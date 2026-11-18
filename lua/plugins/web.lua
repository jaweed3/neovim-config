-- Web: autotag + package.json manager
-- LSP web: lua/config/lsp/web.lua — formatter: lua/plugins/editing.lua

return {
  -- AUTO-CLOSE / AUTO-RENAME TAG — jsx/tsx, html, blade
  -- (blade & php udah di-alias ke html secara default oleh upstream)
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- PACKAGE.JSON — versi terbaru, install/delete, support bun
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    opts = {},
    keys = {
      { "<leader>ns", "<cmd>PackageInfoShow<cr>", desc = "Package: latest versions" },
      { "<leader>ni", "<cmd>PackageInfoInstall<cr>", desc = "Package: install" },
      { "<leader>nd", "<cmd>PackageInfoDelete<cr>", desc = "Package: delete" },
      { "<leader>np", "<cmd>PackageInfoChangeVersion<cr>", desc = "Package: change version" },
    },
  },
}
