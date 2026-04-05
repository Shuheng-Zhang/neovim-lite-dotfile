vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  group = require('utils').pkg_load_group,
  callback = function()
    require('utils').pkg_load('conform', {
      format_on_save = {
        timeout = 10000,
        lsp_format = "fallback"
      }
    })
  end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = require('utils').pkg_load_group,
  pattern = "*",
  callback = function(args)
    require('conform').format({ bufnr = args.buf })
  end
})
