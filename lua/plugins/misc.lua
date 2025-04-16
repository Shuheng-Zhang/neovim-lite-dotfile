return {
	-- Key bindings helper
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			mappings = vim.g.have_nerd_font,
			keys = vim.g.have_nerd_font and {} or {
				Up = "<Up> ",
				Down = "<Down> ",
				Left = "<Left> ",
				Right = "<Right> ",
				C = "<C-…> ",
				M = "<M-…> ",
				D = "<D-…> ",
				S = "<S-…> ",
				CR = "<CR> ",
				Esc = "<Esc> ",
				ScrollWheelDown = "<ScrollWheelDown> ",
				ScrollWheelUp = "<ScrollWheelUp> ",
				NL = "<NL> ",
				BS = "<BS> ",
				Space = "<Space> ",
				Tab = "<Tab> ",
				F1 = "<F1>",
				F2 = "<F2>",
				F3 = "<F3>",
				F4 = "<F4>",
				F5 = "<F5>",
				F6 = "<F6>",
				F7 = "<F7>",
				F8 = "<F8>",
				F9 = "<F9>",
				F10 = "<F10>",
				F11 = "<F11>",
				F12 = "<F12>",
			},
			delay = 0,
			spec = {
				{ "<leader>f", group = "Finder" },
				{ "<leader>l", group = "Language Tools" },
				{ "<leader>u", group = "UI/UX" },
				{ "<leader>t", group = "Terminal" },
			},
		},
	},
	-- Tmux navigatate helper
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	-- Better todo/bug/error/info showing helper
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	-- Better back to normal mode
	{
		"max397574/better-escape.nvim",
		opts = {},
	},
	-- Auto pairs colon and brackets
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
