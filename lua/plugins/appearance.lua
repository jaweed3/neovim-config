-- Appearance: theme, statusline, indent guides
-- COLORSCHEME PICKER: <leader>fC

return {
  -- CATPPUCCIN (daily driver)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        integrations = {
          cmp = true,
          treesitter = true,
          telescope = true,
          neo_tree = true,
          mason = true,
          aerial = true,
          flash = true,
        },
      })
      vim.cmd.colorscheme("vim")
    end,
  },

  -- EXTRA COLORSCHEMES (biar ada pilihan di picker)
  { "folke/tokyonight.nvim", lazy = true, priority = 900 },
  { "shaunsingh/nord.nvim", lazy = true, priority = 900 },
  { "EdenEast/nightfox.nvim", lazy = true, priority = 900 },
  { "sainnhe/gruvbox-material", lazy = true, priority = 900 },
  { "rebelot/kanagawa.nvim", lazy = true, priority = 900 },

  -- TELESCOPE COLORSCHEME PICKER (built-in, live preview)
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme picker" },
    },
  },

  -- STATUSLINE (auto-detect theme dari colorscheme)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- INDENT LINE
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = { indent = { char = "│" } },
  },
}
