return {
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
}
