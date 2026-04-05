vim.api.nvim_create_autocmd('BufReadPost', {
  group = require('utils').pkg_load_group,
  once = true,
  callback = function()
    require('utils').pkg_load('plenary')
    require('utils').pkg_load('todo-comments', {})
  end
})
