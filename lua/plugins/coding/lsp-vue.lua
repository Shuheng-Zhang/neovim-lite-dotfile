return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if opts.ensure_installed ~= "all" then
				opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "vue" })
			end
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(
				opts.ensure_installed,
				{ "vue-language-server", "js-debug-adapter", "prettierd" }
			)
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				vue = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
}
