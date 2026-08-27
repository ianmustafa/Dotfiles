-- ── Window Rules ─────────────────────────────────────────────────
-- Ported from niri/cfg/rules.kdl
-- Uses Hyprland ≥ 0.55 Lua windowrule syntax.

-- ─── Global: round all window corners ────────────────────────────
-- (niri: geometry-corner-radius 8 on every window-rule)
-- Rounding is set globally in decorations.lua (rounding = 8).

-- ─── Noctalia panels: blur + no compositor animation ─────────────
-- (niri: layer-rule for noctalia-wallpaper uses place-within-backdrop
--  which has no Hyprland equivalent; Noctalia manages its own wallpaper layer)
hl.layer_rule({
    name  = "noctalia-blur",
    match = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached%-panel|osd|window%-switcher)$" },
    no_anim     = true,
    ignore_alpha = 0.5,
    blur        = true,
    blur_popups = true,
})

-- ─── Noctalia settings window ────────────────────────────────────
hl.window_rule({
    name  = "noctalia-settings",
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size  = { 1080, 920 },
})

-- ─── Steam ───────────────────────────────────────────────────────
-- float all steam windows except the main one
hl.window_rule({
    name  = "steam-float",
    match = { class = "steam", title = ".*", negative_title = "^[Ss]team$" },
    float = true,
})
-- steam notification toasts: bottom-right, no focus
hl.window_rule({
    name  = "steam-toasts",
    match = { class = "steam", title = "^notificationtoasts_%d+_desktop$" },
    float    = true,
    position = { x = -10, y = -10 },   -- Hyprland: negative = from bottom-right edge
    no_focus = true,
})

-- ─── Zen Browser ─────────────────────────────────────────────────
-- Picture-in-Picture
hl.window_rule({
    name  = "zen-pip",
    match = { class = "zen", title = "^Picture%-in%-Picture$" },
    float    = true,
    pin      = true,
    size     = { 854, 480 },
    position = { x = -32, y = -32 },   -- bottom-right
    minsize  = { 640, 360 },
    maxsize  = { 1280, 720 },
    rounding = 4,
})
-- Google login popup
hl.window_rule({
    name  = "zen-google-login",
    match = { class = "zen", title = "^Login.+Google" },
    float    = true,
    size     = { 640, 640 },
    center   = true,
})
-- PayPal checkout
hl.window_rule({
    name  = "zen-paypal",
    match = { class = "zen", title = "^PayPal Checkout" },
    float    = true,
    size     = { 640, 640 },
    center   = true,
})

-- ─── Ente Auth ───────────────────────────────────────────────────
hl.window_rule({
    name  = "ente-auth",
    match = { class = "io.ente.auth" },
    float    = true,
    size     = { 460, 720 },
    position = { x = 0, y = 32 },   -- top-center
    center   = true,
})

-- ─── ZapZap (WhatsApp) ───────────────────────────────────────────
hl.window_rule({
    name  = "zapzap",
    match = { class = "com.rtosta.zapzap" },
    scrolling_width = 1024 / 2560,  -- fixed 1024px on 2560-wide monitor
})

-- ─── Telegram Desktop ────────────────────────────────────────────
hl.window_rule({
    name  = "telegram",
    match = { class = "org.telegram.desktop" },
    scrolling_width = 1024 / 2560,
})

-- ─── DBeaver splash ──────────────────────────────────────────────
hl.window_rule({
    name  = "dbeaver-splash",
    match = { class = "java", title = "^[Dd][Bb]eaver" },
    float    = true,
    size     = { 600, 300 },
    position = { x = 980, y = 350 },
    rounding = 2,
})

-- ─── DBeaver main app ────────────────────────────────────────────
hl.window_rule({
    name  = "dbeaver-main",
    match = { class = "DBeaver" },
    scrolling_width = 2048 / 2560,
})

-- ─── Satty annotation tool ───────────────────────────────────────
hl.window_rule({
    name  = "satty",
    match = { class = "com.gabm.satty" },
    float = true,
    size  = { 1440, 900 },
    center = true,
})

-- ─── Ghostty terminal ────────────────────────────────────────────
-- (blur commented out in niri — kept as comment here too)
-- hl.window_rule({ match = { class = "com.mitchellh.ghostty" }, blur = true })

-- ─── Alacritty ───────────────────────────────────────────────────
-- hl.window_rule({ match = { class = "Alacritty" }, blur = true })

-- ─── XWayland / misc ─────────────────────────────────────────────
-- allow xhost apps (set in autostart: xhost +SI:localuser:root)
-- no rule needed; handled by xhost call in autostart.lua
