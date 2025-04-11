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

    local get_visual = function(args, parent)
        if (#parent.snippet.env.LS_SELECT_RAW > 0) then
            return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
        else  -- If LS_SELECT_RAW is empty, return a blank insert node
            return sn(nil, i(1))
        end
    end

    --TODO: add condition for not being within a command name
    -- TODO: add hasvar option to disable var version if not existing
    local function mathletter(name, letter)
        local capitalized = name:sub(1,1):upper() .. name:sub(2)
        local upperletter = string.upper(letter)
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

        table.insert(snippets,
            s({
                trig = capitalized,
                snippetType = "autosnippet",
                condition = math_mode_condition,
            },
            {
                    t("\\" .. capitalized)
            })
        )
        if letter ~= nil
        then
            table.insert(snippets,
                s({
                    trig = "@" .. upperletter,
                    snippetType = "autosnippet",
                    condition = math_mode_condition,
                },
                {
                        t("\\" .. capitalized)
                })
            )
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

    local function msnip(trigger, replacement, noWordTrig)
        local trigtable = {
                trig = trigger,
                snippetType = "autosnippet",
                condition = math_mode_condition,
            }

        if noWordTrig then
            trigtable.wordTrig = false
        end

        return s(
            trigtable,
            replacement
        )
    end

    -- TODO: only trigger on empty line
    local function envsnip(name)
        return s(
            {
                trig = name,
                snippetType = "autosnippet",
                condition = math_mode_condition,
            },
            fmta([[
                    \begin{<>}
                        <>
                    \end{<>}
                ]],
                {
                    t(name),
                    i(1),
                    t(name)
                }
            )
        )
    end

    local function mathsuffix(name)
        return s({
                trig = "([A-Za-z]+)" .. name,
                snippetType = "autosnippet",
                regTrig = true,
                condition = math_mode_condition
            }, {
                    t("\\" .. name .. "{"),
                    f(function(_, snip) return snip.captures[1] end),
                    t("}")
            }
        )
    end

    local staticsnippets = {

        msnip("(", { t("("), i(1), t(")") }, true),
        msnip("{", { t("{"), i(1), t("}") }, true),
        -- msnip("\\{", { t("\\{"), i(1), t("\\}") }, true),
        msnip("brc", { t("\\{"), i(1), t("\\}") }),

        msnip("lr(", { t("\\left("), i(1), t("\\right)") }),
        msnip("lr[", { t("\\left["), i(1), t("\\right]") }),
        msnip("lr{", { t("\\left\\{"), i(1), t("\\right\\}") }),
        msnip("ll{", { t("\\left."), i(1), t("\\right\\}") }),

        s(
            {
                trig = "begin",
                snippetType = "autosnippet",
                condition = math_mode_condition,
            },
            fmta([[
                    \begin{<>}
                        <>
                    \end{<>}
                ]],
                {
                    i(1),
                    i(2),
                    rep(1)
                }
            )
        ),

        s(
            {
                trig = "tabular",
                snippetType = "autosnippet",
                condition = math_mode_condition,
            }, fmta([[
                    \begin{tabular}{<>}
                        <>
                    \end{tabular}
            ]], {
                    i(1, "l | l"),
                    i(2)
            })
        ),

        --TODO more envs
        envsnip("align"),
        envsnip("pmatrix"),
        envsnip("bmatrix"),
        envsnip("Bmatrix"),
        envsnip("vmatrix"),
        envsnip("Vmatrix"),

        envsnip("cases"),

        --newline
        msnip("nwl", fmta([[
            \\
            <>
        ]], { i(1) })),



        -- norm
        msnip("norm", { t("\\lvert "), i(1), t(" \\rvert "), i(2) }),
        msnip("||", { t("\\| "), i(1), t(" \\| "), i(2) }),


        msnip("ceil", { t("\\lceil "), i(1), t("\\rceil "), i(2) }),
        msnip("floor", { t("\\lfloor "), i(1), t("\\rfloor "), i(2) }),

        msnip("sr", { t("^2") }, true),
        msnip("cb", { t("^3") }, true),
        msnip("invs", { t("^{-1}") }, true),
        msnip("rd", { t("^{"), i(1), t("}") }, true),
        msnip("_", { t("_{"), i(1), t("}") }, true),

        msnip("sq", { t("\\sqrt{"), i(1), t("}") }),


        msnip("rm", { t("\\mathrm{"), i(1), t("}") }),
        msnip("text", { t("\\text{"), i(1), t("}") }),
        msnip("   ", { t(" \\quad "), i(1), t(" \\quad ") }),
        msnip("quad", { t(" \\quad ") }),

        msnip("xx", { t("\\times") }),
        msnip("cdot", { t("\\cdot") }),
        msnip("**", { t(" \\cdot ") }),

        msnip("xor", { t("\\bigoplus") }),

        msnip("land", { t("\\land") }),
        msnip("lnot", { t("\\lnot") }),
        msnip("lor", { t("\\lor") }),
        msnip("forall", { t("\\forall ") }),
        msnip("all", { t("\\forall ") }),
        msnip("exists", { t("\\exists") }),

        msnip("s.t.", { t("\\mathrm{s.t.} \\quad ") }),

        msnip("Sum", { t("\\sum_{"), i(1), t("}^{"), i(2), t("}") }),
        msnip("Prod", { t("\\prod_{"), i(1), t("}^{"), i(2), t("}") }),
        msnip("sum", { t("\\sum") }),
        msnip("prod", { t("\\prod") }),

        msnip("//", { t("\\frac{"), i(1), t("}{"), i(2), t("}") }),

        msnip("lim", {
            t("\\lim_{"),
            i(1, "n"),
            t(" \\to "),
            i(2, "\\infty"),
            t("}"),
            i(3)
        }),

        msnip("+-", { t("\\pm") }),
        msnip("-+", { t("\\mp") }),
        msnip("...", { t("\\dots ") }),
        msnip("vdots", { t("\\vdots ") }),
        msnip("v..", { t("\\vdots ") }),
        msnip("ddots", { t("\\ddots ") }),
        msnip("d..", { t("\\ddots ") }),

        msnip("Int", {
                t("\\int_{"),
                i(1),
                t("}^{"),
                i(2),
                t("} \\mathrm{d}"),
                i(3)
            }
        ),


        msnip("mop", {
                t("\\mathop{"),
                d(1, get_visual),
                t("}_{"),
                i(2),
                t("}"),
                i(3)
            }
        ),

        msnip("ubr", {
                t("\\underbrace{"),
                d(1, get_visual),
                t("}_{"),
                i(2),
                t("}"),
                i(3)
            }
        ),

        msnip("obr", {
                t("\\overbrace{"),
                d(1, get_visual),
                t("}^{"),
                i(2),
                t("}"),
                i(3)
            }
        ),


        msnip("Par", {
            t("\\frac{\\partial "),
            i(1),
            t("}{\\partial "),
            i(2),
            t("}"),
            i(3)
        }),
        msnip("par", { t("\\partial ") }),

        msnip("grad", { t("\\nabla ") }),
        msnip("nabl", { t("\\nabla ") }),
        
        msnip("MB", { t("\\mathbb{"), i(1), t("}") }),
        msnip("MD", { t("\\mathds{"), i(1), t("}") }),
        msnip("MS", { t("\\mathscr{"), i(1), t("}") }),
        msnip("MC", { t("\\mathcal{"), i(1), t("}") }),


        msnip("NN", { t("\\mathbb{N}") }),
        msnip("RR", { t("\\mathbb{R}") }),

        msnip("arg", { t("\\arg ") }),
        msnip("min", { t("\\min ") }),
        msnip("inf", { t("\\inf ") }),
        msnip("max", { t("\\max ") }),

        msnip("inn", { t("\\in ") }),
        msnip("notin", { t("\\not\\in") }),
        msnip("orr", { t("\\cup") }),
        msnip("and", { t("\\cap") }),

        msnip("sin", { t("\\sin") }),
        msnip("cos", { t("\\cos") }),
        msnip("tan", { t("\\tan") }),
        msnip("log", { t("\\log") }),
        msnip("ln ", { t("\\ln ") }),
        msnip("exp", { t("\\exp("), i(1), t(")") }),


        msnip("tau", { t("\\tau ") }),

        msnip("ooo", { t("\\infty ") }),

        msnip("===", { t("\\equiv") }),
        msnip("!=", { t("\\neq") }),

        msnip(">=", { t("\\geq ") }),
        msnip("<=", { t("\\leq") }),
        msnip(">>", { t("\\gg") }),
        msnip("<<", { t("\\ll") }),

        msnip("~~", { t("\\approx ") }),

        msnip("\\leq>", { t("\\Leftrightarrow ") }),
        msnip("<->", { t("\\leftrightarrow ") }),
        msnip("->", { t("\\to ") }),
        msnip("<-", { t("\\leftarrow ") }),
        msnip("!>", { t("\\mapsto") }),
        msnip("=>", { t("\\implies ") }),
        msnip("=<", { t("\\impliedby ") }),
        msnip(":=", { t("\\coloneqq ") }),

        mathsuffix("tilde"),
        mathsuffix("bar"),
        mathsuffix("und"),
        mathsuffix("vec"),
        mathsuffix("hat"),

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
            t("\\mathrm{"), d(1, get_visual), t("}")
        }),
        msnip("overl", {
            t("\\overline{"), d(1, get_visual), t("}")
        }),

        s({
            trig = "([^/ $]+)/([^/]+)",
            regTrig = true,
            snippetType = "autosnippet",
            wordTrig = false,
            condition = math_mode_condition,
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
	mathletter("eta",   "h") 
	mathletter("theta",  "t") 
	mathletter("iota",   "i") 
	mathletter("kappa",  "k") 
	mathletter("lambda", "l") 
	mathletter("mu", "m") 
	mathletter("psi",    "p") 
	mathletter("sigma",  "s") 
	mathletter("upsilon","u") 
	mathletter("omega",  "o") 
	mathletter("xi",  "x") 

    for _, snippet in ipairs(staticsnippets) do
        table.insert(snippets, snippet)
    end

    return snippets
end

return math_snippets
