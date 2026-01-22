local RevenantLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/AAAAAAASDSYGASSAAAA111/refs/heads/main/115.lua", true))()
RevenantLib.DefaultColor = Color3.fromRGB(255, 0, 0)
RevenantLib:Notification({
  Text = "我们不支持该服务器\u{e000}",
  Duration = 6,
})
wait(1)
RevenantLib:Notification({
  Text = "已自动为您切换通用脚本\u{e000}",
  Duration = 6,
})
wait(1)
RevenantLib:Notification({
  Text = "您可以在售后群催更^ω^",
  Duration = 6,
})
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/whenheet/-ui2/refs/heads/main/%E5%B0%8F%E4%BA%91ui(2).lua", true))()
local window = library:new("大司马", '')
local Section3 = window:Tab("通用", "10882439086")
local Section3 = Section3:section("通用", true)

Section3:Button("透视",function()  
    _G.FriendColor = Color3.fromRGB(0, 0, 255)
    local function ApplyESP(v)
        if v.Character and v.Character:FindFirstChildOfClass'Humanoid' then
            v.Character.Humanoid.NameDisplayDistance = 9e9
            v.Character.Humanoid.NameOcclusion = "NoOcclusion"
            v.Character.Humanoid.HealthDisplayDistance = 9e9
            v.Character.Humanoid.HealthDisplayType = "AlwaysOn"
            v.Character.Humanoid.Health = v.Character.Humanoid.Health
        end
    end
    
    for i,v in pairs(game.Players:GetPlayers()) do
        ApplyESP(v)
        v.CharacterAdded:Connect(function()
            task.wait(0.33)
            ApplyESP(v)
        end)
    end
    
    game.Players.PlayerAdded:Connect(function(v)
        ApplyESP(v)
        v.CharacterAdded:Connect(function()
            task.wait(0.33)
            ApplyESP(v)
        end)
    end)
    
    local Players = game:GetService("Players"):GetChildren()
    local RunService = game:GetService("RunService")
    local highlight = Instance.new("Highlight")
    highlight.Name = "Highlight"
    
    for i, v in pairs(Players) do
        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if not v.Character.HumanoidRootPart:FindFirstChild("Highlight") then
                local highlightClone = highlight:Clone()
                highlightClone.Adornee = v.Character
                highlightClone.Parent = v.Character.HumanoidRootPart
                highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlightClone.Name = "Highlight"
            end
        end
    end
    
    game.Players.PlayerAdded:Connect(function(player)
        repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not player.Character.HumanoidRootPart:FindFirstChild("Highlight") then
            local highlightClone = highlight:Clone()
            highlightClone.Adornee = player.Character
            highlightClone.Parent = player.Character.HumanoidRootPart
            highlightClone.Name = "Highlight"
        end
    end)
    
    game.Players.PlayerRemoving:Connect(function(playerRemoved)
        if playerRemoved.Character and playerRemoved.Character:FindFirstChild("HumanoidRootPart") and playerRemoved.Character.HumanoidRootPart:FindFirstChild("Highlight") then
            playerRemoved.Character.HumanoidRootPart.Highlight:Destroy()
        end
    end)
    
    RunService.Heartbeat:Connect(function()
        for i, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                if not v.Character.HumanoidRootPart:FindFirstChild("Highlight") then
                    local highlightClone = highlight:Clone()
                    highlightClone.Adornee = v.Character
                    highlightClone.Parent = v.Character.HumanoidRootPart
                    highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlightClone.Name = "Highlight"
                end
            end
        end
    end)
end)

Section3:Toggle("夜视","Toggle",false,function(Value)
    if Value then
        game.Lighting.Ambient = Color3.new(1, 1, 1)
    else
        game.Lighting.Ambient = Color3.new(0, 0, 0)
    end
end)

local autoInteract
Section3:Toggle("自动互动", "Auto Interact", false, function(state)
    autoInteract = state
    while autoInteract do
        for _, descendant in pairs(workspace:GetDescendants()) do
            if descendant:IsA("ProximityPrompt") then
                fireproximityprompt(descendant)
            end
        end
        task.wait(0.25)
    end
end)

local Jump
Section3:Toggle("无限跳","Toggle",false,function(Value)
    Jump = Value
    game.UserInputService.JumpRequest:Connect(function()
        if Jump then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
        end
    end)
end)

Section3:Slider("步行速度!", "WalkSpeed", game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, 16, 400, false, function(Speed)
    spawn(function() 
        while task.wait() do 
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Speed 
        end 
    end)
end)

Section3:Slider("跳跃高度!", "JumpPower", game.Players.LocalPlayer.Character.Humanoid.JumpPower, 50, 400, false, function(Jump)
    spawn(function() 
        while task.wait() do 
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jump 
        end 
    end)
end)

Section3:Button("自杀",function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

Section3:Button("踏空行走",function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ENABLED = false
local nameLabels = {}

local function createNameLabel(player)
    if nameLabels[player] then return end
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local billboard = Instance.new("BillboardGui")
        billboard.Parent = player.Character
        billboard.Adornee = player.Character.HumanoidRootPart
        billboard.Size = UDim2.new(0, 100, 0, 40)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Parent = billboard
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.TextScaled = true
        
        nameLabels[player] = billboard
    end
end

local function onPlayerAdded(player)
    if ENABLED then
        createNameLabel(player)
    end
end

local function onPlayerRemoving(player)
    if nameLabels[player] then
        nameLabels[player]:Destroy()
        nameLabels[player] = nil
    end
end

Section3:Toggle("ESP 显示名字", "AMG", false, function(enabled)
    ENABLED = enabled
    if enabled then
        for _, player in ipairs(Players:GetPlayers()) do
            createNameLabel(player)
        end
        Players.PlayerAdded:Connect(onPlayerAdded)
        Players.PlayerRemoving:Connect(onPlayerRemoving)
    else
        for player, label in pairs(nameLabels) do
            label:Destroy()
        end
        nameLabels = {}
    end
end)

Section3:Toggle("Circle ESP", "ESP", false, function(state)
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            if state then
                if player.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character

                    local billboard = Instance.new("BillboardGui")
                    billboard.Parent = player.Character
                    billboard.Adornee = player.Character
                    billboard.Size = UDim2.new(0, 100, 0, 100)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = billboard
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextScaled = true

                    local circle = Instance.new("ImageLabel")
                    circle.Parent = billboard
                    circle.Size = UDim2.new(0, 50, 0, 50)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0)
                    circle.AnchorPoint = Vector2.new(0.5, 0.5)
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246"
                end
            else
                if player.Character then
                    if player.Character:FindFirstChildOfClass("Highlight") then
                        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                    if player.Character:FindFirstChildOfClass("BillboardGui") then
                        player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
                    end
                end
            end
        end
    end
end)

Section3:Button("工具包", "玩家应该看不见", function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()
end)

Section3:Button("工具点击传送", " ", function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "点击传送"
    tool.Activated:connect(function()
        local pos = mouse.Hit+Vector3.new(0,2.5,0)
        pos = CFrame.new(pos.X,pos.Y,pos.Z)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
    end)
    tool.Parent = game.Players.LocalPlayer.Backpack
end)

Section3:Button("飞行", function()
loadstring(game:HttpGet("https://pastefy.app/J9x7RnEZ/raw"))()
end)