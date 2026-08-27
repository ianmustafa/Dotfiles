# Hyprland + Noctalia Shell: Getting Started Guide

This setup mirrors the niri config as closely as possible: Hyprland as the compositor (scrolling layout), Noctalia as the shell, Ghostty as the terminal. Config is split across `~/.config/hypr/config/*.lua`, loaded by `hyprland.lua`.

---

## 📦 Dependencies

| Package | Reason |
| :--- | :--- |
| `hyprland` | Compositor (≥ 0.55, Lua config) |
| `noctalia` | Shell (bar, launcher, OSD, notifications, lock) |
| `ghostty` | Terminal (`TERMINAL` in `config/variables.lua`) |
| `zen-browser` | Browser (`BROWSER` in `config/variables.lua`) |
| `dolphin` | File manager |
| `grim` + `slurp` | Screenshot capture |
| `grimshot` | Screenshot wrapper at `~/.local/bin/grimshot` |
| `satty` | Screenshot annotation |
| `kwalletd6` / `ksecretservice` | Secret service, autostarted |
| `ksshaskpass` | `SSH_ASKPASS` in `config/environment.lua` |
| `kwallet-pam` | Unlock wallet on SDDM login |
| `xdg-desktop-portal-hyprland` | Screen sharing / file dialogs |
| `bibata-cursor-theme` | Cursor (`Bibata-Modern-Classic`) |
| `papirus-icon-theme` | GTK icon theme |
| `qt6ct` | Qt6 theming outside KDE |
| `inter-font` | Used by Noctalia shell |
| `ttf-outfit` | Used by Noctalia shell |
| `noto-fonts` + `noto-fonts-cjk` | GTK / CJK font support |

---

## 🚀 Quick Start

- **Login:** Select **Hyprland** from SDDM (keep using SDDM — no greeter change needed).
- **Terminal:** `Mod + Return` → Ghostty
- **Launcher:** `Mod + Space` → Noctalia launcher
- **Session Menu:** `Mod + Shift + Q`

---

## 🛠️ System Configuration

- **Compositor:** Hyprland ≥ 0.55 (Lua config, scrolling layout — infinite horizontal tape like niri).
- **Shell:** Noctalia (all `noctalia msg ...` IPC calls work identically to niri).
- **Display Manager:** SDDM (unchanged).
- **Portals:** `xdg-desktop-portal-hyprland` for screen sharing. The autostart script kills `xdg-desktop-portal-gnome` if it races in.
- **XWayland:** Enabled in `config/misc.lua`.
- **Nvidia:** `GBM_BACKEND`, `__GLX_VENDOR_LIBRARY_NAME`, `NVD_BACKEND` set in `config/environment.lua`.

---

## 📁 File Structure

```
~/.config/hypr/
  hyprland.lua              ← entry point, requires all modules
  SETUP.md                  ← this file
  config/
    variables.lua           ← MONITOR1, TERMINAL, BROWSER, FILE_MANAGER
    colors.lua              ← orange accent palette (#e66800)
    environment.lua         ← env vars (nvidia, qt, wayland, ssh, cursor)
    monitors.lua            ← HDMI-A-1 2560x1080@60
    inputs.lua              ← keyboard, mouse, touchpad
    animations.lua          ← spring + bezier curves
    decorations.lua         ← rounding, borders, blur, gaps, shadows
    misc.lua                ← scrolling layout settings, xwayland, misc
    autostart.lua           ← dbus env, noctalia, kwalletd6, ssh-agent
    workspaces.lua          ← 9 persistent workspaces, layout=scrolling
    windowrules.lua         ← per-app float/size/position rules
    binds.lua               ← all keybinds
```

---

## ⚙️ First-Boot Checklist

**Must update:**
- `config/variables.lua` — confirm `MONITOR1` matches `hyprctl monitors` output (currently `"HDMI-A-1"`).
- `config/monitors.lua` — update mode/scale if monitor changes.
- `config/autostart.lua` — confirm `/run/user/1000/ssh-agent` socket path matches your UID.

**Check if different:**
- `config/windowrules.lua` — `scrolling_width` fractions are computed for a 2560px-wide screen. Update if monitor width changes.
- Screenshot path in grimshot script at `~/.local/bin/grimshot` — ensure `~/Pictures/Snaps/` exists.

---

## 🔄 Ported from Niri — What Changed

| niri concept | Hyprland equivalent |
| :--- | :--- |
| Infinite horizontal scroll | Built-in scrolling layout (`layout = "scrolling"`) |
| `focus-column-left/right` | `hl.dsp.layout("focus l/r")` |
| `move-column-left/right` | `hl.dsp.layout("swapcol l/r")` |
| `consume-or-expel-window` | `hl.dsp.layout("consume_or_expel prev/next")` |
| `expand-column-to-available-width` | `hl.dsp.layout("fit expand")` — `Mod+X` |
| `set-column-width` / preset widths | `hl.dsp.layout("colresize cycle")` — `Mod+R` |
| `toggle-overview` | `hl.dsp.overview_toggle()` — `Mod+O` |
| `power-off-monitors` | `hl.dsp.dpms("off")` — `Mod+Shift+P` |
| `quit` | `hl.dsp.exit()` — `Ctrl+Alt+Delete` |
| `toggle-column-tabbed-display` | **no equivalent** — dropped |
| `center-visible-columns` | **no equivalent** — dropped |
| Noctalia `noctalia msg ...` IPC | identical — all IPC commands unchanged |

---

## ⌨️ Essential Keybinds

| Action | Keybinding |
| :--- | :--- |
| Open Ghostty | `Mod + Return` |
| Launcher | `Mod + Space` |
| Close Window | `Mod + Q` |
| Focus column left/right | `Mod + H / L` or `Mod + ←/→` |
| Focus window up/down | `Mod + K / J` or `Mod + ↑/↓` |
| Move column left/right | `Mod + Ctrl + H / L` |
| Move window up/down | `Mod + Ctrl + K / J` |
| Cycle column width (⅓/½/⅔) | `Mod + R` |
| Expand column to full width | `Mod + X` |
| Consume/expel window | `Mod + , / .` |
| Toggle floating | `Mod + T` |
| Maximize | `Mod + F` |
| Overview | `Mod + O` |
| Switch workspace 1–9 | `Mod + 1–9` |
| Move window to workspace | `Mod + Shift + 1–9` |
| Screenshot: area | `Print` |
| Screenshot: screen | `Shift + Print` |
| Screenshot: window | `Ctrl + Print` |
| Lock screen | `Mod + Alt + L` |
| Turn off monitors | `Mod + Shift + P` |
| Exit Hyprland | `Ctrl + Alt + Delete` |
