-- ── Animations ───────────────────────────────────────────────────
-- Ported from niri/cfg/animation.kdl spring curves.
-- Hyprland uses bezier/spring curves. Springs are natively supported
-- in recent Hyprland — we match niri's damping-ratio/stiffness feel.

-- Bezier curves (fallback / non-spring animations)
hl.curve("easeOutQuad",   { type = "bezier", points = { {0.25, 0.46}, {0.45, 0.94} } })
hl.curve("easeOutCubic",  { type = "bezier", points = { {0.22, 1},    {0.36, 1}    } })
hl.curve("quick",         { type = "bezier", points = { {0.15, 0},    {0.1,  1}    } })

-- Spring curves (matches niri's spring config feel)
-- niri workspace-switch:        stiffness=1000 damping-ratio=1.0  → fast, no bounce
hl.curve("wsSwitch",   { type = "spring", mass = 1, stiffness = 1000, dampening = 40 })
-- niri horizontal-view-movement: stiffness=900  damping-ratio=1.0
hl.curve("viewMove",   { type = "spring", mass = 1, stiffness = 900,  dampening = 38 })
-- niri window-movement:          stiffness=800  damping-ratio=1.0
hl.curve("winMove",    { type = "spring", mass = 1, stiffness = 800,  dampening = 36 })
-- niri window-resize:            stiffness=1000 damping-ratio=1.0
hl.curve("winResize",  { type = "spring", mass = 1, stiffness = 1000, dampening = 40 })

-- Animations
-- global fallback
hl.animation({ leaf = "global",     enabled = true, speed = 3,   bezier = "quick" })
-- window open/close (niri: 200ms ease-out-quad/cubic)
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 2.5, bezier = "easeOutQuad",  style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "easeOutCubic", style = "slide" })
-- window movement (niri: spring stiffness=800)
hl.animation({ leaf = "windowsMove", enabled = true, spring = "winMove" })
-- workspace switch (niri: spring stiffness=1000)
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, spring = "wsSwitch", style = "slide" })
-- special workspaces
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 2, bezier = "quick", style = "slide top" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 2, bezier = "quick", style = "slide bottom" })
-- border / fade
hl.animation({ leaf = "fade",       enabled = true, speed = 2.5, bezier = "easeOutQuad" })
hl.animation({ leaf = "border",     enabled = true, speed = 2.5, bezier = "easeOutQuad" })
-- layer surfaces (Noctalia panels use their own animations)
hl.animation({ leaf = "layers",     enabled = true, speed = 2,   bezier = "easeOutQuad" })
