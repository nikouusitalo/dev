local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s("req111", {
		t("local "),
		i(1, "mod"),
		t(' = require("'),
		i(2, "module"),
		t('")'),
	}),
}
