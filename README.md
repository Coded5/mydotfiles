# Dotfiles

Personal Linux configuration managed with [GNU Stow](https://www.gnu.org/software/stow/). The repository is built around a Hyprland/Wayland desktop and includes separate desktop and laptop profiles.

These files are tailored to my hardware and workflow. Review the configuration before using it on another machine.

## Packages

| Package | Configuration |
| --- | --- |
| `hypr` | Shared Hyprland Lua configuration, keybindings, rules, scripts, lock screen, and sunset settings |
| `hyprpc` | Desktop monitor, workspace, idle, wallpaper, and autostart profile |
| `hyprlaptop` | Laptop monitor, workspace, idle, wallpaper, and autostart profile |
| `waybar` | Desktop Waybar configuration |
| `waybar-laptop` | Laptop Waybar configuration |
| `nvim` | Neovim configuration with LSP, Treesitter, DAP, formatting, and Obsidian support |
| `kitty` | Kitty terminal configuration |
| `rofi` | Rofi launcher configuration |
| `tmux` | tmux configuration |
| `opencode` | OpenCode providers, agents, plugins, and MCP servers |

## Installation

Install Git and GNU Stow, then clone the repository:

```sh
git clone git@github.com:Coded5/mydotfiles.git ~/dotfiles
cd ~/dotfiles
```

Stow the common packages you want:

```sh
stow --target="$HOME" nvim kitty rofi tmux opencode
```

Add one machine profile. For a desktop:

```sh
stow --target="$HOME" hypr hyprpc waybar
```

For a laptop:

```sh
stow --target="$HOME" hypr hyprlaptop waybar-laptop
```

Do not stow both machine profiles or both Waybar variants at the same time. Existing files in the target locations can also cause Stow conflicts; back them up or use a dry run first:

```sh
stow --simulate --verbose --target="$HOME" hypr hyprpc waybar
```

To remove a package's symlinks:

```sh
stow --delete --target="$HOME" nvim
```

## Dependencies

GNU Stow only creates symlinks; it does not install the applications configured here. The main runtime dependencies are:

- Hyprland with Lua configuration support and UWSM
- Waybar, Kitty, Rofi, Neovim, tmux, and OpenCode
- Hyprpaper, Hypridle, Hyprlock, Hyprsunset, and `hyprpolkitagent`
- NetworkManager applet, `brightnessctl`, `playerctl`, `pavucontrol`, `wpctl`, `hyprshot`, `hyprpicker`, and Clipse
- A Nerd Font, Papirus icons, and Noto Sans Thai

Language servers are managed through Mason when Neovim starts. Language toolchains and formatters such as StyLua, ClangFormat, and Prettier must still be available for the corresponding development workflows.

## OpenCode environment

The OpenCode configuration reads credentials from environment variables rather than storing them in the repository:

```sh
export OPENROUTER_API_KEY="..."
export GITHUB_PERSONAL_ACCESS_TOKEN="..."
export OBSIDIAN_REST_API_KEY="..."
```

Only set the variables for integrations you use. The Obsidian MCP configuration expects a local service at `http://127.0.0.1:27123`.

## Before using

At minimum, review and adjust:

- Monitor names, resolutions, refresh rates, and workspace assignments in `hyprpc` or `hyprlaptop`
- Hard-coded `/home/kami` paths in the Hyprland and Neovim configuration
- NVIDIA-specific environment settings in `hypr/.config/hypr/hyprland.lua`
- Keyboard layouts and input preferences
- Waybar hardware sensors and module dependencies
- The Obsidian vault path and local integrations

You can locate machine-specific values with:

```sh
rg 'kami|DP-[0-9]|eDP-[0-9]' .
```
