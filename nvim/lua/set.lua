-- cp -a ~/code/.dotfiles/nvim/.config/nvim ~/.config/
-- Ignore files
vim.cmd("set wildignore+=*.pyc")
vim.cmd("set wildignore+=*_build/*")
vim.cmd("set wildignore+=**/coverage/*")
vim.cmd("set wildignore+=**/node_modules/*")
vim.cmd("set wildignore+=**/android/*")
vim.cmd("set wildignore+=**/ios/*")
vim.cmd("set wildignore+=**/.git/*")

vim.cmd("filetype plugin indent on")

vim.cmd("set encoding=utf-8")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=2")
vim.cmd("set expandtab")
vim.cmd("set hidden")

-- searching
vim.cmd("set ignorecase")
vim.cmd("set hlsearch")
vim.cmd("set incsearch")
vim.cmd("set smartcase")

vim.cmd("set nosmartindent")
vim.cmd("set cindent")
vim.cmd("set cinkeys-=0#")
vim.cmd("set indentkeys-=0#")
vim.cmd("set nu")
vim.cmd("set rnu")
vim.cmd("set nobackup")
vim.cmd("set nowritebackup")
vim.cmd("set backupcopy=yes")
vim.cmd("set cmdheight=2")

vim.cmd("set termguicolors")

vim.cmd("set mouse=a")
vim.cmd([[
    if has("mouse_sgr")
        set ttymouse=sgr
    end
]])

-- Give more space for displaying messages.
vim.cmd('set cmdheight=2')

-- " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- " delays and poor user experience.
vim.cmd('set updatetime=300')

-- Don't pass messages to |ins-completion-menu|.
vim.cmd('set shortmess+=c')

vim.cmd('set completeopt=menu,menuone,noselect')

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.cmd([[
    if has("patch-8.1.1564")
        set signcolumn=number
    else
        set signcolumn=yes
    endif
]])

vim.g.airline_theme = 'atomic'

-- Files opened on the top
-- let g:airline#extensions#tabline#enabled = 1
-- let g:airline#extensions#tabline#formatter = 'unique_tail'
vim.g.airline_powerline_fonts = 1
vim.cmd('let g:airline#extensions#branch#enabled = 1')
vim.g.gitblame_enabled = false

-- Transparent background
vim.g.transparent_enabled = false

-- netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
