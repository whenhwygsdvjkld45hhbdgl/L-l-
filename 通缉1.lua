local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")


local daySettings = {
    ClockTime = 14,  
    GeographicLatitude = 41.73,  
    
    
    
    
    
    
}

local function setDay()
    for property, value in pairs(daySettings) do
        local tweenInfo = TweenInfo.new(
            2,  
            Enum.EasingStyle.Quad,  
            Enum.EasingDirection.Out  
        )
        
        local tween = TweenService:Create(Lighting, tweenInfo, { [property] = value })
        tween:Play()
    end
end


setDay()


local Players, TeleportService, Workspace, TweenService = 
    game:GetService("Players"), 
    game:GetService("TeleportService"), 
    game:GetService("Workspace"), 
    game:GetService("TweenService")

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "大司马脚本--通缉", Folder = "大司马脚本--通缉", Size = UDim2.fromOffset(550, 300),
    Transparent = true, Theme = "Dark", SideBarWidth = 190, HideSearchBar = true
})
Window:EditOpenButton({Title = "大司马脚本--通缉", CornerRadius = UDim.new(0,4)})

local Tabs = {
    InfoTab = Window:Tab({Title = "作者信息", Icon = "info", Desc = ""}),
    MainDivider = Window:Divider(),
    MainTab = Window:Tab({Title = "主要", Icon = "rocket", Desc = "Main"}),
    ESPTab = Window:Tab({Title = "ESP", Icon = "", Desc = ""}),
    TeleportTab = Window:Tab({Title = "传送", Icon = "", Desc = ""}),
    HTab = Window:Tab({Title = "范围修改", Icon = "", Desc = ""}),
    SellTab = Window:Tab({Title = "出售", Icon = "", Desc = ""}),
    infTab = Window:Tab({Title = "无限子弹", Icon = "", Desc = ""}),
    ylTab = Window:Tab({Title = "彩蛋", Icon = "", Desc = "server"}),
    ServerTab = Window:Tab({Title = "服务器信息", Icon = "server", Desc = "Server"}),
}


local highlights, usernameLabels, playerEsp = {}, {}, false
local onlyOutline = false 


local function addHighlight(player)
    if player == Players.LocalPlayer then return end 

    local character = player.Character
    if character then
        
        local phighlight = Instance.new("Highlight")
        phighlight.Adornee = character
        phighlight.FillColor = Color3.new(1, 0, 0)
        phighlight.FillTransparency = 0.8
        phighlight.OutlineColor = Color3.new(1, 0, 0)
        phighlight.OutlineTransparency = 0
        phighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop 
        phighlight.Parent = character

        
        if onlyOutline then
            phighlight.FillTransparency = 1
        end

        
        highlights[player] = phighlight
    end
end


local function addUsernameLabel(player)
    if player == Players.LocalPlayer then return end 

    local character = player.Character
    if character then
        local head = character:FindFirstChild("Head")
        if head then
            
            local pbillboard = Instance.new("BillboardGui")
            pbillboard.Adornee = head
            pbillboard.Size = UDim2.new(0, 200, 0, 50)
            pbillboard.StudsOffset = Vector3.new(0, 3, 0) 
            pbillboard.AlwaysOnTop = true
            pbillboard.Parent = head

            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            if player.DisplayName == player.Name then label.Text = player.DisplayName else label.Text = player.DisplayName .. " (@" .. player.Name .. ")" end 
            label.TextColor3 = Color3.new(1, 1, 1) 
            label.BackgroundTransparency = 1 
            label.Font = Enum.Font.SourceSansBold
            label.TextSize = 21
            label.Parent = pbillboard

            
            usernameLabels[player] = pbillboard
        end
    end
end


local function removePlayerEffects(player)
    if highlights[player] then
        highlights[player]:Destroy()
        highlights[player] = nil
    end
    if usernameLabels[player] then
        usernameLabels[player]:Destroy()
        usernameLabels[player] = nil
    end
end


local function playeraddfunction()
    for _, player in ipairs(Players:GetPlayers()) do
        removePlayerEffects(player)
        addHighlight(player)
        addUsernameLabel(player)
        player.CharacterAdded:Connect(function(character)
            removePlayerEffects(player)
            addHighlight(player)
            addUsernameLabel(player)
            
            local humanoid = character:WaitForChild("Humanoid")
            
            humanoid.Died:Connect(function()
                if playerEsp then
                    removePlayerEffects(player)
                end
            end)
        end)
    end
end

Players.PlayerAdded:Connect(function(player)
    if playerEsp then
        playeraddfunction()
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removePlayerEffects(player)
end)


local Walk = 16
Tabs.MainTab:Input({Title = "速度设置", Default = "16", Callback = function(v) Walk = tonumber(v) or 16 end})

Tabs.MainTab:Toggle({Title = "速度开启", Callback = function(h)
    getgenv().h = h
    while h and wait() do
        if getgenv().h then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Walk end
    end
end})


local swimming = false
local oldgrav = workspace.Gravity
local swimbeat = nil
local gravReset = nil


local function startSwim()
    if not swimming and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") then
        oldgrav = workspace.Gravity
        workspace.Gravity = 0
        local swimDied = function()
            workspace.Gravity = oldgrav
            swimming = false
        end
        local Humanoid = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        gravReset = Humanoid.Died:Connect(swimDied)
        local enums = Enum.HumanoidStateType:GetEnumItems()
        table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
        for i, v in pairs(enums) do
            Humanoid:SetStateEnabled(v, false)
        end
        Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
        swimbeat = game:GetService("RunService").Heartbeat:Connect(function()
            pcall(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = ((Humanoid.MoveDirection ~= Vector3.new() or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space)) and game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity or Vector3.new())
            end)
        end)
        swimming = true
    end
end

local function stopSwim()
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") then
        workspace.Gravity = oldgrav
        swimming = false
        if gravReset then
            gravReset:Disconnect()
            gravReset = nil
        end
        if swimbeat ~= nil then
            swimbeat:Disconnect()
            swimbeat = nil
        end
        local Humanoid = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        local enums = Enum.HumanoidStateType:GetEnumItems()
        table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
        for i, v in pairs(enums) do
            Humanoid:SetStateEnabled(v, true)
        end
    end
end

Tabs.MainTab:Toggle({Title = "游泳式飞行",      Desc = "飞行速度是对应上面速度", Callback = function(Value)
    if Value then
        startSwim()
    else
        stopSwim()
    end
end})

Tabs.MainTab:Toggle({
    Title = "穿墙模式", 
    Callback = function(state)
        NoClipEnabled = state
        
        
        local RunService = game:GetService("RunService")
        local LocalPlayer = game.Players.LocalPlayer
        
        if state then
            
            if NoClipConnection then
                NoClipConnection:Disconnect()
                NoClipConnection = nil
            end
            
            
            local function setupNoClip(character)
                if not character then return end
                
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
            
            
            if LocalPlayer.Character then
                setupNoClip(LocalPlayer.Character)
            end
            
            
            NoClipConnection = RunService.Stepped:Connect(function()
                local character = LocalPlayer.Character
                if character then
                    for _, part in ipairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            
            
            local function onCharacterAdded(character)
                wait(0.5) 
                if NoClipEnabled and character then
                    setupNoClip(character)
                end
            end
            
            NoClipCharacterConnection = LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
            
        else
            
            if NoClipConnection then
                NoClipConnection:Disconnect()
                NoClipConnection = nil
            end
            
            if NoClipCharacterConnection then
                NoClipCharacterConnection:Disconnect()
                NoClipCharacterConnection = nil
            end
            
            
            local function restoreCollision(character)
                if not character then return end
                
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        
                        
                        if part.Name == "HumanoidRootPart" then
                            part.CanCollide = true
                        else
                            part.CanCollide = true
                        end
                    end
                end
            end
            
            if LocalPlayer.Character then
                restoreCollision(LocalPlayer.Character)
            end
        end
    end
})

Tabs.MainTab:Toggle({Title = "夜视", Callback = function(Value)
    local Lighting = game:GetService("Lighting")
    if Value then
        Lighting.Ambient = Color3.new(1,1,1); Lighting.Brightness = 2; Lighting.ClockTime = 14
        Lighting.FogEnd = 100000; Lighting.GlobalShadows = false
    else
        Lighting.Ambient = Color3.new(0,0,0)
    end
end})

Tabs.MainTab:Button({Title = "删除银行炮台伤害", Desc = "", Callback = function() local oldFireServer = game:GetService("ReplicatedStorage").Shared.Core.Network.FireServer
            game:GetService("ReplicatedStorage").Shared.Core.Network.FireServer = function(self, event, ...)
                if event == "registerLocalHit" and ... == "Turret" then
                    return nil
                end
                return oldFireServer(self, event, ...)
            end end})



local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local RootPart = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
local GizmoFolder = workspace.Local.Gizmos.White

local PatrolPoints = {
    Vector3.new(-1137, 78, -1953),
    Vector3.new(-44, 63, -2083),
    Vector3.new(194, 60, -2884),
    Vector3.new(-412, 106, -1301),
    Vector3.new(-377, 410, -741),
    Vector3.new(-985, 380, -1145),
    Vector3.new(-854, 406, -1505)
}

local IsRunning = false
local TimeElapsed = 0
local TimeoutThreshold = 30

local function ShowNotification(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5
        })
    end)
end

local function GetBasePart(instance)
    if instance:IsA("BasePart") then
        return instance
    end
    for _, descendant in ipairs(instance:GetDescendants()) do
        if descendant:IsA("BasePart") then
            return descendant
        end
    end
end

local function IsValidTarget(instance)
    local typeAttr = instance:GetAttribute("gizmoType")
    return typeAttr == "ATM" or typeAttr == "Register"
end

local function FindClosestTarget()
    local minDistance = math.huge
    local closestPart = nil
    
    for _, item in ipairs(GizmoFolder:GetChildren()) do
        if IsValidTarget(item) then
            local part = GetBasePart(item)
            if part then
                local dist = (RootPart.Position - part.Position).Magnitude
                if dist < minDistance then
                    closestPart = part
                    minDistance = dist
                end
            end
        end
    end
    return closestPart
end

local function TeleportTo(target)
    if typeof(target) ~= "Instance" then
        if typeof(target) == "Vector3" then
            RootPart.CFrame = CFrame.new(target)
        end
    else
        RootPart.CFrame = target.CFrame * CFrame.new(0, 5, 0)
    end
end

local function SpamInteract(duration)
    local start = tick()
    while tick() - start < duration do
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        task.wait(0.05)
    end
end

local function ProcessCollection(targetPart)
    local start = tick()
    local maxWait = 3
    while tick() - start < maxWait and (targetPart.Parent and not targetPart:GetAttribute("Collected")) do
        task.wait(0.1)
    end
    SpamInteract(1.5)
end


local function StartAutoFarm()
    IsRunning = true
    ShowNotification("自动打提款机", "已启动", 3)
    
    task.spawn(function()
        while IsRunning do
            local target = FindClosestTarget()
            if target then
                TeleportTo(target)
                task.wait(0.3)
                SpamInteract(1.5)
                ProcessCollection(target)
                TimeElapsed = 0
            else
                TimeElapsed = TimeElapsed + 0.7
                TeleportTo(PatrolPoints[math.random(1, #PatrolPoints)])
                
                if TimeoutThreshold <= TimeElapsed then
                    ShowNotification("未找到目标", "30秒未找到ATM，继续巡逻...", 3)
                    TimeElapsed = 0
                end
            end
            task.wait(0.7)
        end
    end)
end

local function StopAutoFarm()
    IsRunning = false
    ShowNotification("自动打提款机", "已停止", 3)
end


Tabs.MainTab:Toggle({Title = "自动打提款机", Callback = function(v)
    if v then
        StartAutoFarm()
    else
        StopAutoFarm()
    end
end})





Tabs.MainTab:Toggle({Title = "自动互动", Callback = function(v)
    getgenv().l = v
    while v and wait() do
        if getgenv().l then
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
        end
    end
end})

Tabs.ESPTab:Toggle({Title = "玩家透视", Callback = function(Value)
    playerEsp = Value
    if not Value then
        for _, player in ipairs(Players:GetPlayers()) do removePlayerEffects(player) end
        highlights, usernameLabels = {}, {}
    else
        for _, player in ipairs(Players:GetPlayers()) do playeraddfunction() end
    end
end})

Tabs.MainTab:Toggle({Title = "无限跳跃", Callback = function(Value)
    Jump = Value
    game.UserInputService.JumpRequest:Connect(function()
        if Jump then game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping") end
    end)
end})



Tabs.MainTab:Button({Title = "白天", Callback = function() setDay() end})


Tabs.ServerTab:Paragraph({Title = "服务器ID", Desc = game.JobId, Buttons = {{
    Title = "复制", Callback = function() setclipboard(game.JobId) end
}}})
Tabs.InfoTab:Paragraph({Title = "复制作者QQ号", Buttons = {{
    Title = "复制作者QQ号", Callback = function() setclipboard("2627272316") end
}}})
Tabs.InfoTab:Paragraph({Title = "复制QQ群", Buttons = {{
    Title = "复制QQ群", Callback = function() setclipboard("827283128") end
}}})
Tabs.ServerTab:Button({Title = "重进服务器", Callback = function() TeleportService:Teleport(game.PlaceId) end})

local JobIdInput = ""
Tabs.ServerTab:Input({Title = "输入服务器ID", Callback = function(v) JobIdInput = v end})
Tabs.ServerTab:Button({Title = "加入服务器ID", Callback = function()
    if JobIdInput and JobIdInput ~= "" then TeleportService:TeleportToPlaceInstance(game.PlaceId, JobIdInput) end
end})

local TeleportCFrames = {
    ["高级罪犯聚集地"] = CFrame.new(-7956.45947265625, 21.268028259277344, 1112.85693359375),
        ["黑市"] = CFrame.new(-2913.98876953125, 37.10328674316406, 1655.4158935546875),
                ["烈焰要塞"] = CFrame.new(-1484.169921875, 180.56239318847656, 3399.829833984375),
                       ["M4A1获取"] = CFrame.new(-6343.56689453125, 134.3800506591797, -4327.6962890625),
                                ["RPG获取"] = CFrame.new(-1382.1361083984375, 275.2096252441406, 3199.021240234375),
    ["银行--保险库"] = CFrame.new(-390.3414001464844, 615.2661743164062, -1210.03857421875)
}
for name, cframe in pairs(TeleportCFrames) do
    Tabs.TeleportTab:Button({Title = name, Callback = function()
        for i = 1, 10 do
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
        wait()
        end
    end})
end

Tabs.HTab:Button({Title = "范围", Callback = function() local v0=game:GetService("Players");local v1=game:GetService("RunService");local v2=v0.LocalPlayer;local v3=game:GetService("TweenService");local v4=Instance.new("ScreenGui");local v5=Instance.new("Frame");local v6=Instance.new("UICorner");local v7=Instance.new("TextBox");local v8=Instance.new("UICorner");local v9=Instance.new("TextButton");local v10=Instance.new("UICorner");local v11=Instance.new("TextButton");local v12=Instance.new("UICorner");local v13=false;v4.Parent=game.CoreGui;v5.Parent=v4;v7.Parent=v5;v9.Parent=v5;v11.Parent=v5;v6.Parent=v5;v8.Parent=v7;v10.Parent=v9;v12.Parent=v11;v5.Size=UDim2.new(1637 -(1523 + 114) ,144 + 16 ,0 -0 ,110);v5.Position=UDim2.new(0.5, -80,0.5, -(1120 -(68 + 997)));v5.BackgroundColor3=Color3.fromRGB(1320 -(226 + 1044) ,217 -167 ,167 -(32 + 85) );v5.BorderSizePixel=0 + 0 ;v5.Active=true;v5.Draggable=true;v5.ClipsDescendants=true;v5.BackgroundTransparency=0.2;v5.Visible=true;v6.CornerRadius=UDim.new(0,3 + 7 );v11.Size=UDim2.new(0,1117 -(892 + 65) ,0 -0 ,20);v11.Position=UDim2.new(0 -0 ,0,0,0 -0 );v11.Text="▼";v11.BackgroundColor3=Color3.fromRGB(430 -(87 + 263) ,260 -(67 + 113) ,59 + 21 );v11.TextColor3=Color3.fromRGB(255,626 -371 ,188 + 67 );v12.CornerRadius=UDim.new(0 -0 ,10);v7.Size=UDim2.new(952 -(802 + 150) ,376 -236 ,0 -0 ,19 + 6 );v7.Position=UDim2.new(997 -(915 + 82) ,10,0 -0 ,15 + 10 );v7.Text="10";v7.BackgroundColor3=Color3.fromRGB(92 -22 ,1257 -(1069 + 118) ,70);v7.TextColor3=Color3.fromRGB(578 -323 ,557 -302 ,45 + 210 );v8.CornerRadius=UDim.new(0 -0 ,10 + 0 );v9.Size=UDim2.new(791 -(368 + 423) ,439 -299 ,18 -(10 + 8) ,96 -71 );v9.Position=UDim2.new(442 -(416 + 26) ,31 -21 ,0 + 0 ,96 -41 );v9.Text="Enable Hitbox";v9.BackgroundColor3=Color3.fromRGB(528 -(145 + 293) ,520 -(44 + 386) ,90);v9.TextColor3=Color3.fromRGB(255,1741 -(998 + 488) ,82 + 173 );v10.CornerRadius=UDim.new(0 + 0 ,782 -(201 + 571) );_G.HeadSize=tonumber(v7.Text) or (1148 -(116 + 1022)) ;_G.Disabled=true;local v52={};local function v53() local v54=0 -0 ;while true do if (v54==0) then v52={};for v66,v67 in ipairs(v0:GetPlayers()) do if ((v67~=v2) and v67.Character and v67.Character:FindFirstChild("HumanoidRootPart")) then table.insert(v52,v67);end end break;end end end v7.FocusLost:Connect(function() local v55=0 + 0 ;local v56;while true do if (v55==0) then v56=tonumber(v7.Text);if v56 then _G.HeadSize=v56;else v7.Text=tostring(_G.HeadSize);end break;end end end);v9.MouseButton1Click:Connect(function() local v57=0 -0 ;while true do if (v57==1) then if _G.Disabled then for v71,v72 in ipairs(v52) do if (v72.Character and v72.Character:FindFirstChild("HumanoidRootPart")) then local v73=v72.Character.HumanoidRootPart;v73.Size=Vector3.new(7 -5 ,2,860 -(814 + 45) );v73.Transparency=0;v73.BrickColor=BrickColor.new("Medium stone grey");v73.Material=Enum.Material.Plastic;v73.CanCollide=true;end end end break;end if (v57==0) then _G.Disabled= not _G.Disabled;v9.Text=(_G.Disabled and "Enable Hitbox") or "Disable Hitbox" ;v57=2 -1 ;end end end);v11.MouseButton1Click:Connect(function() local v58=0;local v59;local v60;local v61;while true do if (v58==(1 + 0)) then v60=TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out);v61=v3:Create(v5,v60,{Size=v59});v58=2;end if (v58==(887 -(261 + 624))) then v61:Play();v11.Text=(v13 and "▲") or "▼" ;break;end if (v58==(0 -0)) then v13= not v13;v59=(v13 and UDim2.new(1080 -(1020 + 60) ,160,1423 -(630 + 793) ,20)) or UDim2.new(0 -0 ,757 -597 ,0,44 + 66 ) ;v58=3 -2 ;end end end);v1.RenderStepped:Connect(function() if  not _G.Disabled then for v64,v65 in ipairs(v52) do if (v65.Character and v65.Character:FindFirstChild("HumanoidRootPart")) then local v69=1747 -(760 + 987) ;local v70;while true do if (v69==(1914 -(1789 + 124))) then v70.Transparency=766.7 -(745 + 21) ;v70.BrickColor=BrickColor.new("Really blue");v69=2;end if ((1 + 1)==v69) then v70.Material=Enum.Material.Neon;v70.CanCollide=false;break;end if (v69==0) then v70=v65.Character.HumanoidRootPart;v70.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize);v69=2 -1 ;end end end end end end);while true do v53();wait(3 -2 );end end})

Tabs.ylTab:Button({Title = "小游戏", Desc = "跳200个障碍联系作者有奖励", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Snake-Run-78433"))() end})

Tabs.SellTab:Button({Title = "快捷出售", Callback = function() for _, a in ipairs(game:GetService("ReplicatedStorage").Shared.Core.Network:GetChildren()) do
                            if a:IsA("RemoteFunction") or a:IsA("RemoteEvent") then
                                if not a.Name:find("moveHouse") and not a.Name:find("House") then
                                    pcall(function()
                                        a:InvokeServer()
                                    end)
                                end
                            end
                            if not AutoSell then
                                break
                            end
                        end end})

Tabs.SellTab:Button({Title = "自动出售", Desc = "靠近黑市商人才行", Callback = function() for _, a in ipairs(game:GetService("ReplicatedStorage").Shared.Core.Network:GetChildren()) do
    if a:IsA("RemoteFunction") or a:IsA("RemoteEvent") then
        if not a.Name:find("moveHouse") and not a.Name:find("House") then
            pcall(function()
                a:InvokeServer()
            end)
        end
    end
end end})


Tabs.infTab:Button({Title = "无限子弹", Desc = "", Callback = function() local originalUpdateAmmo = nil
for _, v in pairs(getgc(true)) do
    if type(v) == "table" and rawget(v, "UpdateAmmo") then
        originalUpdateAmmo = v.UpdateAmmo
        break
    end
end
local function hookedUpdateAmmo(self, current, total)
    local newCurrent = 78
    local newTotal = 91
    if originalUpdateAmmo then
        originalUpdateAmmo(self, newCurrent, newTotal)
    end
end
if originalUpdateAmmo then
    for _, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "UpdateAmmo") then
            v.UpdateAmmo = hookedUpdateAmmo
        end
    end
end

print("大司马给制作") end})

Tabs.infTab:Button({Title = "无后座", Desc = "", Callback = function() local Shooter = require(game:GetService("ReplicatedStorage").Client.Wanted.Objects.ClientTool.Components.Guns.Shooter)
            local originalShoot = Shooter._shoot
            Shooter._shoot = function(self)
                self.recoil = {firstShotKick = 0, climb = 0, spread = 0}
                return originalShoot(self)
            end
  end})