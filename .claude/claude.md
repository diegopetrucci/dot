When asked to search my notes, use `qmd` from the command line:
- `qmd search "foobar"`          # Fast keyword search
- `qmd vsearch "foobar"`             # Semantic search
- `qmd query "foobar"`  # Hybrid + reranking (best quality)

Extra options, use as appropriate:
# Get structured results for an LLM
- qmd search "authentication" --json -n 10
# List all relevant files above a threshold
- qmd query "error handling" --all --files --min-score 0.4
# Retrieve full document content
- qmd get "docs/api-reference.md" --full
