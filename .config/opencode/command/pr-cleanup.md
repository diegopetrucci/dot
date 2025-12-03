# Branch Cleanup Commands for LLMs

Execute these tasks in order to clean up and finalize changes in this branch:

## 1. TODO Management

- Search the branch for any leftover TODO comments
- Move unresolved TODOs to `docs/todo/todos.md` and remove them from source code
- Review `docs/todo/todos.md` and delete any TODOs that have been resolved in this branch. Do not add any newly completed todos, only remove completed ones

## 2. Documentation Updates

- Update docs in `docs/` to reflect completed features and changes
- Update `agents.md` if anything substantial like architecture, docs, cli commands has changed
- Update the app architecture doc/mermaid diagrams to reflect the current state of the codebase

## 3. Clean up caches

- For swift projects, once you're all done, run `swift package clean` for each swift package to clean its `.build` directory
