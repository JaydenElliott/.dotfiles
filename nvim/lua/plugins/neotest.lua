return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "rouge8/neotest-rust"
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rust") {
          args = { "--no-capture" },
        }
      },
      consumers = {
        always_open_output = function(client)
          local async = require("neotest.async")

          client.listeners.results = function(adapter_id, results)
            local file_path = async.fn.expand("%:p")
            local row = async.fn.getpos(".")[2] - 1
            local position = client:get_nearest(file_path, row, {})
            if not position then
              return
            end
            local pos_id = position:data().id
            if not results[pos_id] then
              return
            end
            require("neotest").output_panel.open({ position_id = pos_id, adapter = adapter_id })
          end
        end,
      },
    })
  end,
  keys = {
    {
      "<leader>tn",
      "<cmd>Neotest run<cr>",
      desc = "[T]est [N]earest"
    },
    {
      "<leader>ts",
      function()
        require("neotest").run.stop()
      end,
      desc = "[T]est [S]top"
    }
  }
}
