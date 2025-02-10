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
        opts = require("mysnacks").opts,
        keys = require("mysnacks").keys,
    },
    {
        "Vigemus/iron.nvim",
        cmd = "IronRepl",
        config = function()
            require("myiron")
        end
    },
    "tpope/vim-eunuch",
    { "tpope/vim-repeat",             event = "VeryLazy" },
    -- { "mattn/emmet-vim" , event = "InsertEnter"},
    { "sbdchd/neoformat",             cmd = "Neoformat" },
    { "tpope/vim-dadbod",             cmd = { "DB", "DBUI" } },
    { "kristijanhusak/vim-dadbod-ui", cmd = "DBUI" },

    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            { "<leader>T", "<cmd>Trouble diagnostics toggle", desc = "Trouble Diagnostics" }
        }
    },
    {
        "vimwiki/vimwiki",
        lazy = true,
        branch = "dev",
        module = false,
        init = function()
            require("mywiki")
        end,
        keys = {
            {
              "<leader>ww",
              "<Plug>VimwikiIndex",
              desc = "Open Vimwiki index"
            },
            {
              "<leader>wt",
              "<Plug>VimwikiTabIndex",
              desc = "Open Vimwiki index in new tab"
            },
            {
              "<leader>wi",
              "<Plug>VimwikiDiaryIndex",
              desc = "Open Vimwiki diary index"
            },
            {
              "<leader>w<leader>w",
              "<Plug>VimwikiMakeDiaryNote",
              desc = "Make new diary note"
            },
            {
              "<leader>w<leader>y",
              "<Plug>VimwikiMakeYesterdayDiaryNote",
              desc = "Make diary note for yesterday"
            },
            {
              "<leader>w<leader>m",
              "<Plug>VimwikiMakeTomorrowDiaryNote",
              desc = "Make diary note for tomorrow"
            }
        }
        
    },
    {
        "nvim-neorg/neorg",
        lazy = false,
        version = "*", -- Pin Neorg to the latest stable release
        config = true,
        enabled = not potato
    },
    { "paperbenni/Calendar.vim", cmd = { "Calendar", "CalendarH", "CalendarT" } },
    { "michal-h21/vim-zettel",   event = "BufRead *.md" },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            }
        }
    },

    { "lervag/vimtex",           event = "BufRead *.tex" },



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
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = require("mytreesitter"),
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                integrations = {
                    treesitter = true,
                    mini = true,
                    blink_cmp = true,
                    vimwiki = true,
                    snacks = true,
                    mason = false,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    { "j-hui/fidget.nvim", enabled = not potato },
    {
        'echasnovski/mini.nvim',
        version = '*',
        config = function()
            require('mymini')
        end,
        lazy = false,
        keys = {
            {
                "<leader>s",
                function() MiniSessions.select() end,
                desc = "Select session"
            },
        }
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
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_next()
                        end
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
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lsp = {
                        name = "LSP",
                        module = 'blink.cmp.sources.lsp',
                        opts = {},
                        enabled = true,
                        async = false,
                        timeout_ms = 500,
                        transform_items = nil,
                        should_show_items = true,
                        max_items = 10,
                        min_keyword_length = 1,
                        score_offset = 0,
                        fallbacks = {},
                        override = nil,
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    }
                }
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
    -- lazy.nvim
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            presets = {
                bottom_search = true,
                command_palette = true, -- position the cmdline and popupmenu together
            }
        },
        enabled = not potato,
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
    { "xiyaowong/nvim-transparent",    event = "VeryLazy" },
    { "norcalli/nvim-colorizer.lua",   enabled = not potato },
    { "machakann/vim-highlightedyank", enabled = not potato },
    --TODO: check if this can be replaced by mini or snacks
    { "lewis6991/gitsigns.nvim",       enabled = not potato },
    -- TODO: check if this can be replaced by blink cmp
    -- { "ray-x/lsp_signature.nvim",      enabled = not potato },

    { "mfussenegger/nvim-dap",         enabled = not potato },
    { "rcarriga/nvim-dap-ui",          enabled = not potato },
    {
        "simrat39/rust-tools.nvim",
        enabled = not potato,
        event = "BufRead *.rs",
    },
    { "mfussenegger/nvim-dap-python", enabled = not potato },
})
