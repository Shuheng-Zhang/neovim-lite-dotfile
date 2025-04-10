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
			local progress = {
				"progress",
				fmt = function(str)
					return " " .. str
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
					lualine_z = { progress },
				},
			})
			-- disable mode notification
			vim.opt.showmode = false
		end,
	},
	-- tabline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				mode = "buffer",
				offsets = {
					{ filetype = "neo-tree", text_align = "center", separator = false },
				},
			},
		},
	},
	-- folding
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},
		event = "BufReadPost",
		opts = {
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		},
		init = function()
			-- autocmd for disabling folding on filetypes
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "neo-tree" },
				callback = function()
					require("ufo").detach()
					vim.opt_local.foldenable = false
				end,
			})

			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

			vim.keymap.set("n", "zR", function()
				require("ufo").openAllFolds()
			end)
			vim.keymap.set("n", "zM", function()
				require("ufo").closeAllFolds()
			end)
		end,
	},
}
