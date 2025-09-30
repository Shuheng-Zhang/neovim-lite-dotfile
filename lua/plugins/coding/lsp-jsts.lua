return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(
				opts.ensure_installed,
				{ "javascript", "typescript", "tsx", "jsdoc" }
			)
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, {
				"vtsls",
				"eslint-lsp",
				"prettierd",
				"js-debug-adapter",
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
			},
		},
	},
	{
		"vuki656/package-info.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
		event = "BufRead package.json",
	},
	-- ESlint support
	{
		"esmuellert/nvim-eslint",
		opts = {},
	},
}
