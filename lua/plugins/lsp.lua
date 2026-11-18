-- LSP: mason, lspconfig, cmp, trouble
-- Neovim 0.11+ native API (vim.lsp.config / vim.lsp.enable).
-- mason cuma install binary; config per-server ada di lua/config/lsp/*.lua
-- (auto-discover — nambah server = cukup bikin/edit file di folder itu).

return {
  -- MASON (binary installer) + LSP wiring
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "b0o/schemastore.nvim", -- JSON schemas buat jsonls (package.json, tsconfig, dll)
    },
    config = function()
      require("mason").setup()

      -- Safe capabilities — loads cmp if available, else uses LSP defaults
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if has_cmp then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- default buat semua server; override per-server ada di lua/config/lsp/*
      vim.lsp.config("*", { capabilities = capabilities })

      -- register + enable semua server di lua/config/lsp/ (satu file = satu group)
      local lsp = require("config.lsp")
      lsp.setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "rust_analyzer",
          "ts_ls",
          "intelephense",
          "gopls",
          "texlab",
          -- web (TS/JS + Laravel)
          "cssls",
          "jsonls",
          "eslint",
          "tailwindcss",
          "emmet_language_server",
        },
        -- server yang config-nya di lua/config/lsp/ enable-nya dihandle config.lsp
        automatic_enable = { exclude = lsp.registered },
      })
    end,
  },

  -- MASON TOOL INSTALLER (binary non-LSP — biar keinstall otomatis)
  -- prettier: web, stylua: lua, blade-formatter: blade, pint: php, taplo: toml
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = { "prettier", "stylua", "blade-formatter", "pint", "taplo" },
      })
    end,
  },

  -- AUTOCOMPLETE
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "laravel" }, -- view()/route()/env()/kolom model (aktif cuma di php/blade)
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- TROUBLE (diagnostics / symbols / LSP references)
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP refs/defs" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    },
  },
}
