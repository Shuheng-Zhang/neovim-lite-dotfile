return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "rust" })
		end,
	},
	-- {
	-- 	"jay-babu/mason-nvim-dap.nvim",
	-- 	opts = function(_, opts)
	-- 		opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "codelldb" })
	-- 	end,
	-- },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed =
				require("utils").list_insert_unique(opts.ensure_installed, { "codelldb", "rust-analyzer", "taplo" })
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			popup = {
				border = "rounded",
			},
		},
		config = function(_, opts)
			require("crates").setup(opts)
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
}
