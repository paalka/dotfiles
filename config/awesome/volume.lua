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
   "amixer sget Master",
   1,
   function(widget, stdout, stderr, exitreason, exitcode)
      local volume = string.match(stdout,  ".*%[(%d+%%)%].*")
      if volume ~= nil then
	 status = string.match(stdout, "%[(o[^%]]*)%]")
	 if string.find(status, "on", 1, true) then
	    volume = " <span>🔉 " .. volume .. "</span>"
	 else
	    volume = " <span color='#ff638f'>🔇 " .. volume .. "</span>"
	 end
	 volume_sub_widget.markup = volume
      else
	 volume_sub_widget.markup = "Device not found"
      end
   end
)
