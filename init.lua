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
  set colorcolumn=80,100
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
vim.keymap.set('n', '<c-P>', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>a', "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gg', "<cmd>lua require('telescope.builtin').git_status()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '\\', "<cmd>lua require('telescope.builtin').grep_string()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua require("telescope.builtin").grep_string()<cr> . "\'" . expand("<cword>")', { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('v', '<leader>j', "<cmd>lua require('telescope.builtin').grep_visual()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-n>', "<cmd>NERDTreeFind<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rl', '<cmd>call VimuxRunCommand("clear; bundle exec rspec " . bufname("%") . ":" . line("."))<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rb', '<cmd>call VimuxRunCommand("clear; bundle exec rspec " . bufname("%"))<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rc', '<cmd>call VimuxRunCommand(@*)<CR>', { silent = true, noremap = true })
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

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

  use({
    "ggandor/lightspeed.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
    config = function()
      require("lightspeed").setup({
        repeat_ft_with_target_char = true,
      })
    end,
  })

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          ruby = { "string" }, 
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0, -- Offset from pattern match
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
    end
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

  use "vim-crystal/vim-crystal"

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

  use { 'hrsh7th/vim-vsnip' }
  use { 'hrsh7th/vim-vsnip-integ' }
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
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' }
  },                                                                                                                                                                                                                                                                             
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
  cmd = { "bundle", "exec", "solargraph", "stdio" },
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

lsp.rust_analyzer.setup {
  on_attach = on_attach_lsp,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importMergeBehavior = "last",
        importPrefix = "by_self",
      },
      diagnostics = {
        disabled = { "unresolved-import" }
      },
      cargo = {
          loadOutDirsFromCheck = true
      },
      procMacro = {
          enable = true
      },
      checkOnSave = {
          command = "clippy"
      },
    }
  }
}

lsp.csharp_ls.setup{
  capabilities = capabilities,
  on_attach = on_attach_lsp
}

require("nvim-lsp-installer").setup {}

require('nvim-treesitter.configs').setup{
  ensure_installed = { "rust", "elixir", "ruby", "javascript", "typescript" },
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

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

require('telescope').setup {
  defaults = { file_ignore_patterns = {"vendor", "node_modules", "tmp", "log", "coverage"} },
  extension = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case"
    }
  }
}

require('telescope').load_extension('fzf')



local rust_opts = {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
      },
    },
    server = {
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importEnforceGranularity = true,
            importPrefix = "crate"
          },
          cargo = {
            allFeatures = true
          },
          checkOnSave = {
            -- default: `cargo check`
            command = "clippy"
          },
        },
        inlayHints = {
          lifetimeElisionHints = {
            enable = true,
            useParameterNames = true
          },
      },
    }
  }
}

require('rust-tools').setup(rust_opts)


