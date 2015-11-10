-- Create an ACPI widget
batterywidget = widget({ type = "textbox" })
batterywidget.text = "  [Battery] "
batterywidgettimer = timer({ timeout = 5 })
batterywidgettimer:add_signal("timeout",
  function()
    -- TODO: Rewrite this to get the total of all batteries, and put them in
    -- the same indicator, to avoid cluttering the menubar.
    bat0 = assert(io.popen("acpi | grep 'Battery 0:' | cut -d, -f 2,3 | xargs", "r"))
    bat1 = assert(io.popen("acpi | grep 'Battery 1:' | cut -d, -f 2,3 | xargs", "r"))

    batterywidget.text = " [ " .. bat0:read("*l") .. " ]  [ " .. bat1:read("*l") .. " ]"
    bat0:close()
    bat1:close()

    if batteryPercent("BAT0") < 10 and batteryPercent("BAT1") < 10 then
        naughty.notify({ title  = "Low battery Warning"
                                , text       = "Less than 10% battery left!"
                                , timeout    = 5
                                , position   = "top_right"
                                , fg         = beautiful.fg_focus
                                , bg         = beautiful.bg_focus
                                })
    end
  end
)
function batteryPercent(battery_name)
    local adapter_current_capacity_file = io.open("/sys/class/power_supply/" .. battery_name .. "/capacity")
    local adapter_current_capacity = adapter_current_capacity_file:read()

    -- Return the percentage as an int.
    return tonumber(adapter_current_capacity)
end

batterywidgettimer:start()
