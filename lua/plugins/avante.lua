return {
    "yetone/avante.nvim",
    -- enabled = true,
    version = false,
    enabled = false,
    event = "VeryLazy",
    dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
    },
    build = "make",
    -- config = function()
    --     vim.opt.laststatus = 3
    --     require(avante).set
    -- end,
    opts = {
        provider = "ollama",
        ollama = {
          model = "smollm2:135m",
        }
    }
}
