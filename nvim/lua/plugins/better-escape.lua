return {

  {
    'max397574/better-escape.nvim',
    config = function()
      local escape_mapping = {
        j = {
          k = "<Esc>",
        },
        k = {
          j = "<Esc>",
        },
      }
      require 'better_escape'.setup {
        default_mappings = false,
        mappings = {
          i = escape_mapping,
          c = escape_mapping,
          t = escape_mapping,
        },
      }
    end,
  },
}
