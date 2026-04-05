--- better LSP support ---

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
local cmp_capabilities = require("blink.cmp").get_lsp_capabilities()

IS_CONFLICTING_CAPABILITIES_DISABLE_INVOKED = false
local function disable_conflicting_capabilities()
  local lsp_clients = vim.lsp.get_clients()
  for _, lsp_client in ipairs(lsp_clients) do
    if lsp_client.name == "angularls" then
      lsp_client.server_capabilities.foldingRangeProvider = false
      IS_CONFLICTING_CAPABILITIES_DISABLE_INVOKED = true
      vim.notify("disable_conflicting_capabilities invoked")
      break
    end
  end
end

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = require('utils').pkg_load_group,
  once = true,
  callback = function()
    require('utils').pkg_load('nvim-lspconfig')

    vim.lsp.config("*", {
      capabilities = vim.tbl_deep_extend("force", capabilities, cmp_capabilities or {}),
      on_attach = function(client, bufnr)
        if not IS_CONFLICTING_CAPABILITIES_DISABLE_INVOKED then
          disable_conflicting_capabilities()
        end
      end,
    })
  end
})
