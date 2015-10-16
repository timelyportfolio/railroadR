library(railroadR)

# examples from railroad-diagrams
#   https://github.com/tabatkins/railroad-diagrams/blob/master/example.html

railroad(
  "NonTerminal('IDENT'), '('"
)

# can also provide a file or connection
railroad(
  textConnection(
    "NonTerminal('IDENT'), '('"
  )
)

railroad(
  "'@', NonTerminal('IDENT')"
)

railroad(
  "'#', NonTerminal('IDENT')"
)
