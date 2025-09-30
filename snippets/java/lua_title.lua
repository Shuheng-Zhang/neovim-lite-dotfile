local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("java", {
	s(
		"doctitle",
		fmt(
			[[
    /**
     * {} 
     *
     * @author {}
     * @since {}
     */
  ]],
			{
				i(1, ""),
				f(require("utils").username, {}),
				f(require("utils").iso_date, {}),
			}
		)
	),
})
