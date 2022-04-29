-- custom mappings
vim.g.mapleader = ' '
vim.api.nvim_command('set relativenumber')
vim.api.nvim_command('set noswapfile')
vim.api.nvim_command('set hidden')
vim.api.nvim_command('set smarttab')
vim.api.nvim_command('set tabstop=2')
vim.api.nvim_command('set shiftwidth=2')
vim.api.nvim_command('set expandtab')
vim.api.nvim_command('set hlsearch')
vim.api.nvim_command('vnoremap <F8> "xy :%s/<C-R>x/')
vim.api.nvim_command('colorscheme nightfox')
vim.api.nvim_command('set timeoutlen=1000')
vim.api.nvim_command('set ttimeoutlen=0')
vim.api.nvim_command('set signcolumn=yes')


-- switch two buffers
vim.api.nvim_set_keymap('n', '<Leader><Leader>', ':b#<CR>', { noremap = true, silent = true })

-- search mappings
vim.keymap.set('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ga', "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gg', "<cmd>lua require('fzf-lua').git_status()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>\\', "<cmd>lua require('fzf-lua').live_grep()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', "<cmd>lua require('fzf-lua').grep_cWORD()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', '<leader>j', "<cmd>lua require('fzf-lua').grep_visual()<cr>", { silent = true, noremap = true })


vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)

local use = require('packer').use

require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  use({
    "ggandor/lightspeed.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
    config = function()
      require("lightspeed").setup({
        repeat_ft_with_target_char = true,
      })
    end,
  })

  use { 'ibhagwan/fzf-lua',
  -- optional for icon support
     requires = { 'kyazdani42/nvim-web-devicons' }
  }

  use({
    "aserowy/tmux.nvim",
    keys = { "<C-j>", "<C-k>", "<C-h>", "<C-l>" },
    config = [[require('config.tmux')]],
  })

  use "neovim/nvim-lspconfig"

  use "terrortylor/nvim-comment"
  require('nvim_comment').setup()

  use 'nvim-treesitter/nvim-treesitter'

  use "EdenEast/nightfox.nvim"

  use "lukas-reineke/indent-blankline.nvim"

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use({
    "tpope/vim-fugitive",
  })
  use 'airblade/vim-gitgutter'
end)

local cmp = require'cmp'

cmp.setup{
  snippet = {                                                                                                                                                                                                                                                                    
    expand = function(args)                                                                                                                                                                                                                                                      
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.                                                                                                                                                                                                                  
    end,                                                                                                                                                                                                                                                                         
  },                                                                                                                                                                                                                                                                             
  sources = {                                                                                                                                                                                                                                                                    
    { name = 'nvim_lsp'},                                                                                                                                                                                                                                                        
    -- { name = 'vsnip' },                                                                                                                                                                                                                                                       
    -- { name = 'buffer' }                                                                                                                                                                                                                                                       
  },                                                                                                                                                                                                                                                                             
  mapping = {                                                                                                                                                                                                                                                                    
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),                                                                                                                                                                                                                                     
    ['<C-f>'] = cmp.mapping.scroll_docs(4),                                                                                                                                                                                                                                      
    ['<C-Space>'] = cmp.mapping.complete(),                                                                                                                                                                                                                                      
    ['<C-e>'] = cmp.mapping.close(),                                                                                                                                                                                                                                             
    ['<CR>'] = cmp.mapping.confirm({ select = true }),                                                                                                                                                                                                                           
  },
  completion = {                                                                                                                                                                                                                                                                 
    completeopt = 'menu,menuone,noinsert',                                                                                                                                                                                                                                       
  }                                                                                                                                                                                                                                                                              
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


require('lspconfig').solargraph.setup{
  capabilities = capabilities,
  on_attach = function()
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, {buffer=0})
  end
}

require('lspconfig').tsserver.setup{
  capabilities = capabilities,
  on_attach = function()
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, {buffer=0})
  end
}

require('lspconfig').eslint.setup{
  on_attach = function()
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, {buffer=0})
  end
}

require('nvim-treesitter.configs').setup{
  ensure_installed = { "ruby", "javascript", "typescript" },

  highlight = {
    enable = true,  -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
  indent = {
    enable = false,
  },
  rainbow = {
    enable = true,
  },
incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

require("indent_blankline").setup{
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}
