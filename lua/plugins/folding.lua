local folding_conf = require("plugin_config.folding_conf")

return {
  -- folding
  {
    "kevinhwang91/nvim-ufo",
    enabled = true,
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              -- fold indicator
              { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
              -- line number indicator
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
              -- git status indicator
              { text = { "%s" },                  click = "v:lua.ScSa" },
            },
          })
        end,
      },
    },
    event = "BufReadPost",
    opts = {
      fold_virt_text_handler = folding_conf.custom_style_foldtext,
    },
    init = function()
      -- autocmd for disabling folding on filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "neo-tree", "Outline" },
        callback = function()
          require("ufo").detach()
          vim.opt_local.foldenable = false
        end,
      })

      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
      vim.keymap.set("n", "zP", function()
        require("ufo.preview"):peekFoldedLinesUnderCursor()
      end, { desc = "Preview folded lines" })
    end,
  },
}
