local wezterm = require("wezterm")
local act = wezterm.action
local fmt = wezterm.format

-- Switch color scheme based on OS' appearence
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Darkian"
	else
		return "Lightian"
	end
end

-- Show leader status on status bar
wezterm.on("update-status", function(window, pane)
	-- Each element holds the text for a cell in a "powerline" style << fade
	local leader = fmt({})
	if window:leader_is_active() then
		leader = fmt({
			{ Background = { AnsiColor = "Blue" } },
			{ Foreground = { AnsiColor = "White" } },
			{ Attribute = { Intensity = "Bold" } },
			--{ Text = " " .. utf8.char(0xf0633) .. " " }, -- command: f0633, tux: f31a, mint: f08ed
			{ Text = " ^A " }, -- command: f0633, tux: f31a, mint: f08ed
		})
	end
	window:set_right_status(leader)
end)

-- My own color scheme
local Lightian = wezterm.color.get_builtin_schemes()["VSCodeLight+ (Gogh)"]
Lightian.foreground = "#020202"
Lightian.background = "#fcfcfc"
Lightian.ansi[1] = "#f1eff1"
Lightian.ansi[3] = "#009600"
Lightian.ansi[4] = "#a39400"
Lightian.ansi[7] = "#0488a9"
Lightian.brights[1] = "#8a8a8a"
Lightian.brights[3] = "#15a414"
Lightian.brights[4] = "#c8b929"
Lightian.brights[7] = "#4997b3"
Lightian.brights[8] = Lightian.foreground
Lightian.cursor_fg = Lightian.background
Lightian.cursor_bg = Lightian.foreground
Lightian.cursor_border = Lightian.foreground
Lightian.tab_bar = {
	background = Lightian.ansi[1],
	active_tab = {
		bg_color = Lightian.ansi[1],
		fg_color = Lightian.foreground,
		intensity = "Bold",
	},
	inactive_tab = {
		bg_color = Lightian.ansi[1],
		fg_color = Lightian.brights[1],
	},
	inactive_tab_hover = {
		bg_color = Lightian.ansi[1],
		fg_color = Lightian.brights[1],
		intensity = "Bold",
	},
	new_tab = {
		bg_color = Lightian.ansi[1],
		fg_color = Lightian.brights[1],
	},
	new_tab_hover = {
		bg_color = Lightian.ansi[1],
		fg_color = Lightian.brights[1],
		intensity = "Bold",
	},
}
local Darkian = wezterm.color.get_builtin_schemes()["Dark+"]
Darkian.ansi[1] = "#171717"
Darkian.ansi[4] = "#d1c126"
Darkian.ansi[8] = "#cdcdcd"
Darkian.ansi[6] = "#a36e64"
Darkian.brights[4] = "#febe38"
Darkian.brights[6] = "#b08572"
Darkian.tab_bar = {
	background = "#292e32",
	--background = Darkian.ansi[1],
	active_tab = {
		bg_color = Darkian.background,
		fg_color = Darkian.foreground,
		intensity = "Bold",
	},
	inactive_tab = {
		bg_color = Darkian.ansi[1],
		fg_color = Darkian.brights[1],
	},
	inactive_tab_hover = {
		bg_color = Darkian.ansi[1],
		fg_color = Darkian.brights[1],
		intensity = "Bold",
	},
	new_tab = {
		bg_color = "#292e32",
		--bg_color = Darkian.ansi[1],
		fg_color = Darkian.brights[1],
	},
	new_tab_hover = {
		bg_color = "#292e32",
		--bg_color = Darkian.ansi[1],
		fg_color = Darkian.brights[1],
		intensity = "Bold",
	},
}

return {
	-- Color scheme
	--color_scheme_dirs = { '/home/ian/.config/wezterm/schemes' },
	color_schemes = {
		["Lightian"] = Lightian,
		["Darkian"] = Darkian,
	},
	--color_scheme = "Lightian",
	--color_scheme = "Darkian",
	color_scheme = scheme_for_appearance(get_appearance()),
	--color_scheme = 'Dark+', -- 🌙
	--color_scheme = 'Gruber (base16)', -- 🌙
	--color_scheme = "Kanagawa (Gogh)", -- 🌙
	--color_scheme = 'VSCodeLight+ (Gogh)', -- 🌞
	--color_scheme = 'Windows High Contrast Light (base16)', -- 🌞

	-- Tab appearences
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,

	-- Window appearences
	window_background_opacity = 1.0,
	initial_cols = 120,
	initial_rows = 30,
	window_padding = {
		left = 1,
		right = 1,
		top = 0,
		bottom = 0,
	},
	window_close_confirmation = "NeverPrompt",

	-- Pane appearences
	inactive_pane_hsb = {
		saturation = 0.3,
		brightness = 0.8,
	},

	-- Text appearences
	font = wezterm.font("VictorMono Nerd Font", { weight = "DemiBold", style = "Normal" }),
	font_rules = {
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font("VictorMono Nerd Font", { weight = "DemiBold", style = "Italic" }),
		},
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font("VictorMono Nerd Font", { weight = "Bold", style = "Normal" }),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font("VictorMono Nerd Font", { weight = "Bold", style = "Italic" }),
		},
	},
	--font = wezterm.font({
	--	family = "Monaspace Neon",
	--	style = "Normal",
	--	harfbuzz_features = { 'calt', 'liga', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08' },
	--}),
	--font_rules = {
	--	{
	--		intensity = "Normal",
	--		italic = true,
	--		font = wezterm.font({
	--			family = "Monaspace Radon",
	--			weight = "Regular",
	--			style = "Normal",
	--			harfbuzz_features = { 'calt', 'liga', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08' },
	--		})
	--	},
	--	{
	--		intensity = "Bold",
	--		italic = true,
	--		font = wezterm.font({
	--			family = "Monaspace Radon",
	--			weight = "Bold",
	--			style = "Normal",
	--			harfbuzz_features = { 'calt', 'liga', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08' },
	--		})
	--	}
	--},
	font_size = 12,
	line_height = 1.1,

	-- -- Key assignments
	-- leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	-- keys = {
	-- 	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	-- 	{ mods = "LEADER|CTRL", key = "a", action = wezterm.action.SendString("\x01") },
	--
	-- 	-- Split pane horizontally
	-- 	{ mods = "LEADER", key = "'", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- 	{ mods = "LEADER|SHIFT", key = '"', action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- 	{ mods = "LEADER", key = "\\", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- 	{ mods = "LEADER|SHIFT", key = "|", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	--
	-- 	-- Split pane vertically
	-- 	{ mods = "LEADER", key = "-", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	--
	-- 	-- Move to pane
	-- 	{ mods = "LEADER", key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
	-- 	{ mods = "LEADER", key = "h", action = act.ActivatePaneDirection("Left") },
	--
	-- 	{ mods = "LEADER", key = "RightArrow", action = act.ActivatePaneDirection("Right") },
	-- 	{ mods = "LEADER", key = "l", action = act.ActivatePaneDirection("Right") },
	--
	-- 	{ mods = "LEADER", key = "UpArrow", action = act.ActivatePaneDirection("Up") },
	-- 	{ mods = "LEADER", key = "k", action = act.ActivatePaneDirection("Up") },
	--
	-- 	{ mods = "LEADER", key = "DownArrow", action = act.ActivatePaneDirection("Down") },
	-- 	{ mods = "LEADER", key = "j", action = act.ActivatePaneDirection("Down") },
	--
	-- 	-- Pane zoom toggle
	-- 	{ mods = "LEADER", key = "z", action = act.TogglePaneZoomState },
	--
	-- 	-- Close pane
	-- 	{ mods = "LEADER", key = "x", action = act.CloseCurrentPane({ confirm = true }) },
	--
	-- 	-- Rotate pane
	-- 	{ mods = "LEADER", key = "[", action = act.RotatePanes("CounterClockwise") },
	-- 	{ mods = "LEADER", key = "]", action = act.RotatePanes("Clockwise") },
	--
	-- 	-- Open new tab
	-- 	{ mods = "LEADER", key = "c", action = act.SpawnTab("CurrentPaneDomain") },
	--
	-- 	-- Move to tab
	-- 	{ mods = "LEADER", key = ",", action = act.ActivateTabRelative(-1) },
	-- 	{ mods = "LEADER", key = ".", action = act.ActivateTabRelative(1) },
	-- 	{ mods = "CTRL", key = ",", action = act.ActivateTabRelative(-1) },
	-- 	{ mods = "CTRL", key = ".", action = act.ActivateTabRelative(1) },
	--
	-- 	-- Move tab
	-- 	{ mods = "LEADER|SHIFT", key = "{", action = act.MoveTabRelative(-1) },
	-- 	{ mods = "LEADER|SHIFT", key = "}", action = act.MoveTabRelative(1) },
	-- },
}
