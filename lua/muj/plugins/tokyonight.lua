return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1001,
  config = function()
    local tokyonight = require("tokyonight")
    
    tokyonight.setup({
      style = "storm",
      transparent = false,
    })

    -- vim.cmd([[colorscheme tokyonight]])
  end,
}
