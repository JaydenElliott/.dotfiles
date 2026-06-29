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
vim.opt.diffopt = "vertical"

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    -- Treesitter TSUpdate after installs/updates
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      if not ev.data.active then
        vim.
            cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
    end
  end
})

vim.pack.add({
  -- editing
  { src = 'https://github.com/windwp/nvim-autopairs' },
  { src = 'https://github.com/max397574/better-escape.nvim' },
  { src = 'https://github.com/kylechui/nvim-surround' },
  { src = 'https://github.com/preservim/nerdcommenter' },
  { src = 'https://github.com/folke/todo-comments.nvim' },

  -- ui
  { src = 'https://github.com/navarasu/onedark.nvim' },
  { src = 'https://github.com/j-hui/fidget.nvim' },
  { src = 'https://github.com/petertriho/nvim-scrollbar' },

  -- navigation
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/knubie/vim-kitty-navigator' },
  { src = 'https://github.com/mikesmithgh/kitty-scrollback.nvim' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },

  -- treesitter
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter',  version = 'main' },

  -- lsp
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },

  -- completion
  { src = 'https://github.com/hrsh7th/nvim-cmp' },
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
  { src = 'https://github.com/hrsh7th/cmp-buffer' },

  -- dependencies
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
})





vim.cmd.colorscheme('onedark')

require('nvim-autopairs').setup()
require('fidget').setup()
require('scrollbar').setup()
require('nvim-surround').setup()
require('todo-comments').setup()
require('better_escape').setup({
  default_mappings = false,
  mappings = {
    i = { j = { k = "<Esc>" }, k = { j = "<Esc>" } },
    c = { j = { k = "<Esc>" }, k = { j = "<Esc>" } },
    t = { j = { k = "<Esc>" }, k = { j = "<Esc>" } },
  },
})

vim.g.kitty_navigator_no_mappings = 1


-- Neotree
require('neo-tree').setup({
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
})
vim.keymap.set('n', "\\", "<cmd>Neotree reveal left<cr>")

-- Oil
require('oil').setup()
vim.keymap.set('n', "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- Treesitter
require('nvim-treesitter.config').setup({
  ensure_installed = {
    'c', 'cpp', 'go', 'lua', 'python', 'rust', 'wgsl', 'tsx',
    'vimdoc', 'vim', 'sql', 'bash', 'toml', 'json', 'make', 'dockerfile'
  },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = { "make", "dockerfile" },
  },
  indent = { enable = true },
})

-- FZF lua
require('fzf-lua').setup({
  winopts = {
    preview = {
      layout = 'flex',
    },
  },
  files = {
    fd_opts = "--color=never --type f --hidden --follow --exclude .git",
  },
  grep = {
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git'",
  },
  lsp = {
    references = {
      includeDeclaration = false,
    },
  },
  keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    },
  },
})

vim.keymap.set('n', "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find Files" })
vim.keymap.set('n', "<leader>fF", function()
  require('fzf-lua').files({ fd_opts = "--color=never --type f --hidden --no-ignore --exclude .git" })
end, { desc = "Find Files (no ignore)" })
vim.keymap.set('n', "<leader>fh", function()
  require('fzf-lua').files({ fd_opts = "--color=never --type f --hidden --no-ignore --exclude .git" })
end, { desc = "Find Hidden" })
vim.keymap.set('v', "<leader>fv", "<cmd>FzfLua grep_visual<cr>", { desc = "Find visual selection" })
vim.keymap.set('n', "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Find by Grep" })
vim.keymap.set('n', "<leader>fG", function()
  require('fzf-lua').live_grep({
    rg_opts =
    "--column --line-number --no-heading --color=always --smart-case --hidden --no-ignore-dot -g '!.git'"
  })
end, { desc = "Find by Grep (no .ignore)" })
vim.keymap.set('n', "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", { desc = "Diagnostics" })
vim.keymap.set('n', "<leader>f/", "<cmd>FzfLua lgrep_curbuf<cr>", { desc = "Fuzzy search current buffer" })
vim.keymap.set('n', "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "Goto References" })
vim.keymap.set('i', "<C-r>", "<cmd>FzfLua resume<cr>", { desc = "Resume previous search" })


-- LSP
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'rust_analyzer', 'lua_ls', 'clangd', 'jsonls', 'pyright' },
})

vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      cargo = { features = 'all' },
      procMacro = { enable = true },
      inlayHints = {
        bindingModeHints = { enable = true },
        closureCaptureHints = { enable = true },
        closureReturnTypeHints = { enable = 'always' },
        expressionAdjustmentHints = { enable = 'never' }, -- keep general type hints but remove pointer/reference hints e.g. (&(* <TYPE>))
      },
      diagnostics = {
        enable = true,
        disabled = { 'macro-error' },
      },
    },
  },
})


vim.lsp.enable({ 'rust_analyzer', 'clangd', 'jsonls', 'pyright' })

-- LSP keymaps (global — only act when an LSP is attached)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', '<leader>rw', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = 'Open diagnostic' })
vim.keymap.set('n', '<leader>dp',
  function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end,
  { desc = 'Previous error' })
vim.keymap.set('n', '<leader>dn',
  function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Next error' })
vim.keymap.set('n', '[q', function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end,
  { desc = 'Previous error' })
vim.keymap.set('n', ']q', function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end,
  { desc = 'Next error' })

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function() vim.lsp.buf.format() end,
})

-- Inlay hints
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
  end,
})


-- Completion
local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
  snippet = {
    expand = function(args) vim.snippet.expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-j>']     = cmp.mapping.select_next_item(),
    ['<C-k>']     = cmp.mapping.select_prev_item(),
    ['<C-u>']     = cmp.mapping.scroll_docs(-4),
    ['<C-d>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>']      = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    ['<Tab>']     = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item() else fallback() end
    end, { 'i', 's' }),
    ['<S-Tab>']   = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item() else fallback() end
    end, { 'i', 's' }),
  }),
})


-- Copy absolute path of current file to clipboard
vim.api.nvim_create_user_command('Path', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  print('Copied: ' .. path)
end, {})

-- Capture the cwd at startup so :cd later doesn't affect :PathR
local _startup_cwd = vim.fn.getcwd()

-- Copy path relative to the *parent* of where nvim was started (includes the project root name)
vim.api.nvim_create_user_command('PathR', function()
  local abs = vim.fn.expand('%:p')
  local strip = vim.fn.fnamemodify(_startup_cwd, ':h')
  local rel
  if abs:sub(1, #strip) == strip then
    rel = abs:sub(#strip + 2)
  else
    rel = abs
  end
  vim.fn.setreg('+', rel)
  print('Copied: ' .. rel)
end, {})

vim.api.nvim_create_user_command('PackUpdate', function() vim.pack.update() end, {})

vim.keymap.set('n', "<leader>u", 'i"<C-r>=system("uuidgen")[:-2]<CR>",<Esc>', { desc = "Generate UUID" })

local function pack_clean()
  local active_plugins = {}
  local unused_plugins = {}

  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end

  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end

  if #unused_plugins == 0 then
    print("No unused plugins.")
    return
  end

  local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(unused_plugins)
  end
end

vim.api.nvim_create_user_command('PackClean', function() pack_clean() end, {})
