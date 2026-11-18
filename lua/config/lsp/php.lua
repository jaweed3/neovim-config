-- LSP PHP/Laravel: intelephense

return {
  -- blade diikutin biar PHP di dalam view kekomplete juga
  intelephense = {
    filetypes = { "php", "blade" },
    settings = {
      intelephense = {
        files = { maxSize = 5000000 },
        environment = { includePaths = { "vendor" } },
      },
    },
  },
}
