vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specs from lua/plugins/*.lua
require("lazy").setup("plugins", {
  install = { colorscheme = { "vim" } },
  checker = { enabled = true },
})

-- Settings & keymaps
require("options")
require("keymaps")

-- Filetype detection
vim.filetype.add({ extension = { blade = 'blade' } })
