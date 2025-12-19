return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			options = {
				mode = "buffers",
				separator_style = { "", "" },
				show_tab_indicators = true,
				show_buffer_close_icons = false,
				show_close_icon = false,
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
			},
		},
	},
}
