vim.api.nvim_create_autocmd('FileType', {
  group = require('utils').pkg_load_group,
  once = true,
  pattern = "lua",
  callback = function()
    require('utils').pkg_load('lazydev', {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    })
  end
})
