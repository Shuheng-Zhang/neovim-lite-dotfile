return {
	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
		config = false,
	},
	{
		"JavaHello/spring-boot.nvim",
		dependencies = {
			"mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig
		},
		lazy = true,
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(
				opts.ensure_installed,
				{ "jdtls", "java-debug-adapter", "java-test", "vscode-spring-boot-tools" }
			)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "java" })
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				java = {},
			},
			format_on_save = {
				timeout_ms = 5000,
				lsp_fallback = true,
			},
		},
	},
}
