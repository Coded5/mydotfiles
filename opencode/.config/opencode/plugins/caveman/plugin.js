// OpenCode v2 mode tracking. No Caveman CLI or MCP process is required.
import { createRequire } from 'node:module';
import { fileURLToPath, pathToFileURL } from 'node:url';
import { dirname, join } from 'node:path';
import { existsSync, readFileSync } from 'node:fs';
const here = dirname(fileURLToPath(import.meta.url));

function loadConfig() {
  const installed = join(here, 'caveman-config.cjs');
  const dev = join(here, '..', '..', 'hooks', 'caveman-config.js');
  const target = existsSync(installed) ? installed : dev;
  const code = readFileSync(target, 'utf8').replace(/^#![^\n]*\n/, '');
  const mod = { exports: {} };
  // Base require on the loaded file, not plugin.js — caveman-parse.js does a
  // relative require('./caveman-config') that must resolve against src/hooks/
  // in the dev layout and against pluginDir when installed.
  new Function('module', 'exports', 'require', '__dirname', '__filename', code)(
    mod, mod.exports, createRequire(pathToFileURL(target).href), dirname(target), target
  );
  return mod.exports;
}
const config = loadConfig();

const { getDefaultMode } = config;

// Resolved defensively, NOT destructured with the three above. loadConfig()
// reads whatever caveman-config.cjs sits in the installed plugin directory,
// which can predate this file (#848). recordModeChange is the newest of these
// exports, and handleSessionCreated() runs at factory time below, outside any
// try — so destructuring an absent one would throw during plugin construction
// and take caveman on opencode from "mode works, history missing" to "plugin
// does not load at all". The history log is best-effort by design (its own
// body silent-fails), so the no-op stub is the honest fallback.
const recordModeChange = config.recordModeChange || function () {};

// Load the shared mode-change parser (#602) the same way loadConfig() loads
// caveman-config.js — see the doc comment above loadConfig() for why this
// can't go through require()/import() in a compiled Bun binary.
function loadParse() {
  const installed = join(here, 'caveman-parse.cjs');
  const dev = join(here, '..', '..', 'hooks', 'caveman-parse.js');
  const target = existsSync(installed) ? installed : dev;
  const code = readFileSync(target, 'utf8').replace(/^#![^\n]*\n/, '');
  const mod = { exports: {} };
  new Function('module', 'exports', 'require', '__dirname', '__filename', code)(
    mod, mod.exports, (id) => {
      if (id === './caveman-config' || id === './caveman-config.cjs') return config;
      return createRequire(pathToFileURL(target).href)(id);
    }, dirname(target), target
  );
  return mod.exports;
}
const { parseModeChange, INDEPENDENT_MODES } = loadParse();


export default {
  id: 'caveman.mode',
  async setup(ctx) {
    const directory = ctx.location?.directory;
    const defaultMode = () => getDefaultMode(directory);
    const key = (sessionID) => `mode:${sessionID}`;
    async function modeFor(sessionID) {
      const stored = await ctx.storage.get(key(sessionID));
      if (typeof stored === 'string') return stored;
      const configured = defaultMode();
      return configured === 'manual' ? 'off' : configured;
    }
    await ctx.session.hook('prompt', async (event) => {
      const change = parseModeChange(event.prompt.text, {
        getDefaultMode: defaultMode, expandedTpl: true, unwrapQuotes: true,
      });
      if (!change) return;
      if (change.action === 'set' || change.action === 'clear') {
        const mode = change.action === 'clear' ? 'off' : change.mode;
        await ctx.storage.set(key(event.sessionID), mode);
        // Remove expanded command boilerplate, which otherwise activates
        // Caveman even when the user requested "off" or "status".
        if (/^(?:activate (?:caveman|ultracave|megacave) mode\b|\/(?:caveman|ultracave|megacave)(?:\s|$))/i.test(event.prompt.text.trim())) {
          event.prompt.text = mode === 'off'
            ? 'Use normal prose for this session until I explicitly enable Caveman again.'
            : `Use ${mode} mode for this session.`;
        }
      } else if (change.action === 'status') {
        event.prompt.text = `Report this status verbatim without changing mode: Caveman mode: ${await modeFor(event.sessionID)}`;
      } else if (change.action === 'unresolved') {
        event.prompt.text = change.independentMode
          ? `Explain that this mode uses /caveman-${change.independentMode}. Do not change mode.`
          : 'Report that the Caveman mode argument is unrecognized. Do not change mode.';
      }
    });
    const inject = async (event) => {
      const mode = await modeFor(event.sessionID);
      if (mode === 'off') {
        event.system.push({ type: 'text', text: 'Caveman is disabled for this session. Use normal prose; ignore default Caveman style guidance until explicitly reactivated.' });
        return;
      }
      if (INDEPENDENT_MODES.has(mode)) return;
      const rules = config.loadRuleset(mode, here);
      if (!rules) throw new Error(`Caveman ruleset missing: ${mode}`);
      event.system.push({ type: 'text', text: `CAVEMAN MODE ACTIVE (${mode}) — session ruleset applies.\n\n${rules}` });
    };
    await ctx.session.hook('context', inject);
    await ctx.session.hook('compaction', inject);
  },
};
