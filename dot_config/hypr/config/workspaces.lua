-- ── Workspaces ───────────────────────────────────────────────────
-- 9 persistent workspaces on HDMI-A-1, all using the scrolling layout.
-- niri used infinite scroll per workspace — scrolling layout replicates that.

local mon = MONITOR1

for i = 1, 9 do
    hl.workspace_rule({
        workspace   = tostring(i),
        monitor     = mon,
        persistent  = true,
        default     = (i == 1),
        layout      = "scrolling",
    })
end
