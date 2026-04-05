-- ------------------------------ 安装插件 ------------------------------ --
require('utils').pkg_install({
  { src = "catppuccin/nvim",         name = 'catppuccin' },
  "nvim-tree/nvim-web-devicons",
  { src = "akinsho/bufferline.nvim", name = "bufferline" },
  "SmiteshP/nvim-navic",
  { src = "nvim-lualine/lualine.nvim",    name = "lualine" },
  { src = 'folke/snacks.nvim',            name = 'snacks' },
  { src = "MunifTanjim/nui.nvim",         name = "nui" },
  { src = "rcarriga/nvim-notify",         name = "nvim-notify" },
  { src = "folke/noice.nvim",             name = "noice" },
  { src = 'goolord/alpha-nvim',           name = 'alpha' },
  { src = "lewis6991/gitsigns.nvim",      name = "gitsigns" },
  { src = 'max397574/better-escape.nvim', name = 'better_escape' },
  "nvim-treesitter/nvim-treesitter",
  { src = "HiPhish/rainbow-delimiters.nvim", name = "rainbow-delimiters" },
  { src = "stevearc/aerial.nvim",            name = "aerial" },
  "kevinhwang91/promise-async",
  { src = "luukvbaal/statuscol.nvim", name = "statuscol" },
  { src = "kevinhwang91/nvim-ufo",    name = "ufo" },
  { src = "saghen/blink.cmp",         version = vim.version.range('1.*') },
  "neovim/nvim-lspconfig",
  "rafamadriz/friendly-snippets",
  { src = "L3MON4D3/LuaSnip",                          version = vim.version.range('v2.*') },
  { src = "folke/lazydev.nvim",                        name = "lazydev" },
  { src = "stevearc/conform.nvim",                     name = "conform" },
  { src = "MeanderingProgrammer/render-markdown.nvim", name = "render-markdown" },
  { src = "nvim-lua/plenary.nvim",                     name = "plenary" },
  { src = 'folke/todo-comments.nvim',                  name = 'todo-comments' },
  'windwp/nvim-autopairs',
  { src = "j-hui/fidget.nvim",                         name = "fidget" },
  { src = 'folke/which-key.nvim',                      name = 'which-key' },
  { src = "WhoIsSethDaniel/mason-tool-installer.nvim", name = "mason-tool-installer" },
  { src = "williamboman/mason.nvim",                   name = "mason" },
  "Fildo7525/pretty_hover",
}, true)


-- ------------------------------ 加载并配置插件 ----------------------------- --

require('plugins.catppuccin')         -- catppuccin 主题
require('plugins.alpha')              -- Dashboard
require('plugins.bufferline')         -- buffer tab
require('plugins.lualine')            -- 状态栏
require('plugins.snacks')             -- 插件, 功能扩展集合
require('plugins.noice')              -- 消息通知
-- require('plugins.smart-cursor')       -- 滑动光标
require('plugins.gitsigns')           -- Git状态指示
require('plugins.better-esc')         -- 快速ESC

require('plugins.nvim-treesitter')    -- TreeSitter
require('plugins.rainbow-delimiters') -- 多色括号高亮
require('plugins.folding')            -- 折叠

require('plugins.blink-cmp')          -- Auto-CMP
require('plugins.nvim-lsp')           -- LSP Config
require('plugins.luasinp')            -- Snips
require('plugins.aerial')             -- Outline

require('plugins.lazydev')            -- Vim/Neovim modules parser

require('plugins.conform')            -- 格式化
-- require('plugins.markview')           -- Markdown 渲染
require('plugins.render-markdown')    -- Markdown 渲染
require('plugins.todo-comments')      -- 高亮TODO, BUG, FIX, ERROR 等注释
require('plugins.autopairs')          -- 自动匹配各种括号
require('plugins.fidget')             -- 进度指示器

-- 延时加载 --
require('plugins.which-key')    -- WhichKey按键提示
require('plugins.mason')        -- LSP Manager
require('plugins.pretty_hover') -- 代码提示美化
