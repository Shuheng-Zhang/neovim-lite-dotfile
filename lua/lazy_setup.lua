-- Install lazy.nvim
vim.pack.add({
  { src = "https://github.com/folke/lazy.nvim", name = "lazy" }
})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins.ui" },        -- plugins for UI, theme, status line, buffer tab, etc.
    { import = "plugins.editor" },    -- plugins for editor, quick jump, git support, folding, markdown rendering etc.
    { import = "plugins.coding" },    -- plugins for coding, auto-cmp, formatting, sinpets etc.
    { import = "plugins.lsp" },       -- plugins for lsp support, LSP manager and better LSP pre-config
    { import = "plugins.dap" },       -- plugins for DAP support, DAP adapter
    { import = "plugins.misc" },      -- plugins for extends other functionality
    { import = "plugins.lang-specs" } -- plugins for specified language supoort, java, rust, JS/TS etc.
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
