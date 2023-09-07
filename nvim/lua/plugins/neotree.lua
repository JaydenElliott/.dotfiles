return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        hijack_netrw_behavior = "open_current",
            filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
        }
      },
       default_component_configs = {
         name = {
            use_git_status_colors = false
         }
      }
    },
    keys = {
      { "\\",  "<cmd>Neotree reveal left<cr>" },
    }
  },
}
