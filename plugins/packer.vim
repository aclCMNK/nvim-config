lua << EOF

print(vim.fn.stdpath('data'))
-- Function to check if a plugin is installed
local function packer_install_if_missing(name)
    local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/'..name
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.cmd('!git clone https://github.com/'..name..' '..install_path)
        vim.cmd('packadd '..name)
        print('Plugin "'..name..'" installed automatically.')
    end
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
-- Packer can manage itself
    use 'wbthomason/packer.nvim'

-- General plugins
    use {'kyazdani42/nvim-web-devicons'}
    use { 'nvim-lua/plenary.nvim' }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.2' }
	use { 'fannheyward/telescope-coc.nvim' }
    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }
    use 'nvim-telescope/telescope-project.nvim'
    use { 'nvim-tree/nvim-tree.lua' }
    use 'gaborvecsei/memento.nvim'
    use 'natecraddock/workspaces.nvim'
    use { 'ThePrimeagen/harpoon' }
    use { 'j-morano/buffer_manager.nvim' }
    use { "numToStr/FTerm.nvim" }
    use { 'm-demare/hlargs.nvim' }
    use { "AckslD/nvim-neoclip.lua",
        requires = {
            {'nvim-telescope/telescope.nvim'},
            {'ibhagwan/fzf-lua'},
        }
    }
    use { "folke/which-key.nvim" }
    use { "gen740/SmoothCursor.nvim" }
    use { 'terryma/vim-multiple-cursors' }
    use { 'gelguy/wilder.nvim' }
    use { "shortcuts/no-neck-pain.nvim", tag = "*" }
    use { "lukas-reineke/indent-blankline.nvim" }
	use { 'charludo/projectmgr.nvim' }

 --GIT
    use { 'tpope/vim-fugitive' }
    use {
        'tanvirtin/vgit.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

--lsp
    use { 'neovim/nvim-lspconfig' }
    use { 'simrat39/symbols-outline.nvim' }
--[[lsp
    use { 'neovim/nvim-lspconfig' }
    use { 'kabouzeid/nvim-lspinstall' }  -- Optional: makes installing LSP servers easier
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/nvim-compe' }  -- Optional: for autocompletion support
    use { 'onsails/lspkind-nvim' }
    use {
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup {}
        end
    }
    use {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
        end,
    }
    use { 'simrat39/symbols-outline.nvim' }
    use {
        "SmiteshP/nvim-navbuddy",
        requires = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
            "numToStr/Comment.nvim",        -- Optional
            "nvim-telescope/telescope.nvim" -- Optional
        }
    }
    use 'nanotee/nvim-lsp-basics'
    use {
        "jinzhongjia/LspUI.nvim"
    }
    use { "lukas-reineke/lsp-format.nvim" }

-- Diagnostics
    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    })
--]]

-- Colorschemes
    use { 'tiagovla/tokyodark.nvim'}
    use { 'folke/lsp-colors.nvim' }
    use { 'norcalli/nvim-colorizer.lua' }
    use {'nxvu699134/vn-night.nvim'}
    use { 'rose-pine/neovim', as = 'rose-pine' }
    use { 'fenetikm/falcon' }
    use { 'yashguptaz/calvera-dark.nvim' }
    use { 'sainnhe/gruvbox-material' }
    use { 'sainnhe/sonokai' }
    use { 'sainnhe/everforest' }
    use { 'nyoom-engineering/oxocarbon.nvim' }
    use { "bluz71/vim-nightfly-colors", as = "nightfly" }
    use { 'marko-cerovac/material.nvim' }

-- Statuslines and Tablines
    use { "b0o/incline.nvim" }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }

-- Startups
    use {
        "startup-nvim/startup.nvim",
        requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    }
	--use { 'glepnir/dashboard-nvim' }

-- CursorStyles
    use { 'xiyaowong/nvim-cursorword' }

end)
EOF

source $HOME/.config/nvim/plugins/config/colorschemes-config.vim
source $HOME/.config/nvim/plugins/config/nvimtree-config.vim
source $HOME/.config/nvim/plugins/config/telescope-config.vim
source $HOME/.config/nvim/plugins/config/treesitter-config.vim
source $HOME/.config/nvim/plugins/config/incline-config.vim
source $HOME/.config/nvim/plugins/config/evil-lualine-config.vim
source $HOME/.config/nvim/plugins/config/bufferline-config.vim
source $HOME/.config/nvim/plugins/config/startup-config.vim
source $HOME/.config/nvim/plugins/config/cursorword-config.vim
source $HOME/.config/nvim/plugins/config/memento-config.vim
source $HOME/.config/nvim/plugins/config/workspaces-config.vim
source $HOME/.config/nvim/plugins/config/buffer-manager-config.vim
source $HOME/.config/nvim/plugins/config/vgit-config.vim
source $HOME/.config/nvim/plugins/config/fterm-config.vim
source $HOME/.config/nvim/plugins/config/hlargs-config.vim
source $HOME/.config/nvim/plugins/config/neoclip-config.vim
source $HOME/.config/nvim/plugins/config/which-key-config.vim
source $HOME/.config/nvim/plugins/config/SmoothCursor-config.vim
source $HOME/.config/nvim/plugins/config/multiple-cursors-config.vim
source $HOME/.config/nvim/plugins/config/wilder-config.vim
source $HOME/.config/nvim/plugins/config/no-neck-pain-config.vim
source $HOME/.config/nvim/plugins/config/indent-blankline-config.vim
"source $HOME/.config/nvim/plugins/config/dashboard-nvim.vim

"source $HOME/.config/nvim/plugins/config/navbuddy-config.vim
"source $HOME/.config/nvim/plugins/config/lsplines-config.vim

"
"LSP Plugins config
source $HOME/.config/nvim/plugins/config/lspconfig-config.vim
"source $HOME/.config/nvim/plugins/config/lsp-basics-config.vim
"source $HOME/.config/nvim/plugins/config/lspUI-config.vim
"source $HOME/.config/nvim/plugins/config/goto-preview-config.vim
"source $HOME/.config/nvim/plugins/config/inc-rename-config.vim
source $HOME/.config/nvim/plugins/config/symbols-outline-config.vim
"
