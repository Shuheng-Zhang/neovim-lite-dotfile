return {
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      popup = {
        border = "rounded",
      },
    },
    config = function(_, opts)
      require("crates").setup(opts)
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
}
