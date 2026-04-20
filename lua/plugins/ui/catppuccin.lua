return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			-- Configure catppuccin theme
			require("catppuccin").setup({
				flavour = "mocha",
				term_colors = true,
				transparent_background = true,
				background = {
					light = "mocha",
					dark = "mocha",
				},
				float = {
					transparent = true,
					solid = false,
				},
				auto_integrations = true,
			})

			-- Enable theme
			vim.cmd([[colorscheme catppuccin]])

			vim.api.nvim_set_hl(0, "NormalFloat", {
				bg = "NONE",
			})
			vim.api.nvim_set_hl(0, "FloatBorder", {
				fg = "#7aa2f7", -- TokyoNight 蓝（比 catppuccin 更柔和）
				bg = "NONE",
			})

			vim.api.nvim_set_hl(0, "FloatTitle", {
				fg = "#f5c2e7",
				bg = "NONE",
				bold = true,
			})
			vim.api.nvim_set_hl(0, "NormalNC", {
				bg = "NONE",
			})

			vim.api.nvim_set_hl(0, "FloatBorder", {
				fg = "#89b4fa",
				bg = "NONE",
			})
			vim.api.nvim_set_hl(0, "WinSeparator", {
				fg = "#6c7086", -- 更暗一点
			})
		end,
	},
}
