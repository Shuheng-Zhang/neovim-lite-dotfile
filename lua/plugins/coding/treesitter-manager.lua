return {
	{
		"romus204/tree-sitter-manager.nvim",
		enabled = false,
		config = function()
			require("tree-sitter-manager").setup({})
		end,
	},
}
