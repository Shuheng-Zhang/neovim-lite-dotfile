local M = {}

function M.list_insert_unique(dst, src)
	if not dst then
		dst = {}
	end
	assert(vim.islist(dst), "Provided table is not a list like table")
	local added = {}
	for _, val in ipairs(dst) do
		added[val] = true
	end
	for _, val in ipairs(src) do
		if not added[val] then
			table.insert(dst, val)
			added[val] = true
		end
	end
	return dst
end

return M
