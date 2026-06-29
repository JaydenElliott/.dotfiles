local MACHINE = os.getenv("HL_MACHINE")


-- monitor setup
local primaryMonitor
local secondaryMonitor

if MACHINE == "DESKTOP" then
  primaryMonitor   = "DP-1"
  secondaryMonitor = "DP-2"
  hl.monitor({ output = primaryMonitor, mode = "3840x2160@60", position = "0x0", scale = 1.5 })
  hl.monitor({ output = secondaryMonitor, mode = "2560x1440@144", position = "2560x0", scale = 1 })
elseif MACHINE == "LAPTOP" then
  primaryMonitor   = "eDP-1"
  secondaryMonitor = "HDMI-A-2"
  hl.monitor({ output = primaryMonitor, mode = "2560x1600@240", position = "0x0", scale = 1.6 })
  hl.monitor({ output = secondaryMonitor, mode = "3840x2160@60", position = "1600x0", scale = 1.5 })
end


-- workspaces
for i = 1, 5 do
  hl.workspace_rule({ workspace = tostring(i), monitor = 0, persistent = true })
end
for i = 6, 9 do
  hl.workspace_rule({ workspace = tostring(i), monitor = 1, persistent = true, default = true })
end



local terminal      = "kitty"
local fileManager   = "nemo"
local browser       = "vivaldi-stable"
local scratchpadDir = os.getenv("HOME") .. "/Documents/Obsidian/work-notes/scratchpads"


-- auto start
local function open_scratchpad()
  local handle = io.popen("ls " .. scratchpadDir .. "/scratchpad_*.md 2>/dev/null | grep -oP '\\d+' | sort -n | tail -1")
  local latest = handle:read("*l")
  handle:close()
  if not latest or latest == "" then latest = "1" end
  hl.exec_cmd("[workspace special:magic silent] kitty --class scratchpad nvim " ..
    scratchpadDir .. "/scratchpad_" .. latest .. ".md")
end

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
  open_scratchpad()
end)


-- appearance

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


hl.config({
  general = {
    gaps_in  = 10,
    gaps_out = 10,
    col      = { active_border = "rgba(33ccffee)" },
    layout   = "master",
  },

  decoration = {
    rounding = 8,
  },

  animations = {
    enabled = true,
  },

  master = {
    new_status    = "slave",
    new_on_active = "after",
  },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

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


-- input
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


-- device configuration
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


-- keybindings
local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.dotfiles/term/kitty/launch_work.sh"))

-- rofi — Ctrl+Return to copy calc result
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(
  [[rofi -modes "drun,calc" -show drun -calc-command "echo -n '{result}' | wl-copy" -calc-command-history]]))

-- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspace switch + move-active
for _, i in ipairs({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }) do
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
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- window rules
hl.window_rule({
  name           = "suppress-maximize-events",
  match          = { class = ".*" },
  suppress_event = "maximize",
})

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
