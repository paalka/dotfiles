volume_widget = widget({ type = "textbox", name = "tb_volume",
                         align = "right" })

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
            volume = " <span color='red'>🔇" .. volume .. "%</span>"
        end
        widget.text = volume
    else
        widget.text = "Device not found"
    end
 end

update_volume(volume_widget)
awful.hooks.timer.register(1, function () update_volume(volume_widget) end)