local OvO = game.Players
local O_O = OvO.LocalPlayer
local OAO = O_O.Character
local camera = workspace.CurrentCamera

local ESP = {
    "HiderESPFloder",
    "SeekerESPFloder",
}
for _,v in next,ESP do
    if not workspace:FindFirstChild(v) then
        local ESPFloder = Instance.new("Folder")
        ESPFloder.Parent = workspace
        ESPFloder.Name = v
    end
end
local function ESPHider(Text, Adornee, Color)
    if not Adornee:FindFirstChild("ROLESPBillboardGui") then
        local ROLESPBillboardGui = Instance.new("BillboardGui")
        ROLESPBillboardGui.Parent = workspace.HiderESPFloder
        ROLESPBillboardGui.Adornee = Adornee
        ROLESPBillboardGui.Size = UDim2.new(0, 20, 0, 20)
        ROLESPBillboardGui.StudsOffset = Vector3.new(0, 3, 0)
        ROLESPBillboardGui.AlwaysOnTop = true
        local ROLESPTextLabel = Instance.new("TextLabel")
        ROLESPTextLabel.Parent = ROLESPBillboardGui
        ROLESPTextLabel.Size = UDim2.new(1, 0, 1, 0)
        ROLESPTextLabel.BackgroundTransparency = 1
        ROLESPTextLabel.Text = Text
        ROLESPTextLabel.TextColor3 = Color
        ROLESPTextLabel.TextStrokeTransparency = 0.5
        ROLESPTextLabel.TextScaled = true
    end
end
local function ESPSeeker(Text, Adornee, Color)
    if not Adornee:FindFirstChild("ROLESPBillboardGui") then
        local ROLESPBillboardGui = Instance.new("BillboardGui")
        ROLESPBillboardGui.Parent = workspace.SeekerESPFloder
        ROLESPBillboardGui.Adornee = Adornee
        ROLESPBillboardGui.Size = UDim2.new(0, 20, 0, 20)
        ROLESPBillboardGui.StudsOffset = Vector3.new(0, 3, 0)
        ROLESPBillboardGui.AlwaysOnTop = true
        local ROLESPTextLabel = Instance.new("TextLabel")
        ROLESPTextLabel.Parent = ROLESPBillboardGui
        ROLESPTextLabel.Size = UDim2.new(1, 0, 1, 0)
        ROLESPTextLabel.BackgroundTransparency = 1
        ROLESPTextLabel.Text = Text
        ROLESPTextLabel.TextColor3 = Color
        ROLESPTextLabel.TextStrokeTransparency = 0.5
        ROLESPTextLabel.TextScaled = true
    end
end
local AimTog = false
local AutoCollectCoins = false
local Noclip = false
local AlwaysSeeker = false
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/whenheet/-ui2/refs/heads/main/%E5%B0%8F%E4%BA%91ui(2).lua"))()

local window = library:new("大司马｜隐藏或死亡")

local Page = window:Tab("主要功能",'16060333448')

local Section = Page:section("功能",true)

Section:Toggle("自瞄躲藏者", "", false, function(state)
    AimTog = state
    if AimTog then
        pcall(function()
            spawn(function()
                while task.wait(0.1) and AimTog do
                    local closestPlayer = nil
                    local closestDistance = math.huge
                    for _, v in next, OvO:GetChildren() do
                        if v ~= O_O and v.Team.Name == "Hider" and v.Character.Humanoid.Health > 0 then
                            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                                local distance = (O_O.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                                if distance < closestDistance then
                                    closestDistance = distance
                                    closestPlayer = v.Character
                                end
                            end
                        end
                    end
                    if closestPlayer then
                        camera.CFrame = CFrame.lookAt(camera.CFrame.p, closestPlayer.HumanoidRootPart.Position)
                    end
                end
            end)
        end)
    else
        camera.CFrame = CFrame.new(OAO.HumanoidRootPart.Position, OAO.HumanoidRootPart.Position + Vector3.new(0, 0, 1))
    end
end)

Section:Toggle("透视躲藏者", "", false, function(state)
    if state then
        for _,v in next,OvO:GetChildren() do
            if v ~= O_O and v.Team.Name == "Hider" then
                ESPHider("躲藏者"..v.Name, v.Character, Color3.new(0,0,1))
            end
        end
    else
        workspace.HiderESPFloder:ClearAllChildren()
    end
end)

Section:Toggle("透视搜查者", "", false, function(state)
    if state then
        for _,v in next,OvO:GetChildren() do
            if v ~= O_O and v.Team.Name == "Seeker" then
                ESPSeeker("搜查者"..v.Name, v.Character, Color3.new(1,0,0))
            end
        end
    else
        workspace.SeekerESPFloder:ClearAllChildren()
    end
end)

Section:Toggle("自动获取金币", "", false, function(state)
    AutoCollectCoins = state
    pcall(function()
        spawn(function()
            while task.wait(0.1) and AutoCollectCoins do
                for _,v in next,workspace.Trash.Coins:GetChildren() do
                    firetouchinterest(v.Coin, OAO.HumanoidRootPart, 0)
                    firetouchinterest(v.Coin, OAO.HumanoidRootPart, 1)
                end
            end
        end)
    end)
end)

Section:Toggle("完成岛屿挑战(每回合可以挑战一次)", "", false, function(state)
    if state then
        firetouchinterest(workspace.Obby.Pad.Pad, OAO..HumanoidRootPart, 0)
        firetouchinterest(workspace.Obby.Pad.Pad, OAO..HumanoidRootPart, 1)
    end
end)

Main:Toggle("穿墙", "", false, function(state)
    Noclip = state
    spawn(function()
        while Noclip do wait(0.1)
            pcall(function()
                if Noclip and OAO and OAO:FindFirstChild("HumanoidRootPart") then
                    if OAO then
                        for _, part in pairs(OAO:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = not state
                            end
                        end
                    end
                end
            end)
        end
    end)
end)

Main:Toggle("永远成为搜查者", "", false, function(state)
    AlwaysSeeker = state
    spawn(function()
        while AlwaysSeeker do wait(0.1)
            pcall(function()
                if O_O.PlayerGui.Frames.role_reveal.seeker_chance and O_O.PlayerGui.Frames.role_reveal.seeker_chance.TextTransparency ~= 1 then
                    O_O.PlayerGui.Frames.role_reveal.role.Seeker.Visible = true
                    O_O.PlayerGui.Frames.role_reveal.role.Hider.Visible = false
                end
                O_O.PlayerGui.Frames.role_reveal.seeker_chance.Text = "Chance to be seeker: 100%"
                if not O_O.Team or O_O.Team.Name == "Hider" then
                    game:GetService("ReplicatedStorage").Network.match.WantsToJoinMatch:FireServer()
                    O_O.Team = game:GetService("Teams").Seeker
                end
            end)
        end
    end)
end)

for _,player in next,game.Players:GetPlayer() do
    for i=1, 4 do
        game:GetService("ReplicatedStorage").Network.knife.slash:FireServer(
            workspace:GetServerTimeNow(),
            O_O.Character:FindFirstChild("Secondary") or O_O.Backpack:FindFirstChild("Secondary"),
            player.Character:GetPivot(),
            player.Character.Humanoid
        )
    end
end