vim.api.nvim_create_autocmd('FileType', {
  group = require('utils').pkg_load_group,
  once = true,
  pattern = "markdown",
  callback = function()
    require('utils').pkg_load('markview', {})
  end
})
