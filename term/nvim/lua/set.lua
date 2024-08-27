vim.opt.hlsearch = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
-- vim.wo.signcolumn = 'yes'
vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.wrap = false


vim.opt.termguicolors = true

-- vim.opt completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false


vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

-- new split will be on the right rather than in current pane
vim.opt.splitbelow = true
vim.opt.splitright = true
