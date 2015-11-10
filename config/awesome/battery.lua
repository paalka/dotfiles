POWER_SUPPLY_PATH = "/sys/class/power_supply/"
BATTERY_NAMES = {"BAT0", "BAT1"}
ACPI_BATTERY_NAMES = {"Battery 0", "Battery 1"}

battery_warning_shown = false

function getBatteryWidgetText(acpi_battery_names)
    if isCharging() then
        widget_text = " ⚡"
    else
        widget_text = " 🔋"
    end

    for i, acpi_battery_name in ipairs(acpi_battery_names) do
        acpi_battery_status = getACPIBatteryStatus(acpi_battery_name)
        widget_text = string.format("%s [ %s ] ", widget_text, acpi_battery_status)
    end
    return widget_text
end

function getACPIBatteryStatus(acpi_battery_name)
    local battery_status_cmd = assert(io.popen("acpi | grep '" .. acpi_battery_name .. ":' | cut -d, -f 2,3 | xargs", "r"))
    local battery_status = battery_status_cmd:read("*l")

    return battery_status
end

function getTotalBatteryPercent(battery_names)
    local total_percent = 0
    for i, battery_name in ipairs(battery_names) do
        total_percent = total_percent + getBatteryPercent(battery_name)
    end
    return total_percent
end

function isCharging()
    local charging_status_file = io.open(POWER_SUPPLY_PATH .. "AC/online")
    local charging_status = charging_status_file:read()
    return charging_status == "1"
end

function getBatteryPercent(battery_name)
    local adapter_current_capacity_file = io.open(POWER_SUPPLY_PATH .. battery_name .. "/capacity")
    local adapter_current_capacity = adapter_current_capacity_file:read()

    return tonumber(adapter_current_capacity)
end

batterywidgettimer = timer({ timeout = 5 })
batterywidgettimer:add_signal("timeout",
  function()

    batterywidget.text = getBatteryWidgetText(ACPI_BATTERY_NAMES)

    if not isCharging() and not battery_warning_shown and getTotalBatteryPercent(BATTERY_NAMES) < 15 then
        naughty.notify({ title  = "Low battery warning"
                                , text       = "Less than 15% battery left!"
                                , timeout    = 5
                                , position   = "top_right"
                                , fg         = beautiful.fg_focus
                                , bg         = beautiful.bg_focus
                                })
        battery_warning_shown = true
    end
  end
)

batterywidget = widget({ type = "textbox" })
batterywidget.text = getBatteryWidgetText(ACPI_BATTERY_NAMES)

batterywidgettimer:start()
