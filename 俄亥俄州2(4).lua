local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/157nb/qie/refs/heads/main/fuck157"))()

local Window = WindUI:CreateWindow({
    Title = "大司马脚本 俄亥俄州",
    Author = "大司马",
    Theme = "Dark",
    Size = UDim2.new(0, 350, 0, 250),
    Transparent = true,
    HasOutline = true,
    SideBarWidth = 200,
    Folder = "WindUIConfig"
})

Window:EditOpenButton({
    Title = "大司马脚本 俄亥俄州",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
    Color3.fromHex("F1F8E9"),  
    Color3.fromHex("81C784")  
    ),
    Draggable = true,
})



local K = Window:Tab({Title = "战斗", Icon = "skull"})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local localPlayer = Players.LocalPlayer

local autoKillSettings = {
    isEnabled = false,
    range = 100
}

local activeBeams = {}
local lastShootTime = 0
local lastReloadTime = 0
local shootInterval = 0.05
local reloadInterval = 3 

local function hasShield(character)
    if not character then return false end
    local shield = character:FindFirstChild("Shield") or character:FindFirstChild("ForceField")
    return shield ~= nil
end

local function isPlayerAlive(character)
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health > 0
end

local function purchaseAmmo(weaponName)
    pcall(function()
        require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchaseAmmo", weaponName)
    end)
end

local function createBeamEffect(startPos, endPos)
    local beam = Instance.new("Part")
    beam.Name = "KillBeam"
    beam.Anchored = true
    beam.CanCollide = false
    beam.CastShadow = false
    beam.Transparency = 0.2
    beam.Material = Enum.Material.Neon
    beam.Color = Color3.fromRGB(255, 0, 0)
    
    local direction = (endPos - startPos)
    local distance = direction.Magnitude
    
    beam.Size = Vector3.new(0.3, 0.3, distance)
    beam.CFrame = CFrame.lookAt(startPos, endPos) * CFrame.new(0, 0, -distance/2)
    
    local startGlow = Instance.new("Part")
    startGlow.Name = "StartGlow"
    startGlow.Anchored = true
    startGlow.CanCollide = false
    startGlow.Shape = Enum.PartType.Ball
    startGlow.Size = Vector3.new(1.2, 1.2, 1.2)
    startGlow.Color = Color3.fromRGB(255, 50, 50)
    startGlow.Material = Enum.Material.Neon
    startGlow.Transparency = 0.1
    startGlow.Position = startPos
    startGlow.Parent = beam
    
    local endGlow = startGlow:Clone()
    endGlow.Name = "EndGlow"
    endGlow.Position = endPos
    endGlow.Parent = beam
    
    local innerBeam = Instance.new("Part")
    innerBeam.Name = "InnerBeam"
    innerBeam.Anchored = true
    innerBeam.CanCollide = false
    innerBeam.Transparency = 0.1
    innerBeam.Material = Enum.Material.Neon
    innerBeam.Color = Color3.fromRGB(255, 100, 100)
    innerBeam.Size = Vector3.new(0.2, 0.2, distance)
    innerBeam.CFrame = beam.CFrame
    innerBeam.Parent = beam
    
    local pointLight = Instance.new("PointLight")
    pointLight.Brightness = 6
    pointLight.Range = 12
    pointLight.Color = Color3.fromRGB(255, 0, 0)
    pointLight.Parent = startGlow
    
    local pointLight2 = pointLight:Clone()
    pointLight2.Parent = endGlow
    
    beam.Parent = Workspace
    
    local beamInfo = {
        beam = beam,
        startTime = tick(),
        endTime = tick() + 0.3
    }
    
    table.insert(activeBeams, beamInfo)
    
    delay(0.3, function()
        if beam and beam.Parent then
            local fadeTween = TweenService:Create(beam, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1})
            fadeTween:Play()
            fadeTween.Completed:Connect(function()
                if beam and beam.Parent then
                    beam:Destroy()
                end
            end)
        end
    end)
    
    return beam
end

local function updateBeams()
    local currentTime = tick()
    local beamsToRemove = {}
    
    for i, beamInfo in ipairs(activeBeams) do
        if currentTime >= beamInfo.endTime then
            table.insert(beamsToRemove, i)
        end
    end
    
    for i = #beamsToRemove, 1, -1 do
        local index = beamsToRemove[i]
        local beamInfo = activeBeams[index]
        if beamInfo.beam and beamInfo.beam.Parent then
            beamInfo.beam:Destroy()
        end
        table.remove(activeBeams, index)
    end
end

local function isInRange(position1, position2)
    return (position1 - position2).Magnitude <= autoKillSettings.range
end

local function getShootingInfo()
    local success, reloadFunc = pcall(function()
        return getupvalue(require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item.bin.Gun.modules.controller.modules.reload), 2)
    end)
    
    if not success then return nil end
    
    local success2, t = pcall(function()
        return getupvalue(require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item.bin.Gun.modules.controller.modules.shoot), 1)
    end)
    
    if success2 and t and t.item then
        return {
            reload = reloadFunc,
            ammo = t.item.ammoManager,
            gunid = t.item.guid,
            firemode = t.item.firemode,
            weaponName = t.item.name
        }
    end
    return nil
end

local function autoReload(shootingInfo, forceReload)
    if not shootingInfo then return end
    
    local currentTime = tick()
    
    if forceReload or (currentTime - lastReloadTime >= reloadInterval) then
        local reloadEvent = ReplicatedStorage.devv.remoteStorage:FindFirstChild("reload")
        if reloadEvent and shootingInfo.reload then
            purchaseAmmo(shootingInfo.weaponName)
            firesignal(reloadEvent.OnClientEvent, shootingInfo.gunid, 0, shootingInfo.ammo.ammoOut)
            shootingInfo.reload()
            lastReloadTime = currentTime
        end
    end
end

local function getAlivePlayersInRange()
    local localCharacter = localPlayer.Character
    local localRootPart = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
    if not localRootPart then return {} end
    
    local targets = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and humanoid.Health > 0 and humanoidRootPart and not hasShield(character) then
                if isInRange(localRootPart.Position, humanoidRootPart.Position) then
                    table.insert(targets, {
                        player = player,
                        character = character,
                        rootPart = humanoidRootPart
                    })
                end
            end
        end
    end
    
    return targets
end

local function shootAtPlayer(targetData, shootingInfo, rightArm)
    if not shootingInfo or not targetData or not rightArm then return false end
    
    if shootingInfo.ammo.ammo <= 0 then
        autoReload(shootingInfo, true)
        return false
    end
    
    local targetParts = {
        targetData.character:FindFirstChild("Head"),
        targetData.character:FindFirstChild("UpperTorso"),
        targetData.character:FindFirstChild("HumanoidRootPart")
    }
    
    local Event1 = ReplicatedStorage.devv.remoteStorage:FindFirstChild("replicateProjectiles")
    local Event2 = ReplicatedStorage.devv.remoteStorage:FindFirstChild("projectileHit")
    
    if not Event1 or not Event2 then return false end
    
    for _, targetPart in ipairs(targetParts) do
        if targetPart and shootingInfo.ammo.ammo > 0 and isPlayerAlive(targetData.character) then
            local startPos = rightArm.Position
            createBeamEffect(startPos, targetPart.Position)
            
            Event1:FireServer(shootingInfo.gunid, {{"TrackingBullet", targetPart.CFrame}}, shootingInfo.firemode)
            Event2:FireServer("TrackingBullet", "player", {
                hitPart = targetPart,
                hitPlayerId = targetData.player.UserId,
                hitSize = targetPart.Size,
                pos = targetPart.Position
            })
            shootingInfo.ammo.ammo = shootingInfo.ammo.ammo - 1
            return true
        end
    end
    
    return false
end

local function autoKillAll()
    if not autoKillSettings.isEnabled then return end
    
    local currentTime = tick()
    if currentTime - lastShootTime < shootInterval then return end
    
    local targets = getAlivePlayersInRange()
    if #targets == 0 then return end
    
    local shootingInfo = getShootingInfo()
    if not shootingInfo then
        autoReload(shootingInfo, true)
        return
    end
    
    local localCharacter = localPlayer.Character
    if not localCharacter then return end
    
    local rightArm = localCharacter:FindFirstChild("RightHand")
    if not rightArm then return end
    
    for _, targetData in ipairs(targets) do
        if isPlayerAlive(targetData.character) and not hasShield(targetData.character) then
            if shootingInfo.ammo.ammo <= 0 then
                autoReload(shootingInfo, true)
                shootingInfo = getShootingInfo()
                if not shootingInfo then break end
            end
            
            local shotFired = shootAtPlayer(targetData, shootingInfo, rightArm)
            if shotFired then
                lastShootTime = currentTime
            end
        end
    end
end

local autoKillConnection
local beamUpdateConnection

local function toggleAutoKill(isEnabled)
    autoKillSettings.isEnabled = isEnabled
    if isEnabled then
        if autoKillConnection then
            autoKillConnection:Disconnect()
        end
        autoKillConnection = RunService.Heartbeat:Connect(autoKillAll)
        
        if beamUpdateConnection then
            beamUpdateConnection:Disconnect()
        end
        beamUpdateConnection = RunService.Heartbeat:Connect(updateBeams)
        
        lastReloadTime = tick()  -- 初始化换弹时间
    else
        if autoKillConnection then
            autoKillConnection:Disconnect()
            autoKillConnection = nil
        end
        
        if beamUpdateConnection then
            beamUpdateConnection:Disconnect()
            beamUpdateConnection = nil
        end
        
        for _, beamInfo in ipairs(activeBeams) do
            if beamInfo.beam and beamInfo.beam.Parent then
                beamInfo.beam:Destroy()
            end
        end
        activeBeams = {}
    end
end

K:Toggle({
    Title = "枪械杀戮光环[轨道]",
    Value = false,
    Callback = toggleAutoKill
})



local Signal = require(game:GetService("ReplicatedStorage").devv).load("Signal")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local b1 = require(game:GetService('ReplicatedStorage').devv).load('v3item').inventory.items
local autokill = false
local autostomp = false
local grabplay = false
local autoFists = false
local hitMOD = "meleepunch"
local function equipFists()
    for i, v in next, b1 do 
        if v.name == 'Fists' then 
            Signal.FireServer("equip", v.guid)
            break
        end
    end
end

-- 杀戮光环
local function killAura()
    local character = localPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local targetChar = player.Character
            local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                local distance = (rootPart.Position - targetHRP.Position).Magnitude
                if distance <= 35 then
                    local uid = player.UserId
                    Signal.FireServer("meleeAttackHit", "player", { 
                        meleeType = hitMOD, 
                        hitPlayerId = uid 
                    })
                end
            end
        end
    end
end

-- 踩踏光环
local function stompAura()
    local character = localPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local targetChar = player.Character
            local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = targetChar:FindFirstChild("Humanoid")
            if targetHRP and targetHumanoid and targetHumanoid.Health < 20 then
                local distance = (rootPart.Position - targetHRP.Position).Magnitude
                if distance <= 40 then
                    Signal.FireServer("finish", player)
                end
            end
        end
    end
end

-- 抓取光环
local function grabAura()
    local character = localPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local targetChar = player.Character
            local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = targetChar:FindFirstChild("Humanoid")
            if targetHRP and targetHumanoid and targetHumanoid.Health < 20 then
                local distance = (rootPart.Position - targetHRP.Position).Magnitude
                if distance <= 40 then
                    Signal.FireServer("grabPlayer", player)
                end
            end
        end
    end
end
game:GetService("RunService").Heartbeat:Connect(function()
    if autokill then
        killAura()
    end
    
    if autostomp then
        stompAura()
    end
    
    if grabplay then
        grabAura()
    end
    
    if autoFists then
        equipFists()
    end
end)
K:Dropdown({
    Title = "选择攻击模式",
    Values = { "一拳", "普通拳", "踢击", "宇将军飞踢"},
    Callback = function(Value) 
        if Value == "一拳" then
            hitMOD = "meleemegapunch"
        elseif Value == "普通拳" then
            hitMOD = "meleepunch"
        elseif Value == "踢击" then
            hitMOD = "meleekick"
        elseif Value == "宇将军飞踢" then
            hitMOD = "meleejumpKick"
        end
    end
})

K:Toggle({
    Title = "自动装备拳头",
    Value = false,
    Callback = function(state) 
        autoFists = state
    end
})

K:Toggle({
    Title = "杀戮光环",
    Value = false,
    Callback = function(state) 
        autokill = state
    end
})

K:Toggle({
    Title = "踩踏光环",
    Value = false,
    Callback = function(state) 
        autostomp = state
    end
})

K:Toggle({
    Title = "抓取光环",
    Value = false,
    Callback = function(state) 
        grabplay = state
    end
})
K:Toggle({
    Title = "自动穿甲",
    Default = false,
    Callback = function(Value)
        AutoArmor = Value
        if Value then
            local heartbeat = game:GetService("RunService").Heartbeat
            local connection
            connection = heartbeat:Connect(function()
                if not AutoArmor then
                    connection:Disconnect()
                    return
                end
                
                pcall(function()
                    local player = game:GetService('Players').LocalPlayer
                    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health > 35 then
                        local b1 = require(game:GetService('ReplicatedStorage').devv).load('v3item').inventory.items
                        local hasLightVest = false
                        
                        for i, v in next, b1 do
                            if v.name == "Light Vest" then
                                hasLightVest = true
                                light = v.guid
                                local armor = player:GetAttribute('armor')
                                if armor == nil or armor <= 0 then
                                    require(game:GetService("ReplicatedStorage").devv).load("Signal").FireServer("equip", light)
                                    require(game:GetService("ReplicatedStorage").devv).load("Signal").FireServer("useConsumable", light)
                                    require(game:GetService("ReplicatedStorage").devv).load("Signal").FireServer("removeItem", light)
                                end
                                break
                            end
                        end
                        
                        if not hasLightVest then
                            require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchase", "Light Vest")
                        end
                    end
                end)
            end)
        end
    end
})
K:Toggle({
    Title = "自动口罩",
    --Image = "bird",
    Value = false,
    Callback = function(state) 
    autokz = state
    if autokz then
    while autokz and wait(1) do
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local Mask = character:FindFirstChild("Surgeon Mask")
local Signal = require(game:GetService("ReplicatedStorage").devv).load("Signal")
local b1 = require(game:GetService('ReplicatedStorage').devv).load('v3item').inventory.items
if not Mask then
Signal.InvokeServer("attemptPurchase", "Surgeon Mask")
for i, v in next, b1 do
if v.name == "Surgeon Mask" then
sugid = v.guid
if not Mask then
Signal.FireServer("equip", sugid)
Signal.FireServer("wearMask", sugid)
end
break
end
end
end
end
end
    end
})
K:Toggle({
    Title = "自动回血",
    Default = false,
    Callback = function(Value)
        if healThread then
            healThread:Disconnect()
            healThread = nil
        end

        if Value then
            local heartbeat = game:GetService("RunService").Heartbeat
            healThread = heartbeat:Connect(function()
                Signal.InvokeServer("attemptPurchase", 'Bandage')
                for _, v in next, item.inventory.items do
                    if v.name == 'Bandage' then
                        local bande = v.guid
                        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                        local Humanoid = Character:WaitForChild('Humanoid')
                        if Humanoid.Health >= 5 and Humanoid.Health < Humanoid.MaxHealth then
                            Signal.FireServer("equip", bande)
                            Signal.FireServer("useConsumable", bande)
                            Signal.FireServer("removeItem", bande)
                        end
                        break
                    end
                end
            end)
        end
    end
})
local melee = require(game:GetService("ReplicatedStorage").devv).load("ClientReplicator")
local lp = game:GetService("Players").LocalPlayer
local AutoKnockReset = false
K:Toggle({
    Title = "防倒地",
    Default = false,
    Callback = function(Value)
        AutoKnockReset = Value
        if Value then
            task.spawn(function()
                while AutoKnockReset do
                    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                        melee.Set(lp, "knocked", false)
                        melee.Replicate("knocked")
                    end
                    wait()
                end
            end)
        end
    end
})
K:Button({
    Title = "变身警察",
    Callback = function()
        local function fastInteractProximityPrompt(proximityPrompt)
    if not proximityPrompt or not proximityPrompt:IsA("ProximityPrompt") then
        return false
    end
    
  
    local originalRequiresLineOfSight = proximityPrompt.RequiresLineOfSight
    local originalHoldDuration = proximityPrompt.HoldDuration
    
    
    proximityPrompt.RequiresLineOfSight = false
    proximityPrompt.HoldDuration = 0
    
   
    for i = 1, 5 do
        fireproximityprompt(proximityPrompt)
        task.wait(0.01)
    end
    
   
    proximityPrompt.RequiresLineOfSight = originalRequiresLineOfSight
    proximityPrompt.HoldDuration = originalHoldDuration
    
    return true
end

local function interactAtPosition(position)
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local character = localPlayer.Character
    if not character then return false end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    
   
    local originalPosition = rootPart.CFrame
    
    rootPart.CFrame = CFrame.new(position)
    task.wait(0.2) 
    
    local closestPrompt = nil
    local closestDistance = math.huge
    
    for _, prompt in pairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            local promptParent = prompt.Parent
            if promptParent and (promptParent:IsA("MeshPart") or promptParent:IsA("Part")) then
                local distance = (rootPart.Position - promptParent.Position).Magnitude
                
                if distance < closestDistance then
                    closestDistance = distance
                    closestPrompt = prompt
                end
            end
        end
    end
    
    local interacted = false
    if closestPrompt then
        interacted = fastInteractProximityPrompt(closestPrompt)
    end
    rootPart.CFrame = originalPosition
    
    return interacted
end
interactAtPosition(Vector3.new(580.19, 26.67, -873.15))
interactAtPosition(Vector3.new(587.30, 26.66, -871.14))

    end
})

local Main = Window:Tab({Title = "枪锁人", Icon = "target"})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local localPlayer = Players.LocalPlayer

local autoFireSettings = {
    targetPlayer = nil,
    isAutoFiring = false,
    ignoreShield = true,
    fireMode = "全部",
    bulletCount = {min = 1, max = 3},
    autoReload = false,
    autoEquip = false,
    selectedWeapon = "AK-47",
    beamType = "彩虹",  
    beamColor = Color3.new(1, 0, 0) 
}

local weaponOptions = {"AK-47", "M4A1", "M249", "Minigun", "Deagle", "RPG", "Raygun", "M1911"}
local beamOptions = {"彩虹", "红色", "黄色", "绿色", "黑色"}
local beamColors = {
    ["彩虹"] = Color3.new(1, 0, 0),
    ["红色"] = Color3.new(1, 0, 0),
    ["黄色"] = Color3.new(1, 1, 0),
    ["绿色"] = Color3.new(0, 1, 0),
    ["黑色"] = Color3.new(0.1, 0.1, 0.1)
}

local playerList = {"无"}
local selectedPlayer = "无"
local dropdownRef = nil

local activeBeams = {}
local rainbowHue = 0  

local function getPlayerDisplayName(player)
    if player.DisplayName ~= player.Name then
        return player.DisplayName .. " (@" .. player.Name .. ")"
    else
        return player.Name
    end
end

local function updatePlayerList()
    local currentPlayers = Players:GetPlayers()
    local newPlayerList = {"无"}
    for _, player in ipairs(currentPlayers) do
        if player ~= localPlayer then
            table.insert(newPlayerList, getPlayerDisplayName(player))
        end
    end
    playerList = newPlayerList
    if dropdownRef then
        dropdownRef:Refresh(playerList, true)
    end
end

local function hasShield(character)
    if not character or not autoFireSettings.ignoreShield then return false end
    local shield = character:FindFirstChild("Shield") or character:FindFirstChild("ForceField")
    return shield ~= nil
end

local function autoEquipSelectedWeapon()
    local inventory = require(game:GetService("ReplicatedStorage").devv).load("v3item").inventory
    local weaponItem = inventory.getFromName(autoFireSettings.selectedWeapon)
    
    if weaponItem then
        inventory.setEquipped(weaponItem.guid)
        return true
    else
        pcall(function()
            require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchase", autoFireSettings.selectedWeapon)
        end)
        return false
    end
end

local function purchaseAmmo()
    local ammoType = autoFireSettings.selectedWeapon
    require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchaseAmmo", ammoType)
end

local function getCurrentBeamColor()
    if autoFireSettings.beamType == "彩虹" then
        rainbowHue = (rainbowHue + 0.01) % 1
        return Color3.fromHSV(rainbowHue, 1, 1)
    else
        return beamColors[autoFireSettings.beamType]
    end
end

local function createBeamEffect(startPos, endPos, targetPart)
    local currentColor = getCurrentBeamColor()
    
    local beam = Instance.new("Part")
    beam.Name = "BeamCenter"
    beam.Anchored = true
    beam.CanCollide = false
    beam.CastShadow = false
    beam.Transparency = 0.2
    beam.Material = Enum.Material.Neon
    beam.Color = currentColor
    
    local direction = (endPos - startPos)
    local distance = direction.Magnitude
    
    beam.Size = Vector3.new(0.3, 0.3, distance)
    beam.CFrame = CFrame.lookAt(startPos, endPos) * CFrame.new(0, 0, -distance/2)
    
    local circleCount = 8
    local circleRadius = 0.5
    local beams = {beam}
    
    for i = 1, circleCount do
        local angle = (i / circleCount) * math.pi * 2
        local offset = Vector3.new(
            math.cos(angle) * circleRadius,
            math.sin(angle) * circleRadius,
            0
        )
        
        local rotatedOffset = CFrame.lookAt(startPos, endPos):VectorToWorldSpace(offset)
        local circleBeam = Instance.new("Part")
        circleBeam.Name = "CircleBeam_" .. i
        circleBeam.Anchored = true
        circleBeam.CanCollide = false
        circleBeam.CastShadow = false
        circleBeam.Transparency = 0.3
        circleBeam.Material = Enum.Material.Neon
        circleBeam.Color = currentColor:Lerp(Color3.new(1, 1, 1), 0.3)
        circleBeam.Size = Vector3.new(0.15, 0.15, distance)
        
        local circleStart = startPos + rotatedOffset
        local circleEnd = endPos + rotatedOffset
        circleBeam.CFrame = CFrame.lookAt(circleStart, circleEnd) * CFrame.new(0, 0, -distance/2)
        
        local connection = Instance.new("Part")
        connection.Name = "Connection_" .. i
        connection.Anchored = true
        connection.CanCollide = false
        connection.Transparency = 0.4
        connection.Material = Enum.Material.Neon
        connection.Color = currentColor
        connection.Size = Vector3.new(0.1, 0.1, (circleStart - startPos).Magnitude)
        connection.CFrame = CFrame.lookAt(startPos, circleStart) * CFrame.new(0, 0, -(circleStart - startPos).Magnitude/2)
        
        circleBeam.Parent = beam
        connection.Parent = beam
        table.insert(beams, circleBeam)
        table.insert(beams, connection)
    end
    
    local pulseRing = Instance.new("Part")
    pulseRing.Name = "PulseRing"
    pulseRing.Anchored = true
    pulseRing.CanCollide = false
    pulseRing.Shape = Enum.PartType.Cylinder
    pulseRing.Size = Vector3.new(0.1, 2, 2)
    pulseRing.Transparency = 0.3
    pulseRing.Material = Enum.Material.Neon
    pulseRing.Color = currentColor
    pulseRing.CFrame = CFrame.lookAt(startPos, endPos) * CFrame.Angles(0, 0, math.rad(90))
    pulseRing.Parent = beam
    
    local startSphere = Instance.new("Part")
    startSphere.Name = "StartSphere"
    startSphere.Anchored = true
    startSphere.CanCollide = false
    startSphere.Shape = Enum.PartType.Ball
    startSphere.Size = Vector3.new(1.5, 1.5, 1.5)
    startSphere.Transparency = 0.1
    startSphere.Material = Enum.Material.Neon
    startSphere.Color = currentColor
    startSphere.Position = startPos
    startSphere.Parent = beam
    
    local endSphere = startSphere:Clone()
    endSphere.Name = "EndSphere"
    endSphere.Position = endPos
    endSphere.Parent = beam
    
    local startLight = Instance.new("PointLight")
    startLight.Brightness = 8
    startLight.Range = 15
    startLight.Color = currentColor
    startLight.Parent = startSphere
    
    local endLight = startLight:Clone()
    endLight.Parent = endSphere
    
    local innerGlow = Instance.new("SurfaceLight")
    innerGlow.Brightness = 3
    innerGlow.Range = 20
    innerGlow.Color = currentColor
    innerGlow.Face = Enum.NormalId.Front
    innerGlow.Angle = 180
    innerGlow.Parent = beam
    
    local trailingGlow = Instance.new("SurfaceLight")
    trailingGlow.Brightness = 2
    trailingGlow.Range = 15
    trailingGlow.Color = currentColor
    trailingGlow.Face = Enum.NormalId.Back
    trailingGlow.Angle = 180
    trailingGlow.Parent = beam
    
    beam.Parent = Workspace
    
    local beamInfo = {
        beam = beam,
        beams = beams,
        pulseRing = pulseRing,
        startSphere = startSphere,
        endSphere = endSphere,
        startTime = tick(),
        endTime = tick() + 2.5,
        targetPart = targetPart
    }
    
    table.insert(activeBeams, beamInfo)
    
    local pulseTween = TweenService:Create(pulseRing, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true, 0), {
        Size = Vector3.new(0.05, 4, 4)
    })
    pulseTween:Play()
    
    return beam
end

local function updateBeams()
    local currentTime = tick()
    local beamsToRemove = {}
    
    for i, beamInfo in ipairs(activeBeams) do
        if currentTime >= beamInfo.endTime then
            table.insert(beamsToRemove, i)
        else
            local elapsed = currentTime - beamInfo.startTime
            local duration = beamInfo.endTime - beamInfo.startTime
            local fadeProgress = elapsed / duration
            local alpha = 1 - fadeProgress
            
            if autoFireSettings.beamType == "彩虹" then
                local rainbowColor = Color3.fromHSV(rainbowHue + (i * 0.1) % 1, 1, 1)
                if beamInfo.beam then
                    beamInfo.beam.Color = rainbowColor
                end
                if beamInfo.startSphere then
                    beamInfo.startSphere.Color = rainbowColor
                end
                if beamInfo.endSphere then
                    beamInfo.endSphere.Color = rainbowColor
                end
            end
            
            local transparency = 0.2 + (0.8 * fadeProgress)
            if beamInfo.beam then
                beamInfo.beam.Transparency = transparency
            end
            if beamInfo.startSphere then
                beamInfo.startSphere.Transparency = 0.1 + (0.9 * fadeProgress)
            end
            if beamInfo.endSphere then
                endSphere.Transparency = 0.1 + (0.9 * fadeProgress)
            end
            
            if beamInfo.beams then
                for _, subBeam in ipairs(beamInfo.beams) do
                    if subBeam and subBeam.Parent then
                        subBeam.Transparency = transparency + 0.1
                    end
                end
            end
        end
    end
    
    for i = #beamsToRemove, 1, -1 do
        local index = beamsToRemove[i]
        local beamInfo = activeBeams[index]
        if beamInfo.beam then
            beamInfo.beam:Destroy()
        end
        table.remove(activeBeams, index)
    end
end

local function getValidTarget()
    if autoFireSettings.fireMode == "单锁" and autoFireSettings.targetPlayer then
        local targetPlayer = autoFireSettings.targetPlayer
        if targetPlayer.Character and not hasShield(targetPlayer.Character) then
            local character = targetPlayer.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and humanoid.Health > 0 and humanoidRootPart then
                return {
                    player = targetPlayer,
                    character = character,
                    rootPart = humanoidRootPart
                }
            end
        end
    elseif autoFireSettings.fireMode == "全部" then
        local localCharacter = localPlayer.Character
        local localRootPart = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
        
        if localRootPart then
            local targets = {}
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= localPlayer and player.Character and not hasShield(player.Character) then
                    local character = player.Character
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    
                    if humanoid and humanoid.Health > 0 and humanoidRootPart then
                        table.insert(targets, {
                            player = player,
                            character = character,
                            rootPart = humanoidRootPart
                        })
                    end
                end
            end
            
            if #targets > 0 then
                return targets[1]
            end
        end
    end
    
    return nil
end

local function autoFire()
    if not autoFireSettings.isAutoFiring then return end
    
    if autoFireSettings.autoEquip then
        pcall(autoEquipSelectedWeapon)
        pcall(purchaseAmmo)
    end
    
    local reload = getupvalue(require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item.bin.Gun.modules.controller.modules.reload), 2)
    local t = getupvalue(require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item.bin.Gun.modules.controller.modules.shoot), 1)
    local reloadEvent = ReplicatedStorage.devv.remoteStorage:FindFirstChild("reload")
    
    local ammo = t.item.ammoManager
    local gunid = t.item.guid
    local firemode = t.item.firemode
    
    if autoFireSettings.autoReload and ammo.ammo <= 0 then
        firesignal(reloadEvent.OnClientEvent, gunid, 0, ammo.ammoOut)
        reload()
        return
    end
    
    local targetData = getValidTarget()
    if not targetData then return end
    
    local Event1 = ReplicatedStorage.devv.remoteStorage:FindFirstChild("replicateProjectiles")
    local Event2 = ReplicatedStorage.devv.remoteStorage:FindFirstChild("projectileHit")
    
    if not Event1 or not Event2 then return end
    
    local localCharacter = localPlayer.Character
    local rightArm = localCharacter and localCharacter:FindFirstChild("RightHand")
    if not rightArm then return end
    
    local bulletCount = autoFireSettings.fireMode == "全部" and autoFireSettings.bulletCount.max or autoFireSettings.bulletCount.min
    
    for i = 1, bulletCount do
        if not autoFireSettings.autoReload and ammo.ammo <= 0 then 
            break 
        end
        
        local targetCharacter = targetData.character
        local targetPart = targetCharacter:FindFirstChild("Head") or 
                          targetCharacter:FindFirstChild("UpperTorso") or 
                          targetCharacter:FindFirstChild("HumanoidRootPart")
        
        if targetPart then
            local startPos = rightArm.Position
            createBeamEffect(startPos, targetPart.Position, targetPart)
            
            Event1:FireServer(gunid, {{"TrackingBullet", targetPart.CFrame}}, firemode)
            Event2:FireServer("TrackingBullet", "player", {
                hitPart = targetPart,
                hitPlayerId = targetData.player.UserId,
                hitSize = targetPart.Size,
                pos = targetPart.Position
            })
            ammo.ammo = ammo.ammo - 1
        end
        
        if not autoFireSettings.autoReload and ammo.ammo <= 0 then 
            break 
        end
    end
    
    if autoFireSettings.autoReload and ammo.ammo <= 0 then
        firesignal(reloadEvent.OnClientEvent, gunid, 0, ammo.ammoOut)
        reload()
    end
end

local autoFireConnection
local beamUpdateConnection

local function toggleAutoFire(isEnabled)
    autoFireSettings.isAutoFiring = isEnabled
    if isEnabled then
        if autoFireConnection then
            autoFireConnection:Disconnect()
        end
        autoFireConnection = game:GetService("RunService").Heartbeat:Connect(autoFire)
        
        if beamUpdateConnection then
            beamUpdateConnection:Disconnect()
        end
        beamUpdateConnection = RunService.Heartbeat:Connect(updateBeams)
    else
        if autoFireConnection then
            autoFireConnection:Disconnect()
            autoFireConnection = nil
        end
        
        if beamUpdateConnection then
            beamUpdateConnection:Disconnect()
            beamUpdateConnection = nil
        end
        
        for _, beamInfo in ipairs(activeBeams) do
            if beamInfo.beam then
                beamInfo.beam:Destroy()
            end
        end
        activeBeams = {}
    end
end

updatePlayerList()

Main:Dropdown({
    Title = "选择武器",
    Values = weaponOptions,
    Value = "AK-47",
    Callback = function(option)
        autoFireSettings.selectedWeapon = option
    end
})

Main:Dropdown({
    Title = "子弹轨迹颜色",
    Values = beamOptions,
    Value = "彩虹",
    Callback = function(option)
        autoFireSettings.beamType = option
        autoFireSettings.beamColor = beamColors[option]
    end
})

dropdownRef = Main:Dropdown({
    Title = "选择目标[单锁]",
    Values = playerList,
    Value = "无",
    Callback = function(option)
        selectedPlayer = option
        if option and option ~= "无" then
            local playerName = option
            if option:find("(@") then
                playerName = option:match("@(.+)%)") or option:match("^([^@]+)") or option
                playerName = playerName:gsub("%)", ""):gsub("%s+$", "")
            end
            autoFireSettings.targetPlayer = Players:FindFirstChild(playerName)
        else
            autoFireSettings.targetPlayer = nil
        end
    end
})

Main:Dropdown({
    Title = "选择模式",
    Values = {"全部", "单锁"},
    Value = "全部",
    Callback = function(mode)
        autoFireSettings.fireMode = mode
    end
})

Main:Toggle({
    Title = "开始锁人",
    Value = false,  
    Callback = toggleAutoFire
})

Main:Toggle({
    Title = "自动开火换弹",
    Value = false,  
    Callback = function(isEnabled)
        autoFireSettings.autoReload = isEnabled
    end
})

Main:Toggle({
    Title = "自动装备选择的武器",
    Value = false,  
    Callback = function(isEnabled)
        autoFireSettings.autoEquip = isEnabled
        if isEnabled then
            spawn(function()
                while autoFireSettings.autoEquip do
                    pcall(autoEquipSelectedWeapon)
                    wait(0)
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "忽略保护盾",
    Value = true,
    Callback = function(isEnabled)
        autoFireSettings.ignoreShield = isEnabled
    end
})

Main:Button({
    Title = "刷新玩家列表",
    Callback = updatePlayerList
})

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)





local MainTab = Window:Tab({Title = "魔法", Icon = "skull"})
local bombardmentEnabled={RPG=false,Flamethrower=false,AcidGun=false}
local bombardmentConnections={}
local lastBombardmentTime=0 
local lastAmmoPurchaseTime=0 
local ammoPurchaseInterval=2 
local ammoPurchaseAmount=2 
local BOMBARDMENT_DURATION=3.2 
local bombardmentConfig = {
    bombCount = 500,
    selectedPlayers = {},
    targetMode = "all", 
    excludeShield = true, 
    minHealth = 18, 
    pingLimit = 1850 
}

local function fixRemoteNames()
    local signalModule=require(game:GetService("ReplicatedStorage").devv.client.Helpers.remotes.Signal)
    for i,v in next,getupvalue(signalModule.LinkSignal,1)do 
        v.Name=i 
        v:GetPropertyChangedSignal("Name"):Connect(function()v.Name=i end)
    end 
    for i,v in next,getupvalue(signalModule.InvokeServer,1)do 
        v.Name=i 
        v:GetPropertyChangedSignal("Name"):Connect(function()v.Name=i end)
    end 
    for i,v in next,getupvalue(signalModule.FireServer,1)do 
        v.Name=i 
        v:GetPropertyChangedSignal("Name"):Connect(function()v.Name=i end)
    end 
end 
fixRemoteNames()

local function hasShield(player)
    local character=player.Character 
    if not character then return false end 
    local shieldPart=character:FindFirstChild("Shield")or character:FindFirstChild("ForceField")
    if shieldPart then return true end 
    for _,child in ipairs(character:GetDescendants())do 
        if child:IsA("ParticleEmitter")and child.Name:lower():find("shield")then 
            return true 
        end 
    end 
    return false 
end 

local function getAccuracyOffset()
    return Vector3.new(math.random(-0.2,0.2),math.random(-0.2,0.2),math.random(-0.2,0.2))
end 

local function purchaseAmmo(weaponType)
    local ammoType 
    if weaponType=="RPG" then 
        ammoType="RPG" 
    elseif weaponType=="Flamethrower" then 
        ammoType="Flamethrower" 
    elseif weaponType=="AcidGun" then 
        ammoType="Ace Gun" 
    end 
    require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchaseAmmo",ammoType)
end 

local function createVisualEffect(position)
    local explosion = Instance.new("Explosion")
    explosion.Position = position
    explosion.BlastPressure = 0
    explosion.BlastRadius = 10
    explosion.ExplosionType = Enum.ExplosionType.NoCraters
    explosion.DestroyJointRadiusPercent = 0
    explosion.Parent = workspace
    delay(1, function() explosion:Destroy() end)
end

local function isPlayerValidTarget(player)
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    if player == localPlayer then return false end
    if bombardmentConfig.excludeShield and hasShield(player) then return false end
    
    local character = player.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    
    if humanoid.Health <= bombardmentConfig.minHealth then return false end
    
    local hitbox = character:FindFirstChild("Hitbox")
    if not hitbox then return false end
    
    local headHitbox = hitbox:FindFirstChild("Head_Hitbox")
    if not headHitbox then return false end
    
    local targetRootPart = character:FindFirstChild("HumanoidRootPart") or humanoid.RootPart
    if not targetRootPart then return false end
    
    return true
end

local function performBombardment(weaponType)
    local ReplicatedStorage=game:GetService("ReplicatedStorage")
    local Players=game:GetService("Players")
    local localPlayer=Players.LocalPlayer 
    local reload=getupvalue(require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item.bin.Gun.modules.controller.modules.reload),2)
    local t=getupvalue(require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item.bin.Gun.modules.controller.modules.shoot),1)
    local reloadEvent=ReplicatedStorage.devv.remoteStorage:FindFirstChild("reload")
    local ammo=t.item.ammoManager 
    local gunid=t.item.guid 
    local firemode=t.item.firemode 
    
    firesignal(reloadEvent.OnClientEvent,gunid,0,ammo.ammoOut)
    reload()
    
    local targets={}
    
    -- 根据目标模式选择玩家
    if bombardmentConfig.targetMode == "selected" and #bombardmentConfig.selectedPlayers > 0 then
        -- 仅轰炸选择的玩家
        for _, playerName in ipairs(bombardmentConfig.selectedPlayers) do
            local player = Players:FindFirstChild(playerName)
            if player and isPlayerValidTarget(player) then
                local character = player.Character
                local hitbox = character:FindFirstChild("Hitbox")
                local headHitbox = hitbox:FindFirstChild("Head_Hitbox")
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local targetRootPart = character:FindFirstChild("HumanoidRootPart") or humanoid.RootPart
                
                table.insert(targets,{
                    player=player,
                    character=character,
                    headHitbox=headHitbox,
                    rootPart=targetRootPart,
                    humanoid=humanoid
                })
            end
        end
    else
        -- 轰炸所有符合条件的玩家
        for _,player in ipairs(Players:GetPlayers())do 
            if isPlayerValidTarget(player) then
                local character = player.Character
                local hitbox = character:FindFirstChild("Hitbox")
                local headHitbox = hitbox:FindFirstChild("Head_Hitbox")
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local targetRootPart = character:FindFirstChild("HumanoidRootPart") or humanoid.RootPart
                
                table.insert(targets,{
                    player=player,
                    character=character,
                    headHitbox=headHitbox,
                    rootPart=targetRootPart,
                    humanoid=humanoid
                })
            end
        end 
    end
    
    if #targets==0 then return end 
    
    for _,targetData in ipairs(targets)do 
        local targetHeadCFrame=targetData.headHitbox.CFrame 
        local targetHeadPosition=targetData.headHitbox.Position 
        local targetPlayerId=targetData.player.UserId 
        targetHeadCFrame=CFrame.new(targetHeadPosition)
        
        -- 根据配置的轰炸数量调整射击次数
        local shots = math.min(ammo.ammo, math.floor(bombardmentConfig.bombCount / #targets))
        
        if weaponType=="RPG" then 
            for i=1,shots do 
                local offset=getAccuracyOffset()
                local adjustedCFrame=targetHeadCFrame+offset 
                local Event1=ReplicatedStorage.devv.remoteStorage:FindFirstChild("replicateProjectiles")
                if Event1 then 
                    Event1:FireServer(gunid,{{"EZohio123",adjustedCFrame}},firemode)
                end 
                local Event2=ReplicatedStorage.devv.remoteStorage:FindFirstChild("projectileHit")
                if Event2 then 
                    Event2:FireServer("EZohio123","player",{hitPart=targetData.headHitbox,hitPlayerId=targetPlayerId,hitSize=targetData.headHitbox.Size,pos=targetHeadPosition+offset})
                end 
                
                createVisualEffect(targetHeadPosition + offset)
            end 
            
            local rocketHitEvent=ReplicatedStorage.devv.remoteStorage:FindFirstChild("rocketHit")
            if rocketHitEvent then 
                for i=1,math.min(5, math.floor(shots / 2)) do 
                    local offset=getAccuracyOffset()
                    rocketHitEvent:FireServer("EZohio123","EZohio123",targetHeadPosition+offset)
                    createVisualEffect(targetHeadPosition + offset)
                end 
            end 
            
        elseif weaponType=="Flamethrower" then 
            local flameHitEvent=ReplicatedStorage.devv.remoteStorage:FindFirstChild("flameHit")
            if flameHitEvent then 
                for i=1,math.min(50, shots * 10) do 
                    local offset=getAccuracyOffset()
                    flameHitEvent:FireServer("EZohio123","EZohio123",targetHeadPosition+offset)
                end 
            end 
            
        elseif weaponType=="AcidGun" then 
            local acidHitEvent=ReplicatedStorage.devv.remoteStorage:FindFirstChild("acidHit")
            if acidHitEvent then 
                for i=1,math.min(6, shots) do 
                    local offset=getAccuracyOffset()
                    acidHitEvent:FireServer("EZohio123","EZohio123",targetHeadPosition+offset)
                end 
            end 
        end 
        
        if targetData.humanoid.Health > bombardmentConfig.minHealth then
            if weaponType == "RPG" then
                for i = 1, math.min(2, math.floor(shots / 3)) do
                    local offset = getAccuracyOffset()
                    local rocketHitEvent = ReplicatedStorage.devv.remoteStorage:FindFirstChild("rocketHit")
                    if rocketHitEvent then
                        rocketHitEvent:FireServer("EZohio123", "EZohio123", targetHeadPosition + offset)
                        createVisualEffect(targetHeadPosition + offset)
                    end
                end
            end
        end
    end 
    
    firesignal(reloadEvent.OnClientEvent,gunid,0,ammo.ammoOut)
    reload()
end

-- 新增：玩家选择功能
local function refreshPlayerList()
    local Players = game:GetService("Players")
    local playerList = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    
    table.sort(playerList)
    return playerList
end

local function togglePlayerSelection(playerName)
    local index = table.find(bombardmentConfig.selectedPlayers, playerName)
    if index then
        table.remove(bombardmentConfig.selectedPlayers, index)
        return false
    else
        table.insert(bombardmentConfig.selectedPlayers, playerName)
        return true
    end
end

MainTab:Slider({
    Title = "发射数量",
    Value = {Min = 100, Max = 1500, Default = 500},
    Callback = function(value)
        bombardmentConfig.bombCount = math.floor(value)
        WindUI:Notify({
            Title = "轰炸设置",
            Content = "轰炸数量设置为: " .. bombardmentConfig.bombCount,
            Duration = 2,
            Icon = "target"
        })
    end
})

MainTab:Dropdown({
    Title = "模式",
    Desc = "选择轰炸目标",
    Values = {"所有玩家", "仅选择玩家"},
    Value = "所有玩家",
    Callback = function(value)
        if value == "所有玩家" then
            bombardmentConfig.targetMode = "all"
        else
            bombardmentConfig.targetMode = "selected"
        end
        WindUI:Notify({
            Title = "目标模式",
            Content = "已设置为: " .. value,
            Duration = 2,
            Icon = "users"
        })
    end
})
local playerList = refreshPlayerList()
local playerDropdownValues = {}
for _, playerName in ipairs(playerList) do
    table.insert(playerDropdownValues, playerName .. " [未选择]")
end

local playerSelectionDropdown = MainTab:Dropdown({
    Title = "选择玩家",
    Desc = "选择要轰炸的特定玩家",
    Values = playerDropdownValues,
    Value = "",
    Callback = function(value)
        if value and value ~= "" then
            local playerName = value:match("^([^%[]+)")
            if playerName then
                playerName = playerName:gsub("%s+$", "") 
                local isSelected = togglePlayerSelection(playerName)
                
            
                local newValues = refreshPlayerList()
                local updatedDropdownValues = {}
                for _, name in ipairs(newValues) do
                    local status = table.find(bombardmentConfig.selectedPlayers, name) and " [已选择]" or " [未选择]"
                    table.insert(updatedDropdownValues, name .. status)
                end
                
                playerSelectionDropdown:Refresh(updatedDropdownValues)
                
                WindUI:Notify({
                    Title = "玩家选择",
                    Content = playerName .. (isSelected and " 已选择" or " 已取消选择"),
                    Duration = 2,
                    Icon = isSelected and "user-check" or "user-x"
                })
            end
        end
    end
})
MainTab:Toggle({
    Title="RPG轰炸",
    Default=false,
    Callback=function(Value)
        bombardmentEnabled.RPG=Value 
        if bombardmentConnections.RPG then 
            bombardmentConnections.RPG:Disconnect()
            bombardmentConnections.RPG=nil 
        end 
        if Value then 
            local RunService=game:GetService("RunService")
            local Players=game:GetService("Players")
            local localPlayer=Players.LocalPlayer 
            local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)
            local originalGUID=hookfunction(guid,function(...)return "EZohio123" end)
            
            bombardmentConnections.RPG=RunService.Heartbeat:Connect(function()
                local currentTime=tick()
                local ping=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                if ping>bombardmentConfig.pingLimit then return end 
                
                if currentTime-lastAmmoPurchaseTime>=ammoPurchaseInterval then 
                    for i=1,ammoPurchaseAmount do 
                        pcall(purchaseAmmo,"RPG")
                    end 
                    lastAmmoPurchaseTime=currentTime 
                end 
                
                if currentTime-lastBombardmentTime>=0.15 then 
                    pcall(function()
                        performBombardment("RPG")
                    end)
                    lastBombardmentTime=currentTime 
                end 
            end)
            
            _G.RPGBombardment={
                connection=bombardmentConnections.RPG,
                originalGUID=originalGUID
            }
            
            WindUI:Notify({
                Title = "RPG轰炸",
                Content = "已启动 RPG 轰炸模式\n目标: " .. (bombardmentConfig.targetMode == "all" and "所有玩家" or "选择玩家") .. "\n数量: " .. bombardmentConfig.bombCount,
                Duration = 4,
                Icon = "target"
            })
        else 
            if _G.RPGBombardment then 
                if _G.RPGBombardment.connection then 
                    _G.RPGBombardment.connection:Disconnect()
                end 
                if _G.RPGBombardment.originalGUID then 
                    local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)
                    hookfunction(guid,_G.RPGBombardment.originalGUID)
                end 
                _G.RPGBombardment=nil 
            end 
            
            WindUI:Notify({
                Title = "RPG轰炸",
                Content = "已停止 RPG 轰炸",
                Duration = 2,
                Icon = "square"
            })
        end 
    end
})

MainTab:Toggle({
    Title="火焰发射器轰炸",
    Default=false,
    Callback=function(Value)
        bombardmentEnabled.Flamethrower=Value 
        if bombardmentConnections.Flamethrower then 
            bombardmentConnections.Flamethrower:Disconnect()
            bombardmentConnections.Flamethrower=nil 
        end 
        if Value then 
            local RunService=game:GetService("RunService")
            local Players=game:GetService("Players")
            local localPlayer=Players.LocalPlayer 
            local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)
            local originalGUID=hookfunction(guid,function(...)return "EZohio123" end)
            
            bombardmentConnections.Flamethrower=RunService.Heartbeat:Connect(function()
                local currentTime=tick()
                local ping=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                if ping>bombardmentConfig.pingLimit then return end 
                
                if currentTime-lastAmmoPurchaseTime>=ammoPurchaseInterval then 
                    for i=1,ammoPurchaseAmount do 
                        pcall(purchaseAmmo,"Flamethrower")
                    end 
                    lastAmmoPurchaseTime=currentTime 
                end 
                
                if currentTime-lastBombardmentTime>=0.15 then 
                    pcall(function()
                        performBombardment("Flamethrower")
                    end)
                    lastBombardmentTime=currentTime 
                end 
            end)
            
            _G.FlamethrowerBombardment={
                connection=bombardmentConnections.Flamethrower,
                originalGUID=originalGUID
            }
        else 
            if _G.FlamethrowerBombardment then 
                if _G.FlamethrowerBombardment.connection then 
                    _G.FlamethrowerBombardment.connection:Disconnect()
                end 
                if _G.FlamethrowerBombardment.originalGUID then 
                    local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)
                    hookfunction(guid,_G.FlamethrowerBombardment.originalGUID)
                end 
                _G.FlamethrowerBombardment=nil 
            end 
        end 
    end
})

MainTab:Toggle({
    Title="硫酸枪轰炸",
    Default=false,
    Callback=function(Value)
        bombardmentEnabled.AcidGun=Value 
        if bombardmentConnections.AcidGun then 
            bombardmentConnections.AcidGun:Disconnect()
            bombardmentConnections.AcidGun=nil 
        end 
        if Value then 
            local RunService=game:GetService("RunService")
            local Players=game:GetService("Players")
            local localPlayer=Players.LocalPlayer 
            local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)
            local originalGUID=hookfunction(guid,function(...)return "EZohio123" end)
            
            bombardmentConnections.AcidGun=RunService.Heartbeat:Connect(function()
                local currentTime=tick()
                local ping=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                if ping>bombardmentConfig.pingLimit then return end 
                
                if currentTime-lastAmmoPurchaseTime>=ammoPurchaseInterval then 
                    for i=1,ammoPurchaseAmount do 
                        pcall(purchaseAmmo,"AcidGun")
                    end 
                    lastAmmoPurchaseTime=currentTime 
                end 
                
                if currentTime-lastBombardmentTime>=0.15 then 
                    pcall(function()
                        performBombardment("AcidGun")
                    end)
                    lastBombardmentTime=currentTime 
                end 
            end)
            
            _G.AcidGunBombardment={
                connection=bombardmentConnections.AcidGun,
                originalGUID=originalGUID
            }
        else 
            if _G.AcidGunBombardment then 
                if _G.AcidGunBombardment.connection then 
                    _G.AcidGunBombardment.connection:Disconnect()
                end 
                if _G.AcidGunBombardment.originalGUID then 
                    local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)
                    hookfunction(guid,_G.AcidGunBombardment.originalGUID)
                end 
                _G.AcidGunBombardment=nil 
            end 
        end 
    end
})

local Main = Window:Tab({Title = "免费物品", Icon = "box"})
local function upgradeFistsToGoldenRose()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    pcall(function()
        local itemSystem = require(ReplicatedStorage.devv).load("v3item")
        local inventory = itemSystem.inventory
        
        local fistsItem = nil
        for guid, item in pairs(inventory.items) do
            if item.name == "Fists" then
                fistsItem = item
                break
            end
        end
        
        local goldenRoseData = {
            name = "Golden Rose",
            guid = "golden_rose_"..tostring(tick()),
            permanent = true,
            canDrop = true,
            dropCooldown = 120,
            multiplier = 0.625,
            holdableType = "Balloon",
            movespeedAdd = 5,
            TPSOffsets = {hold = CFrame.new(0, 0.5, 0)},
            viewportOffsets = {
                hotbar = {dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, (math.pi/2), 0)},
                ammoHUD = {dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744467859455345, 0)},
                slotButton = {dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, (-math.pi/2), 0)}
            }
        }
        
        if inventory.add then
            inventory.add(goldenRoseData, false)
            if inventory.currentItemsData then
                table.insert(inventory.currentItemsData, goldenRoseData)
            end
        end
        
        if fistsItem then
            local fistsCopy = {
                name = "Fists",
                guid = "fists_copy_"..tostring(tick()),
                permanent = true,
                cannotDiscard = true,
                doMakeModel = false,
                debounce = 0.3,
                damageTable = {meleepunch = 15, meleemegapunch = 200, meleekick = 20, meleejumpKick = 20},
                viewportOffsets = fistsItem.viewportOffsets,
                TPSOffsets = fistsItem.TPSOffsets or {},
                FPSOffsets = fistsItem.FPSOffsets or {}
            }
            if inventory.add then
                inventory.add(fistsCopy, false)
            end
        end
        
        if inventory.rerender then
            inventory:rerender()
        end
    end)
end

local function upgradeFistsToBlackRose()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    pcall(function()
        local itemSystem = require(ReplicatedStorage.devv).load("v3item")
        local inventory = itemSystem.inventory
        
        local fistsItem = nil
        for guid, item in pairs(inventory.items) do
            if item.name == "Fists" then
                fistsItem = item
                break
            end
        end
        
        local blackRoseData = {
            name = "Black Rose",
            guid = "black_rose_"..tostring(tick()),
            permanent = true,
            canDrop = true,
            dropCooldown = 120,
            multiplier = 0.75,
            holdableType = "Balloon",
            movespeedAdd = 12,
            TPSOffsets = {hold = CFrame.new(0, 0.5, 0)},
            viewportOffsets = {
                hotbar = {dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, (math.pi/2), 0)},
                ammoHUD = {dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744467859455345, 0)},
                slotButton = {dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, (-math.pi/2), 0)}
            }
        }
        
        if inventory.add then
            inventory.add(blackRoseData, false)
            if inventory.currentItemsData then
                table.insert(inventory.currentItemsData, blackRoseData)
            end
        end
        
        if fistsItem then
            local fistsCopy = {
                name = "Fists",
                guid = "fists_copy_"..tostring(tick()),
                permanent = true,
                cannotDiscard = true,
                doMakeModel = false,
                debounce = 0.3,
                damageTable = {meleepunch = 15, meleemegapunch = 200, meleekick = 20, meleejumpKick = 20},
                viewportOffsets = fistsItem.viewportOffsets,
                TPSOffsets = fistsItem.TPSOffsets or {},
                FPSOffsets = fistsItem.FPSOffsets or {}
            }
            if inventory.add then
                inventory.add(fistsCopy, false)
            end
        end
        
        if inventory.rerender then
            inventory:rerender()
        end
    end)
end

Main:Button({Title = "获取金玫瑰", Callback = upgradeFistsToGoldenRose})
Main:Button({Title = "获取黑玫瑰", Callback = upgradeFistsToBlackRose})


local function addBalloonToInventory(balloonData)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    pcall(function()
        local itemSystem = require(ReplicatedStorage.devv).load("v3item")
        local inventory = itemSystem.inventory
        
        local balloonItem = {
            name = balloonData.name,
            guid = balloonData.name:lower():gsub(" ","_").."_"..tostring(tick()),
            permanent = balloonData.permanent or true,
            canDrop = balloonData.canDrop or true,
            dropCooldown = balloonData.dropCooldown or 120,
            multiplier = balloonData.multiplier,
            holdableType = balloonData.holdableType or "Balloon",
            movespeedAdd = balloonData.movespeedAdd or 0,
            cannotDiscard = balloonData.cannotDiscard or false,
            TPSOffsets = balloonData.TPSOffsets or {hold = CFrame.new(0, 0.5, 0)},
            viewportOffsets = balloonData.viewportOffsets or {
                hotbar = {dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, (math.pi/2), 0)},
                ammoHUD = {dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744467859455345, 0)},
                slotButton = {dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, (-math.pi/2), 0)}
            }
        }
        
        if inventory.add then
            inventory.add(balloonItem, false)
            if inventory.currentItemsData then
                table.insert(inventory.currentItemsData, balloonItem)
            end
        end
        
        if inventory.rerender then
            inventory:rerender()
        end
    end)
end

local balloonItems = {
    DollarBalloon = {
        name = "Dollar Balloon",
        cost = 100000000000,
        unpurchasable = true,
        multiplier = 0.8,
        holdableType = "Balloon",
        movespeedAdd = 8,
        cannotDiscard = true,
        TPSOffsets = {hold = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.pi, 0)},
        viewportOffsets = {
            hotbar = {dist = 4, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)},
            ammoHUD = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}
        }
    }
}

local balloonNames = {
    DollarBalloon = "美元气球"
}

for balloonName, balloonData in pairs(balloonItems) do
    Main:Button({
        Title = "获取 "..balloonNames[balloonName],
        Callback = function()
            addBalloonToInventory(balloonData)
        end
    })
end

local Main = Window:Tab({Title = "自动", Icon = "user"})

local autobank = false
local bankTeleportCFrame = CFrame.new(1112.12671, 10.1856346, -324.815613)  
local originalPosition = nil  

local function robBankAndReturn()
    if not autobank then return end
    
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    originalPosition = rootPart.CFrame
    
    rootPart.CFrame = bankTeleportCFrame
    task.wait(0.1)
    
    local Signal = require(game:GetService("ReplicatedStorage").devv).load("Signal")
    
    local waitTime = 0.1
    local maxWait = 5.0
    
    local startTime = tick()
    while autobank and (tick() - startTime) < maxWait do
        Signal.FireServer("stealBankCash")
        task.wait(waitTime)
    end
    
    if autobank and originalPosition then
        rootPart.CFrame = originalPosition
        task.wait(0.1)
    end
    
    originalPosition = nil
end

local bankThread = nil

local function startBankRobberyLoop()
    if bankThread then return end
    
    bankThread = task.spawn(function()
        while autobank do
            robBankAndReturn()
            task.wait(0.5)
        end
        bankThread = nil
    end)
end

local function stopBankRobberyLoop()
    if bankThread then
        task.cancel(bankThread)
        bankThread = nil
    end
end

Main:Toggle({
    Title = "自动抢银行",
    Value = false,
    Callback = function(state) 
        autobank = state
        if autobank then
            startBankRobberyLoop()
        else
            stopBankRobberyLoop()
        end
    end
})

Main:Toggle({
    Title = "自动ATM",
    Default = false,
    Callback = function(Value)
        autoATMCashCombo = Value
        
        if autoATMCashCombo then
            local function collectCash()
                local player = game:GetService("Players").LocalPlayer
                local cashSize = Vector3.new(2, 0.2499999850988388, 1)
                
                for _, part in ipairs(workspace.Game.Entities.CashBundle:GetDescendants()) do
                    if part:IsA("BasePart") and part.Size == cashSize then
                        player.Character.HumanoidRootPart.CFrame = part.CFrame
                        task.wait()
                    end
                end
            end
            
            coroutine.wrap(function()
                while autoATMCashCombo and task.wait() do
                   
                    local ATMsFolder = workspace:FindFirstChild("ATMs")
                    local localPlayer = game:GetService("Players").LocalPlayer
                    local hasActiveATM = false
                    
                    if ATMsFolder and localPlayer.Character then
                        for _, atm in ipairs(ATMsFolder:GetChildren()) do
                            if atm:IsA("Model") then
                                local hp = atm:GetAttribute("health")
                                if hp ~= 0 then
                                    hasActiveATM = true
                                    for _, part in ipairs(atm:GetChildren()) do
                                        if part.Name == "Main" and part:IsA("BasePart") then
                                            localPlayer.Character.HumanoidRootPart.CFrame = part.CFrame
                                            task.wait()
                                            atm:SetAttribute("health", 0)
                                            break
                                        end
                                    end
                                    task.wait()
                                end
                            end
                        end
                    end
                    
                    if hasActiveATM then
                        task.wait(1)
                    else
                        collectCash()
                        
                 
                        task.wait()
                    end
                end
            end)()
        end
    end
})

local autoCraftEnabled = false
local autoClaimEnabled = false
local craftConnection

local Signal = require(game:GetService("ReplicatedStorage").devv).load("Signal")

local function performCrafting()
    if autoCraftEnabled then
        Signal.InvokeServer("beginCraft", 'RollieCraft')
    end
    
    if autoClaimEnabled then
        Signal.InvokeServer("claimCraft", 'RollieCraft')
    end
end

game:GetService("RunService").Heartbeat:Connect(function()
    if autoCraftEnabled or autoClaimEnabled then
        performCrafting()
    end
end)

Main:Toggle({
    Title = "自动制作萝莉",
    Default = false,
    Callback = function(Value)
        autoCraftEnabled = Value
    end
})

Main:Toggle({
    Title = "自动领取萝莉",
    Default = false,
    Callback = function(Value)
        autoClaimEnabled = Value
    end
})

local autoStoreGems = false
local Signal = require(game:GetService("ReplicatedStorage").devv).load("Signal")
local b1 = require(game:GetService('ReplicatedStorage').devv).load('v3item').inventory.items

local function storeGems()
    for _, v in pairs(workspace.HousingPlots:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            if v.ActionText == "Add Gem" or v.ActionText == "Equip a Gem" then
                local houseid = v.Parent.Parent.Name
                local hitid = v.Parent.Name
                for i, item in next, b1 do
                    if item.name == "Diamond" or item.name == "Rollie" or item.name == "Dark Matter Gem" or item.name == "Diamond Ring" or item.name == "Void Gem" then
                        Signal.FireServer("equip", item.guid)
                        Signal.FireServer("updateGemDisplay", houseid, hitid, item.guid)
                    end
                end
            end
        end
    end
end

game:GetService("RunService").Heartbeat:Connect(function()
    if autoStoreGems then
        storeGems()
    end
end)

Main:Toggle({
    Title = "自动存放珠宝到家用珠宝柜",
    Desc = "需要有房子和珠宝柜",
    Default = false,
    Callback = function(Value)
        autoStoreGems = Value
    end
})
local autoRentHouse = false

local Signal = require(game:GetService("ReplicatedStorage").devv).load("Signal")

local function rentHouse()
    for _, v in pairs(workspace.HousingPlots:GetChildren()) do
        if not v:GetAttribute("Owner") then
            local housename = v
            Signal.InvokeServer("rentHouse", v)
        end
    end
end

local lastRentTime = 0
game:GetService("RunService").Heartbeat:Connect(function()
    if autoRentHouse and tick() - lastRentTime >= 2 then
        rentHouse()
        lastRentTime = tick()
    end
end)

Main:Toggle({
    Title = "自动租用房屋",
    Default = false,
    Callback = function(Value)
        autoRentHouse = Value
    end
})
local Signal = require(game:GetService("ReplicatedStorage").devv).load("Signal")

local autoClaimEnabled = false
local autoClaimConnection = nil

local function autoClaimRewards()
   
    for day = 1, 12 do
        Signal.InvokeServer("claimDailyReward", day)
        task.wait(0.1)
    end
    
   
    for tier = 1, 3 do
        for level = 1, 6 do
            Signal.InvokeServer("claimPlaytimeReward", tier, level)
            task.wait(0.1)
        end
    end
    
    WindUI:Notify({Title = "自动领取", Content = "奖励领取完成", Duration = 2})
end

local function startAutoClaimLoop()
    autoClaimEnabled = true
    autoClaimConnection = task.spawn(function()
        while autoClaimEnabled do
            autoClaimRewards()
            task.wait(5) 
        end
    end)
end

local function stopAutoClaimLoop()
    autoClaimEnabled = false
    if autoClaimConnection then
        autoClaimConnection:Disconnect()
        autoClaimConnection = nil
    end
end

Main:Toggle({
    Title = "自动领取奖励",
    Default = false,
    Callback = function(Value)
        if Value then
            startAutoClaimLoop()
        else
            stopAutoClaimLoop()
        end
    end
})
local function teleportToAirdrop()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local character = localPlayer.Character
    if not character then return false end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    
    local originalPosition = rootPart.CFrame
    local foundAirdrop = false
    local airdrops = game:GetService('Workspace').Game.Airdrops:GetChildren()
    for _, airdrop in pairs(airdrops) do
        if airdrop:FindFirstChild('Airdrop') and airdrop.Airdrop:FindFirstChild('ProximityPrompt') then
            local prompt = airdrop.Airdrop.ProximityPrompt
            prompt.RequiresLineOfSight = false
            prompt.HoldDuration = 0
            rootPart.CFrame = airdrop.Airdrop.CFrame
            task.wait(0.1) 
            
      
            for i = 1, 15 do
                fireproximityprompt(prompt)
                task.wait(0.02) 
            end
            
            foundAirdrop = true
            break
        end
    end
    
 
    if not foundAirdrop then
        rootPart.CFrame = originalPosition
    else
       
        task.wait(0.3)
        rootPart.CFrame = originalPosition
    end
    
    return foundAirdrop
end
local airdropAutoEnabled = false
Main:Toggle({
    Title = "自动空投",
    Default = false,
    Callback = function(Value)
        airdropAutoEnabled = Value
        if Value then
            task.spawn(function()
                while airdropAutoEnabled do
                    local collected = teleportToAirdrop()
                    if not collected then
                  
                        for i = 1, 10 do
                            if not airdropAutoEnabled then break end
                            task.wait(0.1)
                        end
                    else
                     
                        for i = 1, 3 do
                            if not airdropAutoEnabled then break end
                            task.wait(0.1)
                        end
                    end
                end
            end)
        end
    end
})

local function fastCollectMoney()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local character = localPlayer.Character
    if not character then return false end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return false end
    local originalPosition = humanoidRootPart.CFrame
    local foundMoney = false
    local moneyEntities = workspace.Game.Entities.CashBundle:GetChildren()
    for i = 1, #moneyEntities do
        local l = moneyEntities[i]
        local moneyValue = l:FindFirstChildWhichIsA("IntValue")
        if moneyValue and moneyValue.Value >= setting.minMoney then
            humanoidRootPart.CFrame = l:FindFirstChildWhichIsA("Part").CFrame
            task.wait(0.2)
            humanoidRootPart.CFrame = originalPosition
            foundMoney = true
            break
        end
    end
    return foundMoney
end

Main:Toggle({
    Title = "自动捡钱",
    Default = false,
    Callback = function(Value)
        setting.autoMoney = Value
        if Value then
            task.spawn(function()
                while setting.autoMoney and task.wait(0.1) do
                    fastCollectMoney()
                end
            end)
        end
    end
})

Main:Slider({
    Title = "最低钱数设置",
    Value = {
        Min = 250,
        Max = 1000,
        Default = 250,
    },
    Callback = function(Value)
        setting.minMoney = Value
    end
})

local function crackSafes()
    while autoOpenSafes do
        if not checkAnyTargetExists() then
            teleportToHideSpot()
            task.wait(1)
        else
            pcall(function()
                local rootPart = getRootPart()
                if not rootPart then return end

                for _, obj in ipairs(workspace.Game.Entities:GetDescendants()) do
                    if not autoOpenSafes then break end
                    if obj:IsA("ProximityPrompt") and obj.ActionText == "Crack Safe" and obj.Enabled then
                        obj.RequiresLineOfSight = false
                        obj.HoldDuration = 0

                        local target = obj.Parent and obj.Parent.Parent
                        if target and target:IsA("BasePart") then
                            rootPart.CFrame = CFrame.new(target.Position)
                            task.wait(1)
                            fireproximityprompt(obj)
                            task.wait(0.5)
                            task.wait(2)
                            pickupAll15m(target.Position)
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end
end

local function crackChests()
    while autoOpenChests do
        if not checkAnyTargetExists() then
            teleportToHideSpot()
            task.wait(1)
        else
            pcall(function()
                local rootPart = getRootPart()
                if not rootPart then return end

                for _, obj in ipairs(workspace.Game.Entities:GetDescendants()) do
                    if not autoOpenChests then break end
                    if obj:IsA("ProximityPrompt") and obj.ActionText == "Crack Chest" and obj.Enabled then
                        obj.RequiresLineOfSight = false
                        obj.HoldDuration = 0

                        local target = obj.Parent and obj.Parent.Parent
                        if target and target:IsA("BasePart") then
                            rootPart.CFrame = CFrame.new(target.Position)
                            task.wait(1)
                            fireproximityprompt(obj)
                            task.wait(0.5)
                            task.wait(2)
                            pickupAll15m(target.Position)
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end
end

local function updateThreads()
    if safeThread then
        task.cancel(safeThread)
        safeThread = nil
    end
    if autoOpenSafes then
        safeThread = task.spawn(crackSafes)
    end

    if chestThread then
        task.cancel(chestThread)
        chestThread = nil
    end
    if autoOpenChests then
        chestThread = task.spawn(crackChests)
    end
end

Main:Toggle({
    Title = "自动保险箱",
    Default = false,
    Callback = function(Value)
        autoOpenSafes = Value
        updateThreads()
    end
})

Main:Toggle({
    Title = "自动宝箱",
    Default = false,
    Callback = function(Value)
        autoOpenChests = Value
        updateThreads()
    end
})

Main:Toggle({
    Title = "自动购买撬锁",
    Default = false,
    Callback = function(Value)
        lock = Value
        task.spawn(function()
            while lock and task.wait() do
                pcall(function()
                    local Players = game:GetService("Players")
                    local localPlayer = Players.LocalPlayer
                    if localPlayer.Character then
                        local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            Signal.InvokeServer("attemptPurchase", "Lockpick")
                        end
                    end
                end)
            end
        end)
    end
})


local F2 = Window:Tab({Title = "物品", Icon = "box"})
F2:Toggle({
    Title = "自动捡价值宝石",
    --Image = "bird",
    Value = false,
    Callback = function(state) 
    autobs = state
    if autobs then
    while autobs and wait() do 
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local rootPart = localPlayer.Character.HumanoidRootPart

    for _, l in pairs(game.Workspace.Game.Entities.ItemPickup:GetChildren()) do
        for _, v in pairs(l:GetChildren()) do
            if v:IsA("MeshPart") or v:IsA("Part") then
                local e = v:FindFirstChildOfClass("ProximityPrompt")
                if e and (e.ObjectText == "" or e.ObjectText == "+" or e.ObjectText == ""  or e.ObjectText == ""  or e.ObjectText == ""  or e.ObjectText == "Diamond Ring"  or e.ObjectText == "Diamond" or e.ObjectText == "Void Gem" or e.ObjectText == "Dark Matter Gem" or e.ObjectText == "Rollie" or e.ObjectText == "") then
                    rootPart.CFrame = v.CFrame * CFrame.new(0, 2, 0)
                    e.RequiresLineOfSight = false
                    e.HoldDuration = 0
                    fireproximityprompt(e)
                end
            end
        end
    end
    end
    end
    end
})
F2:Toggle({
    Title = "自动捡贵重物品",
    --Image = "bird",
    Value = false,
    Callback = function(state) 
    autogzwp = state
    if autogzwp then
    while autogzwp and wait() do 
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local rootPart = localPlayer.Character.HumanoidRootPart
    for _, l in pairs(game.Workspace.Game.Entities.ItemPickup:GetChildren()) do
        for _, v in pairs(l:GetChildren()) do
            if v:IsA("MeshPart") or v:IsA("Part") then
                local e = v:FindFirstChildOfClass("ProximityPrompt")
                if e and (e.ObjectText == "Green Lucky Block" or e.ObjectText == "Orange Lucky Block" or e.ObjectText == "Purple Lucky Block" or e.ObjectText == "Blue Candy Cane" or e.ObjectText == "Suitcase Nuke" or e.ObjectText == "Nuke Launcher" or e.ObjectText == "Easter Basket" or e.ObjectText == "Gold Cup" or e.ObjectText == "Gold Crown" or e.ObjectText == "Pearl Necklace" or e.ObjectText == "Treasure Map"or e.ObjectText == "Spectral Scythe" or e.ObjectText == "Bunny Balloon" or e.ObjectText == "Ghost Balloon" or e.ObjectText == "Clover Balloon" or e.ObjectText == "Bat Balloon" or e.ObjectText == "Gold Clover Balloon" or e.ObjectText == "Golden Rose" or e.ObjectText == "Black Rose" or e.ObjectText == "Heart Balloon" or e.ObjectText == "Skull Balloon" or e.ObjectText == "Money Printer") then
                    rootPart.CFrame = v.CFrame * CFrame.new(0, 2, 0)
                    e.RequiresLineOfSight = false
                    e.HoldDuration = 0
                    fireproximityprompt(e)
                end
            end
        end
    end
    end
    end
    end
})

F2:Toggle({
    Title = "自动捡普通宝石",
    --Image = "bird",
    Value = false,
    Callback = function(state) 
    autobs = state
    if autobs then
    while autobs and wait() do 
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local rootPart = localPlayer.Character.HumanoidRootPart

    for _, l in pairs(game.Workspace.Game.Entities.ItemPickup:GetChildren()) do
        for _, v in pairs(l:GetChildren()) do
            if v:IsA("MeshPart") or v:IsA("Part") then
                local e = v:FindFirstChildOfClass("ProximityPrompt")
                if e and (e.ObjectText == "Amethyst" or e.ObjectText == "Sapphire" or e.ObjectText == "Emerald"  or e.ObjectText == "Topaz"  or e.ObjectText == "Ruby"  or e.ObjectText == "Diamond Ring"  or e.ObjectText == "Diamond" or e.ObjectText == "Void Gem" or e.ObjectText == "Dark Matter Gem" or e.ObjectText == "Rollie" or e.ObjectText == "Gold Bar") then
                    rootPart.CFrame = v.CFrame * CFrame.new(0, 2, 0)
                    e.RequiresLineOfSight = false
                    e.HoldDuration = 0
                    fireproximityprompt(e)
                end
            end
        end
    end
    end
    end
    end
})
local Players            = game:GetService("Players")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local devv               = require(ReplicatedStorage.devv)
local item               = devv.load("v3item")
local Signal             = devv.load("Signal")
local junkWeps  = {"Uzi","M1911","C4","Glock","Mossberg","Stagecouch","Python"}
local junkGems  = {"","","","",""}
local junkMisc  = {"Baseball Bat","Basketball","Bloxaide","Bloxy Cola","Cake","Stop Sign"}
local setting = { collect = {} }
local function rmList(list)
    for _, v in next, item.inventory.items do
        for _, name in ipairs(list) do
            if v.name == name then
                Signal.FireServer("removeItem", v.guid)
             
                break
            end
        end
    end
end
local running = {}         
local function loopClean(key, list)
    if running[key] then return end        
    running[key] = true
    task.spawn(function()
        while setting.collect[key] do
            rmList(list)
            task.wait(0.5)
        end
        running[key] = false
    end)
end
local function addToggle(title, key, list)
    F2:Toggle({
        Title   = title,
        Default = false,
        Callback = function(v)
            setting.collect[key] = v
            if v then loopClean(key, list) end
        end
    })
end

do
    local allJunk = {}
    for _, v in ipairs(junkWeps)  do table.insert(allJunk, v) end
    for _, v in ipairs(junkGems)  do table.insert(allJunk, v) end
    for _, v in ipairs(junkMisc)  do table.insert(allJunk, v) end
    rmList(allJunk)
end
addToggle("自动移除垃圾枪",   "autoremoveweps",  junkWeps)
addToggle("自动移除垃圾宝石", "autoremovegems",  junkGems)
addToggle("自动移除其它垃圾", "autoremovemisc",  junkMisc)
F2:Slider({
    Title = "物品栏数量",
    Desc = "调整背包物品栏的数量",
    Value = {
        Min = 1,
        Max = 12,
        Default = 6,
    },
    Callback = function(Value)
        local sum = require(game.ReplicatedStorage.devv.client.Objects.v3item.modules.inventory)
        sum.numSlots = Value
    end
})
local b = Window:Tab({Title = "枪皮", Icon = "palette"})
b:Dropdown({
    Title = "选择一个皮肤",
    Values = { 
        "烟火", "虚空", "纯金", "暗物质", "反物质", "神秘", "虚空神秘", "战术", "纯金战术", 
        "白未来", "黑未来", "圣诞未来", "礼物包装", "猩红", "收割者", "虚空收割者", "圣诞玩具",
        "荒地", "隐形", "像素", "钻石像素", "黄金零下", "绿水晶", "生物", "樱花", "精英", 
        "黑樱花", "彩虹激光", "蓝水晶", "紫水晶", "红水晶", "零下", "虚空射线", "冰冻钻石",
        "虚空梦魇", "金雪", "爱国者", "MM2", "声望", "酷化", "蒸汽", "海盗", "玫瑰", "黑玫瑰",
        "激光", "烟花", "诅咒背瓜", "大炮", "财富", "黄金大炮", "四叶草", "自由", "黑曜石", "赛博朋克"
    },
    Callback = function(Value) 
        if Value == "烟火" then
            skinsec = "Sparkler"
        elseif Value == "虚空" then
            skinsec = "Void"
        elseif Value == "纯金" then
            skinsec = "Solid Gold"
        elseif Value == "暗物质" then
            skinsec = "Dark Matter"
        elseif Value == "反物质" then
            skinsec = "Anti Matter"
        elseif Value == "神秘" then
            skinsec = "Hystic"
        elseif Value == "虚空神秘" then
            skinsec = "Void Mystic"
        elseif Value == "战术" then
            skinsec = "Tactical"
        elseif Value == "纯金战术" then
            skinsec = "Solid Gold Tactical"
        elseif Value == "白未来" then
            skinsec = "Future White"
        elseif Value == "黑未来" then
            skinsec = "Future Black"
        elseif Value == "圣诞未来" then
            skinsec = "Christmas Future"
        elseif Value == "礼物包装" then
            skinsec = "Gift Wrapped"
        elseif Value == "猩红" then
            skinsec = "Crimson Blood"
        elseif Value == "收割者" then
            skinsec = "Reaper"
        elseif Value == "虚空收割者" then
            skinsec = "Void Reaper"
        elseif Value == "圣诞玩具" then
            skinsec = "Christmas Toy"
        elseif Value == "荒地" then
            skinsec = "Wasteland"
        elseif Value == "隐形" then
            skinsec = "Invisible"
        elseif Value == "像素" then
            skinsec = "Pixel"
        elseif Value == "钻石像素" then
            skinsec = "Diamond Pixel"
        elseif Value == "黄金零下" then
            skinsec = "Frozen-Gold"
        elseif Value == "绿水晶" then
            skinsec = "Atomic Nature"
        elseif Value == "生物" then
            skinsec = "Biohazard"
        elseif Value == "樱花" then
            skinsec = "Sakura"
        elseif Value == "精英" then
            skinsec = "Elite"
        elseif Value == "黑樱花" then
            skinsec = "Death Blossom-Gold"
        elseif Value == "彩虹激光" then
            skinsec = "Rainbowlaser"
        elseif Value == "蓝水晶" then
            skinsec = "Atomic Water"
        elseif Value == "紫水晶" then
            skinsec = "Atomic Amethyst"
        elseif Value == "红水晶" then
            skinsec = "Atomic Flame"
        elseif Value == "零下" then
            skinsec = "Sub-Zero"
        elseif Value == "虚空射线" then
            skinsec = "Void-Ray"
        elseif Value == "冰冻钻石" then
            skinsec = "Frozen Diamond"
        elseif Value == "虚空梦魇" then
            skinsec = "Void Nightmare"
        elseif Value == "金雪" then
            skinsec = "Golden Snow"
        elseif Value == "爱国者" then
            skinsec = "Patriot"
        elseif Value == "MM2" then
            skinsec = "MM2 Barrett"
        elseif Value == "声望" then
            skinsec = "Prestige Barnett"
        elseif Value == "酷化" then
            skinsec = "Skin Walter"
        elseif Value == "蒸汽" then
            skinsec = "Steampunk"
        elseif Value == "海盗" then
            skinsec = "Pirate"
        elseif Value == "玫瑰" then
            skinsec = "Rose"
        elseif Value == "黑玫瑰" then
            skinsec = "Black Rose"
        elseif Value == "激光" then
            skinsec = "Hyperlaser"
        elseif Value == "烟花" then
            skinsec = "Firework"
        elseif Value == "诅咒背瓜" then
            skinsec = "Cursed Pumpkin"
        elseif Value == "大炮" then
            skinsec = "Cannon"
        elseif Value == "财富" then
            skinsec = "Firework"
        elseif Value == "黄金大炮" then
            skinsec = "Gold Cannon"
        elseif Value == "四叶草" then
            skinsec = "Lucky Clover"
        elseif Value == "自由" then
            skinsec = "Freedom"
        elseif Value == "黑曜石" then
            skinsec = "Obsidian"
        elseif Value == "赛博朋克" then
            skinsec = "Cyberpunk"
        end
    end
})
b:Toggle({
    Title = "开启美化",
    --Image = "bird",
    Value = false,
    Callback = function(start) 
autoskin = start
if autoskin then
local it = require(game:GetService("ReplicatedStorage").devv).load("v3item").inventory
local b1 = require(game:GetService('ReplicatedStorage').devv).load('v3item').inventory.items
for i, item in next, b1 do 
if item.type == "Gun" then
it.skinUpdate(item.name, skinsec)
end
end
end
end
})
b:Toggle({
    Title = "开启全枪黄金大炮美化",
    --Image = "bird",
    Value = false,
    Callback = function(start) 
skinvoid = start
if skinvoid then
local it = require(game:GetService("ReplicatedStorage").devv).load("v3item").inventory
local b1 = require(game:GetService('ReplicatedStorage').devv).load('v3item').inventory.items
for i, item in next, b1 do 
if item.type == "Gun" then
table.insert(require(game:GetService("ReplicatedStorage").devv.shared.Indicies.skins.bin.Special.Void).compatabilities, item.name)
it.skinUpdate(item.name, "Gold Cannon")
end
end
end
end
})
b:Toggle({
    Title = "开启全枪赛博朋克美化",
    --Image = "bird",
    Value = false,
    Callback = function(start) 
skinvoid = start
if skinvoid then
local it = require(game:GetService("ReplicatedStorage").devv).load("v3item").inventory
local b1 = require(game:GetService('ReplicatedStorage').devv).load('v3item').inventory.items
for i, item in next, b1 do 
if item.type == "Gun" then
table.insert(require(game:GetService("ReplicatedStorage").devv.shared.Indicies.skins.bin.Special.Void).compatabilities, item.name)
it.skinUpdate(item.name, "Cyberpunk")
end
end
end
end
})
b:Toggle({
    Title = "开启全枪虚空美化",
    --Image = "bird",
    Value = false,
    Callback = function(start) 
skinvoid = start
if skinvoid then
local it = require(game:GetService("ReplicatedStorage").devv).load("v3item").inventory
local b1 = require(game:GetService('ReplicatedStorage').devv).load('v3item').inventory.items
for i, item in next, b1 do 
if item.type == "Gun" then
table.insert(require(game:GetService("ReplicatedStorage").devv.shared.Indicies.skins.bin.Special.Void).compatabilities, item.name)
it.skinUpdate(item.name, "Void")
end
end
end
end
})


local Main = Window:Tab({Title = "娱乐", Icon = "settings"})

_G.AUTO_CHAT_TEXT = "大司马脚本 ！！！"
_G.AUTO_CHAT_ENABLED = false
_G.AUTO_CHAT_INTERVAL = 1.5
_G.AUTO_CHAT_MODE = "自定义"
local chatSystem = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    TextChatService = game:GetService("TextChatService"),
    messageIndex = 1,
    messageCount = 0,
    lastMessageTime = 0,
    chatModes = {
        ["自定义"] = function() return {_G.AUTO_CHAT_TEXT} end,
        ["7字经"] = function() return {"来老弟", "你有啥实力", "你活着干啥呢", "臭底层", "快来打压你爹", "我在这等着呢", "快来打压我"} end,
        ["14字经"] = function() return {"你有啥用", "你活着干啥呢", "赶紧跳了吧", "老弟家里几位在哪里", "来吧赶紧让我口吃", "你爹等着你呢", "你个窝囊废", "孩子快来呀", "怎么不敢和你爹对话了？", "你有什么用处", "你活着当技女吗？", "一句话", "来打压我", "哈哈哈笑死我了"} end,
        ["糖人语言"] = function() return {"我是奶龙", "奶龙是我", "你是谁？？", "我是谁", "你干嘛啊？"} end,
        ["宣传词"] = function() return {"大司马脚本牛逼", "打败一切", "快来购买", "功能多多", "支持超多服务器"} end
    },
    connections = {},
    active = false
}
chatSystem.tryTextChatSend = function(msg)
    local ok = false
    pcall(function()
        local ch = chatSystem.TextChatService.TextChannels:FindFirstChild("RBXGeneral") or
                   chatSystem.TextChatService.TextChannels:FindFirstChild("RBXGeneralChannel")
        if ch and ch.SendAsync then
            ch:SendAsync(msg)
            ok = true
        end
    end)
    return ok
end

chatSystem.tryOldChatSend = function(msg)
    local ok = false
    pcall(function()
        local ev = chatSystem.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        local req = ev and ev:FindFirstChild("SayMessageRequest")
        if req then
            req:FireServer(msg, "All")
            ok = true
        end
    end)
    return ok
end

chatSystem.tryPlayerChat = function(msg)
    local ok = false
    pcall(function()
        local pl = chatSystem.Players.LocalPlayer
        if pl and pl.Chat then
            pl:Chat(msg)
            ok = true
        end
    end)
    return ok
end

chatSystem.doSend = function(msg)
    local sent = false
    sent = chatSystem.tryTextChatSend(msg) or sent
    if not sent then sent = chatSystem.tryOldChatSend(msg) or sent end
    if not sent then sent = chatSystem.tryPlayerChat(msg) or sent end
    
    if sent then
        chatSystem.messageCount = chatSystem.messageCount + 1
        chatSystem.lastMessageTime = os.time()
    end
    return sent
end
chatSystem.startAutoChat = function()
    if chatSystem.active then return end
    chatSystem.active = true
    
    chatSystem.connections.autoChat = game:GetService("RunService").Heartbeat:Connect(function()
        if _G.AUTO_CHAT_ENABLED and chatSystem.chatModes[_G.AUTO_CHAT_MODE] then
            local currentTime = tick()
            local lastSendTime = chatSystem.lastSendTime or 0
            local interval = tonumber(_G.AUTO_CHAT_INTERVAL) or 1.5
            
            if currentTime - lastSendTime >= interval then
                local messages = chatSystem.chatModes[_G.AUTO_CHAT_MODE]()
                if messages and #messages > 0 then
                    local message = messages[chatSystem.messageIndex]
                    chatSystem.doSend(tostring(message))
                    chatSystem.messageIndex = (chatSystem.messageIndex % #messages) + 1
                    chatSystem.lastSendTime = currentTime
                end
            end
        end
    end)
end

chatSystem.stopAutoChat = function()
    chatSystem.active = false
    if chatSystem.connections.autoChat then
        chatSystem.connections.autoChat:Disconnect()
        chatSystem.connections.autoChat = nil
    end
end
chatSystem.init = function()
    chatSystem.startAutoChat()
end
chatSystem.sendNow = function(message)
    if not message or message == "" then
        message = _G.AUTO_CHAT_TEXT
    end
    return chatSystem.doSend(message)
end
chatSystem.cleanup = function()
    for name, connection in pairs(chatSystem.connections) do
        if connection then
            pcall(function() connection:Disconnect() end)
        end
    end
    chatSystem.connections = {}
    chatSystem.active = false
end
task.spawn(chatSystem.init)
Main:Dropdown({
    Title = "发言模式",
    Values = {"自定义", "7字经", "14字经", "糖人语言", "宣传词"},
    Value = "自定义",
    Callback = function(value)
        _G.AUTO_CHAT_MODE = value
        chatSystem.messageIndex = 1 -- 重置消息索引
        WindUI:Notify({
            Title = "发言模式",
            Content = "已切换到: " .. value,
            Duration = 2,
            Icon = "message-circle"
        })
    end
})

Main:Input({
    Title = "自定义发言内容",
    Placeholder = "输入要发送的消息",
    Value = "大司马脚本nb",
    Callback = function(value)
        _G.AUTO_CHAT_TEXT = value
        WindUI:Notify({
            Title = "自定义内容",
            Content = "已设置: " .. value,
            Duration = 2,
            Icon = "edit"
        })
    end
})

Main:Toggle({
    Title = "开启自动发言",
    Value = false,
    Callback = function(value)
        _G.AUTO_CHAT_ENABLED = value
        if value and not chatSystem.active then
            chatSystem.startAutoChat()
        elseif not value then
            chatSystem.stopAutoChat()
        end
        WindUI:Notify({
            Title = "自动发言",
            Content = value and "已开启" or "已关闭",
            Duration = 2,
            Icon = value and "play" or "square"
        })
    end
})

Main:Slider({
    Title = "发言间隔",
    Desc = "设置发送消息的时间间隔（秒）",
    Value = {Min = 0.5, Max = 10, Default = 1.5},
    Callback = function(value)
        _G.AUTO_CHAT_INTERVAL = value
        WindUI:Notify({
            Title = "发言间隔",
            Content = "已设置为: " .. value .. "秒",
            Duration = 2,
            Icon = "clock"
        })
    end
})
_G.ChatSystem = chatSystem



local weatherSettings = {
    ["雨天"] = "Rainy",
    ["阴天"] = "Overcast",
    ["晴天"] = "Clear",
    ["雪天"] = "Snowy"
}
local selectedWeather = "晴天"
local function changeWeather(weatherType)
    local lighting = game:GetService("Lighting")
    lighting.ClockTime = 14 
    lighting.Brightness = 1
    lighting.FogEnd = 10000
    lighting.GlobalShadows = true
    
   
    for _, obj in pairs(lighting:GetChildren()) do
        if obj:IsA("ParticleEmitter") or obj.Name == "WeatherEffect" then
            obj:Destroy()
        end
    end
    
    
    if weatherType == "Rainy" then
       
        lighting.Brightness = 0.7
        lighting.FogEnd = 5000
        lighting.ExposureCompensation = -0.5
        
       
        local rain = Instance.new("ParticleEmitter")
        rain.Name = "WeatherEffect"
        rain.Parent = lighting
        rain.Texture = "rbxassetid://2530913495"
        rain.Size = NumberSequence.new(0.5)
        rain.Transparency = NumberSequence.new(0.3)
        rain.Lifetime = NumberRange.new(5)
        rain.Rate = 100
        rain.Speed = NumberRange.new(20)
        rain.VelocitySpread = 90
        rain.Rotation = NumberRange.new(0, 360)
        rain.RotSpeed = NumberRange.new(10)
        rain.LightEmission = 0.1
        
    elseif weatherType == "Overcast" then
        -- 阴天设置
        lighting.Brightness = 0.6
        lighting.FogEnd = 3000
        lighting.ExposureCompensation = -0.8
        lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
        
    elseif weatherType == "Clear" then
        -- 晴天设置
        lighting.Brightness = 2
        lighting.FogEnd = 20000
        lighting.ExposureCompensation = 0.3
        lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        
    elseif weatherType == "Snowy" then
        -- 雪天设置
        lighting.Brightness = 1.2
        lighting.FogEnd = 8000
        lighting.ExposureCompensation = 0.1
        
       
        local snow = Instance.new("ParticleEmitter")
        snow.Name = "WeatherEffect"
        snow.Parent = lighting
        snow.Texture = "rbxassetid://2530914826"
        snow.Size = NumberSequence.new(0.3)
        snow.Transparency = NumberSequence.new(0.1)
        snow.Lifetime = NumberRange.new(8)
        snow.Rate = 80
        snow.Speed = NumberRange.new(5)
        snow.VelocitySpread = 45
        snow.Rotation = NumberRange.new(0, 360)
        snow.RotSpeed = NumberRange.new(5)
        snow.LightEmission = 0.5
        snow.LightInfluence = 0
    end
    
    print("天气已切换至: " .. weatherType)
end
Main:Dropdown({
    Title = "选择天气",
    Values = {"雨天", "阴天", "晴天", "雪天"},
    Value = "晴天",
    Callback = function(option)
        selectedWeather = option
    end
})

Main:Button({
    Title = "确认变换天气",
    Callback = function()
        changeWeather(weatherSettings[selectedWeather])
    end
})

local skySettings = {
    ["神青天空1"] = "http://www.roblox.com/asset/?id=112666167201442",
    ["神青天空2"] = "http://www.roblox.com/asset/?id=105006817202266",
    ["动漫猫羽雫天空"] = "http://www.roblox.com/asset/?id=16060333448"
}

local selectedSky = "神青天空1"


local function changeSky(skyboxId)
    local lighting = game:GetService("Lighting")
    

    for _, obj in pairs(lighting:GetChildren()) do
        if obj:IsA("Sky") then
            obj:Destroy()
        end
    end
    
   
    local sky = Instance.new("Sky")
    sky.CelestialBodiesShown = false
    sky.Parent = lighting
    sky.SkyboxUp = skyboxId
    sky.SkyboxBk = skyboxId
    sky.SkyboxDn = skyboxId
    sky.SkyboxRt = skyboxId
    sky.SkyboxLf = skyboxId
    sky.SkyboxFt = skyboxId
    
    print("天空已切换至: " .. selectedSky)
end

Main:Dropdown({
    Title = "选择天空盒",
    Values = {"神青天空1", "神青天空2", "动漫猫羽雫天空"},
    Value = "神青天空1",
    Callback = function(option)
        selectedSky = option
    end
})

Main:Button({
    Title = "确认变换天空",
    Callback = function()
        changeSky(skySettings[selectedSky])
    end
})

local bs = Window:Tab({Title = "破解类", Icon = "user"})

bs:Button({
    Title = "破解移动经销商",
    Callback = function()
local pjyd pjyd=hookmetamethod(game,"__namecall",function(self,...)local args={...}local method=getnamecallmethod()if method=="InvokeServer" and args[2]==true then args[2]=false return pjyd(self,unpack(args))end return pjyd(self,...)end)--
    game:GetService("Players").LocalPlayer:SetAttribute("mobileDealer",true)local ReplicatedStorage=game:GetService("ReplicatedStorage")local mobileDealer=require(ReplicatedStorage.devv.shared.Indicies.mobileDealer)for category,items in pairs(mobileDealer)do for _,item in ipairs(items)do item.stock=999999 end end local ReplicatedStorage=game:GetService("ReplicatedStorage")local mobileDealer=require(ReplicatedStorage.devv.shared.Indicies.mobileDealer)table.insert(mobileDealer.Gun,{itemName="Acid Gun",stock=9999})table.insert(mobileDealer.Gun,{itemName="Candy Bucket",stock=9999})
    end
})
bs:Button({
    Title = "破解高级表情包",
    Callback = function()
    for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Emotes.Frame.ScrollingFrame:GetDescendants()) do
        if v.Name == "Locked" then
            v.Visible = false
        end
    end
    end
})

bs:Button({
    Title = "破解战斗状态",
    Callback = function()
        for _, func in pairs(getgc(true)) do
    if type(func) == "function" then
        local info = debug.getinfo(func)
        if info.name == "isInCombat" or (info.source and info.source:find("combatIndicator")) then
            hookfunction(func, function() 
                return false 
            end)
        end
    end
end
    end
})
local CasePurchase = Window:Tab({Title = "皮肤箱子", Icon = "shopping-bag"})

local casesList = {}
local skins = require(game:GetService("ReplicatedStorage").devv).load("skins")

for caseName, caseData in pairs(skins.cases) do
    if caseData.cashPrice or caseData.candyPrice or caseData.gingerbreadPrice then
        table.insert(casesList, caseName)
    end
end

local selectedCase = casesList[1]
local selectedOpenCase = casesList[1]
local autoOpenSelected = false
local autoBuySelected = false
local autoOpenAll = false

CasePurchase:Dropdown({
    Title = "选择要购买的箱子",
    Values = casesList,
    Callback = function(Value)
        selectedCase = Value
    end
})

CasePurchase:Button({
    Title = "购买一次选中箱子",
    Callback = function()
        local Signal = require(game:GetService("ReplicatedStorage").devv).load("Signal")
        Signal.InvokeServer("buyCases", selectedCase, 1)
    end
})

CasePurchase:Dropdown({
    Title = "选择要开启的箱子",
    Values = casesList,
    Callback = function(Value)
        selectedOpenCase = Value
    end
})

CasePurchase:Toggle({
    Title = "自动开启选中箱子",
    Value = false,
    Callback = function(state)
        autoOpenSelected = state
        if state then
            task.spawn(function()
                local Signal = require(game:GetService("ReplicatedStorage").devv).load("Signal")
                local state = require(game:GetService("ReplicatedStorage").devv).load("state")
                
                while autoOpenSelected do
                    local ownedCount = state.data.ownedCases[selectedOpenCase] or 0
                    if ownedCount > 0 then
                        Signal.InvokeServer("openCase", selectedOpenCase)
                        task.wait(0.5)
                    else
                        task.wait(1)
                    end
                end
            end)
        end
    end
})

CasePurchase:Toggle({
    Title = "自动开全部箱子",
    Value = false,
    Callback = function(state)
        autoOpenAll = state
        if state then
            task.spawn(function()
                local Signal = require(game:GetService("ReplicatedStorage").devv).load("Signal")
                local state = require(game:GetService("ReplicatedStorage").devv).load("state")
                
                while autoOpenAll do
                    for caseName, ownedCount in pairs(state.data.ownedCases or {}) do
                        if ownedCount > 0 and not autoOpenSelected then
                            Signal.InvokeServer("openCase", caseName)
                            task.wait(0.3)
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    end
})
local Main = Window:Tab({Title = "骚扰类", Icon = "phone"})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Signal = require(ReplicatedStorage.devv).load("Signal")
local TweenService = game:GetService("TweenService")
harassSettings = {
    targetPlayer = nil,
    messageText = "我是神",
    isSpamming = false,
    spamInterval = 1,
    autoMessages = {
        "孩子干啥呢啊",
        "有什么实力",
        "活着干啥呢",
        "SXHUB"
    },
    autoMessageIndex = 1,
    isAutoCalling = false,
    callInterval = 5,
    currentCallId = nil,
    playerList = {},
    lastPlayerRefresh = 0,
    playerRefreshInterval = 5
}
function startAutoCall()
    if not harassSettings.targetPlayer then
        WindUI:Notify({Title = "打电话", Content = "请先选择目标玩家", Duration = 3, Icon = "phone-off"})
        return false
    end
    
    harassSettings.isAutoCalling = true
    
    task.spawn(function()
        while harassSettings.isAutoCalling and harassSettings.targetPlayer do
            pcall(function()
              
                local success, callId = Signal.InvokeServer("attemptCall", harassSettings.targetPlayer.UserId)
                
                if success then
                    harassSettings.currentCallId = callId
                    WindUI:Notify({
                        Title = "打电话", 
                        Content = "正在呼叫: " .. harassSettings.targetPlayer.Name,
                        Duration = 3, 
                        Icon = "phone-outgoing"
                    })
                    
                  
                    local callDuration = math.random(10, 30) -- 10-30秒随机通话时间
                    local startTime = os.time()
                    
                    while harassSettings.isAutoCalling and os.time() - startTime < callDuration do
                        task.wait(1)
                    end
                    
                  
                    if harassSettings.currentCallId then
                        Signal.FireServer("sendPhoneAction", harassSettings.currentCallId, "hangup")
                        harassSettings.currentCallId = nil
                    end
                else
                    WindUI:Notify({
                        Title = "打电话", 
                        Content = "呼叫失败: " .. harassSettings.targetPlayer.Name,
                        Duration = 3, 
                        Icon = "phone-missed"
                    })
                end
            end)
            
            if harassSettings.isAutoCalling then
                task.wait(harassSettings.callInterval)
            end
        end
    end)
end

function stopAutoCall()
    harassSettings.isAutoCalling = false
    if harassSettings.currentCallId then
        Signal.FireServer("sendPhoneAction", harassSettings.currentCallId, "hangup")
        harassSettings.currentCallId = nil
    end
end

function startSpam()
    harassSettings.isSpamming = true
    task.spawn(function()
        while harassSettings.isSpamming and harassSettings.targetPlayer do
            pcall(function()
                Signal.FireServer("sendMessage", harassSettings.targetPlayer.UserId, harassSettings.messageText)
            end)
            task.wait(harassSettings.spamInterval)
        end
    end)
end

function startAutoMessages()
    task.spawn(function()
        while harassSettings.isSpamming and harassSettings.targetPlayer do
            pcall(function()
                Signal.FireServer("sendMessage", harassSettings.targetPlayer.UserId, 
                    harassSettings.autoMessages[harassSettings.autoMessageIndex])
                
                harassSettings.autoMessageIndex = harassSettings.autoMessageIndex + 1
                if harassSettings.autoMessageIndex > #harassSettings.autoMessages then
                    harassSettings.autoMessageIndex = 1
                end
            end)
            task.wait(harassSettings.spamInterval)
        end
    end)
end
function refreshPlayerList()
    local currentTime = os.time()
    if currentTime - harassSettings.lastPlayerRefresh < harassSettings.playerRefreshInterval then
        return harassSettings.playerList
    end
    
    harassSettings.lastPlayerRefresh = currentTime
    harassSettings.playerList = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            table.insert(harassSettings.playerList, {
                text = player.Name .. " (@" .. player.DisplayName .. ")",
                value = player.Name
            })
        end
    end
    
   
    table.sort(harassSettings.playerList, function(a, b)
        return a.text:lower() < b.text:lower()
    end)
    
    return harassSettings.playerList
end

function getPlayerListValues()
    refreshPlayerList()
    local values = {}
    for _, player in ipairs(harassSettings.playerList) do
        table.insert(values, player.text)
    end
    return values
end
Main:Paragraph({
    Title = "小伙伴赶紧骚扰小伙伴吧",
    Desc = "有缺陷请提出",
    Image = "phone",
    ImageSize = 20,
    Color = "Red"
})
local playerDropdown = Main:Dropdown({
    Title = "选择目标玩家",
    Desc = "自动刷新玩家列表",
    Values = getPlayerListValues(),
    Value = "",
    Callback = function(value)
        if value and value ~= "" then
            -- 从显示文本中提取玩家名
            local playerName = value:match("^([^%s]+)")
            if playerName then
                harassSettings.targetPlayer = Players:FindFirstChild(playerName)
                if harassSettings.targetPlayer then
                    WindUI:Notify({
                        Title = "目标设置", 
                        Content = "已选择: " .. harassSettings.targetPlayer.Name,
                        Duration = 2, 
                        Icon = "user-check"
                    })
                else
                    WindUI:Notify({
                        Title = "错误", 
                        Content = "未找到玩家: " .. playerName,
                        Duration = 3, 
                        Icon = "user-x"
                    })
                end
            end
        else
            harassSettings.targetPlayer = nil
        end
    end
})
Main:Button({
    Title = "刷新玩家列表",
    Icon = "refresh-cw",
    Callback = function()
        local newValues = getPlayerListValues()
        playerDropdown:Refresh(newValues)
        WindUI:Notify({
            Title = "玩家列表", 
            Content = "已刷新，找到 " .. #newValues .. " 个玩家",
            Duration = 2, 
            Icon = "users"
        })
    end
})



Main:Toggle({
    Title = "自动打电话",
    Value = false,
    Callback = function(isEnabled)
        if isEnabled and not harassSettings.targetPlayer then
            WindUI:Notify({
                Title = "错误", 
                Content = "请先选择目标玩家",
                Duration = 3, 
                Icon = "user-x"
            })
            return false
        end
        
        if isEnabled then
            startAutoCall()
            WindUI:Notify({
                Title = "开始打电话", 
                Content = "开始自动呼叫: " .. harassSettings.targetPlayer.Name,
                Duration = 3, 
                Icon = "phone-outgoing"
            })
        else
            stopAutoCall()
            WindUI:Notify({
                Title = "停止打电话", 
                Content = "已停止自动呼叫",
                Duration = 2, 
                Icon = "phone-off"
            })
        end
    end
})

Main:Slider({
    Title = "呼叫间隔",
    Desc = "设置每次呼叫的时间间隔（秒）",
    Value = {Min = 3, Max = 60, Default = 5},
    Callback = function(value)
        harassSettings.callInterval = value
    end
})





Main:Input({
    Title = "自定义消息",
    Value = "我是神",
    Placeholder = "输入要发送的消息内容",
    Callback = function(value)
        harassSettings.messageText = value
    end
})

Main:Toggle({
    Title = "消息轰炸[自定义]",
    Value = false,
    Callback = function(isEnabled)
        if isEnabled and not harassSettings.targetPlayer then
            WindUI:Notify({
                Title = "错误", 
                Content = "请先选择目标玩家",
                Duration = 3, 
                Icon = "user-x"
            })
            return false
        end
        
        harassSettings.isSpamming = isEnabled
        if isEnabled then
            startSpam()
            WindUI:Notify({
                Title = "开始轰炸", 
                Content = "开始向 " .. harassSettings.targetPlayer.Name .. " 发送消息",
                Duration = 3, 
                Icon = "send"
            })
        else
            WindUI:Notify({
                Title = "停止轰炸", 
                Content = "已停止发送消息",
                Duration = 2, 
                Icon = "square"
            })
        end
    end
})

Main:Toggle({
    Title = "自动发送预设消息",
    Value = false,
    Callback = function(isEnabled)
        if isEnabled and not harassSettings.targetPlayer then
            WindUI:Notify({
                Title = "错误", 
                Content = "请先选择目标玩家",
                Duration = 3, 
                Icon = "user-x"
            })
            return false
        end
        
        harassSettings.isSpamming = isEnabled
        if isEnabled then
            startAutoMessages()
            WindUI:Notify({
                Title = "开始自动消息", 
                Content = "开始发送预设消息给 " .. harassSettings.targetPlayer.Name,
                Duration = 3, 
                Icon = "message-circle"
            })
        else
            WindUI:Notify({
                Title = "停止自动消息", 
                Content = "已停止发送预设消息",
                Duration = 2, 
                Icon = "message-square"
            })
        end
    end
})

Main:Slider({
    Title = "消息间隔",
    Desc = "设置发送消息的时间间隔（秒）",
    Value = {Min = 0.1, Max = 5, Default = 1},
    Callback = function(value)
        harassSettings.spamInterval = value
    end
})


local qtl = Window:Tab({Title = "购买", Icon = "shopping-bag"})
local itemsOnSale = workspace:FindFirstChild("ItemsOnSale")
local itemNames = {}
local selectedItem = ""
if itemsOnSale then
    local seenNames = {}
    for _, item in ipairs(itemsOnSale:GetChildren()) do
        if not seenNames[item.Name] then
            table.insert(itemNames, item.Name)
            seenNames[item.Name] = true
        end
    end
end

local autoPurchaseSettings = {
    enabled = false,
    bulletEnabled = false,
    delay = 1
}

qtl:Dropdown({
    Title = "选择物品",
    Values = itemNames,
    Value = itemNames[1] or "",
    Callback = function(item)
        selectedItem = item 
    end
})

qtl:Toggle({
    Title = "自动购买选择物品",
    Default = false,
    Callback = function(Value)
        autoPurchaseSettings.enabled = Value
        if Value then
            task.spawn(function()
                while autoPurchaseSettings.enabled and task.wait(autoPurchaseSettings.delay) do
                    if selectedItem and selectedItem ~= "" then
                        require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchase", selectedItem)
                    end
                end
            end)
        end
    end
})

qtl:Toggle({
    Title = "自动购买子弹",
    Default = false,
    Callback = function(Value)
        autoPurchaseSettings.bulletEnabled = Value
        if Value then
            task.spawn(function()
                while autoPurchaseSettings.bulletEnabled and task.wait(autoPurchaseSettings.delay) do
                    require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchase", "子弹")
                end
            end)
        end
    end
})

qtl:Slider({
    Title = "购买延迟",
    Value = {
        Min = 0.1,
        Max = 5,
        Default = 1,
    },
    Callback = function(Value)
        autoPurchaseSettings.delay = Value
    end
})

qtl:Button({
    Title = "购买选择的物品",
    Callback = function()
        if selectedItem and selectedItem ~= "" then
            require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchase", selectedItem)
        else
            warn("请先选择一个物品")
        end
    end
})

qtl:Button({
    Title = "购买子弹",
    Callback = function()
        require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchase", "Ammo")
    end
})


local Main = Window:Tab({Title = "透视", Icon = "settings"})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ESP 配置
local ESPConfig = {
    ESPEnabled = false,
    ShowBox = false,
    ShowHealth = false,
    ShowName = false,
    ShowDistance = false,
    ShowTracer = false,
    TeamCheck = false,
    ShowSkeleton = false,
    ShowRadar = false,
    ShowPlayerCount = false,
    ShowWeapon = false,
    ShowFOV = false,
    OutOfViewArrows = false,
    Chams = false,
    
    -- ESP 颜色配置
    TracerColor = Color3.new(1, 0, 0),
    SkeletonColor = Color3.new(0.2, 0.8, 1),
    BoxColor = Color3.new(1, 1, 1),
    HealthBarColor = Color3.new(0, 1, 0),
    HealthTextColor = Color3.new(1, 1, 1),
    NameColor = Color3.new(1, 1, 1),
    DistanceColor = Color3.new(1, 1, 0),
    WeaponColor = Color3.new(1, 0.5, 0),
    ArrowColor = Color3.new(1, 0, 0),
    FOVColor = Color3.new(1, 1, 1),
    ChamsColor = Color3.new(1, 0, 0),
    
    -- ESP 样式配置
    BoxThickness = 1,
    TracerThickness = 1,
    SkeletonThickness = 2,
    FOVRadius = 100,
    ArrowSize = 15
}

-- 渐变颜色函数
local function getGradientColor(time)
    local r = math.sin(time * 2) * 0.5 + 0.5
    local g = math.sin(time * 3) * 0.5 + 0.5
    local b = math.sin(time * 4) * 0.5 + 0.5
    return Color3.new(r, g, b)
end

-- 玩家计数文本
local playerCountText = Drawing.new("Text")
playerCountText.Visible = false
playerCountText.Color = Color3.new(1, 1, 1)
playerCountText.Size = 20
playerCountText.Font = Drawing.Fonts.Monospace
playerCountText.Outline = true
playerCountText.OutlineColor = Color3.new(0, 0, 0)
playerCountText.Position = Vector2.new(Camera.ViewportSize.X / 2, 10)

-- FOV 圆圈
local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Color = ESPConfig.FOVColor
fovCircle.Thickness = 1
fovCircle.Filled = false
fovCircle.Radius = ESPConfig.FOVRadius
fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

-- 更新玩家计数
local function updatePlayerCount()
    local playerCount = #Players:GetPlayers()
    playerCountText.Text = "在线玩家: " .. playerCount
    playerCountText.Visible = ESPConfig.ESPEnabled and ESPConfig.ShowPlayerCount

    local time = tick()
    playerCountText.Color = getGradientColor(time)
end

-- 更新 FOV 圆圈
local function updateFOV()
    fovCircle.Visible = ESPConfig.ShowFOV
    fovCircle.Color = ESPConfig.FOVColor
    fovCircle.Radius = ESPConfig.FOVRadius
    fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
end

-- ESP 组件存储
local ESPComponents = {}

-- 创建玩家 ESP
local function createESP(player)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = ESPConfig.BoxColor
    box.Thickness = ESPConfig.BoxThickness
    box.Filled = false

    local healthBar = Drawing.new("Square")
    healthBar.Visible = false
    healthBar.Color = ESPConfig.HealthBarColor
    healthBar.Thickness = 1
    healthBar.Filled = true

    local healthBarBackground = Drawing.new("Square")
    healthBarBackground.Visible = false
    healthBarBackground.Color = Color3.new(0, 0, 0)
    healthBarBackground.Transparency = 0.5
    healthBarBackground.Thickness = 1
    healthBarBackground.Filled = true

    local healthBarBorder = Drawing.new("Square")
    healthBarBorder.Visible = false
    healthBarBorder.Color = Color3.new(1, 1, 1)
    healthBarBorder.Thickness = 1
    healthBarBorder.Filled = false

    local healthText = Drawing.new("Text")
    healthText.Visible = false
    healthText.Color = ESPConfig.HealthTextColor
    healthText.Size = 14
    healthText.Font = Drawing.Fonts.Monospace
    healthText.Outline = true
    healthText.OutlineColor = Color3.new(0, 0, 0)

    local nameText = Drawing.new("Text")
    nameText.Visible = false
    nameText.Color = ESPConfig.NameColor
    nameText.Size = 16
    nameText.Font = Drawing.Fonts.Monospace
    nameText.Outline = true
    nameText.OutlineColor = Color3.new(0, 0, 0)

    local distanceText = Drawing.new("Text")
    distanceText.Visible = false
    distanceText.Color = ESPConfig.DistanceColor
    distanceText.Size = 14
    distanceText.Font = Drawing.Fonts.Monospace
    distanceText.Outline = true
    distanceText.OutlineColor = Color3.new(0, 0, 0)

    local weaponText = Drawing.new("Text")
    weaponText.Visible = false
    weaponText.Color = ESPConfig.WeaponColor
    weaponText.Size = 14
    weaponText.Font = Drawing.Fonts.Monospace
    weaponText.Outline = true
    weaponText.OutlineColor = Color3.new(0, 0, 0)

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = ESPConfig.TracerColor
    tracer.Thickness = ESPConfig.TracerThickness

    local arrow = Drawing.new("Triangle")
    arrow.Visible = false
    arrow.Color = ESPConfig.ArrowColor
    arrow.Filled = true
    arrow.Thickness = 1

    local skeletonLines = {}
    local skeletonPoints = {}

    -- 创建骨骼线条
    local function createSkeleton()
        for i = 1, 15 do
            skeletonLines[i] = Drawing.new("Line")
            skeletonLines[i].Visible = false
            skeletonLines[i].Color = ESPConfig.SkeletonColor
            skeletonLines[i].Thickness = ESPConfig.SkeletonThickness
        end

        skeletonPoints["Head"] = Drawing.new("Circle")
        skeletonPoints["Head"].Visible = false
        skeletonPoints["Head"].Color = Color3.new(1, 0.5, 0)
        skeletonPoints["Head"].Thickness = 2
        skeletonPoints["Head"].Filled = true
        skeletonPoints["Head"].Radius = 4
    end

    createSkeleton()

    local lastHealth = 100
    local healthChangeTime = 0
    local smoothHealth = 100

    -- 存储 ESP 组件
    ESPComponents[player] = {
        box = box,
        healthBar = healthBar,
        healthBarBackground = healthBarBackground,
        healthBarBorder = healthBarBorder,
        healthText = healthText,
        nameText = nameText,
        distanceText = distanceText,
        weaponText = weaponText,
        tracer = tracer,
        arrow = arrow,
        skeletonLines = skeletonLines,
        skeletonPoints = skeletonPoints
    }

    -- 每帧更新 ESP
    RunService.RenderStepped:Connect(function()
        if not ESPConfig.ESPEnabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") or not player.Character:FindFirstChild("Humanoid") or player == LocalPlayer then
            -- 隐藏所有组件
            box.Visible = false
            healthBar.Visible = false
            healthBarBackground.Visible = false
            healthBarBorder.Visible = false
            healthText.Visible = false
            nameText.Visible = false
            distanceText.Visible = false
            weaponText.Visible = false
            tracer.Visible = false
            arrow.Visible = false
            for _, line in pairs(skeletonLines) do
                line.Visible = false
            end
            for _, point in pairs(skeletonPoints) do
                point.Visible = false
            end
            return
        end

        -- 队伍检查
        if ESPConfig.TeamCheck and player.Team == LocalPlayer.Team then
            box.Visible = false
            healthBar.Visible = false
            healthBarBackground.Visible = false
            healthBarBorder.Visible = false
            healthText.Visible = false
            nameText.Visible = false
            distanceText.Visible = false
            weaponText.Visible = false
            tracer.Visible = false
            arrow.Visible = false
            for _, line in pairs(skeletonLines) do
                line.Visible = false
            end
            for _, point in pairs(skeletonPoints) do
                point.Visible = false
            end
            return
        end

        local character = player.Character
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")

        if rootPart and humanoid and humanoid.Health > 0 then
            local rootPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            local headPos, _ = Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0))
            local legPos, _ = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))

            -- 获取武器名称
            local weaponName = "无武器"
            for _, tool in ipairs(character:GetChildren()) do
                if tool:IsA("Tool") then
                    weaponName = tool.Name
                    break
                end
            end

            -- 方框透视
            if ESPConfig.ShowBox and onScreen then
                box.Size = Vector2.new(1000 / rootPos.Z, headPos.Y - legPos.Y)
                box.Position = Vector2.new(rootPos.X - box.Size.X / 2, rootPos.Y - box.Size.Y / 2)
                box.Visible = true
                box.Color = ESPConfig.BoxColor
                box.Thickness = ESPConfig.BoxThickness
            else
                box.Visible = false
            end

            -- 血量条
            if ESPConfig.ShowHealth and onScreen then
                local healthPercentage = humanoid.Health / humanoid.MaxHealth
                local barWidth = 50
                local barHeight = 5
                local barX = headPos.X - barWidth / 2
                local barY = headPos.Y - 20

                healthBarBackground.Size = Vector2.new(barWidth, barHeight)
                healthBarBackground.Position = Vector2.new(barX, barY)
                healthBarBackground.Visible = true

                healthBarBorder.Size = Vector2.new(barWidth, barHeight)
                healthBarBorder.Position = Vector2.new(barX, barY)
                healthBarBorder.Visible = true

                smoothHealth = smoothHealth + (humanoid.Health - smoothHealth) * 0.1
                local smoothHealthPercentage = smoothHealth / humanoid.MaxHealth

                healthBar.Size = Vector2.new(barWidth * smoothHealthPercentage, barHeight)
                healthBar.Position = Vector2.new(barX, barY)

                -- 根据血量改变颜色
                if smoothHealthPercentage >= 0.8 then
                    healthBar.Color = Color3.new(0, 1, 0)
                elseif smoothHealthPercentage >= 0.5 then
                    healthBar.Color = Color3.new(1, 1, 0)
                elseif smoothHealthPercentage >= 0.2 then
                    healthBar.Color = Color3.new(1, 0.5, 0)
                else
                    healthBar.Color = Color3.new(1, 0, 0)
                end

                healthBar.Visible = true

                -- 血量变化效果
                if humanoid.Health ~= lastHealth then
                    healthChangeTime = tick()
                    lastHealth = humanoid.Health
                end

                if tick() - healthChangeTime < 0.5 then
                    healthBar.Color = Color3.new(1, 0, 0)
                end

                healthText.Position = Vector2.new(barX + barWidth + 5, barY - 5)
                healthText.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
                healthText.Visible = true
            else
                healthBar.Visible = false
                healthBarBackground.Visible = false
                healthBarBorder.Visible = false
                healthText.Visible = false
            end

            -- 名字和距离
            if ESPConfig.ShowName and onScreen then
                nameText.Position = Vector2.new(headPos.X, headPos.Y - 35)
                nameText.Text = player.Name
                nameText.Visible = true

                if ESPConfig.ShowDistance then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude
                    distanceText.Position = Vector2.new(headPos.X, headPos.Y + 10)
                    distanceText.Text = math.floor(distance) .. "m"
                    distanceText.Visible = true
                else
                    distanceText.Visible = false
                end

                if ESPConfig.ShowWeapon then
                    weaponText.Position = Vector2.new(headPos.X, headPos.Y - 50)
                    weaponText.Text = weaponName
                    weaponText.Visible = true
                else
                    weaponText.Visible = false
                end
            else
                nameText.Visible = false
                distanceText.Visible = false
                weaponText.Visible = false
            end

            -- 射线
            if ESPConfig.ShowTracer then
                local head = character:FindFirstChild("Head")
                if head then
                    local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        tracer.To = Vector2.new(headPos.X, headPos.Y)
                        tracer.Visible = true
                        tracer.Color = ESPConfig.TracerColor
                        tracer.Thickness = ESPConfig.TracerThickness
                        
                        
                        local distance = (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude
                        if distance < 20 then
                            tracer.Color = Color3.new(0, 1, 0)
                        elseif distance < 50 then
                            tracer.Color = Color3.new(1, 1, 0) 
                        else
                            tracer.Color = ESPConfig.TracerColor 
                        end
                    else
                        tracer.Visible = false
                    end
                else
                    tracer.Visible = false
                end
            else
                tracer.Visible = false
            end

          
            if ESPConfig.OutOfViewArrows and not onScreen then
                local direction = (rootPart.Position - Camera.CFrame.Position).Unit
                local dotProduct = Camera.CFrame.RightVector:Dot(direction)
                local crossProduct = Camera.CFrame.RightVector:Cross(direction)
                
                local screenPosition = Vector2.new(
                    Camera.ViewportSize.X / 2 + dotProduct * Camera.ViewportSize.X / 3,
                    Camera.ViewportSize.Y / 2 - crossProduct.Y * Camera.ViewportSize.Y / 3
                )
                
                screenPosition = Vector2.new(
                    math.clamp(screenPosition.X, ESPConfig.ArrowSize, Camera.ViewportSize.X - ESPConfig.ArrowSize),
                    math.clamp(screenPosition.Y, ESPConfig.ArrowSize, Camera.ViewportSize.Y - ESPConfig.ArrowSize)
                )
                
                local angle = math.atan2(screenPosition.Y - Camera.ViewportSize.Y / 2, screenPosition.X - Camera.ViewportSize.X / 2)
                
                arrow.PointA = screenPosition
                arrow.PointB = Vector2.new(
                    screenPosition.X - ESPConfig.ArrowSize * math.cos(angle - 0.5),
                    screenPosition.Y - ESPConfig.ArrowSize * math.sin(angle - 0.5)
                )
                arrow.PointC = Vector2.new(
                    screenPosition.X - ESPConfig.ArrowSize * math.cos(angle + 0.5),
                    screenPosition.Y - ESPConfig.ArrowSize * math.sin(angle + 0.5)
                )
                
                arrow.Color = ESPConfig.ArrowColor
                arrow.Visible = true
            else
                arrow.Visible = false
            end

       
            if ESPConfig.ShowSkeleton and onScreen then
                local head = character:FindFirstChild("Head")
                local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                local leftArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftUpperArm")
                local rightArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightUpperArm")
                local leftLeg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftUpperLeg")
                local rightLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightUpperLeg")
                
                if head and torso and leftArm and rightArm and leftLeg and rightLeg then
                    local headPos = Camera:WorldToViewportPoint(head.Position)
                    local torsoPos = Camera:WorldToViewportPoint(torso.Position)
                    local leftArmPos = Camera:WorldToViewportPoint(leftArm.Position)
                    local rightArmPos = Camera:WorldToViewportPoint(rightArm.Position)
                    local leftLegPos = Camera:WorldToViewportPoint(leftLeg.Position)
                    local rightLegPos = Camera:WorldToViewportPoint(rightLeg.Position)

                    skeletonPoints["Head"].Position = Vector2.new(headPos.X, headPos.Y)
                    skeletonPoints["Head"].Visible = true

               
                    skeletonLines[1].From = Vector2.new(headPos.X, headPos.Y)
                    skeletonLines[1].To = Vector2.new(torsoPos.X, torsoPos.Y) 
                    skeletonLines[1].Visible = true

                    skeletonLines[2].From = Vector2.new(torsoPos.X, torsoPos.Y)
                    skeletonLines[2].To = Vector2.new(leftArmPos.X, leftArmPos.Y)
                    skeletonLines[2].Visible = true

                    skeletonLines[3].From = Vector2.new(torsoPos.X, torsoPos.Y)
                    skeletonLines[3].To = Vector2.new(rightArmPos.X, rightArmPos.Y)
                    skeletonLines[3].Visible = true

                    skeletonLines[4].From = Vector2.new(torsoPos.X, torsoPos.Y)
                    skeletonLines[4].To = Vector2.new(leftLegPos.X, leftLegPos.Y)
                    skeletonLines[4].Visible = true

                    skeletonLines[5].From = Vector2.new(torsoPos.X, torsoPos.Y)
                    skeletonLines[5].To = Vector2.new(rightLegPos.X, rightLegPos.Y)
                    skeletonLines[5].Visible = true

                
                    if character:FindFirstChild("LeftLowerArm") then
                        local leftLowerArmPos = Camera:WorldToViewportPoint(character.LeftLowerArm.Position)
                        skeletonLines[6].From = Vector2.new(leftArmPos.X, leftArmPos.Y)
                        skeletonLines[6].To = Vector2.new(leftLowerArmPos.X, leftLowerArmPos.Y)
                        skeletonLines[6].Visible = true
                    end

                    if character:FindFirstChild("RightLowerArm") then
                        local rightLowerArmPos = Camera:WorldToViewportPoint(character.RightLowerArm.Position)
                        skeletonLines[7].From = Vector2.new(rightArmPos.X, rightArmPos.Y)
                        skeletonLines[7].To = Vector2.new(rightLowerArmPos.X, rightLowerArmPos.Y)
                        skeletonLines[7].Visible = true
                    end

                    if character:FindFirstChild("LeftLowerLeg") then
                        local leftLowerLegPos = Camera:WorldToViewportPoint(character.LeftLowerLeg.Position)
                        skeletonLines[8].From = Vector2.new(leftLegPos.X, leftLegPos.Y)
                        skeletonLines[8].To = Vector2.new(leftLowerLegPos.X, leftLowerLegPos.Y)
                        skeletonLines[8].Visible = true
                    end

                    if character:FindFirstChild("RightLowerLeg") then
                        local rightLowerLegPos = Camera:WorldToViewportPoint(character.RightLowerLeg.Position)
                        skeletonLines[9].From = Vector2.new(rightLegPos.X, rightLegPos.Y)
                        skeletonLines[9].To = Vector2.new(rightLowerLegPos.X, rightLowerLegPos.Y)
                        skeletonLines[9].Visible = true
                    end
                else
                    for _, line in pairs(skeletonLines) do
                        line.Visible = false
                    end
                    for _, point in pairs(skeletonPoints) do
                        point.Visible = false
                    end
                end
            else
                for _, line in pairs(skeletonLines) do
                    line.Visible = false
                end
                for _, point in pairs(skeletonPoints) do
                    point.Visible = false
                end
            end
        else
            -- 玩家死亡时隐藏所有组件
            box.Visible = false
            healthBar.Visible = false
            healthBarBackground.Visible = false
            healthBarBorder.Visible = false
            healthText.Visible = false
            nameText.Visible = false
            distanceText.Visible = false
            weaponText.Visible = false
            tracer.Visible = false
            arrow.Visible = false
            for _, line in pairs(skeletonLines) do
                line.Visible = false
            end
            for _, point in pairs(skeletonPoints) do
                point.Visible = false
            end
        end
    end)
end
local radar = Drawing.new("Circle")
radar.Visible = false
radar.Color = Color3.new(1, 1, 1)
radar.Thickness = 2
radar.Filled = false
radar.Radius = 100
radar.Position = Vector2.new(Camera.ViewportSize.X - 120, 120)

local radarCenter = Drawing.new("Circle")
radarCenter.Visible = false
radarCenter.Color = Color3.new(1, 1, 1)
radarCenter.Thickness = 2
radarCenter.Filled = true
radarCenter.Radius = 3
radarCenter.Position = radar.Position

local radarDirection = Drawing.new("Line")
radarDirection.Visible = false
radarDirection.Color = Color3.new(1, 1, 1)
radarDirection.Thickness = 2

local radarGridLines = {}
for i = 1, 4 do
    radarGridLines[i] = Drawing.new("Line")
    radarGridLines[i].Visible = false
    radarGridLines[i].Color = Color3.new(0.5, 0.5, 0.5)
    radarGridLines[i].Thickness = 1
end

local radarRangeText = Drawing.new("Text")
radarRangeText.Visible = false
radarRangeText.Color = Color3.new(1, 1, 1)
radarRangeText.Size = 14
radarRangeText.Font = Drawing.Fonts.Monospace
radarRangeText.Outline = true
radarRangeText.OutlineColor = Color3.new(0, 0, 0)
radarRangeText.Text = "100m"

local radarPlayers = {}

local function updateRadar()
    if not ESPConfig.ShowRadar then
        radar.Visible = false
        radarCenter.Visible = false
        radarDirection.Visible = false
        radarRangeText.Visible = false
        
        for _, line in pairs(radarGridLines) do
            line.Visible = false
        end
        
        for _, player in pairs(radarPlayers) do
            if player.dot then player.dot.Visible = false end
            if player.direction then player.direction.Visible = false end
            if player.name then player.name.Visible = false end
        end
        return
    end

    radar.Visible = true
    radarCenter.Visible = true
    radarDirection.Visible = true
    radarRangeText.Visible = true
    
    radarRangeText.Position = Vector2.new(radar.Position.X, radar.Position.Y + radar.Radius + 5)
    
  
    for i = 1, 4 do
        local angle = (i-1) * math.pi / 2
        radarGridLines[i].From = radar.Position
        radarGridLines[i].To = Vector2.new(
            radar.Position.X + math.cos(angle) * radar.Radius,
            radar.Position.Y + math.sin(angle) * radar.Radius
        )
        radarGridLines[i].Visible = true
    end
    
    radarDirection.From = radar.Position
    radarDirection.To = Vector2.new(radar.Position.X, radar.Position.Y - radar.Radius)

   
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player ~= LocalPlayer then
            local rootPart = player.Character.HumanoidRootPart
            local relativePosition = rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position
            
            local radarX = radar.Position.X + (relativePosition.X / 10)
            local radarY = radar.Position.Y + (relativePosition.Z / 10)
            
            local distanceFromCenter = math.sqrt((radarX - radar.Position.X)^2 + (radarY - radar.Position.Y)^2)
            
            if distanceFromCenter > radar.Radius then
                local angle = math.atan2(radarY - radar.Position.Y, radarX - radar.Position.X)
                radarX = radar.Position.X + math.cos(angle) * radar.Radius
                radarY = radar.Position.Y + math.sin(angle) * radar.Radius
            end
            
            if not radarPlayers[player] then
                radarPlayers[player] = {
                    dot = Drawing.new("Circle"),
                    direction = Drawing.new("Line"),
                    name = Drawing.new("Text")
                }
                
                radarPlayers[player].dot.Thickness = 1
                radarPlayers[player].dot.Filled = true
                radarPlayers[player].dot.Radius = 4
                
                radarPlayers[player].direction.Thickness = 2
                radarPlayers[player].direction.Visible = true
                
                radarPlayers[player].name.Size = 12
                radarPlayers[player].name.Font = Drawing.Fonts.Monospace
                radarPlayers[player].name.Outline = true
                radarPlayers[player].name.OutlineColor = Color3.new(0, 0, 0)
            end
            
         
            if player.Team == LocalPlayer.Team then
                radarPlayers[player].dot.Color = Color3.new(0, 1, 0)  
                radarPlayers[player].direction.Color = Color3.new(0, 0.8, 0)
                radarPlayers[player].name.Color = Color3.new(0, 1, 0)
            else
                radarPlayers[player].dot.Color = Color3.new(1, 0, 0) 
                radarPlayers[player].direction.Color = Color3.new(1, 0, 0)
                radarPlayers[player].name.Color = Color3.new(1, 0, 0)
            end
            
            radarPlayers[player].dot.Position = Vector2.new(radarX, radarY)
            radarPlayers[player].dot.Visible = true
            
         
            local lookVector = rootPart.CFrame.LookVector
            local directionLength = 10
            radarPlayers[player].direction.From = Vector2.new(radarX, radarY)
            radarPlayers[player].direction.To = Vector2.new(
                radarX + lookVector.X * directionLength,
                radarY + lookVector.Z * directionLength
            )
            
            radarPlayers[player].name.Position = Vector2.new(radarX, radarY - 15)
            radarPlayers[player].name.Text = player.Name
            radarPlayers[player].name.Visible = distanceFromCenter <= radar.Radius
        elseif radarPlayers[player] then
            radarPlayers[player].dot.Visible = false
            radarPlayers[player].direction.Visible = false
            radarPlayers[player].name.Visible = false
        end
    end
    for player, components in pairs(radarPlayers) do
        if not Players:FindFirstChild(player.Name) then
            components.dot.Visible = false
            components.direction.Visible = false
            components.name.Visible = false
            radarPlayers[player] = nil
        end
    end
end
RunService.RenderStepped:Connect(updateRadar)
RunService.RenderStepped:Connect(updatePlayerCount)
RunService.RenderStepped:Connect(updateFOV)
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createESP(player)
    end
end
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        createESP(player)
    end
end)
Players.PlayerRemoving:Connect(function(player)
    if ESPComponents[player] then
        for _, component in pairs(ESPComponents[player]) do
            if typeof(component) == "table" then
                for _, drawing in pairs(component) do
                    drawing:Remove()
                end
            else
                component:Remove()
            end
        end
        ESPComponents[player] = nil
    end
end)

Main:Toggle({
    Title = "ESP总开关",
    Value = false,
    Callback = function(value)
        ESPConfig.ESPEnabled = value
    end
})

Main:Toggle({
    Title = "显示方框",
    Value = false,
    Callback = function(value)
        ESPConfig.ShowBox = value
    end
})

Main:Toggle({
    Title = "显示血量",
    Value = false,
    Callback = function(value)
        ESPConfig.ShowHealth = value
    end
})

Main:Toggle({
    Title = "显示名称",
    Value = false,
    Callback = function(value)
        ESPConfig.ShowName = value
    end
})

Main:Toggle({
    Title = "显示距离",
    Value = false,
    Callback = function(value)
        ESPConfig.ShowDistance = value
    end
})

Main:Toggle({
    Title = "显示射线",
    Value = false,
    Callback = function(value)
        ESPConfig.ShowTracer = value
    end
})

Main:Toggle({
    Title = "队伍检查",
    Value = false,
    Callback = function(value)
        ESPConfig.TeamCheck = value
    end
})

Main:Toggle({
    Title = "显示骨骼",
    Value = false,
    Callback = function(value)
        ESPConfig.ShowSkeleton = value
    end
})

Main:Toggle({
    Title = "显示雷达",
    Value = false,
    Callback = function(value)
        ESPConfig.ShowRadar = value
    end
})

Main:Toggle({
    Title = "显示玩家计数",
    Value = false,
    Callback = function(value)
        ESPConfig.ShowPlayerCount = value
    end
})

Main:Toggle({
    Title = "显示武器",
    Value = false,
    Callback = function(value)
        ESPConfig.ShowWeapon = value
    end
})

Main:Toggle({
    Title = "屏幕外箭头",
    Value = false,
    Callback = function(value)
        ESPConfig.OutOfViewArrows = value
    end
})

Main:Toggle({
    Title = "显示 Chams",
    Value = false,
    Callback = function(value)
        ESPConfig.Chams = value
    end
})
Main:Slider({
    Title = "方框粗细",
    Desc = "滑动调整",
    Value = {
        Min = 1,
        Max = 5,
        Default = ESPConfig.BoxThickness,
    },
    Callback = function(Value)
        ESPConfig.BoxThickness = Value
    end
})

Main:Slider({
    Title = "射线粗细",
    Desc = "滑动调整",
    Value = {
        Min = 1,
        Max = 5,
        Default = ESPConfig.TracerThickness,
    },
    Callback = function(Value)
        ESPConfig.TracerThickness = Value
    end
})

Main:Slider({
    Title = "骨骼粗细",
    Desc = "滑动调整",
    Value = {
        Min = 1,
        Max = 5,
        Default = ESPConfig.SkeletonThickness,
    },
    Callback = function(Value)
        ESPConfig.SkeletonThickness = Value
    end
})

Main:Slider({
    Title = "箭头大小",
    Desc = "滑动调整",
    Value = {
        Min = 5,
        Max = 30,
        Default = ESPConfig.ArrowSize,
    },
    Callback = function(Value)
        ESPConfig.ArrowSize = Value
    end
})
Main:Toggle({
    Title = "显示名字血量",
    Value = false,
    Callback = function(enableESP)
        if enableESP then
            local function ApplyESP(v)
                if v.Character and v.Character:FindFirstChildOfClass'Humanoid' then
                    v.Character.Humanoid.NameDisplayDistance = 9e9
                    v.Character.Humanoid.NameOcclusion = "NoOcclusion"
                    v.Character.Humanoid.HealthDisplayDistance = 9e9
                    v.Character.Humanoid.HealthDisplayType = "AlwaysOn"
                    v.Character.Humanoid.Health = v.Character.Humanoid.Health 
                end
            end
            
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            
        
            for i, v in pairs(Players:GetPlayers()) do
                ApplyESP(v)
                v.CharacterAdded:Connect(function()
                    task.wait(0.33)
                    ApplyESP(v)
                end)
            end
            
          
            Players.PlayerAdded:Connect(function(v)
                ApplyESP(v)
                v.CharacterAdded:Connect(function()
                    task.wait(0.33)
                    ApplyESP(v)
                end)
            end)
            
          
            local espConnection = RunService.Heartbeat:Connect(function()
                for i, v in pairs(Players:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChildOfClass'Humanoid' then
                        v.Character.Humanoid.NameDisplayDistance = 9e9
                        v.Character.Humanoid.NameOcclusion = "NoOcclusion"
                        v.Character.Humanoid.HealthDisplayDistance = 9e9
                        v.Character.Humanoid.HealthDisplayType = "AlwaysOn"
                    end
                end
            end)
            
        
            _G.ESPConnection = espConnection
        else
          
            if _G.ESPConnection then
                _G.ESPConnection:Disconnect()
                _G.ESPConnection = nil
            end
            
           
            local Players = game:GetService("Players")
            for i, v in pairs(Players:GetPlayers()) do
                if v.Character and v.Character:FindFirstChildOfClass'Humanoid' then
                    v.Character.Humanoid.NameDisplayDistance = 100
                    v.Character.Humanoid.NameOcclusion = "OccludeAll"
                    v.Character.Humanoid.HealthDisplayDistance = 100
                    v.Character.Humanoid.HealthDisplayType = "DisplayWhenDamaged"
                end
            end
        end
    end
})
local Main = Window:Tab({Title = "人物", Icon = "user"})

Main:Toggle({
    Title = "走路速度(开/关)",
    Default = false,
    Callback = function(v)
        if v == true then
            sudu = game:GetService("RunService").Heartbeat:Connect(function()
                if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid and game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
                    if game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                        game:GetService("Players").LocalPlayer.Character:TranslateBy(game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection * Speed / 10)
                    end
                end
            end)
        elseif not v and sudu then
            sudu:Disconnect()
            sudu = nil
        end
    end
})

Main:Slider({
    Title = "速度设置",
    Desc = "拉条",
    Value = {
        Min = 1,
        Max = 100,
        Default = 1,
    },
    Callback = function(Value)
        Speed = Value
    end
})

Main:Toggle({
    Title = "扩大视野 (开/关)",
    Default = false,
    Callback = function(v)
        if v == true then
            fovConnection = game:GetService("RunService").Heartbeat:Connect(function()
                workspace.CurrentCamera.FieldOfView = 120
            end)
        elseif not v and fovConnection then
            fovConnection:Disconnect()
            fovConnection = nil
        end
    end
})

Main:Slider({
    Title = "视野范围设置",
    Desc = "调整视野大小",
    Value = {
        Min = 70,
        Max = 120,
        Default = 120,
    },
    Callback = function(Value)
        if fovConnection then
            workspace.CurrentCamera.FieldOfView = Value
        end
    end
})


Main:Toggle({
    Title = "隐身",
    Default = false,
    Callback = function(Value)
        if invisThread then
            task.cancel(invisThread)
            invisThread = nil
        end

        if Value then
            invisThread = task.spawn(function()
                local Player = game:GetService("Players").LocalPlayer
                RealCharacter = Player.Character or Player.CharacterAdded:Wait()
                RealCharacter.Archivable = true
                FakeCharacter = RealCharacter:Clone()
                Part = Instance.new("Part")
                Part.Anchored = true
                Part.Size = Vector3.new(200, 1, 200)
                Part.CFrame = CFrame.new(0, -500, 0)
                Part.CanCollide = true
                Part.Parent = workspace
                FakeCharacter.Parent = workspace
                FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)

                for _, v in pairs(RealCharacter:GetChildren()) do
                    if v:IsA("LocalScript") then
                        local clone = v:Clone()
                        clone.Disabled = true
                        clone.Parent = FakeCharacter
                    end
                end

                for _, v in pairs(FakeCharacter:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Transparency = 0.7
                    end
                end

                local function EnableInvisibility()
                    StoredCF = RealCharacter.HumanoidRootPart.CFrame
                    RealCharacter.HumanoidRootPart.CFrame = FakeCharacter.HumanoidRootPart.CFrame
                    FakeCharacter.HumanoidRootPart.CFrame = StoredCF
                    RealCharacter.Humanoid:UnequipTools()
                    Player.Character = FakeCharacter
                    workspace.CurrentCamera.CameraSubject = FakeCharacter.Humanoid
                    RealCharacter.HumanoidRootPart.Anchored = true

                    for _, v in pairs(FakeCharacter:GetChildren()) do
                        if v:IsA("LocalScript") then
                            v.Disabled = false
                        end
                    end
                end

                RealCharacter.Humanoid.Died:Connect(function()
                    if Part then Part:Destroy() end
                    if FakeCharacter then FakeCharacter:Destroy() end
                    Player.Character = RealCharacter
                end)

                EnableInvisibility()

                game:GetService("RunService").RenderStepped:Connect(function()
                    if RealCharacter and RealCharacter:FindFirstChild("HumanoidRootPart") and Part then
                        RealCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
                    end
                end)
            end)
        else
            if Part then Part:Destroy() Part = nil end
            if FakeCharacter then FakeCharacter:Destroy() FakeCharacter = nil end
            if RealCharacter then
                RealCharacter.HumanoidRootPart.Anchored = false
                RealCharacter.HumanoidRootPart.CFrame = StoredCF
                game:GetService("Players").LocalPlayer.Character = RealCharacter
                workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid
            end
        end
    end
})
local adminNames = {
    "LightKorzo",
    "Kehcdc1",
    "kumamlkan1",
    "Realsigmadeeepseek",
    "Ping4HelP",
    "RedRubyyy611",
    "Recall612",
    "Davydevv"
}
local adminCheckConn = nil
local function checkPlayers()
    local localPlayer = game:GetService("Players").LocalPlayer
    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        for _, name in ipairs(adminNames) do
            if plr.Name == name then
                localPlayer:Kick("NE HUB 贵宾版本[防管理]\n检测到管理员: " .. name .. "\n已自动为你退出服务器")
                return
            end
        end
    end
end
Main:Toggle({
    Title   = "防管理员",
    Default = false,
    Callback = function(Value)
        if adminCheckConn then
            adminCheckConn:Disconnect()
            adminCheckConn = nil
        end
        if Value then
            adminCheckConn = game:GetService("RunService").Heartbeat:Connect(function()
                checkPlayers()
            end)
        end
    end
})
Main:Toggle({
    Title = "无限跳",
    Default = false,
    Callback = function(Value)
        local jumpConn
        if Value then
            jumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
                local humanoid = game:GetService("Players").LocalPlayer.Character and
                                 game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if jumpConn then
                jumpConn:Disconnect()
                jumpConn = nil
            end
        end
    end
})

local Main = Window:Tab({Title = "普通气球美化", Icon = "user"})

Main:Toggle({
    Title = "普通气球美化美金气球",
    Default = false,
    Callback = function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "name") == "Balloon" and rawget(v, "holdableType") == "Balloon" then
                v.name, v.cost, v.unpurchasable, v.multiplier, v.movespeedAdd, v.cannotDiscard = "Dollar Balloon", 200, true, 0.8, 8, true
                if v.TPSOffsets then v.TPSOffsets.hold = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.pi, 0) end
                if v.viewportOffsets and v.viewportOffsets.hotbar then v.viewportOffsets.hotbar.dist = 4 end
                v.canDrop, v.dropCooldown, v.craft = nil
                break
            end
        end

        for _, item in pairs(require(game.ReplicatedStorage.devv.client.Objects.v3item.modules.inventory).items) do
            if item.name == "Dollar Balloon" then
                for _, btn in pairs({item.button, item.backpackButton}) do
                    if btn and btn.resetModelSkin then btn:resetModelSkin() end
                end
            end
        end
    end
})

Main:Toggle({
    Title = "普通气球美化黑玫瑰",
    Default = false,
    Callback = function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "name") == "Balloon" and rawget(v, "holdableType") == "Balloon" then
                v.name, v.cost, v.unpurchasable, v.multiplier, v.movespeedAdd, v.cannotDiscard = "Black Rose", 200, true, 0.75, 12, true
                if v.TPSOffsets then v.TPSOffsets.hold = CFrame.new(0, 0.5, 0) end
                if v.viewportOffsets and v.viewportOffsets.hotbar then v.viewportOffsets.hotbar.dist = 3 end
                v.canDrop, v.dropCooldown, v.craft = nil
                break
            end
        end

        for _, item in pairs(require(game.ReplicatedStorage.devv.client.Objects.v3item.modules.inventory).items) do
            if item.name == "Black Rose" then
                for _, btn in pairs({item.button, item.backpackButton}) do
                    if btn and btn.resetModelSkin then btn:resetModelSkin() end
                end
            end
        end
    end
})

local Main = Window:Tab({Title = "r15动画包", Icon = "user"})

    Player:Dropdown({
        Title = "选择一个r15动画包",
        Values = { 
            "吸血鬼", "英雄", "经典僵尸", "法师", "幽灵", 
            "长者", "漂浮", "宇航员", "忍者", "狼人", 
            "卡通", "海盗", "潜行", "玩具", "骑士", 
            "自信", "流行明星", "公主", "牛仔", "巡逻", 
            "僵尸FE"
        },
        Callback = function(Value) 
            if not plr.Character or not plr.Character:FindFirstChild("Animate") then
                return
            end
            
            local Animate = plr.Character.Animate
            Animate.Disabled = true
            StopAnim()
            
            if Value == "吸血鬼" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083445855"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083450166"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083473930"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083462077"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083455352"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083443587"
            elseif Value == "英雄" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
            elseif Value == "经典僵尸" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
            elseif Value == "法师" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=707742142"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=707855907"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=707897309"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=707853694"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=707826056"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
            elseif Value == "幽灵" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
            elseif Value == "长者" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=845397899"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=845400520"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=845403856"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=845386501"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=845398858"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=845392038"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=845396048"
            elseif Value == "漂浮" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
            elseif Value == "宇航员" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
            elseif Value == "忍者" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=656117400"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=656118341"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=656121766"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=656114359"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=656115606"
            elseif Value == "狼人" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083195517"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083214717"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083178339"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083216690"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083182000"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083189019"
            elseif Value == "卡通" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=742637544"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=742638445"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=742640026"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=742638842"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=742637942"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=742636889"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=742637151"
            elseif Value == "海盗" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=750781874"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=750782770"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=750785693"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=750783738"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=750782230"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=750779899"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=750780242"
            elseif Value == "潜行" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1132473842"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1132477671"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1132510133"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1132494274"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1132489853"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1132461372"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1132469004"
            elseif Value == "玩具" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782845736"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=782843345"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=782842708"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=782847020"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=782843869"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
            elseif Value == "骑士" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=657595757"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=657568135"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=657564596"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=658409194"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=658360781"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=657600338"
            elseif Value == "自信" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1069977950"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1069987858"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1070017263"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1070001516"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1069984524"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1069946257"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1069973677"
            elseif Value == "流行明星" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1212900985"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1212900985"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1212980338"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1212980348"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1212954642"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1213044953"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1212900995"
            elseif Value == "公主" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=941003647"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=941013098"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=941028902"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=941015281"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=941008832"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=940996062"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=941000007"
            elseif Value == "牛仔" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1014390418"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1014398616"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1014421541"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1014401683"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1014394726"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1014380606"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1014384571"
            elseif Value == "巡逻" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1149612882"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1150842221"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1151231493"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1150967949"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1150944216"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1148811837"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1148863382"
            elseif Value == "僵尸FE" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=3489171152"
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=3489171152"
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=3489174223"
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=3489173414"
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
            end
            
            if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
            Animate.Disabled = false
        end
    })