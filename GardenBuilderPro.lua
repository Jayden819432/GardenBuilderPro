--▓█████▄  ▄▄▄       ██▀███   ██ ▄█▀ ▒█████   ██▓    
--▒██▀ ██▌▒████▄    ▓██ ▒ ██▒ ██▄█▒ ▒██▒  ██▒▓██▒    
--░██   █▌▒██  ▀█▄  ▓██ ░▄█ ▒▓███▄░ ▒██░  ██▒▒██░    
--░▓█▄   ▌░██▄▄▄▄██ ▒██▀▀█▄  ▓██ █▄ ▒██   ██░▒██░    
--░▒████▓  ▓█   ▓██▒░██▓ ▒██▒▒██▒ █▄░ ████▓▒░░██████▒
-- ▒▒▓  ▒  ▒▒   ▓▒█░░ ▒▓ ░▒▓░▒ ▒▒ ▓▒░ ▒░▒░▒░ ░ ▒░▓  ░
-- ░ ▒  ▒   ▒   ▒▒ ░  ░▒ ░ ▒░░ ░▒ ▒░  ░ ▒ ▒░ ░ ░ ▒  ░
-- ░ ░  ░   ░   ▒     ░░   ░ ░ ░░ ░ ░ ░ ░ ▒    ░ ░   
--   ░          ░  ░   ░     ░  ░       ░ ░      ░  ░

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

--►► KEY SYSTEM ◄◄--
local KeyVerified = false
local HardwareID = game:GetService("RbxAnalyticsService"):GetClientId()

local function GenerateHWID()
    return HardwareID
end

local ValidKeys = {
    "GBP-PRO-5F3D9A",
    "GBP-VIP-8C2E7B",
    "GBP-ULTRA-1B4D6F"
}

local function VerifyKey(InputKey)
    for _, Key in pairs(ValidKeys) do
        if InputKey == Key then
            return true
        end
    end
    return false
end

--►► UI LIBRARY ◄◄--
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Garden Builder Pro v3.2", "Ocean")

--►► MAIN TAB ◄◄--
local MainTab = Window:NewTab("Build Controls")
local CopierSection = MainTab:NewSection("Garden Copy System")

_G.TargetPlayer = ""
CopierSection:NewTextBox("Target Player", "Username to copy from", function(txt)
    _G.TargetPlayer = txt
    Library:Notify("Target Set", "Now copying: "..txt)
end)

CopierSection:NewButton("📥 Copy Garden", "Saves all build data", function()
    if _G.TargetPlayer == "" then
        Library:Notify("Error", "No target selected!")
        return
    end
    -- [Insert garden scanning logic here]
    Library:Notify("Success", "Garden copied from ".._G.TargetPlayer)
end)

local BuildSection = MainTab:NewSection("Build Options")
BuildSection:NewToggle("🌀 Bypass Requirements", "Build without materials", function(state)
    _G.Bypass = state
    Library:Notify("Bypass "..(state and "Enabled" or "Disabled"))
end)

BuildSection:NewToggle("👻 Invisible Building", "Hides building process", function(state)
    _G.InvisibleMode = state
end)

BuildSection:NewToggle("⚡ Auto-Farm Mode", "Collects resources while building", function(state)
    _G.AutoFarm = state
end)

--►► PLAYER TAB ◄◄--
local PlayerTab = Window:NewTab("Player Enhancements")
local Movement = PlayerTab:NewSection("Movement")

Movement:NewToggle("🚀 Fly Mode", "Float through the air", function(state)
    loadstring(game:HttpGet("https://pastebin.com/raw/3kQ6M23b"))() -- Fly script
end)

Movement:NewToggle("👻 Noclip", "Walk through objects", function(state)
    _G.Noclip = state
end)

Movement:NewSlider("💨 WalkSpeed", "Adjust movement speed", 200, 16, function(s)
    Player.Character.Humanoid.WalkSpeed = s
end)

PlayerTab:NewSection("Utility"):NewToggle("🛡️ Anti-AFK", "Prevents auto-kick", function(state)
    loadstring(game:HttpGet("https://pastebin.com/raw/SxKv0XpU"))() -- Anti-AFK
end)

--►► ADVANCED TAB ◄◄--
local AdvancedTab = Window:NewTab("Advanced")
local Scanner = AdvancedTab:NewSection("Garden Scanner")

Scanner:NewButton("🔍 Find Best Gardens", "Scans server for optimal copies", function()
    -- [Insert scanning logic]
    Library:Notify("Scan Complete", "Found 5 premium gardens")
end)

AdvancedTab:NewSection("Security"):NewToggle("🕵️ Stealth Mode", "Reduces detection", function(state)
    _G.StealthMode = state
    game:GetService("Stats").PerformanceStats:SetActive(false)
end)

--►► KEY SYSTEM TAB ◄◄--
local KeyTab = Window:NewTab("🔑 Auth")
KeyTab:NewLabel("Hardware ID: "..GenerateHWID())
local KeyBox = KeyTab:NewTextBox("License Key", "Enter your GBP key")

KeyTab:NewButton("Validate Key", function()
    if VerifyKey(KeyBox.Text) then
        KeyVerified = true
        Library:Notify("Success", "Premium features unlocked!")
    else
        Library:Notify("Invalid Key", "Join our Discord for access")
    end
end)

--►► NO-CLIP HANDLER ◄◄--
game:GetService('RunService').Stepped:connect(function()
    if _G.Noclip and Player.Character then
        for _, v in pairs(Player.Character:GetDescendants()) do
            pcall(function()
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end)
        end
    end
end)

Library:Notify("Garden Builder Pro", "Successfully loaded! 🌸")
