# RoMaze

A Roblox Studio plugin that generates mazes with configurable algorithms and settings.

## Toolchain

Managed by [Rokit](https://github.com/rojo-rbx/rokit) (`rokit.toml`):
- **rojo** — syncs `src/` into Roblox Studio and builds the plugin binary
- **wally** — Luau package manager
- **wally-package-types** — generates Luau types for Wally packages

## Build & develop

```bash
# Watch src/ and auto-rebuild the plugin on every file change
npm run watch

# One-off build
rojo build plugin.project.json --output ~/Documents/Roblox/Plugins/RoMaze.rbxm

# Install/update Wally packages
wally install

# Lint
selene src/
```

The watch script (`tools/watch.js`) builds into `~/Documents/Roblox/Plugins/RoMaze.rbxm`. Reload the plugin in Roblox Studio manually after each build (Plugin tab → Manage Plugins, or via the Reload button if you have one configured).

## Project structure

```
src/
  Plugin/
    init.server.luau            -- entry point; mounts the React root into CoreGui
    App/
      init.luau                 -- root App React component
      Components/
        StudioComponents/       -- thin React wrappers around Studio API objects
    Assets/
      Icons.luau                -- icon asset ID references
Packages/                       -- Wally-managed packages; do not edit
tools/
  watch.js                      -- file watcher; runs rojo build on any src/ change
plugin.project.json             -- Rojo project definition
wally.toml                      -- Luau package dependencies
rokit.toml                      -- toolchain pin (rojo, wally, wally-package-types)
```

## Architecture

The plugin is a single-context Roblox Studio plugin (no client/server split). The entry point (`init.server.luau`) creates a React root mounted to `CoreGui` and tears it down when the plugin unloads.

All UI is built with React (`jsdotlua/react` + `jsdotlua/react-roblox`). `StudioComponents/` wraps imperative Studio API calls (e.g. `plugin:CreateToolbar`) in React components using `useEffect` so they are created/destroyed with the component lifecycle.

## Key conventions

**Naming**:
- Files: `PascalCase.luau`
- React components: PascalCase functions exported as the module itself (`return MyComponent`)
- Variables and function params: `camelCase`
- Luau types: `PascalCase` with `export type`

**Requires**: Use relative `script.Parent` chains. No path aliases.

**React elements**: Use `local e = React.createElement` at the top of each component file.

**Plugin context**: The `plugin` global is passed as a prop from the entry point down through the tree. Use `StudioPluginContext` to avoid prop-drilling when it gets deep.

## Dependencies (Wally)

| Package | Purpose |
|---|---|
| React | UI framework |
| ReactRoblox | React renderer for Roblox |

## Linting & formatting

- **Selene**: `selene.toml` with `std = "roblox"`.
- **StyLua**: Configured in `.vscode/settings.json`. Format on save is expected.

## Workflow

**Commit messages**: Prefix with `feat:`, `fix:`, `chore:`, `refactor:`, `docs:`, or `test:` (e.g. `feat: add Kruskal maze generator`). Enforced by the `commit-msg` hook in `.githooks/` — run `git config core.hooksPath .githooks` once after cloning to enable it.

**Version bump**: `Version.txt` must be raised on every commit (the same hook compares the staged version against `HEAD`'s). Bump patch for fixes/chores, minor for features, per semver.

**Plan before multi-file changes**: For anything touching more than one file (a new generation algorithm, a new Studio component tree, a cross-cutting refactor), write a short plan first — expected behavior, affected files, how it'll be verified — before writing code. Single-file fixes and small tweaks don't need this.

**Verify before calling it done**: After a behavior change, rebuild (`npm run watch` or the one-off `rojo build` command above), reload the plugin in Studio, and actually exercise the changed path (open the widget, run the generator, check the built maze) rather than relying on the build succeeding as a proxy for correctness.

## What to avoid

- Don't edit `Packages/` — managed by Wally.
- Don't hand-edit `plugin.project.json` without also checking that `rojo build` still succeeds.
- Don't use `game:GetService()` for services that don't exist in a plugin context — prefer the `plugin` API directly.
- Don't add global state at module level; keep all state inside React components or contexts.
