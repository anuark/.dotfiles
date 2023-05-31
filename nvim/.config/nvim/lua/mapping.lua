-- Telescope
-- Using Lua functions
vim.cmd('nnoremap <C-p> <cmd>lua require("telescope.builtin").find_files()<cr>')
vim.cmd('nnoremap <leader>ff <cmd>lua require("telescope.builtin").find_files()<cr>')
vim.cmd('nnoremap <leader>fg <cmd>lua require("telescope.builtin").live_grep()<cr>')
vim.cmd('nnoremap <leader>fb <cmd>lua require("telescope.builtin").buffers()<cr>')
vim.cmd('nnoremap <leader>fh <cmd>lua require("telescope.builtin").help_tags()<cr>')
vim.cmd('nnoremap <leader>fd <cmd>lua require("telescope.builtin").diagnostics()<cr>')
vim.cmd('nnoremap <leader>fn <cmd>TodoTelescope<cr>')

-- Custom remappings
vim.cmd('nnoremap <leader>d "_d')
vim.cmd('vnoremap <leader>d "_d')
vim.cmd('nnoremap x "_x')
vim.cmd('vnoremap p "_dP')

vim.cmd('nnoremap <C-S-c> :bd!<CR>')
vim.cmd('nnoremap <C-c> :bd<CR>')

-- behave vim
vim.cmd('nnoremap Y y$')

-- keeping it centered
vim.cmd('nnoremap n nzzzv')
vim.cmd('nnoremap N Nzzzv')
vim.cmd('nnoremap J mzJ`z')

-- Undo breakpoints
vim.cmd('inoremap , ,<c-g>u')
vim.cmd('inoremap . .<c-g>u')
vim.cmd('inoremap ! !<c-g>u')
vim.cmd('inoremap ? ?<c-g>u')

--Moving Text
vim.cmd([[
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv
    " inoremap <C-j> <esc>:m .+1<CR>==
    " inoremap <C-k> <esc>:m .-2<CR>==
    nnoremap <leader>k :m .-2<CR>==
    nnoremap <leader>j :m .+1<CR>==
]])

-- LSP
vim.cmd('nnoremap <leader>r :LspRestart<CR>')

-- init.vim
vim.cmd('nnoremap <Leader>vs :source ~/code/.dotfiles/nvim/.config/nvim/init.lua<CR>')
vim.cmd('nnoremap <Leader>ve :vsplit ~/code/.dotfiles/nvim/.config/nvim/init.lua<CR>')
vim.cmd('nnoremap <Leader>vc :!cp -a ~/code/.dotfiles/nvim/.config/nvim ~/.config/<CR>')

-- Harpoon
vim.cmd('nnoremap <silent><leader>a :lua require("harpoon.mark").add_file()<CR>')
vim.cmd('nnoremap <silent><C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>')
vim.cmd('nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')
vim.cmd('nnoremap <silent><C-h> :lua require("harpoon.ui").nav_file(1)<CR>')
vim.cmd('nnoremap <silent><C-t> :lua require("harpoon.ui").nav_file(2)<CR>')
vim.cmd('nnoremap <silent><C-n> :lua require("harpoon.ui").nav_file(3)<CR>')
vim.cmd('nnoremap <silent><C-s> :lua require("harpoon.ui").nav_file(4)<CR>')

-- Dap
-- vim.cmd('nnoremap <silent> <F5> <Cmd>lua require"dap'.continue()<CR>')
-- vim.cmd('nnoremap <silent> <F10> <Cmd>lua require"dap'.step_over()<CR>')
-- vim.cmd('nnoremap <silent> <F11> <Cmd>lua require"dap'.step_into()<CR>')
-- vim.cmd('nnoremap <silent> <F12> <Cmd>lua require"dap'.step_out()<CR>')
-- vim.cmd('nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>')
-- vim.cmd('nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>')
-- vim.cmd('nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>')
-- vim.cmd('nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>')
-- vim.cmd('nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>')

-- Coq bindings
vim.cmd('ino <silent><expr> <Esc>   pumvisible() ? "<C-e><Esc>" : "<Esc>"')
vim.cmd('ino <silent><expr> <C-c>   pumvisible() ? "<C-e><C-c>" : "<C-c>"')
vim.cmd('ino <silent><expr> <BS>    pumvisible() ? "<C-e><BS>"  : "<BS>"')
vim.cmd('ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "<C-e><CR>" : "<C-y>") : "<CR>"')
vim.cmd('ino <silent><expr> <Tab>   pumvisible() ? "<C-n>" : "<Tab>"')

