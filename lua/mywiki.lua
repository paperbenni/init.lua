vim.cmd([[

let g:vimwiki_filetypes = ['markdown']
let g:vimwiki_markdown_link_ext=0
let wiki = {}
let wiki.path = '~/wiki/vimwiki'
let wiki.syntax = 'markdown'
let wiki.ext = '.md'
let wiki.automatic_nested_syntaxes = 1

let streamwiki = {}
let streamwiki.path = '~/streamwiki/vimwiki'
let streamwiki.automatic_nested_syntaxes = 1


let g:vimwiki_conceal_pre = 1
let g:vimwiki_list = [wiki, streamwiki] " wikilistmarker


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

let g:zettel_format = "%y%m%d-%H%M-%title"

]])

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        -- Enable wrapping
        vim.opt_local.wrap = true

        -- Set text width to 80 characters
        vim.opt_local.textwidth = 80

        -- Optionally, if you want soft line breaks at 80 characters but no hard break:
        vim.opt_local.linebreak = true
    end,
})
