# Niri + Noctalia Shell: Getting Started Guide

This guide summarizes your custom configuration on CachyOS, featuring Niri as the compositor, Noctalia as the shell, and Ghostty as the primary terminal.

---

## 📦 Dependencies
You can install all required packages using:
```bash
yay -S --needed - < packages.txt
```

Additional packages not in `packages.txt` but required by the config:

| Package | Reason |
| :--- | :--- |
| `papirus-icon-theme` | GTK icon theme (`Papirus-Dark`) |
| `bibata-cursor-theme` | Cursor theme (`Bibata-Modern-Classic`) in `misc.kdl` |
| `breeze` | GTK theme (`Breeze`) in `gtk-3.0/settings.ini` |
| `kwallet` / `ksecretservice` | `kwalletd6` in `autostart.kdl`, secret service alias |
| `ksshaskpass` | `SSH_ASKPASS` in `misc.kdl` |
| `noto-fonts` | GTK font (`Noto Sans 10`) |
| `noto-fonts-cjk` | CJK font support |
| `inter-font` | Used by Noctalia shell |
| `ttf-outfit` | Used by Noctalia shell |
| `awesome-terminal-fonts` | Status bar icons |

---

## 🚀 Quick Start
- **Login:** Select **Niri** from your display manager (SDDM/GDM).
- **Terminal:** `Mod + Return` launches **Ghostty**.
- **App Launcher:** `Mod + Space` opens the Noctalia launcher.
- **Session Menu:** `Mod + Shift + Q` for power/logout options.

---

## 🛠️ System Configuration
- **Compositor:** Niri (Scrollable-tiling).
- **Shell:** Noctalia (built with Quickshell).
- **Terminal:** Ghostty (Set as `$TERMINAL` in `.zshrc`).
- **Portals:** KDE XDG Desktop Portal (for file dialogs and dark mode compatibility), plus GNOME and GTK portals (required for screen casting/sharing in Niri).
- **XWayland:** Automatically managed by Niri via `xwayland-satellite`.

---

## 🎨 Theme & Dark Mode
Your setup uses a custom sync script to ensure consistent dark mode across all apps (Zen Browser, Ghostty, etc.):
- **Toggle:** Change the theme in the Noctalia settings panel.
- **Sync:** A hook in `~/.config/noctalia/settings.json` triggers `~/.config/niri/sync-dark-mode.sh` to update the Freedesktop color-scheme preference.

---

## 💾 Dotfiles & Backup
Your configurations are symlinked to `/media/Vault/Dotfiles/` for easy backup:
- **Niri:** `~/.config/niri` → `/media/Vault/Dotfiles/Niri`
- **Noctalia:** `~/.config/noctalia` → `/media/Vault/Dotfiles/Noctalia`

### Restoration (Fresh Install)
To restore this exact setup on a new system:
1. Mount your **Vault** drive (or copy the Dotfiles folder to a known path).
2. Run the initialization script:
   ```bash
   bash /media/Vault/Dotfiles/Niri/init.sh
   ```
   This script restores symlinks, compiles the GSettings schema, sets up the KWallet D-Bus service file, and marks scripts as executable.

3. Copy the remaining config files manually:
   ```
   ~/.config/gtk-3.0/
   ~/.config/gtk-4.0/
   ~/.config/xdg-desktop-portal/niri-portals.conf
   ~/.config/alacritty/alacritty.toml
   ```

---

## 🖥️ Migrating to a New Machine

### Full file checklist

| Source | Notes |
| :--- | :--- |
| `/media/Vault/Dotfiles/Niri/` | Core compositor config — handled by `init.sh` |
| `/media/Vault/Dotfiles/Noctalia/` | Shell config — handled by `init.sh` |
| `~/.config/gtk-3.0/` | GTK 3 theme, cursor, icon settings |
| `~/.config/gtk-4.0/` | GTK 4 theme settings |
| `~/.config/xdg-desktop-portal/niri-portals.conf` | Portal backend routing (ScreenCast, FileChooser, etc.) |
| `~/.config/alacritty/alacritty.toml` | Alacritty terminal config |

### Things to adjust after copying

**Required:**
- `cfg/display.kdl` — output name `"HDMI-A-1"` is machine-specific. Run `niri msg outputs` after first boot to get the correct name (likely `eDP-1` on a laptop), then update the file.
- `cfg/misc.kdl` — remove or comment out the Nvidia-specific env vars if the target machine is not Nvidia:
  ```kdl
  // GBM_BACKEND "nvidia-drm"
  // __GLX_VENDOR_LIBRARY_NAME "nvidia"
  ```
- `init.sh` — the `DOTFILES_DIR` is hardcoded to `/media/Vault/Dotfiles`. Update it if the Vault is mounted at a different path, or if you've copied the dotfiles to a local directory.
- `cfg/misc.kdl` — `screenshot-path` has a hardcoded absolute path (`/home/ian/Pictures/Snaps/`). Make sure that directory exists, or update the path.

**Check if different:**
- `gtk-3.0/settings.ini` and `gtk-4.0/settings.ini` — `gtk-xft-dpi=98304` (= 96 DPI). Adjust for the laptop's actual DPI, especially on HiDPI screens.
- `alacritty.toml` — `title = "Alacritty@CachyOS"` is cosmetic; update to match the new machine name.

---

## ⌨️ Essential Keybinds
| Action | Keybinding |
| :--- | :--- |
| **Open Ghostty** | `Mod + Return` |
| **Launcher** | `Mod + Space` |
| **Close Window** | `Mod + Q` |
| **Horizontal Scroll** | `Mod + H / L` or `Mouse Wheel` |
| **Move Column** | `Mod + Ctrl + H / L` |
| **Toggle Floating** | `Mod + T` |
| **Overview** | `Mod + O` |
