-- -------------------------- 全局自定义用户命令 -------------------------- --
-- 复制时高亮
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("nvim-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- 自动切换折行
local auto_wrap_group = vim.api.nvim_create_augroup('nvim-auto-wrap', { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Auto disable wrapText in INSERT mode",
  group = auto_wrap_group,
  callback = function()
    vim.opt.wrap = false
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  desc = "Auto enable wrapText in INSERT mode",
  group = auto_wrap_group,
  callback = function()
    vim.opt.wrap = true
  end,
})
