return {
  {
    "JavaHello/spring-boot.nvim",
    dependencies = {
      {
        "mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig
        lazy = true,
        config = false,
      }
    },
    lazy = true,
    opts = {},
  },
}
