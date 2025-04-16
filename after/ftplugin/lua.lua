local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require("blink.cmp").get_lsp_capabilities()

-- server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
local root_files = {
	".luarc.json",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	".git",
}

vim.api.nvim_create_autocmd("FileType", {
	desc = "LSP: Start lua-language-server",
	pattern = { "lua" },
	callback = function()
		vim.lsp.start({
			cmd = { "lua-language-server" },
			name = "lua_ls",
			capabilities = vim.tbl_deep_extend("force", {}, capabilities, cmp_capabilities or {}),
			root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					hint = {
						enable = true,
					},
				},
			},
		})
	end,
})
