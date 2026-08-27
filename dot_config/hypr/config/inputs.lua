-- ── Input ─────────────────────────────────────────────────────────
-- Ported from niri/cfg/input.kdl

hl.config({
    input = {
        kb_layout  = "us",
        kb_options = "ctrl:nocaps",         -- Caps Lock → Ctrl
        numlock_by_default = true,

        -- Mouse: flat accel, no acceleration
        accel_profile = "flat",
        sensitivity   = 0.0,
        natural_scroll = true,

        touchpad = {
            tap_to_click   = true,
            natural_scroll = true,
            -- drag_lock    = true,        -- uncomment if you prefer
        },

        -- focus_follows_mouse = 1,        -- uncomment to enable
    },

    binds = {
        workspace_back_and_forth = true,    -- niri: workspace-auto-back-and-forth
    },
})
