vim.g.mapleader = " " -- set vim's mapleader key to <Space>

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local which_key = require("which-key")
    local wk_setup = {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },

        presets = {
          operators = false,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },

      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = "<c-j>", -- binding to scroll down inside the popup
        scroll_up = "<c-k>", -- binding to scroll up inside the popup
      },

      window = {
        border = "rounded",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        winblend = 0,
      },

      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },

      ignore_missing = true,
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
      show_help = true,

      triggers = "auto",
      triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
      },
    }

    local opts = {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    }

    local mappings = {
      -- general purpose mappings
      ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
      ["m"] = { "<cmd>Mason<CR>", "LSP Server Manager" },
      ["p"] = { "<cmd>Lazy<CR>", "Lazy Plugin Manager" },

      e = {
        name = "Neo-tree",
        c = { "<cmd>Neotree close<CR>", "Close Explorer" },
        f = { "<cmd>Neotree focus<CR>", "Focus Explorer" },
        t = { "<cmd>Neotree toggle<CR>", "Toggle Explorer" },
      },

      f = {
        name = "Telescope",
        b = { "<cmd>Telescope buffers<CR>", "Buffers" },
        f = { "<cmd>Telescope find_files<CR>", "Find Files" },
        g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
        h = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
      },

      w = {
        name = "Session",
        d = { "<cmd>Autosession delete<CR>", "Delete Selected Session" },
        e = { "<cmd>Autosession search<CR>", "Search Sessions" },
        s = { "<cmd>SessionSave<CR>", "Save Current Session" },
        r = { "<cmd>SessionRestore<CR>", "Restore Session On CWD" },
      },
    }

    which_key.setup(wk_setup)
    which_key.register(mappings, opts)
  end,
}
