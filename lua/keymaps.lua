--
-- Global keymappings
--

-- set <leader> key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local keymap = vim.keymap

-- move around split buffer window
keymap.set("n", "<C-j>", "<C-w><C-j>")
keymap.set("n", "<C-h>", "<C-w><C-h>")
keymap.set("n", "<C-k>", "<C-w><C-k>")
keymap.set("n", "<C-l>", "<C-w><C-l>")

-- LSP keymaps
keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end, { desc = "Goto definition" })
keymap.set("n", "gD", function()
	vim.lsp.buf.declaration()
end, { desc = "Goto Declaration" })
keymap.set("n", "gl", function()
	vim.lsp.buf.diagnostic.open_float()
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
