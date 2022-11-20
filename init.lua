require('plugins')
require('impatient')


vim.cmd([[

set number
set mouse=a
let mapleader = " "
map <SPACE> <leader>

set tabline
set cursorline
set relativenumber
set smartcase
set ignorecase
set scrolloff=6
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

function! VimwikiLinkHandler(link)
  if a:link =~# '^txt:'
    try
      " chop off the leading file: - see :h expr-[:] for syntax:
      execute ':split ' . a:link[4:]
      return 1
    catch
      echo "Failed opening file in vim."
    endtry
  endif
  return 0
endfunction

]])



require 'nvim-treesitter.configs'.setup { highlight = { enable = true } }

-- require 'mycmp'
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'mytelescope'
require'mylsp'

require('neoscroll').setup()

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


require("nvim-tree").setup()

require 'bufferline'.setup {}
require('lualine').setup {
    options = {
        theme = 'tokyonight',
        icons_enabled = true
    }
}

vim.opt.termguicolors = true
vim.cmd "colorscheme tokyonight"

vim.cmd "COQnow --shut-up"
