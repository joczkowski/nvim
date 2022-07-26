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

lsp.elixirls.setup{
  capabilities = capabilities,
  on_attach = on_attach_lsp
}

lsp.sorbet.setup{
  capabilities = capabilities,
  on_attach = on_attach_lsp,
  cmd = { "srb", "tc", "--lsp" } 
,
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
