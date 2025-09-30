return {
	{
		"Shuheng-Zhang/bk.nvim",
		-- dir = vim.fn.expand("~/workspace/PersonalProjects/bk.nvim"),
		opts = {},
		lazy = true,
		keys = {
			{
				"<leader>pe",
				function()
					vim.ui.input({ prompt = "ePub path" }, function(input)
						if input then
							vim.cmd("BkReader " .. input)
						end
					end)
				end,
				desc = "Open epub Reader",
			},
			{
				"<leader>pE",
				"<cmd>Telescope bk_telescope<CR>",
				desc = "Open epub Reader form recently",
			},
		},
	},
}
