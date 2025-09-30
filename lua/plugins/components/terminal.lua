-- Terminal integration
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	opts = {
		shade_terminals = false,
	},
	keys = {
		{ "<leader>tf", "<Cmd>ToggleTerm direction=float<CR>", desc = "Open terminal float" },
		{ "<leader>th", "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "Open terminal horizontally" },
		{ "<leader>tv", "<Cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "Open terminal vertically" },
		{ "<leader>tt", "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
	},
}
