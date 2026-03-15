return {
  "williamboman/mason.nvim",
  dependencies = {
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = {
        ensure_installed = {
          -- Lua
          "lua-language-server",
          "stylua",

          -- Java
          "jdtls",
          "java-debug-adapter",
          "java-test",
          "vscode-spring-boot-tools",

          -- xml
          "lemminx",

          -- yaml
          "yaml-language-server",

          -- markdown
          "marksman",

          -- Rust
          "codelldb",
          "rust-analyzer",
          "taplo",

          -- Go
          "gopls",
          "delve",
          "gomodifytags",
          "gotests",
          "iferr",
          "impl",
          "goimports"
        }
      }
    },

  },
  opts = {
    ui = {
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = "",
      },
      border = "rounded",
      backdrop = 80,
    },
  },
}
