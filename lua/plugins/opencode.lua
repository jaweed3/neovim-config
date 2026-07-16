-- OpenCode: AI coding assistant — chat, ask, explore codebase
-- https://github.com/nickjvandyke/opencode.nvim

return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  config = function()
    vim.g.opencode_opts = {}
    vim.o.autoread = true

    -- Ask / Select (leader prefix)
    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ")
    end, { desc = "OpenCode: Ask" })

    vim.keymap.set({ "n", "x" }, "<leader>os", function()
      require("opencode").select()
    end, { desc = "OpenCode: Select" })

    -- Operator mode (overrides `go` — built-in byte-offset command, rarely used)
    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "OpenCode: Append range", expr = true })

    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "OpenCode: Append line", expr = true })

    -- Scroll inside OpenCode floating window
    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "OpenCode: Scroll up" })

    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "OpenCode: Scroll down" })
  end,
}
