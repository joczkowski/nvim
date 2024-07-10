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
  colorscheme habamax
  set mouse=
  set signcolumn=yes
  set colorcolumn=80,100
  highlight ColorColumn ctermbg=0 guibg=lightgrey
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

  nnoremap <silent> <C-h> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>
  nnoremap <silent> <C-j> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>
  nnoremap <silent> <C-k> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>
  nnoremap <silent> <C-l> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>
  nnoremap <silent> <C-\> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>
  nnoremap <silent> <C-Space> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>
  vnoremap <leader>y  "+y
  nnoremap <leader>p "+p
]])



local set = vim.keymap.set

--
-- switch two buffers
--
set('n', '<Leader><Leader>', ':b#<CR>', { noremap = true, silent = true })
--
-- end switch two buffers
--


--
-- search mappings
-- 
-- set('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
-- set('n', '\\', "<cmd>lua require('fzf-lua').live_grep()<CR>", { noremap = true, silent = true })
-- set('v', '<leader>k', "<cmd>lua require('fzf-lua').grep_visual()<cr>", { silent = true, noremap = true })
-- set('n', '<leader>k', "<cmd>lua require('fzf-lua').grep_cword()<cr>", { silent = true, noremap = true })
-- set('n', '<Leader>a', "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true })
-- set('n', '<Leader>gg', "<cmd>lua require('fzf-lua').git_status()<CR>", { noremap = true, silent = true })

local tbin = require('telescope.builtin')
set('n', '<c-P>', tbin.find_files, { noremap = true, silent = true })
set('n', '\\', tbin.live_grep, { noremap = true, silent = true })
set('v', '<leader>k', tbin.grep_string, { silent = true, noremap = true })
set('n', '<leader>k', tbin.grep_string, { silent = true, noremap = true })
set('n', '<Leader>a', tbin.buffers, { noremap = true, silent = true })
set('n', '<Leader>gg', tbin.git_status, { noremap = true, silent = true })
--
-- end search mappings
--

--
-- nerdtree mappings
-- 
set('n', '<C-n>', "<cmd>NERDTreeFind<cr>", { silent = true, noremap = true })
--
-- end nerdtree mappings
--

--
-- rspec integration mappings
-- 
set('n', '<leader>rl', '<cmd>call VimuxRunCommand("clear; dev bt bundle exec rspec " . bufname("%") . ":" . line("."))<CR>', { silent = true, noremap = true })
set('n', '<leader>rb', '<cmd>call VimuxRunCommand("clear; bundle exec rspec " . bufname("%"))<CR>', { silent = true, noremap = true })
--
-- end rspec integration mappings
--

--
-- run command mappings
--
set('n', '<leader>rc', '<cmd>call VimuxRunCommand(@*)<CR>', { silent = true, noremap = true })
--
-- end run command mappings
--

set('n', '<leader>td', '<cmd>e ~/todo.org<CR>', { silent = true, noremap = true })


---
--- lsp
---
set('n', '<Leader>e', "<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>", { noremap = true, silent = true })
set('n', '<Leader>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
set('n', '<Leader>h', "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
set('n', 'gd',        "<cmd>lua vim.lsp.buf.definition()<CR>")
---
--- lsp
---

set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)

local opts = { noremap = true, silent = true }
