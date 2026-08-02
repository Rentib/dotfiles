-- Example config for Swayimg.
-- This file contains the default configuration used by the application.

-- The viewer searches for the config file in the following locations:
-- 1. $XDG_CONFIG_HOME/swayimg/init.lua
-- 2. $HOME/.config/swayimg/init.lua
-- 3. $XDG_CONFIG_DIRS/swayimg/init.lua
-- 4. /etc/xdg/swayimg/init.lua

-- General config
swayimg.mode = "viewer"           -- mode at startup
swayimg.antialiasing = true       -- anti-aliasing
swayimg.decoration = false        -- window title/buttons/borders
swayimg.overlay = false           -- window overlay mode
swayimg.exif_orientation = true   -- image orientation by EXIF
swayimg.dnd_button = "MouseRight" -- drag-and-drop mouse button

swayimg.set_format_params('raw', { camera_wb = true }) -- use camera white balance

-- Image list configuration
swayimg.imagelist.order = "numeric" -- list order
swayimg.imagelist.reverse = false   -- reverse order
swayimg.imagelist.recursive = false -- recursive directory reading
swayimg.imagelist.adjacent = false  -- add adjacent files from same dir
swayimg.imagelist.fsmon = true      -- enable file system monitoring

-- Text overlay configuration
swayimg.text.visible = true              -- overlay visible state
swayimg.text.font = "IosevkaTerm NFM" -- font name
swayimg.text.size = 24                -- font size in pixels
swayimg.text.spacing = 0              -- line spacing
swayimg.text.padding = 10             -- padding from window edge
swayimg.text.color = 0xff000000       -- text color
swayimg.text.background = 0x00ffffff  -- background color
swayimg.text.shadow = 0x0d000000      -- shadow color
swayimg.text.timeout = 5              -- layer hide timeout
swayimg.text.status_timeout = 3       -- status message hide timeout

-- Image viewer mode
swayimg.viewer.default_scale = "optimal"                        -- default image scale
swayimg.viewer.default_position = "center"                      -- default image position
swayimg.viewer.drag_button = "MouseLeft"                        -- mouse button to drag image
swayimg.viewer.autocenter = true                                -- enable automatic centering
swayimg.viewer.loop = true                                      -- enable image list loop mode
swayimg.viewer.preload = 1                                      -- number of images to preload
swayimg.viewer.history = 1                                      -- number of the history cache
swayimg.viewer.mark_color = 0xff808080                          -- mark icon color
swayimg.viewer.pinch_factor = 1.0                               -- pinch gesture factor
swayimg.viewer.set_window_background(0xff000000)                -- window background color
swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c) -- chessboard
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
swayimg.slideshow.timeout = 5                       -- timeout to switch image
swayimg.slideshow.default_scale = "fit"             -- default image scale
swayimg.slideshow.history = 0                       -- number of the history cache
swayimg.slideshow.set_window_background("auto")     -- window background mode
swayimg.slideshow.set_text("topleft", { "{name}" }) -- top left text block scheme

-- Gallery mode
swayimg.gallery.thumb_size = 200              -- thumbnail size in pixels
swayimg.gallery.aspect = "fill"               -- thumbnail aspect ratio
swayimg.gallery.padding_size = 5              -- padding between thumbnails
swayimg.gallery.border_size = 5               -- border size for selected thumbnail
swayimg.gallery.border_color = 0x00000000     -- border color for selected thumbnail
swayimg.gallery.selected_scale = 1.15         -- scale for selected thumbnail
swayimg.gallery.selected_color = 0x00000000   -- background color for selected thumbnail
swayimg.gallery.unselected_color = 0x00000000 -- background color for unselected thumbnail
swayimg.gallery.window_color = 0xff000000     -- window background color
swayimg.gallery.pinch_factor = 100.0          -- pinch gesture factor
swayimg.gallery.hover = true                  -- enable mouse following
swayimg.gallery.cache = 100                   -- number of thumbnails stored in memory
swayimg.gallery.preload = false               -- preloading invisible thumbnails
swayimg.gallery.embedded_thumb = true         -- use embedded thumbnails
swayimg.gallery.pstore = false                -- enable persistent storage for thumbnails
swayimg.gallery.set_text("topleft", {         -- top left text block scheme
    "File: {name}"
})
swayimg.gallery.set_text("topright", {        -- top right text block scheme
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
swayimg.viewer.on_key("Return", function() swayimg.mode = "gallery" end)
swayimg.viewer.on_key("f", function() swayimg.fullscreen = not swayimg.fullscreen end)
swayimg.viewer.on_key("g", function() swayimg.viewer.open("first") end)
swayimg.viewer.on_key("Shift+g", function() swayimg.viewer.open("last") end)
swayimg.viewer.on_key("p", function() swayimg.viewer.open("prev") end)
swayimg.viewer.on_key("n", function() swayimg.viewer.open("next") end)
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
    swayimg.viewer.open("next")
end)

-- Gallery:
swayimg.gallery.on_key("Escape", swayimg.exit)
swayimg.gallery.on_key("q", swayimg.exit)
swayimg.gallery.on_key("Return", function() swayimg.set_mode("viewer") end)
swayimg.gallery.on_key("f", function() swayimg.fullscreen = not swayimg.fullscreen end)
swayimg.gallery.on_key("g", function() swayimg.gallery.select("first") end)
swayimg.gallery.on_key("Shift+g", function() swayimg.gallery.select("last") end)
swayimg.gallery.on_key("h", function() swayimg.gallery.select("left") end)
swayimg.gallery.on_key("j", function() swayimg.gallery.select("down") end)
swayimg.gallery.on_key("k", function() swayimg.gallery.select("up") end)
swayimg.gallery.on_key("l", function() swayimg.gallery.select("right") end)
swayimg.gallery.on_key("b", function()
    os.execute("setbg " .. swayimg.gallery.get_image().path)
end)
swayimg.gallery.on_key("y", function()
    os.execute(os.getenv("HOME") .. "/.config/swayimg/exec_copy_image " .. swayimg.gallery.get_image().path)
end)
swayimg.gallery.on_key("Shift+Delete", function()
    local img = swayimg.gallery.get_image()
    os.remove(img.path)
    swayimg.gallery.select("next")
end)
