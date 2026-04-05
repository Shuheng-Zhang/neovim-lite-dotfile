-- -------------------------- 公用工具函数 -------------------------- --

local M = {}

-- 插件配置组
M.pkg_load_group = vim.api.nvim_create_augroup('nvim-plugin-load', { clear = true })

--- 获取插件包的源安装地址
---
--- @param name string 插件包路径, 使用 GitHub 短地址, 如 ___repo/plugin___ .
---
local function from_github(name)
  return 'https://github.com/' .. name
end


--- 安装插件包
---
--- 仅执行包安装, 加载包需要调用 ___vim.cmd.packadd___ 函数
---
--- @param plugins string|string[]|{src: string, name: string?, version?: vim.VersionRange}[] 包路径, 使用 GitHub 短地址, 如 ___repo/plugin___ . 务必确保系统中 ___git___ 可用
--- @param confirm boolean? 是否自动安装. 默认为 __true__
---
M.pkg_install = function(plugins, confirm)
  -- 确保 pkg(s) 是个列表
  local pkg_list = type(plugins) == "table" and plugins or { plugins }

  -- 处理 conform 赋值
  if not confirm then
    confirm = false
  end

  -- 批量安装包
  for _, pkg in ipairs(pkg_list) do
    local pkg_type = type(pkg)
    if pkg_type == "string" then
      pkg = from_github(pkg)
    elseif pkg_type == "table" and pkg.src and pkg.src ~= '' then
      pkg.src = from_github(pkg.src)
    else
      vim.notify(string.format("Invalid plugin spec: [%s]", vim.inspect(pkg)))
      goto continue
    end

    -- 执行安装, 取消安装后自动加载
    local ok, err = pcall(vim.pack.add, { pkg }, { confirm = confirm, load = false })
    if not ok then
      vim.notify(string.format("Failed to install plugin: [%s]. ERROR occurred: %s", vim.inspect(pkg or pkg.src), err))
    end

    ::continue::
  end
end

--- 检查插件是否已安装
---
--- @param plugin string 插件安装名
---
M.is_pkg_installed = function(plugin)
  local pkg = vim.pack.get({ plugin })
  return pkg ~= nil
end

--- 加载并初始化插件
---
--- 仅加载并初始化 ___已安装___ 的插件
---
--- @param plugin string 插件名称
--- @param init table|function? 初始化配置. 若为 __table__ 则作为初始化参数传入 ___setup()___ 函数; 若为 __function__ 则调用该函数执行初始化; 若为空, 则仅加载插件到运行时
---
M.pkg_load = function(plugin, init)
  if not M.is_pkg_installed(plugin) then
    vim.notify(string.format('Plugin [%s] was not installed yet', plugin), vim.log.levels.ERROR)
    return
  end

  -- 加载插件
  if not package.loaded[plugin] then
    vim.cmd.packadd(plugin)
  else
    return
  end

  -- 无配置, 仅加载插件
  if not init then
    return
  end

  -- 调用 init() 初始化
  if type(init) == "function" then
    init()
    return
  end

  -- 使用插件的 setup() 函数并传入参数进行初始化
  require(plugin).setup(init)
end


M.pkg_update = function(plugins)
  local ok, err = pcall(vim.pack.update, plugins)
  if not ok then
    vim.notify('Error occurred during plugin(s) update: ' .. tostring(err), vim.log.levels.ERROR)
  end
end


--- 自定义折叠指示器样式
---
--- @param virtText table content block object
--- @param lnum number start of folding line
--- @param endLnum number end of folding line
--- @param width number max usable display width
--- @param truncate function content text truncate function
M.custom_foldtext = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = string.rep(" ", 4) .. ("󰁂 %d lines(%d ~> %d)"):format(endLnum - lnum + 1, lnum, endLnum + 1)

  local sufWidth = vim.fn.strdisplaywidth(suffix)

  -- main continer with
  local continerWidth = width - sufWidth

  -- used with counter
  local curWidth = 0

  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if continerWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, continerWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)

      if curWidth + chunkWidth < continerWidth then
        suffix = suffix .. (" "):rep(continerWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end

  table.insert(newVirtText, { suffix, "@character.special" })

  return newVirtText
end

return M
