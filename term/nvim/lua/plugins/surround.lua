--[[

ys{motion}{char} - surround
yss{char}        - surround full line

cs{motion}{char} - change surround
ds{motion}{char} - delete surround

--]]
return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true
  }
}
