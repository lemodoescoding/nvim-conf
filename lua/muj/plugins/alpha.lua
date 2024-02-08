return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local startify = require("alpha.themes.startify")

    startify.section.header.val = {
      [[  __       __                           ]],
      [[ |  \\     /  \\                        ]],
      [[ | ▓▓\\   /  ▓▓__    __       __        ]],
      [[ |  ▓▓▓\\ /  ▓▓▓  \\  |  \\     |  \\   ]],
      [[ | ▓▓▓▓\\  ▓▓▓▓ ▓▓  | ▓▓      \\▓▓      ]],
      [[ | ▓▓\\▓▓ ▓▓ ▓▓ ▓▓  | ▓▓     |  \\      ]],
      [[ | ▓▓ \\▓▓▓| ▓▓ ▓▓__/ ▓▓     | ▓▓__     ]],
      [[ | ▓▓  \\▓ | ▓▓\\▓▓    ▓▓     | ▓▓  \\  ]],
      [[ \\▓▓      \\▓▓ \\▓▓▓▓▓▓ __   | ▓▓\\▓▓  ]],
      [[                     |  \\__/ ▓▓        ]],
      [[                      \\▓▓    ▓▓        ]],
      [[                       \\▓▓▓▓▓▓         ]],
    }

    -- Send config to alpha
    alpha.setup(startify.config)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
