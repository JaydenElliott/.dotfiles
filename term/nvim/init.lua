vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.hlsearch = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.completeopt = 'menuone,noselect'
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true


-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
    },
    {
      'max397574/better-escape.nvim',
      opts = {
        default_mappings = false,
        mappings = {
          i = { j = { k = "<Esc>" }, k = { j = "<Esc>" } },
          c = { j = { k = "<Esc>" }, k = { j = "<Esc>" } },
          t = { j = { k = "<Esc>" }, k = { j = "<Esc>" } },
        },
      }
    },
    {
      'navarasu/onedark.nvim',
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd.colorscheme('onedark')
      end,
    },
    {
      'sindrets/diffview.nvim',
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = true
    },
    {
      "j-hui/fidget.nvim",
      config = true
    },
    {
      'theprimeagen/harpoon',
      keys = {
        { "<C-q>",     function() require('harpoon.ui').nav_prev() end,          desc = "Go to previous harpoon mark" },
        { "<C-p>",     function() require('harpoon.ui').nav_next() end,          desc = "Go to next harpoon mark" },
        { "<C-t>",     function() require('harpoon.ui').toggle_quick_menu() end, desc = "Show harpoon marks" },
        { "<leader>p", function() require('harpoon.mark').add_file() end,        desc = "Mark file with harpoon" },
      }
    },
    {
      "knubie/vim-kitty-navigator",
      cmd = { "KittyNavigateRight", "KittyNavigateUp", "KittyNavigateDown", "KittyNavigateLeft", },
      keys = {
        { "<C-w>h", "<cmd>KittyNavigateLeft<cr>", },
        { "<C-w>j", "<cmd>KittyNavigateDown<cr>", },
        { "<C-w>k", "<cmd>KittyNavigateUp<cr>", },
        { "<C-w>l", "<cmd>KittyNavigateRight<cr>", },
      },
      config = function()
        vim.g.kitty_navigator_no_mappings = 1
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
      keys = { { "\\", "<cmd>Neotree reveal left<cr>" } },
      init = function()
        vim.api.nvim_create_augroup("neotree_start", { clear = true })
        vim.api.nvim_create_autocmd("BufEnter", {
          desc = "Open Neo-Tree on startup with directory",
          group = "neotree_start",
          callback = function()
            if vim.fn.isdirectory(vim.api.nvim_buf_get_name(0)) == 1 then
              require("neo-tree.setup.netrw").hijack()
            end
          end,
        })
      end,
      opts = {
        filesystem = {
          hijack_netrw_behavior = "open_current",
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
          }
        },
        event_handlers = {
          {
            event = "file_opened",
            handler = function() require("neo-tree.command").execute({ action = "close" }) end
          },
          {
            event = "vim_buffer_enter",
            handler = function()
              if vim.bo.filetype == "neo-tree" then
                vim.opt.relativenumber = true
                vim.opt.number = true
              end
            end,
          },
        },
      },
    },
    {
      'preservim/nerdcommenter',
    },
    {
      "folke/todo-comments.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      config = true
    },

    {
      'petertriho/nvim-scrollbar',
      config = true
    },
    {
      "kylechui/nvim-surround",
      version = "*",
      event = "VeryLazy",
      config = true
    },
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        "nvim-telescope/telescope-file-browser.nvim",
        "smilovanovic/telescope-search-dir-picker.nvim",
        "debugloop/telescope-undo.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      },
      keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>",                            desc = "[F]ind [F]iles" },
        { "<leader>fF", "<cmd>Telescope search_dir_picker<cr>",                     desc = "[F]ind dir then grep" },
        { "<leader>fh", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "[F]ind [H]idden" },
        { "<leader>fw", "<cmd>Telescope grep_string<cr>",                           desc = "[F]ind current [W]ord" },
        { "<leader>fg", "<cmd>Telescope live_grep_args<cr>",                        desc = "[F]ind by [G]rep" },
        { "<leader>fu", "<cmd>Telescope undo<cr>",                                  desc = "[F]ind [U]ndo" },
        { "<leader>df", "<cmd>Telescope diagnostics<cr>",                           desc = "[D]iagnostics find by [F]ile" },
        { "gr",         "<cmd>Telescope lsp_references<cr>",                        desc = "[G]oto [R]eferences" },
        {
          "<C-r>",
          function() require('telescope.builtin').resume() end,
          mode = "i",
          desc = "Resume previous search"
        },
        {
          "<leader>f/",
          function()
            require('telescope.builtin').current_buffer_fuzzy_find(
              require('telescope.themes').get_dropdown({ winblend = 10, previewer = false })
            )
          end,
          desc = '[/] Fuzzily search in current buffer'
        },
      },
      config = function()
        local telescope = require('telescope')
        local lga_actions = require("telescope-live-grep-args.actions")

        vim.cmd('autocmd User TelescopePreviewerLoaded setlocal wrap')

        telescope.setup({
          pickers = {
            lsp_references = {
              show_line = false,
              include_declaration = false,
              include_current_line = false,
            }
          },
          extensions = {
            live_grep_args = {
              auto_quoting = true,
              mappings = {
                i = {
                  ["<C-k>"] = lga_actions.quote_prompt(),
                  ["<C-l>"] = lga_actions.quote_prompt({ postfix = " config " }),
                  ["<C-h>"] = lga_actions.quote_prompt({ postfix = " --no-ignore --hidden" }),
                },
              },
            },
          },
        })

        -- Load extensions
        telescope.load_extension('fzf')
        telescope.load_extension('live_grep_args')
        telescope.load_extension('search_dir_picker')
        telescope.load_extension('undo')
      end
    },

    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      opts = {
        ensure_installed = {
          'bash', 'c', 'cpp', 'go', 'json', 'just', 'lua',
          'python', 'rust', 'sql', 'toml', 'tsx', 'vim', 'vimdoc', 'wgsl'
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      }
    },
    { "mason-org/mason.nvim", config = true },
    { "neovim/nvim-lspconfig" },
    {
      "mason-org/mason-lspconfig.nvim",
      dependencies = { "neovim/nvim-lspconfig", "mason-org/mason.nvim", "hrsh7th/nvim-cmp" },
      opts = {
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "clangd",
          "bashls",
          "jsonls",
          "pyright",
          "taplo"
        },

        servers = {
          rust_analyzer = {
            cargo = { features = "all" },
            procMacro = { enable = true },
            inlayHints = {
              bindingModeHints = { enable = true },
              closureCaptureHints = { enable = true },
              closureReturnTypeHints = { enable = true },
              expressionAdjustmentHints = { enable = true }
            },
            diagnostics = { enable = true },
          },
          lua_ls = { Lua = { format = { enable = true } } },
        },
      },
      config = function(_, opts)
        local lspconfig = require('lspconfig')

        local on_attach = function(_, _)
          vim.cmd('autocmd BufWritePre * lua vim.lsp.buf.format()')
          if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { 0 })
          end
        end

        local capabilities = vim.tbl_deep_extend(
          "force",
          {},
          vim.lsp.protocol.make_client_capabilities(),
          require("cmp_nvim_lsp").default_capabilities()
        )

        for server, config in pairs(opts.servers) do
          config.capabilities = capabilities
          config.on_attach = on_attach
          lspconfig[server].setup(config)
        end
      end
    },
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        {
          'L3MON4D3/LuaSnip',
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end
        },
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require('luasnip')

        cmp.setup({
          sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lsp_document_symbol' },
            { name = 'buffer' },
          },
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          }),
        })
      end
    },
  }
)


-- Window management
vim.keymap.set("n", "<C-w><C-s>", vim.cmd.split, { noremap = true })
vim.keymap.set("n", "<C-w><C-v>", vim.cmd.vsplit, { noremap = true })
vim.keymap.set("n", "<C-w><C-h>", "<cmd>wincmd h<cr>", { noremap = true })
vim.keymap.set("n", "<C-w><C-j>", "<cmd>wincmd j<cr>", { noremap = true })
vim.keymap.set("n", "<C-w><C-k>", "<cmd>wincmd k<cr>", { noremap = true })
vim.keymap.set("n", "<C-w><C-l>", "<cmd>wincmd l<cr>", { noremap = true })

-- Diagnostic navigation
vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
  { desc = 'Go to previous error' })
vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
  { desc = 'Go to next error' })
vim.keymap.set("n", "]q", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
  { desc = 'Go to next error' })
vim.keymap.set("n", "[q", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
  { desc = 'Go to previous error' })
vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Center cursor during movement
vim.keymap.set("n", "J", "mzJ`z", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { noremap = true })
vim.keymap.set("n", "<C-o>", "<C-o>zz", { noremap = true })
vim.keymap.set("n", "*", "*zz", { noremap = true })
vim.keymap.set("n", "#", "#zz", { noremap = true })

-- LSP
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = '[G]oto [A]ction', })
vim.keymap.set('n', '<leader>rw', vim.lsp.buf.rename, { desc = '[R]ename [W]ord', })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation', })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition', })
vim.keymap.set('n', '<leader>kd', vim.lsp.buf.signature_help, { desc = 'Signature Documentation', })


-- Other keympaps
vim.api.nvim_create_user_command('W', 'noautocmd w', {})                            -- save without formatting
vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format() end, {}) -- format without saving
vim.keymap.set('v', 'p', 'pgvy', { noremap = true })                                -- dont override paste
vim.keymap.set("n", "<leader>u", 'i"<C-r>=system("uuidgen")[:-2]<CR>",<Esc>')       -- generate UUID
vim.api.nvim_create_user_command('Diff', 'DiffviewOpen', {})                        -- git diff
