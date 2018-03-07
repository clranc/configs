local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")
local colors = require("colorgradient")

remind = {time=30}

remind.fg = wibox.widget.textbox()
remind.fg:set_align("right")
remind.widget = wibox.widget.background()
remind.widget:set_widget(remind.fg)
remind.widget:set_fg("#DD4400")
remind.widget:set_bg("#FFFFFF")

--remind.widget = wibox.widget {
--    {
--        widget = wibox.widget.textbox,
--        align = "right",
--    },
--    fg = "#DD4400",
--    bg = "#FFFFFF",
--    widget = wibox.widget.background,
--}

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
                         timeout = 10,
                         position = "top_left"})
    end
    return todos
end

function remind.update()
    local todos = remind.findtodos()
    -- Running totals
    local output
    local cnt = 0
    for todo in todos do
        output = remind.catfile("~/todo/"..todo)
        naughty.notify({ bg="#FDFF00",
                         fg="#DD4400",
                         text = output,
                         timeout = 10,
                         position = "top_left"})
        cnt = cnt + 1
    end
    remind.fg:set_text(" tasks: "..tostring(cnt).." ")
end

remind.update()
remind.mytimer = timer ({timeout = remind.time})
remind.mytimer:connect_signal("timeout", remind.update)

function remind.doAThing()
    remind.update()
    remind.mytimer:again()
end

remind.fg:buttons(awful.util.table.join(
    awful.button({}, 1, remind.doAThing)
))

remind.mytimer:start()

return remind.widget
