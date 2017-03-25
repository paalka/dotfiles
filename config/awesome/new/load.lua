local wibox = require("wibox")
local gears = require("gears")

LOAD_AVG_PATH = "/proc/loadavg"

-- Creates the text to be shown on the widget.
function getAverageLoadText()
    local average_load = getAverageLoad()
    local widget_text = string.format("[ %s ] ", average_load)
    return widget_text
end

function getAverageLoad()
    -- Get the average load for the last minute
    local load_avg_cmd = assert(io.popen("cat " .. LOAD_AVG_PATH .. " | cut -d ' ' -f 1"))
    local avg_load = load_avg_cmd:read("*l")

    if avg_load == '' then
        avg_load = "Could not find average load!"
    end

    return avg_load
end

cpu_load_sub_widget = wibox.widget.textbox()
cpu_load_widget_timer = gears.timer({ timeout = 5 })
cpu_load_widget_timer:connect_signal("timeout",
  function()
    cpu_load_sub_widget.text = getAverageLoadText()
  end
)

cpu_load_widget = wibox.widget{
  {
    cpu_load_sub_widget,
    fg = "#6e6e6e",
    forced_width = 50,
    widget = wibox.container.background
  },
  layout = wibox.container.margin(cpu_load_widget, 5, 5, 5, 5)
}
cpu_load_sub_widget.text = getAverageLoadText()
cpu_load_widget_timer:start()
