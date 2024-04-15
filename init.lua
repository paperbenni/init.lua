require('plugins')
-- vim.loader.enable()

local potato = require('mypotato')
vim.g.mapleader = " "

vim.api.nvim_create_user_command(
    'Debug',
    ":lua require'mydap'",
    { nargs = 0 }
)

vim.cmd([[

" somehow works in tmux now...
if has("termguicolors")
        set termguicolors
endif


set tabstop=4 shiftwidth=4 expandtab

set guifont=FiraCode\ Nerd\ Font\ Mono:h11
set encoding=UTF-8

set colorcolumn=80

" command Explore :NvimTreeToggle
command! Lighttheme colorscheme catppuccin-latte | set background=light

command! Cal Calendar | vertical resize +20

nnoremap <leader>a :Startify<CR>
nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>f :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>g :Gcd<CR>
nnoremap <leader>n :tabnew<CR>

nnoremap <leader>vn :cnext<CR>
nnoremap <leader>vp :cprevious<CR>

noremap glk <Plug>VimwikiToggleListItem

" additional mode switching

inoremap <special> kj <ESC>
inoremap <special> jk <ESC>:
tnoremap <special> jk <C-\><C-n>

" move line up/down with alt j/k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap <leader>ww <Plug>VimwikiIndex
nnoremap <leader>wt <Plug>VimwikiTabIndex
nnoremap <leader>wi <Plug>VimwikiDiaryIndex
nnoremap <leader>w<leader>w <Plug>VimwikiMakeDiaryNote
nnoremap <leader>w<leader>y <Plug>VimwikiMakeYesterdayDiaryNote
nnoremap <leader>w<leader>m <Plug>VimwikiMakeTomorrowDiaryNote
autocmd FileType markdown nnoremap <buffer> <C-Space> <Plug>VimwikiToggleListItem

let g:neovide_cursor_vfx_mode = "sonicboom"
" let g:user_emmet_expandabbr_key = '<C-,>'

]])

local opt          = vim.opt

opt.number         = true
opt.lazyredraw     = true
opt.cursorline     = true
opt.relativenumber = true
opt.ignorecase     = true
opt.smartcase      = true

opt.hidden         = true

opt.inccommand     = "split"
opt.mouse          = "a"
opt.scrolloff      = 6
opt.foldenable     = false

opt.foldmethod     = "expr"
opt.foldexpr       = "nvim_treesitter#foldexpr()"

-- require("indent_blankline").setup {
--     -- for example, context is off by default, use this to turn it on
--     show_current_context = true,
--     show_current_context_start = true,
-- }


require 'nvim-treesitter.configs'.setup { highlight = { enable = true } }
-- require("hardtime").setup()


if not potato
then
    require('gitsigns').setup()
    require("which-key").setup()
    require("colorizer").setup()
    require 'mycopilot'
    require 'myharpoon'

    -- this one is mostly annoying
    -- require "lsp_signature".setup()
end


require 'mytelescope'
require 'mylsp'

require 'myneovide'




vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- l to expand tree item
-- local on_tree_attach = function(_, bufnr)
--     local bufopts = { noremap = true, silent = true, buffer = bufnr }
--     local nt_api = require 'nvim-tree.api'
--     vim.keymap.set('n', 'l', nt_api.node.open.edit, bufopts)
-- end

require("nvim-autopairs").setup {}

require 'bufferline'.setup {}

local mytheme = require('themes.catppuccin')

require('lualine').setup {
    options = {
        theme = mytheme.lualinetheme,
        icons_enabled = true
    }
}

vim.cmd("colorscheme " .. mytheme.vimtheme)

if My_completion_engine == "mycoq"
then
    vim.cmd "COQnow --shut-up"
end
