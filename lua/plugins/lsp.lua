-- LSP: mason, lspconfig, cmp, trouble
-- Neovim 0.11+ native API (vim.lsp.config / vim.lsp.enable).
-- mason-lspconfig only installs binaries; per-server settings live here.

return {
  -- MASON (binary installer)
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "rust_analyzer", "ts_ls", "intelephense", "gopls", "texlab" },
        automatic_enable = { exclude = { "intelephense", "lua_ls", "gopls", "texlab" } },
      })

      -- Safe capabilities — loads cmp if available, else uses LSP defaults
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if has_cmp then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      vim.lsp.config("*", { capabilities = capabilities })

      vim.lsp.config("intelephense", {
        capabilities = capabilities,
        settings = {
          intelephense = {
            files = { maxSize = 5000000 },
            environment = { includePaths = { "vendor" } },
          },
        },
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config("gopls", {
        capabilities = capabilities,
        cmd = { vim.fn.expand("~/go/bin/gopls") },
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            analyses = { unusedparams = true, shadow = false },
            codelenses = { generate = true, test = true, tidy = true },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              functionTypeParameters = true,
            },
          },
        },
      })

      -- ponytail: texlab builds via tectonic on save, previews with `open`
      vim.lsp.config("texlab", {
        capabilities = capabilities,
        settings = {
          texlab = {
            build = {
              executable = "tectonic",
              args = { "-X", "compile", "--synctex", "--keep-logs", "%f" },
              onSave = true,
              forwardSearchAfter = false,
            },
            forwardSearch = { executable = "open", args = { "%p" } },
          },
        },
      })

      vim.lsp.enable({ "intelephense", "lua_ls", "gopls", "texlab" })
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
