local keymap = vim.keymap.set

-- ── Basics ──────────────────────────────────────
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Close" })
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlight" })

-- ── LSP tracing (OSS exploration essentials) ────
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover doc" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- call hierarchy — trace who calls what
keymap("n", "<leader>ci", vim.lsp.buf.incoming_calls, { desc = "Incoming calls" })
keymap("n", "<leader>co", vim.lsp.buf.outgoing_calls, { desc = "Outgoing calls" })

-- ── Telescope: grep word under cursor ─────────────
keymap("n", "<leader>fw", function()
  require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end, { desc = "Grep word" })

-- ── LaTeX (texlab builds via tectonic on save; this previews) ──
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function(ev)
    keymap("n", "<leader>lv", function()
      vim.lsp.buf_request(ev.buf, "textDocument/forwardSearch", {
        textDocument = { uri = vim.uri_from_bufnr(ev.buf) },
        position = vim.lsp.util.make_position_params().position,
      }, function() end)
    end, { buffer = ev.buf, desc = "LaTeX view PDF" })
  end,
})
-- ── Autocmd ────────────────────────────────────
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})
