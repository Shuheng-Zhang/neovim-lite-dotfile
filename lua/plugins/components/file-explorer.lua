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
			-- set up highlight groups for neo-tree
			local function setup_neo_tree_highlight_for_transparency()
				local bg = "NONE" -- 保持透明
				local fg_dim = "#7a7a7a" -- 非激活灰
				local fg_bright = "#ffccff" -- 激活时亮灰

				vim.api.nvim_set_hl(0, "NeoTreeSourceSeparator", { fg = fg_dim, bg = bg })
				vim.api.nvim_set_hl(0, "NeoTreeTabInactive", { fg = fg_dim, bg = bg })
				vim.api.nvim_set_hl(0, "NeoTreeTabActive", { fg = fg_bright, bg = bg, bold = true })
			end

			require("neo-tree").setup({
				popup_border_style = "rounded",
				window = { width = 40 },
				sources = {
					"filesystem",
					"buffers",
					"git_status",
				},
				source_selector = {
					winbar = true,
					highlight_separator = "NeoTreeSourceSeparator",
					highlight_tab = "NeoTreeTabInactive",
					highlight_tab_active = "NeoTreeTabActive",
					truncation_character = "...",
				},
				event_handlers = {
					{
						event = "file_open_requested",
						handler = function()
							vim.cmd("Neotree close")
						end,
					},
				},
			})

			vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
			vim.keymap.set(
				"n",
				"<leader>e",
				":Neotree toggle<CR>",
				{ noremap = true, silent = true, desc = "File Explorer" }
			)
			vim.keymap.set("n", "<leader>E", function()
				if vim.bo.filetype == "neo-tree" then
					vim.cmd.wincmd("p")
				else
					vim.cmd.Neotree("focus")
				end
			end, { noremap = true, silent = true, desc = "File Explorer Focus" })

			-- vim.api.nvim_create_autocmd("ColorScheme", {
			-- 	callback = setup_neo_tree_highlight_for_transparency,
			-- })
			setup_neo_tree_highlight_for_transparency()
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
			{ "<leader>o", "<cmd>Oil --float<cr>", desc = "File Explorer(CWD, OIL)" },
		},
	},
	{
		"antosha417/nvim-lsp-file-operations",
		event = "LspAttach",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Uncomment whichever supported plugin(s) you use
			-- "nvim-tree/nvim-tree.lua",
			"nvim-neo-tree/neo-tree.nvim",
			-- "simonmclean/triptych.nvim"
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
}
