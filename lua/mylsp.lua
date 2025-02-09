require("mason").setup()
require("mason-lspconfig").setup()

local potato = require('mypotato')

if not potato
then
    require "fidget".setup {}
end

local capabilities = require(My_completion_engine)

-- print(vim.inspect(capabilities))

local on_attach = function(client, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    local function setkey(mode, key, func, description)
        vim.keymap.set(mode, key, func, { noremap = true, silent = true, buffer = bufnr, desc = description })
    end

    setkey('n', 'gD', vim.lsp.buf.declaration, "Go to declaration")
    setkey('n', 'gd', vim.lsp.buf.definition, "Go to definition")
    setkey('n', 'K', vim.lsp.buf.hover, "Show hover")
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)

    setkey('n', '<leader><F2>', vim.lsp.buf.rename, "Rename")
    setkey('n', '<leader>x', vim.lsp.buf.code_action, "Code Action")
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    setkey('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, 'LSP Format buffer')
end
local lspconfig = require 'lspconfig'

-- iterate over lsp servers
local servers = {
    lspconfig.clangd,
    lspconfig.ts_ls,
    lspconfig.bashls,
    lspconfig.sqlls,
    lspconfig.terraformls,
    lspconfig.jdtls,
    lspconfig.cssls,
    lspconfig.svelte,
    lspconfig.gopls,
    lspconfig.texlab,
    -- lspconfig.ltex,
    lspconfig.rust_analyzer,
    -- lspconfig.html,
    -- lspconfig.astro,
}

for _, server in ipairs(servers) do
    server.setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end



lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function()
        return vim.fn.getcwd()
    end,
}

lspconfig.yamlls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/canonical/cloud-init/main/cloudinit/config/schemas/versions.schema.cloud-config.json"] = "user-data.yml"
            }
        }
    }
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

lspconfig.svelte.setup {
    capabilities = capabilities,
    on_attach = on_attach
}


if not potato
then
    lspconfig.volar.setup {
        capabilities = capabilities,
        on_attach = on_attach
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
end

-- lspconfig.html.setup{
--     capabilities = capabilities,
--     on_attach = on_attach
-- }

-- lspconfig.astro.setup{
--     capabilities = capabilities,
--     on_attach = on_attach

-- }
