return {
	-- colorscheme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				background = {
					light = "mocha",
					dark = "mocha",
				},
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	-- indent & code block highlighting
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({})
		end,
	},
	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local mode = {
				"mode",
				fmt = function(str)
					return " " .. str
				end,
			}

			local filename = {
				"filename",
				symbols = { added = " ", modified = "󰛿 ", removed = " " }, -- changes diff symbols
				fmt = function(str)
					local ft_icon = require("nvim-web-devicons").get_icon(
						vim.fn.expand("%:t"),
						vim.fn.expand("%:e"),
						{ default = true }
					)
					return ft_icon .. " " .. str
				end,
			}

			local diagnostics = {
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
				colored = true,
				update_in_insert = false,
				always_visible = false,
			}

			local diff = {
				"diff",
				colored = true,
				symbols = { added = " ", modified = "󰛿 ", removed = " " }, -- changes diff symbols
			}

			local lsp_servers = function()
				local servers = vim.lsp.get_clients()
				if #servers == 0 then
					return "NO_LSP"
				end
				local serv_str = ""
				for idx, serv in pairs(servers) do
					serv_str = serv_str .. serv.name
					if idx < #servers then
						serv_str = serv_str .. ","
					end
				end
				return " " .. serv_str
			end

			require("lualine").setup({

				options = {
					theme = "catppuccin-mocha",
					component_separators = { left = " ", right = "|" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = { "neo-tree" },
					},
				},
				sections = {
					lualine_a = { mode },
					lualine_b = { "branch" },
					lualine_c = { filename, diff, diagnostics },
					lualine_x = { { lsp_servers }, "encoding", "fileformat" },
					lualine_y = { "location" },
					lualine_z = { "progress" },
				},
			})
		end,
	},
	-- tabline
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons", opts = {} },
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
			})

			vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
			vim.keymap.set(
				"n",
				"<leader>e",
				":Neotree toggle<CR>",
				{ noremap = true, silent = true, desc = "File Explorer" }
			) -- focus file explorer

			vim.keymap.set("n", "<leader>o", function()
				if vim.bo.filetype == "neo-tree" then
					vim.cmd.wincmd("p")
				else
					vim.cmd.Neotree("focus")
				end
			end, { noremap = true, silent = true, desc = "File Explorer Focus" })
		end,
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		config = function()
			require("oil").setup({})
			vim.keymap.set("n", "<leader>E", "<cmd>Oil<cr>", { desc = "File Explorer(CWD, OIL)" })
		end,
		lazy = false,
	},
}
