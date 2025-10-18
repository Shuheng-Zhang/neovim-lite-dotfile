-----------------------------------
--- Folding Configuration       ---
-----------------------------------

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = "expr"

-- Use treesitter as default folding impl
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-----------------------------------
--- Folding status manage       ---
-----------------------------------

-- Create view store dir
local view_dir = vim.fn.stdpath("state") .. "/view"
if vim.fn.isdirectory(view_dir) == 0 then
	vim.fn.mkdir(view_dir, "p")
end

-- Config view options
vim.opt.viewoptions:remove("options")
vim.opt.viewoptions:remove("folds")
vim.opt.viewoptions:append("folds")

-- Config view store directory
vim.opt.viewdir = view_dir

local view_agroup = vim.api.nvim_create_augroup("presistent-views", { clear = true })

-- auto cmd for saving folding state when window closed
vim.api.nvim_create_autocmd("BufWinLeave", {
	group = view_agroup,
	pattern = "*",
	callback = function()
		-- ignore buffer buffers  of these types
		local buftype = vim.bo.buftype
		if buftype == "terminal" or buftype == "prompt" or buftype == "nofile" then
			return
		end

		-- save views
		vim.cmd("silent! mkview")
	end,
})

-- auto cmd for restore folding state when window opened
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = view_agroup,
	pattern = "*",
	callback = function()
		-- ignore buffer buffers  of these types
		local buftype = vim.bo.buftype
		if buftype == "terminal" or buftype == "prompt" or buftype == "nofile" then
			return
		end

		-- load views
		vim.cmd("silent! loadview")

		-- reload fold state if modified outside
		if vim.fn.foldlevel(".") == 0 and vim.fn.foldclosed(".") == -1 then
			vim.cmd("normal! zx")
		end
	end,
})

-- command for refreshing fold
vim.api.nvim_create_user_command("RefreshFold", function()
	vim.cmd("silent! loadview")
	vim.cmd("normal! zx")
	vim.notify("Fold states refreshed", vim.log.levels.INFO)
end, {})

--- Custom folding line style
---
--- @param virtText table content block object
--- @param lnum number start of folding line
--- @param endLnum number end of folding line
--- @param width number max usable display width
--- @param truncate function content text truncate function
local function custom_style_foldtext(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = string.rep(" ", 4) .. ("󰁂 %d lines(%d ~> %d)"):format(endLnum - lnum + 1, lnum, endLnum + 1)

	local sufWidth = vim.fn.strdisplaywidth(suffix)

	-- main continer with
	local continerWidth = width - sufWidth

	-- used with counter
	local curWidth = 0

	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if continerWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, continerWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)

			if curWidth + chunkWidth < continerWidth then
				suffix = suffix .. (" "):rep(continerWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end

	-- local suffix_arrow = ""
	-- table.insert(newVirtText, { suffix_arrow, "@comment.todo" })
	-- curWidth = curWidth + vim.fn.strdisplaywidth(suffix_arrow)

	-- local padding = ""
	-- if curWidth < continerWidth then
	-- 	padding = (" "):rep(continerWidth - curWidth - 2)
	-- end

	-- local resultSuffix = padding .. suffix

	table.insert(newVirtText, { suffix, "@character.special" })

	return newVirtText
end

return {
	-- folding
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							-- fold indicator
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							-- line number indicator
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
							-- git status indicator
							{ text = { "%s" }, click = "v:lua.ScSa" },
						},
					})
				end,
			},
		},
		event = "BufReadPost",
		opts = {
			fold_virt_text_handler = custom_style_foldtext,
		},
		init = function()
			-- autocmd for disabling folding on filetypes
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "neo-tree", "Outline" },
				callback = function()
					require("ufo").detach()
					vim.opt_local.foldenable = false
				end,
			})

			vim.keymap.set("n", "zR", function()
				require("ufo").openAllFolds()
			end)
			vim.keymap.set("n", "zM", function()
				require("ufo").closeAllFolds()
			end)
			vim.keymap.set("n", "zP", function()
				require("ufo.preview"):peekFoldedLinesUnderCursor()
			end, { desc = "Preview folded lines" })
		end,
	},
}
