# OpenCode 2

`opencode.jsonc` uses native v2 providers, agents, MCP servers, and plugin lists.
`cli.json` is the global terminal configuration. Its existing Ayu theme and
session preferences are retained, with supported keybind, scrolling, mouse,
and attention settings migrated from `tui.jsonc`.

`tui.jsonc` remains a v1 reference; v2 ignores it. The pinned goal and quota
packages publish server and terminal entrypoints. Restart OpenCode after
changing plugin versions; runtime dependency artifacts are ignored.

Ponytail is loaded from `@dietrichgebert/ponytail`.
The OpenAI and Anthropic providers use the local proxy at `127.0.0.1:8787`.
Build, plan, and full-audit use GPT-6.1 Sol; the default and focused review use
GPT-6 Luna. The remote scribe removal is retained.
Caveman mode tracking uses the local `plugins/caveman` v2 plugin. It parses
mode commands and natural-language switches, stores mode per session, and
injects the matching skill rules into context and compaction requests.
It does not require the Caveman executable. The old native subprocess wrapper
was removed. Caveman MCP is disabled because its configured executable is
absent; install that executable before enabling Cloud tools again.

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
