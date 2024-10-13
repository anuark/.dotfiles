local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- color themes
    -- use {
    --     'catppuccin/nvim',
    --     as = 'catppuccin',
    --     config =  function()
    --         vim.cmd('colorscheme catppuccin')
    --     end
    -- }
    -- use({
    --     'rose-pine/neovim',
    --     as = 'rose-pine',
    --     config = function()
    --         -- vim.cmd('colorscheme rose-pine')
    --     end
    -- })
    -- use({
    --   'Everblush/everblush.nvim',
    --   as = 'everblush',
    --   config = function()
    -- 	  vim.cmd('colorscheme everblush')
    --   end
    -- })
    -- use({
    --   'NLKNguyen/papercolor-theme',
    --   as = 'PaperColor',
    --   config = function()
    -- 	  vim.cmd('colorscheme PaperColor')
    --   end
    -- })
    -- use({
    --   'sainnhe/everforest',
    --   as = 'everforest',
    --   config = function()
    -- 	  -- vim.cmd('colorscheme everforest')
    --   end
    -- })
    -- use 'rafi/awesome-vim-colorschemes'
    -- use {
    --     "cvigilv/patana.nvim",
    --     config = function()
    --         require("patana.nvim").setup()
    --     end,
    -- }
    use({
        "scottmckendry/cyberdream.nvim",
        config = function()
            vim.cmd('colorscheme cyberdream')
        end
    })

    use 'neovim/nvim-lsp'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'ThePrimeagen/harpoon'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'pangloss/vim-javascript'
    use 'maxmellon/vim-jsx-pretty'
    use {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'folke/todo-comments.nvim'
    use { 'akinsho/toggleterm.nvim', tag = 'v2.*' }
    use 'f-person/git-blame.nvim'
    use 'LuaLS/lua-language-server'
    use 'folke/zen-mode.nvim'
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'onsails/lspkind-nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    use {
        'goolord/alpha-nvim',
        requires = { 'echasnovski/mini.icons' },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    }

    require('set')
    require('remap')
    require('plugins')
    require('lsp')

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if ensure_packer() then
        require('packer').sync()
    end
end)
