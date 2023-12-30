return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },

  config = function()
    local mason = require("mason")

    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "tsserver",
        "cssls",
        "html",
        "lua_ls",
        "emmet_ls",
        -- "intelephense",
        "pyright",
        "svelte",
        -- "clangd",
      },

      automatic_installation = true,
    })
  end,
}
