return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    statuscolumn = {
      enabled = false,
      left = { "fold", "mark", "sign" }, -- priority of signs on the left (high to low)
      right = { "git" },                 -- priority of signs on the right (high to low)
      folds = {
        open = true,
        git_hl = false,
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    -- {
    --   "<leader>bc",
    --   function() Snacks.bufdelete.other() end,
    --   desc = "Close all buffer(s) except current"
    -- },
    -- {
    --   "<leader>bC",
    --   function() Snacks.bufdelete.all() end,
    --   desc = "Close all buffer(s)"
    -- },
    {
      "<leader>e",
      function() Snacks.explorer() end,
      desc = "File Explorer"
    },
    {
      "<leader>o",
      function() Snacks.explorer.reveal() end,
      desc = "File Explorer(fcous)"
    },
    {
      "<leader>fb",
      function() Snacks.picker.buffers() end,
      desc = "Find buffer(s)"
    },
    {
      "<leader>ff",
      function() Snacks.picker.files() end,
      desc = "Find file(s)"
    },
    {
      "<leader>fF",
      function() Snacks.picker.grep() end,
      desc = "Find file(s) with grep"
    },
    {
      "<leader>fr",
      function() Snacks.picker.recent() end,
      desc = "Find rencent"
    },
    {
      "<leader>tg",
      function() Snacks.lazygit() end,
      desc = "Toggle Lazygit"
    },
    {
      "<leader>tt",
      function() Snacks.terminal() end,
      desc = "Toggle Terminal"
    },
    {
      "<leader>lo",
      "<cmd>Outline<cr>",
      desc = "Symbols Outline"
    },
    {
      "<leader>xt",
      function() Snacks.picker.todo_comments() end,
      desc = "TODO(s)"
    }
  }
}
