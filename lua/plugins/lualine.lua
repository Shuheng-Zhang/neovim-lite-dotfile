return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    { -- edit element nav bar
      "SmiteshP/nvim-navic",
      config = function()
        require("nvim-navic").setup({
          highlight = true,
          lsp = {
            auto_attach = true,
            preference = {
              "jdtls",
              "marksman",
            },
          },
        })
      end,
    },
  },
  config = function()
    local modules = require("plugin_config.lualine_conf")
    require("lualine").setup({
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
        lualine_a = { modules.mode },
        lualine_b = { "branch" },
        lualine_c = { modules.filename, modules.diff, modules.diagnostics },
        lualine_x = { { modules.lsp_servers }, "encoding", "fileformat" },
        lualine_y = { "location" },
        lualine_z = { modules.progress },
      },
      winbar = {
        lualine_c = {
          { modules.navic },
          color_correction = nil,
          navic_opts = nil,
        },
      },
    })

    -- disable mode notification
    vim.opt.showmode = false
  end
}
