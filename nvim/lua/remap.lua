vim.keymap.set("n", "<C-w><C-s>", vim.cmd.split, { noremap = true })
vim.keymap.set("n", "<C-w><C-v>", vim.cmd.vsplit, { noremap = true })
vim.keymap.set("n", "<C-w><C-k>", "<cmd>wincmd k<cr>", { noremap = true })
vim.keymap.set("n", "<C-w><C-j>", "<cmd>wincmd j<cr>", { noremap = true })
vim.keymap.set("n", "<C-w><C-k>", "<cmd>wincmd k<cr>", { noremap = true })
vim.keymap.set("n", "<C-w><C-l>", "<cmd>wincmd l<cr>", { noremap = true })







-- if in two splits run ``:windo diffthis`` to compare files

-- diagnostics
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- cursor stays in the center of the screen during these commands
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })
vim.keymap.set('n', 'n', 'nzz', { noremap = true })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { noremap = true })
vim.keymap.set('n', '<C-o>', '<C-o>zz', { noremap = true })

-- dont override paste
vim.keymap.set('v', 'p', 'pgvy', { noremap = true })

-- save without format
vim.api.nvim_create_user_command('W', 'noautocmd w', {})

-- format without saving
vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format() end, {})


-- generate uuid
vim.keymap.set("n", "<leader>u", "i\"<C-r>=system('uuidgen')[:-2]<CR>\",<Esc>")

-- git diff
vim.api.nvim_create_user_command('Diff', 'DiffviewOpen', {})
