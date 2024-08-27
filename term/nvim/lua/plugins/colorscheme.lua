return { {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme onedark]])
  end,
},
  {
    'fei6409/log-highlight.nvim',
  }
}
