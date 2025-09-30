return {
	{
		"noearc/jieba.nvim",
		ft = { "text", "markdown" },
		cmd = { "JiebaSegment", "JiebaSearch" },
		dependencies = { "noearc/jieba-lua" },
		opts = {},
	},
	{
		"keaising/im-select.nvim",
		lazy = false,
		enabled = vim.loop.os_uname().sysname == "Darwin",
		opts = {
			default_im_select = "com.apple.keylayout.ABC",
			default_command = "im-select",
		},
	},
}
