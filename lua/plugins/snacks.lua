--- collections extension features for neovim ---

require('utils').pkg_load('snacks', {
  animate = { enabled = true },
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = {
    enabled = false,
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
})

local keymap = vim.keymap

keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = 'File Explorer' })
keymap.set('n', '<leader>o', function() Snacks.explorer.reveal() end, { desc = 'File Explorer(fcous)' })

keymap.set('n', '<leader>bc', function() Snacks.bufdelete.other() end, { desc = 'Close all buffer(s) except current' })
keymap.set('n', '<leader>bC', function() Snacks.bufdelete.all() end, { desc = 'Close all buffer(s)' })
keymap.set('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'File buffer(s)' })

keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find file(s)' })
keymap.set('n', '<leader>fF', function() Snacks.picker.grep() end, { desc = 'Find file(s) with grep' })
keymap.set('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = 'Rencent files' })

keymap.set('n', '<leader>tg', function() Snacks.lazygit() end, { desc = 'Toggle Lazygit' })
keymap.set('n', '<leader>tt', function() Snacks.terminal() end, { desc = 'Toggle Terminal' })
keymap.set('n', '<leader>xt', function() Snacks.picker.todo_comments() end, { desc = 'Find TODO(s)' })
