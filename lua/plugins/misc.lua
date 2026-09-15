-- Misc: which-key, todo-comments, illuminate, undotree, markdown, tmux, illuminate

return {
  -- WHICH-KEY (leader menu)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({ delay = 300 })
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>d", group = "Database" },
        { "<leader>l", group = "Git" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>c", group = "Code" },
        { "<leader>g", group = "Git" },
        { "<leader>s", group = "Search/replace" },
      })
    end,
  },

  -- TODO COMMENTS
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    config = function()
      require("todo-comments").setup({
        signs = true,
        keywords = {
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = "󰍨 ", color = "hint", alt = { "INFO" } },
        },
      })
    end,
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
    },
  },

  -- VIM-ILLUMINATE (highlight word under cursor)
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
  },

  -- UNDOTREE (visual undo history)
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    },
  },

  -- MARKDOWN PREVIEW (browser)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },



  -- TMUX NAVIGATOR (seamless nvim ⇄ tmux)
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
}
