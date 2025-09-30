local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
local cmp_capabilities = require("blink.cmp").get_lsp_capabilities()

IS_CONFLICTING_CAPABILITIES_DISABLE_INVOKED = false
local function disable_conflicting_capabilities()
	local lsp_clients = vim.lsp.get_clients()
	for _, lsp_client in ipairs(lsp_clients) do
		if lsp_client.name == "angularls" then
			lsp_client.server_capabilities.foldingRangeProvider = false
			IS_CONFLICTING_CAPABILITIES_DISABLE_INVOKED = true
			vim.notify("disable_conflicting_capabilities invoked")
			break
		end
	end
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-----------------------------------------------------
			--- config lsp servers                            ---
			-----------------------------------------------------
			vim.lsp.config("jdtls", require("lsp.jdtls"))

			vim.lsp.config("cssls", {
				init_options = {
					{ provideFormatter = true },
				},
			})

			vim.lsp.config("html", {
				init_options = {
					provideFormatter = false,
					embeddedLanguages = { css = true, javascript = true },
					configurationSection = { "html", "css", "javascript" },
				},
			})

			vim.lsp.config("vtsls", {
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								{
									name = "@vue/typescript-plugin",
									location = vim.fn.stdpath("data")
										.. "/mason/packages/vue-language-server"
										.. "/node_modules/@vue/language-server",
									languages = { "vue" },
									configNamespace = "typescript",
									enableForWorkspaceTypeScriptVersions = true,
								},
							},
						},
					},
				},
			})
			vim.lsp.config("vue_ls", {
				capabilities = {
					textDocument = {
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
				},
			})
			vim.lsp.config("angularls", {
				root_markers = { "angular.json", "nx.json" },
				root_dir = vim.fs.dirname(vim.fs.find({ "angular.json" }, { upward = true })[1]),
			})

			-- set capabilities for all lsp servers
			vim.lsp.config("*", {
				capabilities = vim.tbl_deep_extend("force", capabilities, cmp_capabilities or {}),
				on_attach = function(client, bufnr)
					if not IS_CONFLICTING_CAPABILITIES_DISABLE_INVOKED then
						disable_conflicting_capabilities()
					end
				end,
			})

			-----------------------------------------------------
			--- enable lsp servers                            ---
			-----------------------------------------------------
			vim.lsp.enable({
				"lua_ls",
				"vtsls",
				"jsonls",
				"marksman",
				"sqls",
				"taplo",
				"lemminx",
				"jdtls",
				"cssls",
				"html",
				"yamlls",
				"dockerls",
				"emmet_ls",
				"vue_ls",
				"angularls",
			})
		end,
	},
}
