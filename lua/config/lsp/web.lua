-- LSP web: ts_ls, eslint, tailwind, emmet, jsonls
-- (TS/JS + Next/Elysia, Tailwind, blade, JSON schema)

-- base on_attach dari lspconfig (bikin command LspEslintFixAll)
local base_eslint_on_attach = vim.lsp.config.eslint.on_attach

return {
  -- auto-update import path pas file TS/JS dipindah / di-rename
  ts_ls = {
    settings = {
      javascript = { updateImportsOnFileMove = { enabled = "always" } },
      typescript = { updateImportsOnFileMove = { enabled = "always" } },
    },
  },

  -- eslint fix-all pas save
  eslint = {
    on_attach = function(client, bufnr)
      if base_eslint_on_attach then
        base_eslint_on_attach(client, bufnr)
      end
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "LspEslintFixAll",
      })
    end,
  },

  -- class completion di tsx/jsx/blade/php/css + helper yang umum (cn, clsx, cva)
  tailwindcss = {
    settings = {
      tailwindCSS = {
        classFunctions = { "cn", "clsx", "cva", "tv", "twMerge", "twJoin" },
      },
    },
  },

  -- emmet (`div.card` + <Tab>) — blade di-map ke html
  -- ponytail: filetypes di-set penuh karena vim.lsp.config merge-nya per-index
  emmet_language_server = {
    filetypes = {
      "astro",
      "blade",
      "css",
      "eruby",
      "html",
      "htmlangular",
      "htmldjango",
      "javascriptreact",
      "less",
      "sass",
      "scss",
      "svelte",
      "typescriptreact",
      "vue",
    },
    init_options = {
      includeLanguages = { blade = "html" },
    },
  },

  -- schema dari SchemaStore (package.json, tsconfig, biome.json, dll)
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
}
