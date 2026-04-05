--- TreeSitter ---
require('utils').pkg_load('nvim-treesitter', function()
  local ensure_installed = {
    "bash",
    "c",
    "diff",
    "html",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "query",
    "vim",
    "vimdoc",
  }
  local nt = require('nvim-treesitter')
  nt.setup({})
  nt.install(ensure_installed)
end)

-- Auto update parsers after plugin updated
vim.api.nvim_create_autocmd('PackChanged', {
  group = require('utils').pkg_load_group,
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      vim.cmd('TSUpdate')
    end
  end
})
