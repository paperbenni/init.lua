require("mini.sessions").setup({})
require("mini.git").setup({})
require("mini.tabline").setup({})
require("mini.icons").setup({})

local miniclue = require("mini.clue")
local potato = require("mypotato")

-- if not potato then
    miniclue.setup({
        triggers = {
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },
            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },
        },
        clues = {
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
        }
    })
-- end

if potato then
    require("mini.notify").setup({})
end

-- files
local files = require("mini.files")

require("mini.pairs").setup({})
require("mini.surround").setup({
    mappings = {
        add = "S",
        delete = "ds",
        replace = "cs",
    },
})

files.setup({})
vim.keymap.set("n", "<leader>e", function()
    files.open()
end, { desc = "File explorer" })


local statusline = require("mini.statusline")
statusline.setup()
