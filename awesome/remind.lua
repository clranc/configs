local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")
local colors = require("colorgradient")

remind = {time=30}

remind.widget = wibox.widget {
    {
        widget = wibox.widget.textbox,
        align = "right",
    },
    fg = "#DD4400",
    bg = "#FFFFFF",
    widget = wibox.widget.background,
}

function remind.catfile(name, fmt)
    local fh = io.popen("cat "..name,'r')
    local stdout = fh:read('*all')
    fh:close()
    return stdout
end

function remind.findtodos ()
    local file = io.popen("ls ~/todo",'r')
    local stdout = file:read('*all')
    file:close()
    local todos = stdout:gmatch("[^\r\n]+")
    if stdout == '' then
        naughty.notify({ preset = naughty.config.presets.critical,
                         text = 'Yo!! Why arent you doing stuff bra!?',
                         timeout = 10})
    end
    return todos
end

-- Todo: Split it out into multiple batteries


function remind.update()
    local todos = remind.findtodos()
    -- Running totals
    local output
    local cnt = 0
    -- Add each battery's values to the running total
    for todo in todos do
        output = remind.catfile("~/todo/"..todo)
        naughty.notify({ bg="#FFFFFF",
                         fg="#DD4400",
                         text = output,
                         timeout = 10})
        cnt = cnt + 1
    end
    remind.widget.widget.text = " tasks: "..tostring(cnt).." "
end

remind.update()

remind.mytimer = timer {
    timeout = remind.time,
    callback = remind.update,
}

remind.widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        remind.update()
        remind.mytimer:again()
    end)
))

remind.mytimer:start()

return remind.widget
