return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local lualine = require("lualine")

    -- for the time being, i'm just gonna use the predefined theme
    -- later i will try to design my style on my own
    lualine.setup({
      options = {
        theme = "material"
      },
    })
  end,
}
