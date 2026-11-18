-- Registry config LSP — satu file di folder ini = satu group server.
-- Tiap file return { nama_server = config } buat vim.lsp.config dan otomatis:
--   1. di-register + di-enable (setup() di bawah)
--   2. masuk exclude mason-lspconfig (lihat lua/plugins/lsp.lua)
-- Jadi nambah/ngedit server: cukup bikin/edit file di folder ini (auto-discover).

local M = {}

-- daftar server yang punya config custom (diisi pas setup)
M.registered = {}

function M.setup()
  local dir = vim.fn.stdpath("config") .. "/lua/config/lsp"
  local files = vim.fn.readdir(dir)
  table.sort(files)

  for _, file in ipairs(files) do
    local group = file:match("^([%w_]+)%.lua$")
    if group and group ~= "init" then
      local ok, configs = pcall(require, "config.lsp." .. group)
      if ok and type(configs) == "table" then
        for server, cfg in pairs(configs) do
          vim.lsp.config(server, cfg)
          table.insert(M.registered, server)
        end
      else
        vim.notify("config.lsp." .. group .. ": " .. tostring(configs), vim.log.levels.ERROR)
      end
    end
  end

  vim.lsp.enable(M.registered)
end

return M
