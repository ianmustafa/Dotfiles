-- ── Misc ─────────────────────────────────────────────────────────

hl.config({
    misc = {
        disable_hyprland_logo      = true,
        disable_splash_rendering   = true,
        force_default_wallpaper    = 0,
        font_family                = "sans-serif",
        -- Allow Noctalia / any app to activate a window (xdg-activation)
        focus_on_activate          = true,
        -- niri: prefer-no-csd → ask clients to drop their own decorations
        no_direct_scanout          = false,
    },

    xwayland = {
        enabled    = true,
        use_nearest_neighbor = false,
        force_zero_scaling   = false,
    },

    debug = {
        -- Uncomment if you hit Nvidia tearing issues:
        -- damage_tracking = 0,
    },

    scrolling = {
        column_width            = 0.5,  -- niri default-column-width proportion 0.5
        fullscreen_on_one_column = true,
        focus_fit_method        = 1,    -- 1 = fit (niri center-focused-column "never")
        follow_focus            = true,
        follow_min_visible      = 0.2,
        -- preset column widths cycled with Mod+R (see binds.lua)
        explicit_column_widths  = { 0.33333, 0.5, 0.66667 },
    },
})
