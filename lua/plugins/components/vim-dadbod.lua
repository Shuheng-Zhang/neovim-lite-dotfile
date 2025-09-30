-- vim.api.nvim_create_autocmd("BufNewFile", {
-- 	pattern = "dbui://*",
-- 	callback = function(args)
-- 		vim.bo[args.buf].filetype = "sql"
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "sql", "mysql", "plsql" },
-- 	callback = function(args)
-- 		local bufnr = args.buf
-- 		-- 如果没有 LSP attach，则手动启用
-- 		if not vim.lsp.get_clients({ bufnr = bufnr, name = "sqls" })[1] then
-- 			vim.lsp.start({
-- 				name = "sqls",
-- 				cmd = { "sqls" },
-- 				root_dir = vim.fn.getcwd(),
-- 			}, { bufnr = bufnr })
-- 		end
-- 	end,
-- })

return {
	-- dadbod core
	{
		"tpope/vim-dadbod",
		lazy = true,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
		cmd = { "DBUI", "DBUIToggle", "DBUIFindBuffer" },
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
		keys = {
			{ "<leader>ud", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
		},
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		ft = { "sql", "mysql", "plsql" },
	},

	-- blink.cmp (替代 cmp)
	{
		"saghen/blink.cmp",
		dependencies = {
			"kristijanhusak/vim-dadbod-completion",
		},
		opts = {
			sources = {
				providers = {
					dadbod = {
						module = "vim_dadbod_completion.blink",
						name = "Dadbod",
					},
				},
				per_filetype = {
					sql = { "lsp", "dadbod", "buffer", "path" },
					mysql = { "lsp", "dadbod", "buffer" },
					plsql = { "lsp", "dadbod", "buffer" },
				},
			},
		},
	},
}
