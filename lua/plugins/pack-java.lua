return {
	-- LSP: Java
	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
		config = false,
	},
	-- LSP: Java-Springboot
	{
		"JavaHello/spring-boot.nvim",
		lazy = true,
		config = false,
	},
	{
		"mason-tool-installer",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(
				opts.ensure_installed,
				{ "jdtls", "java-debug-adapter", "java-test", "spring-boot-tools" }
			)
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed =
				require("utils").list_insert_unique(opts.ensure_installed, { "javadbg", "javatest" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "java" })
		end,
	},
}
