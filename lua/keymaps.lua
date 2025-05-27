--
-- Global keymappings
--

-- set <leader> key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local function buffer_close(bufnr, force)
	if not bufnr or bufnr == 0 then
		bufnr = vim.api.nvim_get_current_buf()
	end
	local buftype = vim.bo[bufnr].buftype
	vim.cmd(("silent! %s %d"):format((force or buftype == "terminal") and "bdelete!" or "confirm bdelete", bufnr))
end

local function buffer_close_all(keep_current, force)
	if keep_current == nil then
		keep_current = false
	end
	local current = vim.api.nvim_get_current_buf()
	for _, bufnr in ipairs(vim.t.bufs) do
		if not keep_current or bufnr ~= current then
			buffer_close(bufnr, force)
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
	buffer_close_all(true)
end, { desc = "Close all buffers except current" })
keymap.set("n", "<leader>bC", function()
	buffer_close_all()
end, { desc = "Close all buffers" })
keymap.set("n", "<leader>bx", "<cmd>bdelete<cr>", { desc = "Close current buffer" })

-- window(buffer) split
keymap.set("n", "<leader>b\\", "<cmd>vsplit<cr>", { desc = "Vertical split" })
keymap.set("n", "<leader>b|", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Quit window
keymap.set("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit window" })
keymap.set("n", "<leader>Q", "<cmd>confirm qall<cr>", { desc = "Quit all windows" })

keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
keymap.set("n", "<leader>n", "<cmd>enew<cr>", { desc = "New file" })

-- LSP keymaps
keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end, { desc = "Goto definition" })
keymap.set("n", "gD", function()
	vim.lsp.buf.declaration()
end, { desc = "Goto Declaration" })
keymap.set("n", "gl", function()
	vim.diagnostic.open_float()
end, { desc = "Show inline diagnostic" })
keymap.set("n", "gi", function()
	vim.lsp.buf.implementation()
end, { desc = "Goto implementation" })

-- create a autocmd for highlighting yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("nvim-lite-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
