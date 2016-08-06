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

load_widget_timer = timer({ timeout = 1 })
load_widget_timer:add_signal("timeout",
  function()
    load_widget.text = getAverageLoadText()
  end
)

load_widget = widget({ type = "textbox" })
load_widget.text = getAverageLoadText()
load_widget_timer:start()
