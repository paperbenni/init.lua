require("mason").setup()
require("mason-lspconfig").setup()
local navbuddy

local potato = require('mypotato')

if not potato
then
    require "fidget".setup {}
    navbuddy = require("nvim-navbuddy")
end

local capabilities = require(My_completion_engine)

-- print(vim.inspect(capabilities))

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    if not potato
    then
        navbuddy.attach(client, bufnr)
    end
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader><F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>x', vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, bufopts)
    vim.keymap.set('n', '<space>N', require("nvim-navbuddy").open, bufopts)
end
local lspconfig = require 'lspconfig'



lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function()
        return vim.fn.getcwd()
    end,
}

lspconfig.bashls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

lspconfig.sqlls.setup{
    capabilities = capabilities,
    on_attach = on_attach
}

lspconfig.jdtls.setup{
    capabilities = capabilities,
    on_attach = on_attach
}

-- lspconfig.tailwindcss.setup {
--     capabilities = capabilities,
--     on_attach = on_attach,
--     filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "django-html", "htmldjango", "edge", "eelixir",
--         "elixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade",
--         "leaf", "liquid", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss",
--         "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript",
--         "typescriptreact", "vue", "svelte" }
-- }

lspconfig.svelte.setup{
    capabilities = capabilities,
    on_attach = on_attach
}

lspconfig.gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

lspconfig.texlab.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

if not potato
then
    lspconfig.volar.setup {
        capabilities = capabilities,
        on_attach = on_attach
    }
    lspconfig.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
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
    lspconfig.emmet_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "html", "vue", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "eruby" }
    }


    -- fancy rust config with more stuff like debugging
    local rt = require("rust-tools")
    rt.setup({
        server = {
            on_attach = on_attach,
        },
    })


    -- local ltxpaths = {
    --     vim.fn.stdpath("config") .. "/spell/ltex.dictionary.en-US.txt",
    --     vim.fn.expand("%:p:h") .. "/.vscode/ltex.dictionary.en-US.txt",
    -- }

    -- local words = {}
    -- for _, path in ipairs(ltxpaths) do
    --     local f = io.open(path)
    --     if f then
    --         for word in f:lines() do
    --             table.insert(words, word)
    --         end
    --         f:close()
    --     end
    -- end

    -- lspconfig.ltex.setup {
    --     capabilities = capabilities,
    --     on_attach = on_attach,
    --     settings = {
    --         ltex = {
    --             dictionary = {
    --                 ['en-US'] = words,
    --                 ['en-GB'] = words,
    --             },
    --         },
    --     }
    -- }
else
    lspconfig.rust_analyzer.setup {
        on_attach = on_attach,
        capabilities = capabilities
    }

end

-- lspconfig.tsserver.setup{
--     capabilities = capabilities,
--     on_attach = on_attach
-- }

-- lspconfig.html.setup{
--     capabilities = capabilities,
--     on_attach = on_attach
-- }

-- lspconfig.astro.setup{
--     capabilities = capabilities,
--     on_attach = on_attach

-- }
