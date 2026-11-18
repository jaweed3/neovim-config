; SQL di tagged template sql`...` — Drizzle ORM / postgres.js (file .js/.jsx)
((call_expression
  function: (identifier) @_fn
  arguments: (template_string (string_fragment) @injection.content))
  (#eq? @_fn "sql")
  (#set! injection.combined)
  (#set! injection.language "sql"))
