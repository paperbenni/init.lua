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
  text_mode = true,
  label_definition = true,
  label_reference = true,
}

-- Function to check if cursor is inside a LaTeX math block in markdown
local function in_latex_math_block()
  local node = vim.treesitter.get_node({ ignore_injections = false })
  while node do
    if TEXT_NODES[node:type()] then
      return false
    elseif MATH_NODES[node:type()] then
      return true
    end
    node = node:parent()
  end
  return false
end

-- Create the snippet
return require("math_snips")(in_latex_math_block)
