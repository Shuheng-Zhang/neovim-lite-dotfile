return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "dockerfile" })
			vim.filetype.add({
				filename = {
					["docker-compose.yaml"] = "yaml.docker-compose",
					["docker-compose.yml"] = "yaml.docker-compose",
					["Dockerfile"] = "dockerfile",
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, {
				"docker-compose-language-service",
				"dockerfile-language-server",
				-- "hadolint",
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				["yaml.docker-compose"] = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
	},
}
