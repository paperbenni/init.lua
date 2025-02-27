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


local function math_snippets(math_mode_condition)
    local snippets = {}

    local function mathletter(name, letter)
        table.insert(snippets,
            s({
                trig = name,
                snippetType = "autosnippet",
                condition = math_mode_condition,
            },
            {
                    t("\\" .. name)
            })
        )
        if letter ~= nil
        then
            table.insert(snippets,
                s({
                    trig = "@" .. letter,
                    snippetType = "autosnippet",
                    condition = math_mode_condition,
                },
                {
                        t("\\" .. name)
                })
            )
            table.insert(snippets,
                s({
                    trig = ":" .. letter,
                    snippetType = "autosnippet",
                    condition = math_mode_condition,
                },
                {
                        t("\\var" .. name)
                })
            )
        end
    end

    local function msnip(trigger, replacement)
        return s(
            {
                trig = trigger,
                snippetType = "autosnippet",
                condition = math_mode_condition,
            },
            replacement
        )
    end
    

    local staticsnippets = {
        msnip("sr", { t("^2") }),
        msnip("cb", { t("^3") }),
        msnip("rd", { t("^{"), i(1), t("}") }),
        msnip("_", { t("_{"), i(1), t("}") }),

        msnip("rm", { t("\\mathrm{"), i(1), t("}") }),

        msnip("cdot", { t("\\cdot") }),
        msnip("xor", { t("\\bigoplus") }),

        msnip("Sum", { t("\\sum_{"), i(1), t("}^{"), i(2), t("}") }),
        msnip("Prod", { t("\\prod_{"), i(1), t("}^{"), i(2), t("}") }),
        msnip("sum", { t("\\sum") }),
        msnip("prod", { t("\\prod") }),

        msnip("Int", {
                t("\\int_{"),
                i(1),
                t("}^{"),
                i(2),
                t("} \\mathrm{d}"),
                i(3)
            }
        ),
        
        msnip("MB", { t("\\mathbb{"), i(1), t("}") }),

        msnip("NN", { t("\\mathbb{N}") }),

        msnip("arg", { t("\\arg{") }),
        msnip("min", { t("\\min{") }),
        msnip("max", { t("\\max{") }),

        msnip("sin", { t("\\sin") }),
        msnip("cos", { t("\\cos") }),
        msnip("tan", { t("\\tan") }),

        msnip("ooo", { t("\\infty") }),

        msnip("===", { t("\\equiv") }),
        msnip("!=", { t("\\neq") }),

        msnip(">=", { t("\\geq") }),
        msnip("<=", { t("\\leq") }),
        msnip(">>", { t("\\gg") }),
        msnip("<<", { t("\\ll") }),

        msnip("<->", { t("\\leftrightarrow ") }),
        msnip("->", { t("\\to") }),
        msnip("!>", { t("\\mapsto") }),
        msnip("=>", { t("\\implies") }),
        msnip("=<", { t("\\impliedby") }),

        s({
            trig = "([^ /$]+)hat",
            snippetType = "autosnippet",
            regTrig = true,
            condition = math_mode_condition
        }, {
                t("\\hat{"),
                f(function(_, snip) return snip.captures[1] end),
                t("}")
        }),
        s({
            trig = "([^ /$]+)und",
            snippetType = "autosnippet",
            regTrig = true,
            condition = math_mode_condition
        }, {
                t("\\und{"),
                f(function(_, snip) return snip.captures[1] end),
                t("}")
        }),
        s({
            trig = "([^ /$]+)bar",
            snippetType = "autosnippet",
            regTrig = true,
            condition = math_mode_condition
        }, {
                t("\\bar{"),
                f(function(_, snip) return snip.captures[1] end),
                t("}")
        }),

        s({
            trig = "mk",
            regTrig = false,
            condition = function()
                return not math_mode_condition()
            end,
            snippetType = "autosnippet"
        }, {
            t("$"), i(1), t("$")
        }),
        s({
            trig = "dm",
            snippetType = "autosnippet",
            condition = function()
                return not math_mode_condition()
            end,
        }, {
            t({ "$$", "" }), i(1), t({ "","$$" })
        }),

        msnip("rm", {
            t("\\mathrm{"), i(1), t("}")
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

	mathletter("alpha",  "a") 
	mathletter("beta",   "b") 
	mathletter("gamma",  "g") 
	mathletter("delta",  "d") 
	mathletter("epsilon","e") 
	mathletter("zeta",   "z") 
	mathletter("theta",  "t") 
	mathletter("iota",   "i") 
	mathletter("kappa",  "k") 
	mathletter("lambda", "l") 
	mathletter("sigma",  "s") 
	mathletter("upsilon","u") 
	mathletter("omega",  "o") 

    for _, snippet in ipairs(staticsnippets) do
        table.insert(snippets, snippet)
    end

    return snippets
end

return math_snippets
