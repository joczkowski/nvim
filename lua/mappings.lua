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

  autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
]])

-- switch two buffers
vim.api.nvim_set_keymap('n', '<Leader><Leader>', ':b#<CR>', { noremap = true, silent = true })

-- search mappings
vim.keymap.set('n', '<c-P>', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>a', "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gg', "<cmd>lua require('telescope.builtin').git_status()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '\\', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua require("telescope.builtin").grep_string()<CR>', { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('v', '<leader>j', "<cmd>lua require('telescope.builtin').grep_visual()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-n>', "<cmd>NERDTreeFind<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rl', '<cmd>call VimuxRunCommand("clear; bundle exec rspec " . bufname("%") . ":" . line("."))<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rb', '<cmd>call VimuxRunCommand("clear; bundle exec rspec " . bufname("%"))<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rc', '<cmd>call VimuxRunCommand(@*)<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>td', '<cmd>e ~/todo.org<CR>', { silent = true, noremap = true })


-- debug keymaps
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F3>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F2>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")

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
