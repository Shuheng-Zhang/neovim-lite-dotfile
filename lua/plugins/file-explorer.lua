return {
	-- file explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				version = "2.*",
				config = function()
					require("window-picker").setup({
						filter_rules = {
							include_current_win = false,
							autoselect_one = true,
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = { "neo-tree", "neo-tree-popup", "notify" },
								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal", "quickfix" },
							},
						},
					})
				end,
			},
		},
		lazy = false, -- neo-tree will lazily load itself
		config = function()
			require("neo-tree").setup({
				window = { width = 30 },
			})

			vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
			vim.keymap.set(
				"n",
				"<leader>e",
				":Neotree toggle<CR>",
				{ noremap = true, silent = true, desc = "File Explorer" }
			) -- focus file explorer
		end,
	},
	-- Vim-like file explorer
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		opts = {
			default_file_explorer = true,
		},
		keys = {
			{ "<leader>o", "<cmd>Oil --float --preview<cr>", desc = "File Explorer(CWD, OIL)" },
		},
		lazy = false,
	},
}
