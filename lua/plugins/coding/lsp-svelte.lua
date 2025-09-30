return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "svelte" })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed =
				require("utils").list_insert_unique(opts.ensure_installed, { "svelte-language-server" })
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				svelte = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
}
