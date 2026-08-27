-- ── Decorations ──────────────────────────────────────────────────
-- Ported from niri/cfg/noctalia.kdl + niri/cfg/layout.kdl + niri/cfg/misc.kdl

hl.config({
    general = {
        gaps_in  = 4,   -- niri gaps 8 → split ~evenly
        gaps_out = 8,
        border_size = 2,
        col = {
            active_border   = ORANGE,
            inactive_border = BLACK_NEAR,
            no_border_on_floating = false,
        },
        layout = "scrolling",   -- set globally; workspaces.lua pins it per-workspace too
        resize_on_border = true,
    },

    decoration = {
        rounding       = 8,     -- niri: geometry-corner-radius 8
        rounding_power = 2,

        shadow = {
            enabled      = true,
            range        = 8,
            render_power = 2,
            color        = SHADOW_COL,
        },

        blur = {
            enabled   = true,
            size      = 4,
            passes    = 2,
            vibrancy  = 0.15,
            new_optimizations = true,
        },
    },

    group = {
        -- tab bar colors (closest to niri tab-indicator)
        groupbar = {
            enabled        = true,
            font_size      = 10,
            col = {
                active          = ORANGE,
                inactive        = BLACK_NEAR,
                locked_active   = ORANGE,
                locked_inactive = BLACK_NEAR,
            },
        },
    },

    cursor = {
        no_hardware_cursors = false,
        -- Bibata theme is set via XCURSOR_THEME/HYPRCURSOR_THEME env vars in environment.lua
    },
})
