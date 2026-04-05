vim.api.nvim_create_autocmd('InsertEnter', {
  once = true,
  group = require('utils').pkg_load_group,
  callback = function()
    require('utils').pkg_load('nvim-autopairs', {})
  end
})
