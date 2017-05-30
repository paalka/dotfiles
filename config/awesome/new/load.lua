local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local watch = require("awful.widget.watch")

LOAD_AVG_PATH = "/proc/loadavg"

cpu_load_sub_widget = wibox.widget.textbox()
cpu_load_widget = wibox.widget{
  {
    cpu_load_sub_widget,
    fg = "#6e6e6e",
    forced_width = 65,
    widget = wibox.container.background
  },
  layout = wibox.container.margin(cpu_load_widget, 5, 5, 5, 5)
}

watch(
"sh -c \"cat " .. LOAD_AVG_PATH .. " | cut -d ' ' -f 1\"", 10,
    function(widget, stdout, stderr, exitreason, exit_code)
      -- Get the average load for the last minute
      local avg_load = stdout:sub(1, -2) -- remove the newline

      if avg_load == '' then
          avg_load = "Could not find average load!"
      end

      cpu_load_sub_widget.text = string.format("[ %s ] ", avg_load)
    end
    )
