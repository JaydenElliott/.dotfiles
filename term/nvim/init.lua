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


local general_keymaps = {
  -- Window management
  { "<C-w><C-s>", vim.cmd.split,                               desc = "Split horizontal" },
  { "<C-w><C-v>", vim.cmd.vsplit,                              desc = "Split vertical" },
  { "<C-w><C-h>", "<cmd>wincmd h<cr>",                         desc = "Go to left window" },
  { "<C-w><C-j>", "<cmd>wincmd j<cr>",                         desc = "Go to window below" },
  { "<C-w><C-k>", "<cmd>wincmd k<cr>",                         desc = "Go to window above" },
  { "<C-w><C-l>", "<cmd>wincmd l<cr>",                         desc = "Go to right window" },

  -- Center cursor
  { "J",          "mzJ`z",                                     desc = "Join lines and restore cursor" },
  { "<C-d>",      "<C-d>zz",                                   desc = "Scroll down half page and center" },
  { "<C-u>",      "<C-u>zz",                                   desc = "Scroll up half page and center" },
  { "n",          "nzz",                                       desc = "Next search result and center" },
  { "<C-i>",      "<C-i>zz",                                   desc = "Jump forward and center" },
  { "<C-o>",      "<C-o>zz",                                   desc = "Jump back and center" },
  { "*",          "*zz",                                       desc = "Search word under cursor and center" },
  { "#",          "#zz",                                       desc = "Search word under cursor backwards and center" },

  -- quickfix
  { "<leader>[",  "<cmd>cprev<cr>",                            desc = "Previous quickfix item" },
  { "<leader>]",  "<cmd>cnext<cr>",                            desc = "Next quickfix item" },

  -- Other
  { "p",          "pgvy",                                      mode = "v",                                            desc = "Paste without overriding register" },
  { "<leader>u",  'i"<C-r>=system("uuidgen")[:-2]<CR>",<Esc>', desc = "Generate UUID" },
}

local plugin_keymaps = {
  -- harpoon
  { "<C-q>",      function() require('harpoon.ui').nav_prev() end,            desc = "Go to previous harpoon mark" },
  { "<C-p>",      function() require('harpoon.ui').nav_next() end,            desc = "Go to next harpoon mark" },
  { "<C-t>",      function() require('harpoon.ui').toggle_quick_menu() end,   desc = "Show harpoon marks" },
  { "<leader>a",  function() require('harpoon.mark').add_file() end,          desc = "Mark file with harpoon" },

  -- vim-kitty-navigator
  { "<C-w>h",     "<cmd>KittyNavigateLeft<cr>",                               desc = "Navigate to left pane (Kitty)" },
  { "<C-w>j",     "<cmd>KittyNavigateDown<cr>",                               desc = "Navigate to pane below (Kitty)" },
  { "<C-w>k",     "<cmd>KittyNavigateUp<cr>",                                 desc = "Navigate to pane above (Kitty)" },
  { "<C-w>l",     "<cmd>KittyNavigateRight<cr>",                              desc = "Navigate to right pane (Kitty)" },

  -- neotree
  { "\\",         "<cmd>Neotree reveal left<cr>",                             desc = "Toggle Neo-tree" },

  -- telescope
  { "<leader>ff", "<cmd>Telescope find_files<cr>",                            desc = "Find Files" },
  { "<leader>fF", "<cmd>Telescope search_dir_picker<cr>",                     desc = "Find dir then grep" },
  { "<leader>fh", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "Find Hidden" },
  { "<leader>fw", "<cmd>Telescope grep_string<cr>",                           desc = "Find current Word" },
  { "<leader>fg", "<cmd>Telescope live_grep_args<cr>",                        desc = "Find by Grep" },
  { "<leader>fu", "<cmd>Telescope undo<cr>",                                  desc = "Find Undo" },
  { "<leader>df", "<cmd>Telescope diagnostics<cr>",                           desc = "Diagnostics find by File" },
  { "gr",         "<cmd>Telescope lsp_references<cr>",                        desc = "Goto References" },
  { "<C-r>",      function() require('telescope.builtin').resume() end,       mode = "i",                             desc = "Resume previous search" },
  {
    "<leader>f/",
    function()
      require('telescope.builtin').current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown({ winblend = 10, previewer = false })
      )
    end,
    desc = "Fuzzily search in current buffer"
  },
}


local lsp_keymaps = {
  -- diagnostics
  { "<leader>dp", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Go to previous error" },
  { "<leader>dn", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Go to next error" },
  { "]q",         function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Go to next error" },
  { "[q",         function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Go to previous error" },
  { "<leader>do", vim.diagnostic.open_float,                                                             desc = "Open floating diagnostic message" },

  -- lsp
  { "ga",         vim.lsp.buf.code_action,                                                               desc = "Goto Action" },
  { "<leader>rw", vim.lsp.buf.rename,                                                                    desc = "Rename Word" },
  { "K",          vim.lsp.buf.hover,                                                                     desc = "Hover Documentation" },
  { "gd",         vim.lsp.buf.definition,                                                                desc = "Goto Definition" },
}

-- key bindings helper
local function set_keymaps(keymaps, buffer)
  for _, keymap in ipairs(keymaps) do
    local mode = keymap.mode or 'n'
    local opts = { desc = keymap.desc, buffer = buffer }
    vim.keymap.set(mode, keymap[1], keymap[2], opts)
  end
end

set_keymaps(general_keymaps)
set_keymaps(plugin_keymaps)


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
    },
    {
      "knubie/vim-kitty-navigator",
      cmd = { "KittyNavigateRight", "KittyNavigateUp", "KittyNavigateDown", "KittyNavigateLeft", },
      config = function()
        vim.g.kitty_navigator_no_mappings = 1
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
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
          "rust_analyzer",
          "lua_ls",
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
          clangd = {},
          bashls = {},
          jsonls = {},
          pyright = {},
          taplo = {},
        },
      },
      config = function(_, opts)
        local lspconfig = require('lspconfig')


        local on_attach = function(_, bufnr)
          set_keymaps(lsp_keymaps, bufnr)

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


-- custom commands
vim.api.nvim_create_user_command('W', 'noautocmd w', {})                            -- save without formatting
vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format() end, {}) -- format without saving
vim.api.nvim_create_user_command('Diff', 'DiffviewOpen', {})                        -- git diff
