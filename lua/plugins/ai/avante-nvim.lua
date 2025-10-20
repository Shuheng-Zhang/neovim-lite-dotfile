return {
	{
		"yetone/avante.nvim",
		-- 如果您想从源代码构建，请执行 `make BUILD_FROM_SOURCE=true`
		-- ⚠️ 一定要加上这一行配置！！！！！
		build = vim.fn.has("win32") ~= 0
				and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			or "make",
		event = "VeryLazy",
		version = false, -- 永远不要将此值设置为 "*"！永远不要！
		---@module 'avante'
		---@type avante.Config
		opts = {
			provider = "deepseek",
			vendors = {
				deepseek = {
					__inherited_from = "openai",
					api_key_name = "DEEPSEEK_API_KEY",
					endpoint = "https://api.deepseek.com",
					model = "deepseek-coder",
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim", -- 用于文件选择器提供者 telescope
			"nvim-tree/nvim-web-devicons", -- 或 echasnovski/mini.icons
			{
				-- 支持图像粘贴
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- 推荐设置
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- Windows 用户必需
						use_absolute_path = true,
					},
					web_search = {
						enabled = false,
					},
				},
			},
		},
	},
}
