local servers = {
  "emmet_ls",
  "lua_ls",
  "ts_ls",
  "html",
  "cssls",
  "bashls",
  "jsonls",
  "yamlls",
  "svelte",
  -- "tailwindcss-language-server",
  -- "intelephense",
  "clangd",
}

local settings = {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "onsails/lspkind.nvim",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    require("mason").setup(settings)
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
    })
  end,
}
