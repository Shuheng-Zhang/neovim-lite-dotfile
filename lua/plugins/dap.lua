return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		opts = {},
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggole Debugeger UI",
			},
			{
				"<leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Debugeger Hover",
			},
			{
				"<leader>dE",
				function()
					vim.ui.input({ prompt = "Expression: " }, function(expr)
						if expr then
							require("dapui").eval(expr, { enter = true })
						end
					end)
				end,
				desc = "Evaluate Input",
			},
			{
				"<leader>dE",
				function()
					require("dapui").eval()
				end,
				mode = "v",
				desc = "Evaluate Input",
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>da",
				function()
					require("dap").set_breakpoint()
				end,
				desc = "Set a Breakpoint",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "[Debugeger] Toggle Breakpoint(F9)",
			},
			{
				"<leader>dl",
				function()
					require("fzf-lua").dap_breakpoints()
				end,
				desc = "[Debugeger] List Breakpoints",
			},
			{
				"<F9>",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").clear_breakpoints()
				end,
				desc = "Clear Breakpoints",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Start/Continue(F5)",
			},
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "[Debugeger] Start/Continue",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Setp Into(F11)",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "[Debugeger] Setp Into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Setp Over(F10)",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "[Debugeger] Setp Over",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "Setp Out(S-F11)",
			},
			{
				"<F23>", -- Shift+F11
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<leader>dp",
				function()
					require("dap").pause()
				end,
				desc = "Pause(F6)",
			},
			{
				"<F6>",
				function()
					require("dap").pause()
				end,
				desc = "[Debugeger] Pause",
			},
			{
				"<leader>dq",
				function()
					require("dap").close()
				end,
				desc = "Close Session",
			},
			{
				"<leader>dQ",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate Session(S-F5)",
			},
			{
				"<F29>",
				function()
					require("dap").terminate()
				end,
				desc = "[Debugeger] Terminate Session",
			},
			{
				"<leader>dR",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle REPL",
			},
			{
				"<leader>dr",
				function()
					require("dap").restart_frame()
				end,
				desc = "Restart (C-F5)",
			},
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			ensure_installed = { "javadbg", "javatest" },
		},
	},
}
