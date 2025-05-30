return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "dockerfile" })
			vim.filetype.add({
				filename = {
					["docker-compose.yaml"] = "yaml.docker-compose",
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(
				opts.ensure_installed,
				{ "docker-compose-language-service", "dockerfile-language-server", "hadolint" }
			)
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				["yaml.docker-compose"] = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				["dockerfile"] = { "hadolint" },
			},
		},
	},
}
