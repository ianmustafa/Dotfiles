# Dotfiles setup

This repository is managed with [chezmoi](https://www.chezmoi.io/).

## 1. Set the hostname

Host-specific templates use the system hostname. For a new Omenian laptop:

```bash
sudo hostnamectl set-hostname Omenian
```

Other supported profiles are `Archian` and `Thinkian`. Log out and back in, or reboot, after changing the hostname.

## 2. Install bootstrap dependencies

On CachyOS or Arch Linux:

```bash
sudo pacman -S --needed git chezmoi rbw zsh go fzf zoxide
paru -S --needed nodenv
```

Go, Nodenv, FZF, and Zoxide are mandatory workflow dependencies. `bootstrap.sh` checks for them and stops if one is missing.

## 3. Prepare SSH and Vaultwarden access

The repository is private:

```bash
ssh -T git@git.kupu.dev
```

Configure `rbw`:

```bash
rbw config set base_url https://v.kupu.dev
rbw login
```

The bootstrap script unlocks `rbw` before applying encrypted Chezmoi files.

## 4. Initialize and review Chezmoi

```bash
chezmoi init --ssh git@git.kupu.dev:ian/dotfiles.git
chezmoi diff
```

Review the diff before applying anything. If it is correct:

```bash
bash "$(chezmoi source-path)/bootstrap.sh"
```

Alternatively, apply directly:

```bash
chezmoi apply
```

For a dry run:

```bash
chezmoi apply --dry-run --verbose
```

## 5. Local secrets and environment files

The repository provides examples only:

```text
~/.omp/.env.example
~/.config/opencode/.env.example
```

Create local files and fill in credentials separately:

```bash
cp ~/.omp/.env.example ~/.omp/.env
cp ~/.config/opencode/.env.example ~/.config/opencode/.env
chmod 600 ~/.omp/.env ~/.config/opencode/.env
```

The real `.env` files, OpenCode `service.json`, and all API keys/passwords remain unmanaged.

## 6. Neovim and terminal plugins

The Neovim lockfile is managed for reproducible plugin versions. After applying:

```text
:Lazy restore
```

For intentional plugin updates, use `:Lazy update`, test Neovim, and review the resulting `lazy-lock.json` before committing it.

Install tmux plugins with `prefix + I`.

## 7. Omenian hardware check

The Omenian profile is based on Thinkian. After entering Niri, inspect the actual outputs:

```bash
niri msg outputs
```

The initial template assumes:

```text
eDP-1
1920x1080 @ 60.001 Hz
```

If that differs, update the Omenian branch in:

```text
~/.local/share/chezmoi/dot_config/niri/cfg/display.kdl.tmpl
```

Then review and apply again:

```bash
chezmoi diff
chezmoi apply
```

## 8. First-session checklist

```bash
chsh -s /bin/zsh
```

Then start a new login session and verify:

- Zsh loads without errors;
- Go, Nodenv, FZF, and Zoxide are available;
- Neovim restores its plugins;
- Niri outputs and startup applications are correct;
- Docker Compose renders successfully:

```bash
docker compose -f ~/Docker/compose.yaml config
```

## 9. Updating an existing system

```bash
chezmoi update --no-tty
chezmoi diff
chezmoi apply
```

To import one intentional live change, re-add only that file:

```bash
chezmoi re-add ~/.config/nvim/lazy-lock.json
```

Do not run `chezmoi re-add` over the entire home directory. Exclude caches, databases, browser profiles, runtime state, credentials, and generated Noctalia themes.

Noctalia themes are intentionally ignored because each device generates colors from its active wallpaper.

## 10. Useful inspection commands

```bash
chezmoi source-path
chezmoi status
chezmoi managed
chezmoi unmanaged
chezmoi diff
```

## Quick start: Omenian

```bash
sudo hostnamectl set-hostname Omenian
sudo pacman -S --needed git chezmoi rbw zsh go fzf zoxide
paru -S --needed nodenv
ssh -T git@git.kupu.dev
rbw config set base_url https://v.kupu.dev
rbw login
chezmoi init --ssh git@git.kupu.dev:ian/dotfiles.git
chezmoi diff
bash "$(chezmoi source-path)/bootstrap.sh"
```

Do not skip the `chezmoi diff` review.

## Remote

```text
git@git.kupu.dev:ian/dotfiles.git
```

## Safety checklist

Before applying or committing:

- confirm the hostname;
- review `chezmoi diff`;
- verify no secrets or runtime data are included;
- check hardware-specific paths and displays;
- validate Niri and Docker Compose configuration where applicable.
