local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

local rainbowBorderAnimation
local currentBorderColorScheme = "彩虹颜色"
local currentFontColorScheme = "彩虹颜色"
local borderInitialized = false
local animationSpeed = 2
local borderEnabled = true
local fontColorEnabled = false
local uiScale = 1
local blurEnabled = false
local soundEnabled = true

local FONT_STYLES = {
    "SourceSansBold","SourceSansItalic","SourceSansLight","SourceSans",
    "GothamSSm","GothamSSm-Bold","GothamSSm-Medium","GothamSSm-Light",
    "GothamSSm-Black","GothamSSm-Book","GothamSSm-XLight","GothamSSm-Thin",
    "GothamSSm-Ultra","GothamSSm-SemiBold","GothamSSm-ExtraLight","GothamSSm-Heavy",
    "GothamSSm-ExtraBold","GothamSSm-Regular","Gotham","GothamBold",
    "GothamMedium","GothamBlack","GothamLight","Arial","ArialBold",
    "Code","CodeLight","CodeBold","Highway","HighwayBold","HighwayLight",
    "SciFi","SciFiBold","SciFiItalic","Cartoon","CartoonBold","Handwritten"
}

local FONT_DESCRIPTIONS = {
    ["SourceSansBold"] = "标准粗体",["SourceSansItalic"] = "斜体",["SourceSansLight"] = "细体",
    ["SourceSans"] = "标准体",["GothamSSm"] = "哥特标准",["GothamSSm-Bold"] = "哥特粗体",
    ["GothamSSm-Medium"] = "哥特中等",["GothamSSm-Light"] = "哥特细体",["GothamSSm-Black"] = "哥特黑体",
    ["GothamSSm-Book"] = "哥特书本体",["GothamSSm-XLight"] = "哥特超细体",["GothamSSm-Thin"] = "哥特极细体",
    ["GothamSSm-Ultra"] = "哥特超黑体",["GothamSSm-SemiBold"] = "哥特半粗体",["GothamSSm-ExtraLight"] = "哥特特细体",
    ["GothamSSm-Heavy"] = "哥特粗重体",["GothamSSm-ExtraBold"] = "哥特特粗体",["GothamSSm-Regular"] = "哥特常规体",
    ["Gotham"] = "经典哥特体",["GothamBold"] = "经典哥特粗体",["GothamMedium"] = "经典哥特中等",
    ["GothamBlack"] = "经典哥特黑体",["GothamLight"] = "经典哥特细体",["Arial"] = "标准Arial体",
    ["ArialBold"] = "Arial粗体",["Code"] = "代码字体",["CodeLight"] = "代码细体",
    ["CodeBold"] = "代码粗体",["Highway"] = "高速公路体",["HighwayBold"] = "高速公路粗体",
    ["HighwayLight"] = "高速公路细体",["SciFi"] = "科幻字体",["SciFiBold"] = "科幻粗体",
    ["SciFiItalic"] = "科幻斜体",["Cartoon"] = "卡通字体",["CartoonBold"] = "卡通粗体",
    ["Handwritten"] = "手写体"
}

local currentFontStyle = "SourceSansBold"

local COLOR_SCHEMES = {
    ["彩虹颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),ColorSequenceKeypoint.new(0.16, Color3.fromHex("FFA500")),ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),ColorSequenceKeypoint.new(1, Color3.fromHex("EE82EE"))}),"palette"},
    ["黑红颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("000000")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("FF0000")),ColorSequenceKeypoint.new(1, Color3.fromHex("000000"))}),"alert-triangle"},
    ["蓝白颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("FFFFFF")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("1E90FF")),ColorSequenceKeypoint.new(1, Color3.fromHex("FFFFFF"))}),"droplet"},
    ["紫金颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("FFD700")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("8A2BE2")),ColorSequenceKeypoint.new(1, Color3.fromHex("FFD700"))}),"crown"},
    ["蓝黑颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("000000")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("0000FF")),ColorSequenceKeypoint.new(1, Color3.fromHex("000000"))}),"moon"},
    ["绿紫颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("00FF00")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("800080")),ColorSequenceKeypoint.new(1, Color3.fromHex("00FF00"))}),"zap"},
    ["粉蓝颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("FF69B4")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("00BFFF")),ColorSequenceKeypoint.new(1, Color3.fromHex("FF69B4"))}),"heart"},
    ["橙青颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("FF4500")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("00CED1")),ColorSequenceKeypoint.new(1, Color3.fromHex("FF4500"))}),"sun"},
    ["红金颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("FFD700")),ColorSequenceKeypoint.new(1, Color3.fromHex("FF0000"))}),"award"},
    ["银蓝颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("C0C0C0")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("4682B4")),ColorSequenceKeypoint.new(1, Color3.fromHex("C0C0C0"))}),"star"},
    ["霓虹颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("FF00FF")),ColorSequenceKeypoint.new(0.25, Color3.fromHex("00FFFF")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("FFFF00")),ColorSequenceKeypoint.new(0.75, Color3.fromHex("FF00FF")),ColorSequenceKeypoint.new(1, Color3.fromHex("00FFFF"))}),"sparkles"},
    ["森林颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("228B22")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("32CD32")),ColorSequenceKeypoint.new(1, Color3.fromHex("228B22"))}),"tree"},
    ["火焰颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("FF4500")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("FF0000")),ColorSequenceKeypoint.new(1, Color3.fromHex("FF8C00"))}),"flame"},
    ["海洋颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("000080")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("1E90FF")),ColorSequenceKeypoint.new(1, Color3.fromHex("00BFFF"))}),"waves"},
    ["日落颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("FF4500")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("FF8C00")),ColorSequenceKeypoint.new(1, Color3.fromHex("FFD700"))}),"sunset"},
    ["银河颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("4B0082")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("8A2BE2")),ColorSequenceKeypoint.new(1, Color3.fromHex("9370DB"))}),"galaxy"},
    ["糖果颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("FF69B4")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("FF1493")),ColorSequenceKeypoint.new(1, Color3.fromHex("FFB6C1"))}),"candy"},
    ["金属颜色"] = {ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHex("C0C0C0")),ColorSequenceKeypoint.new(0.5, Color3.fromHex("A9A9A9")),ColorSequenceKeypoint.new(1, Color3.fromHex("696969"))}),"shield"}
}

local fontColorAnimations = {}

local function applyFontColorGradient(textElement, colorScheme)
    if not textElement or not textElement:IsA("TextLabel") and not textElement:IsA("TextButton") and not textElement:IsA("TextBox") then
        return
    end
    
    local existingGradient = textElement:FindFirstChild("FontColorGradient")
    if existingGradient then
        existingGradient:Destroy()
    end
    
    if fontColorAnimations[textElement] then
        fontColorAnimations[textElement]:Disconnect()
        fontColorAnimations[textElement] = nil
    end
    
    if not fontColorEnabled then
        textElement.TextColor3 = Color3.new(1, 1, 1)
        return
    end
    
    local schemeData = COLOR_SCHEMES[colorScheme or currentFontColorScheme]
    if not schemeData then return end
    
    local fontGradient = Instance.new("UIGradient")
    fontGradient.Name = "FontColorGradient"
    fontGradient.Color = schemeData[1]
    fontGradient.Rotation = 0
    fontGradient.Parent = textElement
    
    textElement.TextColor3 = Color3.new(1, 1, 1)
    
    local animation
    animation = game:GetService("RunService").Heartbeat:Connect(function()
        if not textElement or textElement.Parent == nil then
            animation:Disconnect()
            fontColorAnimations[textElement] = nil
            return
        end
        
        if not fontGradient or fontGradient.Parent == nil then
            animation:Disconnect()
            fontColorAnimations[textElement] = nil
            return
        end
        
        local time = tick()
        fontGradient.Rotation = (time * animationSpeed * 30) % 360
    end)
    
    fontColorAnimations[textElement] = animation
end

local function applyFontStyleToWindow(fontStyle)
    if not Window or not Window.UIElements then 
        wait(0.5)
        if not Window or not Window.UIElements then
            return false
        end
    end
    
    local successCount = 0
    local totalCount = 0
    
    local function processElement(element)
        for _, child in ipairs(element:GetDescendants()) do
            if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                totalCount = totalCount + 1
                pcall(function()
                    child.Font = Enum.Font[fontStyle]
                    successCount = successCount + 1
                end)
            end
        end
    end
    
    processElement(Window.UIElements.Main)
    
    return successCount, totalCount
end

local function applyFontColorsToWindow(colorScheme)
    if not Window or not Window.UIElements then return end
    
    local function processElement(element)
        for _, child in ipairs(element:GetDescendants()) do
            if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                applyFontColorGradient(child, colorScheme)
            end
        end
    end
    
    processElement(Window.UIElements.Main)
end

local function createRainbowBorder(window, colorScheme, speed)
    if not window or not window.UIElements then
        wait(1)
        if not window or not window.UIElements then
            return nil, nil
        end
    end
    
    local mainFrame = window.UIElements.Main
    if not mainFrame then
        return nil, nil
    end
    
    local existingStroke = mainFrame:FindFirstChild("RainbowStroke")
    if existingStroke then
        local glowEffect = existingStroke:FindFirstChild("GlowEffect")
        if glowEffect then
            local schemeData = COLOR_SCHEMES[colorScheme or currentBorderColorScheme]
            if schemeData then
                glowEffect.Color = schemeData[1]
            end
        end
        return existingStroke, rainbowBorderAnimation
    end
    
    if not mainFrame:FindFirstChildOfClass("UICorner") then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 16)
        corner.Parent = mainFrame
    end
    
    local rainbowStroke = Instance.new("UIStroke")
    rainbowStroke.Name = "RainbowStroke"
    rainbowStroke.Thickness = 1.5
    rainbowStroke.Color = Color3.new(1, 1, 1)
    rainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    rainbowStroke.LineJoinMode = Enum.LineJoinMode.Round
    rainbowStroke.Enabled = borderEnabled
    rainbowStroke.Parent = mainFrame
    
    local glowEffect = Instance.new("UIGradient")
    glowEffect.Name = "GlowEffect"
    
    local schemeData = COLOR_SCHEMES[colorScheme or currentBorderColorScheme]
    if schemeData then
        glowEffect.Color = schemeData[1]
    else
        glowEffect.Color = COLOR_SCHEMES["彩虹颜色"][1]
    end
    
    glowEffect.Rotation = 0
    glowEffect.Parent = rainbowStroke
    
    return rainbowStroke, nil
end

local function startBorderAnimation(window, speed)
    if not window or not window.UIElements then
        return nil
    end
    
    local mainFrame = window.UIElements.Main
    if not mainFrame then
        return nil
    end
    
    local rainbowStroke = mainFrame:FindFirstChild("RainbowStroke")
    if not rainbowStroke or not rainbowStroke.Enabled then
        return nil
    end
    
    local glowEffect = rainbowStroke:FindFirstChild("GlowEffect")
    if not glowEffect then
        return nil
    end
    
    if rainbowBorderAnimation then
        rainbowBorderAnimation:Disconnect()
        rainbowBorderAnimation = nil
    end
    
    local animation
    animation = game:GetService("RunService").Heartbeat:Connect(function()
        if not rainbowStroke or rainbowStroke.Parent == nil or not rainbowStroke.Enabled then
            animation:Disconnect()
            return
        end
        
        local time = tick()
        glowEffect.Rotation = (time * speed * 60) % 360
    end)
    
    rainbowBorderAnimation = animation
    return animation
end

local function initializeRainbowBorder(scheme, speed)
    speed = speed or animationSpeed
    
    local rainbowStroke, _ = createRainbowBorder(Window, scheme, speed)
    if rainbowStroke then
        if borderEnabled then
            startBorderAnimation(Window, speed)
        end
        borderInitialized = true
        return true
    end
    return false
end

local function gradient(text, startColor, endColor)
    local result = ""
    for i = 1, #text do
        local t = (i - 1) / (#text - 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
    end
    return result
end

local function playSound()
    if soundEnabled then
        pcall(function()
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://9047002353"
            sound.Volume = 0.3
            sound.Parent = game:GetService("SoundService")
            sound:Play()
            game:GetService("Debris"):AddItem(sound, 2)
        end)
    end
end

local function applyBlurEffect(enabled)
    if enabled then
        pcall(function()
            local blur = Instance.new("BlurEffect")
            blur.Size = 8
            blur.Name = "UI大司马脚本Blur"
            blur.Parent = game:GetService("Lighting")
        end)
    else
        pcall(function()
            local existingBlur = game:GetService("Lighting"):FindFirstChild("UI大司马脚本Blur")
            if existingBlur then
                existingBlur:Destroy()
            end
        end)
    end
end

local function applyUIScale(scale)
    if Window and Window.UIElements and Window.UIElements.Main then
        local mainFrame = Window.UIElements.Main
        mainFrame.Size = UDim2.new(0, 600 * scale, 0, 400 * scale)
    end
end

local Confirmed = false

WindUI:Popup({
    Title = "大司马脚本",
    IconThemed = true,
    Content = "欢迎尊贵的用户" .. game.Players.LocalPlayer.Name .. "使用大司马脚本 当前版本型号:V2",
    Buttons = {
        {
            Title = "取消",
            Callback = function() end,
            Variant = "Secondary",
        },
        {
            Title = "执行",
            Icon = "arrow-right",
            Callback = function() 
                Confirmed = true
                createUI()
            end,
            Variant = "Primary",
        }
    }
})

function createUI()
local Window = WindUI:CreateWindow({
    Title = "大司马脚本",
    Icon = "crown",
    Author = "尊贵的"..game.Players.LocalPlayer.Name.."欢迎使用",
    Folder = "RainbowBorder",
    Size = UDim2.fromOffset(300, 200),
    Theme = "Dark",
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            WindUI:Notify({
                Title = "用户信息",
                Content = "用户资料已点击!",
                Duration = 3
            })
        end
    },
    SideBarWidth = 200,
    ScrollBarEnabled = true
})

Window:EditOpenButton({
    Title = "大司马脚本",
    Icon = "crown",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = COLOR_SCHEMES["彩虹颜色"][1],
    Draggable = true
})

Window:Tag({
    Title = "v2",
    Color = Color3.fromHex("#30ff6a")
})

Window:Tag({
    Title = "死铁轨",
    Color = Color3.fromHex("#ff6b6b")
})

Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
    WindUI:Notify({
        Title = "主题已切换",
        Content = "当前主题: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

if not borderInitialized then
    spawn(function()
        wait(0.5)
        initializeRainbowBorder("彩虹颜色", animationSpeed)
        wait(1)
        applyFontStyleToWindow(currentFontStyle)
    end)
end

local windowOpen = true

Window:OnClose(function()
    windowOpen = false
    if rainbowBorderAnimation then
        rainbowBorderAnimation:Disconnect()
        rainbowBorderAnimation = nil
    end
end)

local originalOpenFunction = Window.Open
Window.Open = function(...)
    windowOpen = true
    local result = originalOpenFunction(...)
    
    if borderInitialized and borderEnabled and not rainbowBorderAnimation then
        wait(0.1)
        startBorderAnimation(Window, animationSpeed)
    end
    
    return result
end







local KillAuraTab = Window:Tab({Title = "战斗", Icon = "settings"})

KillAuraTab:Section({Title = "枪械杀戮光环"})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game.Workspace

local ShootRemote = ReplicatedStorage.Remotes.Weapon.Shoot
local ReloadRemote = ReplicatedStorage.Remotes.Weapon.Reload
local Camera = workspace.CurrentCamera or workspace:WaitForChild("Camera")
local LocalPlayer = Players.LocalPlayer

local AutoHeadshotEnabled = false
local AutoReloadEnabled = true
local GunAuraAllMobs = true
local GUN_SEARCH_RADIUS = 1000
local HEADSHOT_DELAY = 0.1
local killAuraCoroutine = nil

local Weapons = {
    ["Revolver"] = true,
    ["Rifle"] = true,
    ["Sawed-Off Shotgun"] = true,
    ["Bolt Action Rifle"] = true,
    ["Navy Revolver"] = true,
    ["Mauser"] = true,
    ["Shotgun"] = true
}

local function getEquippedSupportedWeapon()
    local char = LocalPlayer.Character
    if not char then return nil end
    for name, _ in pairs(Weapons) do
        local tool = char:FindFirstChild(name)
        if tool then
            return tool
        end
    end
    return nil
end

local function isNPC(obj)
    if not obj:IsA("Model") then return false end
    if workspace:FindFirstChild("Horse") and obj:IsDescendantOf(workspace.Horse) then
        return false
    end
    local hum = obj:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    return obj:FindFirstChild("Head")
        and obj:FindFirstChild("HumanoidRootPart")
        and not Players:GetPlayerFromCharacter(obj)
end

local function findAllNPCsInRange()
    local npcs = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if isNPC(obj) then
            local head = obj:FindFirstChild("Head")
            local dist = (head.Position - Camera.CFrame.Position).Magnitude
            if dist <= GUN_SEARCH_RADIUS then
                table.insert(npcs, {
                    model = obj,
                    hum = obj.Humanoid,
                    head = head
                })
            end
        end
    end
    table.sort(npcs, function(a, b)
        return (a.head.Position - Camera.CFrame.Position).Magnitude < (b.head.Position - Camera.CFrame.Position).Magnitude
    end)
    return npcs
end

local function autoHeadshotLoop()
    while AutoHeadshotEnabled do
        local tool = getEquippedSupportedWeapon()
        if tool then
            local npcs = GunAuraAllMobs and findAllNPCsInRange() or {}
            for _, npc in ipairs(npcs) do
                if npc.hum and npc.hum.Health > 0 then
                    local pelletTable = {}
                    if tool.Name:lower():find("shotgun") then
                        for i = 1, 6 do
                            pelletTable[tostring(i)] = npc.hum
                        end
                    else
                        pelletTable["1"] = npc.hum
                    end
                    local shootArgs = {
                        workspace:GetServerTimeNow(),
                        tool,
                        CFrame.new(npc.head.Position + Vector3.new(0, 1.5, 0), npc.head.Position),
                        pelletTable
                    }
                    local success, err = pcall(function()
                        ShootRemote:FireServer(unpack(shootArgs))
                    end)
                    if not success then
                        warn("[杀戮光环] 射击失败: " .. tostring(err))
                    end
                    if AutoReloadEnabled then
                        success, err = pcall(function()
                            ReloadRemote:FireServer(workspace:GetServerTimeNow(), tool)
                        end)
                        if not success then
                            warn("[杀戮光环] 装弹失败: " .. tostring(err))
                        end
                    end
                end
            end
        end
        task.wait(HEADSHOT_DELAY)
    end
end

KillAuraTab:Toggle({
    Title = "枪械杀戮光环",
    Desc = "必须持有枪械",
    Default = false,
    Callback = function(Value)
        AutoHeadshotEnabled = Value
        if Value then
            if not killAuraCoroutine then
                killAuraCoroutine = task.spawn(autoHeadshotLoop)
            end
        else
            AutoHeadshotEnabled = false
        end
    end
})

KillAuraTab:Slider({
    Title = "枪械攻击范围",
    Desc = "调整枪械攻击范围",
    Value = {
        Min = 100,
        Max = 2000,
        Default = 1000
    },
    Callback = function(Value)
        local radius = tonumber(Value)
        GUN_SEARCH_RADIUS = radius or 1000
    end
})

KillAuraTab:Toggle({
    Title = "自动装弹",
    Desc = "自动装填弹药",
    Default = true,
    Callback = function(Value)
        AutoReloadEnabled = Value
    end
})

local quickShootEnabled = false
local quickReloadEnabled = false
local instantKillEnabled = false
local meleeAttackEnabled = false
local attackCount = 100
KillAuraTab:Toggle({
    Title = "开枪无间隔",
    Default = false,
    Callback = function(Value)
        quickShootEnabled = Value
        if Value then
            task.spawn(function()
                while quickShootEnabled do
                    task.wait(0.1)
                    pcall(function()
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                                v.WeaponConfiguration.FireDelay.Value = 0
                            end
                        end
                        for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                            if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                                v.WeaponConfiguration.FireDelay.Value = 0
                            end
                        end
                    end)
                end
            end)
        else
            pcall(function()
                for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                        v.WeaponConfiguration.FireDelay.Value = 0.2
                    end
                end
                for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                        v.WeaponConfiguration.FireDelay.Value = 0.2
                    end
                end
            end)
        end
    end
})

KillAuraTab:Toggle({
    Title = "无换弹时间",
    Desc = "瞬间装弹",
    Default = false,
    Callback = function(Value)
        quickReloadEnabled = Value
        if Value then
            task.spawn(function()
                while quickReloadEnabled do
                    task.wait(0.1)
                    pcall(function()
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                                v.WeaponConfiguration.ReloadDuration.Value = 0
                            end
                        end
                        for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                            if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                                v.WeaponConfiguration.ReloadDuration.Value = 0
                            end
                        end
                    end)
                end
            end)
        else
            pcall(function()
                for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                        v.WeaponConfiguration.ReloadDuration.Value = 2
                    end
                end
                for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                        v.WeaponConfiguration.ReloadDuration.Value = 2
                    end
                end
            end)
        end
    end
})
KillAuraTab:Toggle({
    Title = "秒杀子弹",
    Default = false,
    Callback = function(Value)
        instantKillEnabled = Value
        if Value then
            task.spawn(function()
                while instantKillEnabled do
                    task.wait(0.1)
                    pcall(function()
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                                local magazineFed = v.WeaponConfiguration:FindFirstChild("MagazineFed")
                                if not magazineFed then
                                    magazineFed = Instance.new("BoolValue")
                                    magazineFed.Name = "MagazineFed"
                                    magazineFed.Value = true
                                    magazineFed.Parent = v.WeaponConfiguration
                                end
                            end
                        end
                        for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                            if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                                local magazineFed = v.WeaponConfiguration:FindFirstChild("MagazineFed")
                                if not magazineFed then
                                    magazineFed = Instance.new("BoolValue")
                                    magazineFed.Name = "MagazineFed"
                                    magazineFed.Value = true
                                    magazineFed.Parent = v.WeaponConfiguration
                                end
                            end
                        end
                    end)
                end
            end)
        else
            pcall(function()
                for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                        local magazineFed = v.WeaponConfiguration:FindFirstChild("MagazineFed")
                        if magazineFed then
                            magazineFed:Destroy()
                        end
                    end
                end
                for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChild("WeaponConfiguration") then
                        local magazineFed = v.WeaponConfiguration:FindFirstChild("MagazineFed")
                        if magazineFed then
                            magazineFed:Destroy()
                        end
                    end
                end
            end)
        end
    end
})


KillAuraTab:Section({Title = "近战类"})

local MELEE_SEARCH_RADIUS = 50
local meleeAuraEnabled = false
local meleeAuraCoroutine = nil

local function isMeleeWeapon(tool)
    local meleeWeapons = {
        "Axe", "Pickaxe", "Sword", "Knife", "Bat", "Hammer",
        "Crowbar", "Machete", "Katana", "Spear", "Club"
    }
    
    for _, weaponName in ipairs(meleeWeapons) do
        if tool.Name:lower():find(weaponName:lower()) then
            return true
        end
    end
    return false
end

local function findMeleeTargets()
    local targets = {}
    local character = LocalPlayer.Character
    if not character then return targets end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return targets end
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if isNPC(obj) then
            local hrp = obj:FindFirstChild("HumanoidRootPart")
            if hrp then
                local distance = (hrp.Position - rootPart.Position).Magnitude
                if distance <= MELEE_SEARCH_RADIUS then
                    table.insert(targets, {
                        model = obj,
                        humanoid = obj.Humanoid,
                        distance = distance
                    })
                end
            end
        end
    end
    
    table.sort(targets, function(a, b)
        return a.distance < b.distance
    end)
    
    return targets
end

local function meleeAttackLoop()
    while meleeAuraEnabled do
        local character = LocalPlayer.Character
        if character then
            local tool = nil
            
            for _, child in ipairs(character:GetChildren()) do
                if child:IsA("Tool") and isMeleeWeapon(child) then
                    tool = child
                    break
                end
            end
            
            if not tool then
                for _, child in ipairs(LocalPlayer.Backpack:GetChildren()) do
                    if child:IsA("Tool") and isMeleeWeapon(child) then
                        tool = child
                        tool.Parent = character
                        task.wait(0.1)
                        break
                    end
                end
            end
            
            if tool then
                local targets = findMeleeTargets()
                for _, target in ipairs(targets) do
                    if target.humanoid and target.humanoid.Health > 0 then
                        tool:Activate()
                        task.wait(0.2)
                    end
                end
            end
        end
        task.wait(0.1)
    end
end

KillAuraTab:Toggle({
    Title = "近战杀戮光环",
    Default = false,
    Callback = function(Value)
        meleeAuraEnabled = Value
        if Value then
            if not meleeAuraCoroutine then
                meleeAuraCoroutine = task.spawn(meleeAttackLoop)
            end
        else
            meleeAuraEnabled = false
        end
    end
})

KillAuraTab:Slider({
    Title = "近战攻击范围",
    Desc = "调整近战攻击范围",
    Value = {
        Min = 10,
        Max = 100,
        Default = 50
    },
    Callback = function(Value)
        MELEE_SEARCH_RADIUS = Value
    end
})


KillAuraTab:Slider({
    Title = "攻击次数",
    Desc = "每次攻击的次数",
    Value = {
        Min = 1,
        Max = 300,
        Default = 100
    },
    Callback = function(Value)
        attackCount = Value
    end
})

KillAuraTab:Toggle({
    Title = "工具快速攻击",
    Default = false,
    Callback = function(Value)
        meleeAttackEnabled = Value
        if Value then
            task.spawn(function()
                while meleeAttackEnabled do
                    task.wait(0.2)
                    pcall(function()
                        local player = game.Players.LocalPlayer
                        local character = player.Character
                        if not character or not character:FindFirstChild("HumanoidRootPart") then
                            return
                        end

                        for _, v in pairs(player.Backpack:GetChildren()) do
                            if v:IsA("Tool") and v:FindFirstChild("Configuration") and 
                               v.Configuration:FindFirstChild("Animations") and 
                               v.Configuration.Animations:FindFirstChild("SwingAnimation") then
                                v.Parent = character
                            end
                        end

                        for _, v in pairs(character:GetChildren()) do
                            if v:IsA("Tool") and v:FindFirstChild("Configuration") and 
                               v.Configuration:FindFirstChild("Animations") and 
                               v.Configuration.Animations:FindFirstChild("SwingAnimation") then
                                for i = 1, attackCount do
                                    for u = 1, 10 do
                                        game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.ChargeMelee:FireServer(v, workspace:GetServerTimeNow())
                                        game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.SwingMelee:FireServer(v, workspace:GetServerTimeNow(), Vector3.new(0, 0, 0))
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end
})
local AutoHealTab = Window:Tab({Title = "治疗类", Icon = "settings"})
AutoHealTab:Section({Title = "绷带设置"})

local AutoBandageConfig = {
    Enabled = false,
    MinHealth = 50,
    Active = false,
    Cooldown = 3,
    SearchBackpack = true
}

local function FindBandage()
    local player = game:GetService("Players").LocalPlayer
    
    if AutoBandageConfig.SearchBackpack then
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            local bandage = backpack:FindFirstChild("Bandage")
            if bandage then return bandage end
        end
    end
    
    local character = player.Character
    if character then
        return character:FindFirstChild("Bandage")
    end
    
    return nil
end

local function UseBandage()
    local bandage = FindBandage()
    if bandage and bandage:FindFirstChild("Use") then
        bandage.Use:FireServer()
        return true
    end
    return false
end

local function RunBandageLoop()
    if AutoBandageConfig.Active then return end
    AutoBandageConfig.Active = true
    
    while AutoBandageConfig.Enabled do
        local success, err = pcall(function()
            local player = game:GetService("Players").LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            if humanoid and humanoid.Health < AutoBandageConfig.MinHealth then
                if UseBandage() then
                    task.wait(AutoBandageConfig.Cooldown)
                else
                    task.wait(1)
                end
            else
                task.wait(0.5)
            end
        end)
        
        if not success then
            warn("AutoBandage Error: "..tostring(err))
            task.wait(1)
        end
    end
    
    AutoBandageConfig.Active = false
end

AutoHealTab:Toggle({
    Title = "自动使用绷带",
    Default = false,
    Callback = function(Value)
        AutoBandageConfig.Enabled = Value
        if Value then
            coroutine.wrap(RunBandageLoop)()
        end
    end
})

AutoHealTab:Slider({
    Title = "绷带使用血量限制",
    Desc = "当生命值低于此值时自动使用绷带",
    Value = {
        Min = 1,
        Max = 100,
        Default = 50
    },
    Callback = function(Value)
        AutoBandageConfig.MinHealth = Value
    end
})

AutoHealTab:Slider({
    Title = "绷带使用冷却时间",
    Desc = "两次使用之间的间隔时间",
    Value = {
        Min = 1,
        Max = 10,
        Default = 3
    },
    Callback = function(Value)
        AutoBandageConfig.Cooldown = Value
    end
})

AutoHealTab:Section({Title = "蛇油设置"})

local AutoSnakeOilConfig = {
    Enabled = false,
    MinHealth = 50,
    Active = false,
    Cooldown = 5
}

local function FindSnakeOil()
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return nil end
    
    local snakeOil = backpack:FindFirstChild("Snake Oil")
    if snakeOil then return snakeOil end
    
    local character = player.Character
    if character then
        return character:FindFirstChild("Snake Oil")
    end
    
    return nil
end

local function UseSnakeOil()
    local snakeOil = FindSnakeOil()
    if snakeOil and snakeOil:FindFirstChild("Use") then
        local args = {[1] = snakeOil}
        snakeOil.Use:FireServer(unpack(args))
        return true
    end
    return false
end

local function RunSnakeOilLoop()
    if AutoSnakeOilConfig.Active then return end
    AutoSnakeOilConfig.Active = true
    
    while AutoSnakeOilConfig.Enabled do
        local success, err = pcall(function()
            local player = game:GetService("Players").LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            if humanoid and humanoid.Health < AutoSnakeOilConfig.MinHealth then
                if UseSnakeOil() then
                    task.wait(AutoSnakeOilConfig.Cooldown)
                else
                    task.wait(1)
                end
            else
                task.wait(0.5)
            end
        end)
        
        if not success then
            warn("AutoSnakeOil Error: "..tostring(err))
            task.wait(1)
        end
    end
    
    AutoSnakeOilConfig.Active = false
end

AutoHealTab:Toggle({
    Title = "自动使用蛇油",
    Default = false,
    Callback = function(Value)
        AutoSnakeOilConfig.Enabled = Value
        if Value then
            coroutine.wrap(RunSnakeOilLoop)()
        end
    end
})

AutoHealTab:Slider({
    Title = "蛇油使用血量限制",
    Desc = "当生命值低于此值时自动使用蛇油",
    Value = {
        Min = 1,
        Max = 100,
        Default = 50
    },
    Callback = function(Value)
        AutoSnakeOilConfig.MinHealth = Value
    end
})

AutoHealTab:Slider({
    Title = "蛇油使用冷却时间",
    Desc = "两次使用之间的间隔时间",
    Value = {
        Min = 1,
        Max = 30,
        Default = 5
    },
    Callback = function(Value)
        AutoSnakeOilConfig.Cooldown = Value
    end
})


local CollectAuraTab = Window:Tab({Title = "收集光环", Icon = "settings"})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game.Workspace

local LocalPlayer = Players.LocalPlayer
local AutoCollectMoneybagEnabled = false
local AutoCollectBondEnabled = false
local MONEY_SEARCH_RADIUS = 30
local COLLECT_DELAY = 0.1
local moneybagCoroutine = nil
local bondCoroutine = nil

local function findAllMoneybagsInRange()
    local moneybags = {}
    for _, item in ipairs(workspace.RuntimeItems:GetChildren()) do
        if item.Name == "Moneybag" then
            local dist = (item:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude
            if dist <= MONEY_SEARCH_RADIUS then
                table.insert(moneybags, item)
            end
        end
    end
    return moneybags
end

local function autoMoneybagLoop()
    while AutoCollectMoneybagEnabled do
        local moneybags = findAllMoneybagsInRange()
        for _, moneybag in ipairs(moneybags) do
            if moneybag:FindFirstChild("MoneyBag") then
                fireproximityprompt(moneybag.MoneyBag.CollectPrompt)
            end
        end
        task.wait(COLLECT_DELAY)
    end
end

CollectAuraTab:Toggle({
    Title = "钱袋收集光环",
    Desc = "自动收集范围内的钱袋",
    Default = false,
    Callback = function(Value)
        AutoCollectMoneybagEnabled = Value
        if Value then
            if not moneybagCoroutine then
                moneybagCoroutine = task.spawn(autoMoneybagLoop)
            end
        else
            AutoCollectMoneybagEnabled = false
        end
    end
})

local function findAllBondsInRange()
    local bonds = {}
    for _, item in ipairs(workspace.RuntimeItems:GetChildren()) do
        if item.Name == "Bond" then
            local dist = (item:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude
            if dist <= MONEY_SEARCH_RADIUS then
                table.insert(bonds, item)
            end
        end
    end
    return bonds
end

local function autoBondLoop()
    while AutoCollectBondEnabled do
        local bonds = findAllBondsInRange()
        for _, bond in ipairs(bonds) do
            ReplicatedStorage.Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer(bond)
        end
        task.wait(COLLECT_DELAY)
    end
end

CollectAuraTab:Toggle({
    Title = "债券收集光环",
    Desc = "自动收集范围内的债券",
    Default = false,
    Callback = function(Value)
        AutoCollectBondEnabled = Value
        if Value then
            if not bondCoroutine then
                bondCoroutine = task.spawn(autoBondLoop)
            end
        else
            AutoCollectBondEnabled = false
        end
    end
})

CollectAuraTab:Slider({
    Title = "收集范围",
    Desc = "调整自动收集范围",
    Value = {
        Min = 10,
        Max = 100,
        Default = 30
    },
    Callback = function(Value)
        MONEY_SEARCH_RADIUS = Value
    end
})

local AutoCollectOtherEnabled = false
local AutoCollectToolEnabled = false
local AutoCollectAmmoEnabled = false
local AutoCollectArmorEnabled = false
local otherCoroutine = nil
local toolCoroutine = nil
local ammoCoroutine = nil
local armorCoroutine = nil

local function findAllOtherItemsInRange()
    local items = {}
    for _, item in ipairs(workspace.RuntimeItems:GetChildren()) do
        local dist = (item:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude
        if dist <= MONEY_SEARCH_RADIUS and (item.Name ~= "Bond" and item.Name ~= "RevolverAmmo" and item.Name ~= "RifleAmmo" and item.Name ~= "ShotgunShells") then
            table.insert(items, item)
        end
    end
    return items
end

local function autoOtherLoop()
    while AutoCollectOtherEnabled do
        local items = findAllOtherItemsInRange()
        for _, item in ipairs(items) do
            ReplicatedStorage.Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer(item)
        end
        task.wait(COLLECT_DELAY)
    end
end

CollectAuraTab:Toggle({
    Title = "物品收集光环",
    Desc = "自动收集范围内的物品",
    Default = false,
    Callback = function(Value)
        AutoCollectOtherEnabled = Value
        if Value then
            if not otherCoroutine then
                otherCoroutine = task.spawn(autoOtherLoop)
            end
        else
            AutoCollectOtherEnabled = false
        end
    end
})

local function findAllToolsInRange()
    local tools = {}
    for _, item in ipairs(workspace.RuntimeItems:GetChildren()) do
        local dist = (item:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude
        if dist <= MONEY_SEARCH_RADIUS and not item:GetAttribute("BuyPrice") then
            table.insert(tools, item)
        end
    end
    return tools
end

local function autoToolLoop()
    while AutoCollectToolEnabled do
        local tools = findAllToolsInRange()
        for _, tool in ipairs(tools) do
            ReplicatedStorage.Remotes.Tool.PickUpTool:FireServer(tool)
        end
        task.wait(COLLECT_DELAY)
    end
end

CollectAuraTab:Toggle({
    Title = "工具收集光环",
    Desc = "自动收集范围内的工具",
    Default = false,
    Callback = function(Value)
        AutoCollectToolEnabled = Value
        if Value then
            if not toolCoroutine then
                toolCoroutine = task.spawn(autoToolLoop)
            end
        else
            AutoCollectToolEnabled = false
        end
    end
})

local function findAllAmmoInRange()
    local ammo = {}
    for _, item in ipairs(workspace.RuntimeItems:GetChildren()) do
        local dist = (item:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude
        if dist <= MONEY_SEARCH_RADIUS and (item.Name == "RevolverAmmo" or item.Name == "RifleAmmo" or item.Name == "ShotgunShells") and not item:GetAttribute("BuyPrice") then
            table.insert(ammo, item)
        end
    end
    return ammo
end

local function autoAmmoLoop()
    while AutoCollectAmmoEnabled do
        local ammo = findAllAmmoInRange()
        for _, ammoItem in ipairs(ammo) do
            ReplicatedStorage.Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer(ammoItem)
        end
        task.wait(COLLECT_DELAY)
    end
end

CollectAuraTab:Toggle({
    Title = "子弹收集光环",
    Desc = "自动收集范围内的子弹",
    Default = false,
    Callback = function(Value)
        AutoCollectAmmoEnabled = Value
        if Value then
            if not ammoCoroutine then
                ammoCoroutine = task.spawn(autoAmmoLoop)
            end
        else
            AutoCollectAmmoEnabled = false
        end
    end
})

local function findAllArmorInRange()
    local armor = {}
    for _, item in ipairs(workspace.RuntimeItems:GetChildren()) do
        local dist = (item:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude
        if dist <= MONEY_SEARCH_RADIUS and not item:GetAttribute("BuyPrice") then
            table.insert(armor, item)
        end
    end
    return armor
end

local function autoArmorLoop()
    while AutoCollectArmorEnabled do
        local armor = findAllArmorInRange()
        for _, armorItem in ipairs(armor) do
            ReplicatedStorage.Remotes.Object.EquipObject:FireServer(armorItem)
        end
        task.wait(COLLECT_DELAY)
    end
end

CollectAuraTab:Toggle({
    Title = "装甲收集光环",
    Desc = "自动收集范围内的装甲",
    Default = false,
    Callback = function(Value)
        AutoCollectArmorEnabled = Value
        if Value then
            if not armorCoroutine then
                armorCoroutine = task.spawn(autoArmorLoop)
            end
        else
            AutoCollectArmorEnabled = false
        end
    end
})

local AutoCollectBandageEnabled = false
local AutoCollectSnakeOilEnabled = false
local bandageCoroutine = nil
local snakeOilCoroutine = nil

local function findAllBandagesInRange()
    local bandages = {}
    for _, item in ipairs(workspace.RuntimeItems:GetChildren()) do
        if item.Name == "Bandage" then
            local dist = (item:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude
            if dist <= MONEY_SEARCH_RADIUS then
                table.insert(bandages, item)
            end
        end
    end
    return bandages
end

local function autoBandageLoop()
    while AutoCollectBandageEnabled do
        local bandages = findAllBandagesInRange()
        for _, bandage in ipairs(bandages) do
            ReplicatedStorage.Remotes.Tool.PickUpTool:FireServer(bandage)
        end
        task.wait(COLLECT_DELAY)
    end
end

CollectAuraTab:Toggle({
    Title = "绷带收集光环",
    Desc = "自动收集范围内的绷带",
    Default = false,
    Callback = function(Value)
        AutoCollectBandageEnabled = Value
        if Value then
            if not bandageCoroutine then
                bandageCoroutine = task.spawn(autoBandageLoop)
            end
        else
            AutoCollectBandageEnabled = false
        end
    end
})

local function findAllSnakeOilInRange()
    local snakeOils = {}
    for _, item in ipairs(workspace.RuntimeItems:GetChildren()) do
        if item.Name == "Snake Oil" then
            local dist = (item:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude
            if dist <= MONEY_SEARCH_RADIUS then
                table.insert(snakeOils, item)
            end
        end
    end
    return snakeOils
end

local function autoSnakeOilLoop()
    while AutoCollectSnakeOilEnabled do
        local snakeOils = findAllSnakeOilInRange()
        for _, snakeOil in ipairs(snakeOils) do
            ReplicatedStorage.Remotes.Tool.PickUpTool:FireServer(snakeOil)
        end
        task.wait(COLLECT_DELAY)
    end
end

CollectAuraTab:Toggle({
    Title = "蛇油收集光环",
    Desc = "自动收集范围内的蛇油",
    Default = false,
    Callback = function(Value)
        AutoCollectSnakeOilEnabled = Value
        if Value then
            if not snakeOilCoroutine then
                snakeOilCoroutine = task.spawn(autoSnakeOilLoop)
            end
        else
            AutoCollectSnakeOilEnabled = false
        end
    end
})

local TrainTab = Window:Tab({Title = "火车类", Icon = "settings"})
TrainTab:Section({Title = "火车控制"})

local autoThrottleEnabled = false
local autoBurningFuelEnabled = false
local autoBurningZombieEnabled = false

TrainTab:Toggle({
    Title = "自动开火车",
    Default = false,
    Callback = function(Value)
        autoThrottleEnabled = Value
        game:GetService("RunService").RenderStepped:Connect(function()
            if autoThrottleEnabled then
                for _,v in next,workspace:GetChildren() do
                    if v:GetAttribute("Stopped") ~= nil then
                        if math.abs(v.RequiredComponents.Controls.ConductorSeat.VehicleSeat.Throttle) == 0 then
                            v.RequiredComponents.Controls.ConductorSeat.VehicleSeat.Throttle = 1
                        end
                    end
                end
            end
        end)
    end
})

TrainTab:Toggle({
    Title = "自动烧煤",
    Default = false,
    Callback = function(Value)
        autoBurningFuelEnabled = Value
        task.spawn(function()
            while autoBurningFuelEnabled do
                task.wait(0.1)
                pcall(function()
                    for _, v in next, workspace.RuntimeItems:GetChildren() do
                        if v:GetAttribute("Fuel") and v:GetAttribute("Fuel") > 0 then
                            for _, z in next, workspace:GetChildren() do
                                if z:GetAttribute("Stopped") ~= nil then
                                    local distance = (v:GetPivot().Position - game.Players.LocalPlayer.Character:GetPivot().Position).Magnitude
                                    if distance <= 30 then
                                        game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(v)
                                        task.wait(.5)
                                        v.PrimaryPart.DragAttachment:Destroy()
                                        v.PrimaryPart.DragAlignPosition:Destroy()
                                        v.PrimaryPart.DragAlignOrientation:Destroy()
                                        v:PivotTo(z.RequiredComponents.FuelZone:GetPivot())
                                        task.wait(0.01)
                                        game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
})

TrainTab:Toggle({
    Title = "自动烧丧尸",
    Default = false,
    Callback = function(Value)
        autoBurningZombieEnabled = Value
        task.spawn(function()
            while autoBurningZombieEnabled do
                task.wait(0.1)
                pcall(function()
                    for _, v in next, workspace.RuntimeItems:GetChildren() do
                        if v:GetAttribute("Fuel") and v:GetAttribute("Fuel") > 0 and (v.Name:find("Walker") or v.Name:find("Runner")) then
                            for _, z in next, workspace:GetChildren() do
                                if z:GetAttribute("Stopped") ~= nil then
                                    local distance = (v:GetPivot().Position - game.Players.LocalPlayer.Character:GetPivot().Position).Magnitude
                                    if distance <= 30 then
                                        game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(v)
                                        task.wait(.5)
                                        v.PrimaryPart.DragAttachment:Destroy()
                                        v.PrimaryPart.DragAlignPosition:Destroy()
                                        v.PrimaryPart.DragAlignOrientation:Destroy()
                                        v:PivotTo(z.RequiredComponents.FuelZone:GetPivot())
                                        task.wait(0.01)
                                        game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
})

TrainTab:Section({Title = "火车传送"})

TrainTab:Button({
    Title = "传送火车",
    Callback = function()
        for _, v in next, workspace:GetChildren() do
            if v:GetAttribute("Stopped") ~= nil then
                local oldPos = v.RequiredComponents.Controls.ConductorSeat.VehicleSeat:GetPivot()
                repeat
                    local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                    if hum then
                        local seat = v.RequiredComponents.Controls.ConductorSeat.VehicleSeat
                        if seat:FindFirstChild("SeatWeld") then break end
                        seat.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        firetouchinterest(seat, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
                        firetouchinterest(seat, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
                    end
                    task.wait(0.01)
                until seat:FindFirstChild("SeatWeld")
                v.RequiredComponents.Controls.ConductorSeat.VehicleSeat:PivotTo(oldPos)
            end
        end
    end
})

TrainTab:Button({
    Title = "随处固定",
    Callback = function()
        if not game.CoreGui:FindFirstChild("WeldGui") then
            local WeldGUI = Instance.new("ScreenGui")
            WeldGUI.Name = "WeldGui"
            WeldGUI.ResetOnSpawn = false
            WeldGUI.Parent = game:GetService("CoreGui")
            
            local WeldFrame = Instance.new("Frame")
            WeldFrame.Size = UDim2.new(0, 200, 0, 60)
            WeldFrame.Position = UDim2.new(0.85, -100, 0.75, -180)
            WeldFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            WeldFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            WeldFrame.BackgroundTransparency = 0.3
            WeldFrame.BorderSizePixel = 0
            WeldFrame.Active = true
            WeldFrame.Draggable = true
            WeldFrame.Parent = WeldGUI
            
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 12)
            UICorner.Parent = WeldFrame
            
            local WeldToggleButton = Instance.new("TextButton")
            WeldToggleButton.Size = UDim2.new(1, -20, 0, 40)
            WeldToggleButton.Position = UDim2.new(0, 10, 0, 10)
            WeldToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            WeldToggleButton.BackgroundTransparency = 0.4
            WeldToggleButton.Text = "固定"
            WeldToggleButton.TextColor3 = Color3.new(1, 1, 1)
            WeldToggleButton.Font = Enum.Font.Fantasy
            WeldToggleButton.TextSize = 22
            WeldToggleButton.Parent = WeldFrame
            
            WeldToggleButton.MouseButton1Click:Connect(function()
                for _, model in pairs(workspace.RuntimeItems:GetChildren()) do
                    if model:IsA("Model") and model.PrimaryPart and model.PrimaryPart:FindFirstChild("DragAlignPosition") then
                        if not model.PrimaryPart:FindFirstChild("DragWeldConstraint") then
                            for _, target in pairs(workspace:GetChildren()) do
                                if target:IsA("Model") and target:FindFirstChild("RequiredComponents") and
                                   target.RequiredComponents:FindFirstChild("Base") then
                                    game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestWeld:FireServer(model, target.RequiredComponents.Base)
                                end
                            end
                        end
                    end
                end
            end)
    
            local UICorner2 = Instance.new("UICorner")
            UICorner2.CornerRadius = UDim.new(0, 12)
            UICorner2.Parent = WeldToggleButton
        end
    end
})

local ESPTab = Window:Tab({Title = "透视", Icon = "settings"})

ESPTab:Section({Title = "物品透视"})

local itemESPEnabled = false
local oreESPEnabled = false
local nightEnemiesESPEnabled = false
local unicornESPEnabled = false
local buildESPEnabled = false
local buildZombieESPEnabled = false
local bankESPEnabled = false
local bondESPEnabled = false

local rainbowColors = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 127, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(139, 0, 255),
    Color3.fromRGB(255, 0, 255)
}

-- 存储ESP对象的表
local ESPObjects = {
    itemESP = {},
    oreESP = {},
    nightEnemiesESP = {},
    unicornESP = {},
    buildESP = {},
    buildZombieESP = {},
    bankESP = {},
    bondESP = {}
}

local function createESP(parent, text, espType)
    if not parent or parent.Parent == nil then return end
    
    -- 创建高亮效果
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESPHighlight"
    highlight.Parent = parent
    highlight.FillTransparency = 0.7
    highlight.OutlineTransparency = 0
    highlight.Adornee = parent
    
    -- 创建彩虹公告板
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "RainbowBillboard"
    billboard.Parent = parent
    billboard.Adornee = parent
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.Enabled = true
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "ESPLabel"
    nameLabel.Parent = billboard
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = text
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.TextScaled = false
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    
    -- 彩虹颜色效果
    local colorIndex = 1
    local rainbowConnection
    rainbowConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not parent or parent.Parent == nil then
            rainbowConnection:Disconnect()
            return
        end
        highlight.FillColor = rainbowColors[colorIndex]
        highlight.OutlineColor = rainbowColors[colorIndex]
        nameLabel.TextColor3 = rainbowColors[colorIndex]
        colorIndex = colorIndex + 1
        if colorIndex > #rainbowColors then
            colorIndex = 1
        end
    end)
    
    -- 存储ESP对象
    table.insert(ESPObjects[espType], {
        Parent = parent,
        Highlight = highlight,
        Billboard = billboard,
        Connection = rainbowConnection
    })
    
    return highlight, billboard
end

local function clearESP(espType)
    for i, espData in ipairs(ESPObjects[espType]) do
        if espData.Highlight and espData.Highlight.Parent then
            espData.Highlight:Destroy()
        end
        if espData.Billboard and espData.Billboard.Parent then
            espData.Billboard:Destroy()
        end
        if espData.Connection then
            espData.Connection:Disconnect()
        end
    end
    ESPObjects[espType] = {}
end

local function clearAllESP()
    for espType, _ in pairs(ESPObjects) do
        clearESP(espType)
    end
end

-- 物品透视
ESPTab:Toggle({
    Title = "物品透视",
    Default = false,
    Callback = function(Value)
        itemESPEnabled = Value
        if Value then
            for _, v in ipairs(workspace.RuntimeItems:GetChildren()) do
                if v:IsA("Model") and not v:FindFirstChild("ESPHighlight") then
                    createESP(v, v.Name:gsub("Model_", ""), "itemESP")
                end
            end
            
            workspace.RuntimeItems.ChildAdded:Connect(function(v)
                if v:IsA("Model") and not v:FindFirstChild("ESPHighlight") and itemESPEnabled then
                    createESP(v, v.Name:gsub("Model_", ""), "itemESP")
                end
            end)
        else
            clearESP("itemESP")
        end
    end
})

-- 矿石透视
ESPTab:Toggle({
    Title = "矿石透视",
    Default = false,
    Callback = function(Value)
        oreESPEnabled = Value
        if Value then
            if workspace:FindFirstChild("Ore") then
                for _, v in ipairs(workspace.Ore:GetChildren()) do
                    if v:IsA("Model") and not v:FindFirstChild("ESPHighlight") then
                        createESP(v, v.Name, "oreESP")
                    end
                end
                
                workspace.Ore.ChildAdded:Connect(function(v)
                    if v:IsA("Model") and not v:FindFirstChild("ESPHighlight") and oreESPEnabled then
                        createESP(v, v.Name, "oreESP")
                    end
                end)
            end
        else
            clearESP("oreESP")
        end
    end
})

-- 夜晚怪物透视
ESPTab:Toggle({
    Title = "夜晚怪物透视",
    Default = false,
    Callback = function(Value)
        nightEnemiesESPEnabled = Value
        if Value then
            if workspace:FindFirstChild("NightEnemies") then
                for _, v in ipairs(workspace.NightEnemies:GetChildren()) do
                    if v:IsA("Model") and not v:FindFirstChild("ESPHighlight") then
                        createESP(v, v.Name, "nightEnemiesESP")
                    end
                end
                
                workspace.NightEnemies.ChildAdded:Connect(function(v)
                    if v:IsA("Model") and not v:FindFirstChild("ESPHighlight") and nightEnemiesESPEnabled then
                        createESP(v, v.Name, "nightEnemiesESP")
                    end
                end)
            end
        else
            clearESP("nightEnemiesESP")
        end
    end
})

-- 独角兽透视
ESPTab:Toggle({
    Title = "独角兽透视",
    Default = false,
    Callback = function(Value)
        unicornESPEnabled = Value
        if Value then
            for _, v in ipairs(workspace:GetDescendants()) do
                if v.Name == "Unicorn" and v:IsA("Model") and not v:FindFirstChild("ESPHighlight") then
                    createESP(v, "独角兽", "unicornESP")
                end
            end
            
            local unicornConnection
            unicornConnection = workspace.DescendantAdded:Connect(function(v)
                if v.Name == "Unicorn" and v:IsA("Model") and not v:FindFirstChild("ESPHighlight") and unicornESPEnabled then
                    createESP(v, "独角兽", "unicornESP")
                end
            end)
            
            table.insert(ESPObjects.unicornESP, {Connection = unicornConnection})
        else
            clearESP("unicornESP")
        end
    end
})

-- 建筑物透视
ESPTab:Toggle({
    Title = "建筑物透视",
    Default = false,
    Callback = function(Value)
        buildESPEnabled = Value
        if Value then
            if workspace:FindFirstChild("RandomBuildings") then
                for _, v in ipairs(workspace.RandomBuildings:GetChildren()) do
                    if v:IsA("Model") and not v:FindFirstChild("ESPHighlight") then
                        createESP(v, v.Name, "buildESP")
                    end
                end
                
                workspace.RandomBuildings.ChildAdded:Connect(function(v)
                    if v:IsA("Model") and not v:FindFirstChild("ESPHighlight") and buildESPEnabled then
                        createESP(v, v.Name, "buildESP")
                    end
                end)
            end
        else
            clearESP("buildESP")
        end
    end
})

-- 房中怪物透视
ESPTab:Toggle({
    Title = "房中怪物透视",
    Default = false,
    Callback = function(Value)
        buildZombieESPEnabled = Value
        if Value then
            if workspace:FindFirstChild("RandomBuildings") then
                for _, building in ipairs(workspace.RandomBuildings:GetChildren()) do
                    if building:FindFirstChild("StandaloneZombiePart") and building.StandaloneZombiePart:FindFirstChild("Zombies") then
                        for _, zombie in ipairs(building.StandaloneZombiePart.Zombies:GetChildren()) do
                            if zombie:IsA("Model") and not zombie:FindFirstChild("ESPHighlight") then
                                createESP(zombie, zombie.Name, "buildZombieESP")
                            end
                        end
                    end
                end
                
                workspace.RandomBuildings.ChildAdded:Connect(function(building)
                    if building:FindFirstChild("StandaloneZombiePart") and building.StandaloneZombiePart:FindFirstChild("Zombies") then
                        for _, zombie in ipairs(building.StandaloneZombiePart.Zombies:GetChildren()) do
                            if zombie:IsA("Model") and not zombie:FindFirstChild("ESPHighlight") and buildZombieESPEnabled then
                                createESP(zombie, zombie.Name, "buildZombieESP")
                            end
                        end
                    end
                end)
            end
        else
            clearESP("buildZombieESP")
        end
    end
})

-- 银行透视
ESPTab:Toggle({
    Title = "银行透视",
    Default = false,
    Callback = function(Value)
        bankESPEnabled = Value
        if Value then
            if workspace:FindFirstChild("Towns") then
                for _, town in ipairs(workspace.Towns:GetChildren()) do
                    if town:FindFirstChild("Buildings") then
                        for _, building in ipairs(town.Buildings:GetChildren()) do
                            if building:IsA("Model") and building.Name:find("Bank") and building:FindFirstChild("Vault") and building.Vault:FindFirstChild("Union") then
                                local combination = building.Vault:FindFirstChild("Combination")
                                local code = combination and combination.Value or "未知"
                                createESP(building, "银行 | 密码: " .. code, "bankESP")
                            end
                        end
                    end
                end
                
                workspace.Towns.ChildAdded:Connect(function(town)
                    if town:FindFirstChild("Buildings") then
                        for _, building in ipairs(town.Buildings:GetChildren()) do
                            if building:IsA("Model") and building.Name:find("Bank") and building:FindFirstChild("Vault") and building.Vault:FindFirstChild("Union") and bankESPEnabled then
                                local combination = building.Vault:FindFirstChild("Combination")
                                local code = combination and combination.Value or "未知"
                                createESP(building, "银行 | 密码: " .. code, "bankESP")
                            end
                        end
                    end
                end)
            end
        else
            clearESP("bankESP")
        end
    end
})

-- 债券透视
ESPTab:Toggle({
    Title = "债券透视",
    Default = false,
    Callback = function(Value)
        bondESPEnabled = Value
        if Value then
            for _, v in ipairs(workspace.RuntimeItems:GetChildren()) do
                if v:IsA("Model") and v.Name == "Bond" and not v:FindFirstChild("ESPHighlight") then
                    createESP(v, "债券", "bondESP")
                end
            end
            
            workspace.RuntimeItems.ChildAdded:Connect(function(v)
                if v:IsA("Model") and v.Name == "Bond" and not v:FindFirstChild("ESPHighlight") and bondESPEnabled then
                    createESP(v, "债券", "bondESP")
                end
            end)
        else
            clearESP("bondESP")
        end
    end
})

local AlertTab = Window:Tab({Title = "提示功能", Icon = "settings"})

AlertTab:Section({Title = "提示设置"})

local alertRadius = 100
local unicornAlertEnabled = false
local tonightMonsterAlertEnabled = false
local nearbyMonsterAlertEnabled = false
local bankAlertEnabled = false
local bondAlertEnabled = false
local buildingAlertEnabled = false
local zombieAlertEnabled = false
local outlawAlertEnabled = false

AlertTab:Slider({
    Title = "提示范围",
    Value = {
        Min = 10,
        Max = 500,
        Default = 100
    },
    Callback = function(Value)
        alertRadius = Value
    end
})

AlertTab:Toggle({
    Title = "独角兽提示",
    Default = false,
    Callback = function(Value)
        unicornAlertEnabled = Value
        if Value then
            WindUI:Notify({
                Title = "独角兽提示",
                Content = "已启用",
                Duration = 2,
                Icon = "type"
            })
            task.spawn(function()
                while unicornAlertEnabled do
                    task.wait(1)
                    pcall(function()
                        for _, v in ipairs(workspace:GetDescendants()) do
                            if v.Name == "Unicorn" then
                                WindUI:Notify({
                                    Title = "独角兽出现",
                                    Content = "全图发现独角兽！",
                                    Duration = 5,
                                    Icon = "type"
                                })
                                task.wait(10)
                            end
                        end
                    end)
                end
            end)
        else
            WindUI:Notify({
                Title = "独角兽提示",
                Content = "已禁用",
                Duration = 2,
                Icon = "type"
            })
        end
    end
})

AlertTab:Toggle({
    Title = "今晚怪物提示",
    Default = false,
    Callback = function(Value)
        tonightMonsterAlertEnabled = Value
        if Value then
            WindUI:Notify({
                Title = "今晚怪物提示",
                Content = "已启用",
                Duration = 2,
                Icon = "type"
            })
            task.spawn(function()
                while tonightMonsterAlertEnabled do
                    task.wait(5)
                    pcall(function()
                        for _, v in ipairs(workspace.NightEnemies:GetChildren()) do
                            if v:IsA("Model") then
                                local monsterName = ""
                                if v.Name:find("Werewolf") then
                                    monsterName = "🐺 狼人"
                                elseif v.Name:find("Vampire") then
                                    monsterName = "🧛 吸血鬼"
                                elseif v.Name:find("Walker") then
                                    monsterName = "🧟 普通僵尸"
                                elseif v.Name:find("Runner") then
                                    monsterName = "🏃 奔跑僵尸"
                                end
                                
                                if monsterName ~= "" then
                                    WindUI:Notify({
                                        Title = "今晚怪物",
                                        Content = monsterName .. " 已出现",
                                        Duration = 5,
                                        Icon = "type"
                                    })
                                end
                            end
                        end
                    end)
                end
            end)
        else
            WindUI:Notify({
                Title = "今晚怪物提示",
                Content = "已禁用",
                Duration = 2,
                Icon = "type"
            })
        end
    end
})

AlertTab:Toggle({
    Title = "附近怪物提示",
    Default = false,
    Callback = function(Value)
        nearbyMonsterAlertEnabled = Value
        if Value then
            WindUI:Notify({
                Title = "附近怪物提示",
                Content = "已启用",
                Duration = 2,
                Icon = "type"
            })
            task.spawn(function()
                while nearbyMonsterAlertEnabled do
                    task.wait(2)
                    pcall(function()
                        local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                        for _, v in ipairs(workspace:GetDescendants()) do
                            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                local isPlayer = false
                                for _, pl in ipairs(game.Players:GetPlayers()) do
                                    if pl.Character == v then
                                        isPlayer = true
                                        break
                                    end
                                end
                                
                                if not isPlayer and v:FindFirstChild("HumanoidRootPart") then
                                    local distance = (v.HumanoidRootPart.Position - playerPos).Magnitude
                                    if distance <= alertRadius then
                                        WindUI:Notify({
                                            Title = "附近怪物",
                                            Content = v.Name .. " (" .. math.floor(distance) .. "m)",
                                            Duration = 3,
                                            Icon = "type"
                                        })
                                        task.wait(5)
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        else
            WindUI:Notify({
                Title = "附近怪物提示",
                Content = "已禁用",
                Duration = 2,
                Icon = "type"
            })
        end
    end
})

AlertTab:Toggle({
    Title = "银行提示",
    Default = false,
    Callback = function(Value)
        bankAlertEnabled = Value
        if Value then
            WindUI:Notify({
                Title = "银行提示",
                Content = "已启用",
                Duration = 2,
                Icon = "type"
            })
            task.spawn(function()
                while bankAlertEnabled do
                    task.wait(3)
                    pcall(function()
                        local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                        for _, town in ipairs(workspace.Towns:GetChildren()) do
                            for _, building in ipairs(town.Buildingns:GetChildren()) do
                                if building.Name:find("Bank") and building:FindFirstChild("Vault") then
                                    local distance = (building:GetPivot().Position - playerPos).Magnitude
                                    if distance <= alertRadius then
                                        WindUI:Notify({
                                            Title = " 银行发现",
                                            Content = "密码: " .. building.Vault.Combination.Value .. " (" .. math.floor(distance) .. "m)",
                                            Duration = 4,
                                            Icon = "type"
                                        })
                                        task.wait(10)
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        else
            WindUI:Notify({
                Title = "银行提示",
                Content = "已禁用",
                Duration = 2,
                Icon = "type"
            })
        end
    end
})

AlertTab:Toggle({
    Title = "债券提示",
    Default = false,
    Callback = function(Value)
        bondAlertEnabled = Value
        if Value then
            WindUI:Notify({
                Title = "债券提示",
                Content = "已启用",
                Duration = 2,
                Icon = "type"
            })
            task.spawn(function()
                while bondAlertEnabled do
                    task.wait(2)
                    pcall(function()
                        local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                        for _, item in ipairs(workspace.RuntimeItems:GetChildren()) do
                            if item.Name == "Bond" then
                                local distance = (item:GetPivot().Position - playerPos).Magnitude
                                if distance <= alertRadius then
                                    WindUI:Notify({
                                        Title = "债券发现",
                                        Content = "附近有债券 (" .. math.floor(distance) .. "m)",
                                        Duration = 3,
                                        Icon = "type"
                                    })
                                    task.wait(5)
                                end
                            end
                        end
                    end)
                end
            end)
        else
            WindUI:Notify({
                Title = "债券提示",
                Content = "已禁用",
                Duration = 2,
                Icon = "type"
            })
        end
    end
})

AlertTab:Toggle({
    Title = "建筑提示",
    Default = false,
    Callback = function(Value)
        buildingAlertEnabled = Value
        if Value then
            WindUI:Notify({
                Title = "建筑提示",
                Content = "已启用",
                Duration = 2,
                Icon = "type"
            })
            task.spawn(function()
                while buildingAlertEnabled do
                    task.wait(5)
                    pcall(function()
                        local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                        for _, building in ipairs(workspace.RandomBuildings:GetChildren()) do
                            local distance = (building:GetPivot().Position - playerPos).Magnitude
                            if distance <= alertRadius then
                                WindUI:Notify({
                                    Title = "新建筑",
                                    Content = building.Name .. " (" .. math.floor(distance) .. "m)",
                                    Duration = 4,
                                    Icon = "type"
                                })
                                task.wait(10)
                            end
                        end
                    end)
                end
            end)
        else
            WindUI:Notify({
                Title = "建筑提示",
                Content = "已禁用",
                Duration = 2,
                Icon = "type"
            })
        end
    end
})

AlertTab:Toggle({
    Title = "僵尸提示",
    Default = false,
    Callback = function(Value)
        zombieAlertEnabled = Value
        if Value then
            WindUI:Notify({
                Title = "僵尸提示",
                Content = "已启用",
                Duration = 2,
                Icon = "type"
            })
            task.spawn(function()
                while zombieAlertEnabled do
                    task.wait(3)
                    pcall(function()
                        local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                        for _, building in ipairs(workspace.RandomBuildings:GetChildren()) do
                            if building:FindFirstChild("StandaloneZombiePart") then
                                for _, zombie in ipairs(building.StandaloneZombiePart.Zombies:GetChildren()) do
                                    if zombie:FindFirstChild("HumanoidRootPart") then
                                        local distance = (zombie.HumanoidRootPart.Position - playerPos).Magnitude
                                        if distance <= alertRadius then
                                            WindUI:Notify({
                                                Title = "建筑僵尸",
                                                Content = zombie.Name .. " (" .. math.floor(distance) .. "m)",
                                                Duration = 3,
                                                Icon = "type"
                                            })
                                            task.wait(5)
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        else
            WindUI:Notify({
                Title = "僵尸提示",
                Content = "已禁用",
                Duration = 2,
                Icon = "type"
            })
        end
    end
})

AlertTab:Toggle({
    Title = "逃犯提示",
    Default = false,
    Callback = function(Value)
        outlawAlertEnabled = Value
        if Value then
            WindUI:Notify({
                Title = "逃犯提示",
                Content = "已启用",
                Duration = 2,
                Icon = "type"
            })
            task.spawn(function()
                while outlawAlertEnabled do
                    task.wait(3)
                    pcall(function()
                        local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                        for _, v in ipairs(workspace:GetDescendants()) do
                            if v:IsA("Model") and (v.Name:find("Outlaw") or v.Name:find("RifleOutlaw") or v.Name:find("ShotgunOutlaw") or v.Name:find("RevolverOutlaw")) then
                                if v:FindFirstChild("HumanoidRootPart") then
                                    local distance = (v.HumanoidRootPart.Position - playerPos).Magnitude
                                    if distance <= alertRadius then
                                        WindUI:Notify({
                                            Title = " 逃犯发现",
                                            Content = v.Name .. " (" .. math.floor(distance) .. "m)",
                                            Duration = 3,
                                            Icon = "type"
                                        })
                                        task.wait(5)
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        else
            WindUI:Notify({
                Title = "逃犯提示",
                Content = "已禁用",
                Duration = 2,
                Icon = "type"
            })
        end
    end
})

local TeleportTab = Window:Tab({Title = "传送", Icon = "settings"})

TeleportTab:Section({Title = "火车传送"})

TeleportTab:Button({
    Title = "传送火车",
    Callback = function()
        for _, v in next, workspace:GetChildren() do
            if v:GetAttribute("Stopped") ~= nil then
                local oldPos = v.RequiredComponents.Controls.ConductorSeat.VehicleSeat:GetPivot()
                repeat
                    local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                    if hum then
                        local seat = v.RequiredComponents.Controls.ConductorSeat.VehicleSeat
                        if seat:FindFirstChild("SeatWeld") then break end
                        seat.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        firetouchinterest(seat, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
                        firetouchinterest(seat, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
                    end
                    task.wait(0.01)
                until seat:FindFirstChild("SeatWeld")
                v.RequiredComponents.Controls.ConductorSeat.VehicleSeat:PivotTo(oldPos)
            end
        end
    end
})

TeleportTab:Button({
    Title = "传送到特斯拉实验室",
    Callback = function()
        local Player = game.Players.LocalPlayer
        if not Player.Character then
            Player.CharacterAdded:Wait()
        end
        local Character = Player.Character
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            local HRP = Character.HumanoidRootPart
            local HUM = Character:FindFirstChildOfClass("Humanoid")
            
            local originalWalkSpeed = HUM.WalkSpeed
            HUM.WalkSpeed = 0
            
            local Generator = workspace:WaitForChild("TeslaLab"):WaitForChild("Generator")
            local modelPosition = Generator:GetPivot().Position
            HRP:PivotTo(CFrame.new(modelPosition + Vector3.new(0, 5, 0)))
            HRP.Anchored = true
            
            task.wait(2)
            
            local RuntimeItems = workspace:WaitForChild("RuntimeItems")
            local function findClosestAvailableSeat()
                local closestSeat = nil
                local minDistance = math.huge
                local playerPos = HRP.Position
                
                for _, chair in pairs(RuntimeItems:GetChildren()) do
                    if chair:IsA("Model") and chair.Name == "Chair" then
                        local seat = chair:FindFirstChild("Seat")
                        if seat and seat:IsA("Seat") and seat.Occupant == nil then
                            local seatPos = seat.Position
                            local distance = (seatPos - playerPos).Magnitude
                            if distance < minDistance then
                                minDistance = distance
                                closestSeat = seat
                            end
                        end
                    end
                end
                return closestSeat
            end
            
            local seat = findClosestAvailableSeat()
            if seat then
                HRP.Anchored = true
                HRP:PivotTo(seat.CFrame + Vector3.new(0, 3, 0))
                
                task.delay(0.15, function()
                    if HRP and HRP.Anchored then
                        HRP.Anchored = false
                    end
                end)
                
                task.delay(0.1, function()
                    if HRP and HRP.Anchored then
                        HRP.Anchored = false
                    end
                end)
                
                task.wait(0.5)
                seat:Sit(HUM)
            else
                HRP.Anchored = false
            end
            
            task.wait(1)
            HUM.WalkSpeed = originalWalkSpeed
        end
    end
})
TeleportTab:Button({
    Title = "传送到吸血鬼城堡",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/FASTCASTLE.txt"))()
        end)
    end
})
TeleportTab:Button({
    Title = "传送到堡垒",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/Tpfort.lua.txt"))()
        end)
    end
})

TeleportTab:Button({
    Title = "传送到斯特林",
    Callback = function()
        pcall(function()
            local originalSetCore = game:GetService("StarterGui").SetCore
            local blocked = {"SendNotification"}

            hookfunction(originalSetCore, function(self, method, ...)
                if table.find(blocked, method) then
                    return
                end
                return originalSetCore(self, method, ...)
            end)

            loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/TPsterling.txt"))()
        end)
    end
})

local PlayerTab = Window:Tab({Title = "人物", Icon = "settings"})
PlayerTab:Section({Title = "↳ 飞行"})

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local invis_on = false
local invisChair = nil
local savedCFrame = nil

local function setTransparency(character, transparency)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("MeshPart") then
            part.Transparency = transparency
        end
    end
end

local function turnOnInvisibility()
    if not invis_on then
        invis_on = true
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        savedCFrame = hrp.CFrame

        wait()
        char:MoveTo(Vector3.new(-25.95, 84, 3537.55))
        wait(0.15)

        invisChair = Instance.new("Seat", workspace)
        invisChair.Anchored = false
        invisChair.CanCollide = false
        invisChair.Name = "invischair"
        invisChair.Transparency = 1
        invisChair.Position = Vector3.new(-25.95, 84, 3537.55)

        local weld = Instance.new("Weld", invisChair)
        weld.Part0 = invisChair
        weld.Part1 = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")

        wait()
        invisChair.CFrame = savedCFrame
        setTransparency(char, 0)
        if hrp then hrp.Transparency = 0 end
    end
end

local function turnOffInvisibility()
    if invis_on then
        invis_on = false
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        setTransparency(char, 0)
        if hrp then hrp.Transparency = 0 end

        if savedCFrame and hrp then
            hrp.CFrame = savedCFrame
        end

        if invisChair then
            invisChair:Destroy()
            invisChair = nil
        end
    end
end

local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local flying = false
local speed = 50
local control = {f = 0, b = 0, l = 0, r = 0}
local bodyGyro, bodyVel, flyConn

local function onInput(input, isProcessed)
    if isProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.W then control.f = 1 end
        if input.KeyCode == Enum.KeyCode.S then control.b = -1 end
        if input.KeyCode == Enum.KeyCode.A then control.l = -1 end
        if input.KeyCode == Enum.KeyCode.D then control.r = 1 end
    end
end

local function onRelease(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.W then control.f = 0 end
        if input.KeyCode == Enum.KeyCode.S then control.b = 0 end
        if input.KeyCode == Enum.KeyCode.A then control.l = 0 end
        if input.KeyCode == Enum.KeyCode.D then control.r = 0 end
    end
end

local function startFly()
    if flying or not hrp then return end
    flying = true

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.Parent = hrp
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = hrp.CFrame

    bodyVel = Instance.new("BodyVelocity")
    bodyVel.Velocity = Vector3.zero
    bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVel.P = 9e4
    bodyVel.Parent = hrp

    UserInputService.InputBegan:Connect(onInput)
    UserInputService.InputEnded:Connect(onRelease)

    flyConn = RunService.RenderStepped:Connect(function()
        local camCF = workspace.CurrentCamera.CFrame
        bodyGyro.CFrame = camCF
        local moveVec = Vector3.zero
        if control.f + control.b ~= 0 then
            moveVec += camCF.LookVector * (control.f + control.b)
        end
        if control.l + control.r ~= 0 then
            moveVec += camCF.RightVector * (control.r + control.l)
        end
        bodyVel.Velocity = moveVec * speed + Vector3.new(0, 0.1, 0)
    end)
end

local function stopFly()
    flying = false
    if flyConn then flyConn:Disconnect() end
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVel then bodyVel:Destroy() end
end

PlayerTab:Toggle({
    Title = "飞行",
    Desc = "开启后无法收集/交互任何物品！",
    Default = false,
    Callback = function(Value)
        if Value then
            turnOnInvisibility()
            startFly()
        else
            turnOffInvisibility()
            stopFly()
        end
    end
})

PlayerTab:Slider({
    Title = "飞行速度",
    Desc = "调整飞行速度",
    Value = {
        Min = 1,
        Max = 500,
        Default = 50
    },
    Callback = function(Value)
        speed = Value
    end
})

PlayerTab:Section({Title = "↳ 移动速度"})

local humanoid = char:WaitForChild("Humanoid")
local originalWalkSpeed = humanoid.WalkSpeed
local walkEnabled = false
local walkMultiplier = 2

PlayerTab:Slider({
    Title = "移动速度倍数",
    Desc = "调整你的移动速度",
    Value = {
        Min = 0,
        Max = 200,
        Default = 2
    },
    Callback = function(Value)
        walkMultiplier = Value
        if walkEnabled then
            humanoid.WalkSpeed = originalWalkSpeed * walkMultiplier
        end
    end
})

PlayerTab:Toggle({
    Title = "移动速度",
    Desc = "开启后无法收集/交互任何物品！",
    Default = false,
    Callback = function(Value)
        walkEnabled = Value
        if Value then
            turnOnInvisibility()
            humanoid.WalkSpeed = originalWalkSpeed * walkMultiplier
        else
            turnOffInvisibility()
            humanoid.WalkSpeed = originalWalkSpeed
        end
    end
})

PlayerTab:Section({Title = "↳ 跳跃"})

local originalJumpHeight = humanoid.JumpHeight
local jumpEnabled = false
local jumpMultiplier = 2

PlayerTab:Slider({
    Title = "跳跃高度倍数",
    Desc = "调整你的跳跃高度",
    Value = {
        Min = 0,
        Max = 200,
        Default = 2
    },
    Callback = function(Value)
        jumpMultiplier = Value
        if jumpEnabled then
            humanoid.JumpHeight = originalJumpHeight * jumpMultiplier
        end
    end
})

PlayerTab:Toggle({
    Title = "跳跃高度",
    Desc = "开启后无法收集/交互任何物品！",
    Default = false,
    Callback = function(Value)
        jumpEnabled = Value
        if Value then
            turnOnInvisibility()
            humanoid.JumpHeight = originalJumpHeight * jumpMultiplier
        else
            turnOffInvisibility()
            humanoid.JumpHeight = originalJumpHeight
        end
    end
})

























local Settings = Window:Tab({Title = "ui设置", Icon = "palette"})
Settings:Paragraph({
    Title = "ui设置",
    Desc = "二改wind原版ui",
    Image = "settings",
    ImageSize = 20,
    Color = "White"
})

Settings:Toggle({
    Title = "启用边框",
    Value = borderEnabled,
    Callback = function(value)
        borderEnabled = value
        local mainFrame = Window.UIElements and Window.UIElements.Main
        if mainFrame then
            local rainbowStroke = mainFrame:FindFirstChild("RainbowStroke")
            if rainbowStroke then
                rainbowStroke.Enabled = value
                if value and windowOpen and not rainbowBorderAnimation then
                    startBorderAnimation(Window, animationSpeed)
                elseif not value and rainbowBorderAnimation then
                    rainbowBorderAnimation:Disconnect()
                    rainbowBorderAnimation = nil
                end
                
                WindUI:Notify({
                    Title = "边框",
                    Content = value and "已启用" or "已禁用",
                    Duration = 2,
                    Icon = value and "eye" or "eye-off"
                })
            end
        end
    end
})

Settings:Toggle({
    Title = "启用字体颜色",
    Value = fontColorEnabled,
    Callback = function(value)
        fontColorEnabled = value
        applyFontColorsToWindow(currentFontColorScheme)
        
        WindUI:Notify({
            Title = "字体颜色",
            Content = value and "已启用" or "已禁用",
            Duration = 2,
            Icon = value and "type" or "type"
        })
    end
})

Settings:Toggle({
    Title = "启用音效",
    Value = soundEnabled,
    Callback = function(value)
        soundEnabled = value
        WindUI:Notify({
            Title = "音效",
            Content = value and "已启用" or "已禁用",
            Duration = 2,
            Icon = value and "volume-2" or "volume-x"
        })
    end
})

Settings:Toggle({
    Title = "启用背景模糊",
    Value = blurEnabled,
    Callback = function(value)
        blurEnabled = value
        applyBlurEffect(value)
        WindUI:Notify({
            Title = "背景模糊",
            Content = value and "已启用" or "已禁用",
            Duration = 2,
            Icon = value and "cloud-rain" or "cloud"
        })
    end
})

local colorSchemeNames = {}
for name, _ in pairs(COLOR_SCHEMES) do
    table.insert(colorSchemeNames, name)
end
table.sort(colorSchemeNames)

Settings:Dropdown({
    Title = "边框颜色方案",
    Desc = "选择喜欢的颜色组合",
    Values = colorSchemeNames,
    Value = "彩虹颜色",
    Callback = function(value)
        currentBorderColorScheme = value
        local success = initializeRainbowBorder(value, animationSpeed)
        playSound()
    end
})

Settings:Dropdown({
    Title = "字体颜色方案",
    Desc = "选择文字颜色组合",
    Values = colorSchemeNames,
    Value = "彩虹颜色",
    Callback = function(value)
        currentFontColorScheme = value
        applyFontColorsToWindow(value)
        playSound()
    end
})

local fontOptions = {}
for _, fontName in ipairs(FONT_STYLES) do
    local description = FONT_DESCRIPTIONS[fontName] or fontName
    table.insert(fontOptions, {text = description, value = fontName})
end

table.sort(fontOptions, function(a, b)
    return a.text < b.text
end)

local fontValues = {}
local fontValueToName = {}
for _, option in ipairs(fontOptions) do
    table.insert(fontValues, option.text)
    fontValueToName[option.text] = option.value
end

Settings:Dropdown({
    Title = "字体样式",
    Desc = "选择文字字体样式 (" .. #FONT_STYLES .. " 种可用)",
    Values = fontValues,
    Value = "标准粗体",
    Callback = function(value)
        local fontName = fontValueToName[value]
        if fontName then
            currentFontStyle = fontName
            local successCount, totalCount = applyFontStyleToWindow(fontName)
            playSound()
        end
    end
})

Settings:Slider({
    Title = "边框转动速度",
    Desc = "调整边框旋转的快慢",
    Value = { 
        Min = 1,
        Max = 10,
        Default = 5,
    },
    Callback = function(value)
        animationSpeed = value
        if rainbowBorderAnimation then
            rainbowBorderAnimation:Disconnect()
            rainbowBorderAnimation = nil
        end
        if borderEnabled then
            startBorderAnimation(Window, animationSpeed)
        end
        
        applyFontColorsToWindow(currentFontColorScheme)
        playSound()
    end
})

Settings:Slider({
    Title = "UI整体缩放",
    Desc = "调整UI大小比例",
    Value = { 
        Min = 0.5,
        Max = 1.5,
        Default = 1,
    },
    Step = 0.1,
    Callback = function(value)
        uiScale = value
        applyUIScale(value)
        playSound()
    end
})

Settings:Divider()

Settings:Slider({
    Title = "UI透明度",
    Desc = "调整整个UI的透明度",
    Value = { 
        Min = 0,
        Max = 1,
        Default = 0.2,
    },
    Step = 0.1,
    Callback = function(value)
        Window:ToggleTransparency(tonumber(value) > 0)
        WindUI.TransparencyValue = tonumber(value)
        playSound()
    end
})

Settings:Slider({
    Title = "调整UI宽度",
    Desc = "调整窗口的宽度",
    Value = { 
        Min = 500,
        Max = 800,
        Default = 600,
    },
    Callback = function(value)
        if Window.UIElements and Window.UIElements.Main then
            Window.UIElements.Main.Size = UDim2.fromOffset(value, 400)
        end
        playSound()
    end
})

Settings:Slider({
    Title = "调整UI高度",
    Desc = "调整窗口的高度",
    Value = { 
        Min = 300,
        Max = 600,
        Default = 400,
    },
    Callback = function(value)
        if Window.UIElements and Window.UIElements.Main then
            local currentWidth = Window.UIElements.Main.Size.X.Offset
            Window.UIElements.Main.Size = UDim2.fromOffset(currentWidth, value)
        end
        playSound()
    end
})

Settings:Slider({
    Title = "边框粗细",
    Desc = "调整边框的粗细",
    Value = { 
        Min = 1,
        Max = 5,
        Default = 1.5,
    },
    Step = 0.5,
    Callback = function(value)
        local mainFrame = Window.UIElements and Window.UIElements.Main
        if mainFrame then
            local rainbowStroke = mainFrame:FindFirstChild("RainbowStroke")
            if rainbowStroke then
                rainbowStroke.Thickness = value
            end
        end
        playSound()
    end
})

Settings:Slider({
    Title = "圆角大小",
    Desc = "调整UI圆角的大小",
    Value = { 
        Min = 0,
        Max = 20,
        Default = 16,
    },
    Callback = function(value)
        local mainFrame = Window.UIElements and Window.UIElements.Main
        if mainFrame then
            local corner = mainFrame:FindFirstChildOfClass("UICorner")
            if not corner then
                corner = Instance.new("UICorner")
                corner.Parent = mainFrame
            end
            corner.CornerRadius = UDim.new(0, value)
        end
        playSound()
    end
})

Settings:Button({
    Title = "恢复UI到原位",
    Icon = "rotate-ccw",
    Callback = function()
        if Window.UIElements and Window.UIElements.Main then
            Window.UIElements.Main.Position = UDim2.new(0.5, 0, 0.5, 0)
            playSound()
        end
    end
})

Settings:Button({
    Title = "重置UI大小",
    Icon = "maximize-2",
    Callback = function()
        if Window.UIElements and Window.UIElements.Main then
            Window.UIElements.Main.Size = UDim2.fromOffset(600, 400)
            playSound()
        end
    end
})

Settings:Button({
    Title = "随机字体",
    Icon = "shuffle",
    Callback = function()
        local randomFont = FONT_STYLES[math.random(1, #FONT_STYLES)]
        currentFontStyle = randomFont
        applyFontStyleToWindow(randomFont)
        playSound()
    end
})

Settings:Button({
    Title = "随机颜色",
    Icon = "palette",
    Callback = function()
        local randomColor = colorSchemeNames[math.random(1, #colorSchemeNames)]
        currentBorderColorScheme = randomColor
        initializeRainbowBorder(randomColor, animationSpeed)
        playSound()
    end
})

Settings:Divider()

Settings:Button({
    Title = "刷新字体颜色",
    Icon = "refresh-cw",
    Callback = function()
        applyFontColorsToWindow(currentFontColorScheme)
        playSound()
    end
})

Settings:Button({
    Title = "刷新字体样式",
    Icon = "refresh-cw",
    Callback = function()
        local successCount, totalCount = applyFontStyleToWindow(currentFontStyle)
        playSound()
    end
})

Settings:Button({
    Title = "测试所有字体",
    Icon = "check-circle",
    Callback = function()
        local workingFonts = {}
        local totalFonts = #FONT_STYLES
        
        for i, fontName in ipairs(FONT_STYLES) do
            local success = pcall(function()
                local test = Enum.Font[fontName]
            end)
            
            if success then
                table.insert(workingFonts, fontName)
            end
        end
        playSound()
    end
})

Settings:Button({
    Title = "导出设置",
    Icon = "download",
    Callback = function()
        local settings = {
            font = currentFontStyle,
            borderColor = currentBorderColorScheme,
            fontSize = currentFontColorScheme,
            speed = animationSpeed,
            scale = uiScale
        }
        setclipboard("大司马脚本 设置: " .. game:GetService("HttpService"):JSONEncode(settings))
        playSound()
    end
})

Window:OnClose(function()
    if rainbowBorderAnimation then
        rainbowBorderAnimation:Disconnect()
    end
    applyBlurEffect(false)
end)

Window:OnDestroy(function()
    if rainbowBorderAnimation then
        rainbowBorderAnimation:Disconnect()
    end
    for _, animation in pairs(fontColorAnimations) do
        animation:Disconnect()
    end
    fontColorAnimations = {}
    applyBlurEffect(false)
end)
end