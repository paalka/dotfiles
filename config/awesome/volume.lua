local wibox = require("wibox")
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
watch(
"pulsemixer --get-volume --get-mute",
1,
function(widget, stdout, stderr, exitreason, exitcode)
  local volume, mute_status = string.match(stdout, "(%d+).*(%d)")
  if volume ~= nil then
    local volume_text = volume .. "%"
    if mute_status == "0" then
      volume_text = " <span>🔉 " .. volume_text .. "</span>"
    else
      volume_text = " <span color='#ff638f'>🔇 " .. volume_text .. "</span>"
    end
    volume_sub_widget.markup = volume_text
  else
    volume_sub_widget.markup = "unavailable"
  end
end
)
