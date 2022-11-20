require('plugins')
require('impatient')


vim.cmd([[

set inccommand=split
" somehow works in tmux now...
if has("termguicolors")
        set termguicolors
endif



let mapleader = " "
map <SPACE> <leader>

set ignorecase
set tabstop=4 shiftwidth=4 expandtab

set guifont=FiraCode\ Nerd\ Font\ Mono:h13
set encoding=UTF-8

set hidden

command Explore :NvimTreeToggle
command! Lighttheme colorscheme tokyonight-day | set background=light

map <SPACE> <leader>
nnoremap <leader>a :Startify<CR>
nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>f :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>g :Gcd<CR>
nnoremap <leader>n :tabnew<CR>

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

let g:neovide_cursor_vfx_mode = "sonicboom"

]])

local opt = vim.opt

opt.number  = true
opt.lazyredraw  = true
opt.cursorline  = true
opt.relativenumber = true
opt.smartcase = true

opt.hidden = true

opt.inccommand = "split"
opt.mouse = "a"
opt.scrolloff = 6
opt.foldenable = false


opt.list = true
opt.listchars:append "eol:↴"

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true
}


require 'nvim-treesitter.configs'.setup { highlight = { enable = true } }



-- require 'mycmp'
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'mytelescope'
require'mylsp'

vim.cmd([[
    let g:coq_settings = { 'display': { 'pum.kind_context': [' |', '|'], 'icons.mode': 'short', 'pum.source_context': [' ', ' '] } }
]])

require'mywiki'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


require("nvim-tree").setup()
require("nvim-autopairs").setup {}


require 'bufferline'.setup {}
require('lualine').setup {
    options = {
        theme = 'onedark',
        icons_enabled = true
    }
}

vim.cmd "colorscheme onedark"

vim.cmd "COQnow --shut-up"
