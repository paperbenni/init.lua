local mytheme = require('themes.catppuccin')
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

-- My_completion_engine = "mycoq"
-- My_completion_engine = "mycmp"
My_completion_engine = "myblink"




require("lazy").setup({
    {
        "folke/snacks.nvim",
        lazy = false,
        priority = 1000,
        ---@type snacks.Config
        opts = {
            indent = { enabled = true },
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            -- TODO: change easing
            scroll =  { enabled = not potato },
            input = { enabled = true },
            scratch = { enabled = true },
            quickfile = { enabled = true },
            lazygit = { enabled = true },
        },
        keys = {
                { "<leader>G", function() Snacks.lazygit() end, desc = "Lazygit" },
        --     { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        --     { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        }
    },

    {

        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        enabled = not potato
    },
    {
        "Vigemus/iron.nvim",
        cmd = "IronRepl",
        config = function()
            require("myiron")
        end
    },
    "tpope/vim-eunuch",
    "tpope/vim-surround",
    { "tpope/vim-repeat",   event = "VeryLazy" },
    -- { "mattn/emmet-vim" , event = "InsertEnter"},
    { "sbdchd/neoformat", cmd = "Neoformat" },

    { "tpope/vim-dadbod", cmd = { "DB", "DBUI" } },
    { "kristijanhusak/vim-dadbod-ui", cmd = "DBUI" },

    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
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
        "nvim-neorg/neorg",
        lazy = false,
        version = "*", -- Pin Neorg to the latest stable release
        config = true,
        enabled = not potato
    },
    { "paperbenni/Calendar.vim", cmd = { "Calendar", "CalendarH", "CalendarT" } },
    { "michal-h21/vim-zettel", event = "BufRead *.md" },

    { "lervag/vimtex",         event = "BufRead *.tex" },



    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' }
    },
    {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        version = '1.*',
        config = function()
            require 'typst-preview'.setup {}
        end,
    },
    "nvim-treesitter/nvim-treesitter",

    { "catppuccin/nvim",   name = "catppuccin" },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
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

    { "j-hui/fidget.nvim", enabled = not potato },
    {
        "folke/which-key.nvim",
        enabled = not potato,
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = { },
    },
    -- {
    --     "nvim-tree/nvim-tree.lua",
    --     version = "*",
    --     -- enabled = true,
    --     lazy = false,
    --     dependencies = {
    --         "nvim-tree/nvim-web-devicons",
    --     },
    --     opts = {
    --         on_attach = require("mytree"),
    --         update_focused_file = {
    --             enable = true,
    --             update_root = true,
    --
    --         },
    --         renderer = {
    --             indent_markers = {
    --                 enable = true
    --             }
    --         }
    --     },
    -- },
    {
        'echasnovski/mini.nvim',
        version = '*',
        config = function()
            require('mymini')
        end
    },
    -- {
    --     'akinsho/bufferline.nvim',
    --     version = "*",
    --     dependencies = 'nvim-tree/nvim-web-devicons',
    --     config = function()
    --         require('bufferline').setup {}
    --     end
    -- },
    -- {
    --     'nvim-lualine/lualine.nvim',
    --     dependencies = { 'nvim-tree/nvim-web-devicons' },
    --     config = function()
    --         require('lualine').setup {
    --             options = {
    --                 theme = mytheme.lualinetheme,
    --                 icons_enabled = true
    --             }
    --         }
    --     end
    -- },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    {
        "hrsh7th/nvim-cmp",
        enabled = (My_completion_engine == "mycmp"),
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "ray-x/cmp-treesitter",
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
        },
    },
    {
        "ms-jpq/coq_nvim",
        enabled = (My_completion_engine == "mycoq"),
        dependencies = {
            { "ms-jpq/coq.artifacts",  branch = "artifacts" },
            { "ms-jpq/coq.thirdparty", branch = "3p" },
        },
    },
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = "make install_jsregexp",
        config = function()
            require("myluasnip")
        end
    },
    {
        "saghen/blink.cmp",
        enabled = (My_completion_engine == "myblink"),
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        version = "*",
        --@module 'blink.cmp'
        --@type blink.cmp.config
        opts = {
            snippets = { preset = 'luasnip' },
            keymap = {
                preset = 'default',
                ['<Tab>'] = {
                    function(cmp)
                        if cmp.snippet_active() then return cmp.accept()
                        else return cmp.select_next() end
                    end,
                    'snippet_forward',
                    'fallback'
                },
                -- ['<CR>'] = { 'accept', 'fallback' },
                -- only enable CR if not on cmdline
                ['<CR>'] = { 'accept', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
                cmdline = {
                    preset = 'none'
                }
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            sources = {
                cmdline = {},
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            signature = { enabled = true },
        },
        opts_extend = { "sources.default" }
    },
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({
                condition = function()
                    local file_path = vim.api.nvim_buf_get_name(0)
                    local filename = vim.fn.expand("%:t")
                    -- TODO: learn lua and do not copy if...return everywhere

                    if file_path:match("^/dev/shm/") then
                        return true
                    end

                    local password_path = vim.fn.expand("~/.password-store")
                    if file_path:match("^" .. vim.fn.escape(password_store_path, "%.") .. "/") then
                        return true
                    end
                    -- Check if the file ends with gpg.txt
                    if file_path:match("%.gpg%.txt$") then
                        return true
                    end
                    -- Check if the file is an SSH key (common SSH key filenames)
                    local ssh_key_patterns = {
                        "id_rsa", "id_dsa", "id_ecdsa", "id_ed25519", "authorized_keys", "known_hosts"
                    }
                    for _, pattern in ipairs(ssh_key_patterns) do
                        if filename == pattern then
                            return true
                        end
                    end
                    -- Check if the file is in the ~/.ssh directory
                    local ssh_dir = vim.fn.expand("~/.ssh")
                    if file_path:match("^" .. vim.fn.escape(ssh_dir, "%.") .. "/") then
                        return true
                    end
                end,
                keymaps = {
                    accept_suggestion = "<C-j>",
                    clear_suggestion = "<C-e>",
                    accept_word = "<C-M-j>",
                }
            })
        end,
    },
    { "xiyaowong/nvim-transparent" , event = "VeryLazy" },
    { "norcalli/nvim-colorizer.lua",   enabled = not potato },
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
