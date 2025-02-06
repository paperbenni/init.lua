require("mini.sessions").setup({})
require("mini.git").setup({})
require("mini.tabline").setup({})
require("mini.icons").setup({})

local miniclue = require("mini.clue")
local potato = require("mypotato")

if not potato then
    miniclue.setup({
        triggers = {
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },
        },
        clues = {
            miniclue.gen_clues.builtin_completion(),
        }
    })
end

-- files
local files = require("mini.files")

files.setup({})
vim.keymap.set("n", "<leader>e", function()
    files.open()
end, { desc = "File explorer" })


local statusline = require("mini.statusline")
statusline.setup()
