return {
	"Shuheng-Zhang/file-encode-selector.nvim",
	opts = {},
	-- load plugin immediately that can use the commands
	-- otherwise trigged when pressed the keys that set
	lazy = true,
	keys = {
		{ "<leader>fe", "<cmd>FileEncodeReload<cr>", desc = "Select encoding to reload file" },
		{ "<leader>fE", "<cmd>FileEncodeSave<cr>", desc = "Select encoding to save file" },
	},
}
