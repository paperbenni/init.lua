require('plugins')


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

command Explore :NvimTreeToggle

map <SPACE> <leader>
nnoremap <leader>a :Startify<CR>
nnoremap <leader>e :NvimTreeToggle<CR>

" additional mode switching

inoremap <special> kj <ESC> 
inoremap <special> jk <ESC>:
tnoremap <special> jk <C-\><C-n>

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

require("mason").setup()
require("mason-lspconfig").setup()

require "fidget".setup {}

require 'nvim-treesitter.configs'.setup { highlight = { enable = true } }

-- require 'mycmp'

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
local coq = require("coq")
local capabilities = coq.lsp_ensure_capabilities()

require 'lspconfig'.rust_analyzer.setup {
    capabilities = capabilities
}
require 'lspconfig'.clangd.setup {
    capabilities = capabilities
}
require 'lspconfig'.pyright.setup {
    capabilities = capabilities
}

require'lspconfig'.bashls.setup{}

require'lspconfig'.volar.setup{
  capabilities = capabilities
}

require 'lspconfig'.sumneko_lua.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("nvim-tree").setup()

vim.cmd "colorscheme tokyonight"

vim.cmd "COQnow --shut-up"
