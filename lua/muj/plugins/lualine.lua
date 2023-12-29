return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local lualine = require("lualine")
    local lazy_stat = require("lazy.status")

    local colors = {
      blue = "#65d1ff",
      green = "#3effdc",
      violet = "#ff61ef",
      yellow = "#ffda7b",
      red = "#ff4a4a",
      fg = "#c3ccdc",
      bg = "#112638",
      inactive_bg = "#2c3043",
      semilightgray = "#6b6869",
    }

    local lualine_theme_n = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold"},
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    lualine.setup({
      options = {
        theme = lualine_theme_n,
      },

      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},

      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },

      section = {
        lualine_x = {
          {
            lazy_stat.updates,
            cond = lazy_stat.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },{ "fileformat" },{ "filetype" },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
