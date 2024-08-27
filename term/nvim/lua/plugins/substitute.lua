return {
  {
    "gbprod/substitute.nvim",
    config = true,
    keys = {
      {
        's',
        function() require('substitute').operator() end,
        silent = true,
        desc = "Substitute"
      }
    }
  }
}
