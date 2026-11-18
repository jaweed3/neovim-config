-- LSP Go: gopls

return {
  gopls = {
    cmd = { vim.fn.expand("~/go/bin/gopls") },
    settings = {
      gopls = {
        gofumpt = true,
        staticcheck = true,
        analyses = { unusedparams = true, shadow = false },
        codelenses = { generate = true, test = true, tidy = true },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          functionTypeParameters = true,
        },
      },
    },
  },
}
