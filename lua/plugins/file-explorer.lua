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
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		lazy = false, -- neo-tree will lazily load itself
		config = function()
			require("neo-tree").setup({
				window = { width = 30 },
				-- sources = {
				--   "filesystem",
				--   "buffers",
				--   "git_status"
				-- },
				-- source_selector = {
				--   winbar = true,
				-- },
			})

			vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
			vim.keymap.set(
				"n",
				"<leader>e",
				":Neotree toggle<CR>",
				{ noremap = true, silent = true, desc = "File Explorer" }
			) -- focus file explorer

			-- vim.keymap.set("n", "<leader>o", function()
			-- 	if vim.bo.filetype == "neo-tree" then
			-- 		vim.cmd.wincmd("p")
			-- 	else
			-- 		vim.cmd.Neotree("focus")
			-- 	end
			-- end, { noremap = true, silent = true, desc = "File Explorer Focus" })
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
			{ "<leader>E", "<cmd>Oil --float<cr>", desc = "File Explorer(CWD, OIL)" },
		},
		lazy = false,
	},
}
