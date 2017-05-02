local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local watch = require("awful.widget.watch")

POWER_SUPPLY_PATH = "/sys/class/power_supply/"
BATTERY_NAMES = {"BAT0", "BAT1"}
ACPI_BATTERY_NAMES = {"Battery 0", "Battery 1"}
LOW_BATTERY_THRESHOLD = 15

-- Creates the text to be shown on the widget.
function getBatteryWidgetText(acpi_battery_names)
    if isCharging() then
        widget_text = " ⚡"
    else
        widget_text = "  "
    end

    for i, acpi_battery_name in ipairs(acpi_battery_names) do
        acpi_battery_status = getACPIBatteryStatus(acpi_battery_name)
        widget_text = string.format("%s | %s | ", widget_text, acpi_battery_status)
    end
    return widget_text
end

-- Returns a string indicating the status of the battery (eg. whether it is
-- charging, discharging, etc.)
function getACPIBatteryStatus(acpi_battery_name)
    local battery_status_cmd = assert(io.popen("acpi | grep '" .. acpi_battery_name .. ":' | cut -d, -f 2 | xargs", "r"))
    local battery_status = battery_status_cmd:read("*l")

    if battery_status == '' then
        battery_status = acpi_battery_name .. " missing"
    end

    return battery_status
end

function getACPIBatteryText(acpi_battery_name)
    local battery_status_cmd = assert(io.popen("acpi | grep '" .. acpi_battery_name .. ":' | cut -d, -f 3 | xargs", "r"))
    local battery_status = battery_status_cmd:read("*l") 
    return battery_status
end

-- Get the sum of the remaining battery across all batteries.
function getTotalBatteryPercent(battery_names)
    local total_percent = 0
    for i, battery_name in ipairs(battery_names) do
        total_percent = total_percent + getBatteryPercent(battery_name)
    end
    return total_percent
end

-- Determine any of the batteries are being charged.
function isCharging()
    local charging_status_file = io.open(POWER_SUPPLY_PATH .. "AC/online")
    local charging_status = charging_status_file:read()
    return charging_status == "1"
end

-- Get the percentage of battery left.
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

should_show_battery_warning = true
notification = nil

battery_sub_widget = wibox.widget.textbox()
battery_sub_widget.text = getBatteryWidgetText(ACPI_BATTERY_NAMES)

local loacal battery_widget_timer = gears.timer({ timeout = 15 })

battery_widget_timer:connect_signal("timeout",
  function()
    battery_sub_widget.text = getBatteryWidgetText(ACPI_BATTERY_NAMES)
    local total_battery_percent = getTotalBatteryPercent(BATTERY_NAMES)

    if not isCharging() and should_show_battery_warning and total_battery_percent < LOW_BATTERY_THRESHOLD then
        notification = naughty.notify({ 
                                text       = "Less than " .. LOW_BATTERY_THRESHOLD .. "% battery left!"
                                , timeout    = 300 , position   = "top_right" , fg         = beautiful.fg_focus
                                , bg         = beautiful.bg_urgent
                                })
        should_show_battery_warning = false
    -- If the battery warning has not recently been shown, allow it to be
    -- displayed again the next time the total battery percentage goes below
    -- the threshold.
    elseif total_battery_percent > 75 and not should_show_battery_warning then
        should_show_battery_warning = true
    end

    if isCharging() and notification then
        naughty.destroy(notification)
        notification = nil
    end
  end
)

battery_sub_widget:connect_signal("mouse::enter", function()
  local widget_text = ""
  for i, acpi_battery_name in ipairs(ACPI_BATTERY_NAMES) do
      acpi_battery_status = getACPIBatteryText(acpi_battery_name)
      widget_text = string.format("%s\n%s ", widget_text, acpi_battery_status)
  end
  notification_options = {
      text = widget_text,
      timeout = 0, hover_timeout = 0.5 }
  battery_sub_widget.hover = naughty.notify(notification_options)
end)
battery_sub_widget:connect_signal("mouse::leave", function()
  naughty.destroy(battery_sub_widget.hover)
end)

battery_widget_timer:start()

battery_widget = wibox.widget {
    {
      battery_sub_widget,
      fg     = '#6e6e6e',
      forced_width = 115,
      widget = wibox.container.background
    },
    layout = wibox.container.margin(battery_ting, 5, 5, 5, 5)
}
