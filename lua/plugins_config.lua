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

require("nvim-lsp-installer").setup {}

require('nvim-treesitter.configs').setup{
  ensure_installed = { "ruby" },
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
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  },
  defaults = {
    layout_strategy = 'center',
    layout_config = {
      prompt_position='bottom',
      layout_strategy='center',
      width=0.95,
    }
  }
}

require('telescope').load_extension('fzf')


-- local rust_opts = {
--   tools = {
--     autoSetHints = true,
--     inlay_hints = {
--       show_parameter_hints = true,
--       parameter_hints_prefix = "",
--       other_hints_prefix = "",
--       },
--     },
--     server = {
--       settings = {
--         ["rust-analyzer"] = {
--           assist = {
--             importEnforceGranularity = true,
--             importPrefix = "crate"
--           },
--           cargo = {
--             allFeatures = true
--           },
--           checkOnSave = {
--             -- default: `cargo check`
--             command = "clippy"
--           },
--         },
--         inlayHints = {
--           lifetimeElisionHints = {
--             enable = true,
--             useParameterNames = true
--           },
--       },
--     }
--   }
-- }

-- require('rust-tools').setup(rust_opts)

local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

local ts_conds = require('nvim-autopairs.ts-conds')


-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})

-- require("elixir").setup()
-- require 'go'.setup({
--   goimport = 'gopls', -- if set to 'gopls' will use golsp format
--   gofmt = 'gopls', -- if set to gopls will use golsp format
--   max_line_len = 120,
--   tag_transform = false,
--   test_dir = '',
--   comment_placeholder = '   ',
--   lsp_cfg = {
--     capabilities = capabilities,
--   },
--   lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
--   lsp_on_attach = true, -- use on_attach from go.nvim
--   dap_debug = true,
-- })
--
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

require("nvim-dap-virtual-text").setup()
-- require('dap-go').setup()
-- require("dapui").setup()

vim.g.copilot_node_command = "~/.nvm/versions/node/v16.15.0/bin/node"

require'nvim-tmux-navigation'.setup {
    disable_when_zoomed = true -- defaults to false
}

require("telescope").load_extension('harpoon')

