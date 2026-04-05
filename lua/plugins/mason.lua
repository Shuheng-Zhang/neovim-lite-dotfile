--- LSP Manager(Install, Remove, Update LSP) ---

vim.schedule(function()
  require('utils').pkg_load('mason', {
    ui = {
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = "",
      },
      border = "rounded",
      backdrop = 80,
    },
  })

  require('utils').pkg_load('mason-tool-installer', {
    start_delay = 3000,
    ensure_installed = {
      -- Lua
      "lua-language-server",
      "stylua",
      -- markdown
      "marksman",
    }
  })

  vim.keymap.set('n', '<leader>pm', '<CMD>Mason<CR>', { desc = 'LSP(s) Manage' })
end)
