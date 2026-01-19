local OpenUI = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")
OpenUI.Name = "OpenUI"
OpenUI.Parent = game.CoreGui
OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ImageButton.Parent = OpenUI
ImageButton.BackgroundColor3 = Color3.fromRGB(105, 105, 105)
ImageButton.BackgroundTransparency = 0.8
ImageButton.Position = UDim2.new(0.9, 0, 0.1, 0)
ImageButton.Size = UDim2.new(0, 50, 0, 50)
ImageButton.Image = "rbxassetid://14369638300"
ImageButton.Draggable = true
ImageButton.Transparency = 1
UICorner.CornerRadius = UDim.new(0, 200)
UICorner.Parent = ImageButton
ImageButton.MouseButton1Click:Connect(function()
    local vim = game:service("VirtualInputManager")
    vim:SendKeyEvent(true, "RightControl", false, game)
    local vim = game:service("VirtualInputManager")
    vim:SendKeyEvent(false, "RightControl", false, game)
end)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local currentLine = 0
local lineHeight = 0.1
local baseYPosition = 0

local function Show(text, color)
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local screenGui = playerGui:FindFirstChild("FadingTextGui")
    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "FadingTextGui"
        screenGui.Parent = playerGui
        currentLine = 0
        baseYPosition = 0
    end
    local yPosition = baseYPosition + (currentLine * lineHeight)
    if yPosition + lineHeight > 1 then
        currentLine = 0
        baseYPosition = 0
        yPosition = 0
    end
    local frame = Instance.new("Frame")
    frame.Name = "TextFrame_" .. currentLine
    frame.Size = UDim2.new(0.3, 0, lineHeight, 0)
    frame.Position = UDim2.new(0, 10, yPosition, 10)
    frame.BackgroundTransparency = 1
    frame.Parent = screenGui
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "FadingText"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = color
    textLabel.TextSize = 30
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.Parent = frame
    local fadeInfo = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 1)
    local fadeTween = TweenService:Create(textLabel, fadeInfo, {TextTransparency = 1})
    fadeTween:Play()
    currentLine = currentLine + 1
    fadeTween.Completed:Connect(function()
        frame:Destroy()
        if #screenGui:GetChildren() == 0 then
            screenGui:Destroy()
            currentLine = 0
            baseYPosition = 0
        end
    end)
end

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/lyyanai/rbx/refs/heads/main/lsui"))()
local win = lib:Window("大司马脚本 | 穷小子打工记",Color3.fromRGB(102, 255, 153), Enum.KeyCode.RightControl)
local Tab = win:Tab("自动功能")
local Tab2 = win:Tab("购买功能")

Tab:Button("防录屏", function()
    local localPlayer = game.Players.LocalPlayer
    local profile = localPlayer.PlayerGui.MainUI.profile
    local starterProfile = game.StarterGui.MainUI.profile
    profile.Headshot:Destroy()
    profile.Username:Destroy()
    profile.Money:Destroy()
    starterProfile.Headshot:Destroy()
    starterProfile.Username:Destroy()
    starterProfile.Money:Destroy()
    localPlayer.Character.OverheadGui:Destroy()
    Show("已开启防录屏，放心使用", Color3.new(1, 1, 1))
end)

Tab:Button("选择矿工职业", function()
    game:GetService("ReplicatedStorage").Events.ChangeTeam:FireServer("矿工")
    Show("已选择矿工，请搭配自动挖矿", Color3.new(1, 1, 1))
end)

Tab:Button("选择渔民职业", function()
    game:GetService("ReplicatedStorage").Events.ChangeTeam:FireServer("渔民")
    Show("已选择渔民，请搭配自动钓鱼", Color3.new(1, 1, 1))
end)

Tab:Button("选择外卖员职业", function()
    game:GetService("ReplicatedStorage").Events.ChangeTeam:FireServer("外卖员")
    Show("已选择外卖员，请搭配自动送外卖", Color3.new(1, 1, 1))
end)

Tab:Toggle("自动复活", false, function(Value)
    if Value and not respawn then
        respawn = true
        Show("已开启", Color3.new(0, 1, 0))
        task.spawn(function()
            local hunger = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Hunger
            while respawn do
                if hunger.Value < 10 then
                    game:GetService("ReplicatedStorage"):WaitForChild("RespawnPlayer"):FireServer()
                end
                task.wait(1)
            end
        end)
    else
        respawn = false
        Show("已关闭", Color3.new(1, 0, 0))
    end
end)

Tab:Textbox("办公次数",false, function(Value)
    interactCount = tonumber(Value)
end)

Tab:Toggle("自动办公", false, function(Value)
    if Value and not autoFarm then
        autoFarm = true
        Show("自动办公已开启", Color3.new(0, 1, 0))
        if not promptConnection then
            promptConnection = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
                prompt.HoldDuration = 0
            end)
        end
        task.spawn(function()
            while autoFarm do
                if not autoFarm then break end
                local pos1 = Vector3.new(619.0928344726562, 34.50177764892578, -701.0907592773438)
                local char = game.Players.LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = CFrame.new(pos1)
                        task.wait(1)
                        for i = 1, interactCount do
                            if not autoFarm then break end
                            fireproximityprompt(workspace["\229\156\176\229\155\190"]["\229\187\186\231\173\145"]["\229\138\158\229\133\172"]["\228\186\164\228\186\146"].WORKS:GetChildren()[8].Work.Prox.ProximityPrompt)
                            task.wait(0.5)
                        end
                        local pos2 = Vector3.new(607.09814453125, 34.50177764892578, -673.690185546875)
                        hrp.CFrame = CFrame.new(pos2)
                        task.wait(1)
                        fireproximityprompt(workspace["\229\156\176\229\155\190"]["\229\187\186\231\173\145"]["\229\138\158\229\133\172"]["\228\186\164\228\186\146"].Sell.ProximityPrompt)
                        task.wait(1)
                    end
                end
            end
        end)
    else
        autoFarm = false
        if promptConnection then
            promptConnection:Disconnect()
            promptConnection = nil
        end
        Show("自动办公已关闭", Color3.new(1, 0, 0))
    end
end)

Tab:Toggle("自动送外卖", false, function(Value)
    if Value and not auto then
        auto = true
        Show("已开启", Color3.new(0, 1, 0))
        local args = {
            [1] = "\229\164\150\229\141\150\229\145\152"
        }
        game:GetService("ReplicatedStorage").Events.ChangeTeam:FireServer(unpack(args))
        task.spawn(function()
            local Workspace = cloneref(game:GetService("Workspace"))
            local Players = cloneref(game:GetService("Players"))
            local gameMechanics = Workspace:WaitForChild("\231\142\169\230\179\149")
            local waiMai = gameMechanics:WaitForChild("\229\164\150\229\141\150")
            local foodPoints = waiMai:WaitForChild("FoodPoints")
            local LocalPlayer = Players.LocalPlayer
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            while auto do
                if foodPoints then
                    local point = foodPoints:FindFirstChild("Location")
                    if point then
                        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                        if HumanoidRootPart then
                            task.wait(0.5)
                            HumanoidRootPart.CFrame = point.CFrame
                            task.wait(0.5)
                            local Prompt = point:FindFirstChild("Prompt")
                            if Prompt then
                                Prompt:InputHoldBegin()
                                task.wait(Prompt.HoldDuration)
                                task.wait(0.5)
                                fireproximityprompt(Prompt)
                            end
                            local tool = LocalPlayer.Backpack:WaitForChild("\229\164\150\229\141\150")
                            if tool then
                                Character.Humanoid:EquipTool(tool)
                                task.wait(0.5)
                                local delivery = tool:FindFirstChild("DeliveryLocation")
                                if delivery then
                                    HumanoidRootPart.CFrame = delivery.Value.CFrame
                                    task.wait(0.5)
                                    local deliveryPrompt = delivery.Value:FindFirstChild("Prompt")
                                    if deliveryPrompt then
                                        deliveryPrompt:InputHoldBegin()
                                        task.wait(deliveryPrompt.HoldDuration)
                                        task.wait(0.5)
                                        fireproximityprompt(deliveryPrompt)
                                    end
                                end
                            end
                        end
                    end
                end
                task.wait(1)
            end
        end)
    else
        auto = false
        Show("已关闭", Color3.new(1, 0, 0))
    end
end)

Tab:Toggle("自动挖矿石", false, function(Value)
    if Value and not mine then
        mine = true
        Show("已开启", Color3.new(0, 1, 0))
        task.spawn(function()
            while mine do
                if not mine then break end
                local teleportPositions = {
                    Vector3.new(578.310546875, -154.25787353515625, -1489.1280517578125),
                    Vector3.new(577.8190307617188, -154.1538848876953, -1492.1644287109375),
                    Vector3.new(587.0579223632812, -153.80850219726562, -1494.7083740234375),
                    Vector3.new(565.4415893554688, -154.6429901123047, -1492.0113525390625)
                }
                for _, pos in ipairs(teleportPositions) do
                    if not mine then break end
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            task.wait(0.5)
                            char:MoveTo(pos)
                            task.wait(0.5)
                            for _, part in ipairs(workspace:GetDescendants()) do
                                if part:FindFirstChild("ProximityPrompt") then
                                    local distance = (hrp.Position - part.Position).Magnitude
                                    if distance < 4 then
                                        fireproximityprompt(part.ProximityPrompt)
                                    end
                                end
                            end
                        end
                    end
                end
                if mine then
                    local miningArea2 = workspace:WaitForChild("地图"):WaitForChild("建筑"):WaitForChild("矿场"):WaitForChild("地表")
                    local sellPoint = miningArea2:WaitForChild("矿棚"):WaitForChild("交互"):WaitForChild("Sell")
                    if sellPoint then
                        local char = game.Players.LocalPlayer.Character
                        if char then
                            local hrp = char:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                hrp.CFrame = sellPoint.CFrame
                                task.wait(0.5)
                                fireproximityprompt(sellPoint.ProximityPrompt)
                            end
                        end
                    end
                end
                if mine then
                    task.wait(2)
                end
            end
        end)
    else
        mine = false
        Show("已关闭", Color3.new(1, 0, 0))
    end
end)

Tab:Toggle("自动捡井盖", false, function(Value)
    if Value and not cover then
        cover = true
        Show("已开启", Color3.new(0, 1, 0))
        task.spawn(function()
            local Workspace = cloneref(game:GetService("Workspace"))
            local Players = cloneref(game:GetService("Players"))
            local map = Workspace:WaitForChild("\229\156\176\229\155\190")
            local folder1 = map:WaitForChild("\228\184\139\230\176\180\233\129\147")
            local folder2 = folder1:WaitForChild("Manholes")
            local builds = map:WaitForChild("\229\187\186\231\173\145")
            local sbShop = builds:WaitForChild("\228\186\148\233\135\145\229\186\151")
            local sellPart = sbShop:WaitForChild("Sell")
            local sellPrompt = sellPart:WaitForChild("SellPrompt")
            local LocalPlayer = Players.LocalPlayer
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            while cover do
                if folder2 then
                    for _, retard in ipairs(folder2:GetChildren()) do
                        if not cover then break end
                        if not retard then continue end
                        local Cover = retard:FindFirstChild("Cover")
                        if not Cover then continue end
                        local Handle = Cover:FindFirstChild("Handle")
                        if not Handle then continue end
                        local Prompt = Handle:FindFirstChild("ProximityPrompt")
                        if not Prompt then continue end
                        if Prompt.ActionText ~= "拾取" then continue end
                        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                        if not HumanoidRootPart then continue end
                        task.wait(0.5)
                        HumanoidRootPart.CFrame = Handle.CFrame
                        task.wait(1.5)
                        Prompt:InputHoldBegin()
                        task.wait(Prompt.HoldDuration)
                        task.wait(0.5)
                        fireproximityprompt(Prompt)
                    end
                end
                if sellPrompt and Character then
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if HumanoidRootPart then
                        HumanoidRootPart.CFrame = sellPart.CFrame * CFrame.new(0, 0, -2)
                        task.wait(1)
                        fireproximityprompt(sellPrompt)
                        task.wait(0.5)
                    end
                end
                task.wait(1)
            end
        end)
    else
        cover = false
        Show("已关闭", Color3.new(1, 0, 0))
    end
end)

local positions = {
    ["木稿"] = Vector3.new(300.3729553222656, 16.10000991821289, -1307.2498779296875),
    ["石稿"] = Vector3.new(305.67803955078125, 16.13286781311035, -1308.208984375),
    ["铁稿"] = Vector3.new(311.58050537109375, 16.100008010864258, -1307.4964599609375),
    ["钻石稿"] = Vector3.new(316.64666748046875, 16.10000991821289, -1307.2305908203125),
    ["下届稿"] = Vector3.new(320.9141845703125, 16.10000991821289, -1307.0269775390625)
}

local selectedItem = ""
Tab2:Dropdown("选择稿子", {"木稿", "石稿", "铁稿", "钻石稿", "下届稿"}, function(itemName)
    selectedItem = itemName
    Show("已选择: "..itemName, Color3.new(0, 1, 0))
end)

Tab2:Button("自动购买", function()
    if selectedItem == "" then
        Show("错误：请先选择一个稿子", Color3.new(1, 0, 0))
        return
    end
    local targetPos = positions[selectedItem]
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    task.wait(0.5)
    character:MoveTo(targetPos)
    task.wait(0.5)
    local prompts = {}
    for _, child in ipairs(workspace:GetDescendants()) do
        if child:IsA("ProximityPrompt") and (child.Parent.Position - targetPos).Magnitude < 4 then
            table.insert(prompts, child)
        end
    end
    if #prompts > 0 then
        for _, prompt in ipairs(prompts) do
            fireproximityprompt(prompt)
        end
        Show("购买成功！", Color3.new(0, 1, 0))
    else
        Show("警告：传送成功，未找到接近提示", Color3.new(1, 1, 0))
    end
end)

local fishingRodPositions = {
    ["新手钓鱼竿"] = Vector3.new(-48.1423454284668, 0.014911353588104248, -976.5598754882812),
    ["普通钓鱼竿"] = Vector3.new(-51.93882369995117, 0.014909714460372925, -976.4150390625),
    ["高级钓鱼竿"] = Vector3.new(-55.99718475341797, 0.013977736234664917, -976.3984375)
}

local selectedFishingRod = ""
Tab2:Dropdown("选择鱼竿", {"新手钓鱼竿", "普通钓鱼竿", "高级钓鱼竿"}, function(rodName)
    selectedFishingRod = rodName
    Show("已选择: "..rodName, Color3.new(0, 1, 0))
end)

Tab2:Button("自动购买", function()
    if selectedFishingRod == "" then
        Show("错误：请先选择一个鱼竿", Color3.new(1, 0, 0))
        return
    end
    local rodTargetPos = fishingRodPositions[selectedFishingRod]
    local localPlayer = game.Players.LocalPlayer
    local playerCharacter = localPlayer.Character
    local rootPart = playerCharacter:FindFirstChild("HumanoidRootPart")
    task.wait(0.5)
    playerCharacter:MoveTo(rodTargetPos)
    task.wait(0.5)
    local rodPrompts = {}
    for _, child in ipairs(workspace:GetDescendants()) do
        if child:IsA("ProximityPrompt") and (child.Parent.Position - rodTargetPos).Magnitude < 4 then
            table.insert(rodPrompts, child)
        end
    end
    if #rodPrompts > 0 then
        for _, prompt in ipairs(rodPrompts) do
            fireproximityprompt(prompt)
        end
        Show("购买成功！", Color3.new(0, 1, 0))
    else
        Show("警告：传送成功，未找到接近提示", Color3.new(1, 1, 0))
    end
end)