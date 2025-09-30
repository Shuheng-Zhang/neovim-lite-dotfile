return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed =
				require("utils").list_insert_unique(opts.ensure_installed, { "marksman", "prettierd" })
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				markdown = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
}
