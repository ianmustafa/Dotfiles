# Dotfiles setup

This repository is managed with [chezmoi](https://www.chezmoi.io/).

## 1. Set the hostname

Host-specific templates use the system hostname. Set it before initializing Chezmoi:

```bash
sudo hostnamectl set-hostname <hostname>
```

Supported profiles currently include:

- `Archian` — desktop/workstation profile
- `Thinkian` — laptop profile
- `Omenian` — laptop profile based on Thinkian

Use the profile that matches the machine you are setting up. Log out and back in, or reboot, after changing the hostname.

## 2. Install bootstrap dependencies

On CachyOS or Arch Linux:

```bash
sudo pacman -Syu --needed git chezmoi rbw zsh go fzf zoxide
paru -S --needed nodenv
```

Go, Nodenv, FZF, and Zoxide are mandatory workflow dependencies. `bootstrap.sh` checks for them and stops if one is missing.

Install other applications from the configuration—such as Niri, Ghostty, Neovim, tmux, Docker, and Noctalia—according to the selected host profile.

## 3. Install selected EndeavourOS applications

These are the application packages retained from the old EndeavourOS notes.

```bash
sudo pacman -Syu --needed \
  easyeffects lsp-plugins-lv2 calf reaper \
  tmux entr \
  libreoffice-fresh ttf-caladea ttf-carlito ttf-gentium \
  ttf-linux-libertine-g adobe-source-sans-fonts adobe-source-serif-fonts \
  direnv \
  v4l2loopback-dkms obs-studio \
  docker docker-compose \
  steam
```

The old EndeavourOS notes referenced `game-devices-udev`; it is not a separate package in the current CachyOS repositories. The `steam` package provides the current Steam device integration.

`v4l2loopback-dkms` is a kernel module package. Install the headers matching every kernel you intend to boot before installing it—for example, `linux-cachyos-headers` for the CachyOS kernel or `linux-cachyos-lts-headers` for its LTS kernel.

### Docker

Enable Docker and allow the current user to access the daemon without `sudo`:

```bash
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
```

The `docker` group grants root-equivalent privileges because it can control the Docker daemon. For stronger isolation, use Docker rootless mode instead of adding the user to this group. Log out and back in after changing group membership, or use `newgrp docker` for the current shell. Validate the managed Compose file with:

```bash
docker compose -f ~/Docker/compose.yaml config
```

### Tmux

The Tmux configuration is managed at `~/.config/tmux/tmux.conf`. Install TPM once and then press `prefix + I` inside Tmux:

```bash
git clone https://github.com/tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"
```

### Direnv

The managed `~/.config/direnv/direnv.toml` enables dotenv loading. The Zsh configuration already loads the Direnv hook. Start a new shell after applying the dotfiles and verify with:

```bash
direnv version
direnv status
```

Only run `direnv allow .` inside a trusted project after reviewing its `.envrc`; authorization permits that file to execute shell code.

### Nodenv

Install Nodenv through the configured AUR helper, then install the plugins from the old setup notes:

```bash
paru -S --needed nodenv
mkdir -p "$(nodenv root)/plugins"
git clone https://github.com/nodenv/node-build.git "$(nodenv root)/plugins/node-build"
git clone https://github.com/nodenv/nodenv-update.git "$(nodenv root)/plugins/nodenv-update"
git clone https://github.com/momo-lab/xxenv-latest.git "$(nodenv root)/plugins/nodenv-latest"
```

The managed Zsh configuration initializes Nodenv on the laptop profiles. Verify it in a new shell:

```bash
nodenv --version
nodenv install -l | head
```

### EasyEffects, LibreOffice, OBS Studio, and Steam

The packages above are sufficient for installation. EasyEffects uses PipeWire, and OBS Studio exposes its virtual-camera controls after the loopback module is available. Start OBS and use **Start Virtual Camera** when needed.

Steam requires the `multilib` repository. Keep Vulkan installation hardware-specific: install the appropriate 64-bit and 32-bit Vulkan driver packages for the installed GPU rather than copying a driver command from another machine. CachyOS can then provide its preferred Steam compatibility and performance integration.

## 4. Prepare SSH and Vaultwarden access

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

## 5. Initialize and review Chezmoi

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

## 6. Local secrets and environment files

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

## 7. Neovim and terminal plugins

The Neovim lockfile is managed for reproducible plugin versions. After applying:

```text
:Lazy restore
```

For intentional plugin updates, use `:Lazy update`, test Neovim, and review the resulting `lazy-lock.json` before committing it.

Install tmux plugins with `prefix + I`.

## 8. Host-specific checks

Inspect the actual hardware and paths after applying the shared configuration.

For Niri, inspect the outputs with:

```bash
niri msg outputs
```

If a host's display differs from its template, update the corresponding branch in:

```text
~/.local/share/chezmoi/dot_config/niri/cfg/display.kdl.tmpl
```

Then review and apply again:

```bash
chezmoi diff
chezmoi apply
```

For desktop profiles, verify GPU settings, storage paths, external mounts, and Docker services before starting them. For laptop profiles, verify the internal display, power behavior, and optional hardware-specific startup programs.

## 9. First-session checklist

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

## 10. Updating an existing system

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

## 11. Useful inspection commands

```bash
chezmoi source-path
chezmoi status
chezmoi managed
chezmoi unmanaged
chezmoi diff
```

## Quick start template

Replace `<hostname>` with the profile for the machine:

```bash
sudo hostnamectl set-hostname <hostname>
sudo pacman -Syu --needed git chezmoi rbw zsh go fzf zoxide
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

- confirm the hostname and selected profile;
- review `chezmoi diff`;
- verify no secrets or runtime data are included;
- check hardware-specific paths and display outputs;
- validate Niri and Docker Compose configuration where applicable.
