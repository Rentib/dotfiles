-- Example config for Swayimg.
-- This file contains the default configuration used by the application.

-- The viewer searches for the config file in the following locations:
-- 1. $XDG_CONFIG_HOME/swayimg/init.lua
-- 2. $HOME/.config/swayimg/init.lua
-- 3. $XDG_CONFIG_DIRS/swayimg/init.lua
-- 4. /etc/xdg/swayimg/init.lua

-- General config
swayimg.set_mode("viewer")            -- mode at startup
swayimg.enable_antialiasing(true)     -- anti-aliasing
swayimg.enable_decoration(false)      -- window title/buttons/borders
swayimg.enable_overlay(false)         -- window overlay mode
swayimg.enable_exif_orientation(true) -- image orientation by EXIF
swayimg.set_dnd_button("MouseRight")  -- drag-and-drop mouse button

-- Image list configuration
swayimg.imagelist.set_order("numeric")    -- list order
swayimg.imagelist.enable_reverse(false)   -- reverse order
swayimg.imagelist.enable_recursive(false) -- recursive directory reading
swayimg.imagelist.enable_adjacent(false)  -- add adjacent files from same dir
swayimg.imagelist.enable_fsmon(true)      -- enable file system monitoring

-- Text overlay configuration
swayimg.text.set_font("IosevkaTerm NFM") -- font name
swayimg.text.set_size(24)                -- font size in pixels
swayimg.text.set_spacing(0)              -- line spacing
swayimg.text.set_padding(10)             -- padding from window edge
swayimg.text.set_foreground(0xff000000)  -- foreground text color
swayimg.text.set_background(0x00ffffff)  -- text background color
swayimg.text.set_shadow(0x0d000000)      -- text shadow color
swayimg.text.set_timeout(5)              -- layer hide timeout
swayimg.text.set_status_timeout(3)       -- status message hide timeout

-- Image viewer mode
swayimg.viewer.set_default_scale("optimal")                     -- default image scale
swayimg.viewer.set_default_position("center")                   -- default image position
swayimg.viewer.set_drag_button("MouseLeft")                     -- mouse button to drag image
swayimg.viewer.set_window_background(0xff000000)                -- window background color
swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c) -- chessboard
swayimg.viewer.enable_centering(true)                           -- enable automatic centering
swayimg.viewer.enable_loop(true)                                -- enable image list loop mode
swayimg.viewer.limit_preload(1)                                 -- number of images to preload
swayimg.viewer.limit_history(1)                                 -- number of the history cache
swayimg.viewer.set_mark_color(0xff808080)                       -- mark icon color
swayimg.viewer.set_text("topleft", {                            -- top left text block scheme
    "File: {name}",
    "Format: {format}",
    "File size: {sizehr}",
    "File time: {time}",
    "EXIF date: {meta.Exif.Photo.DateTimeOriginal}",
    "EXIF camera: {meta.Exif.Image.Model}"
})
swayimg.viewer.set_text("topright", { -- top right text block scheme
    "Image: {list.index} of {list.total}",
    "Frame: {frame.index} of {frame.total}",
    "Size: {frame.width}x{frame.height}"
})
swayimg.viewer.set_text("bottomleft", { -- bottom left text block scheme
    "Scale: {scale}"
})

-- Slide show mode, same config as for viewer mode with the following defaults:
swayimg.slideshow.set_timeout(5)                    -- timeout to switch image
swayimg.slideshow.set_default_scale("fit")          -- default image scale
swayimg.slideshow.set_window_background("auto")     -- window background mode
swayimg.slideshow.limit_history(0)                  -- number of the history cache
swayimg.slideshow.set_text("topleft", { "{name}" }) -- top left text block scheme

-- Gallery mode
swayimg.gallery.set_aspect("fill")               -- thumbnail aspect ratio
swayimg.gallery.set_thumb_size(200)              -- thumbnail size in pixels
swayimg.gallery.set_padding_size(5)              -- padding between thumbnails
swayimg.gallery.set_border_size(5)               -- border size for selected thumbnail
swayimg.gallery.set_border_color(0x00000000)     -- border color for selected thumbnail
swayimg.gallery.set_selected_scale(1.15)         -- scale for selected thumbnail
swayimg.gallery.set_selected_color(0x00000000)   -- background color for selected thumbnail
swayimg.gallery.set_unselected_color(0x00000000) -- background color for unselected thumbnail
swayimg.gallery.set_window_color(0xff000000)     -- window background color
swayimg.gallery.limit_cache(100)                 -- number of thumbnails stored in memory
swayimg.gallery.enable_preload(false)            -- preloading invisible thumbnails
swayimg.gallery.enable_pstore(false)             -- enable persistent storage for thumbnails
swayimg.gallery.set_text("topleft", {            -- top left text block scheme
    "File: {name}"
})
swayimg.gallery.set_text("topright", { -- top right text block scheme
    "{list.index} of {list.total}"
})

-- force set scale mode on window resize (useful for tiling compositors)
swayimg.on_window_resize(function()
    swayimg.viewer.set_fix_scale("optimal")
end)

-- set a custom window title in gallery mode
swayimg.gallery.on_image_change(function()
    local image = swayimg.gallery.get_image()
    swayimg.set_title("Gallery: " .. image.path)
end)

-- Keybids:

-- Viewer:
swayimg.viewer.on_key("Escape", swayimg.exit)
swayimg.viewer.on_key("q", swayimg.exit)
swayimg.viewer.on_key("Return", function() swayimg.set_mode("gallery") end)
swayimg.viewer.on_key("f", swayimg.set_fullscreen)
swayimg.viewer.on_key("g", function() swayimg.viewer.switch_image("first") end)
swayimg.viewer.on_key("Shift+g", function() swayimg.viewer.switch_image("last") end)
swayimg.viewer.on_key("p", function() swayimg.viewer.switch_image("prev") end)
swayimg.viewer.on_key("n", function() swayimg.viewer.switch_image("next") end)
swayimg.viewer.on_key("r", swayimg.viewer.reload)
swayimg.viewer.on_key("h", function()
    pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x + 20, pos.y)
end)
swayimg.viewer.on_key("j", function()
    pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x, pos.y - 20)
end)
swayimg.viewer.on_key("k", function()
    pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x, pos.y + 20)
end)
swayimg.viewer.on_key("l", function()
    pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x - 20, pos.y)
end)
swayimg.viewer.on_key("Shift+j", function()
    scale = swayimg.viewer.get_scale()
    swayimg.viewer.set_abs_scale(scale * (1 - 0.05))
end)
swayimg.viewer.on_key("Shift+k", function()
    scale = swayimg.viewer.get_scale()
    swayimg.viewer.set_abs_scale(scale * (1 + 0.05))
end)
swayimg.viewer.on_key("b", function()
    os.execute("setbg " .. swayimg.viewer.get_image().path)
end)
swayimg.viewer.on_key("y", function()
    os.execute(os.getenv("HOME") .. "/.config/swayimg/exec_copy_image " .. swayimg.viewer.get_image().path)
end)
swayimg.viewer.on_key("Shift+Delete", function()
    local img = swayimg.viewer.get_image()
    os.remove(img.path)
    swayimg.viewer.switch_image("next")
end)

-- Gallery:
swayimg.gallery.on_key("Escape", swayimg.exit)
swayimg.gallery.on_key("q", swayimg.exit)
swayimg.gallery.on_key("Return", function() swayimg.set_mode("viewer") end)
swayimg.gallery.on_key("f", swayimg.toggle_fullscreen)
swayimg.gallery.on_key("g", function() swayimg.gallery.switch_image("first") end)
swayimg.gallery.on_key("Shift+g", function() swayimg.gallery.switch_image("last") end)
swayimg.gallery.on_key("h", function() swayimg.gallery.switch_image("left") end)
swayimg.gallery.on_key("j", function() swayimg.gallery.switch_image("down") end)
swayimg.gallery.on_key("k", function() swayimg.gallery.switch_image("up") end)
swayimg.gallery.on_key("l", function() swayimg.gallery.switch_image("right") end)
swayimg.gallery.on_key("b", function()
    os.execute("setbg " .. swayimg.gallery.get_image().path)
end)
swayimg.gallery.on_key("y", function()
    os.execute(os.getenv("HOME") .. "/.config/swayimg/exec_copy_image " .. swayimg.gallery.get_image().path)
end)
swayimg.gallery.on_key("Shift+Delete", function()
    local img = swayimg.gallery.get_image()
    os.remove(img.path)
    swayimg.gallery.switch_image("next")
end)
