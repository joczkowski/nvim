local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.diagnostic.config({
  virtual_text = false
})

local lsp = require 'lspconfig'

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
end

lsp.pyright.setup{
  on_attach = on_attach
}

-- lsp.solargraph.setup{
--   capabilities = capabilities,
--   root_dir = lsp.util.root_pattern(".git"),
--   cmd = { "solargraph", "stdio" },
--   -- settings = { solargraph = { useBundler = true } },
--   on_attach = on_attach
-- }

lsp.ruby_lsp.setup {
  capabilities = capabilities,
  on_attach = on_attach_lsp
}

lsp.tsserver.setup{
  capabilities = capabilities,
  on_attach = on_attach_lsp
}

lsp.eslint.setup{
  on_attach = on_attach_lsp
}

lsp.gopls.setup{
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
