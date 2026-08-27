# Dotfiles of Ian Mustafa

Managed with [chezmoi](https://www.chezmoi.io/).

## What's in Here

| config | description |
| :--- | :--- |
| `alacritty` | terminal emulator |
| `btop` | resource monitor |
| `direnv` | per-directory env vars |
| `fastfetch` | system info |
| `ghostty` | primary terminal |
| `hypr` | Hyprland compositor + Noctalia shell (Lua, ≥0.55) |
| `lazygit` | git TUI |
| `MangoHud` | GPU/FPS overlay |
| `mpv` | media player |
| `niri` | niri compositor + Noctalia shell (KDL) |
| `noctalia` | shell (bar, launcher, OSD, lock, notifications) |
| `nvim` | neovim |
| `starship.toml` | shell prompt |
| `tmux` | terminal multiplexer |
| `wezterm` | terminal emulator (secondary) |
| `zed` | editor |
| `zsh` | shell config |
| `.gitconfig` | git identity + GPG signing |
| `.xprofile` | X session env |
| `.npmrc` | npm config |

## Quick Start

```bash
# install chezmoi and apply dotfiles in one shot
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@git.kupu.dev:ian/dotfiles.git
```

or if chezmoi is already installed:

```bash
chezmoi init git@git.kupu.dev:ian/dotfiles.git
chezmoi apply
```

## Compositor

two compositor configs are maintained in parallel — pick one at the SDDM login screen:

- **niri** — scrollable tiling, KDL config. see [`~/.config/niri/SETUP.md`](.config/niri/SETUP.md)
- **hyprland** — scrolling layout, Lua config. see [`~/.config/hypr/SETUP.md`](.config/hypr/SETUP.md)

both use **Noctalia** as the shell — all `noctalia msg` IPC is identical between them.

## Bootstrap

`bootstrap.sh` handles first-run setup (symlinks, package installs). see comments inside for details.

## Structure

chezmoi source conventions used here:

- `dot_*` → `~/.` (e.g. `dot_config` → `~/.config`)
- `private_*` → file with `chmod 600`
- `*.tmpl` → chezmoi template (machine-specific values)
