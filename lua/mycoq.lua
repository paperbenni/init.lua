vim.g.coq_settings = {
    -- keymap = {
    --     pre_select = true
    -- },
    -- clients = {
    --     tabnine = {
    --         enabled = true
    --     }
    -- },
    display = {
        ["icons.mode"] = 'short',
        pum = {
            kind_context = { '│', '│' },
            source_context = { '', '' }
        }
    }
}

local capabilities =
require 'coq'.lsp_ensure_capabilities()

return capabilities
