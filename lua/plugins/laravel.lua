-- Laravel: laravel.nvim — pickers, artisan/tinker, gf navigation, cmp source
-- butuh parser php + json (lihat treesitter.lua), rg, jq
-- LSP php: lua/config/lsp/php.lua — cmp source "laravel" di lsp.lua

return {
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-telescope/telescope.nvim",
    },
    -- load di file laravel-related; keymap di bawah juga lazy-load plugin-nya
    event = { "BufEnter composer.json" },
    ft = { "php", "blade", "tinker" },
    keys = {
      { "<leader>Ll", function() Laravel.pickers.laravel() end, desc = "Laravel: picker" },
      { "<leader>La", function() Laravel.pickers.artisan() end, desc = "Laravel: artisan" },
      { "<leader>Lr", function() Laravel.pickers.routes() end, desc = "Laravel: routes" },
      { "<leader>Lm", function() Laravel.pickers.make() end, desc = "Laravel: make" },
      { "<leader>Lc", function() Laravel.pickers.commands() end, desc = "Laravel: custom commands" },
      { "<leader>Lo", function() Laravel.pickers.resources() end, desc = "Laravel: resources" },
      { "<leader>Lt", function() Laravel.commands.run("actions") end, desc = "Laravel: code actions" },
      { "<leader>Lu", function() Laravel.commands.run("hub") end, desc = "Laravel: artisan hub" },
      { "<leader>Lp", function() Laravel.commands.run("command_center") end, desc = "Laravel: command center" },
      { "<leader>Lh", function() Laravel.run("artisan docs") end, desc = "Laravel: docs" },
      { "<leader>Lf", function() Laravel.commands.run("view:finder") end, desc = "Laravel: view finder" },
      -- gf: buka view/route/config/env pas cursor di resource laravel (fallback gf biasa)
      {
        "gf",
        function()
          if Laravel.app("gf").cursorOnResource() then
            return "<cmd>lua Laravel.commands.run('gf')<cr>"
          end
          return "gf"
        end,
        expr = true,
        ft = { "php", "blade" },
        desc = "Laravel: go to resource",
      },
    },
    opts = {
      features = {
        pickers = { provider = "telescope" },
      },
    },
  },
}
