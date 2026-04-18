# My dotfiles

This is the public subset of my private [chezmoi](https://www.chezmoi.io) setup. I sync selected files here from `~/.local/share/chezmoi` whenever I get around to it, so this repo is representative rather than exhaustive.

## What's in here

- [AI agent configs](https://github.com/diegopetrucci/dot/tree/main/.codex): mostly [Codex](https://github.com/diegopetrucci/dot/tree/main/.codex), [Claude](https://github.com/diegopetrucci/dot/tree/main/.claude), [Pi](https://github.com/diegopetrucci/dot/tree/main/.pi), [Amp](https://github.com/diegopetrucci/dot/tree/main/.config/amp), and [OpenCode](https://github.com/diegopetrucci/dot/tree/main/.config/opencode).
- [Agent commands and skills](https://github.com/diegopetrucci/dot/tree/main/.agents): reusable prompts plus a couple of local skills, including Odds API and TfL journey/disruption helpers.
- [Atuin](https://github.com/diegopetrucci/dot/tree/main/.config/atuin): shell history/search.
- [Chezmoi package data](https://github.com/diegopetrucci/dot/blob/main/.local/share/chezmoi/.chezmoidata/packages.yaml): the package inventory that helps keep machines aligned.
- [Ghostty](https://github.com/diegopetrucci/dot/tree/main/.config/ghostty): terminal config and theme overrides.
- [Git](https://github.com/diegopetrucci/dot/blob/main/.gitconfig) and [ignore rules](https://github.com/diegopetrucci/dot/tree/main/.config/git).
- [Neovim](https://github.com/diegopetrucci/dot/tree/main/.config/nvim): my editor config.
- [Night Shift](https://github.com/diegopetrucci/dot/tree/main/.config/nightshift): budget/scheduling config for background agent work.
- [Powerlevel10k](https://github.com/diegopetrucci/dot/blob/main/.p10k.zsh): prompt config for Zsh.
- [Scripts](https://github.com/diegopetrucci/dot/tree/main/.local/bin/scripts): small utilities I actually use.
- [Tmux](https://github.com/diegopetrucci/dot/tree/main/.config/tmux): less central now that I mostly live in Ghostty, but still useful for persistent sessions.
- [Zed](https://github.com/diegopetrucci/dot/tree/main/.config/zed): editor settings and theme placeholders.
- [Zsh](https://github.com/diegopetrucci/dot/blob/main/.zshrc) and [modular shell config](https://github.com/diegopetrucci/dot/tree/main/.config/zsh): aliases, completions, lazy-loading, and shell startup tweaks.

## Notes

- Shared prompts and skills are pulled in via submodules from [ai-custom-prompts](https://github.com/diegopetrucci/ai-custom-prompts) and [ai-agents-skills](https://github.com/diegopetrucci/ai-agents-skills).
- If something looks missing, it probably lives only in the private chezmoi repo because it is machine-specific or not safe to publish.
