return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "json", "jsonc" })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "jsonls" })
		end,
	},
	{
		"b0o/schemastore.nvim",
		config = function()
			vim.lsp.config("jsonls", {
				on_new_config = function(config)
					if not config.settings.json.schemas then
						config.settings.json.schemas = {}
					end
					vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
				end,
				settings = { json = { validate = { enable = true } } },
			})
		end,
		-- spec = {
		-- 	{
		-- 		"neovim/nvim-lspconfig",
		-- 		opts = {
		-- 			servers = {
		-- 				jsonls = {
		-- 					on_new_config = function(config)
		-- 						if not config.settings.json.schemas then
		-- 							config.settings.json.schemas = {}
		-- 						end
		-- 						vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
		-- 					end,
		-- 					settings = { json = { validate = { enable = true } } },
		-- 				},
		-- 			},
		-- 		},
		-- 	},
		-- },
		-- config = function()
		-- 	require("lspconfig").jsonls.setup({
		-- 		settings = {
		-- 			json = {
		-- 				schemas = require("schemastore").json.schemas(),
		-- 				validate = { enable = true },
		-- 			},
		-- 		},
		-- 	})
		-- end,
	},
}
