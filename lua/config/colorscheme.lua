-- Persist colorscheme across restarts + new instances.
-- Any :colorscheme (incl. <leader>fC picker) auto-saves to a file,
-- then loaded again on startup.
local M = {}

M.file = vim.fn.stdpath("data") .. "/last_colorscheme.txt"

function M.save()
  local name = vim.g.colors_name
  if not name or name == "" then
    return
  end
  -- save background too (e.g. tokyonight day vs night)
  pcall(vim.fn.writefile, { vim.o.background, name }, M.file)
end

function M.load()
  local f = io.open(M.file, "r")
  if not f then
    return nil
  end
  local bg = f:read("*l")
  local name = f:read("*l")
  f:close()
  -- backward compat: old file may contain only one line (the scheme)
  if name == nil and bg ~= nil then
    name, bg = bg, nil
  end
  if not name or name == "" then
    return nil
  end
  if bg == "dark" or bg == "light" then
    vim.o.background = bg
  end
  local ok = pcall(vim.cmd.colorscheme, name)
  if ok then
    return name
  end
  return nil
end

function M.setup_autocmd()
  local group = vim.api.nvim_create_augroup("PersistColorscheme", { clear = true })
  -- fires on every :colorscheme incl. Telescope picker live preview end
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = function()
      M.save()
    end,
    desc = "Save colorscheme for next session",
  })
  -- :set background=light/dark doesn't fire ColorScheme, save it too
  vim.api.nvim_create_autocmd("OptionSet", {
    group = group,
    pattern = "background",
    callback = function()
      M.save()
    end,
    desc = "Save background for next session",
  })
end

return M
