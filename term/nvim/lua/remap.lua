-- Window management
local window_maps = {
  ["<C-w><C-s>"] = vim.cmd.split,
  ["<C-w><C-v>"] = vim.cmd.vsplit,
  ["<C-w><C-h>"] = "<cmd>wincmd h<cr>",
  ["<C-w><C-j>"] = "<cmd>wincmd j<cr>",
  ["<C-w><C-k>"] = "<cmd>wincmd k<cr>",
  ["<C-w><C-l>"] = "<cmd>wincmd l<cr>",
}


-- Diagnostic navigation
local diagnostic_maps = {
  ["<leader>dp"] = { function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Go to previous error' } },
  ["<leader>dn"] = { function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Go to next error' } },
  ["<leader>do"] = { vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' } },
}

-- Center cursor during movement
local center_cursor_maps = {
  ["J"] = "mzJ`z",
  ["<C-d>"] = "<C-d>zz",
  ["<C-u>"] = "<C-u>zz",
  ["n"] = "nzz",
  ["<C-i>"] = "<C-i>zz",
  ["<C-o>"] = "<C-o>zz",
}

-- Apply window mappings
for lhs, rhs in pairs(window_maps) do
  vim.keymap.set("n", lhs, rhs, { noremap = true })
end

-- Apply diagnostic mappings
for lhs, mapping in pairs(diagnostic_maps) do
  local rhs, opts = mapping[1], mapping[2]
  vim.keymap.set("n", lhs, rhs, opts)
end

-- Apply center cursor mappings
for lhs, rhs in pairs(center_cursor_maps) do
  vim.keymap.set("n", lhs, rhs, { noremap = true })
end

-- Other mappings

-- Save without Formatting
vim.api.nvim_create_user_command('W', 'noautocmd w', {})

-- Format without saving
vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format() end, {})

-- Dont override paste
vim.keymap.set('v', 'p', 'pgvy', { noremap = true })

-- Generate UUID
vim.keymap.set("n", "<leader>u", 'i"<C-r>=system("uuidgen")[:-2]<CR>",<Esc>')

-- Diff
vim.api.nvim_create_user_command('Diff', 'DiffviewOpen', {})


vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = '[G]oto [A]ction', })
vim.keymap.set('n', '<leader>rw', vim.lsp.buf.rename, { desc = '[R]ename [W]ord', })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation', })


---- Go to
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition', })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
  { desc = '[G]oto [D]efinition', })

vim.keymap.set('n', '<leader>kd', vim.lsp.buf.signature_help,
  { desc = 'Signature Documentation', })
