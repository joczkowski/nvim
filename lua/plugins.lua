local use = require('packer').use

-- PACKER
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'preservim/nerdtree'
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-surround'
  use 'tanvirtin/monokai.nvim'
  use 'projekt0n/github-nvim-theme'
  use 'alexghergh/nvim-tmux-navigation'
  use 'github/copilot.vim'
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'
  use 'terrortylor/nvim-comment'
  require('nvim_comment').setup()
  use 'nvim-treesitter/nvim-treesitter'
  use 'EdenEast/nightfox.nvim'
  use 'vim-crystal/vim-crystal'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'ThePrimeagen/harpoon'
  use 'ray-x/guihua.lua'
  use 'mfussenegger/nvim-dap'
  use 'leoluz/nvim-dap-go'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'slime-lang/vim-slime-syntax'
  use 'airblade/vim-gitgutter'
  use 'preservim/vimux'
  use 'ellisonleao/gruvbox.nvim'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'tpope/vim-fugitive'
  use { "ibhagwan/fzf-lua", requires = { "nvim-tree/nvim-web-devicons" } }
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  use { "mhanberg/elixir.nvim", requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" }}
  use { 'bluz71/vim-moonfly-colors', branch = 'cterm-compat' }
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons', config = function() require('trouble').setup {} end }
  use { 'ggandor/lightspeed.nvim', keys = { "s", "S", "f", "F", "t", "T" }, config = function() require("lightspeed").setup({ repeat_ft_with_target_char = true }) end }
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }
end)
