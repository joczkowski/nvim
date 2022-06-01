-- custom mappings

vim.g.mapleader = ' '

vim.cmd([[
  set relativenumber
  set number
  set noswapfile
  set hidden
  set smarttab
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set hlsearch
  set timeoutlen=1000
  set ttimeoutlen=0
  set signcolumn=yes
  colorscheme nightfox
  set cursorline

  vnoremap <F8> "xy :%s/<C-R>x/

  function! HideTab()
    set nonumber
    set norelativenumber
    set signcolumn=no
  endfunction

  function! ShowTab()
    set number
    set relativenumber
    set signcolumn=yes
  endfunction

  nnoremap <F2> :saveas %:p:h/
  nnoremap <F9> :call HideTab()<cr>
  nnoremap <F10> :call ShowTab()<cr>
]])

-- switch two buffers
vim.api.nvim_set_keymap('n', '<Leader><Leader>', ':b#<CR>', { noremap = true, silent = true })

-- search mappings
vim.keymap.set('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>a', "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gg', "<cmd>lua require('fzf-lua').git_status()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '\\', "<cmd>lua require('fzf-lua').live_grep()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', "<cmd>lua require('fzf-lua').grep_cword()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', '<leader>j', "<cmd>lua require('fzf-lua').grep_visual()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-n>', "<cmd>NERDTreeToggle<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rl', '<cmd>call VimuxRunCommand("clear; bundle exec rspec " . bufname("%") . ":" . line("."))<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rb', '<cmd>call VimuxRunCommand("clear; bundle exec rspec " . bufname("%"))<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>td', '<cmd>e ~/todo.org<CR>', { silent = true, noremap = true })

-- display lsp diagnostic float window
vim.keymap.set('n', '<Leader>e', "<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>", { noremap = true, silent = true })

-- code action
vim.keymap.set('n', '<Leader>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)

local use = require('packer').use

-- PACKER
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  use 'preservim/nerdtree'

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

  use "projekt0n/github-nvim-theme"
  use({
    "aserowy/tmux.nvim",
    keys = { "<C-j>", "<C-k>", "<C-h>", "<C-l>" },
    config = [[require('config.tmux')]],
  })

  use "williamboman/nvim-lsp-installer"
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
      }
    end
  }

  use({
    "tpope/vim-fugitive",
  })
  use 'airblade/vim-gitgutter'

  use 'preservim/vimux'

  use { "ellisonleao/gruvbox.nvim" }

  use { 'simrat39/rust-tools.nvim' }
end)

local cmp = require'cmp'

cmp.setup{
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user
    end,
  },                                                                                                                                                                                                                                                                             
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' }
  },                                                                                                                                                                                                                                                                             
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ["<C-j>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif has_words_before() then
        cmp.complete()
      end
    end, { "i", "s" }),
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  }
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.diagnostic.config({
  virtual_text = false
})

function on_attach_lsp() 
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, {buffer=0})
end

local lsp = require 'lspconfig'

lsp.solargraph.setup{
  capabilities = capabilities,
  root_dir = lsp.util.root_pattern(".git"),
  cmd = { "solargraph", "stdio" },
  settings = { solargraph = { useBundler = true } },
  on_attach = on_attach_lsp
}

lsp.tsserver.setup{
  capabilities = capabilities,
  on_attach = on_attach_lsp
}

lsp.eslint.setup{
  on_attach = on_attach_lsp
}

lsp.rls.setup{
  on_attach = on_attach_lsp
}

lsp.rust_analyzer.setup{
  on_attach = on_attach_lsp
}

lsp.csharp_ls.setup{
  capabilities = capabilities,
  on_attach = on_attach_lsp
}

require("fzf-lua").setup {
  winopts = { 
    preview = { 
      layout = 'vertical'
    }
  },
}

require("nvim-lsp-installer").setup {}

require('nvim-treesitter.configs').setup{
  ensure_installed = { "elixir", "ruby", "javascript", "typescript" },
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
