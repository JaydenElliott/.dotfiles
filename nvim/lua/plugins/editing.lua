return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  {
    'preservim/nerdcommenter'
  },
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = true,
    keys = {
      { "<leader>h", "<cmd>HopWord<cr>" },
    }
  },
  {
    'max397574/better-escape.nvim',
    config = function()
      require 'better_escape'.setup {
        mapping = { "jk", "kj" }
      }
    end,

  },
  {
    "ray-x/sad.nvim",
    dependencies = { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
    config = true,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true
  }
}
