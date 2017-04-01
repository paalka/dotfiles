local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local watch = require("awful.widget.watch")


volume_sub_widget = wibox.widget.textbox()
volume_widget = wibox.widget{
  {
    volume_sub_widget,
    forced_width = 60,
    widget = wibox.container.background
  },
  layout = wibox.container.margin(volume_widget, 5, 5, 5, 5)
}

function update_volume(widget)
    local fd = io.popen("amixer sget Master")
    local status = fd:read("*all")
    fd:close()

    local volume = tonumber(string.match(status, "(%d?%d?%d)%%"))
    if volume ~= nil then
        volume = string.format("%3d", volume)

        status = string.match(status, "%[(o[^%]]*)%]")
        if string.find(status, "on", 1, true) then
            volume = " <span>🔉" .. volume .. "%</span>"
        else
            volume = " <span color='#ff284c'>🔇" .. volume .. "%</span>"
        end
        widget.markup = volume
    else
        widget.markup = "Device not found"
    end
 end

update_volume(volume_sub_widget)
volume_widget_timer = gears.timer({ timeout = 1 })
volume_widget_timer:connect_signal("timeout", function()
  update_volume(volume_sub_widget)
  end
)

volume_widget_timer:start()
