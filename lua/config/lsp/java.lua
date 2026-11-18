-- LSP Java: jdtls (autodetect gradlew/mvnw, no system gradle needed)

return {
  jdtls = {
    settings = {
      java = {
        eclipse = { downloadSources = true },
        maven = { downloadSources = true },
        gradle = { downloadSources = true },
        format = { enabled = true },
      },
    },
  },
}
