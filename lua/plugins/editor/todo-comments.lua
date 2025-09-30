return {
  	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{ "<leader>xt", "<cmd>TodoTelescope<CR>", desc = "Find Todos" },
		},
	},
}
