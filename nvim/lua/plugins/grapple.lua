return {
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-q>",     "<cmd>GrappleCycle backward<cr>" },
      { "<C-p>",     "<cmd>GrappleCycle forward<cr>" },
      { "<C-t>",     "<cmd>GrapplePopup tags<cr>" },
      { "<leader>p", "<cmd>GrappleToggle<cr>" },
    }
  }
}
