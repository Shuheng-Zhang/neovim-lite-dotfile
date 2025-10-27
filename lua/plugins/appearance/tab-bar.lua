return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"catppuccin/nvim",
		},
		config = function()
			local mocha = require("catppuccin.palettes").get_palette("mocha")

			require("bufferline").setup({
				options = {
					mode = "buffers",
					offsets = {
						{ filetype = "neo-tree", text_align = "center", separator = false },
					},
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
					indicator = {
						style = "underline",
					},
					separator_style = { "", "" }, -- important
				},
			})
		end,
	},
}
