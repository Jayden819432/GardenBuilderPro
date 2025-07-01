-- Variables
local player = game:GetService("Players").LocalPlayer
local TIER = "FREE" -- Changed by key verification

-- Rainbow Username (UI)
local function rainbowText(text)
    local colors = {"Red", "Orange", "Yellow", "Green", "Blue", "Purple"}
    for i = 1, #text do
        -- Animate each character
    end
end

-- Auto-Farm + Auto-Sell
local function autoFarm()
    while task.wait() do
        if TIER == "ULTRA" then
            -- Farm planets + sell automatically
        end
    end
end

-- UI Setup (Fancy design)
local UI = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
-- ... (Full UI code in Pastebin)

-- Welcome Animation
Frame.WelcomeLabel.Text = "Welcome, " .. player.Name .. "!"
spawn(function()
    while task.wait(0.1) do
        -- Slide-in effect
    end
end)

-- Gear/Seed Menu
local function openShop(shopType)
    if TIER ~= "FREE" then
        teleportTo(shopType) -- No walking needed
    end
end
                                                          
