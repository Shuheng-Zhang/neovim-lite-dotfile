--- Fuzzy fast Auto-completions ---

require('utils').pkg_load('blink.cmp', {
  keymap = {
    preset = "enter",
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-s>"] = {
      function(cmp)
        cmp.show({ providers = { "snippets" } })
      end,
    },
  },

  appearance = {
    nerd_font_variant = "mono",
  },

  completion = {
    accept = {
      auto_brackets = { enabled = true },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = {
        border = "rounded",
      },
      treesitter_highlighting = true,
      -- draw = function(opts)
      --   if opts.item and opts.item.documentation and opts.item.documentation.value then
      --     local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
      --     opts.item.documentation.value = out:string()
      --   end
      --
      --   opts.default_implementation(opts)
      -- end,
    },
    menu = {
      draw = {
        columns = {
          { "kind_icon", gap = 1 },
          { "label",     "label_description", gap = 1 },
          { "kind",      gap = 1 },
        },
      },
      border = "rounded",
    },
  },

  signature = {
    window = {
      border = "rounded",
    },
  },

  snippets = { preset = "luasnip" },
  sources = {
    default = { "lsp", "snippets", "path", "buffer" },
    providers = {
      -- add avante supports
      avante = {
        module = "blink-cmp-avante",
        name = "Avante",
        opts = {
          -- options for blink-cmp-avante
        },
      },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
-- vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
--   once = true,
--   callback = function()
--   end
-- })
