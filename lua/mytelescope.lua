local tactions = require("telescope.actions")
local potato = require("mypotato")


require('telescope').setup({
    extensions = {
        fzf = {
            fuzzy = true,               -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case",   -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    },
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = tactions.close,
            }
        }
    }
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('zoxide')

vim.cmd([[
nnoremap <leader><SPACE> <cmd>Telescope find_files<cr>
nnoremap <leader>l <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>
nnoremap <leader>tr <cmd>Telescope lsp_references<cr>
nnoremap <leader>ts <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>tz <cmd>Telescope zoxide list<cr>
nnoremap <leader>r <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>tq <cmd>Telescope quickfix<cr>
]])
