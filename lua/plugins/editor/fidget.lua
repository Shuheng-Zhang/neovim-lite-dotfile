vim.api.nvim_set_hl(0, "FidgetText", { fg = "#aaaaaa", bg = "none" })
vim.api.nvim_set_hl(0, "FidgetTitle", { fg = "#aaaaaa", bg = "none" })
vim.api.nvim_set_hl(0, "FidgetTask", { fg = "#aaaaaa", bg = "none" })

return {
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		config = function()
			require("fidget").setup({
				notification = {
					window = {
						normal_hl = "FidgetText", -- 使用自定义高亮组
						winblend = 0, -- 不透明
						border = "none", -- 去掉边框
					},
				},
				progress = {
					display = {
						render_limit = 5,
					},
				},
			})
		end,
	},
}
