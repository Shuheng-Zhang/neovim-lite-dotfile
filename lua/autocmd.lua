-- Highlighting yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("nvim-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Wrap mode auto switching
vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Auto disable wrapText in INSERT mode",
  callback = function()
  vim.opt.wrap = false
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  desc = "Auto enable wrapText in INSERT mode",
  callback = function()
  vim.opt.wrap = true
  end,
})
