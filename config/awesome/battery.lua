-- Create an ACPI widget
batterywidget = widget({ type = "textbox" })
batterywidget.text = "  [Battery] "
batterywidgettimer = timer({ timeout = 5 })
batterywidgettimer:add_signal("timeout",
  function()
    fh = assert(io.popen("acpi | awk 1 ORS=', ' | cut -d, -f 2,4,5", "r"))
    batterywidget.text = "  [" .. fh:read("*l") .. " ]"
    fh:close()
  end
)
batterywidgettimer:start()
