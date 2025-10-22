--
-- Global keymappings
--

-- set <leader> key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local function close_buffer(close_all)
	local all_buffers = vim.api.nvim_list_bufs()
	local current_buffer = vim.api.nvim_get_current_buf()
	local modified_buffers = {}

	-- Find unsaved changes buffers
	for _, buf in ipairs(all_buffers) do
		if vim.api.nvim_get_option_value("modified", { buf = buf }) then
			table.insert(modified_buffers, buf)
		end
	end

	-- Check if unsaved changes buffers
	if #modified_buffers > 0 then
		vim.notify("There are " .. #modified_buffers .. " buffers with unsaved changes", vim.log.levels.WARN)
		return
	end

	if close_all then
		for _, buf in ipairs(all_buffers) do
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	else
		for _, buf in ipairs(all_buffers) do
			if buf ~= current_buffer and vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = false })
			end
		end
	end
end

local keymap = vim.keymap

-- move around split buffer window
keymap.set("n", "<C-j>", "<C-w><C-j>")
keymap.set("n", "<C-h>", "<C-w><C-h>")
keymap.set("n", "<C-k>", "<C-w><C-k>")
keymap.set("n", "<C-l>", "<C-w><C-l>")

-- Close buffers
keymap.set("n", "<leader>bc", function()
	close_buffer(false)
end, { desc = "Close all buffers except current" })
keymap.set("n", "<leader>bC", function()
	close_buffer(true)
end, { desc = "Close all buffers" })
keymap.set("n", "<leader>bx", "<cmd>bdelete<cr>", { desc = "Close current buffer" })

-- window(buffer) split
keymap.set("n", "<leader>b\\", "<cmd>vsplit<cr>", { desc = "Vertical split" })
keymap.set("n", "<leader>b|", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Quit window
keymap.set("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Close window" })
keymap.set("n", "<leader>Q", "<cmd>confirm qall<cr>", { desc = "Close all windows" })

keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
keymap.set("n", "<leader>n", "<cmd>enew<cr>", { desc = "New file" })

-- add keymaps for resize split window on Linux or Windows
local os = require("utils").os_info()
if os == "Linux" or os == "Windows" then
	keymap.set("n", "<A-h>", "<cmd>vertical resize -2<cr>", { silent = true })
	keymap.set("n", "<A-l>", "<cmd>vertical resize +2<cr>", { silent = true })
	keymap.set("n", "<A-j>", "<cmd>resize +2<cr>", { silent = true })
	keymap.set("n", "<A-k>", "<cmd>resize -2<cr>", { silent = true })
end

-- add keymaps for moving contents blocks that selected with pressing TAB
keymap.set("v", "<TAB>", ">gv", { noremap = true, silent = true })
keymap.set("v", "<S-TAB>", "<gv", { noremap = true, silent = true })

-- cancel search
keymap.set("n", "<ESC>", function()
	if vim.v.hlsearch == 1 then
		local sc = vim.fn.searchcount({ maxcount = 0 }) or {}
		if (sc.total or 0) > 0 then
			vim.cmd("nohlsearch")
			vim.fn.setreg("/", "")
			return
		end
	end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end, { noremap = true, silent = true })

-- create a autocmd for highlighting yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("nvim-yank-highligiting", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- create a command for cleaning registers
vim.api.nvim_create_user_command("ClearRegisters", function()
	local registers = { '"', "@" }

	-- registers for copy or delete history
	for i = 0, 9 do
		table.insert(registers, tostring(i))
	end
	-- registers for custom macro or text
	for reg = string.byte("a"), string.byte("z") do
		table.insert(registers, string.char(reg))
	end

	-- clear all registers
	for _, reg in ipairs(registers) do
		vim.fn.setreg(reg, "")
	end

	vim.notify("All registers cleared", vim.log.levels.INFO)
end, { desc = "Clear registers" })
