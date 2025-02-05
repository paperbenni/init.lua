local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep


-- Helper function to check if we're in math mode
local function math_mode_condition()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end


return {
    s({
        trig = "hi",
        dscr = "This is a test",
        regTrig = false,
        priority = 100,
        snippetType = "autosnippet",
    },{
        t("This is a test for saying hi"),
    }),
    s({
        trig = "mk",
        snippetType = "autosnippet"
    }, {
        t("$"), i(1), t("$")
    }),
    s({
        trig = "@g",
        snippetType = "autosnippet",
        condition = math_mode_condition,
    }, {
        t("\\gamma")
    }),
    s({
        trig = "([^/$]+)/([^/]+)",
        regTrig = true,
        snippetType = "autosnippet",
        wordTrig = false,
        desc = "Auto-convert a/b to fraction",
    }, {
        t("\\frac{"),
        f(function(_, snip) return snip.captures[1] end),
        t("}{"),
        f(function(_, snip) return snip.captures[2] end),
        i(1),
        t("}"),
        i(2),
    }),
}

