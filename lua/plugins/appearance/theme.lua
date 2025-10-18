return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				background = {
					light = "mocha",
					dark = "mocha",
				},
				float = {
					transparent = false,
					solid = true,
				},
				auto_integrations = true,
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
