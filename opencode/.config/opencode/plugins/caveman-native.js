// Ported from `caveman enable opencode` to the OpenCode v2 plugin API.
// Regenerating this file with a v1 Caveman integration overwrites the port.
import { execFileSync } from "node:child_process";
import { createHash } from "node:crypto";

const command = "/home/kami/.nvm/versions/node/v24.12.0/bin/caveman";
const prefix = [];

function call(event, payload = {}) {
  try {
    const raw = execFileSync(
      command,
      [...prefix, "native-hook", "opencode", event],
      {
        input: JSON.stringify({ event_name: event, ...payload }),
        encoding: "utf8",
        timeout: 2000,
        maxBuffer: 2 * 1024 * 1024,
      },
    );
    if (!raw.trim()) return undefined;
    const value = JSON.parse(raw);
    return value && typeof value === "object" ? value : undefined;
  } catch {
    return undefined;
  }
}

function digest(value) {
  try {
    const raw = JSON.stringify(value);
    return {
      bytes: Buffer.byteLength(raw),
      sha256: "sha256:" + createHash("sha256").update(raw).digest("hex"),
    };
  } catch {
    return undefined;
  }
}

function taskType(value) {
  let text;
  try {
    text = JSON.stringify(value).toLowerCase();
  } catch {
    return "general";
  }
  const has = (...terms) => terms.some((term) => text.includes(term));
  if (has("migration", "migrate", "schema change", "backfill", "rollback"))
    return "migration";
  if (has("bug", "fix", "broken", "regression", "crash", "error", "incorrect"))
    return "bugfix";
  if (has("investigate", "diagnose", "root cause", "why does", "trace"))
    return "investigation";
  if (has("refactor", "restructure", "reorganize", "cleanup"))
    return "refactor";
  if (has("review", "audit", "critique", "assess")) return "review";
  if (has("verify", "verification", "prove", "validate", "check that"))
    return "verification";
  if (has("build", "implement", "add", "create", "ship", "feature"))
    return "feature";
  return "general";
}

function taskTerms(value) {
  let text;
  try {
    text = JSON.stringify(value);
  } catch {
    return [];
  }
  const stop = new Set([
    "about",
    "after",
    "agent",
    "before",
    "build",
    "change",
    "code",
    "create",
    "from",
    "have",
    "help",
    "implement",
    "into",
    "make",
    "please",
    "project",
    "repository",
    "should",
    "spec",
    "task",
    "that",
    "then",
    "there",
    "these",
    "they",
    "this",
    "through",
    "user",
    "want",
    "what",
    "when",
    "where",
    "which",
    "with",
    "would",
    "your",
  ]);
  const out = [];
  const seen = new Set();
  for (const raw of text.match(/[A-Za-z][A-Za-z0-9_./-]{2,63}/g) ?? []) {
    const term = raw.toLowerCase().replace(/^[-./]+|[-./]+$/g, "");
    if (
      !term ||
      term.includes("..") ||
      stop.has(term) ||
      seen.has(term) ||
      /^(?:sk|pk|rk|ghp|github_pat|xox[baprs]|akia)[-_]/i.test(term) ||
      /^[a-z0-9_-]{40,}$/i.test(term)
    )
      continue;
    seen.add(term);
    out.push(term);
    if (out.length === 12) break;
  }
  return out;
}

function taskContinuation(value) {
  const visit = (item) => {
    if (typeof item === "string") return item;
    if (Array.isArray(item)) return item.map(visit).filter(Boolean).join(" ");
    if (!item || typeof item !== "object") return "";
    return visit(item.text ?? item.content ?? item.message ?? "");
  };
  const prompt = visit(value).trim().toLowerCase();
  if (!prompt || prompt.length > 160 || prompt.split(/\s+/).length > 14)
    return false;
  return /^(?:please\s+)?(?:continue|go ahead|keep going|proceed|do (?:it|that)|fix (?:it|that)|retry|try again|explain (?:it|that)|what do you mean|yes|yep|yeah|why\??|how\??)[.!?\s]*$/.test(
    prompt,
  );
}

export default {
  id: "caveman.native-opencode",
  async setup(ctx) {
    const contexts = new Map();
    const pending = new Map();
    const controller = new AbortController();

    function sessionContext(sessionID) {
      if (!sessionID) return undefined;
      if (!contexts.has(sessionID)) {
        const out = call("SessionStart", {
          session_id: sessionID,
          surface: "cli",
        });
        const context = out?.hookSpecificOutput?.additionalContext;
        if (typeof context === "string" && context)
          contexts.set(sessionID, context);
      }
      return contexts.get(sessionID);
    }

    const events = (async () => {
      for await (const event of ctx.event.subscribe({
        signal: controller.signal,
      })) {
        const type = event?.type;
        const props = event?.data ?? {};
        const sessionID = event.sessionID ?? props.sessionID ?? props.info?.id;
        if (type === "session.created") sessionContext(sessionID);
        if (type === "session.idle") call("Stop", { session_id: sessionID });
        if (type === "session.compacted") {
          const out = call("PostCompact", { session_id: sessionID });
          const context = out?.hookSpecificOutput?.additionalContext;
          if (typeof context === "string" && context)
            contexts.set(sessionID, context);
        }
        if (type === "session.deleted") {
          call("SessionEnd", { session_id: sessionID });
          contexts.delete(sessionID);
          pending.delete(sessionID);
        }
      }
    })().catch((error) => {
      if (!controller.signal.aborted)
        console.error("Caveman event stream:", error);
    });

    await ctx.session.hook("prompt", (event) => {
      const decision = call("UserPromptSubmit", {
        session_id: event.sessionID,
        prompt: digest(event.prompt),
        task_type: taskType(event.prompt),
        task_terms: taskTerms(event.prompt),
        task_continuation: taskContinuation(event.prompt),
      });
      const dynamic = decision?.hookSpecificOutput?.additionalContext;
      if (typeof dynamic === "string" && dynamic)
        pending.set(event.sessionID, dynamic);
    });
    await ctx.session.hook("context", (event) => {
      const stable = sessionContext(event.sessionID);
      if (stable) event.system.push({ type: "text", text: stable });
      const hint = pending.get(event.sessionID);
      if (hint) {
        event.system.push({ type: "text", text: hint });
        pending.delete(event.sessionID);
      }
    });
    await ctx.tool.hook("execute.before", (event) => {
      const decision = call("PreToolUse", {
        session_id: event.sessionID,
        tool_name: event.tool,
        tool_input: event.input,
      });
      if (typeof decision?.hookSpecificOutput?.additionalContext === "string") {
        pending.set(
          event.sessionID,
          decision.hookSpecificOutput.additionalContext,
        );
      }
      if (event.tool !== "shell" || typeof event.input?.command !== "string")
        return;
      try {
        const raw = execFileSync(command, [...prefix, "shrink-hook"], {
          input: JSON.stringify({
            tool_name: "Bash",
            tool_input: { command: event.input.command },
          }),
          encoding: "utf8",
          timeout: 750,
        });
        const rewritten =
          JSON.parse(raw)?.hookSpecificOutput?.updatedInput?.command;
        if (typeof rewritten === "string" && rewritten)
          event.input.command = rewritten;
      } catch {}
    });
    await ctx.tool.hook("execute.after", (event) => {
      if (event.status !== "completed") return;
      const decision = call("PostToolUse", {
        session_id: event.sessionID,
        tool_name: event.tool,
        tool_input: event.input,
        tool_output: event.result.content,
      });
      if (typeof decision?.hookSpecificOutput?.updatedToolOutput === "string") {
        event.result.content = decision.hookSpecificOutput.updatedToolOutput;
      } else if (typeof decision?.output_replacement === "string") {
        event.result.content = decision.output_replacement;
      }
    });
    await ctx.session.hook("compaction", (event) => {
      call("PreCompact", { session_id: event.sessionID });
      const stable = sessionContext(event.sessionID);
      if (stable) event.system.push({ type: "text", text: stable });
    });
    return async () => {
      controller.abort();
      await events;
      for (const sessionID of contexts.keys())
        call("SessionEnd", { session_id: sessionID });
      contexts.clear();
      pending.clear();
    };
  },
};
