local M = {}


M.mode = {
  "mode",
  fmt = function(str)
    return " " .. str
  end,
}

M.filename = {
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

M.progress = {
  "progress",
  fmt = function(str)
    return " " .. str
  end,
}

M.diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = true,
  update_in_insert = false,
  always_visible = false,
}

M.diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = "󰛿 ", removed = " " }, -- changes diff symbols
}

M.navic = function()
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

M.lsp_servers = function()
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

return M


