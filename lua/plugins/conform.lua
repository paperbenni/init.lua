return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            rust = { "rustfmt", lsp_format = "fallback" },
            sh = { "shfmt", lsp_format = "fallback" },
            cpp = { "clang-format" },
        },
    },
    keys = {
        { "<leader>F", function()
            require 'conform'.format()
        end
        },
    },
}
