vim.api.nvim_create_autocmd('BufReadPost', {
  group = require('utils').pkg_load_group,
  once = true,
  callback = function()
    require('utils').pkg_load('promise-async')
    require('utils').pkg_load('statuscol', function()
      local statuscol_builtin = require('statuscol.builtin')
      require('statuscol').setup({
        relculright = true,
        segments = {
          -- fold indicator
          { text = { statuscol_builtin.foldfunc },      click = "v:lua.ScFa" },
          -- line number indicator
          { text = { statuscol_builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          -- git status indicator
          { text = { "%s" },                            click = "v:lua.ScSa" },
        },
      })
    end)
    require('utils').pkg_load('ufo', {
      fold_virt_text_handler = require('utils').custom_foldtext
    })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = require('utils').pkg_load_group,
  pattern = { "neo-tree", "Outline" },
  callback = function()
    require("ufo").detach()
    vim.opt_local.foldenable = false
  end,
})

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = "expr"

-- Use treesitter as default folding impl
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-----------------------------------
--- Folding status manage       ---
-----------------------------------

-- Create view store dir
local view_dir = vim.fn.stdpath("state") .. "/view"
if vim.fn.isdirectory(view_dir) == 0 then
  vim.fn.mkdir(view_dir, "p")
end

-- Config view options
vim.opt.viewoptions:remove("options")
vim.opt.viewoptions:remove("folds")
vim.opt.viewoptions:append("folds")

-- Config view store directory
vim.opt.viewdir = view_dir

local view_agroup = vim.api.nvim_create_augroup("presistent-views", { clear = true })

-- auto cmd for saving folding state when window closed
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = view_agroup,
  pattern = "*",
  callback = function()
    -- ignore buffer buffers  of these types
    local buftype = vim.bo.buftype
    if buftype == "terminal" or buftype == "prompt" or buftype == "nofile" then
      return
    end

    -- save views
    vim.cmd("silent! mkview")
  end,
})

-- auto cmd for restore folding state when window opened
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = view_agroup,
  pattern = "*",
  callback = function()
    -- ignore buffer buffers  of these types
    local buftype = vim.bo.buftype
    if buftype == "terminal" or buftype == "prompt" or buftype == "nofile" then
      return
    end

    -- load views
    vim.cmd("silent! loadview")

    -- reload fold state if modified outside
    if vim.fn.foldlevel(".") == 0 and vim.fn.foldclosed(".") == -1 then
      vim.cmd("normal! zx")
    end
  end,
})

-- command for refreshing fold
vim.api.nvim_create_user_command("RefreshFold", function()
  vim.cmd("silent! loadview")
  vim.cmd("normal! zx")
  vim.notify("Fold states refreshed", vim.log.levels.INFO)
end, {})
