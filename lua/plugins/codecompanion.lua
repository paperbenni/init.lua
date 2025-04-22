return {
    "olimorris/codecompanion.nvim",
    -- enabled = false,
    opts = {},
    -- config = function ()
    --     vim.opt.laststatus = 3
    -- end,
    cmd = {
        "CodeCompanion",
        "CodeCompanionChat",
        "CodeCompanionActions",
        "CodeCompanionCmd"
    },
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    }
}
