-- LSP LaTeX: texlab (build via tectonic on save, preview pakai `open`)

return {
  texlab = {
    settings = {
      texlab = {
        build = {
          executable = "tectonic",
          args = { "-X", "compile", "--synctex", "--keep-logs", "%f" },
          onSave = true,
          forwardSearchAfter = false,
        },
        forwardSearch = { executable = "open", args = { "%p" } },
      },
    },
  },
}
