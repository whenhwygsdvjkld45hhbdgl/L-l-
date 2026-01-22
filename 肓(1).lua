local UI = loadstring(game:HttpGet("https://xan.bar/init.lua"))()

UI.Sideloader({
    Steps = {
        "检查执行器...",
        "加载模块...",
        "初始化性能..",
        "加载fps...",
        "加载成功!"
    },
    StepDelay = 0.4,
    OnComplete = function()
        Window:Show()
    end
})

local Window = UI.New({
    Title = "大司马脚本V3",
    Theme = "Default",
    Size = UDim2.new(0, 580, 0, 420),
    ShowUserInfo = true,
    ShowActiveList = true
})

local Watermark = UI.Watermark({
    Text = "大司马脚本V3",
    Position = UDim2.new(0, 10, 0, 10),
    ShowFPS = true,
    ShowPing = true,
    ShowTime = true,
    Visible = true
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

UI.Toast(LocalPlayer.Name, "欢迎使用大司马脚本付费版V3")
local Main = Window:AddTab("主要功能", UI.Icons.Home)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

Main:AddSlider("奔跑速度", "SliderText", 16, 100, 16, function(Value)
    local Character = LocalPlayer.Character
    if Character and Character:FindFirstChild("Humanoid") then
        Character.Humanoid.WalkSpeed = Value
    end
end)

Main:AddSlider("跳跃高度", "SliderText", 50, 200, 50, function(Value)
    local Character = LocalPlayer.Character
    if Character and Character:FindFirstChild("Humanoid") then
        pcall(function()
            Character.Humanoid.JumpHeight = Value
        end)
        pcall(function()
            Character.Humanoid.UseJumpPower = true
            Character.Humanoid.JumpPower = Value
        end)
    end
end)
local AntiHit = false
Main:AddToggle("防击中", "防击中", function(Value)
    AntiHit = Value
    if Value then
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            task.spawn(function()
                while AntiHit do
                    local CurrentCFrame = HumanoidRootPart.CFrame
                    HumanoidRootPart.CFrame = CurrentCFrame * CFrame.new(0, -5, 0)
                    RunService.RenderStepped:Wait()
                    HumanoidRootPart.CFrame = CurrentCFrame
                    task.wait()
                end
            end)
        end
    else
    end
end)

local TrophyFarm = false
Main:AddToggle("自动刷钱", "自动刷钱", function(Value)
    TrophyFarm = Value
    if Value then
    
        task.spawn(function()
            while TrophyFarm do
                local Character = LocalPlayer.Character
                if Character then
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    local Trophy = Workspace:FindFirstChild("Trophy", true)
                    if Trophy and HumanoidRootPart then
                        firetouchinterest(HumanoidRootPart, Trophy, 0)
                        task.wait()
                        firetouchinterest(HumanoidRootPart, Trophy, 1)
                    end
                end
                task.wait(0.3)
            end
          
        end)
    else
      
    end
end)
local Tab= Window:AddTab("ESP", UI.Icons.Render)
local function createPlayerESP()
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local localPlayer = players.LocalPlayer
local espEnabled = false
local function createESP(player)
if player == localPlayer then return end
local char = player.Character
if not char then return end
local humanoidRootPart = char:FindFirstChild("HumanoidRootPart")
if not humanoidRootPart then return end
local box = Instance.new("BoxHandleAdornment")
box.Adornee = humanoidRootPart
box.AlwaysOnTop = true
box.ZIndex = 10
box.Size = Vector3.new(4, 6, 4)
box.Color3 = Color3.fromRGB(255, 255, 255)
box.Transparency = 0.5
box.Parent = char
local billboard = Instance.new("BillboardGui")
billboard.Name = "ESP"
billboard.Adornee = humanoidRootPart
billboard.Size = UDim2.new(0, 100, 0, 40)
billboard.StudsOffset = Vector3.new(0, 4, 0)
billboard.AlwaysOnTop = true
billboard.Parent = char
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = player.Name
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.TextSize = 14
nameLabel.Font = Enum.Font.GothamBold
nameLabel.Parent = billboard
local distanceLabel = Instance.new("TextLabel")
distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
distanceLabel.BackgroundTransparency = 1
distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
distanceLabel.TextSize = 12
distanceLabel.Font = Enum.Font.Gotham
distanceLabel.Parent = billboard
local connection
connection = runService.Heartbeat:Connect(function()
if not char or not char:FindFirstChild("HumanoidRootPart") or not humanoidRootPart then
connection:Disconnect()
return
end
local localChar = localPlayer.Character
local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")
if localRoot then
local distance = math.floor((humanoidRootPart.Position - localRoot.Position).Magnitude)
distanceLabel.Text = distance .. " studs"
end
end)
end
local function removeESP(player)
local char = player.Character
if char then
for _, v in pairs(char:GetChildren()) do
if v.Name == "ESP" or v:IsA("BoxHandleAdornment") then
v:Destroy()
end
end
end
end
players.PlayerAdded:Connect(function(player)
player.CharacterAdded:Connect(function(char)
if espEnabled then
createESP(player)
end
end)
end)
players.PlayerRemoving:Connect(function(player)
removeESP(player)
end)
for _, player in pairs(players:GetPlayers()) do
if player ~= localPlayer and player.Character then
createESP(player)
end
end
Tab:AddToggle("显示玩家", function(state)
espEnabled = state
if state then
for _, player in pairs(players:GetPlayers()) do
if player ~= localPlayer and player.Character then
createESP(player)
end
end
else
for _, player in pairs(players:GetPlayers()) do
if player ~= localPlayer then
removeESP(player)
end
end
end
end)
end
createPlayerESP()