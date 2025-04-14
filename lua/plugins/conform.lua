return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            rust = { "rustfmt", lsp_format = "fallback" },
            sh = { "shfmt", lsp_format = "fallback" },
        },
    },
    keys = {
        { "<leader>F", function()
            require 'conform'.format()
        end
        },
    },
}
