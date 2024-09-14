vim.g.mapleader = " " -- set vim's mapleader key to <Space>

-- TODO: update this which-key configuration to v3

return {
  "folke/which-key.nvim",
  dependencies = {
    "echasnovski/mini.nvim",
  },
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

      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },

      -- sorting keymap based on alpha-numerical order -- added from v3 config example on github
      sort = {"alphanum" },

      -- change from popup_mapping to keys due to new v3 config standard
      keys = {
        scroll_down = "<c-j>", -- binding to scroll down inside the popup
        scroll_up = "<c-k>", -- binding to scroll up inside the popup
      },

      -- change these settings to newer v3 config
      win = {
        no_overlaps = true, -- don't allow the popup to overlap with the current cursor
        title = true,
        title_pos = "center",
        border = "rounded",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        wo = {
          winblend = 0,
        },
      },

      -- layout of the popup
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },

      show_keys = true, -- show the currently pressed key
      show_help = true,

      -- removed triggers_backlist, hidden, ignore_options opts
      -- modify triggers option based on the new v3 standard
      triggers = {
        {"<auto>", mode = "nixsotc"},
      },
    }

    which_key.add({
      {"<leader>a", "<cmd>Alpha<cr>", desc = "Home Buffer" },

      -- Neo-tree section
      {"<leader>e", "Neo-Tree"},
      {"<leader>ec","<cmd>Neotree close<CR>", desc = "Close Explorer" },
      {"<leader>ef", "<cmd>Neotree focus<CR>", desc = "Focus Explorer" },
      {"<leader>et", "<cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },

      -- Telescope section
      {"<leader>f", "Telescope"},
      {"<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      {"<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
      {"<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
      {"<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },

      -- Live-server section
      {"<leader>s", "Live-Server H,C,J"},
      {"<leader>st","<cmd>LiveServerStop<CR>", desc = "Stop Live Server" },
      {"<leader>ss","<cmd>LiveServerStart<CR>", desc = "Start Live Server" },

      -- Transparent BG
      {"<leader>t", "Transparent Bg"},
      {"<leader>tt", "<cmd>TransparentToggle<CR>", desc = "Toggle Transparent Bg" },

      -- Session Section
      {"<leader>w", "Session"},
      {"<leader>wd", "<cmd>Autosession delete<CR>", desc = "Delete Selected Session" },
      {"<leader>we", "<cmd>Autosession search<CR>", desc = "Search Sessions" },
      {"<leader>ws", "<cmd>SessionSave<CR>", desc = "Save Current Session" },
      {"<leader>wr","<cmd>SessionRestore<CR>", desc = "Restore Session On CWD" },
    })

    -- local mappings = {
    --   -- general purpose mappings
    --   ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
    --   ["m"] = { "<cmd>Mason<CR>", "LSP Server Manager" },
    --   ["p"] = { "<cmd>Lazy<CR>", "Lazy Plugin Manager" },
    --
    --   e = {
    --     name = "Neo-tree",
    --     c = { "<cmd>Neotree close<CR>", "Close Explorer" },
    --     f = { "<cmd>Neotree focus<CR>", "Focus Explorer" },
    --     t = { "<cmd>Neotree toggle<CR>", "Toggle Explorer" },
    --   },
    --
    --   f = {
    --     name = "Telescope",
    --     b = { "<cmd>Telescope buffers<CR>", "Buffers" },
    --     f = { "<cmd>Telescope find_files<CR>", "Find Files" },
    --     g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
    --     h = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
    --   },
    --
    --   s = {
    --     name = "Live Server Service",
    --     t = { "<cmd>LiveServerStop<CR>", "Stop Live Server" },
    --     s = { "<cmd>LiveServerStart<CR>", "Start Live Server" },
    --   },
    --
    --   t = {
    --     name = "Transparent Bg",
    --     t = { "<cmd>TransparentToggle<CR>", "Toggle Transparent Bg" },
    --   },
    --
    --   w = {
    --     name = "Session",
    --     d = { "<cmd>Autosession delete<CR>", "Delete Selected Session" },
    --     e = { "<cmd>Autosession search<CR>", "Search Sessions" },
    --     s = { "<cmd>SessionSave<CR>", "Save Current Session" },
    --     r = { "<cmd>SessionRestore<CR>", "Restore Session On CWD" },
    --   },
    -- }

    which_key.setup(wk_setup)
  end,
}
