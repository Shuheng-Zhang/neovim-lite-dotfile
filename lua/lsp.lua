-----------------------------------------
-- Set up Diagnostic UI appearance     --
-----------------------------------------

local diagnostic_icons = {
	ERROR = "󰅚 ",
	WARN = "󰀪 ",
	INFO = "󰋽 ",
	HINT = "󰌶 ",
}

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	-- underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_icons.ERROR,
			[vim.diagnostic.severity.WARN] = diagnostic_icons.WARN,
			[vim.diagnostic.severity.INFO] = diagnostic_icons.INFO,
			[vim.diagnostic.severity.HINT] = diagnostic_icons.HINT,
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	} or {},
	virtual_lines = {
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})

-------------------------------
-- General LSP setup         --
-------------------------------

-----------------------------------------
-- Set up LSP                          --
-----------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		-- A keymapping function to make LSP key bindings easier
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
		end

		-- map("K", require("pretty_hover").hover, nil)
		map("<leader>lc", vim.lsp.codelens.run, "Run CodeLens")
		map("<leader>lC", function()
			vim.lsp.codelens.refresh({ bufnr = 0 })
		end, "Refresh CodeLens")
		map("<leader>ln", vim.lsp.buf.rename, "Rename")
		map("<leader>lf", vim.lsp.buf.format, "Format code")
		map("gl", function()
			vim.diagnostic.open_float({ source = true })
		end, "Show inline diagnostic")
		map("gD", vim.lsp.buf.declaration, "Goto Declaration")
		map("gi", vim.lsp.buf.implementation, "Goto implementation")
		map("gd", function()
			vim.lsp.buf.definition()
		end, "Goto definition")

		map("<leader>la", vim.lsp.buf.code_action, "Code Actions", { "n", "x" })
		map("<leader>lr", require("telescope.builtin").lsp_references, "References")
		map("<leader>li", require("telescope.builtin").lsp_implementations, "Implementations")
		map("<leader>ld", require("telescope.builtin").lsp_definitions, "Definitions")
		map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
		map("<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
		map("<leader>lt", require("telescope.builtin").lsp_type_definitions, "Type Definition")
		map("<leader>lx", function()
			require("telescope.builtin").diagnostics({ bufnr = 0 })
		end, "Document Diagnostics")
		map("<leader>lX", require("telescope.builtin").diagnostics, "Workspace Diagnostics")

		----------------------------------------
		-- Configurate supported LSP features --
		----------------------------------------

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- Disable inlayHint as default
		vim.lsp.inlay_hint.enable(false)
		vim.keymap.set("n", "<leader>lh", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
		end, { buffer = event.buf, desc = "Toggle Inlay Hints" })

		-- Autocmd for disable inlay hints in insert mode
		vim.api.nvim_create_autocmd("InsertEnter", {
			desc = "Disable inlay hints on insert",
			callback = function(args)
				local filter = { bufnr = args.buf }
				-- if the inlay hints are currently enabled
				if vim.lsp.inlay_hint.is_enabled(filter) then
					-- disable the inlay hints
					vim.lsp.inlay_hint.enable(false, filter)
					-- create a single use autocommand to turn the inlay hints back on
					-- when leaving insert mode
					vim.api.nvim_create_autocmd("InsertLeave", {
						buffer = args.buf,
						once = true,
						callback = function()
							vim.lsp.inlay_hint.enable(true, filter)
						end,
					})
				end
			end,
		})

		-- Autocmd for refresh codelens
		vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
			desc = "Auto refresh codelens",
			pattern = "*",
			callback = function()
				vim.lsp.codelens.refresh({ bufnr = 0 })
			end,
		})
		-- Highlight words under cursor
		if
			client
			and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
			and vim.bo.filetype ~= "bigfile"
		then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(e)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = e.buf })
					-- vim.cmd 'setl foldexpr <'
				end,
			})
		end

		-- LSP Folding
		-- Switch to LSP folding if supported
		if client and client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})
