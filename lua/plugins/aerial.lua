require('utils').pkg_load('aerial', {})

vim.keymap.set("n", "<leader>lo", "<cmd>AerialToggle!<CR>", { desc = "Toggle Outline" })
