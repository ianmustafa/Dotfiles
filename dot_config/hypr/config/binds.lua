-- ── Keybinds ─────────────────────────────────────────────────────
-- Ported from niri/cfg/keybinds.kdl
-- Hyprland ≥ 0.55 Lua syntax. mainMod = Super.

local m   = "SUPER"
local ipc = "noctalia msg "

-- ─── Applications ────────────────────────────────────────────────
hl.bind(m .. "+Return",        hl.dsp.exec_cmd(TERMINAL))
hl.bind(m .. "+Space",         hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(m .. "+B",             hl.dsp.exec_cmd(BROWSER))
hl.bind(m .. "+E",             hl.dsp.exec_cmd(FILE_MANAGER))
hl.bind(m .. "+backslash",     hl.dsp.exec_cmd("enteauth"))
hl.bind(m .. "+slash",         hl.dsp.exec_cmd(ipc .. "panel-toggle launcher /e"))
hl.bind(m .. "+SHIFT+slash",   hl.dsp.exec_cmd(ipc .. "panel-toggle launcher /uni"))

-- ─── Session ─────────────────────────────────────────────────────
hl.bind(m .. "+ALT+L",         hl.dsp.exec_cmd(ipc .. "session lock"))
hl.bind(m .. "+SHIFT+Q",       hl.dsp.exec_cmd(ipc .. "panel-toggle session"))

-- ─── Media Controls ──────────────────────────────────────────────
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(ipc .. "volume-up"))
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(ipc .. "volume-down"))
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd(ipc .. "mic-mute"))
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd(ipc .. "media next"))
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd(ipc .. "media previous"))
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd(ipc .. "media toggle"))
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd(ipc .. "media toggle"))
hl.bind("Pause",                 hl.dsp.exec_cmd(ipc .. "mic-mute"))  -- Pause as mic mute

-- ─── Brightness ──────────────────────────────────────────────────
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(ipc .. "brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

-- ─── Window: close / float / fullscreen ──────────────────────────
hl.bind(m .. "+Q",             hl.dsp.kill_active())
hl.bind(m .. "+F",             hl.dsp.fullscreen(1))          -- maximize (layout-aware)
hl.bind(m .. "+SHIFT+F",       hl.dsp.fullscreen(0))          -- true fullscreen
hl.bind(m .. "+T",             hl.dsp.toggle_floating())
hl.bind(m .. "+P",             hl.dsp.pin())                  -- pin floating window

-- ─── Focus: columns (left/right) and windows within column ───────
hl.bind(m .. "+Left",          hl.dsp.layout("focus l"))
hl.bind(m .. "+H",             hl.dsp.layout("focus l"))
hl.bind(m .. "+Right",         hl.dsp.layout("focus r"))
hl.bind(m .. "+L",             hl.dsp.layout("focus r"))
hl.bind(m .. "+Up",            hl.dsp.layout("focus u"))
hl.bind(m .. "+K",             hl.dsp.layout("focus u"))
hl.bind(m .. "+Down",          hl.dsp.layout("focus d"))
hl.bind(m .. "+J",             hl.dsp.layout("focus d"))

-- ─── Move: swap columns / move windows within column ─────────────
hl.bind(m .. "+CTRL+Left",     hl.dsp.layout("swapcol l"))
hl.bind(m .. "+CTRL+H",        hl.dsp.layout("swapcol l"))
hl.bind(m .. "+CTRL+Right",    hl.dsp.layout("swapcol r"))
hl.bind(m .. "+CTRL+L",        hl.dsp.layout("swapcol r"))
hl.bind(m .. "+CTRL+Up",       hl.dsp.layout("move u"))
hl.bind(m .. "+CTRL+K",        hl.dsp.layout("move u"))
hl.bind(m .. "+CTRL+Down",     hl.dsp.layout("move d"))
hl.bind(m .. "+CTRL+J",        hl.dsp.layout("move d"))

-- ─── Focus: first / last column ──────────────────────────────────
hl.bind(m .. "+Home",          hl.dsp.layout("focus_first"))
hl.bind(m .. "+End",           hl.dsp.layout("focus_last"))
hl.bind(m .. "+CTRL+Home",     hl.dsp.layout("move_first"))
hl.bind(m .. "+CTRL+End",      hl.dsp.layout("move_last"))

-- ─── Monitor focus / move to monitor ─────────────────────────────
hl.bind(m .. "+SHIFT+Left",        hl.dsp.focus_monitor("l"))
hl.bind(m .. "+SHIFT+Right",       hl.dsp.focus_monitor("r"))
hl.bind(m .. "+SHIFT+Up",          hl.dsp.focus_monitor("u"))
hl.bind(m .. "+SHIFT+Down",        hl.dsp.focus_monitor("d"))
hl.bind(m .. "+SHIFT+CTRL+Left",   hl.dsp.move_to_monitor("l"))
hl.bind(m .. "+SHIFT+CTRL+Right",  hl.dsp.move_to_monitor("r"))
hl.bind(m .. "+SHIFT+CTRL+Up",     hl.dsp.move_to_monitor("u"))
hl.bind(m .. "+SHIFT+CTRL+Down",   hl.dsp.move_to_monitor("d"))

-- ─── Column width cycle (niri: preset-column-widths 0.33/0.5/0.67) ─
hl.bind(m .. "+R",             hl.dsp.layout("colresize cycle"))

-- ─── Consume / expel (niri: consume-or-expel-window-left/right) ──
hl.bind(m .. "+COMMA",         hl.dsp.layout("consume_or_expel prev"))
hl.bind(m .. "+PERIOD",        hl.dsp.layout("consume_or_expel next"))
-- explicit consume into column / expel out of column
hl.bind(m .. "+SHIFT+COMMA",   hl.dsp.layout("consume"))
hl.bind(m .. "+SHIFT+PERIOD",  hl.dsp.layout("expel"))

-- ─── Expand column to available width ────────────────────────────
hl.bind(m .. "+X",             hl.dsp.layout("fit expand"))

-- ─── Workspace switching (number keys) ───────────────────────────
for i = 1, 9 do
    local key = tostring(i)
    hl.bind(m .. "+" .. key,         hl.dsp.workspace(key))
    hl.bind(m .. "+SHIFT+" .. key,   hl.dsp.move_to_workspace(key))
    hl.bind(m .. "+CTRL+" .. key,    hl.dsp.move_to_workspace_silent(key))
end

-- ─── Workspace switching (scroll wheel, niri-style) ──────────────
hl.bind(m .. "+mouse_down",    hl.dsp.workspace("e+1"))   -- next workspace
hl.bind(m .. "+mouse_up",      hl.dsp.workspace("e-1"))   -- prev workspace
hl.bind(m .. "+CTRL+mouse_down", hl.dsp.move_to_workspace("e+1"))
hl.bind(m .. "+CTRL+mouse_up",   hl.dsp.move_to_workspace("e-1"))

-- Horizontal scroll → focus column left/right (niri: Mod+WheelScrollRight/Left)
hl.bind(m .. "+mouse_right",   hl.dsp.layout("focus r"))
hl.bind(m .. "+mouse_left",    hl.dsp.layout("focus l"))

-- ─── Screenshots (grimshot, same as niri) ────────────────────────
hl.bind("Print",               hl.dsp.exec_cmd("/home/ian/.local/bin/grimshot area"))
hl.bind("SHIFT+Print",         hl.dsp.exec_cmd("/home/ian/.local/bin/grimshot screen"))
hl.bind("CTRL+Print",          hl.dsp.exec_cmd("/home/ian/.local/bin/grimshot window"))

-- ─── Power / exit ────────────────────────────────────────────────
hl.bind("CTRL+ALT+Delete",     hl.dsp.exit())
hl.bind(m .. "+SHIFT+P",       hl.dsp.dpms("off"))        -- niri: power-off-monitors

-- ─── Overview (niri: toggle-overview) ────────────────────────────
hl.bind(m .. "+O",             hl.dsp.overview_toggle())

-- ─── Emergency: release any keyboard inhibitor ───────────────────
-- (niri: toggle-keyboard-shortcuts-inhibit)
hl.bind(m .. "+Escape",        hl.dsp.pass())  -- passthrough; inhibitor released by Hyprland on Super

-- ─── Mouse button binds (move/resize floating windows) ───────────
hl.bind(m .. "+mouse:272",     hl.dsp.move_window())      -- LMB drag
hl.bind(m .. "+mouse:273",     hl.dsp.resize_window())    -- RMB drag
