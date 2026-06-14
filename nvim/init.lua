-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.cmd("let g:python3_host_prog = '/Users/anuarkilgore/python/bin/python3'")
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
vim.cmd('set cmdheight=2') -- Give more space for displaying messages.
vim.cmd('set updatetime=300')
vim.cmd('set shortmess+=c')
vim.cmd('set completeopt=menu,menuone,noselect')
vim.cmd([[
    if has("mouse_sgr")
        set ttymouse=sgr
    end
]])
-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.cmd([[
    if has("patch-8.1.1564")
        set signcolumn=number
    else
        set signcolumn=yes
    endif
]])
vim.o.winborder = 'rounded'

-- REMAP
-- oil.nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.cmd('nnoremap <leader>d "_d')
vim.cmd('vnoremap <leader>d "_d')
vim.cmd('nnoremap x "_x')
vim.cmd('vnoremap p "_dP')
vim.cmd('nnoremap <C-S-c> :bd!<CR>')
vim.cmd('nnoremap <C-c> :bd<CR>')
vim.cmd('nnoremap Y y$')
vim.cmd('nnoremap n nzzzv')
vim.cmd('nnoremap N Nzzzv')
vim.cmd('nnoremap J mzJ`z')
vim.cmd('inoremap , ,<c-g>u')
vim.cmd('inoremap . .<c-g>u')
vim.cmd('inoremap ! !<c-g>u')
vim.cmd('inoremap ? ?<c-g>u')

--Moving Text
vim.cmd([[
    vnoremap <C-j> :m '>+1<CR>gv=gv
    vnoremap <C-k> :m '<-2<CR>gv=gv
    nnoremap <leader>k :m .-2<CR>==
    nnoremap <leader>j :m .+1<CR>==
]])

-- Edit Config
vim.cmd('nnoremap <Leader>vs :source ~/code/.dotfiles/nvim/init.lua<CR>')
vim.cmd('nnoremap <Leader>ve :vsplit ~/code/.dotfiles/nvim/init.lua<CR>')
vim.cmd('nnoremap <Leader>vc :!cp -a ~/code/.dotfiles/nvim/ ~/.config/nvim<CR>')


-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

-- windows to close with "q"
vim.api.nvim_create_autocmd(
    "FileType",
    { pattern = { "help", "startuptime", "qf", "lspinfo" }, command = [[nnoremap <buffer><silent> q :close<CR>]] }
)
vim.api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- copy to clipboard
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', opts)
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', opts)

-- quickfix
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- Harpoon
vim.cmd('nnoremap <silent><C-a> :lua require("harpoon.mark").add_file()<CR>')
vim.cmd('nnoremap <silent><C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>')
vim.cmd('nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')
vim.cmd('nnoremap <silent><C-h> :lua require("harpoon.ui").nav_file(1)<CR>')
vim.cmd('nnoremap <silent><C-t> :lua require("harpoon.ui").nav_file(2)<CR>')
vim.cmd('nnoremap <silent><C-n> :lua require("harpoon.ui").nav_file(3)<CR>')
vim.cmd('nnoremap <silent><C-s> :lua require("harpoon.ui").nav_file(4)<CR>')
-- TODO: use on keymap function

-- gitblame
vim.api.nvim_set_keymap("n", "<leader>gbb", ":GitBlameToggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gbc", ":GitBlameOpenCommitURL<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gbf", ":GitBlameOpenFileURL<CR>", opts)
vim.g.gitblame_enabled = false

-- toggle quickfix list
vim.keymap.set("n", "<leader>q", function()
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            vim.cmd("cclose")
            return
        end
    end
    vim.cmd("copen")
end, { desc = "Toggle quickfix" })

-- molten
-- I find auto open annoying, keep in mind setting this option will require setting
-- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
vim.g.molten_auto_open_output = false

-- this guide will be using image.nvim
-- Don't forget to setup and install the plugin if you want to view image outputs
-- vim.g.molten_image_provider = "image.nvim"

-- optional, I like wrapping. works for virt text and the output window
vim.g.molten_wrap_output = true

-- Output as virtual text. Allows outputs to always be shown, works with images, but can
-- be buggy with longer images
vim.g.molten_virt_text_output = true

-- this will make it so the output shows up below the \`\`\` cell delimiter
vim.g.molten_virt_lines_off_by_1 = true
vim.g.molten_enter_output_behavior = 'open_and_enter'

-- folke/edgy.nvim
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"

-- TODO: use lazy to set keybindings
vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
vim.keymap.set("n", "<leader>mi", ":MoltenInterrupt<CR>", { desc = "molten interrupt", silent = true })
vim.keymap.set("n", "<leader>mo", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })
vim.keymap.set("n", "<leader>mr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
vim.keymap.set("n", "<leader>r", ":MoltenEvaluateLine<CR>", { desc = "execute line", silent = true })
vim.keymap.set("v", "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "execute visual selection", silent = true })
vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })
vim.keymap.set("n", "<leader>os", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "show/enter output" })
vim.keymap.set("n", "<leader>mx", ":MoltenOpenInBrowser<CR>", { desc = "open output in browser", silent = true })


-- lazy.nvim
require("lazy").setup({
    spec = {
        -- {{ Colorschemes
        {
            'catppuccin/nvim',
            name = 'catppuccin',
            priority = 1000,
        },
        {
            'rose-pine/neovim',
            name = 'rose-pine',
            priority = 1000,
        },
        {
            'Everblush/everblush.nvim',
            name = 'everblush',
            priority = 1000,
            -- config = function()
            --     vim.cmd('colorscheme everblush')
            -- end
        },
        {
            'NLKNguyen/papercolor-theme',
            name = 'PaperColor',
            priority = 1000,
        },
        {
            'sainnhe/everforest',
            name = 'everforest',
            priority = 1000,
            -- config = function()
            --     vim.cmd('colorscheme everforest')
            -- end
        },
        {
            'scottmckendry/cyberdream.nvim',
            priority = 1000,
            -- config = function()
            --     vim.cmd([[colorscheme cyberdream]])
            -- end,
        },
        {
            "rebelot/kanagawa.nvim",
            priority = 1000,
            -- config = function()
            --     vim.cmd.colorscheme("kanagawa-wave")
            -- end
        },
        {
            "navarasu/onedark.nvim",
            priority = 1000,
            config = function()
                vim.cmd.colorscheme("onedark")
            end
        },
        -- }}
        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' }
        },
        {
            "benlubas/molten-nvim",
            version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
            build = ":UpdateRemotePlugins",
            init = function()
                vim.g.molten_output_win_max_height = 16
            end,
        },
        {
            'saghen/blink.cmp',
            dependencies = { 'rafamadriz/friendly-snippets' },
            version = '1.*',
            opts = {
                keymap = {
                    preset = 'none',
                    ["<Tab>"] = {
                        function(cmp)
                            if cmp.is_visible() then
                                return cmp.select_next()
                            end
                            return false -- fallback to normal <Tab>
                        end,
                        "fallback",
                    },
                    ["<S-Tab>"] = {
                        function(cmp)
                            if cmp.is_visible() then
                                return cmp.select_prev()
                            end
                            return false
                        end,
                        "fallback",
                    },
                    ["<CR>"] = { "accept", "fallback" },
                    -- ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
                    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                },
                appearance = {
                    nerd_font_variant = 'mono'
                },
                completion = { documentation = { auto_show = false } },
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },
                fuzzy = { implementation = "prefer_rust_with_warning" }
            },
            opts_extend = { "sources.default" }
        },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    { path = "snacks.nvim",        words = { "Snacks" } },
                    { path = "lazy.nvim",          words = { "LazyVim" } },
                },
            },
        },
        -- { "fei6409/log-highlight.nvim", event = "BufRead *.log", opts = {} },
        {
            'nvim-treesitter/nvim-treesitter',
            lazy = false,
            build = ":TSUpdate",
            opts_extend = { "ensure_installed" },
            opts = {
                sync_install = true,
                ensure_install = { "help", "go", "javascript", "typescript", "rust", "lua", "regex", "css", "html", "latex", "norg", "scss", "svelte", "tsx", "typst", "vue", "markdown_inline", "markdown" },
                auto_install = true,

                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            },
        },
        {
            'nvim-treesitter/nvim-treesitter-context',
            opts = {
                enable = true,        -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0,        -- How many lines the window should span. Values <= 0 mean no limit.
                trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                patterns = {          -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                    -- For all filetypes
                    -- Note that setting an entry here replaces all other patterns for this entry.
                    -- By setting the 'default' entry below, you can control which nodes you want to
                    -- appear in the context window.
                    default = {
                        'class',
                        'function',
                        'method',
                        'for', -- These won't appear in the context
                        'while',
                        -- 'if',
                        -- 'switch',
                        -- 'case',
                    },
                    -- Example for a specific filetype.
                    -- If a pattern is missing, *open a PR* so everyone can benefit.
                    --   rust = {
                    --       'impl_item',
                    --   },
                },
                exact_patterns = {
                    -- Example for a specific filetype with Lua patterns
                    -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
                    -- exactly match "impl_item" only)
                    -- rust = true,
                },
                zindex = 20,     -- The Z-index of the context window
                mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
                separator = '-',
            },
        },
        -- Need to learn more about this plugin
        -- {
        --     "nvim-treesitter/nvim-treesitter-textobjects",
        --     branch = "main",
        --     init = function()
        --         -- Disable entire built-in ftplugin mappings to avoid conflicts.
        --         -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
        --         vim.g.no_plugin_maps = true

        --         -- Or, disable per filetype (add as you like)
        --         -- vim.g.no_python_maps = true
        --         -- vim.g.no_ruby_maps = true
        --         -- vim.g.no_rust_maps = true
        --         -- vim.g.no_go_maps = true
        --     end,
        --     config = function()
        --         -- put your config here
        --     end,
        -- },
        {
            'stevearc/oil.nvim',
            opts = {
                columns = {
                    "icon",
                    -- "permissions",
                    "size",
                    "mtime",
                }
            }
        },
        {
            "ThePrimeagen/harpoon",
            branch = "master",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {}
        },
        { 'f-person/git-blame.nvim' },
        -- {
        --     "folke/which-key.nvim",
        --     event = "VeryLazy",
        --     opt = {
        --         preset = "modern",
        --         triggers = { "<auto>", mode = "" },
        --     },
        --     keys = {
        --         {
        --             "<leader>?",
        --             function()
        --                 require("which-key").show({ global = false })
        --             end,
        --             desc = "Buffer Local Keymaps (which-key)",
        --         },
        --     },
        -- },
        {
            "folke/edgy.nvim",
            ---@module 'edgy'
            ---@param opts Edgy.Config
            event = "VeryLazy",
            opts = function(_, opts)
                for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
                    opts[pos] = opts[pos] or {}
                    table.insert(opts[pos], {
                        ft = "snacks_terminal",
                        size = { height = 0.4 },
                        title = "%{b:snacks_terminal.id}: %{b:term_title}",
                        filter = function(_buf, win)
                            return vim.w[win].snacks_win
                                and vim.w[win].snacks_win.position == pos
                                and vim.w[win].snacks_win.relative == "editor"
                                and not vim.w[win].trouble_preview
                        end,
                    })
                end
            end,
        },
        {
            "coder/claudecode.nvim",
            dependencies = { "folke/snacks.nvim" },
            config = true,
            opts = {
                -- Server Configuration
                port_range = { min = 10000, max = 65535 },
                auto_start = true,
                log_level = "info", -- "trace", "debug", "info", "warn", "error"
                terminal_cmd = nil, -- Custom terminal command (default: "claude")
                -- For local installations: "~/.claude/local/claude"
                -- For native binary: use output from 'which claude'

                -- Send/Focus Behavior
                -- When true, successful sends will focus the Claude terminal if already connected
                focus_after_send = true,

                -- Selection Tracking
                track_selection = true,
                visual_demotion_delay_ms = 50,

                -- Terminal Configuration
                terminal = {
                    split_side = "right", -- "left" or "right"
                    split_width_percentage = 0.45,
                    provider = "auto", -- "auto", "snacks", "native", "external", "none", or custom provider table
                    auto_close = true,
                    snacks_win_opts = {}, -- Opts to pass to `Snacks.terminal.open()` - see Floating Window section below

                    -- Provider-specific options
                    provider_opts = {
                        -- Command for external terminal provider. Can be:
                        -- 1. String with %s placeholder: "alacritty -e %s" (backward compatible)
                        -- 2. String with two %s placeholders: "alacritty --working-directory %s -e %s" (cwd, command)
                        -- 3. Function returning command: function(cmd, env) return "alacritty -e " .. cmd end
                        external_terminal_cmd = nil,
                    },
                },

                -- Diff Integration
                diff_opts = {
                    layout = "vertical", -- "vertical" or "horizontal"
                    open_in_new_tab = false,
                    keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
                    hide_terminal_in_new_tab = false,
                    -- on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"

                    -- Legacy aliases (still supported):
                    -- vertical_split = true,
                    -- open_in_current_tab = true,
                },
            },
            keys = {
                { "<leader>a",  nil,                              desc = "AI/Claude Code" },
                { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
                { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
                { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
                { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
                { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
                { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
                { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
                {
                    "<leader>as",
                    "<cmd>ClaudeCodeTreeAdd<cr>",
                    desc = "Add file",
                    ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
                },
                -- Diff management
                { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
                { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
            },
        },
        {
            "folke/snacks.nvim",
            priority = 1000,
            lazy = false,
            ---@type snacks.Config
            opts = {
                bigfile = { enabled = true },
                dashboard = { enabled = true },
                explorer = { enabled = true },
                indent = { enabled = true },
                image = { enabled = false },
                input = { enabled = true },
                lazygit = { enabled = true },
                picker = { enabled = true },
                notifier = { enabled = true, timeout = 3000 },
                quickfile = { enabled = true },
                scope = { enabled = true },
                scroll = { enabled = true },
                statuscolumn = {
                    enabled = true,
                },
                teminal = {
                    enabled = true,
                    win = { style = "terminal" },
                    bo = {
                        filetype = "snacks_terminal",
                    },
                    wo = {},
                    stack = true, -- when enabled, multiple split windows with the same position will be stacked together (useful for terminals)
                    esc_timer = 100,
                    keys = {
                        q = "hide",
                        gf = function(self)
                            local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
                            if f == "" then
                                Snacks.notify.warn("No file under cursor")
                            else
                                self:hide()
                                vim.schedule(function()
                                    vim.cmd("e " .. f)
                                end)
                            end
                        end,
                        term_normal = {
                            "<esc>",
                            function(self)
                                self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
                                if self.esc_timer:is_active() then
                                    self.esc_timer:stop()
                                    vim.cmd("stopinsert")
                                else
                                    self.esc_timer:start(200, 0, function() end)
                                    return "<esc>"
                                end
                            end,
                            mode = "t",
                            expr = true,
                            desc = "Double escape to normal mode",
                        },
                    },
                },
                -- win = { enabled = true },
                words = { enabled = true },
                zen = { enabled = true },
            },
            keys = {
                -- Top Pickers & Explorer
                { "<leader><space>", function() Snacks.picker.smart() end,                 desc = "Smart Find Files" },
                { "<leader>,",       function() Snacks.picker.buffers() end,               desc = "Buffers" },
                { "<leader>/",       function() Snacks.picker.grep() end,                  desc = "Grep" },
                { "<leader>:",       function() Snacks.picker.command_history() end,       desc = "Command History" },
                { "<leader>n",       function() Snacks.picker.notifications() end,         desc = "Notification History" },
                -- find
                { "<leader>fb",      function() Snacks.picker.buffers() end,               desc = "Buffers" },
                { "<C-p>",           function() Snacks.picker.files() end,                 desc = "Find Files" },
                { "<leader>fg",      function() Snacks.picker.git_files() end,             desc = "Find Git Files" },
                { "<leader>fp",      function() Snacks.picker.projects() end,              desc = "Projects" },
                { "<leader>fr",      function() Snacks.picker.recent() end,                desc = "Recent" },
                -- LSP
                { "gd",              function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
                { "gD",              function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
                { "gr",              function() Snacks.picker.lsp_references() end,        nowait = true,                     desc = "References" },
                { "gI",              function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
                { "gt",              function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
                { "gai",             function() Snacks.picker.lsp_incoming_calls() end,    desc = "C[a]lls Incoming" },
                { "gao",             function() Snacks.picker.lsp_outgoing_calls() end,    desc = "C[a]lls Outgoing" },
                { "<leader>gs",      function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
                { "<leader>gS",      function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
                -- search
                { '<leader>s"',      function() Snacks.picker.registers() end,             desc = "Registers" },
                { '<leader>s/',      function() Snacks.picker.search_history() end,        desc = "Search History" },
                { "<leader>sa",      function() Snacks.picker.autocmds() end,              desc = "Autocmds" },
                { "<leader>sb",      function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
                { "<leader>sc",      function() Snacks.picker.command_history() end,       desc = "Command History" },
                { "<leader>sC",      function() Snacks.picker.commands() end,              desc = "Commands" },
                { "<leader>gi",      function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
                { "<leader>gI",      function() Snacks.picker.diagnostics_buffer() end,    desc = "Buffer Diagnostics" },
                { "<leader>fh",      function() Snacks.picker.help() end,                  desc = "Help Pages" },
                { "<leader>fH",      function() Snacks.picker.highlights() end,            desc = "Highlights" },
                { "<leader>fi",      function() Snacks.picker.icons() end,                 desc = "Icons" },
                { "<leader>fj",      function() Snacks.picker.jumps() end,                 desc = "Jumps" },
                { "<leader>sk",      function() Snacks.picker.keymaps() end,               desc = "Keymaps" },
                { "<leader>sl",      function() Snacks.picker.loclist() end,               desc = "Location List" },
                { "<leader>sm",      function() Snacks.picker.marks() end,                 desc = "Marks" },
                { "<leader>sM",      function() Snacks.picker.man() end,                   desc = "Man Pages" },
                { "<leader>sp",      function() Snacks.picker.lazy() end,                  desc = "Search for Plugin Spec" },
                { "<leader>sq",      function() Snacks.picker.qflist() end,                desc = "Quickfix List" },
                { "<leader>sR",      function() Snacks.picker.resume() end,                desc = "Resume" },
                { "<leader>su",      function() Snacks.picker.undo() end,                  desc = "Undo History" },
                { "<leader>uC",      function() Snacks.picker.colorschemes() end,          desc = "Colorschemes" },
                -- Other
                { "<leader>z",       function() Snacks.zen() end,                          desc = "Toggle Zen Mode" },
                { "<leader>Z",       function() Snacks.zen.zoom() end,                     desc = "Toggle Zoom" },
                { "<leader>.",       function() Snacks.scratch() end,                      desc = "Toggle Scratch Buffer" },
                { "<leader>S",       function() Snacks.scratch.select() end,               desc = "Select Scratch Buffer" },
                { "<leader>n",       function() Snacks.notifier.show_history() end,        desc = "Notification History" },
                { "<leader>bd",      function() Snacks.bufdelete() end,                    desc = "Delete Buffer" },
                { "<leader>cR",      function() Snacks.rename.rename_file() end,           desc = "Rename File" },
                { "<leader>gB",      function() Snacks.gitbrowse() end,                    desc = "Git Browse",               mode = { "n", "v" } },
                { "<leader>gg",      function() Snacks.lazygit() end,                      desc = "Lazygit" },
                { "<leader>un",      function() Snacks.notifier.hide() end,                desc = "Dismiss All Notifications" },
                { "<leader>cc",      function() Snacks.picker.qflist() end,                desc = "Open Quickfix list" },
                { "<c-\\>",          function() Snacks.terminal() end,                     desc = "Toggle Terminal",          mode = { "n", "t" } },
                { "]]",              function() Snacks.words.jump(vim.v.count1) end,       desc = "Next Reference",           mode = { "n", "t" } },
                { "[[",              function() Snacks.words.jump(-vim.v.count1) end,      desc = "Prev Reference",           mode = { "n", "t" } },
                {
                    "<leader>N",
                    desc = "Neovim News",
                    function()
                        Snacks.win({
                            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                            width = 0.6,
                            height = 0.6,
                            wo = {
                                spell = false,
                                wrap = false,
                                signcolumn = "yes",
                                statuscolumn = " ",
                                conceallevel = 3,
                            },
                        })
                    end,
                }
            }
        }
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

-- Diagnostics {{{
local config = {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
        },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "single",
        source = "always",
        header = "",
        prefix = "",
        suffix = "",
    },
}
vim.diagnostic.config(config)
-- }}}

-- Improve LSPs UI {{{
local icons = {
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Keyword = " ",
    Method = "ƒ ",
    Module = "󰏗 ",
    Property = " ",
    Snippet = " ",
    Struct = " ",
    Text = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
}

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
    completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end
-- }}}

-- Lsp capabilities and on_attach {{{
-- Here we grab default Neovim capabilities and extend them with ones we want on top
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
    dynamicRegistration = true,
    lineFoldingOnly = true,
}

capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
        if ok then
            diag.populate_workspace_diagnostics(client, bufnr)
        end
    end,
})
-- }}}

-- Disable the default keybinds {{{
for _, bind in ipairs({ "grn", "gra", "gri", "grr", "grt" }) do
    pcall(vim.keymap.del, "n", bind)
end
-- }}}

-- Create keybindings, commands, inlay hints and autocommands on LSP attach {{{
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then
            return
        end
        ---@diagnostic disable-next-line need-check-nil
        if client.server_capabilities.completionProvider then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
            -- vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
        end
        ---@diagnostic disable-next-line need-check-nil
        if client.server_capabilities.definitionProvider then
            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        end

        -- -- nightly has inbuilt completions, this can replace all completion plugins
        -- if client:supports_method("textDocument/completion", bufnr) then
        --   -- Enable auto-completion
        --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        -- end

        --- Disable semantic tokens
        ---@diagnostic disable-next-line need-check-nil
        client.server_capabilities.semanticTokensProvider = nil

        -- All the keymaps
        -- stylua: ignore start
        local keymap = vim.keymap.set
        local lsp = vim.lsp
        local function opt(desc, others)
            return vim.tbl_extend("force", { silent = true }, { desc = desc }, others or {})
        end
        keymap("n", "gd", lsp.buf.definition, opt("Go to definition"))
        keymap("n", "gD", function()
            local ok, diag = pcall(require, "rj.extras.definition")
            if ok then
                diag.get_def()
            end
        end, opt("Get the definition in a float"))
        keymap("n", "gi", function() lsp.buf.implementation({ border = "single" }) end, opt("Go to implementation"))
        keymap("n", "gr", lsp.buf.references, opt("Show References"))
        keymap("n", "gl", vim.diagnostic.open_float, opt("Open diagnostic in float"))
        keymap("n", "<C-k>", lsp.buf.signature_help, { silent = true })
        -- disable the default binding first before using a custom one
        pcall(vim.keymap.del, "n", "K", { buffer = ev.buf })
        keymap("n", "K", function() lsp.buf.hover({ border = "single", max_height = 30, max_width = 120 }) end,
            opt("Toggle hover"))
        -- keymap("n", "<Leader>lF", vim.cmd.FormatToggle, opt("Toggle AutoFormat"))
        -- keymap("n", "<Leader>lI", vim.cmd.Mason, opt("Mason"))
        -- keymap("n", "<Leader>lS", lsp.buf.workspace_symbol, opt("Workspace Symbols"))
        keymap("n", "<Leader>la", lsp.buf.code_action, opt("Code Action"))
        keymap("n", "<Leader>lh", function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({})) end,
            opt("Toggle Inlayhints"))
        keymap("n", "<Leader>li", vim.cmd.LspInfo, opt("LspInfo"))
        keymap("n", "<Leader>ll", lsp.codelens.run, opt("Run CodeLens"))
        keymap("n", "<Leader>lr", lsp.buf.rename, opt("Rename"))
        -- keymap("n", "<Leader>ls", lsp.buf.document_symbol, opt("Doument Symbols"))

        -- diagnostic mappings
        keymap("n", "<Leader>dD", function()
            local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
            if ok then
                for _, cur_client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                    diag.populate_workspace_diagnostics(cur_client, 0)
                end
                Snacks.notify.info("INFO: Diagnostic populated")
            end
        end, opt("Popluate diagnostic for the whole workspace"))
        -- keymap("n", "<Leader>dn", function() vim.diagnostic.jump({ count = 1, float = true }) end, opt("Next Diagnostic"))
        -- keymap("n", "<Leader>dp", function() vim.diagnostic.jump({ count = -1, float = true }) end, opt("Prev Diagnostic"))
        keymap("n", "<Leader>dq", vim.diagnostic.setloclist, opt("Set LocList"))
        keymap("n", "<Leader>dv", function()
            vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
        end, opt("Toggle diagnostic virtual_lines"))
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gf', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gH', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

        -- stylua: ignore end
    end,
})
-- }}}

-- Servers {{{

-- Lua {{{
vim.lsp.config.lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".git", vim.uv.cwd() },
    settings = {
        Lua = {
            telemetry = {
                enable = false,
            },
        },
    },
}
vim.lsp.enable("lua_ls")
-- }}}

-- Python {{{
vim.lsp.config.pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    -- on_attach = function(client, bufnr)
    --     vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
    --         local params = {
    --             command = 'pyright.organizeimports',
    --             arguments = { vim.uri_from_bufnr(bufnr) },
    --         }

    --         -- Using client.request() directly because "pyright.organizeimports" is private
    --         -- (not advertised via capabilities), which client:exec_cmd() refuses to call.
    --         -- https://github.com/neovim/neovim/blob/c333d64663d3b6e0dd9aa440e433d346af4a3d81/runtime/lua/vim/lsp/client.lua#L1024-L1030
    --         ---@diagnostic disable-next-line: param-type-mismatch
    --         client.request('workspace/executeCommand', params, nil, bufnr)
    --     end, {
    --         desc = 'Organize Imports',
    --     })
    --     vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
    --         desc = 'Reconfigure pyright with the provided python path',
    --         nargs = 1,
    --         complete = 'file',
    --     })
    -- end,
    root_markers = { "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git", "uv.lock" },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true
            }
        }
    },
}
vim.lsp.enable('pyright')

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "python",
--     callback = function()
--         local ok, venv = pcall(require, "rj.extras.venv")
--         if ok then
--             venv.setup()
--         end
--         local root = vim.fs.root(0, {
--             "pyproject.toml",
--             "setup.py",
--             "setup.cfg",
--             "requirements.txt",
--             "Pipfile",
--             "pyrightconfig.json",
--             ".git",
--             vim.uv.cwd(),
--         })
--         local client =
--             vim.lsp.start(vim.tbl_extend("force", vim.lsp.config.basedpyright, { root_dir = root }), { attach = false })
--         if client then
--             vim.lsp.buf_attach_client(0, client)
--         end
--     end,
-- })
-- vim.lsp.config.ruff = {
--     cmd = { "ruff", "server" },
--     filetypes = { "python" },
--     root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
-- }
-- vim.lsp.enable('ruff')
-- }}}

-- Go {{{
vim.lsp.config.gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gotempl", "gowork", "gomod" },
    root_markers = { ".git", "go.mod", "go.work", vim.uv.cwd() },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
            ["ui.inlayhint.hints"] = {
                compositeLiteralFields = true,
                constantValues = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
}
vim.lsp.enable("gopls")
-- }}}

-- C/C++ {{{
vim.lsp.config.clangd = {
    cmd = {
        "clangd",
        "-j=" .. 2,
        "--background-index",
        "--clang-tidy",
        "--inlay-hints",
        "--fallback-style=llvm",
        "--all-scopes-completion",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
        "--pch-storage=memory",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_markers = {
        "CMakeLists.txt",
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac",
        ".git",
        vim.uv.cwd(),
    },
}
vim.lsp.enable("clangd")
-- }}}

-- Rust {{{
vim.lsp.config.rust_analyzer = {
    filetypes = { "rust" },
    cmd = { "rust-analyzer" },
    workspace_required = true,
    root_dir = function(buf, cb)
        local root = vim.fs.root(buf, { "Cargo.toml", "rust-project.json" })
        local out = vim.system({ "cargo", "metadata", "--no-deps", "--format-version", "1" }, { cwd = root }):wait()
        if out.code ~= 0 then
            return cb(root)
        end

        local ok, result = pcall(vim.json.decode, out.stdout)
        if ok and result.workspace_root then
            return cb(result.workspace_root)
        end

        return cb(root)
    end,
    settings = {
        autoformat = false,
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
        },
    },
}
vim.lsp.enable("rust_analyzer")
-- }}}

-- Typst {{{
vim.lsp.config.tinymist = {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    root_markers = { ".git", vim.uv.cwd() },
}

vim.lsp.enable("tinymist")
-- }}}

-- Bash {{{
vim.lsp.config.bashls = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh", "zsh" },
    root_markers = { ".git", vim.uv.cwd() },
    settings = {
        bashIde = {
            globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
        },
    },
}
vim.lsp.enable("bashls")
-- }}}

-- Web-dev {{{
-- TSServer {{{
vim.lsp.config.ts_ls = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },

    init_options = {
        hostInfo = "neovim",
    },
}
-- }}}

-- CSSls {{{
vim.lsp.config.cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss" },
    root_markers = { "package.json", ".git" },
    init_options = {
        provideFormatter = true,
    },
}
-- }}}

-- TailwindCss {{{
vim.lsp.config.tailwindcssls = {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {
        "ejs",
        "html",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
    root_markers = {
        "tailwind.config.js",
        "tailwind.config.cjs",
        "tailwind.config.mjs",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.cjs",
        "postcss.config.mjs",
        "postcss.config.ts",
        "package.json",
        "node_modules",
    },
    settings = {
        tailwindCSS = {
            classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
            includeLanguages = {
                eelixir = "html-eex",
                eruby = "erb",
                htmlangular = "html",
                templ = "html",
            },
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
            },
            validate = true,
        },
    },
}
-- }}}

-- HTML {{{
vim.lsp.config.htmlls = {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    root_markers = { "package.json", ".git" },

    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        provideFormatter = true,
    },
}
-- }}}

-- PHP {{{
vim.lsp.config.intelephense = {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    root_markers = { ".git", "composer.json" },
}
-- }}}

-- Svelte {{{
vim.lsp.config.svelte = {
    cmd = { "svelteserver", "--stdio" },
    filetypes = { "svelte" },
    root_markers = { "svelte.config.js", "tsconfig.json", "package.json", ".git" },

    init_options = {
        hostInfo = "neovim",
    },
}
-- }}}

vim.lsp.enable({ "ts_ls", "cssls", "tailwindcssls", "htmlls", "intelephense", "svelte" })

-- }}}

-- Start, Stop, Restart, Log commands {{{
vim.api.nvim_create_user_command("LspStart", function()
    vim.cmd.e()
end, { desc = "Starts LSP clients in the current buffer" })

vim.api.nvim_create_user_command("LspStop", function(opts)
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if opts.args == "" or opts.args == client.name then
            client:stop(true)
            vim.notify(client.name .. ": stopped")
            Snacks.notify.info(client.name .. ": stopped")
        end
    end
end, {
    desc = "Stop all LSP clients or a specific client attached to the current buffer.",
    nargs = "?",
    complete = function(_, _, _)
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local client_names = {}
        for _, client in ipairs(clients) do
            table.insert(client_names, client.name)
        end
        return client_names
    end,
})

vim.api.nvim_create_user_command("LspRestart", function()
    local detach_clients = {}
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        client:stop(true)
        if vim.tbl_count(client.attached_buffers) > 0 then
            detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
        end
    end
    local timer = vim.uv.new_timer()
    if not timer then
        Snacks.notify.info("Servers are stopped but havent been restarted")
        return vim.notify("Servers are stopped but havent been restarted")
    end
    timer:start(
        100,
        50,
        vim.schedule_wrap(function()
            for name, client in pairs(detach_clients) do
                local client_id = vim.lsp.start(client[1].config, { attach = false })
                if client_id then
                    for _, buf in ipairs(client[2]) do
                        vim.lsp.buf_attach_client(buf, client_id)
                    end
                    Snacks.notify.info(name .. ": restarted")
                end
                detach_clients[name] = nil
            end
            if next(detach_clients) == nil and not timer:is_closing() then
                timer:close()
            end
        end)
    )
end, {
    desc = "Restart all the language client(s) attached to the current buffer",
})

vim.api.nvim_create_user_command("LspLog", function()
    vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
    desc = "Get all the lsp logs",
})

vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("silent checkhealth vim.lsp")
end, {
    desc = "Get all the information about all LSP attached",
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'go', 'php', 'css', 'html', 'js', 'ts', 'json', 'svelte', 'jsx', 'rust', 'py', 'lua', 'c' },
    callback = function() vim.treesitter.start() end,
})

-- autoimports for golang
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        -- buf_request_sync defaults to a 1000ms timeout. Depending on your
        -- machine and codebase, you may want longer. Add an additional
        -- argument after params if you find that you have to write the file
        -- twice for changes to be saved.
        -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
            end
        end
        vim.lsp.buf.format({ async = false })
    end
})

-- require('lualine_theme')
require('lualine').setup({
    options = {
        theme = 'auto'
    }
})
