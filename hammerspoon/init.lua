------------------------------------------------------
-- Define my Hyper key modifier
------------------------------------------------------
--
local hyper = {"cmd", "alt"}
local hyperShift = {"shift", "cmd", "alt"}

------------------------------------------------------
-- Auto reload config file on change
------------------------------------------------------
--
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

------------------------------------------------------
-- Window Placement
------------------------------------------------------
------------------------------------------------------
-- Full screen
------------------------------------------------------
hs.hotkey.bind(hyper, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

------------------------------------------------------
-- Left half of screen
------------------------------------------------------
hs.hotkey.bind(hyper, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

------------------------------------------------------
-- Right half of screen
------------------------------------------------------
hs.hotkey.bind(hyper, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

------------------------------------------------------
-- Thirds
------------------------------------------------------
------------------------------------------------------
-- Left Hand Side
------------------------------------------------------
hs.hotkey.bind(hyper, "1", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 3
  f.h = max.h
  win:setFrame(f)
end)
--
------------------------------------------------------
-- Centre
------------------------------------------------------
hs.hotkey.bind(hyper, "2", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 3)
  f.y = max.y
  f.w = max.w / 3
  f.h = max.h
  win:setFrame(f)
end)
--
------------------------------------------------------
-- Right Hand Side
------------------------------------------------------
hs.hotkey.bind(hyper, "3", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (2 * max.w)/ 3
  f.y = max.y
  f.w = max.w / 3
  f.h = max.h
  win:setFrame(f)
end)

------------------------------------------------------
-- Change Window Focus
------------------------------------------------------
------------------------------------------------------
-- Hyper Down to show window hints
------------------------------------------------------
--
hs.hotkey.bind(hyper, 'Down', function()
    hs.hints.style = "vimperator"
    hs.hints.windowHints()
end)

------------------------------------------------------
-- hjkl to move window focus
------------------------------------------------------
--
hs.hotkey.bind(hyper, 'k', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowNorth()
    else
        hs.alert.show("No active window")
    end
end)
hs.hotkey.bind(hyper, 'j', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowSouth()
    else
        hs.alert.show("No active window")
    end
end)
hs.hotkey.bind(hyper, 'l', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowEast()
    else
        hs.alert.show("No active window")
    end
end)
hs.hotkey.bind(hyper, 'h', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowWest()
    else
        hs.alert.show("No active window")
    end
end)

------------------------------------------------------
-- Pandoc create html on save
------------------------------------------------------
--
function to_html(files)
    for _,file in pairs(files) do
        if file:sub(-3) == ".md" then
            local command = "pandoc -s -t html -o '" .. file:sub(1,-4) .. ".html' '" .. file .. "'"
            os.execute("echo " .. command .. " > ~/debug.txt")
            os.execute(command)
        end
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/Documents/notes", to_html):start()

