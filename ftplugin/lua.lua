local lua_setting = {
  Lua = {
    runtime = { version = "LuaJIT" },
    diagnostics = { global = { "vim" } },
    workspace = {
      checkThirdParty = false,
      library = {
        vim.env.VIMRUMTINE,
        vim.api.nvim_get_runtime_file("", true)
      }
    }
  }
}

local lua_ls_cfg = vim.lsp.config.lua_ls

lua_ls_cfg.settings = lua_setting

vim.lsp.config("lua_ls", lua_ls_cfg)

vim.lsp.enable({
  "lua_ls"
})