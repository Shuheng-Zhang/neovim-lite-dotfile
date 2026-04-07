return {
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          normal_hl = "FidgetText", -- 使用自定义高亮组
          winblend = 0,         -- 不透明
          border = "none",      -- 去掉边框
        },
      },
      progress = {
        display = {
          render_limit = 5,
        },
      },
    }
  }
}