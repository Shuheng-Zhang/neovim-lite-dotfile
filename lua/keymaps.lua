-- set <leader> key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local keymap = vim.keymap

-- move around split buffer window
keymap.set("n", "<C-j>", "<C-w><C-j>")
keymap.set("n", "<C-h>", "<C-w><C-h>")
keymap.set("n", "<C-k>", "<C-w><C-k>")
keymap.set("n", "<C-l>", "<C-w><C-l>")

-- create a autocmd for highlighting yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("nvim-lite-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
