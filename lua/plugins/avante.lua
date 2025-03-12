return {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
    },
    build = "make",
    config = function()
        vim.opt.laststatus = 3
    end,
    opts = {
        provider = "ollama",
        ollama = {
            endpoint = "http://127.0.0.1:11434",
            model = "qwen2.5-coder:0.5b",
        }
    }
}
