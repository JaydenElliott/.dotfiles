return {
  {
    "knubie/vim-kitty-navigator",
    enabled = true,
    cmd = {
      "KittyNavigateRight",
      "KittyNavigateUp",
      "KittyNavigateDown",
      "KittyNavigateLeft",
    },
    keys = {
      {
        "<C-w>h",
        "<cmd>KittyNavigateLeft<cr>",
        desc = "Navigate window left",
      },
      {
        "<C-w>j",
        "<cmd>KittyNavigateDown<cr>",
        desc = "Navigate window down",
      },
      {
        "<C-w>k",
        "<cmd>KittyNavigateUp<cr>",
        desc = "Navigate window up",
      },
      {
        "<C-w>l",
        "<cmd>KittyNavigateRight<cr>",
        desc = "Navigate window right",
      },
    },
    config = function()
      vim.g.kitty_navigator_no_mappings = 1
    end,
  },
}
