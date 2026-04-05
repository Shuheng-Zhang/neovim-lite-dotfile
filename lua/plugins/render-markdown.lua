local group = vim.api.nvim_create_augroup('nvim-render-markdown', { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"nocie", "markdown", "codecompanion", "Avante" },
  group = group,
  callback = function ()
    require('utils').pkg_load('render-markdown', {
      callout = {
        abstract = {
          raw = "[!ABSTRACT]",
          rendered = "󰯂 Abstract",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        summary = {
          raw = "[!SUMMARY]",
          rendered = "󰯂 Summary",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        tldr = {
          raw = "[!TLDR]",
          rendered = "󰦩 Tldr",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        failure = {
          raw = "[!FAILURE]",
          rendered = " Failure",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        fail = {
          raw = "[!FAIL]",
          rendered = " Fail",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        missing = {
          raw = "[!MISSING]",
          rendered = " Missing",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        attention = {
          raw = "[!ATTENTION]",
          rendered = " Attention",
          highlight = "RenderMarkdownWarn",
          category = "obsidian",
        },
        warning = {
          raw = "[!WARNING]",
          rendered = " Warning",
          highlight = "RenderMarkdownWarn",
          category = "github",
        },
        danger = {
          raw = "[!DANGER]",
          rendered = " Danger",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        error = {
          raw = "[!ERROR]",
          rendered = " Error",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        bug = { raw = "[!BUG]", rendered = " Bug", highlight = "RenderMarkdownError", category = "obsidian" },
        quote = {
          raw = "[!QUOTE]",
          rendered = " Quote",
          highlight = "RenderMarkdownQuote",
          category = "obsidian",
        },
        cite = {
          raw = "[!CITE]",
          rendered = " Cite",
          highlight = "RenderMarkdownQuote",
          category = "obsidian",
        },
        todo = {
          raw = "[!TODO]",
          rendered = " Todo",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        wip = { raw = "[!WIP]", rendered = "󰦖 WIP", highlight = "RenderMarkdownHint", category = "obsidian" },
        done = {
          raw = "[!DONE]",
          rendered = " Done",
          highlight = "RenderMarkdownSuccess",
          category = "obsidian",
        },
      },
      code = {
        -- general
        width = "full",
        min_width = 80,
        -- borders
        border = "thin",
        left_pad = 2,
        right_pad = 2,
        -- language info
        position = "left",
        language_icon = true,
        language_name = true,
        -- avoid making headings ugly
        highlight_inline = "RenderMarkdownCodeInfo",
      },
      heading = {
        icons = { " 󰼏 ", " 󰎨 ", " 󰼑 ", " 󰎲 ", " 󰼓 ", " 󰎴 " },
        border = false,
        render_modes = true, -- keep rendering while inserting
      },
      checkbox = {
        unchecked = {
          icon = "󰄱",
          highlight = "RenderMarkdownCodeFallback",
          scope_highlight = "RenderMarkdownCodeFallback",
        },
        checked = {
          icon = "󰄵",
          highlight = "RenderMarkdownUnchecked",
          scope_highlight = "RenderMarkdownUnchecked",
        },
        custom = {
          question = {
            raw = "[?]",
            rendered = "",
            highlight = "RenderMarkdownError",
            scope_highlight = "RenderMarkdownError",
          },
          todo = {
            raw = "[>]",
            rendered = "󰦖",
            highlight = "RenderMarkdownInfo",
            scope_highlight = "RenderMarkdownInfo",
          },
          canceled = {
            raw = "[-]",
            rendered = "",
            highlight = "RenderMarkdownCodeFallback",
            scope_highlight = "@text.strike",
          },
          important = {
            raw = "[!]",
            rendered = "",
            highlight = "RenderMarkdownWarn",
            scope_highlight = "RenderMarkdownWarn",
          },
          favorite = {
            raw = "[~]",
            rendered = "",
            highlight = "RenderMarkdownMath",
            scope_highlight = "RenderMarkdownMath",
          },
        },
      },
      pipe_table = {
        alignment_indicator = "─",
        border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
      },
      link = {
        render_modes = true,
        wiki = {
          icon = " ",
          highlight = "RenderMarkdownWikiLink",
          scope_highlight = "RenderMarkdownWikiLink",
        },
        image = " ",
        custom = {
          jdt = { pattern = "^jdt", icon = ' ' },
          web = { pattern = '^[http|https]', icon = '󰖟 ' },
          apple = { pattern = 'apple%.com', icon = ' ' },
          discord = { pattern = 'discord%.com', icon = '󰙯 ' },
          github = { pattern = 'github%.com', icon = '󰊤 ' },
          gitlab = { pattern = 'gitlab%.com', icon = '󰮠 ' },
          google = { pattern = 'google%.com', icon = '󰊭 ' },
          hackernews = { pattern = 'ycombinator%.com', icon = ' ' },
          linkedin = { pattern = 'linkedin%.com', icon = '󰌻 ' },
          microsoft = { pattern = 'microsoft%.com', icon = ' ' },
          neovim = { pattern = 'neovim%.io', icon = ' ' },
          reddit = { pattern = 'reddit%.com', icon = '󰑍 ' },
          slack = { pattern = 'slack%.com', icon = '󰒱 ' },
          stackoverflow = { pattern = 'stackoverflow%.com', icon = '󰓌 ' },
          steam = { pattern = 'steampowered%.com', icon = ' ' },
          twitter = { pattern = 'twitter%.com', icon = ' ' },
          wikipedia = { pattern = 'wikipedia%.org', icon = '󰖬 ' },
          x = { pattern = 'x%.com', icon = ' ' },
          youtube = { pattern = 'youtube[^.]*%.com', icon = '󰗃 ' },
          youtube_short = { pattern = 'youtu%.be', icon = '󰗃 ' },
        },
        hyperlink = " ",
      },
      anti_conceal = {
        disabled_modes = { "n" },
        ignore = {
          bullet = true, -- render bullet in insert mode
          head_border = true,
          head_background = true,
        },
      },
      completions = {
        lsp = { enabled = true },
        blink = { enabled = true },
      },
      overrides = {
        buftype = {
          nofile = {
            render_modes = { "n", "c", "i" },
            debounce = 5,
            code = {
              left_pad = 0,
              right_pad = 0,
              language_pad = 0,
            },
          },
        },
        filetype = {},
      },
      win_options = { concealcursor = { rendered = "nvc" } },
      sign = { enabled = false },
      render_modes = true,
      file_types = { "noice", "markdown", "codecompanion", "Avante" }
    })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "markdown", "tex", "mdx", "codecompanion" },
  group = group,
  callback = function (args)
    vim.treesitter.start(args.buf, "markdown")
  end
})
