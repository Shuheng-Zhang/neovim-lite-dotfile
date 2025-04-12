return {
  "ibhagwan/fzf-lua",
  dependencies = {
    -- Icon supported
    "nvim-tree/nvim-web-devicons",
    { -- Find working directory
      "ahmedkhalf/project.nvim",
      init = function()
        require("project_nvim").setup({
          patterns = { ".git", ".svn", "Makefile", "package.json", "pom.xml", "build.gradle", "cargo.toml" },
        })
      end
    }
  },
  opts = {},
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Find Recently Files" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep current project" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Find keympas" },
    { "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "Find helps" },
    { "<leader>fc", "<cmd>FzfLua commands<cr>", desc = "Find neovim commands" },
    { "<leader>fC", "<cmd>FzfLua autocmds<cr>", desc = "Find autocmds" },
  }
}
