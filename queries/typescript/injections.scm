; SQL di tagged template sql`...` — Drizzle ORM / postgres.js
; tsx udah inherit dari typescript, jadi ini kepake buat Next/React juga
((call_expression
  function: (identifier) @_fn
  arguments: (template_string (string_fragment) @injection.content))
  (#eq? @_fn "sql")
  (#set! injection.combined)
  (#set! injection.language "sql"))
