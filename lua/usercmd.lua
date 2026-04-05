-- -------------------------- 全局自定义命令 -------------------------- --

-- create a command for cleaning registers
vim.api.nvim_create_user_command("ClearRegisters", function()
  local registers = { '"', "@" }

  -- registers for copy or delete history
  for i = 0, 9 do
    table.insert(registers, tostring(i))
  end
  -- registers for custom macro or text
  for reg = string.byte("a"), string.byte("z") do
    table.insert(registers, string.char(reg))
  end

  -- clear all registers
  for _, reg in ipairs(registers) do
    vim.fn.setreg(reg, "")
  end

  vim.notify("All registers cleared", vim.log.levels.INFO)
end, { desc = "Clear registers" })
