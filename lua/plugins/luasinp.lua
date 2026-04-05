vim.api.nvim_create_autocmd('InsertEnter', {
  group = require('utils').pkg_load_group,
  once = true,
  callback = function()
    require('utils').pkg_load('friendly-snippets')
    require('utils').pkg_load('LuaSnip', function()
      -- load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      -- load custom snippets
      require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
    end)
  end
})
