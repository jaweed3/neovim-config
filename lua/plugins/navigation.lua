-- Navigation: telescope, neo-tree, harpoon, flash, aerial

return {
  -- TELESCOPE (fuzzy find everything)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git" },
        },
      })
    end,
  },

  -- FILE EXPLORER
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree toggle" },
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        use_libuv_file_watcher = false,
      },
      window = {
        position = "float",
        width = 30,
      },
    },
  },

  -- HARPOON (file marks)
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon: Add file" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon: File 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon: File 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon: File 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon: File 4" },
      { "<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon: Menu" },
    },
    config = function()
      require("harpoon").setup({})
    end,
  },

  -- FLASH (jump to any visible location) — replaces `s` key
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
    },
    opts = {
      labels = "abcdefghijklmnopqrstuvwxyz",
      search = { mode = "fuzzy" },
      jump = { autojump = false },
    },
  },

  -- AERIAL (symbol outline sidebar) — essential for OSS code reading
  {
    "stevearc/aerial.nvim",
    branch = "nvim-0.11",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>cA", "<cmd>AerialToggle<cr>", desc = "Aerial outline" },
    },
    opts = {
      backends = { "treesitter", "lsp", "markdown" },
      layout = {
        default_direction = "right",
        width = 40,
      },
      show_guides = true,
      keymaps = {
        ["<C-j>"] = "actions.down",
        ["<C-k>"] = "actions.up",
      },
    },
  },
}
