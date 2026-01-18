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
    Title = "监狱人生",
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

local Main = Window:Tab({Title = "主要功能", Icon = "palette"})

local AuraSettings = {
    enabled = false,
    range = 30
}

Main:Toggle({
    Title = "开启杀戮光环",
    Callback = function(Value)
        AuraSettings.enabled = Value
        if Value then
            startAura()
        end
    end
})

Main:Slider({
    Title = "杀戮范围",
    Value = {
        Min = 5,
        Max = 100,
        Default = 30,
    },
    Callback = function(Value)
        AuraSettings.range = Value
    end
})

local auraConnection

local function startAura()
    if auraConnection then
        auraConnection:Disconnect()
    end
    
    auraConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not AuraSettings.enabled then
            auraConnection:Disconnect()
            return
        end
        
        pcall(function()
            local localPlayer = game:GetService("Players").LocalPlayer
            local localCharacter = localPlayer.Character
            if not localCharacter then return end
            
            local localRoot = localCharacter:FindFirstChild("HumanoidRootPart")
            if not localRoot then return end
            
            for i, v in next, game:GetService("Players"):GetChildren() do
                if v ~= localPlayer then
                    pcall(function()
                        local targetCharacter = v.Character
                        if targetCharacter and not targetCharacter:FindFirstChildOfClass("ForceField") then
                            local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
                            local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
                            
                            if targetHumanoid and targetRoot and targetHumanoid.Health > 0 then
                                local distance = (targetRoot.Position - localRoot.Position).Magnitude
                                
                            
                                if distance <= AuraSettings.range then
                                    game.ReplicatedStorage.meleeEvent:FireServer(v)
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end)
end


local AutoOpenPrisonGate = false

Main:Toggle({
    Title = "自动开启监狱大门",
    Callback = function(Value)
        AutoOpenPrisonGate = Value
        if Value then
            repeat
                local args = {
                    [1] = workspace.Prison_ITEMS.buttons:FindFirstChild("Prison Gate"):FindFirstChild("Prison Gate")
                }
                game:GetService("ReplicatedStorage").Remotes.InteractWithItem:InvokeServer(unpack(args))
                task.wait(0.5) 
            until not AutoOpenPrisonGate
        end
    end
})
local AutoReload = false

Main:Toggle({
    Title = "自动检测空弹夹换弹",
    Callback = function(Value)
        AutoReload = Value
        if Value then
            repeat
                game:GetService("ReplicatedStorage").GunRemotes.FuncReload:InvokeServer()
                task.wait(0) 
            until not AutoReload
        end
    end
})

Main:Button({
    Title = "获得所有枪",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(822, 101, 2251, 1, -0, 0, 0, 1, 0, -0, -0, 1)
        wait(1.1)
        local args = {
            [1] = workspace:WaitForChild("Prison_ITEMS"):WaitForChild("giver"):WaitForChild("M9"):WaitForChild("ITEMPICKUP")
        }
        workspace:WaitForChild("Remote"):WaitForChild("ItemHandler"):InvokeServer(unpack(args))
        wait(1.1)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(824.801025, 104.330627, 2250.36157, 0.173624337, 0.984811902, 0, -0.984811902, 0.173624337, -0, -0, 0, 1)
        wait(1.1)
        local args = {
            [1] = workspace:WaitForChild("Prison_ITEMS"):WaitForChild("giver"):WaitForChild("Remington 870"):WaitForChild("ITEMPICKUP")
        }
        workspace:WaitForChild("Remote"):WaitForChild("ItemHandler"):InvokeServer(unpack(args))
        wait(1.1)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-936.710632, 93.5627747, 2054.66602, 0, -1, 0, 1, 0, -0, 0, 0, 1)
        wait(1.1)
        local args = {
            [1] = workspace:WaitForChild("Prison_ITEMS"):WaitForChild("giver"):WaitForChild("AK-47"):WaitForChild("ITEMPICKUP")
        }
        workspace:WaitForChild("Remote"):WaitForChild("ItemHandler"):InvokeServer(unpack(args))
    end
})


local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local RunService = game:GetService("RunService")

-- 自动开枪设置
local AutoShoot = false
local TeamCheck = true
local ShootDelay = 0.1

-- 透视设置
local ESPEnabled = false
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "PlayerESP"
ESPFolder.Parent = game:GetService("CoreGui")

-- 队伍颜色配置
local TeamColors = {
    ["Criminals"] = Color3.fromRGB(255, 0, 0),     -- 红色
    ["Police"] = Color3.fromRGB(0, 0, 255),        -- 蓝色
    ["Neutral"] = Color3.fromRGB(0, 255, 0),       -- 绿色
    ["Inmates"] = Color3.fromRGB(255, 165, 0),     -- 橙色
    ["Guards"] = Color3.fromRGB(0, 255, 255),      -- 青色
}

-- 获取最近的敌人玩家
local function getNearestEnemy()
    local closestPlayer = nil
    local closestDistance = math.huge
    local localCharacter = LocalPlayer.Character
    local localHumanoidRootPart = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
    
    if not localHumanoidRootPart then return nil end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            -- 队伍检查
            if TeamCheck then
                if player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                    continue
                end
            end
            
            local character = player.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            
            if humanoidRootPart and humanoid and humanoid.Health > 0 then
                local distance = (humanoidRootPart.Position - localHumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    
    return closestPlayer
end

-- 自动开枪函数
local function startAutoShoot()
    while AutoShoot do
        local targetPlayer = getNearestEnemy()
        if targetPlayer and targetPlayer.Character then
            local targetCharacter = targetPlayer.Character
            local targetHumanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
            local targetHead = targetCharacter:FindFirstChild("Head")
            
            if targetHumanoidRootPart then
                local localCharacter = LocalPlayer.Character
                local localHumanoidRootPart = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
                
                if localHumanoidRootPart then
                    -- 计算射击方向（追踪头部）
                    local targetPosition = targetHead and targetHead.Position or targetHumanoidRootPart.Position
                    
                    local args = {
                        [1] = {
                            [1] = {
                                [1] = localHumanoidRootPart.Position, -- 从玩家位置开始
                                [2] = targetPosition, -- 指向目标头部
                                [3] = workspace.floor
                            }
                        }
                    }
                    
                    -- 发射子弹
                    game:GetService("ReplicatedStorage").GunRemotes.ShootEvent:FireServer(unpack(args))
                end
            end
        end
        task.wait(ShootDelay)
    end
end

-- 透视功能
local function createESP(player)
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- 获取队伍颜色
    local teamName = player.Team and player.Team.Name or "Neutral"
    local espColor = TeamColors[teamName] or TeamColors["Neutral"]
    
    -- 创建ESP框
    local highlight = Instance.new("Highlight")
    highlight.Name = player.Name .. "_ESP"
    highlight.Adornee = character
    highlight.FillColor = espColor
    highlight.FillTransparency = 0.7
    highlight.OutlineColor = espColor
    highlight.OutlineTransparency = 0
    highlight.Parent = ESPFolder
    
    -- 创建队伍标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = player.Name .. "_Tag"
    billboard.Adornee = humanoidRootPart
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = player.Name .. " [" .. teamName .. "]"
    label.TextColor3 = espColor
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard
    
    billboard.Parent = ESPFolder
end

local function removeESP(player)
    local espName = player.Name .. "_ESP"
    local tagName = player.Name .. "_Tag"
    
    if ESPFolder:FindFirstChild(espName) then
        ESPFolder:FindFirstChild(espName):Destroy()
    end
    if ESPFolder:FindFirstChild(tagName) then
        ESPFolder:FindFirstChild(tagName):Destroy()
    end
end

local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            removeESP(player)
            if ESPEnabled then
                createESP(player)
            end
        end
    end
end

-- 玩家加入/离开事件
Players.PlayerAdded:Connect(function(player)
    if ESPEnabled then
        createESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

-- 角色生成事件
LocalPlayer.CharacterAdded:Connect(function()
    if ESPEnabled then
        task.wait(2)
        updateESP()
    end
end)

-- 添加到你的UI中
Main:Toggle({
    Title = "自动开枪追踪",
    Callback = function(Value)
        AutoShoot = Value
        if Value then
            coroutine.wrap(startAutoShoot)()
        end
    end
})

Main:Toggle({
    Title = "区分队伍",
    Callback = function(Value)
        TeamCheck = Value
    end
})

Main:Toggle({
    Title = "透视队伍",
    Callback = function(Value)
        ESPEnabled = Value
        if Value then
            updateESP()
        else
            for _, child in pairs(ESPFolder:GetChildren()) do
                child:Destroy()
            end
        end
    end
})

Main:Slider({
    Title = "开枪延迟",
    Value = {
        Min = 0.05,
        Max = 1,
        Default = 0.1,
    },
    Callback = function(Value)
        ShootDelay = Value
    end
})
local Main = Window:Tab({Title = "枪械设置", Icon = "palette"})


Main:Button({
    Title = "全枪射速和无换弹时间",
    Callback = function()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local TARGET_FIRE_RATE = 0
local TARGET_RELOAD_TIME = 0

local originalAttributes = {}

local function isGun(weapon)
    if not weapon:IsA("Tool") then return false end
    
    local gunNames = {
        "AK-47", "AK47", "AK", "Kalashnikov",
        "M4", "M4A1", "M16", "AR-15",
        "Pistol", "Glock", "Desert Eagle", "Deagle",
        "Shotgun", "Sniper", "AWP", "Rifle",
        "SMG", "UZI", "MP5", "Machine Gun",
        "Revolver", "Magnum", "Beretta",
        "Gun", "Weapon", "Firearm"
    }
    
    local gunNamesLower = {}
    for _, name in pairs(gunNames) do
        table.insert(gunNamesLower, name:lower())
    end
    
    local weaponNameLower = weapon.Name:lower()
    for _, name in pairs(gunNamesLower) do
        if weaponNameLower:find(name) then
            return true
        end
    end
    
    if weapon:FindFirstChild("Handle") then
        local handle = weapon.Handle
        if handle:FindFirstChildOfClass("SpecialMesh") then
            local mesh = handle:FindFirstChildOfClass("SpecialMesh")
            local meshIdLower = mesh.MeshId:lower()
            local textureIdLower = mesh.TextureId:lower()
            
            local gunKeywords = {"gun", "pistol", "rifle", "shotgun", "sniper", "ak", "m4", "m16", "weapon"}
            for _, keyword in pairs(gunKeywords) do
                if meshIdLower:find(keyword) or textureIdLower:find(keyword) then
                    return true
                end
            end
        end
    end
    
    local gunAttributes = {"FireRate", "fireRate", "Rate", "ShootRate", "Ammo", "Damage", "ReloadTime"}
    for _, attr in pairs(gunAttributes) do
        if weapon:GetAttribute(attr) ~= nil then
            return true
        end
    end
    
    return false
end

local function modifyWeaponAttributes(weapon)
    if weapon:IsA("Tool") and isGun(weapon) then
        originalAttributes[weapon] = {
            FireRate = weapon:GetAttribute("FireRate"),
            fireRate = weapon:GetAttribute("fireRate"),
            Rate = weapon:GetAttribute("Rate"),
            ReloadTime = weapon:GetAttribute("ReloadTime"),
            reloadTime = weapon:GetAttribute("reloadTime"),
            Reload = weapon:GetAttribute("Reload")
        }
        
        local fireRateAttributes = {"FireRate", "fireRate", "Rate", "rate", "ShootRate", "shootRate"}
        for _, attrName in pairs(fireRateAttributes) do
            local attrValue = weapon:GetAttribute(attrName)
            if attrValue ~= nil then
                weapon:SetAttribute(attrName, TARGET_FIRE_RATE)
            end
        end
        
        local reloadTimeAttributes = {"ReloadTime", "reloadTime", "Reload", "reload", "ReloadSpeed"}
        for _, attrName in pairs(reloadTimeAttributes) do
            local attrValue = weapon:GetAttribute(attrName)
            if attrValue ~= nil then
                weapon:SetAttribute(attrName, TARGET_RELOAD_TIME)
            end
        end
        
        local allAttributes = {}
        for _, attr in pairs(fireRateAttributes) do table.insert(allAttributes, attr) end
        for _, attr in pairs(reloadTimeAttributes) do table.insert(allAttributes, attr) end
        
        for _, attrName in pairs(allAttributes) do
            if weapon:GetAttribute(attrName) ~= nil then
                weapon:GetAttributeChangedSignal(attrName):Connect(function()
                    if attrName == "FireRate" or attrName == "fireRate" or attrName == "Rate" or attrName == "ShootRate" then
                        if weapon:GetAttribute(attrName) ~= TARGET_FIRE_RATE then
                            weapon:SetAttribute(attrName, TARGET_FIRE_RATE)
                        end
                    elseif attrName == "ReloadTime" or attrName == "reloadTime" or attrName == "Reload" then
                        if weapon:GetAttribute(attrName) ~= TARGET_RELOAD_TIME then
                            weapon:SetAttribute(attrName, TARGET_RELOAD_TIME)
                        end
                    end
                end)
            end
        end
    end
end

local function modifyAllWeapons()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        for _, weapon in pairs(backpack:GetChildren()) do
            if isGun(weapon) then
                modifyWeaponAttributes(weapon)
            end
        end
    end
    
    local character = LocalPlayer.Character
    if character then
        for _, weapon in pairs(character:GetChildren()) do
            if isGun(weapon) then
                modifyWeaponAttributes(weapon)
            end
        end
    end
    
    for _, weapon in pairs(workspace:GetDescendants()) do
        if weapon:IsA("Tool") and isGun(weapon) then
            modifyWeaponAttributes(weapon)
        end
    end
end

local function monitorNewWeapons()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        backpack.ChildAdded:Connect(function(child)
            if isGun(child) then
                task.wait(0.2)
                modifyWeaponAttributes(child)
            end
        end)
    end
    
    LocalPlayer.CharacterAdded:Connect(function(character)
        character.ChildAdded:Connect(function(child)
            if isGun(child) then
                task.wait(0.2)
                modifyWeaponAttributes(child)
            end
        end)
    end)
    
    workspace.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("Tool") and isGun(descendant) then
            task.wait(0.1)
            modifyWeaponAttributes(descendant)
        end
    end)
end

local function protectWeaponAttributes()
    local connection
    connection = RunService.Heartbeat:Connect(function()
        for weapon, originalValues in pairs(originalAttributes) do
            if weapon and weapon.Parent and isGun(weapon) then
                local fireRateAttributes = {"FireRate", "fireRate", "Rate", "rate", "ShootRate"}
                for _, attrName in pairs(fireRateAttributes) do
                    local currentValue = weapon:GetAttribute(attrName)
                    if currentValue ~= nil and currentValue ~= TARGET_FIRE_RATE then
                        weapon:SetAttribute(attrName, TARGET_FIRE_RATE)
                    end
                end
                
                local reloadTimeAttributes = {"ReloadTime", "reloadTime", "Reload", "reload"}
                for _, attrName in pairs(reloadTimeAttributes) do
                    local currentValue = weapon:GetAttribute(attrName)
                    if currentValue ~= nil and currentValue ~= TARGET_RELOAD_TIME then
                        weapon:SetAttribute(attrName, TARGET_RELOAD_TIME)
                    end
                end
            end
        end
    end)
    return connection
end

local function restoreOriginalAttributes()
    for weapon, attributes in pairs(originalAttributes) do
        if weapon and weapon.Parent then
            for attrName, originalValue in pairs(attributes) do
                if originalValue ~= nil then
                    weapon:SetAttribute(attrName, originalValue)
                end
            end
        end
    end
    originalAttributes = {}
end

local function findAllWeapons()
    local weaponList = {}
    
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        for _, weapon in pairs(backpack:GetChildren()) do
            if isGun(weapon) then
                table.insert(weaponList, weapon)
            end
        end
    end
    
    local character = LocalPlayer.Character
    if character then
        for _, weapon in pairs(character:GetChildren()) do
            if isGun(weapon) then
                table.insert(weaponList, weapon)
            end
        end
    end
    
    for _, weapon in pairs(workspace:GetDescendants()) do
        if weapon:IsA("Tool") and isGun(weapon) then
            table.insert(weaponList, weapon)
        end
    end
    
    return weaponList
end

local function applyInfiniteFireRateAndZeroReload()
    local weapons = findAllWeapons()
    
    for _, weapon in pairs(weapons) do
        modifyWeaponAttributes(weapon)
    end
    
    monitorNewWeapons()
    
    local protectionConnection = protectWeaponAttributes()
    
    return function()
        if protectionConnection then
            protectionConnection:Disconnect()
        end
        restoreOriginalAttributes()
    end
end

local function forceModifyWeapon(weaponPath)
    local success, weapon = pcall(function()
        return game:GetService(weaponPath)
    end)
    
    if success and weapon and weapon:IsA("Tool") then
        originalAttributes[weapon] = {
            FireRate = weapon:GetAttribute("FireRate"),
            ReloadTime = weapon:GetAttribute("ReloadTime")
        }
        weapon:SetAttribute("FireRate", TARGET_FIRE_RATE)
        weapon:SetAttribute("ReloadTime", TARGET_RELOAD_TIME)
        return true
    end
    return false
end

local function modifyFireRateOnly(weapon, targetRate)
    if weapon and weapon:IsA("Tool") then
        local fireRateAttributes = {"FireRate", "fireRate", "Rate", "ShootRate"}
        for _, attrName in pairs(fireRateAttributes) do
            if weapon:GetAttribute(attrName) ~= nil then
                weapon:SetAttribute(attrName, targetRate)
            end
        end
    end
end

local function modifyReloadTimeOnly(weapon, targetReload)
    if weapon and weapon:IsA("Tool") then
        local reloadAttributes = {"ReloadTime", "reloadTime", "Reload"}
        for _, attrName in pairs(reloadAttributes) do
            if weapon:GetAttribute(attrName) ~= nil then
                weapon:SetAttribute(attrName, targetReload)
            end
        end
    end
end

local stopFunction = applyInfiniteFireRateAndZeroReload()

local WeaponModifier = {
    apply = applyInfiniteFireRateAndZeroReload,
    stop = stopFunction,
    findWeapons = findAllWeapons,
    forceModify = forceModifyWeapon,
    restore = restoreOriginalAttributes,
    isGun = isGun,
    modifyFireRate = modifyFireRateOnly,
    modifyReloadTime = modifyReloadTimeOnly,
    
    setFireRate = function(value)
        TARGET_FIRE_RATE = value
    end,
    
    setReloadTime = function(value)
        TARGET_RELOAD_TIME = value
    end
}

task.spawn(function()
    while task.wait(5) do
        local currentWeapons = findAllWeapons()
        local modifiedCount = 0
        for weapon, _ in pairs(originalAttributes) do
            if weapon and weapon.Parent then
                modifiedCount = modifiedCount + 1
            end
        end
    end
end)

return WeaponModifier

    end
})

Main:Button({
    Title = "修改子弹轨道",
    Callback = function()
-- 彩虹子弹轨迹特效修改脚本
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 彩虹色生成函数
local function getRainbowColor(timeOffset)
    local time = tick() + (timeOffset or 0)
    local hue = (time * 180) % 360  -- 每2秒完成一个彩虹循环
    return Color3.fromHSV(hue/360, 1, 1)
end

-- 配置
local TRAIL_LIFETIME = 2  -- 2秒后消失
local TRAIL_UPDATE_INTERVAL = 0.02  -- 更快的残影更新间隔
local BULLET_THICKNESS = 0.5  -- 更厚的子弹轨迹
local TRAIL_THICKNESS = 0.3  -- 残影厚度

-- 存储子弹轨迹和残影
local activeBullets = {}
local bulletTrails = {}

-- 检查是否是自己的子弹
local function isMyBullet(bulletPart)
    -- 通过子弹的父级关系判断是否属于本地玩家
    local character = LocalPlayer.Character
    if not character then return false end
    
    -- 检查子弹是否在玩家的武器或角色层级下
    local ancestor = bulletPart
    while ancestor and ancestor ~= game do
        if ancestor:IsA("Tool") and ancestor.Parent == character then
            return true
        end
        if ancestor == character then
            return true
        end
        ancestor = ancestor.Parent
    end
    
    return false
end

-- 创建彩虹子弹轨迹
local function createRainbowBullet(startPos, endPos)
    local distance = (startPos - endPos).Magnitude
    
    -- 创建厚的彩虹子弹轨迹
    local bulletPart = Instance.new("Part")
    bulletPart.Name = "RainbowBulletTracer"
    bulletPart.Anchored = true
    bulletPart.CanCollide = false
    bulletPart.Material = Enum.Material.Neon
    bulletPart.Size = Vector3.new(BULLET_THICKNESS, BULLET_THICKNESS, distance)
    bulletPart.Transparency = 0.2
    
    -- 计算位置和方向
    local centerPos = (startPos + endPos) / 2
    bulletPart.CFrame = CFrame.lookAt(centerPos, endPos)
    bulletPart.Parent = workspace
    
    -- 添加彩虹发光效果
    local pointLight = Instance.new("PointLight")
    pointLight.Brightness = 10
    pointLight.Range = 12
    pointLight.Color = getRainbowColor()
    pointLight.Parent = bulletPart
    
    -- 添加彩虹光束
    local beam = Instance.new("Beam")
    beam.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, getRainbowColor(0)),
        ColorSequenceKeypoint.new(0.5, getRainbowColor(0.5)),
        ColorSequenceKeypoint.new(1, getRainbowColor(1))
    })
    beam.Width0 = BULLET_THICKNESS
    beam.Width1 = BULLET_THICKNESS
    beam.Brightness = 3
    beam.FaceCamera = true
    
    local attachment0 = Instance.new("Attachment")
    attachment0.Parent = bulletPart
    attachment0.Position = Vector3.new(0, 0, -distance/2)
    
    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = bulletPart
    attachment1.Position = Vector3.new(0, 0, distance/2)
    
    beam.Attachment0 = attachment0
    beam.Attachment1 = attachment1
    beam.Parent = bulletPart
    
    Debris:AddItem(bulletPart, TRAIL_LIFETIME)
    
    return bulletPart
end

-- 创建快速彩虹残影
local function createQuickRainbowTrail(bulletPart, trailId)
    if not bulletTrails[trailId] then
        bulletTrails[trailId] = {
            connections = {},
            parts = {}
        }
    end
    
    local trails = bulletTrails[trailId]
    local trailCount = 0
    local lastPositions = {}
    
    -- 快速残影生成函数
    local function generateQuickTrail()
        if not bulletPart or bulletPart.Parent == nil then return end
        
        local currentPos = bulletPart.Position
        local currentTime = tick()
        
        -- 存储当前位置用于残影生成
        table.insert(lastPositions, 1, {
            position = currentPos,
            time = currentTime,
            color = getRainbowColor(currentTime)
        })
        
        -- 限制位置记录数量
        while #lastPositions > 8 do
            table.remove(lastPositions)
        end
        
        -- 快速生成残影（每2帧生成一个）
        if #lastPositions >= 2 then
            for i = 1, math.min(2, #lastPositions - 1) do
                local trailData = lastPositions[i]
                local nextData = lastPositions[i + 1]
                
                -- 创建厚的残影部分
                local trailPart = Instance.new("Part")
                trailPart.Name = "RainbowTrail"
                trailPart.Anchored = true
                trailPart.CanCollide = false
                trailPart.Material = Enum.Material.Neon
                trailPart.BrickColor = BrickColor.new(trailData.color)
                trailPart.Size = Vector3.new(TRAIL_THICKNESS, TRAIL_THICKNESS, 
                    (trailData.position - nextData.position).Magnitude)
                trailPart.Transparency = 0.3 + (i * 0.1)
                
                local centerPos = (trailData.position + nextData.position) / 2
                trailPart.CFrame = CFrame.lookAt(centerPos, nextData.position)
                trailPart.Parent = workspace
                
                -- 残影发光效果
                local trailLight = Instance.new("PointLight")
                trailLight.Brightness = 6 - (i * 1)
                trailLight.Range = 8
                trailLight.Color = trailData.color
                trailLight.Parent = trailPart
                
                table.insert(trails.parts, trailPart)
                trailCount = trailCount + 1
                
                -- 残影淡出效果
                task.spawn(function()
                    task.wait(0.3 + (i * 0.1))
                    local tween = TweenService:Create(trailPart, 
                        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 1, Size = Vector3.new(0.1, 0.1, trailPart.Size.Z)}
                    )
                    tween:Play()
                    Debris:AddItem(trailPart, 1)
                end)
            end
        end
        
        -- 限制残影数量
        while trailCount > 15 do
            local oldestTrail = table.remove(trails.parts, 1)
            if oldestTrail and oldestTrail.Parent then
                oldestTrail:Destroy()
            end
            trailCount = trailCount - 1
        end
    end
    
    -- 使用更快的更新频率
    local heartbeatConnection = RunService.Heartbeat:Connect(generateQuickTrail)
    local renderConnection = RunService.RenderStepped:Connect(generateQuickTrail)
    
    table.insert(trails.connections, heartbeatConnection)
    table.insert(trails.connections, renderConnection)
    
    return trails
end

-- 修改自己的子弹轨迹为彩虹效果
local function enhanceMyBulletWithRainbow(originalPart)
    if not originalPart or originalPart.Parent == nil then return end
    if not isMyBullet(originalPart) then return end  -- 只修改自己的子弹
    
    -- 获取子弹轨迹的起点和终点
    local startPos = originalPart.Position - originalPart.CFrame.LookVector * (originalPart.Size.Z / 2)
    local endPos = originalPart.Position + originalPart.CFrame.LookVector * (originalPart.Size.Z / 2)
    
    -- 创建彩虹子弹轨迹
    local rainbowBullet = createRainbowBullet(startPos, endPos)
    
    -- 创建快速彩虹残影
    local bulletId = #activeBullets + 1
    activeBullets[bulletId] = {
        original = originalPart,
        rainbow = rainbowBullet,
        createdTime = tick()
    }
    
    createQuickRainbowTrail(rainbowBullet, bulletId)
    
    -- 隐藏原轨迹
    originalPart.Transparency = 1
    local light = originalPart:FindFirstChildOfClass("SurfaceLight")
    if light then
        light.Enabled = false
    end
    
    -- 2秒后清理
    task.delay(TRAIL_LIFETIME, function()
        if rainbowBullet and rainbowBullet.Parent then
            rainbowBullet:Destroy()
        end
        
        -- 清理残影
        if bulletTrails[bulletId] then
            for _, conn in pairs(bulletTrails[bulletId].connections) do
                conn:Disconnect()
            end
            for _, part in pairs(bulletTrails[bulletId].parts) do
                if part and part.Parent then
                    part:Destroy()
                end
            end
            bulletTrails[bulletId] = nil
        end
        
        activeBullets[bulletId] = nil
    end)
    
    return rainbowBullet
end

-- 实时监控并增强自己的子弹轨迹
local function monitorAndEnhanceMyBullets()
    local connection
    connection = RunService.Heartbeat:Connect(function()
        -- 查找所有子弹轨迹，但只增强自己的
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "RayPart" and obj:IsA("Part") and not obj:FindFirstChild("RainbowEnhanced") then
             
                local marker = Instance.new("BoolValue")
                marker.Name = "RainbowEnhanced"
                marker.Value = true
                marker.Parent = obj
                
             
                enhanceMyBulletWithRainbow(obj)
            end
        end
    end)
    
    return connection
end

local function cleanup()
    for _, bulletData in pairs(activeBullets) do
        if bulletData.rainbow and bulletData.rainbow.Parent then
            bulletData.rainbow:Destroy()
        end
    end
    activeBullets = {}
    
    for trailId, trailData in pairs(bulletTrails) do
        for _, conn in pairs(trailData.connections) do
            conn:Disconnect()
        end
        for _, part in pairs(trailData.parts) do
            if part and part.Parent then
                part:Destroy()
            end
        end
    end
    bulletTrails = {}
end

-- 主执行函数
local function applyRainbowBulletEffects()
    print("开始应用彩虹子弹轨迹特效（只修改自己的子弹）...")
    
    cleanup()
   
    local monitorConnection = monitorAndEnhanceMyBullets()
    return function()
        if monitorConnection then
            monitorConnection:Disconnect()
        end
        cleanup()
        print("彩虹子弹特效已停止")
    end
end
local stopFunction = applyRainbowBulletEffects()
local RainbowBulletEffects = {
    apply = applyRainbowBulletEffects,
    stop = stopFunction,
    cleanup = cleanup,
    isMyBullet = isMyBullet  
}

return RainbowBulletEffects

    end
})
Main:Slider({
    Title = "修改子弹量",
    Value = {
        Min = 1,
        Max = 9999,
        Default = 30,
    },
    Callback = function(Value)
        local weapons = game:GetService("Players").LocalPlayer.Backpack:GetChildren()
        for _, weapon in ipairs(weapons) do
            if weapon:IsA("Tool") and string.lower(weapon.Name):find("ak") then
                weapon:SetAttribute("MaxAmmo", Value)
                weapon:SetAttribute("Ammo", Value)
            end
        end
        local character = game:GetService("Players").LocalPlayer.Character
        if character then
            for _, weapon in ipairs(character:GetChildren()) do
                if weapon:IsA("Tool") and string.lower(weapon.Name):find("ak") then
                    weapon:SetAttribute("MaxAmmo", Value)
                    weapon:SetAttribute("Ammo", Value)
                end
            end
        end
    end
})




local MainTab = Window:Tab({Title = "传送", Icon = "palette"})
MainTab:Dropdown({
    Title = "传送位置列表",
    Values = {"警卫室", "监狱室内", "犯罪点", "院子"},
    Default = "警卫室",
    Callback = function(Value)
        local Locations = {
            ["警卫室"] = CFrame.new(847.7261352539062, 98.95999908447266, 2267.387451171875),
            ["监狱室内"] = CFrame.new(919.2575073242188, 98.95999908447266, 2379.74169921875),
            ["犯罪点"] = CFrame.new(-937.5891723632812, 93.09876251220703, 2063.031982421875),
            ["院子"] = CFrame.new(760.6033325195312, 96.96992492675781, 2475.405029296875)
        }
        
        SelectedLocation = Locations[Value]
    end
})

MainTab:Button({
    Title = "确认传送",
    Callback = function()
        if SelectedLocation then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedLocation
        end
    end
})

MainTab:Button({
    Title = "来回传送",
    Callback = function()
        if SelectedLocation then
            local char = game.Players.LocalPlayer.Character
            local currentPos = char.HumanoidRootPart.CFrame
            char.HumanoidRootPart.CFrame = SelectedLocation
            wait(1)
            char.HumanoidRootPart.CFrame = currentPos
        end
    end
})

MainTab:Toggle({
    Title = "反复传送",
    Default = false,
    Callback = function(Value)
        AutoTeleport = Value
        while AutoTeleport and SelectedLocation do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedLocation
            wait(0.5)
        end
    end
})

MainTab:Toggle({
    Title = "平滑穿墙移动",
    Default = false,
    Callback = function(Value)
        SmoothNoclip = Value
        if Value then
            local char = game.Players.LocalPlayer.Character
            local hrp = char.HumanoidRootPart
            
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
            
            local con
            con = game:GetService("RunService").Stepped:Connect(function()
                if not SmoothNoclip then
                    con:Disconnect()
                    return
                end
                
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
            
            if SelectedLocation then
                local startPos = hrp.Position
                local endPos = SelectedLocation.Position
                local distance = (endPos - startPos).Magnitude
                local duration = distance / 50
                local startTime = tick()
                
                while tick() - startTime < duration and SmoothNoclip do
                    local alpha = (tick() - startTime) / duration
                    hrp.Position = startPos:Lerp(endPos, alpha)
                    wait()
                end
                
                if SmoothNoclip then
                    hrp.CFrame = SelectedLocation
                end
                SmoothNoclip = false
            end
        end
    end
})




local Main = Window:Tab({Title = "人物", Icon = "settings"})

Main:Toggle({
    Title = "走路/飞行速度 (开/关)",
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
    Title = "飞行",
    Default = false,
    Callback = function(Value)
        FlyEnabled = Value
        if Value then
            for i, v in pairs(Enum.HumanoidStateType:GetEnumItems()) do
                LocalPlayer.Character.Humanoid:SetStateEnabled(v, false)
            end
            LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
            originalGravity = workspace.Gravity
            workspace.Gravity = 0
            if LocalPlayer.Character then
                LocalPlayer.Character.Humanoid.AutoRotate = false
            end
            task.spawn(function()
                while FlyEnabled do
                    pcall(function()
                        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
                        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.zero
                        if LocalPlayer.Character then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                                LocalPlayer.Character.HumanoidRootPart.Position,
                                LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer:GetMouse().Hit.LookVector
                            )
                        end
                    end)
                    RunService.Heartbeat:Wait()
                end
            end)
        else
          
            for i, v in pairs(Enum.HumanoidStateType:GetEnumItems()) do
                LocalPlayer.Character.Humanoid:SetStateEnabled(v, true)
            end
            
         
            if LocalPlayer.Character then
                LocalPlayer.Character.Humanoid.AutoRotate = true
            end
            
         
            workspace.Gravity = originalGravity or 196.2
            
            LocalPlayer.Character.Humanoid:ChangeState("Flying")
        end
    end
})

do local TouchFlingModule={}TouchFlingModule.Version="1.0" TouchFlingModule.LoadTime=tick()local flingEnabled=false local flingPower=10000 local flingThread=nil local flingMove=0.1 Main:Input({Title="碰飞距离",Desc="大小",Value=tostring(flingPower),Placeholder="输入",Color=Color3.fromRGB(0,170,255),Callback=function(Value)local power=tonumber(Value)if power then flingPower=power end end})Main:Toggle({Title="开启碰飞",Default=flingEnabled,Callback=function(State)flingEnabled=State if flingThread then task.cancel(flingThread)flingThread=nil end if flingEnabled then flingThread=task.spawn(function()local RunService=game:GetService("RunService")local Players=game:GetService("Players")local lp=Players.LocalPlayer while flingEnabled do RunService.Heartbeat:Wait()local c=lp.Character local hrp=c and c:FindFirstChild("HumanoidRootPart")if hrp then local vel=hrp.Velocity hrp.Velocity=vel*flingPower+Vector3.new(0,flingPower,0)RunService.RenderStepped:Wait()hrp.Velocity=vel RunService.Stepped:Wait()hrp.Velocity=vel+Vector3.new(0,flingMove,0)flingMove=-flingMove end end end)end end})TouchFlingModule.Cleanup=function()if flingThread then task.cancel(flingThread)flingThread=nil end flingEnabled=false end if _G.TouchFlingModule then _G.TouchFlingModule.Cleanup()end _G.TouchFlingModule=TouchFlingModule end


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