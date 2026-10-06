# OpenCode 2

`opencode.jsonc` uses native v2 providers, agents, MCP servers, and plugin lists.
`cli.json` is the global terminal configuration. Its existing Ayu theme and
session preferences are retained, with supported keybind, scrolling, mouse,
and attention settings migrated from `tui.jsonc`.

`tui.jsonc` remains a v1 reference; v2 ignores it. The pinned goal and quota
packages publish server and terminal entrypoints. Restart OpenCode after
changing plugin versions; runtime dependency artifacts are ignored.

The `./.opencode/plugins/ponytail.mjs` entry is enabled. Its implementation was
not found in this configuration directory, so its v2 compatibility is unverified.

V2 ignores `server` in the main config. To restore the previous fixed port:

```sh
opencode service set port 4096
opencode service start
```

These commands change the background service and may stop existing sessions.
`service.json` contains machine-local credentials and is ignored by Git.

V2 currently does not run LSP servers or produce LSP diagnostics. Use project
lint, typecheck, or compiler commands instead. The `instructions` field is
retained for compatibility, but v2 currently loads guidance through `AGENTS.md`
rather than its entries.

Credentials continue to come from `OPENROUTER_API_KEY`,
`GITHUB_PERSONAL_ACCESS_TOKEN`, and `OBSIDIAN_REST_API_KEY`.

References: [v2 migration](https://opencode.ai/v2/docs/migrate-v1),
[terminal settings](https://opencode.ai/v2/docs/cli/config),
[service settings](https://opencode.ai/v2/docs/cli/web/).
