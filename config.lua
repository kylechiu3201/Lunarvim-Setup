--[[
THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
`lvim` is the global options object
]]

-- Enable powershell as your default shell
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

-- Set a compatible clipboard manager
vim.g.clipboard = {
    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
    },
}

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "vscode"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = false
-- lvim.builtin.terminal.shell = "pwsh.exe -NoLogo"

-- nvim-tree has some performance issues on windows, see kyazdani42/nvim-tree.lua#549
lvim.builtin.nvimtree.setup.diagnostics.enable = false
lvim.builtin.nvimtree.setup.filters.custom = {}
lvim.builtin.nvimtree.setup.git.enable = false
lvim.builtin.nvimtree.setup.update_cwd = false
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.git_hl = false
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "c",
    "lua",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }



-- User-Added Configurations
-- Additional Plugins
lvim.plugins = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "folke/lsp-colors.nvim",
        event = "BufRead",
        config = function()
            require("lsp-colors").setup({
                Error = "#db4b4b",
                Warning = "#e0af68",
                Information = "#0db9d7",
                Hint = "#10B981"
            })
        end
    },
    { "folke/trouble.nvim",
        config = function()
            require("trouble").setup({})
        end
    },
    { "gennaro-tedesco/nvim-peekup" },
    { "Mofiqul/vscode.nvim" },
    { "tpope/vim-fugitive" },
    { "folke/twilight.nvim",
        config = function()
            require("twilight").setup({})
        end
    },
    { "kylechiu3201/nvim-pqf",
        config = function()
            require("pqf").setup({})
        end
    },
    { "akinsho/git-conflict.nvim",
        config = function()
            require("git-conflict").setup({})
        end
    },
    { "farmergreg/vim-lastplace",
        config = function()
            require("lastplace").setup({
                open_folds = true
            })
        end
    },
    { "jremmen/vim-ripgrep" },
    { "onsails/diaglist.nvim",
        config = function()
            require("diaglist").init({
                debug = false,
                debounce_ms = 150
            })
        end
    },
    { "andymass/vim-matchup" },
    { "onsails/lspkind.nvim" },
    { "tpope/vim-sleuth" },
    { "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup({})
        end
    },
    { "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                show_current_context = true,
                show_current_context_start = true,
                use_treesitter = true,
                show_end_of_file = true,
                use_treesitter_scope = false
            })
        end
    },
    { "ntpeters/vim-better-whitespace",
        config = function()
            require("better-whitespace").setup({
                current_line_whitespace_disabled_soft = true
                -- current_line_whitespace_disabled_hard = true
            })
        end
    },
    { "simrat39/symbols-outline.nvim" },
    { "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim"
    },
    { "" },
    { "" },
}



-- user config
    vim.api.nvim_command('set relativenumber number nocp noerrorbells nowrap hidden cursorline encoding=utf8 history=1000 termguicolors')
    vim.api.nvim_command('set shiftwidth=4 tabstop=4 expandtab softtabstop=4 autoindent smartindent')
    vim.api.nvim_command("set foldmethod=manual foldtext=getline(v:foldstart).'...'.trim(getline(v:foldend))")
    vim.keymap.set('n', '<C-j>', '<C-d>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-k>', '<C-u>', { noremap = true, silent = true })
    vim.keymap.set('n', '<S-h>', '^', { noremap = true, silent = true })
    vim.keymap.set('n', '<S-l>', '$', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-h>', ':bp<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-l>', ':bn<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-f><C-h>', ':tabp<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-f><C-l>', ':tabn<CR>', { noremap = true, silent = true })
    vim.g.vscode_style = "dark"
    lvim.format_on_save = false -- <leader>lf to manually format file

-- telescope.nvim config
    vim.keymap.set('n', '<space>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>fb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>fh', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })

-- nvim-treesitter config
    require 'nvim-treesitter.install'.compilers = { "clang" }

-- bufferline.nvim config

-- nvim-tree.lua config
    vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    -- has a lot of keymappings

-- Comment.nvim config

-- project.nvim config

-- LuaSnip config

-- structlog.nvim config

-- nvim-lspconfig config
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
    -- vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-g>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })

-- friendly-snippets config

-- nlsp-settings.nvim config

-- lualine.nvim config

-- nvim-notify config
    vim.keymap.set('n', '<space>n', ':Notifications<CR>', { noremap = true, silent = true })

-- DAPInstall.nvim config

-- toggleterm.nvim config

-- nvim-dap config




-- trouble.nvim config
    vim.keymap.set('n', '<space>tw', '<cmd>TroubleToggle workspace_diagnostics<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>td', '<cmd>TroubleToggle document_diagnostics<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>tq', '<cmd>TroubleToggle quickfix<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>tl', '<cmd>TroubleToggle loclist<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', 'gR', '<cmd>TroubleToggle lsp_references<CR>', { noremap = true, silent = true })

-- nvim-peekup config
    -- activate with "" in normal mode

-- twilight.nvim config
    vim.keymap.set('n', '<space>tt', ':Twilight<CR>', { noremap = true, silent = true })

-- git-conflict.nvim config
    -- ct: choose theirs
    -- cb: choose both
    -- c0: choose none
    -- ]x: previous conflict
    -- [x: next conflict

-- vim-matchup config
    require("nvim-treesitter.configs").setup({
        matchup = {
            enable = true
        }
    })

-- lspkind.nvim config
    local lspkind = require('lspkind')
    local cmp = require("cmp")
    cmp.setup({
      formatting = {
        format = lspkind.cmp_format({
        mode = 'symbol', -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

         -- The function below will be called before any actual modifications from lspkind
         -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
         -- before = function (entry, vim_item)
         --   ...
         --   return vim_item
         -- end
        })
      }
    })

-- symbols-outline.nvim config
    vim.keymap.set('n', '<space>lo', ':SymbolsOutline<CR>0', { noremap = true, silent = true })
    -- Enter: Go to symbol location in code
    -- o: Go to symbol location in code without losing focus
    -- <C-Space>: Hover current symbol
    -- K: Toggles the current symbol preview
    -- r: Rename symbol
    -- a: Code actions
    -- ?: Show help message

-- diffview.nvim config
    vim.keymap.set('n', '<space>do', ':DiffviewOpen<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<space>dc', ':DiffviewClose<CR>', { noremap = true, silent = true })
