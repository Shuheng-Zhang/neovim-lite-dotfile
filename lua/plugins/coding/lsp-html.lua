return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if opts.ensure_installed ~= "all" then
				opts.ensure_installed =
					require("utils").list_insert_unique(opts.ensure_installed, { "css", "html", "scss" })
			end
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed =
				require("utils").list_insert_unique(opts.ensure_installed, { "html-lsp", "css-lsp", "prettierd" })
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	{
		"uga-rosa/ccc.nvim",
		ft = { "css", "scss", "html", "javascript", "typescript", "vue" }, -- 进入这些文件类型时加载
		cmd = { "CccPick", "CccConvert", "CccHighlighterEnable" }, -- 命令调用也触发加载
		opts = {
			highlighter = {
				auto_enable = true,
				lsp = true,
			},
		},
	},
}
