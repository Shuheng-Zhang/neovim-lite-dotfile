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

-- Close buffers
keymap.set("n", "<leader>bx", "<cmd>bdelete<cr>", { desc = "Close current buffer" })

-- window(buffer) split
keymap.set("n", "<leader>b\\", "<cmd>vsplit<cr>", { desc = "Vertical split" })
keymap.set("n", "<leader>b|", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Quit window
keymap.set("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit window" })
keymap.set("n", "<leader>Q", "<cmd>confirm qall<cr>", { desc = "Quit all windows" })

-- Save buffer changes
keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
keymap.set("n", "<leader>n", "<cmd>enew<cr>", { desc = "New file" })


