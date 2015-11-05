-- Create an ACPI widget
batterywidget = widget({ type = "textbox" })
batterywidget.text = "  [Battery] "
batterywidgettimer = timer({ timeout = 5 })
batterywidgettimer:add_signal("timeout",
  function()
    bat0 = assert(io.popen("acpi | grep 'Battery 0:' | cut -d, -f 2,3 | xargs", "r"))
    bat1 = assert(io.popen("acpi | grep 'Battery 1:' | cut -d, -f 2,3 | xargs", "r"))
    batterywidget.text = " [ " .. bat0:read("*l") .. " ]  [ " .. bat1:read("*l") .. " ]"
    bat0:close()
    bat1:close()
  end
)
batterywidgettimer:start()
