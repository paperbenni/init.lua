local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local potato = require("mypotato")

if potato then
    My_completion_engine = "mycoq"
else
    My_completion_engine = "mycmp"
end

require("lazy").setup({

    "tpope/vim-commentary",
    {

        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        enabled = not potato
    },
    "tpope/vim-fugitive",
    "tpope/vim-eunuch",
    "tpope/vim-surround",
    "tpope/vim-repeat",

    { "folke/zen-mode.nvim",   opts = {} },

    "lukas-reineke/indent-blankline.nvim",
    "mattn/emmet-vim",
    "sbdchd/neoformat",

    -- TODO: more lazy loading
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-ui",

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "vimwiki/vimwiki",
        lazy = false,
        branch = "dev",
        module = false,
        init = function()
            require("mywiki")
        end,
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim" },
        lazy = false,
        version = "*", -- Pin Neorg to the latest stable release
        config = true,
        enabled = not potato
    },

    "paperbenni/Calendar.vim",
    { "michal-h21/vim-zettel", event = "BufRead *.md" },

    { "lervag/vimtex",         event = "BufRead *.tex" },

    "mhinz/vim-startify",

    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' }
    },

    "nvim-treesitter/nvim-treesitter",

    { "catppuccin/nvim",   name = "catppuccin" },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        -- or                              , branch = '0.1.x',
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            { "jvgrootveld/telescope-zoxide", enabled = not potato },
        },
    },

    { "j-hui/fidget.nvim",  enabled = not potato },
    {
        "folke/which-key.nvim",
        enabled = not potato,
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {

                -- on_attach = on_tree_attach,
                view = {
                    mappings = {
                        list = {
                            { key = "l", action = "edit" }
                        }
                    }
                },
                update_focused_file = {
                    enable = true,
                    update_root = true,

                },
                renderer = {
                    indent_markers = {
                        enable = true
                    }
                }

            }
        end,
    },

    "akinsho/bufferline.nvim",
    "hoob3rt/lualine.nvim",
    "windwp/nvim-autopairs",

    {
        "hrsh7th/nvim-cmp",
        enabled = not potato,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "ray-x/cmp-treesitter",
            "rafamadriz/friendly-snippets",
            { "L3MON4D3/LuaSnip", tag = "v1.2.1" },
            "saadparwaiz1/cmp_luasnip",
        },
    },
    {
        "ms-jpq/coq_nvim",
        enabled = potato,
        dependencies = {
            { "ms-jpq/coq.artifacts",  branch = "artifacts" },
            { "ms-jpq/coq.thirdparty", branch = "3p" },
        },
    },

    {
        "SmiteshP/nvim-navbuddy",
        enabled = not potato,
        dependencies = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
        },
    },

    { "github/copilot.vim",            enabled = not potato },

    { "xiyaowong/nvim-transparent" },
    { "norcalli/nvim-colorizer.lua",   enabled = not potato },
    { "psliwka/vim-smoothie",          enabled = not potato },
    { "machakann/vim-highlightedyank", enabled = not potato },
    { "lewis6991/gitsigns.nvim",       enabled = not potato },
    { "ray-x/lsp_signature.nvim",      enabled = not potato },

    { "mfussenegger/nvim-dap",         enabled = not potato },
    { "rcarriga/nvim-dap-ui",          enabled = not potato },
    {
        "simrat39/rust-tools.nvim",
        enabled = not potato,
        event = "BufRead *.rs",
    },
    { "mfussenegger/nvim-dap-python", enabled = not potato },
})
