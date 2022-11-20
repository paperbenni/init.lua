-- ensure the packer plugin manager is installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()


require('packer').startup(function(use)
    use 'lewis6991/impatient.nvim'
    use 'wbthomason/packer.nvim'

    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'

    use 'lewis6991/gitsigns.nvim'

    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-ui'

    use { 'paperbenni/vimwiki', branch = 'dev' }
    use 'paperbenni/Calendar.vim'
    use 'michal-h21/vim-zettel'
    use 'karb94/neoscroll.nvim'

    use 'lervag/vimtex'

    use 'mhinz/vim-startify'
    use 'machakann/vim-highlightedyank'
    use 'folke/tokyonight.nvim'
    use 'j-hui/fidget.nvim'

    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    use 'nvim-treesitter/nvim-treesitter'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

    -- use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" })
    -- use 'saadparwaiz1/cmp_luasnip'

    use { 'ms-jpq/coq_nvim', branch = 'coq' }
    use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
    use { 'ms-jpq/coq.thirdparty', branch = '3p' }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use 'akinsho/bufferline.nvim'
    use 'hoob3rt/lualine.nvim'

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

end)



-- the first run will install packer and our plugins
if packer_bootstrap then
    require("packer").sync()
    return
end
