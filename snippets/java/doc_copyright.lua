local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("java", {
	s(
		"copyright",
		fmt(
			[[
    /**
     * Copyright (c) {} {}. All rights reserved.
     *
     * @version {}
     * @license {}
     */
  ]],
			{
				f(function()
					return os.date("%Y")
				end, {}), -- 当前年份
				f(require("utils").username, {}),
				i(1, "1.0.0"),
				i(2, "MIT"),
			}
		)
	),
})
