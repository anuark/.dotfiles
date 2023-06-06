-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
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
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gf', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gR', ':Telescope lsp_references<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', ':Telescope lsp_definitions<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gT', ':Telescope lsp_type_definitions<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gS', ':Telescope lsp_document_symbols<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', ':Telescope lsp_implementations<CR>', opts)
    -- Diagnostics
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':Telescope diagnostics<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gH', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

-- local coq = require "coq"
-- lsp.<server>.setup(coq.lsp_ensure_capabilities())
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = coq.lsp_ensure_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()
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
        },
        Lua = {
            diagnostics = {
                globals = {'vim'}
            }
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
    'lua_ls',
    'intelephense',
    'rust_analyzer',
    'solc',
    'tailwindcss'
}

for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup(lspSetup)
    -- require('lspconfig')[lsp].setup(coq.lsp_ensure_capabilities(lspSetup))
    -- require('lspconfig')[lsp].setup(coq.lsp_ensure_capabilities())
end

