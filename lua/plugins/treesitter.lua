-- Treesitter: syntax, textobjects, context

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
		},
		lazy = false,
		config = function()
			-- nvim-treesitter stores queries in runtime/queries/ (not queries/)
			vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime")

			-- Modern nvim-treesitter (main): highlight/indent/ensure_installed are
			-- gone from config.setup — highlighting is core Neovim now.
			require("nvim-treesitter").setup()

			-- Attach treesitter highlight to every buffer whose parser exists
			-- (blade has no legacy syntax file, so it needs this to be colored)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			-- Treesitter context (show enclosing function name at top)
			require("treesitter-context").setup({
				enable = true,
				max_lines = 3,
				multiline_threshold = 2,
			})
		end,
	},
}
