-- Define required resources and garden stages
local requiredResources = {
    Stage1 = { Wood = 10, Stone = 5 },
    Stage2 = { Wood = 20, Stone = 10 },
    Stage3 = { Wood = 30, Stone = 15 }
}

local currentStage = "Stage1"
local garden = {}
local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()
local hephaestus = loadstring(game:HttpGet("https://raw.githubusercontent.com/Johnromich/Hephaestus/main/src/Hephaestus.lua"))()
local ws = hephaestus:new("GardenUI", true)
local mainFrame, topBar, gardenImage, stageLabel, resourceLabel, resumeButton, flyNoClipToggle, autoBuildToggle, saveDataButton

-- Initialize the UI elements
function initUI()
    mainFrame = ws:CreateElement("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 250)
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = ws.Frame

    topBar = ws:CreateElement("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 30)
    topBar.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    topBar.Parent = mainFrame

    gardenImage = ws:CreateElement("ImageLabel")
    gardenImage.Size = UDim2.new(1, 0, 1, 0)
    gardenImage.BackgroundTransparency = 1
    gardenImage.Image = "rbxassetid://123456789" -- Replace with the actual image ID
    gardenImage.Parent = mainFrame

    stageLabel = ws:CreateElement("TextLabel")
    stageLabel.Size = UDim2.new(1, 0, 0, 30)
    stageLabel.TextColor3 = Color3.new(1, 1, 1)
    stageLabel.TextSize = 20
    stageLabel.Font = Enum.Font.SourceSansBold
    stageLabel.TextXAlignment = Enum.TextXAlignment.Center
    stageLabel.Parent = mainFrame

    resourceLabel = ws:CreateElement("TextLabel")
    resourceLabel.Size = UDim2.new(1, 0, 0, 30)
    resourceLabel.TextColor3 = Color3.new(1, 1, 1)
    resourceLabel.TextSize = 16
    resourceLabel.Font = Enum.Font.SourceSans
    resourceLabel.TextXAlignment = Enum.TextXAlignment.Center
    resourceLabel.Parent = mainFrame

    resumeButton = ws:CreateElement("TextButton")
    resumeButton.Size = UDim2.new(0.4, 0, 0, 40)
    resumeButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
    resumeButton.TextColor3 = Color3.new(1, 1, 1)
    resumeButton.TextSize = 18
    resumeButton.Font = Enum.Font.SourceSansSemibold
    resumeButton.Text = "Resume Building"
    resumeButton.Parent = mainFrame

    flyNoClipToggle = ws:CreateElement("Toggle")
    flyNoClipToggle.Size = UDim2.new(0.3, 0, 0, 40)
    flyNoClipToggle.Position = UDim2.new(0.4, 0, 0, 120)
    flyNoClipToggle.BackgroundColor3 = Color3.new(0, 0.5, 1)
    flyNoClipToggle.TextColor3 = Color3.new(1, 1, 1)
    flyNoClipToggle.TextSize = 18
    flyNoClipToggle.Font = Enum.Font.SourceSansSemibold
    flyNoClipToggle.Text = "Fly & NoClip"
    flyNoClipToggle.Value = false
    flyNoClipToggle.Parent = mainFrame

    autoBuildToggle = ws:CreateElement("Toggle")
    autoBuildToggle.Size = UDim2.new(0.3, 0, 0, 40)
    autoBuildToggle.Position = UDim2.new(0.4, 0, 0, 160)
    autoBuildToggle.BackgroundColor3 = Color3.new(0, 0.5, 1)
    autoBuildToggle.TextColor3 = Color3.new(1, 1, 1)
    autoBuildToggle.TextSize = 18
    autoBuildToggle.Font = Enum.Font.SourceSansSemibold
    autoBuildToggle.Text = "Auto Build"
    autoBuildToggle.Value = false
    autoBuildToggle.Parent = mainFrame

    saveDataButton = ws:CreateElement("TextButton")
    saveDataButton.Size = UDim2.new(0.3, 0, 0, 40)
    saveDataButton.Position = UDim2.new(0.4, 0, 0, 200)
    saveDataButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
    saveDataButton.TextColor3 = Color3.new(1, 1, 1)
    saveDataButton.TextSize = 18
    saveDataButton.Font = Enum.Font.SourceSansSemibold
    saveDataButton.Text = "Save Data"
    saveDataButton.Parent = mainFrame

    updateGardenUI()
end

-- Function to copy another player's garden
function copyGarden(player)
    garden = player.garden
    currentStage = player.currentStage
    updateGardenUI()
end

-- Function to update the garden UI
function updateGardenUI()
    if not mainFrame then
        initUI()
    end

    stageLabel.Text = "Stage: " .. currentStage
    resourceLabel.Text = "Required Resources:\n" .. table.concat(requiredResources[currentStage], "\n", "\n")

    if hasEnoughResources() then
        resumeButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
        resumeButton.TextColor3 = Color3.new(1, 1, 1)
        saveDataButton.TextColor3 = Color3.new(1, 1, 1)
    else
        resumeButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
        resumeButton.TextColor3 = Color3.new(0.5, 0.5, 0.5)
        saveDataButton.TextColor3 = Color3.new(0.5, 0.5, 0.5)
        saveDataButton.Text = "Save Data (Incomplete)"
    end
end

-- Function to check if the player has enough resources
function hasEnoughResources()
    local playerResources = game.Players.LocalPlayer.BACKPACK

    for resource, amount in next, requiredResources[currentStage] do
        if playerResources[resource].Value < amount then
            return false
        end
    end

    return true
end

-- Function to build the garden
function buildGarden()
    if not hasEnoughResources() then
        print("Not enough resources. Waiting for more.")
        return
    end

    -- Subtract required resources from the player's backpack using shared features (Wave, Xeno, Codex)
    for resource, amount in next, requiredResources[currentStage] do
        getgenv(). Taken = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinito64/ExecutorHub/main/universal/FindAndTakeLua"))()
        Taken(resource, amount)
    end

    -- Update the garden with the next stage's model using shared features (Wave, Xeno, Codex)
    local gardenModel = script:WaitForChild(currentStage)
    getgenv(). Clone = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinito64/ExecutorHub/main/universal/CloneLua"))()
    Clone(gardenModel, garden.Parent)

    currentStage = currentStage + 1
    updateGardenUI()
end

-- Resume building the garden button click event
resumeButton.ButtonClicked:Connect(function()
    if not hasEnoughResources() then
        print("Not enough resources. Waiting for more.")
        return
    end

    buildGarden()
end)

-- Fly and NoClip toggle button click event
flyNoClipToggle.Toggled:Connect(function()
    local flying, noClip = flyNoClipToggle.Value
    humanoid.WalkSpeed = flying and 20 or 16
    camera.FieldOfView = flying and 70 or 70

    -- NoClip functionality (character can phase through objects) using shared features (Wave, Xeno, Codex)
    local oldScript = character:FindFirstChild("oldScript")
    if noClip then
        if not oldScript then
            local newScript = Instance.new("Script")
            newScript.Name = "oldScript"
            newScript.Source = humanoid.WalkSpeed + 1000 .. " speedWalk(_,_)"
            newScript.Parent = character
            oldScript = newScript
        end
    elseif oldScript then
        oldScript:Destroy()
    end
end)

-- Auto build toggle button click event
autoBuildToggle.Toggled:Connect(function()
    local autoBuild, flying, noClip = autoBuildToggle.Value, flyNoClipToggle.Value

    if autoBuild then
        while hasEnoughResources() do
            buildGarden()
            wait(1) -- Add a small delay between each build iteration to prevent lag
        end

        if not hasEnoughResources() then
            print("Not enough resources. Saving data and stopping auto build.")
            saveData()
            autoBuildToggle.Value = false
        end
    end
end)

-- Save data button click event
saveDataButton.ButtonClicked:Connect(function()
    local dataToSave = { currentStage = currentStage, requiredResources = requiredResources[currentStage] }
    local saveDataScript = Instance.new("Script")
    saveDataScript.Name = "SaveData"
    saveDataScript.Source = "game.Players.LocalPlayer.Data:FireServer(\"SaveGardenData\", " .. stringify(dataToSave) .. ")"
    saveDataScript.Parent = game:GetService("Workspace")
end)

-- Load saved data function
function loadSavedData(data)
    garden = data.garden or {}
    currentStage = data.currentStage or "Stage1"
    requiredResources[currentStage] = data.requiredResources or requiredResources[currentStage]
    updateGardenUI()
end

-- Save data function
function saveData()
    local dataToSave = { currentStage = currentStage, requiredResources = requiredResources[currentStage] }
    local saveDataScript = Instance.new("Script")
    saveDataScript.Name = "SaveData"
    saveDataScript.Source = "game.Players.LocalPlayer.Data:FireServer(\"SaveGardenData\", " .. stringify(dataToSave) .. ")"
    saveDataScript.Parent = game:GetService("Workspace")
end

-- Check if the player has enough resources and start building the garden when the resume button is clicked
if hasEnoughResources() then
    buildGarden()
else
    print("Waiting for more resources...")
end

-- Initialization
if flyNoClipToggle.Value then
    flyNoClipToggle:FireServer()
end
