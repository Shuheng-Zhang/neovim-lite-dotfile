local opt = vim.opt
local buffer = vim.b

-- show line relative number
opt.number = true
opt.relativenumber = true

-- use space instead of tab
opt.expandtab = true
-- set 2 space for one tab
opt.shiftwidth = 2
-- set 2 space for one tab
opt.tabstop = 2
-- set 2 space for one tab
opt.softtabstop = 2
-- round indent to multiple of 'shiftwidth'
opt.shiftround = true
-- enable smart tab
opt.smarttab = true
-- copy indent from current line when open a new line
opt.autoindent = true
-- smart indenting when open a new line
opt.smartindent = true

-- highlight current line
opt.cursorline = true
-- disable wrap for long line
opt.wrap = false
-- Show signcolumn by default
opt.signcolumn = "yes"
-- enable terminal true color
opt.termguicolors = true

-- use nerd fonts icons
vim.g.have_nerd_font = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- no highlight matched search result
opt.hlsearch = false
-- auto handle mix case when searching
opt.smartcase = true
-- ignore case when searching
opt.ignorecase = true

-- set update time
opt.updatetime = 200
-- set mapped sequence wait time
opt.timeoutlen = 300
-- disable swap file to speed up large file loading
opt.swapfile = false
-- disable backup
opt.backup = false
-- enable undo after neovim is quited
opt.undofile = true
opt.undodir = vim.fn.expand("$HOME/.local/share/nvim-lite/undo")

-- set new split window open from right-below
opt.splitright = true
opt.splitbelow = true

-- enable system clipboard
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- number of screen lines to keep above and below the cursor
opt.scrolloff = 20

-- enable folding
-- opt.foldenable = true
-- opt.foldlevel = 99
-- opt.foldlevelstart = 99

-- enable command-line support
opt.wildmenu = true

-- auto read file when it have been changed from other side
opt.autoread = true

-- confirm handling when closing unsave file(buffor)
opt.confirm = true

-- set default fileencoding
buffer.fileencoding = "utf-8"

-- initialize buffer list
if not vim.t.bufs then
	vim.t.bufs = vim.api.nvim_list_bufs()
end
