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
--
------------------------------------------------------
-- Grid Placement
------------------------------------------------------
--
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 6
hs.grid.GRIDHEIGHT = 2

------------------------------------------------------
-- Define common placements
------------------------------------------------------
Left50 = {x=0,y=0,w=3,h=2}
Right50 = {x=3,y=0,w=3,h=2}
Left33 = {x=0,y=0,w=2,h=2}
Mid33 = {x=2,y=0,w=2,h=2}
Right33 = {x=4,y=0,w=2,h=2}

------------------------------------------------------
-- Jump to standard placement
------------------------------------------------------
------------------------------------------------------
-- Maximize
------------------------------------------------------
hs.hotkey.bind(hyper, "Up", hs.grid.maximizeWindow)
------------------------------------------------------
-- Half Left
------------------------------------------------------
hs.hotkey.bind(hyper, "Left", function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    hs.grid.set(win, Left50, screen)
end)
------------------------------------------------------
-- Half Right
------------------------------------------------------
hs.hotkey.bind(hyper, "Right", function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    hs.grid.set(win, Right50, screen)
end)
------------------------------------------------------
-- Third Left
------------------------------------------------------
hs.hotkey.bind(hyper, "1", function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    hs.grid.set(win, Left33, screen)
end)
------------------------------------------------------
-- Third Middle
------------------------------------------------------
hs.hotkey.bind(hyper, "2", function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    hs.grid.set(win, Mid33, screen)
end)
------------------------------------------------------
-- Third Right
------------------------------------------------------
hs.hotkey.bind(hyper, "3", function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    hs.grid.set(win, Right33, screen)
end)
--
------------------------------------------------------
-- Multi monitor
------------------------------------------------------
hs.hotkey.bind(hyper, ",", hs.grid.pushWindowNextScreen )
hs.hotkey.bind(hyper, ".", hs.grid.pushWindowPrevScreen )

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

