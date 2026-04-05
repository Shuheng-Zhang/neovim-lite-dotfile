--- Plugin for buffer tabs ---
--- 
require('utils').pkg_load('nvim-web-devicons', {})

require('utils').pkg_load('bufferline', {
  options = {
    mode = "buffers",
    separator_style = { "", "" },
    show_tab_indicators = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    indicator = {
      style = "underline",
    },
  }
})
