POWER_SUPPLY_PATH = "/sys/class/power_supply/"
BATTERY_NAMES = {"BAT0", "BAT1"}
ACPI_BATTERY_NAMES = {"Battery 0", "Battery 1"}
LOW_BATTERY_THRESHOLD = 15

should_show_battery_warning = true

function getBatteryWidgetText(acpi_battery_names)
    if isCharging() then
        widget_text = " ⚡"
    else
        widget_text = "  "
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

    if battery_status == '' then
        battery_status = acpi_battery_name .. " missing"
    end

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
    local adapter_current_capacity
    if adapter_current_capacity_file ~= nil then
        adapter_current_capacity = adapter_current_capacity_file:read()
    else
        adapter_current_capacity = 0
    end

    return adapter_current_capacity
end

batterywidgettimer = timer({ timeout = 5 })
batterywidgettimer:add_signal("timeout",
  function()

    batterywidget.text = getBatteryWidgetText(ACPI_BATTERY_NAMES)
    total_battery_percent = getTotalBatteryPercent(BATTERY_NAMES)

    if not isCharging() and should_show_battery_warning and total_battery_percent < LOW_BATTERY_THRESHOLD then
        naughty.notify({ title  = "Low battery warning"
                                , text       = "Less than " .. LOW_BATTERY_THRESHOLD .. "% battery left!"
                                , timeout    = 300
                                , position   = "top_right"
                                , fg         = beautiful.fg_focus
                                , bg         = beautiful.bg_urgent
                                })
        should_show_battery_warning = false
    elseif total_battery_percent > 75 and not should_show_battery_warning then
        should_show_battery_warning = true
    end
  end
)

batterywidget = widget({ type = "textbox" })
batterywidget.text = getBatteryWidgetText(ACPI_BATTERY_NAMES)

batterywidgettimer:start()
