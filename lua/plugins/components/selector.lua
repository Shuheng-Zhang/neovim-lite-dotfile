return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-frecency.nvim",
			dependencies = { "kkharji/sqlite.lua" },
			config = function()
				require("telescope").load_extension("frecency")
			end,
		},
	},
	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find files",
		},
		{
			"<leader>fr",
			function()
				require("telescope").extensions.frecency.frecency({
					workspace = "CWD", -- 当前项目目录
				})
			end,
			desc = "Find Recently Files",
		},
		{
			"<leader><leader>",
			function()
				require("telescope").extensions.frecency.frecency({
					workspace = "CWD", -- 当前项目目录
				})
			end,
			desc = "Find Recently Files",
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Find buffers",
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Live grep current project",
		},
		{
			"<leader>fk",
			function()
				require("telescope.builtin").keymaps()
			end,
			desc = "Find keympas",
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Find helps",
		},
		{
			"<leader>fc",
			function()
				require("telescope.builtin").commands()
			end,
			desc = "Find neovim commands",
		},
		{
			"<leader>fa",
			function()
				require("telescope.builtin").autocommands()
			end,
			desc = "Find autocmds",
		},
		{
			"<leader>fC",
			function()
				require("telescope.builtin").command_history()
			end,
			desc = "Find commands history",
		},
	},
	opts = {
		extensions = {
      -- NOTE: Uncomment after telescope installed
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		},
	},
}
