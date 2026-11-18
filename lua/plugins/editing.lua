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
					-- jsonl (JSON Lines): jq -c = compact per-baris (prettier nggak support jsonl)
					jq_compact = { command = "jq", args = { "-c", "." } },
				},
				formatters_by_ft = {
					python = { "ruff_format" },
					rust = { "rustfmt" },
					go = { "gofumpt" },
					lua = { "stylua" },
					--          sql = { "sql_formatter" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" }, -- jsx
					typescriptreact = { "prettier" }, -- tsx (Next.js dll)
					css = { "prettier" },
					scss = { "prettier" },
					less = { "prettier" },
					html = { "prettier" },
					vue = { "prettier" },
					graphql = { "prettier" },
					markdown = { "prettier" },
					yaml = { "prettier" },
					json = { "prettier" },
					json5 = { "prettier" },
					jsonc = { "prettier" }, -- tsconfig.json dkk (aman sama komentar)
					jsonl = { "jq_compact" }, -- JSON Lines: satu JSON per baris
					toml = { "taplo" },
					blade = { "blade-formatter" }, -- laravel blade
					php = { "pint" }, -- vendor/bin/pint kalau ada, fallback pint global
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},
}
