-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local scratch = require('scratch')
local quake = require('quake')

local local_config = require("local")

if SHOW_BATTERY then
   local battery = require('battery')
end

if SHOW_VOLUME then
   local volume = require('volume')
end

if SHOW_LOAD then
   local cpu_load = require('load')
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
		    title = "Oops, there were errors during startup!",
		    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
   local in_error = false
   awesome.connect_signal("debug::error", function (err)
			     -- Make sure we don't go into an endless error loop
			     if in_error then return end
			     in_error = true

			     naughty.notify({ preset = naughty.config.presets.critical,
					      title = "Oops, an error happened!",
					      text = tostring(err) })
			     in_error = false
   end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")


-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
   awful.layout.suit.floating,
   awful.layout.suit.tile.left,
   awful.layout.suit.fair,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
   local instance = nil

   return function ()
      if instance and instance.wibox.visible then
	 instance:hide()
	 instance = nil
      else
	 instance = awful.menu.clients({ theme = { width = 250 } })
      end
   end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
			     { "open terminal", terminal }
}
		       })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
				     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
   awful.button({ }, 1, function(t) t:view_only() end),
   awful.button({ modkey }, 1, function(t)
	 if client.focus then
	    client.focus:move_to_tag(t)
	 end
   end),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, function(t)
	 if client.focus then
	    client.focus:toggle_tag(t)
	 end
   end),
   awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
   awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = awful.util.table.join(
   awful.button({ }, 1, function (c)
	 if c == client.focus then
	    c.minimized = true
	 else
	    -- Without this, the following
	    -- :isvisible() makes no sense
	    c.minimized = false
	    if not c:isvisible() and c.first_tag then
	       c.first_tag:view_only()
	    end
	    -- This will also un-minimize
	    -- the client, if needed
	    client.focus = c
	    c:raise()
	 end
   end),
   awful.button({ }, 3, client_menu_toggle_fn()),
   awful.button({ }, 4, function ()
	 awful.client.focus.byidx(1)
   end),
   awful.button({ }, 5, function ()
	 awful.client.focus.byidx(-1)
end))

local function set_wallpaper(s)
   -- Wallpaper
   if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
	 wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, true)
   end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
      -- Wallpaper
      set_wallpaper(s)

      s.quake = quake({ app = "alacritty", argname = "--title %s",extra = "--class QuakeDD", visible = true, height = 0.7, width = 0.5, vert = "center", horiz = "center", screen = s })

      -- Each screen has its own tag table.
      awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8"}, s, awful.layout.layouts[1])

      -- Create a promptbox for each screen
      s.mypromptbox = awful.widget.prompt()
      -- Create an imagebox widget which will contains an icon indicating which layout we're using.
      -- We need one layoutbox per screen.
      s.mylayoutbox = awful.widget.layoutbox(s)
      s.mylayoutbox:buttons(awful.util.table.join(
			       awful.button({ }, 1, function () awful.layout.inc( 1) end),
			       awful.button({ }, 3, function () awful.layout.inc(-1) end),
			       awful.button({ }, 4, function () awful.layout.inc( 1) end),
			       awful.button({ }, 5, function () awful.layout.inc(-1) end)))
      -- Create a taglist widget
      s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

      -- Create a tasklist widget
      s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

      -- Create the wibox
      s.mywibox = awful.wibar({ position = "top", screen = s })

      -- Add widgets to the wibox
      s.mywibox:setup {
	 layout = wibox.layout.align.horizontal,
	 { -- Left widgets
	    layout = wibox.layout.fixed.horizontal,
	    mylauncher,
	    s.mytaglist,
	    s.mypromptbox,
	 },
	 s.mytasklist, -- Middle widget
	 { -- Right widgets
	    cpu_load_widget,
	    volume_widget,
	    battery_widget,
	    layout = wibox.layout.fixed.horizontal,
	    mytextclock,
	    wibox.widget.systray(),
	    s.mylayoutbox,
	 },
      }
      awful.tag.add("scratch", {
		      layout             = awful.layout.suit.fair,
		      screen             = s,
		      selected           = true,
      })

end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
		awful.button({ }, 3, function () mymainmenu:toggle() end)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
   awful.key({ modkey,           }, "h",      hotkeys_popup.show_help,
      {description="show help", group="awesome"}),
   awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
      {description = "go back", group = "tag"}),

   awful.key({ modkey,           }, "j",
      function ()
	 awful.client.focus.byidx( 1)
      end,
      {description = "focus next by index", group = "client"}
   ),
   awful.key({ modkey,           }, "k",
      function ()
	 awful.client.focus.byidx(-1)
      end,
      {description = "focus previous by index", group = "client"}
   ),

   awful.key({ modkey, }, "s", function () awful.screen.focused().quake:toggle() end, {description = "dropdown application", group = "launcher"}),

   -- Layout manipulation
   awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
      {description = "swap with next client by index", group = "client"}),
   awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
      {description = "swap with previous client by index", group = "client"}),
   awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen", group = "screen"}),
   awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
      {description = "focus the previous screen", group = "screen"}),
   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
      {description = "jump to urgent client", group = "client"}),
   awful.key({ modkey,           }, "Tab",
      function ()
	 awful.client.focus.history.previous()
	 if client.focus then
	    client.focus:raise()
	 end
      end,
      {description = "go back", group = "client"}),

   -- Standard program
   awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
      {description = "open a terminal", group = "launcher"}),
   awful.key({ modkey, "Control" }, "r", awesome.restart,
      {description = "reload awesome", group = "awesome"}),
   awful.key({ modkey, "Shift"   }, "e", awesome.quit,
      {description = "quit awesome", group = "awesome"}),

   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
      {description = "increase master width factor", group = "layout"}),
   awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
      {description = "decrease master width factor", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
      {description = "increase the number of master clients", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
      {description = "decrease the number of master clients", group = "layout"}),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
      {description = "increase the number of columns", group = "layout"}),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
      {description = "decrease the number of columns", group = "layout"}),
   awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
      {description = "select next", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
      {description = "select previous", group = "layout"}),

   awful.key({ modkey, "Control" }, "n",
      function ()
	 local c = awful.client.restore()
	 -- Focus restored client
	 if c then
	    client.focus = c
	    c:raise()
	 end
      end,
      {description = "restore minimized", group = "client"}),

   --awful.key({ modkey,           }, "s",      function() scratch.toggle("alacritty --class scratch-term", {instance = "scratch-term"}) end),
   -- Handle volume
   awful.key({ }, "XF86AudioRaiseVolume", function ()
	 awful.spawn("pulsemixer --unmute --change-volume +3") end),
   awful.key({ }, "XF86AudioLowerVolume", function ()
	 awful.spawn("pulsemixer --unmute --change-volume -3") end),
   awful.key({ }, "XF86AudioMute", function ()
	 awful.spawn("pulsemixer --toggle-mute") end),

   -- Play/Pause the music when pressing Control + Space
   awful.key({ "Control" }, "space", function ()
	 awful.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause") end),

   -- Handle screen brightness
   awful.key({ }, "XF86MonBrightnessUp", function ()
	 awful.spawn("xbacklight -inc 10") end),
   awful.key({ }, "XF86MonBrightnessDown", function ()
	 awful.spawn("xbacklight -dec 10") end),

   -- Lock the screen
   awful.key({ modkey,           }, "y", function () awful.spawn.with_shell("~/.bin/lock") end)
)
if USE_ROFI then
   rofikeys = awful.util.table.join(
      awful.key({ modkey,           }, "w", function () awful.spawn.with_shell("rofi -show window") end),

      awful.key({ modkey },            "r",     function () awful.spawn.with_shell("rofi -show run") end,
	 {description = "run prompt", group = "launcher"})
   )
   globalkeys = awful.util.table.crush(globalkeys, rofikeys)
else
   launcher_keys = awful.util.table.join(
      awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
	 {description = "run prompt", group = "launcher"})
   )
   globalkeys = awful.util.table.merge(globalkeys, launcher_keys)
end

if USE_EMACS then
   emacskeys = awful.util.table.join(
      awful.key({ modkey },            "e",     function () awful.spawn("emacsclient -cq") end,
	 {description = "emacsclient", group = "emacs"})
   )
   globalkeys = awful.util.table.crush(globalkeys, emacskeys)
end

clientkeys = awful.util.table.join(
   awful.key({ modkey,           }, "f",
      function (c)
	 c.fullscreen = not c.fullscreen
	 c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}),
   awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
      {description = "close", group = "client"}),
   awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
      {description = "toggle floating", group = "client"}),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}),
   awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
      {description = "move to screen", group = "client"}),
   awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
      {description = "toggle keep on top", group = "client"}),
   awful.key({ modkey,           }, "n",
      function (c)
	 -- The client currently has the input focus, so it cannot be
	 -- minimized, since minimized clients can't have the focus.
	 c.minimized = true
      end ,
      {description = "minimize", group = "client"}),
   awful.key({ modkey,           }, "m",
      function (c)
	 c.maximized = not c.maximized
	 c:raise()
      end ,
      {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
   globalkeys = awful.util.table.join(globalkeys,
				      -- View tag only.
				      awful.key({ modkey }, "#" .. i + 9,
					 function ()
					    local screen = awful.screen.focused()
					    local tag = screen.tags[i]
					    if tag then
					       tag:view_only()
					    end
					 end,
					 {description = "view tag #"..i, group = "tag"}),
				      -- Toggle tag display.
				      awful.key({ modkey, "Control" }, "#" .. i + 9,
					 function ()
					    local screen = awful.screen.focused()
					    local tag = screen.tags[i]
					    if tag then
					       awful.tag.viewtoggle(tag)
					    end
					 end,
					 {description = "toggle tag #" .. i, group = "tag"}),
				      -- Move client to tag.
				      awful.key({ modkey, "Shift" }, "#" .. i + 9,
					 function ()
					    if client.focus then
					       local tag = client.focus.screen.tags[i]
					       if tag then
						  client.focus:move_to_tag(tag)
					       end
					    end
					 end,
					 {description = "move focused client to tag #"..i, group = "tag"}),
				      -- Toggle tag on focused client.
				      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
					 function ()
					    if client.focus then
					       local tag = client.focus.screen.tags[i]
					       if tag then
						  client.focus:toggle_tag(tag)
					       end
					    end
					 end,
					 {description = "toggle focused client on tag #" .. i, group = "tag"})
   )
end

clientbuttons = awful.util.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
   awful.button({ modkey }, 1, awful.mouse.client.move),
   awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
		    border_color = beautiful.border_normal,
		    focus = awful.client.focus.filter,
		    raise = true,
		    keys = clientkeys,
		    buttons = clientbuttons,
		    screen = awful.screen.preferred,
		    placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
   },
   { rule = { instance = "spotify" },
     properties = { tag = "8" }
   },
   { rule = { role = "browser" },
     properties = { tag = "4", switchtotag = true }
   },
   { rule = { instance = "slack" },
     properties = { tag = "7" }
   },
   { rule = { class = "Code" },
     properties = { tag = "1", switchtotag = true }
   },
   { rule_any = {
	instance = {
	   "scratch"
	},
   },
     properties = {
	floating = true,
	placement = awful.placement.centered
     }
   },

   -- Floating clients.
   { rule_any = {
	instance = {
	   "DTA",  -- Firefox addon DownThemAll.
	   "copyq",  -- Includes session name in class.
	},
	class = {
	   "Arandr",
	   "Gpick",
	   "Kruler",
	   "MessageWin",  -- kalarm.
	   "Sxiv",
	   "Wpa_gui",
	   "pinentry",
	   "veromix",
	   "xtightvncviewer"},

	name = {
	   "Event Tester",  -- xev.
	},
	role = {
	   "AlarmWindow",  -- Thunderbird's calendar.
	   "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
	}
   }, properties = { floating = true }},

   -- Add titlebars to normal clients and dialogs
   { rule_any = {type = { "normal", "dialog" }
		}, properties = { titlebars_enabled = false }
   },

   -- Set Firefox to always map on the tag named "2" on screen 1.
   -- { rule = { class = "Firefox" },
   --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
			 -- Set the windows at the slave,
			 -- i.e. put it at the end of others instead of setting it master.
			 -- if not awesome.startup then awful.client.setslave(c) end

			 if awesome.startup and
			    not c.size_hints.user_position
			 and not c.size_hints.program_position then
			    -- Prevent clients from being unreachable after screen count changes.
			    awful.placement.no_offscreen(c)
			 end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
			 if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
			 and awful.client.focus.filter(c) then
			    client.focus = c
			 end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
--
--

tag.connect_signal("request::screen", function(t)
    for s in screen do
        if s ~= t.screen and
           s.geometry.x == t.screen.geometry.x and
           s.geometry.y == t.screen.geometry.y and
           s.geometry.width == t.screen.geometry.width and
           s.geometry.height == t.screen.geometry.height then
            local t2 = awful.tag.find_by_name(s, t.name)
            if t2 then
                t:swap(t2)
            else
                t.screen = s
            end
            return
        end
    end
end)
