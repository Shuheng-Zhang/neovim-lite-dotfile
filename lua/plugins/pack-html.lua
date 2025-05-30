return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "html", "css", "scss", "styled" })
			vim.treesitter.language.register("scss", "less")
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(
				opts.ensure_installed,
				{ "html", "emmet_ls", "css-lsp", "prettierd" }
			)
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				less = { "prettierd", "prettier", stop_after_first = true },
				postcss = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
}
