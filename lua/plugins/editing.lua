-- Editing: autopairs, surround, comments, formatter

return {
  -- AUTO CLOSING BRACKETS
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- SURROUND (ys, cs, ds)
  {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- COMMENT (gcc, gc<motion>)
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function()
      require("Comment").setup()
    end,
  },

  -- FORMATTER (format on save)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        formatters = {
          gofumpt = { command = vim.fn.expand("~/go/bin/gofumpt") },
        },
        formatters_by_ft = {
          python = { "ruff_format" },
          rust = { "rustfmt" },
          go = { "gofumpt" },
          lua = { "stylua" },
          sql = { "sql_formatter" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
          markdown = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
}
