-- ── Autostart ────────────────────────────────────────────────────
-- Ported from niri/cfg/autostart.kdl
-- No UWSM — using plain exec_once.

hl.on("hyprland.start", function()
    -- Forward env to D-Bus / systemd user session
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORM QT_QPA_PLATFORMTHEME SSH_AUTH_SOCK SSH_ASKPASS SSH_ASKPASS_REQUIRE")

    -- Kill gnome portal if it sneaks in (only keep hyprland portal)
    hl.exec_cmd("bash -c 'while ! busctl --user status org.gnome.Mutter.ScreenCast >/dev/null 2>&1; do sleep 0.2; done; pkill -f xdg-desktop-portal-gnome'")

    -- Shell
    hl.exec_cmd("noctalia")

    -- KDE wallet (needed by ksshaskpass, Dolphin, etc.)
    hl.exec_cmd("kwalletd6")

    -- SSH agent
    hl.exec_cmd("ssh-agent -D -a /run/user/1000/ssh-agent")
end)
