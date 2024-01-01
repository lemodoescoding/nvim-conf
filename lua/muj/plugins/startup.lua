return {
  "startup-nvim/startup.nvim",
  -- priority = 9999,
  event = "VimEnter",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },

  config = function()
    local startup = require("startup")

    startup.setup({
        header = {
          type = "text",
          oldfiles_directory = false,
          align = "center",
          fold_section = false,
          title = "Header",
          margin = 5,

          content = {
            " __       __                      ",
            "|  \\     /  \\                     ",
            "| ▓▓\\   /  ▓▓__    __       __    ",
            "| ▓▓▓\\ /  ▓▓▓  \\  |  \\     |  \\   ",
            "| ▓▓▓▓\\  ▓▓▓▓ ▓▓  | ▓▓      \\▓▓   ",
            "| ▓▓\\▓▓ ▓▓ ▓▓ ▓▓  | ▓▓     |  \\   ",
            "| ▓▓ \\▓▓▓| ▓▓ ▓▓__/ ▓▓     | ▓▓__ ",
            "| ▓▓  \\▓ | ▓▓\\▓▓    ▓▓     | ▓▓  \\",
            " \\▓▓      \\▓▓ \\▓▓▓▓▓▓ __   | ▓▓\\▓▓",
            "                     |  \\__/ ▓▓   ",
            "                      \\▓▓    ▓▓   ",
            "                       \\▓▓▓▓▓▓    ",
          },

          highlight = "Statement",
          default_color = "",
          oldfiles_amount = 0,
        },

        body = {
          type = "mapping",
          oldfiles_directory = false,
          align = "center",
          fold_section = false,
          title = "Basic Commands",
          margin = 5,
          content = {
            { " New File", "ene", "e" },
            { " Find File", "<leader>ff", "ff" },
            { "󰍉 Find Word", "<leader>fg", "fg" },
            { " Recent Files", "<leader>fo", "fo" },
          },
          highlight = "String",
          default_color = "",
          oldfiles_amount = 0,
        },
      footer = {
          type = "text",
          oldfiles_directory = false,
          align = "center",
          fold_section = false,
          title = "Footer",
          margin = 5,
          content = {
            "gg.lb",
            "<leader>qf to quit",
          },
          highlight = "Number",
          default_color = "",
          oldfiles_amount = 0,
        },

        options = {
          mapping_keys = true,
          empty_lines_between_mappings = true,
          disable_statuslines = true,
        },

        mapping = {
          execute_command = "<CR>",
          open_file = "o",
          open_file_split = "<C-o>",
          open_section = "<TAB>",
          open_help = "?",
        },

        colors = {
          background = "#1f2227",
          folded_section = "#56b6c2",
        },

        parts = { "header", "body", "footer" }
      })
  end
}
