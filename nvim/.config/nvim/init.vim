" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

filetype plugin indent on

set encoding=utf-8
set tabstop=4
set shiftwidth=4
set softtabstop=2
" set noexpandtab
set expandtab
" set ruler
set hidden

" searching
set ignorecase
set hlsearch
set incsearch
set smartcase

set nosmartindent
set cindent
set cinkeys-=0#
set indentkeys-=0#
set nu
set rnu
set nobackup
set nowritebackup
set backupcopy=yes
set cmdheight=2

call plug#begin()
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://gitlab.com/code-stats/code-stats-vim.git'
Plug 'junegunn/vim-easy-align'
Plug 'tomlion/vim-solidity'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jreybert/vimagit'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'sainnhe/everforest'
Plug 'NLKNguyen/papercolor-theme'
Plug 'onsails/lspkind-nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'tpope/vim-fugitive'
" Plug 'sbdchd/neoformat'
call plug#end()

" colorscheme space-vim-dark
" colorscheme happy_hacking
" colorscheme OceanicNext
" colorscheme sonokai
" colorscheme solarized8_high
" colorscheme onehalfdark
" colorscheme gruvbox
" colorscheme spacecamp
" colorscheme everforest
colorscheme PaperColor

" netrw
let g:netrw_liststyle = 0
let g:netrw_banner = 1
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 20
" let g:netrw_keepdir = 0
" let g:netrw_localcopycmd = "cp -f"

set mouse=a
if has("mouse_sgr")
    set ttymouse=sgr
end

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set completeopt=menu,menuone,noselect

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

let g:airline_theme='atomic'

let g:codestats_api_key = $CODESTATS_TOKEN

" Optional: configure vim-airline to display status
" let g:airline_section_x = airline#section#create_right(['tagbar', 'filetype', '%{CodeStatsXp()}'])


" Files opened on the top
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1

" Telescope
" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fd <cmd>lua require('telescope.builtin').diagnostics()<cr>
nnoremap <leader>fn <cmd>TodoTelescope<cr>

" Custom remappings
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap x "_x
vnoremap p "_dP

" nnoremap <C-h> :bp<CR>
" nnoremap <C-l> :bn<CR>
nnoremap <C-c> :bd<CR>
nnoremap <C-S-c> :bd!<CR>
" behave vim
nnoremap Y y$
" keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
" Undo breakpoints
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
"Moving Text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
" Netrw
" nnoremap <leader>e :Ex<CR>
" nnoremap <leader>r :Rex<CR>
" LSP
nnoremap <leader>o :LspRestart<CR>
nnoremap <Leader>T :lua require'lsp_extensions'.inlay_hints()<cr>

:verbose imap <tab>

" copy to clipboard on all operations not only * +
" set clipboard+=unnamedplus
let g:clipboard = {
\	'name': 'mac',
\	'copy': {
\		'+': 'pbcopy',
\		'*': 'pbcopy',
\	},
\	'paste': {
\		'+': 'pbpaste',
\		'*': 'pbpaste',
\	},
\	'cache_enabled': 0,
\}

" Clojure
let g:sexp_enable_insert_mode_mappings = 1
let g:clojure_fuzzy_indent_patterns = ['^doto', '^with', '^def', '^let', 'go-loop', 'match', '^context', '^GET', '^PUT', '^POST', '^PATCH', '^DELETE', '^ANY', 'this-as', '^are', '^dofor']
let g:clojure_align_multiline_strings = 1
let g:clojure_maxlines = 100
let g:clj_refactor_prefix_rewriting=0

" function! Expand(exp) abort
"     let l:result = expand(a:exp)
"     return l:result ==# '' ? '' : "file://" . l:result
" endfunction

" highlight Normal guibg=#101010 guifg=white
" highlight CursorColumn guibg=#202020
" highlight Keyword guifg=#FFAB52
" highlight CursorLine guibg=#202020

augroup ARKNIUM
    autocmd!
    " autocmd BufWritePre *.lua Neoformat
    " autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

augroup custom_fugitive
    autocmd!
    autocmd VimEnter,BufNewFile,BufReadPost * if !empty(maparg('null', 'n')) | unmap <buffer> null| endif
augroup END

autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
" autocmd VimEnter <buffer> unmap null
" autocmd VimEnter echo 'hola'

nnoremap <silent><leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>
nnoremap <silent><C-h> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><C-t> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><C-n> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><C-s> :lua require("harpoon.ui").nav_file(4)<CR>

" Coq config
let g:coq_settings = {
  \ "auto_start": 'shut-up',
  \ "keymap.recommended": v:false,
  \ "keymap.manual_complete": "<c-space>",
  \ "keymap.jump_to_mark": "",
  \ "keymap.pre_select": v:true
\ }

" Keybindings
ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
ino <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"

" noremap n :echo 'pressed n'<CR>

:lua require('main')

