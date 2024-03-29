---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "dejavu sans 8"

theme.bg_normal     = "#111111"
theme.bg_focus      = "#222222"
theme.bg_urgent     = "#ff284c"
theme.bg_minimize   = "#333333"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#29272d"
theme.border_focus  = "#424242"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "~/.config/awesome/themes/default/squarefw.png"
theme.taglist_squares_unsel = "~/.config/awesome/themes/default/squarew.png"

theme.tasklist_floating_icon = "~/.config/awesome/themes/default/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "~/.config/awesome/themes/default/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

theme.tasklist_disable_icon = true

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "~/.config/awesome/themes/default/close_normal.png"
theme.titlebar_close_button_focus  = "~/.config/awesome/themes/default/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "~/.config/awesome/themes/default/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "~/.config/awesome/themes/default/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "~/.config/awesome/themes/default/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "~/.config/awesome/themes/default/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "~/.config/awesome/themes/default/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "~/.config/awesome/themes/default/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "~/.config/awesome/themes/default/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "~/.config/awesome/themes/default/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "~/.config/awesome/themes/default/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "~/.config/awesome/themes/default/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "~/.config/awesome/themes/default/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "~/.config/awesome/themes/default/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "~/.config/awesome/themes/default/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "~/.config/awesome/themes/default/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "~/.config/awesome/themes/default/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "~/.config/awesome/themes/default/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = "~/.config/awesome/themes/default/fairhw.png"
theme.layout_fairv = "~/.config/awesome/themes/default/fairvw.png"
theme.layout_floating  = "~/.config/awesome/themes/default/floatingw.png"
theme.layout_magnifier = "~/.config/awesome/themes/default/magnifierw.png"
theme.layout_max = "~/.config/awesome/themes/default/maxw.png"
theme.layout_fullscreen = "~/.config/awesome/themes/default/fullscreenw.png"
theme.layout_tilebottom = "~/.config/awesome/themes/default/tilebottomw.png"
theme.layout_tileleft   = "~/.config/awesome/themes/default/tileleftw.png"
theme.layout_tile = "~/.config/awesome/themes/default/tilew.png"
theme.layout_tiletop = "~/.config/awesome/themes/default/tiletopw.png"
theme.layout_spiral  = "~/.config/awesome/themes/default/spiralw.png"
theme.layout_dwindle = "~/.config/awesome/themes/default/dwindlew.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
