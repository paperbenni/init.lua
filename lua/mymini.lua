require("mini.sessions").setup({})
require("mini.git").setup({})
require("mini.tabline").setup({})
require("mini.icons").setup({})

local miniclue = require("mini.clue")
local potato = require("mypotato")

-- if not potato then
    miniclue.setup({
        triggers = {
        -- leader
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },
            -- go
            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },
            -- folding
            { mode = 'n', keys = 'z' },
            { mode = 'x', keys = 'z' },
            -- marks
            { mode = 'n', keys = "'" },
            { mode = 'n', keys = '`' },
            { mode = 'x', keys = "'" },
            { mode = 'x', keys = '`' },
        },
        clues = {
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.z(),
            miniclue.gen_clues.marks(),
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
