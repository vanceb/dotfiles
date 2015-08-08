------------------------------------------------------
-- Vance's Hammerspoon config
--
-- For some good ideas see:
-- https://github.com/cmsj/hammerspoon-config/blob/master/init.lua
--
------------------------------------------------------
--
------------------------------------------------------
-- Define my Hyper key modifiers
------------------------------------------------------
--
local hyper = {"cmd", "alt"}
local hyperShift = {"shift", "cmd", "alt"}
local hyperCtrl = {"ctrl", "cmd", "alt"}
local cmdCtrl = {"cmd", "ctrl"}

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
-- WiFi watcher
------------------------------------------------------
local homeSSID = "deepspace" -- My home WiFi SSID
local lastSSID = hs.wifi.currentNetwork()

-- Define functions used in the callback
-- Perform tasks to configure the system for my home WiFi network
function home_arrived()
    hs.audiodevice.defaultOutputDevice():setVolume(25)

    -- Note: sudo commands will need to have been pre-configured in /etc/sudoers, for passwordless access, e.g.:
    -- vance ALL=(root) NOPASSWD: /usr/libexec/ApplicationFirewall/socketfilterfw --setblockall *
    os.execute("sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setblockall off")

    hs.applescript('tell application "Tunnelblick" to disconnect all')
    hs.notify.new({
          title='Hammerspoon',
            informativeText='Welcome home!'
        }):send():release()
end

-- Perform tasks to configure the system for any WiFi network other than my home
function home_departed()
    local status
    local result
    hs.audiodevice.defaultOutputDevice():setVolume(0)
    os.execute("sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setblockall on")
    local msg = 'Shields Up'
    if hs.wifi.currentNetwork() ~= nil then
        msg = msg .. ' (' .. hs.wifi.currentNetwork() .. ')'
    end
    result, status = hs.applescript('tell application "Tunnelblick" to get state of first configuration where name = "London"')
    if status == 'EXITING' then
        result, status = hs.applescript('tell application "Tunnelblick" to connect "London"')
    end
    hs.notify.new({
          title='Hammerspoon',
            informativeText = msg
        }):send():release()
end


-- Do initial setup in case nothing has been set up to this point
if lastSSID == homeSSID then
    home_arrived()
else
    home_departed()
end

-- Callback function for WiFi SSID change events
function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    if lastSSID ~= newSSID then
        if newSSID == homeSSID and lastSSID ~= homeSSID then
            -- We have gone from something that isn't my home WiFi, to something that is
            home_arrived()
        elseif newSSID ~= homeSSID and lastSSID == homeSSID then
            -- We have gone from something that is my home WiFi, to something that isn't
            home_departed()
        end
    end
    lastSSID = newSSID
end

-- Start the wifi watcher
local wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

------------------------------------------------------
-- Window Placement
------------------------------------------------------
-- disable animation
hs.window.animationDuration = 0
------------------------------------------------------
-- Grid Placement
------------------------------------------------------
--
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 6
hs.grid.GRIDHEIGHT = 2

------------------------------------------------------
-- Define my standard placements
------------------------------------------------------
Left50 = {x=0,y=0,w=3,h=2}
Right50 = {x=3,y=0,w=3,h=2}
Left33 = {x=0,y=0,w=2,h=2}
Mid33 = {x=2,y=0,w=2,h=2}
Right33 = {x=4,y=0,w=2,h=2}
Top50 = {x=0,y=0,w=6,h=1}
Bottom50 = {x=0,y=1,w=6,h=1}

------------------------------------------------------
-- Manually tweak size and position
------------------------------------------------------
--
------------------------------------------------------
-- Size
------------------------------------------------------
hs.hotkey.bind(hyperCtrl, "Down", hs.grid.resizeWindowTaller)
hs.hotkey.bind(hyperCtrl, "Up", hs.grid.resizeWindowShorter)
hs.hotkey.bind(hyperCtrl, "Left", hs.grid.resizeWindowThinner)
hs.hotkey.bind(hyperCtrl, "Right", hs.grid.resizeWindowWider)

------------------------------------------------------
-- Grid Position
------------------------------------------------------
hs.hotkey.bind(hyperShift, "Up", hs.grid.pushWindowUp)
hs.hotkey.bind(hyperShift, "Down", hs.grid.pushWindowDown)
hs.hotkey.bind(hyperShift, "Left", hs.grid.pushWindowLeft)
hs.hotkey.bind(hyperShift, "Right", hs.grid.pushWindowRight)

------------------------------------------------------
-- Jump to standard placement
------------------------------------------------------
--
------------------------------------------------------
-- Maximize
------------------------------------------------------
hs.hotkey.bind(hyper, "Up", hs.grid.maximizeWindow)

------------------------------------------------------
-- Half Left
------------------------------------------------------
hs.hotkey.bind(hyper, "Left", function()
    local win = hs.window.focusedWindow()
    if win ~= nil then
        local screen = win:screen()
        hs.grid.set(win, Left50, screen)
    else
        hs.alert.show("No active window")
    end
end)

------------------------------------------------------
-- Half Right
------------------------------------------------------
hs.hotkey.bind(hyper, "Right", function()
    local win = hs.window.focusedWindow()
    if win ~= nil then
        local screen = win:screen()
        hs.grid.set(win, Right50, screen)
    else
        hs.alert.show("No active window")
    end
end)

------------------------------------------------------
-- Half Top
------------------------------------------------------
hs.hotkey.bind(hyper, "4", function()
    local win = hs.window.focusedWindow()
    if win ~= nil then
        local screen = win:screen()
        hs.grid.set(win, Top50, screen)
    else
        hs.alert.show("No active window")
    end
end)

------------------------------------------------------
-- Half Bottom
------------------------------------------------------
hs.hotkey.bind(hyper, "5", function()
    local win = hs.window.focusedWindow()
    if win ~= nil then
        local screen = win:screen()
        hs.grid.set(win, Bottom50, screen)
    else
        hs.alert.show("No active window")
    end
end)

------------------------------------------------------
-- Third Left
------------------------------------------------------
hs.hotkey.bind(hyper, "1", function()
    local win = hs.window.focusedWindow()
    if win ~= nil then
        local screen = win:screen()
        hs.grid.set(win, Left33, screen)
    else
        hs.alert.show("No active window")
    end
end)

------------------------------------------------------
-- Third Middle
------------------------------------------------------
hs.hotkey.bind(hyper, "2", function()
    local win = hs.window.focusedWindow()
    if win ~= nil then
        local screen = win:screen()
        hs.grid.set(win, Mid33, screen)
    else
        hs.alert.show("No active window")
    end
end)

------------------------------------------------------
-- Third Right
------------------------------------------------------
hs.hotkey.bind(hyper, "3", function()
    local win = hs.window.focusedWindow()
    if win ~= nil then
        local screen = win:screen()
        hs.grid.set(win, Right33, screen)
    else
        hs.alert.show("No active window")
    end
end)
--
------------------------------------------------------
-- Full Screen Management
------------------------------------------------------
hs.hotkey.bind(cmdCtrl, "Up", function()
        local win = hs.window.focusedWindow()
        if win ~= nil then
            win:setFullScreen(not win:isFullScreen())
        end
    end)

------------------------------------------------------
-- Multi monitor
------------------------------------------------------
hs.hotkey.bind(hyper, ",", hs.grid.pushWindowNextScreen )
hs.hotkey.bind(hyper, ".", hs.grid.pushWindowPrevScreen )

------------------------------------------------------
-- Change Window Focus
------------------------------------------------------
--
------------------------------------------------------
-- Hyper Down to show window hints
------------------------------------------------------
hs.hotkey.bind(hyper, 'Down', function()
    hs.hints.style = "vimperator"
    hs.hints.windowHints()
end)

------------------------------------------------------
-- hjkl to move window focus
------------------------------------------------------
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
-- Open or Focus key applications
------------------------------------------------------
hs.hotkey.bind(hyper, 'x', function()
    hs.application.launchOrFocus('iTerm')
end)
hs.hotkey.bind(hyper, 'c', function()
    hs.application.launchOrFocus('Google Chrome')
end)
hs.hotkey.bind(hyper, 'v', function()
    hs.application.launchOrFocus('MacVim')
end)

------------------------------------------------------
-- Pandoc create html on Markdown file save
------------------------------------------------------
function to_html(files)
    for _,file in pairs(files) do
        if file:sub(-3) == ".md" then
            local command = "/usr/local/bin/pandoc -s -c default.css -t html -o \"" .. file:sub(1,-4) .. ".html\" \"" .. file .. "\""
            os.execute(command)
        end
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/Documents/md", to_html):start()
