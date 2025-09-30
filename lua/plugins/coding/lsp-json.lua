return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed =
				require("utils").list_insert_unique(opts.ensure_installed, { "json", "json5", "jsonc" })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, {
				"json-lsp",
				"prettierd",
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				json = { "prettierd", "prettier" },
			},
		},
	},
}
