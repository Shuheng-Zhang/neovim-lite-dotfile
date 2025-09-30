local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- 动态提取参数名、返回类型和异常
local function extract_java_method_info()
	local line_num = vim.fn.line(".")
	local lines = vim.api.nvim_buf_get_lines(0, line_num, line_num + 5, false)

	for _, line in ipairs(lines) do
		local clean = line:gsub("^%s+", ""):gsub("//.*", ""):gsub("%s+", " ")

		-- 匹配完整方法签名，包括 throws(可选)
		local ret_type, method_name, params, throws_clause =
			clean:match("([%w_<>%[%]]+)%s+([%w_]+)%s*%((.-)%)%s*throws%s+([%w_., %s]+)")
		-- 如果没有 throws 匹配，再试试没有 throws 的签名
		if not ret_type then
			ret_type, method_name, params = clean:match("([%w_<>%[%]]+)%s+([%w_]+)%s*%((.-)%)")
		end

		if ret_type and method_name then
			local param_lines = {}
			if #params > 0 then
				for param in params:gmatch("([^,%s]+%s+[%w_]+)") do
					local pname = param:match("([%w_]+)$")
					if pname then
						table.insert(param_lines, " * @param " .. pname .. " ")
					end
				end
			end

			local return_line = {}
			if ret_type ~= "void" then
				return_line = { " * @return " }
			end

			local throws_lines = {}
			if throws_clause then
				for exception in throws_clause:gmatch("([%w_]+)") do
					table.insert(throws_lines, " * @throws " .. exception .. " ")
				end
			end

			return param_lines, return_line, throws_lines
		end
	end

	return {}, {}, {}
end

return {
	s("docmethod", {
		t({ "/**", " * " }),
		i(1, ""),
		t({ "", "" }),
		f(function()
			local param_lines, return_line, throws_lines = extract_java_method_info()
			local doc = {}
			vim.list_extend(doc, param_lines)
			vim.list_extend(doc, return_line)
			vim.list_extend(doc, throws_lines)
			if #doc == 0 then
				return { " * " }
			end
			return doc
		end, {}),
		t({ "", " */" }),
	}),
}
