-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- telescope git
vim.api.nvim_set_keymap("n", "<leader>gc", ":Telescope git_commits<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gd", ":Telescope git_bcommits<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gb", ":Telescope git_branches<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gss", ":Telescope git_status<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gst", ":Telescope git_stash<CR>", opts)

-- telescope file browser
vim.api.nvim_set_keymap("n", "<leader>e", ":Telescope file_browser<CR>", opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gS', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gF', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gH', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    -- LSP telescope
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gR', ':Telescope lsp_references<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', ':Telescope lsp_definitions<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gT', ':Telescope lsp_type_definitions<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gS', ':Telescope lsp_document_symbols<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', ':Telescope lsp_implementations<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gF', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
    -- Diagnostics
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':Telescope diagnostics<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gH', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local coq = require "coq"
-- lsp.<server>.setup(coq.lsp_ensure_capabilities())
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = coq.lsp_ensure_capabilities()
local lspSetup = {
    on_attach = on_attach,
    flags = {
        -- This will be the default in neovim 0.7+
        debounce_text_changes = 150,
        composites = false,
    },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                composites = false,
            },
            staticcheck = true,
        }
    },
    capabilities = capabilities
}
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
local servers = {
    'pyright',
    'gopls',
    'tsserver',
    'vimls',
    'eslint',
    'cssls',
    'jsonls',
    'sumneko_lua',
    'intelephense',
    'rust_analyzer',
    'solc',
    'tailwindcss'
}
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup(lspSetup)
    require('lspconfig')[lsp].setup(coq.lsp_ensure_capabilities(lspSetup))
    -- require('lspconfig')[lsp].setup(coq.lsp_ensure_capabilities())
end

-- util = require "lspconfig/util"
-- require('lspconfig')['gopls'].setup {
--   cmd = {"gopls", "serve"},
--   filetypes = {"go", "gomod"},
--   root_dir = util.root_pattern("go.work", "go.mod", ".git"),
--   settings = {
--     gopls = {
--       analyses = {
--         unusedparams = true,
--         composites = false,
--       },
--       staticcheck = true,
--     },
--   },
-- }

require 'nvim-treesitter.configs'.setup {
    sync_install = false,

    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}

require 'treesitter-context'.setup {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            -- 'for', -- These won't appear in the context
            -- 'while',
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

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
}

require('todo-comments').setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    highlight = {
        before = "bg", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
    },
}

require('telescope').setup {
    defaults = {
        layout_strategy = 'flex',
        layout_config = {
            height = 0.90,
            width = 0.90,
            horizontal = {
                preview_width = 80
            }
        },
    },
    pickers = {
        find_files = {
            -- theme = "dropdown",
            prompt_prefix = "🔍 "
        }
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        file_browser = {
            -- theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                },
                ["n"] = {
                    -- your custom normal mode mappings
                },
            },
        },
    },
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('emoji')

require('toggleterm').setup {
    size = 20,
    open_mapping = [[<c-\>]],
    direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float',
    winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
            return term.name
        end
    },
    persist_mode = true,
    float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        -- like `size`, width and height can be a number or function which is passed the current terminal
        -- winblend = 3,
    },
}

function _G.set_terminal_keymaps()
    for from, to in pairs {
        ["`"] = [[<C-\><C-n>]],
        ["<C-w>"] = [[<C-\><C-o><C-w>]],
    } do
        vim.api.nvim_buf_set_keymap(0, "t", from, to, {
            noremap = true,
            silent = true
        })
    end
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float', count = 5 })

function Lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>lua Lazygit_toggle()<CR>", { noremap = true, silent = true })

require("transparent").setup({
    enable = false, -- boolean: enable transparent
    extra_groups = { -- table/string: additional groups that should be cleared
        "BufferLineTabClose",
        "BufferlineBufferSelected",
        "BufferLineFill",
        "BufferLineBackground",
        "BufferLineSeparator",
        "BufferLineIndicatorSelected",
    },
    exclude = {}, -- table: groups you don't want to clear
})

