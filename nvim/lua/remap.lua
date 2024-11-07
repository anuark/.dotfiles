vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
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

-- Edit Config
vim.cmd('nnoremap <Leader>vs :source ~/code/.dotfiles/nvim/init.lua<CR>')
vim.cmd('nnoremap <Leader>ve :vsplit ~/code/.dotfiles/nvim/init.lua<CR>')
vim.cmd('nnoremap <Leader>vc :!cp -a ~/code/.dotfiles/nvim/ ~/.config/nvim<CR>')

-- Harpoon
vim.cmd('nnoremap <silent><leader>a :lua require("harpoon.mark").add_file()<CR>')
vim.cmd('nnoremap <silent><C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>')
vim.cmd('nnoremap <silent><leader>e :lua require("harpoon.ui").toggle_quick_menu()<CR>')
vim.cmd('nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')
vim.cmd('nnoremap <silent><C-h> :lua require("harpoon.ui").nav_file(1)<CR>')
vim.cmd('nnoremap <silent><C-t> :lua require("harpoon.ui").nav_file(2)<CR>')
vim.cmd('nnoremap <silent><C-n> :lua require("harpoon.ui").nav_file(3)<CR>')
vim.cmd('nnoremap <silent><C-s> :lua require("harpoon.ui").nav_file(4)<CR>')

-- windows to close with "q"
vim.api.nvim_create_autocmd(
    "FileType",
    { pattern = { "help", "startuptime", "qf", "lspinfo" }, command = [[nnoremap <buffer><silent> q :close<CR>]] }
)
vim.api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

-- telescope
vim.cmd('nnoremap <C-p> <cmd>lua require("telescope.builtin").find_files()<cr>')
vim.cmd('nnoremap <leader>gg <cmd>lua require("telescope.builtin").live_grep()<cr>')
vim.cmd('nnoremap <leader>bu <cmd>lua require("telescope.builtin").buffers()<cr>')
vim.cmd('nnoremap <leader>h <cmd>lua require("telescope.builtin").help_tags()<cr>')
vim.cmd('nnoremap <leader>fd <cmd>lua require("telescope.builtin").diagnostics()<cr>')
vim.cmd('nnoremap <leader>tt <cmd>TodoTelescope<cr>')

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
-- vim.api.nvim_set_keymap("n", "<leader>gc", ":Telescope git_commits<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>gd", ":Telescope git_bcommits<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>gb", ":Telescope git_branches<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>gss", ":Telescope git_status<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>gst", ":Telescope git_stash<CR>", opts)

-- filebrowser 
-- vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope file_browser<CR>", opts)

-- gitblame
vim.api.nvim_set_keymap("n", "<leader>gbb", ":GitBlameToggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gbc", ":GitBlameOpenCommitURL<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gbf", ":GitBlameOpenFileURL<CR>", opts)

-- markdown preview
vim.api.nvim_set_keymap('n', '<leader>md', ':MarkdownPreview<CR>', opts)

-- copy to clipboard
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', opts)
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', opts)

-- remove all buffers
vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#<cr>", { desc = "Close all buffers but the current one" })

-- g;
vim.keymap.set("n", "<C-k>", "g;")
