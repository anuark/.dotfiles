-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

require 'nvim-treesitter.configs'.setup {
    sync_install = false,
    ensure_install = { "help", "go", "javascript", "typescript", "rust", "lua" },
    auto_install = true,

    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}

require 'treesitter-context'.setup {
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

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20,     -- The Z-index of the context window
    mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
}

-- require('todo-comments').setup {
--     -- your configuration comes here
--     -- or leave it empty to use the default settings
--     -- refer to the configuration section below
--     highlight = {
--         before = "bg",                   -- "fg" or "bg" or empty
--         keyword = "wide",                -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
--         after = "fg",                    -- "fg" or "bg" or empty
--         pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
--         comments_only = true,            -- uses treesitter to match keywords in comments only
--         max_line_len = 400,              -- ignore lines longer than this
--         exclude = {},                    -- list of file types to exclude highlighting
--     },
-- }

require('telescope').setup {
    defaults = {
        layout_strategy = 'flex',
        -- layout_config = {
        --     height = 0.80,
        --     width = 0.80,
        --     horizontal = {
        --         preview_width = 80
        --     },
        --     vertical = {
        --         preview_width = 50
        --     }
        -- },
    },
    pickers = {
        find_files = {
            -- theme = "dropdown",
            prompt_prefix = "🔍 ",
            hidden = true,
            file_ignore_patterns = { ".git", "node_modules" }
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            hidden = true,
            -- the default case_mode is "smart_case"
        },
        -- file_browser = {
        --     -- theme = "ivy",
        --     hijack_netrw = true,
        --     hidden = true,
        --     -- mappings = {
        --     --     ["i"] = {
        --     --         -- your custom insert mode mappings
        --     --     },
        --     --     ["n"] = {
        --     --         -- your custom normal mode mappings
        --     --     },
        --     -- },
        -- },
    },
}
require('telescope').load_extension('fzf')
-- require('telescope').load_extension('file_browser')
-- require('telescope').load_extension('emoji')

require('toggleterm').setup {
    size = 16,
    open_mapping = [[<c-\>]],
    direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float',
    auto_scroll = false,
    winbar = {
        enabled = true,
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
        winblend = 5,
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

local Terminal        = require('toggleterm.terminal').Terminal
local lazygitTerminal = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float', count = 5 })
-- local yaziTerminal    = Terminal:new({ cmd = "yazi", hidden = true, direction = 'float', count = 6 })

function Lazygit_toggle()
    lazygitTerminal:toggle()
end

-- function Yazi_toggle()
--     yaziTerminal:toggle()
-- end

vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>lua Lazygit_toggle()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua Yazi_toggle()<CR>", { noremap = true, silent = true })

-- nvim-cmp.
vim.opt.completeopt = "menu,menuone,noselect"
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',     -- show only symbol annotations
            maxwidth = 50,       -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            -- before = function (entry, vim_item)
            --   return vim_item
            -- end
        })
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },   -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        { name = 'buffer' },
    })
})

-- trouble
-- require'trouble'.setup()
-- vim.keymap.set("n", "<leader>x", "<cmd>TroubleToggle<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
--   {silent = true, noremap = true}
-- )

-- require("zen-mode").setup {
--     window = {
--         width = 90,
--         options = {
--             number = true,
--             relativenumber = true,
--         }
--     },
-- }
-- 
-- vim.keymap.set("n", "<leader>zz", function()
--     require("zen-mode").toggle()
--     vim.wo.wrap = false
-- end)

-- require('lualine').setup({
--     options = {
--         theme = 'everforest'
--     }
-- })

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

-- oil.nvim
require("oil").setup({
  -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
  -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
  default_file_explorer = true,
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  columns = {
    "icon",
    -- "permissions",
    -- "size",
    -- "mtime",
  },
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  -- Window-local options to use for oil buffers
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
  delete_to_trash = false,
  -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
  skip_confirm_for_simple_edits = false,
  -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
  -- (:help prompt_save_on_select_new_entry)
  prompt_save_on_select_new_entry = true,
  -- Oil will automatically delete hidden buffers after this delay
  -- You can set the delay to false to disable cleanup entirely
  -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
  cleanup_delay_ms = 2000,
  lsp_file_methods = {
    -- Enable or disable LSP file operations
    enabled = true,
    -- Time to wait for LSP file operations to complete before skipping
    timeout_ms = 1000,
    -- Set to true to autosave buffers that are updated with LSP willRenameFiles
    -- Set to "unmodified" to only save unmodified buffers
    autosave_changes = false,
  },
  -- Constrain the cursor to the editable parts of the oil buffer
  -- Set to `false` to disable, or "name" to keep it on the file names
  constrain_cursor = "editable",
  -- Set to true to watch the filesystem for changes and reload oil
  watch_for_changes = false,
  -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("oil.actions").<name>
  -- Set to `false` to remove a keymap
  -- See :help oil-actions for a list of all available actions
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = { "actions.close", mode = "n" },
    ["<C-l>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = true,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      local m = name:match("^%.")
      return m ~= nil
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return false
    end,
    -- Sort file names with numbers in a more intuitive order for humans.
    -- Can be "fast", true, or false. "fast" will turn it off for large directories.
    natural_order = "fast",
    -- Sort file and directory names case insensitive
    case_insensitive = false,
    sort = {
      -- sort order can be "asc" or "desc"
      -- see :help oil-columns to see which columns are sortable
      { "type", "asc" },
      { "name", "asc" },
    },
    -- Customize the highlight group for the file name
    highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
      return nil
    end,
  },
  -- Extra arguments to pass to SCP when moving/copying files over SSH
  extra_scp_args = {},
  -- EXPERIMENTAL support for performing file operations with git
  git = {
    -- Return true to automatically git add/mv/rm files
    add = function(path)
      return false
    end,
    mv = function(src_path, dest_path)
      return false
    end,
    rm = function(path)
      return false
    end,
  },
  -- Configuration for the floating window in oil.open_float
  float = {
    -- Padding around the floating window
    padding = 2,
    -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
    get_win_title = nil,
    -- preview_split: Split direction: "auto", "left", "right", "above", "below".
    preview_split = "auto",
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
  -- Configuration for the file preview window
  preview_win = {
    -- Whether the preview window is automatically updated when the cursor is moved
    update_on_cursor_moved = true,
    -- How to open the preview window "load"|"scratch"|"fast_scratch"
    preview_method = "fast_scratch",
    -- A function that returns true to disable preview on a file e.g. to avoid lag
    disable_preview = function(filename)
      return false
    end,
    -- Window-local options to use for preview window buffers
    win_options = {},
  },
  -- Configuration for the floating action confirmation window
  confirmation = {
    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a single value or a list of mixed integer/float types.
    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
    max_width = 0.9,
    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
    min_width = { 40, 0.4 },
    -- optionally define an integer/float for the exact width of the preview window
    width = nil,
    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a single value or a list of mixed integer/float types.
    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
    max_height = 0.9,
    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
    min_height = { 5, 0.1 },
    -- optionally define an integer/float for the exact height of the preview window
    height = nil,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating progress window
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating SSH window
  ssh = {
    border = "rounded",
  },
  -- Configuration for the floating keymaps help window
  keymaps_help = {
    border = "rounded",
  },
})
