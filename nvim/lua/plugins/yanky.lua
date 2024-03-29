return { {
  "gbprod/yanky.nvim",
  keys = {
    --{ "p",      "<Plug>(YankyPutAfter)",      desc = "Put after",            mode = { "n", "x" } },
    --{ "P",      "<Plug>(YankyPutBefore)",     desc = "Put before",           mode = { "n", "x" } },
    --{ "<C-y>p", "<Plug>(YankyCycleForward)",  desc = "Yanky Cycle Forward",  mode = { "n", "x" } },
    --{ "<C-y>n", "<Plug>(YankyCycleBackward)", desc = "Yanky Cycle Backward", mode = { "n", "x" } },
  },
  opts = {
    highlight = {
      on_put = false,
      on_yank = false,
    },
    preserve_cursor_position = {
      enabled = false,
    },
  }
}
}
