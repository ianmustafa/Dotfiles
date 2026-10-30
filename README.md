# Ian's CachyOS dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

## Hosts

| host | role | base |
| :--- | :--- | :--- |
| `Archian` | primary desktop/workstation | desktop-specific configuration |
| `Thinkian` | existing laptop profile | laptop configuration |
| `Omenian` | new laptop | `Thinkian`-based laptop configuration |

Hostname-specific templates use `chezmoi.hostname`. Set the hostname before running the bootstrap script.

## What's included

- **Niri + Noctalia** — compositor and desktop shell
- **Ghostty** and **Alacritty** — terminal emulators
- **Zsh + Zinit + Oh My Posh** — shell and prompt
- **Neovim/LazyVim** — editor
- **tmux + TPM** — terminal multiplexer
- **lazygit**, **btop**, **fzf**, **fd**, **eza**, **bat**, and **zoxide**
- **Docker Compose** — host-aware service configuration
- **MangoHud**, **mpv**, and development tool configuration
- Git identity and signing configuration

Hyprland, WezTerm, and Foot files may remain in the repository for reference, but they are not part of the current CachyOS desktop profile.

## Fresh CachyOS install: Omenian

Set the new machine hostname first:

```bash
sudo hostnamectl set-hostname Omenian
```

Install the minimum bootstrap dependencies:

```bash
sudo pacman -S --needed git chezmoi rbw zsh
```

Then run the bootstrap script after SSH access to the repositories and Vaultwarden are configured:

```bash
bash bootstrap.sh
```

The script applies the shared dotfiles and the `Omenian` laptop profile. Hardware-specific Niri output settings should be checked with:

```bash
niri msg outputs
```

If the laptop panel is not `eDP-1` at `1920x1080@60.001`, update the Omenian branch in `dot_config/niri/cfg/display.kdl.tmpl` before applying.

## Existing machine update

To update the source from a machine's current managed files:

```bash
chezmoi re-add
chezmoi diff
```

Review the diff before committing. Do not use `chezmoi re-add` for secrets, generated files, or machine-specific data that should remain local.

## Repository layout

- `dot_*` → files under `$HOME`
- `private_*` → files with restrictive permissions
- `*.tmpl` → machine-specific Chezmoi templates
- `.chezmoiignore` → generated, secret, or machine-local files excluded from management
- `bootstrap.sh` → first-run setup for a fresh machine

## Docker

Docker Compose is rendered per host. Archian keeps its desktop/storage/GPU services; Thinkian and Omenian use the laptop-safe branch. Copy `Docker/.env` separately because secrets are intentionally not stored in this repository.

## After applying

1. Open a new Zsh session so Zinit can install plugins.
2. Open tmux and press `prefix + I` to install TPM plugins.
3. Start Neovim so LazyVim can install plugins.
4. Verify Niri outputs and hardware-specific paths.
5. Review `chezmoi diff` before applying future changes.

## Source conventions

This repository uses the standard Chezmoi naming conventions and keeps secrets outside the repository.

Remote: `git@git.kupu.dev:ian/dotfiles.git`
