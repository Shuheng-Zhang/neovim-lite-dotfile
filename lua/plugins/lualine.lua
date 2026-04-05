--- plugin for better statusbar ---

local LuaLineModules = {}

LuaLineModules.mode = {
  "mode",
  fmt = function(str)
    return " " .. str
  end,
}

LuaLineModules.filename = {
  "filename",
  symbols = { added = " ", modified = "󰛿 ", removed = " " }, -- changes diff symbols
  fmt = function(str)
    local ft_icon = require("nvim-web-devicons").get_icon(
      vim.fn.expand("%:t"),
      vim.fn.expand("%:e"),
      { default = true }
    )
    return ft_icon .. " " .. str
  end,
}

LuaLineModules.progress = {
  "progress",
  fmt = function(str)
    return " " .. str
  end,
}

LuaLineModules.diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = true,
  update_in_insert = false,
  always_visible = false,
}

LuaLineModules.diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = "󰛿 ", removed = " " }, -- changes diff symbols
}

LuaLineModules.navic = function()
  local nc = require("nvim-navic")
  local function get_filename()
    local fname = vim.fn.expand("%:t")
    if not fname or fname == "" then
      return ""
    end
    return fname
  end
  if nc.is_available() then
    local cur_filename = get_filename()
    -- hide plugin bar when no file loaded
    if cur_filename == "" then
      return ""
    end
    local location = nc.get_location()
    if location ~= "" then
      return " " .. cur_filename .. " > " .. location
    else
      return " " .. cur_filename
    end
  else
    -- hide plugin bar when plugin is not available
    return ""
  end
end

LuaLineModules.lsp_servers = function()
  local servers = vim.lsp.get_clients()
  if #servers == 0 then
    return "NO_LSP"
  end
  local serv_str = ""
  for idx, serv in pairs(servers) do
    serv_str = serv_str .. serv.name
    if idx < #servers then
      serv_str = serv_str .. ", "
    end
  end
  return "  " .. serv_str
end

require('utils').pkg_load('nvim-web-devicons', {})

require('utils').pkg_load('nvim-navic', {
  highlight = true,
  lsp = {
    auto_attach = true,
    preference = {
      "jdtls",
      "marksman",
    },
  },
})

require('utils').pkg_load('lualine', {
  options = {
    theme = "catppuccin-mocha",
    component_separators = { left = " ", right = "|" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
    disabled_filetypes = {
      statusline = {},
      winbar = {
        "neo-tree",
        "term",
        "toggleterm",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
        "dap-repl",
        "dapui_console",
        "snacks_picker_list"
      },
    },
  },
  sections = {
    lualine_a = { LuaLineModules.mode },
    lualine_b = { "branch" },
    lualine_c = { LuaLineModules.filename, LuaLineModules.diff, LuaLineModules.diagnostics },
    lualine_x = { { LuaLineModules.lsp_servers }, "encoding", "fileformat" },
    lualine_y = { "location" },
    lualine_z = { LuaLineModules.progress },
  },
  winbar = {
    lualine_c = {
      { LuaLineModules.navic },
      color_correction = nil,
      navic_opts = nil,
    },
  },
})

-- disable mode notification
vim.opt.showmode = false
