return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
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
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dl",
				function()
					require("fzf-lua").dap_breakpoints()
				end,
				desc = "List Breakpoints",
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
				desc = "Start/Continue",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Setp Into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Setp Over",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "Setp Out",
			},
			{
				"<leader>dp",
				function()
					require("dap").pause()
				end,
				desc = "Pause",
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
				desc = "Terminate Session",
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
				desc = "Restart",
			},
		},
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"nvim-neotest/nvim-nio",
				},
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
			"mxsdev/nvim-dap-vscode-js",
			{
				"microsoft/vscode-js-debug",
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
		},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			local function get_js_debug()
				local path = vim.fn.stdpath("data")
				return path .. "/lazy/vscode-js-debug"
			end

			require("dap-vscode-js").setup({
				node_path = "node",
				debugger_path = get_js_debug(),
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})

			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Debug Jest Tests",
						-- trace = true, -- include debugger info
						runtimeExecutable = "node",
						runtimeArgs = {
							"./node_modules/jest/bin/jest.js",
							"--runInBand",
						},
						rootPath = "${workspaceFolder}",
						cwd = "${workspaceFolder}",
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
					},
					{
						type = "pwa-chrome",
						name = "Attach - Remote Debugging",
						request = "attach",
						program = "${file}",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
						protocol = "inspector",
						port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
						webRoot = "${workspaceFolder}",
					},
					{
						type = "pwa-chrome",
						name = "Launch Chrome",
						request = "launch",
						url = "http://localhost:5173", -- This is for Vite. Change it to the framework you use
						webRoot = "${workspaceFolder}",
						userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
					},
				}
			end

			for _, language in ipairs({ "typescriptreact", "javascriptreact" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-chrome",
						name = "Attach - Remote Debugging",
						request = "attach",
						program = "${file}",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
						protocol = "inspector",
						port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
						webRoot = "${workspaceFolder}",
					},
					{
						type = "pwa-chrome",
						name = "Launch Chrome",
						request = "launch",
						url = "http://localhost:5173", -- This is for Vite. Change it to the framework you use
						webRoot = "${workspaceFolder}",
						userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
					},
				}
			end
		end,
	},
}
