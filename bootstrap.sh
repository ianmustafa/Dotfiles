#!/usr/bin/env bash
# bootstrap.sh — Dotfiles setup for Archian / Thinkian
# Usage: bash bootstrap.sh
# Repos:
#   dotfiles         → https://github.com/kepitian/dotfiles  (chezmoi, home files)
#   dotfiles-etc     → https://github.com/kepitian/dotfiles-etc  (chezetc, /etc files)
#   dotfiles-private → https://git.kupu.dev/kepitian/dotfiles-private  (chezmoi-private, secrets)

set -euo pipefail

HOSTNAME=$(hostname)
CHEZMOI_SRC="$HOME/.local/share/chezmoi"
CHEZETC_SRC="$HOME/.local/share/chezetc"
CHEZMOI_PRIVATE_SRC="$HOME/.local/share/chezmoi-private"

DOTFILES_REPO="git@github.com:kepitian/dotfiles.git"
DOTFILES_ETC_REPO="git@github.com:kepitian/dotfiles-etc.git"
DOTFILES_PRIVATE_REPO="git@git.kupu.dev:kepitian/dotfiles-private.git"

info()    { echo "[INFO] $*"; }
success() { echo "[OK]   $*"; }
warn()    { echo "[WARN] $*"; }
die()     { echo "[ERR]  $*" >&2; exit 1; }

# ─── Preflight ───────────────────────────────────────────────────────────────

info "Hostname: $HOSTNAME"

command -v chezmoi >/dev/null 2>&1 || die "chezmoi not installed. Install via: pacman -S chezmoi"
command -v chezetc >/dev/null 2>&1 || warn "chezetc not installed. Skipping /etc files. Install via: paru -S chezetc"
command -v git     >/dev/null 2>&1 || die "git not installed."
command -v rbw     >/dev/null 2>&1 || die "rbw not installed. Install via: pacman -S rbw"

# ─── rbw (Vaultwarden) ──────────────────────────────────────────────────────

info "Configuring rbw for Vaultwarden ..."
rbw config set base_url https://v.kupu.dev

if ! rbw unlocked 2>/dev/null; then
  info "  rbw is locked — please unlock to allow chezmoi to fetch secrets."
  rbw unlock || die "rbw unlock failed. Run 'rbw unlock' manually then re-run bootstrap.sh"
fi
success "rbw unlocked."

# ─── dotfiles (home) ─────────────────────────────────────────────────────────

info "Setting up dotfiles (chezmoi) ..."

if [ -d "$CHEZMOI_SRC/.git" ]; then
  info "  chezmoi source already exists, pulling ..."
  git -C "$CHEZMOI_SRC" pull --ff-only
else
  chezmoi init --source "$CHEZMOI_SRC" "$DOTFILES_REPO"
fi

info "  Applying chezmoi ..."
chezmoi apply --source "$CHEZMOI_SRC"
success "dotfiles applied."

# ─── dotfiles-private (secrets) ──────────────────────────────────────────────

info "Setting up dotfiles-private ..."

if [ ! -f "$HOME/.ssh/id_ed25519" ] && [ ! -f "$HOME/.ssh/id_rsa" ]; then
  warn "  No SSH key found — skipping dotfiles-private (requires manual SSH key setup first)."
else
  if [ -d "$CHEZMOI_PRIVATE_SRC/.git" ]; then
    info "  chezmoi-private source already exists, pulling ..."
    git -C "$CHEZMOI_PRIVATE_SRC" pull --ff-only
  else
    chezmoi init --source "$CHEZMOI_PRIVATE_SRC" "$DOTFILES_PRIVATE_REPO"
  fi

  info "  Applying chezmoi-private ..."
  chezmoi apply --source "$CHEZMOI_PRIVATE_SRC"
  success "dotfiles-private applied."
fi

# ─── dotfiles-etc (/etc files) ───────────────────────────────────────────────

if command -v chezetc >/dev/null 2>&1; then
  info "Setting up dotfiles-etc (chezetc) ..."

  if [ -d "$CHEZETC_SRC/.git" ]; then
    info "  chezetc source already exists, pulling ..."
    git -C "$CHEZETC_SRC" pull --ff-only
  else
    # chezetc init creates the source dir; then we set the remote
    chezetc init
    git -C "$CHEZETC_SRC" remote add origin "$DOTFILES_ETC_REPO"
    git -C "$CHEZETC_SRC" fetch origin
    git -C "$CHEZETC_SRC" reset --hard origin/master
  fi

  info "  Applying chezetc (requires sudo) ..."
  chezetc apply
  success "dotfiles-etc applied."
else
  warn "chezetc not found — skipping /etc files."
  warn "  To apply manually:"
  warn "    paru -S chezetc"
  warn "    chezetc init"
  warn "    git -C $CHEZETC_SRC remote add origin $DOTFILES_ETC_REPO"
  warn "    git -C $CHEZETC_SRC fetch origin && git -C $CHEZETC_SRC reset --hard origin/master"
  warn "    chezetc apply"
fi

# ─── Post-install hints ───────────────────────────────────────────────────────

echo ""
echo "────────────────────────────────────────"
echo "  Bootstrap complete for: $HOSTNAME"
echo "────────────────────────────────────────"
echo ""
echo "Next steps:"
echo "  1. Copy your SSH keys to ~/.ssh/ (they are not in any repo)"
echo "  2. Copy ~/Docker/.env with your actual secrets"
echo "  3. Install zsh plugins: open a new shell — zinit will auto-install"
echo "  4. Install tmux plugins: prefix + I inside tmux (tpm)"
echo "  5. Install nvim plugins: nvim (lazy will auto-install)"
echo ""
echo "  For /etc files (chezetc):"
echo "    chezetc apply   # applies DNSCrypt, udev, pacman, samba, sudoers, wireplumber"
echo "    Remember: fstab UUIDs are placeholders — edit /etc/fstab manually with your own UUIDs."
echo ""
