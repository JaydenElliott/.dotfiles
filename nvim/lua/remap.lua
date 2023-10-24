vim.keymap.set("n", "<C-w><C-s>", vim.cmd.split, { noremap = true })
vim.keymap.set("n", "<C-w><C-v>", vim.cmd.vsplit, { noremap = true })
vim.keymap.set("n", "<C-w><C-k>", "<cmd>wincmd k<cr>", { noremap = true })
vim.keymap.set("n", "<C-w><C-j>", "<cmd>wincmd j<cr>", { noremap = true })
vim.keymap.set("n", "<C-w><C-k>", "<cmd>wincmd k<cr>", { noremap = true })
vim.keymap.set("n", "<C-w><C-l>", "<cmd>wincmd l<cr>", { noremap = true })




-- clear search highglighting
-- vimkeymap.set("n", "<leader>/", vim.cmd.noh, { noremap = true })



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



-- moving chunks around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- save without format
vim.api.nvim_create_user_command('Wf', 'noautocmd w', {})


-- generate uuid
--local cmd = uuidgen|sed 's/.*/\"&\"/'|tr \"[A-Z]\" \"[a-z]\",
local cmd = ":<cmd> r! uuidgen|sed \'s/.*/\"&\"/\'|tr \"[A-Z]\" \"[a-z]\",<CR>"
vim.keymap.set("n", "<leader>u", cmd)
