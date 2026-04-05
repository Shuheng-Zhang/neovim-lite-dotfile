--- Catppuccin Theme ---

-- load and enable
require('utils').pkg_load('catppuccin', {
  falavor = 'mocha',
  auto_integrations = true,
  term_colors = true,
  transparent_background = false,
  float = {
    transparent = true,
    solid = true,
  },
})
vim.cmd.colorscheme "catppuccin"
