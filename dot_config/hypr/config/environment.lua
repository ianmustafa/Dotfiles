-- ── Environment Variables ─────────────────────────────────────────
-- Ported from niri/cfg/misc.kdl environment block.
-- Hyprland sets WAYLAND_DISPLAY and XDG_SESSION_TYPE itself;
-- the rest are forwarded to child processes.

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORM",              "wayland")
hl.env("QT_QPA_PLATFORMTHEME",         "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- Keep KDE portal/menu integration (Dolphin, KWallet, etc.)
hl.env("XDG_CURRENT_DESKTOP",          "Hyprland:KDE")
hl.env("XDG_MENU_PREFIX",              "plasma-")
hl.env("XDG_DATA_DIRS",                "/usr/local/share:/usr/share")
hl.env("GSETTINGS_SCHEMA_DIR",         "/home/ian/.local/share/glib-2.0/schemas")
-- Nvidia
hl.env("GBM_BACKEND",                  "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME",    "nvidia")
hl.env("NVD_BACKEND",                  "direct")   -- hardware video decode
-- Firefox / Zen
hl.env("MOZ_ENABLE_WAYLAND",           "1")
-- SSH
hl.env("SSH_AUTH_SOCK",                "/run/user/1000/ssh-agent")
hl.env("SSH_ASKPASS",                  "/usr/bin/ksshaskpass")
hl.env("SSH_ASKPASS_REQUIRE",          "prefer")
-- Cursor
hl.env("XCURSOR_THEME",                "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE",                 "24")
hl.env("HYPRCURSOR_THEME",             "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE",              "24")
