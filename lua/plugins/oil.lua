return {
  -- Vim-like file explorer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    opts = {
      default_file_explorer = true,
    },
    keys = {
      { "<leader>E", "<cmd>Oil --float<cr>", desc = "File Explorer(Vim mode)" },
    },
  },
}
