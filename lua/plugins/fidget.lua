vim.api.nvim_create_autocmd('LspAttach', {
  group = require('utils').pkg_load_group,
  callback = function()
    require('utils').pkg_load('fidget', {
      notification = {
        window = {
          normal_hl = "FidgetText", -- 使用自定义高亮组
          winblend = 0,             -- 不透明
          border = "none",          -- 去掉边框
        },
      },
      progress = {
        display = {
          render_limit = 5,
        },
      },
    })
  end
})
