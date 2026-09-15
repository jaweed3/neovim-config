-- Database: vim-dadbod + dadbod-ui (in-buffer SQL via perpus-db tunnels)
--
-- Connections go through local SSH tunnels (managed by `perpus-db` script):
--   staging  127.0.0.1:13306 -> vm-perpus:127.0.0.1:3306  (perpustakaan_staging)
--   prod     127.0.0.1:13307 -> 172.20.20.15:6033          (unidagon_perpus)
--
-- Passwords come from ~/.config/perpus-db/secrets.env at startup — never
-- hardcoded here, never committed. If secrets are missing, URLs resolve to
-- "" (dadbod will report "no URL").
--
-- Two ways to reference a connection in :DB commands:
--   :DB g:perpus_staging <query>   (single string var — for :DB commands)
--   vim.g.dbs                      (dict — only read by the DBUI drawer)
-- Workflow: :DBUI (drawer) -> o open table, <leader>db execute query.
-- See CHEATSHEET.md "Database (dadbod + masume)" for the full tutorial.

local function secret(name)
  local f = io.open(vim.fn.expand("~/.config/perpus-db/secrets.env"), "r")
  if not f then
    return ""
  end
  for line in f:lines() do
    local v = line:match("^" .. name .. "=(.+)$")
    if v then
      f:close()
      return v
    end
  end
  f:close()
  return ""
end

local staging_pass = secret("PERPUS_STAGING_PASS")
local prod_pass = secret("PERPUS_PROD_PASS")

local function mysql_url(user, pass, port, db, extra)
  if pass == "" then
    return ""
  end
  local url = string.format("mysql://%s:%s@127.0.0.1:%d/%s", user, pass, port, db)
  if extra then
    url = url .. "?" .. extra
  end
  return url
end

-- Staging: old server without SSL support. `?skip-ssl` becomes the
-- `--skip-ssl=1` CLI flag (see db#adapter#mysql#filter: every URL query
-- param is passed through as --key=value). Prod supports SSL, no flag needed.
vim.g.dbs = {
  perpus_staging = mysql_url("perpus_staging", staging_pass, 13306, "perpustakaan_staging", "skip-ssl"),
  perpus_prod = mysql_url("app_perpus", prod_pass, 13307, "unidagon_perpus"),
}

-- Aliases for :DB commands (:DB only resolves g:/b:/w: vars, not vim.g.dbs).
vim.g.perpus_staging = vim.g.dbs.perpus_staging
vim.g.perpus_prod = vim.g.dbs.perpus_prod

-- Warn once if secrets are missing (empty URLs are unusable in dadbod).
if staging_pass == "" or prod_pass == "" then
  vim.schedule(function()
    vim.notify(
      "perpus-db secrets missing (~/.config/perpus-db/secrets.env). Run perpus-db setup.",
      vim.log.levels.WARN
    )
  end)
end

-- vim-dadbod-completion is an omni-completion source, NOT an nvim-cmp source:
-- it must be added buffer-locally per README, never to the global cmp list.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    local ok, cmp = pcall(require, "cmp")
    if ok then
      cmp.setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
    end
  end,
})

return {
  -- DADBOD CORE (query engine; owns the :DB command only)
  {
    "tpope/vim-dadbod",
    cmd = { "DB" },
    keys = {
      -- Execute SQL: visual-select query -> run on staging
      {
        "<leader>db",
        ":'<,'>DB g:perpus_staging<CR>",
        mode = "v",
        desc = "DB: run selection on staging",
      },
      -- Execute SQL: whole buffer on staging
      {
        "<leader>dB",
        ":%DB g:perpus_staging<CR>",
        mode = "n",
        desc = "DB: run buffer on staging",
      },
    },
  },

  -- DADBOD UI (drawer: browse tables, saved queries; owns all :DBUI* commands)
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIClose",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
      "DBUILastQueryInfo",
    },
    keys = {
      { "<leader>du", "<cmd>DBUIToggle<cr>", desc = "DB: toggle drawer" },
      { "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "DB: find buffer" },
      { "<leader>da", "<cmd>DBUIAddConnection<cr>", desc = "DB: add connection" },
      { "<leader>dq", "<cmd>DBUILastQueryInfo<cr>", desc = "DB: last query info" },
      -- masume TUI in a new tab (own SSH tunnels 15432/15433, auto-managed).
      -- Exit masume with Ctrl+C, then :q to close the tab.
      { "<leader>dm", "<cmd>tabnew | terminal masume<cr>", desc = "DB: open masume TUI" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      -- Auto-execute: <leader>S on a table line shows table data
      vim.g.db_ui_table_helpers = {
        mysql = {
          Count = "select count(*) from {table}",
          Describe = "describe {table}",
        },
      }
    end,
  },

  -- DADBOD COMPLETION (table/column names in sql buffers, via autocmd above)
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
  },
}
