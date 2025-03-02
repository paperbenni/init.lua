require("mason").setup()
require("mason-lspconfig").setup()

local potato = require('mypotato')

if not potato
then
    require "fidget".setup {}
end

local capabilities = require(My_completion_engine)

-- print(vim.inspect(capabilities))


-- iterate over lsp servers




-- lspconfig.tailwindcss.setup {
--     capabilities = capabilities,
--     on_attach = on_attach,
--     filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "django-html", "htmldjango", "edge", "eelixir",
--         "elixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade",
--         "leaf", "liquid", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss",
--         "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript",
--         "typescriptreact", "vue", "svelte" }
-- }



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
