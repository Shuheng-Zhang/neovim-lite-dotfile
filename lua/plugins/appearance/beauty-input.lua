return {
  	{
		"stevearc/dressing.nvim",
		opts = {
			input = {
				relative = "editor",
				prefer_width = 0.6,
				override = function(conf)
					conf.col = math.floor((vim.o.columns - conf.width) / 2)
					conf.row = math.floor((vim.o.lines - conf.height) / 2)
					return conf
				end,
			},
		},
	}
}
