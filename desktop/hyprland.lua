-- Hyprland config (Lua) — ported from desktop/hyprland.conf
-- Not yet deployed: keep using hyprland.conf until this is verified.
-- See examples-configs/example-default.lua for the reference API.


------------------
---- MONITORS ----
------------------

hl.monitor({ output = "eDP-1", mode = "3840x2160@60", position = "0x0", scale = 1.5 })
hl.monitor({ output = "HDMI-A-2", mode = "2560x1440@144", position = "2560x0", scale = 1 })


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "nemo"
local browser     = "vivaldi-stable"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("hyprsunset --temperature 4000")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("waybar")
  hl.exec_cmd("[workspace 1 silent] " .. browser)

  -- Screen sharing
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

  -- Scratchpad on special:magic
  hl.exec_cmd("[workspace special:magic silent] " .. os.getenv("HOME") .. "/.dotfiles/desktop/scratchpad.sh")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


----------------------
---- WORKSPACES ----
----------------------

-- Monitor eDP-1
for _, ws in ipairs({ 1, 2, 3, 4, 5 }) do
  hl.workspace_rule({ workspace = tostring(ws), monitor = "eDP-1", persistent = true })
end

-- Monitor HDMI-A-2 — 6/7/8/9, default = true
for _, ws in ipairs({ 6, 7, 8, 9 }) do
  hl.workspace_rule({ workspace = tostring(ws), monitor = "HDMI-A-2", persistent = true, default = true })
end


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
  general = {
    gaps_in          = 10,
    gaps_out         = 10,
    border_size      = 2,
    col              = {
      active_border   = "rgba(33ccffee)",
      inactive_border = "rgba(595959aa)",
    },
    resize_on_border = false,
    allow_tearing    = false,
    layout           = "master",
  },

  decoration = {
    rounding         = 8,
    rounding_power   = 2,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },

    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

  master = {
    new_status    = "slave",
    new_on_active = "after",
  },

  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo   = false,
  },
})

-- Animation curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Animations
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })


---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout    = "us",
    follow_mouse = 2,
    sensitivity  = -0.5,
    repeat_rate  = 40,
    repeat_delay = 300,
    touchpad     = {
      natural_scroll = true,
    },
  },
})

-- Per-device overrides
hl.device({
  name       = "ite-tech.-inc.-ite-device(8258)-keyboard",
  kb_options = "ctrl:nocaps,ctrl:swap_lalt_lctl",
})

hl.device({
  name       = "kinesis-advantage2-keyboard-1",
  kb_options = "caps:escape, compose:lctrl",
})

hl.device({
  name        = "elan06fa:00-04f3:327e-touchpad",
  sensitivity = -0.3,
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.dotfiles/term/kitty/launch_work.sh"))

-- rofi — Ctrl+Return to copy calc result
hl.bind(mainMod .. " + R",
  hl.dsp.exec_cmd(
    [[rofi -modes "drun,calc" -show drun -calc-command -calc-command-history "echo -n '{result}' | wl-copy"]]))

-- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspace switch + move-active for 1–4 and 6–8
for _, i in ipairs({ 1, 2, 3, 4, 6, 7, 8 }) do
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + SHIFT + R", hl.dsp.layout("swapwithmaster"))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Cycle through windows of same class
hl.bind("SUPER + grave", hl.dsp.window.cycle_next({ same_class = true }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Laptop multimedia keys (using F-keys per current config, not XF86*)
hl.bind("F3", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("F2", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("F1", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("F6", hl.dsp.exec_cmd("brightnessctl s 5%+"), { locked = true, repeating = true })
hl.bind("F5", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Scratchpad lands on special:magic
hl.window_rule({
  name      = "scratchpad-to-magic",
  match     = { class = "scratchpad" },
  workspace = "special:magic",
})

-- Ignore maximize requests from all apps
hl.window_rule({
  name           = "suppress-maximize-events",
  match          = { class = ".*" },
  suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move  = "20 monitor_h-120",
  float = true,
})
