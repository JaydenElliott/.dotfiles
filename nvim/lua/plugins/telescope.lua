return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope-file-browser.nvim",
      "smilovanovic/telescope-search-dir-picker.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },

    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>fh", "<cmd>Telescope find_help<cr>" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>",       desc = "[F]ind current [W]ord" },
      { "<leader>fg", "<cmd>Telescope live_grep_args<cr>",    desc = "[F]ind by [G]rep" },
      { "<leader>fu", "<cmd>Telescope undo<cr>",              desc = "[F]ind [U]ndo" },
      { "<leader>fd", "<cmd>Telescope search_dir_picker<cr>", desc = "[F]ind dir then grep" },
      { "<leader>fe", "<cmd>Telescope diagnostics<cr>",       desc = "[F]ind by [E]rrors/Diagnostics" },
      { "<leader>f/",
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end, { desc = '[/] Fuzzily search in current buffer' }
      }
    },

    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('fzf')
      telescope.load_extension('search_dir_picker')
      telescope.load_extension("undo")
      telescope.load_extension("live_grep_args")
    end


  }

}
