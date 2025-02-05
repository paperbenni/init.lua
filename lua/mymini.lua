-- local potato = require("mypotato")
-- if not potato then
--     local miniclue = require("mini.clue")
--     miniclue.setup({
--         -- Leader triggers
--         triggers = {
--             { mode = 'n', keys = '<Leader>' },
--             { mode = 'x', keys = '<Leader>' },
--         },
--     })
-- end

require("mini.git").setup({})
require("mini.tabline").setup({})
require("mini.icons").setup({})
-- files
local files = require("mini.files")

files.setup({ })
vim.keymap.set("n", "<leader>e", function()
    files.open()
end)


local statusline = require("mini.statusline")
statusline.setup()
