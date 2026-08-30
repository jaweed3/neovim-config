-- vim.list polyfill for nvim-treesitter (0.11 compat)
if not vim.list then
  vim.list = {}
  vim.list.unique = function(t)
    local seen = {}
    local result = {}
    for _, v in ipairs(t) do
      if not seen[v] then
        seen[v] = true
        table.insert(result, v)
      end
    end
    return result
  end
end

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.termguicolors = true
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"

opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true

opt.updatetime = 250
opt.timeoutlen = 300

-- Bypass Neovim 0.12.4 tree-sitter-markdown nil-node crash (markdown fenced code blocks)
-- Prevents built-in highlighter from starting for markdown
require("vim.treesitter")

local orig_start = vim.treesitter.start
vim.treesitter.start = function(buf, lang)
  buf = vim._resolve_bufnr(buf or 0)
  lang = lang or vim.bo[buf].filetype
  if lang == "markdown" then
    return
  end
  return orig_start(buf, lang)
end

