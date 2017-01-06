---------------------------------------------------------------------------
-- @author Julien Danjou &lt;julien@danjou.info&gt;, Steve Pomeroy, Paul
-- Tagliamonte
-- @copyright 2009 Julien Danjou, 2015 Steve Pomeroy, Paul Tagliamonte
-- @release v3.5.6
---------------------------------------------------------------------------

local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local capi = { timer = timer }
local awful = require("awful")

--- Text clock widget.
-- hearts.hearts
local hearts = { mt = {} }

--- Create a battery health meter. It shows the current battery level with
--  hearts.
-- @param timeout How often update the time. Default is 60.
-- @return A textbox widget.
function hearts.new(timeout)
    local timeout = timeout or 60

    local w = textbox()
    local timer = capi.timer { timeout = timeout }
    timer:connect_signal("timeout", function() w:set_markup(awful.util.pread("/home/steve/bin/bheart --html")) end)
    timer:start()
    timer:emit_signal("timeout")
    return w
end

function hearts.mt:__call(...)
    return hearts.new(...)
end

return setmetatable(hearts, hearts.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
