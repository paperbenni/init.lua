local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local extras = require("luasnip.extras")
local conds = require("luasnip.extras.expand_conditions")

local MATH_NODES = {
  displayed_equation = true,
  inline_formula = true,
  math_environment = true,
  latex_block = true,
}

local TEXT_NODES = {
  -- text_mode = true,
  -- TODO: which one of these breaks when comments are present?
  -- label_definition = true,
  -- label_reference = true,
}

-- Function to check if cursor is inside a LaTeX math block in markdown
local function in_latex_math_block()
    local captures = vim.treesitter.get_captures_at_cursor()
    for _, capture in ipairs(captures) do
      if capture == "markup.math" then
        return true
      end
    end
  return false
end

-- Create the snippet
return require("math_snips")(in_latex_math_block)
