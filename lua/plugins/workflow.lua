-- Workflow: diffview (git diff/history), grug-far (find & replace).
-- Complement: gitsigns+lazygit, telescope live_grep, neo-tree.

return {
	-- DIFFVIEW (rich diff + file history — yang kurang dari gitsigns/lazygit)
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewFileHistory",
			"DiffviewRefresh",
		},
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git: diff working tree" },
			{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Git: close diffview" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Git: history current file" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Git: history repo-wide" },
		},
		config = function()
			require("diffview").setup({})
		end,
	},

	-- GRUG-FAR (find & replace se-project — pasangan live_grep <leader>fg)
	{
		"MagicDuck/grug-far.nvim",
		cmd = { "GrugFar" },
		keys = {
			{ "<leader>sr", "<cmd>GrugFar<cr>", mode = { "n", "v" }, desc = "Search & replace (project)" },
			{
				"<leader>sw",
				function()
					require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
				end,
				mode = "n",
				desc = "Search & replace word",
			},
		},
		config = function()
			require("grug-far").setup({})
		end,
	},
}
