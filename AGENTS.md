# AGENTS.md

This repository is a Neovim configuration, primarily written in Lua. Please follow these guidelines when contributing or operating as an agent:

## Setup & Dependencies
- Install dependencies using the justfile: `just dependencies` (or see `install.sh` for manual steps).
- Tool versions are managed with mise; see `mise.toml` and `.mise.toml`.
- Required tools: Neovim (latest), lua-language-server, stylua.

## Build/Lint/Test
- There are no explicit build, lint, or test commands.
- For formatting, use `stylua` (no config file; use default style).
- For linting, use `lua-language-server` or `luacheck` (if available; no config file).
- There are no automated or unit tests; manual testing is done via Neovim.

## Code Style Guidelines
- Use idiomatic Lua: 2 spaces for indentation, no trailing whitespace.
- Prefer `local` for variables and functions unless global is required.
- Use descriptive, snake_case names for variables and functions.
- Group related imports at the top of each file.
- Handle errors gracefully; use `pcall` for protected calls when needed.
- Keep plugin and config files modular and focused.
- Document non-obvious logic with comments.

## Notes
- No Cursor or Copilot rules are present.
- If adding tests or new tools, update this file accordingly.
