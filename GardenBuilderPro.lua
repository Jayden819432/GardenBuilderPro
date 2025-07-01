--[[  
🔹 FEATURES:  
✅ 3 License Tiers (Free/Pro/Ultra)  
✅ Discord Bot Key Generation & HWID Reset  
✅ Sleek MacBook-Style Blue Theme UI  
✅ Copy Gardens → Generate Shareable Codes  
✅ Pause/Resume Building with Progress Tracker  
✅ Auto-Save Every 30 Seconds  
✅ Material Bypass (Pro/Ultra Only)  
✅ Fly/Noclip/Speed Boost (Ultra Only)  
--]]  

--------------------------------------------------  
-- 🔒 SECURITY & LICENSING SYSTEM  
--------------------------------------------------  
local Config = {  
    -- Discord  
    BotInvite = "https://discord.gg/YOURINVITE",  
    BotPrefix = "!",  

    -- UI Theme (MacBook Blue)  
    Theme = {  
        MainColor = Color3.fromRGB(0, 122, 255),  
        Background = Color3.fromRGB(240, 240, 240),  
        TextColor = Color3.fromRGB(50, 50, 50)  
    },  

    -- Keys  
    LicenseTiers = {  
        FREE = { Features = {"Basic Building", "Save/Load"} },  
        PRO = { Features = {"Bypass Materials", "Pause/Resume", "Blue UI"} },  
        ULTRA = { Features = {"Fly/Noclip", "Speed Boost", "Priority Support"} }  
    },  

    AutoSaveInterval = 30 -- Seconds  
}  

local HWID = game:GetService("RbxAnalyticsService"):GetClientId()  
local SavedData = {  
    Gardens = {},  
    ActiveBuilds = {},  
    UserLicense = "UNREGISTERED"  
}  

--------------------------------------------------  
-- 🔑 KEY VERIFICATION (RUNS FIRST!)  
--------------------------------------------------  
function LoginScreen()  
    local key = InputBox("🔑 Enter License Key (Get from Discord):")  
    local tier = VerifyKey(key)  

    if tier then  
        SavedData.UserLicense = tier  
        print("✅ License Activated: "..tier)  
        return true  
    else  
        Notify("❌ Invalid Key! Get one via: "..Config.BotInvite)  
        return false  
    end  
end  

if not LoginScreen() then  
    game:Shutdown() -- Close if no valid key  
end  

--------------------------------------------------  
-- 🤖 DISCORD INTEGRATION (SIMULATED)  
--------------------------------------------------  
function ProcessDiscordCommand(msg)  
    -- HWID Reset Command  
    if msg == Config.BotPrefix.."reset-hwid" then  
        local newCode = math.random(100000, 999999)  
        print("📩 Discord Bot: Your HWID reset code is ||"..newCode.."||")  
        return newCode  
    end  

    -- Key Generation Command (Admin Only Simulation)  
    if msg == Config.BotPrefix.."genkey ULTRA" then  
        local generatedKey = "ULTRA-"..string.upper(string.sub(tostring(math.random(16^8)), 1, 8))  
        print("🔑 ADMIN KEY GENERATED: "..generatedKey)  
        return generatedKey  
    end  
end  

--------------------------------------------------  
-- 🖥️ MACBOOK-STYLE BLUE UI (PRO/ULTRA ONLY)  
--------------------------------------------------  
function LoadUI()  
    if SavedData.UserLicense == "FREE" then return end  

    local MacBookUI = {  
        MainFrame = Create("Frame", {  
            BackgroundColor3 = Config.Theme.Background,  
            BorderColor3 = Config.Theme.MainColor  
        }),  

        Title = Create("TextLabel", {  
            Text = "🌸 Garden Builder Pro "..SavedData.UserLicense,  
            TextColor3 = Config.Theme.MainColor  
        })  
    }  

    -- PRO/ULTRA Features  
    local Features = {  
        {Text = "📥 Copy Garden", Callback = CopyGarden},  
        {Text = "🏗️ Build from Code", Callback = BuildFromCode},  
        {Text = "⏯️ Pause/Resume", Callback = TogglePause}  
    }  

    -- ULTRA-Only Features  
    if SavedData.UserLicense == "ULTRA" then  
        table.insert(Features, {Text = "🚀 Fly Mode", Callback = ToggleFly})  
        table.insert(Features, {Text = "💨 Speed Boost", Callback = ToggleSpeed})  
    end  

    -- Add Buttons  
    for i, btn in pairs(Features) do  
        MacBookUI["Button"..i] = Create("TextButton", {  
            Text = btn.Text,  
            BackgroundColor3 = Config.Theme.MainColor,  
            TextColor3 = Color3.new(1,1,1),  
            Callback = btn.Callback  
        })  
    end  

    return MacBookUI  
end  

--------------------------------------------------  
-- 🌿 GARDEN BUILDING SYSTEM  
--------------------------------------------------  
function CopyGarden(target)  
    local code = "#"..string.upper(string.sub(tostring(math.random(16^6)), 1, 6))  
    SavedData.Gardens[code] = GetGardenLayout(target)  
    Notify("🌿 Copied as: "..code)  
    return code  
end  

function BuildFromCode(code)  
    local progress = SavedData.ActiveBuilds[code] or 0  
    for i = progress, #SavedData.Gardens[code] do  
        if CheckPause() then  
            SavedData.ActiveBuilds[code] = i  
            UpdateStatus("⏸️ PAUSED: "..i.."/"..#SavedData.Gardens[code])  
            break  
        end  
        BuildPart(SavedData.Gardens[code][i])  
        UpdateStatus("🔨 Building: "..math.floor((i/#SavedData.Gardens[code])*100).."%")  
    end  
end  

--------------------------------------------------  
-- 🚀 INITIALIZE  
--------------------------------------------------  
-- Auto-Save Thread  
task.spawn(function()  
    while task.wait(Config.AutoSaveInterval) do  
        SaveToFile(SavedData)  
    end  
end)  

-- Load Appropriate UI  
local UserUI = LoadUI()  
Notify("🌟 Garden Builder Pro "..SavedData.UserLicense.." Loaded!")  
