return {
  	{
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = "nvim-treesitter/nvim-treesitter",
		main = "rainbow-delimiters.setup",
		opts = {},
	}
}
