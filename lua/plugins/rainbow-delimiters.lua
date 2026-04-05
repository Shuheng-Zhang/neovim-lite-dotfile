vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group    = require('utils').pkg_load_group,
  once     = true,
  callback = function()
    require('utils').pkg_load('rainbow-delimiters', function()
      require('rainbow-delimiters.setup').setup({})
    end)
  end
})
