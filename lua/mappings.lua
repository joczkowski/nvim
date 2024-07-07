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
  colorscheme monokai
  colorscheme moonfly
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
]])

-- switch two buffers
vim.api.nvim_set_keymap('n', '<Leader><Leader>', ':b#<CR>', { noremap = true, silent = true })

-- search mappings
vim.keymap.set('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '\\', "<cmd>lua require('fzf-lua').live_grep()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>k', "<cmd>lua require('fzf-lua').grep_visual()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', "<cmd>lua require('fzf-lua').grep_cword()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>a', "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gg', "<cmd>lua require('fzf-lua').git_status()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', "<cmd>NERDTreeFind<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rl', '<cmd>call VimuxRunCommand("clear; dev bt bundle exec rspec " . bufname("%") . ":" . line("."))<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rb', '<cmd>call VimuxRunCommand("clear; bundle exec rspec " . bufname("%"))<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rc', '<cmd>call VimuxRunCommand(@*)<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>td', '<cmd>e ~/todo.org<CR>', { silent = true, noremap = true })

vim.keymap.set('n', '<Leader>1', '<cmd>Telescope harpoon marks<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>2', '<cmd>lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F2>', '<cmd>lua require("harpoon.mark").clear_all()<CR>', { noremap = true, silent = true })

-- display lsp diagnostic float window
vim.keymap.set('n', '<Leader>e', "<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>", { noremap = true, silent = true })

-- code action
vim.keymap.set('n', '<Leader>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })

-- hover name
vim.keymap.set('n', '<Leader>h', "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end


local keymap = vim.keymap.set
-- local tb = require('telescope.builtin')
local opts = { noremap = true, silent = true }

keymap('n', '<space>G', ':Telescope live_grep<cr>', opts)
keymap('v', '<space>G', function()
	local text = vim.getVisualSelection()
	tb.live_grep({ default_text = text })
end, opts)
