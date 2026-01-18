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
    Title = "终极战场",
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
local Tab = Window:Tab({
    Title = "功能",
    Icon = "sword",
    Locked = false,
})
local fakeBlockEnabled = false
local loopRunning = false

Tab:Toggle({
    Title = "假防(关闭功能后按一次防御即可取消假防)",
    Value = false,
    Callback = function(state)
        fakeBlockEnabled = state

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local BlockRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Combat"):WaitForChild("Block")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local function enableBlock()
            pcall(function()
                BlockRemote:FireServer(true)
            end)
        end

        if fakeBlockEnabled then
            enableBlock()
        end

        if not loopRunning then
            loopRunning = true
            task.spawn(function()
                while true do
                    task.wait(0.01)
                    if fakeBlockEnabled then
                        local success, isBlocking = pcall(function()
                            return character:GetAttribute("IsBlocking")
                        end)
                        if success and not isBlocking then
                            enableBlock()
                        end
                    end
                end
            end)
        end
    end
})

local defaultCooldown = game:GetService("ReplicatedStorage").Settings.Cooldowns.Dash.Value

Tab:Toggle({
    Title = "侧闪无冷却",
    Value = false,
    Callback = function(state)
        local dashCooldown = game:GetService("ReplicatedStorage").Settings.Cooldowns.Dash
        if state then
            dashCooldown.Value = 1
        else
            dashCooldown.Value = defaultCooldown
        end
    end
})
local defaultMeleeCooldown = game:GetService("ReplicatedStorage").Settings.Cooldowns.Melee.Value

Tab:Toggle({
    Title = "近战无冷却",
    Value = false,
    Callback = function(state)
        local meleeCooldown = game:GetService("ReplicatedStorage").Settings.Cooldowns.Melee
        if state then
            meleeCooldown.Value = 1
        else
            meleeCooldown.Value = defaultMeleeCooldown
        end
    end
})
local rs = game:GetService("ReplicatedStorage")
local settings = rs.Settings

local defaultAbility = settings.Cooldowns.Ability.Value
Tab:Toggle({
    Title = "技能无冷却(仅宿傩角色)",
    Value = false,
    Callback = function(state)
        settings.Cooldowns.Ability.Value = state and 1 or defaultAbility
    end
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local noSlowdownsToggle = ReplicatedStorage.Settings.Toggles.NoSlowdowns

local defaultValue = false

Tab:Toggle({
    Title = "无减速效果",
    Value = noSlowdownsToggle.Value,
    Callback = function(state)
        if state then
            noSlowdownsToggle.Value = true
        else
            noSlowdownsToggle.Value = defaultValue
        end
    end
})

local defaultDisableHitStun = settings.Toggles.DisableHitStun.Value
Tab:Toggle({
    Title = "取消被攻击硬直",
    Value = false,
    Callback = function(state)
        settings.Toggles.DisableHitStun.Value = state
    end
})

local defaultDisableIntros = settings.Toggles.DisableIntros.Value
Tab:Toggle({
    Title = "跳过角色开场动作",
    Value = false,
    Callback = function(state)
        settings.Toggles.DisableIntros.Value = state
    end
})

local defaultNoStunOnMiss = settings.Toggles.NoStunOnMiss.Value
Tab:Toggle({
    Title = "普攻无僵直",
    Value = false,
    Callback = function(state)
        settings.Toggles.NoStunOnMiss.Value = state
    end
})

local defaultRagdollTimer = settings.Multipliers.RagdollTimer.Value
Tab:Toggle({
    Title = "被别人击倒不会变成布娃娃",
    Value = false,
    Callback = function(state)
        settings.Multipliers.RagdollTimer.Value = state and 0.5 or defaultRagdollTimer
    end
})

local defaultUltimateTimer = settings.Multipliers.UltimateTimer.Value
Tab:Toggle({
    Title = "延长大招时间",
    Value = false,
    Callback = function(state)
        settings.Multipliers.UltimateTimer.Value = state and 100000 or defaultUltimateTimer
    end
})

local defaultInstantTransformation = settings.Toggles.InstantTransformation.Value
Tab:Toggle({
    Title = "秒开大",
    Value = false,
    Callback = function(state)
        settings.Toggles.InstantTransformation.Value = state
    end
})
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Ping = player:WaitForChild("Info"):WaitForChild("Ping")

local loop

Tab:Toggle({
    Title = "ping乱码",
    Value = false,
    Callback = function(state)
        if state then
            loop = task.spawn(function()
                while state do
                    for i = 0, 999, 25 do
                        if not state then break end
                        Ping.Value = i
                        task.wait(0.03)
                    end
                    for i = 999, 0, -25 do
                        if not state then break end
                        Ping.Value = i
                        task.wait(0.03)
                    end
                end
            end)
        else
            if loop then
                task.cancel(loop)
                loop = nil
            end
        end
    end
})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MeleeDamage = ReplicatedStorage:WaitForChild("Settings"):WaitForChild("Multipliers"):WaitForChild("MeleeDamage")

MeleeDamage.Value = 100

Tab:Toggle({
    Title = "一拳倒地",
    Value = false,
    Callback = function(state)
        if state then
            MeleeDamage.Value = 1000000
        else
            MeleeDamage.Value = 100
        end
    end
})
Tab:Toggle({
    Title = "一拳击飞",
    Value = false,
    Callback = function(state)
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RunService = game:GetService("RunService")

        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

        local RagdollPower = ReplicatedStorage:WaitForChild("Settings"):WaitForChild("Multipliers"):WaitForChild("RagdollPower")

        local maxTeleportDistance = 50
        local lastPosition = HumanoidRootPart.Position
        local connection

        if state then
            RagdollPower.Value = 10000

            connection = RunService.RenderStepped:Connect(function()
                -- refresh character in case of reset
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                    lastPosition = HumanoidRootPart.Position
                end

                local currentPos = HumanoidRootPart.Position
                local distance = (currentPos - lastPosition).Magnitude

                if distance > maxTeleportDistance then
                    HumanoidRootPart.CFrame = CFrame.new(lastPosition)
                else
                    lastPosition = currentPos
                end
            end)
        else
            RagdollPower.Value = 100
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end
})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local wallCombo = ReplicatedStorage.Settings.Cooldowns.WallCombo

Tab:Toggle({
    Title = "墙打无冷却",
    Value = false,
    Callback = function(state)
        if state then
            wallCombo.Value = 0
            print("WallCombo cooldown set to 0")
        else
            wallCombo.Value = 100
            print("WallCombo cooldown reset to 100")
        end
    end
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local wall = nil
pcall(function()
    wall = workspace.Map.Structural.Terrain:GetChildren()[5]:GetChildren()[12]
end)

if not wall then
    wall = Instance.new("Part")
    wall.Parent = workspace
end

wall.Size = Vector3.new(12,6,2)
wall.Transparency = 0.6
wall.Material = Enum.Material.SmoothPlastic
wall.Anchored = true
wall.CanCollide = true
wall.CFrame = wall.CFrame or CFrame.new(0,5,0)

if getconnections then
    for _, conn in pairs(getconnections(wall.AncestryChanged)) do
        conn:Disable()
    end
end

local mt = getrawmetatable(game)
setreadonly(mt,false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if self == wall and method == "Destroy" then
        return
    end
    return old(self, ...)
end)
setreadonly(mt,true)

local followConnection = nil
Tab:Toggle({
    Title = "随处墙打",
    Value = false,
    Callback = function(state)
        if state then
            if not followConnection then
                followConnection = RunService.RenderStepped:Connect(function()
                    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        wall.CFrame = hrp.CFrame * CFrame.new(0,0,-8)
                    end
                end)
            end
        else
            if followConnection then
                followConnection:Disconnect()
                followConnection = nil
            end
        end
    end
})
local originalData = {}
local skyBackup = nil

Tab:Toggle({
    Title = "防卡",
    Value = false,
    Callback = function(state)
        if state then
            originalData = {}
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Explosion") then
                    originalData[v] = v.Enabled
                    v.Enabled = false
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    originalData[v] = v.Transparency
                    v.Transparency = 1
                elseif v:IsA("MeshPart") or v:IsA("UnionOperation") or v:IsA("Part") then
                    if v.Name ~= "HumanoidRootPart" then
                        originalData[v] = v.Material
                        v.Material = Enum.Material.SmoothPlastic
                    end
                elseif v:IsA("SurfaceGui") or v:IsA("BillboardGui") or v:IsA("Beam") then
                    if v:IsA("Beam") then
                        originalData[v] = v.Enabled
                        v.Enabled = false
                    else
                        originalData[v] = v.Enabled ~= nil and v.Enabled or true
                        if v.Enabled ~= nil then
                            v.Enabled = false
                        end
                    end
                end
            end
            originalData["GlobalShadows"] = game.Lighting.GlobalShadows
            originalData["FogEnd"] = game.Lighting.FogEnd
            game.Lighting.GlobalShadows = false
            game.Lighting.FogEnd = 9e9
            local sky = game.Lighting:FindFirstChildOfClass("Sky")
            if sky then
                skyBackup = sky:Clone()
                sky:Destroy()
            end
            local newSky = Instance.new("Sky")
            newSky.SkyboxBk = ""
            newSky.SkyboxDn = ""
            newSky.SkyboxFt = ""
            newSky.SkyboxLf = ""
            newSky.SkyboxRt = ""
            newSky.SkyboxUp = ""
            newSky.SunAngularSize = 0
            newSky.MoonAngularSize = 0
            newSky.Parent = game.Lighting
            game.Lighting.Ambient = Color3.fromRGB(128,128,128)
            game.Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
        else
            for obj, value in pairs(originalData) do
                if typeof(obj) == "Instance" and obj.Parent then
                    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Explosion") then
                        obj.Enabled = value
                    elseif obj:IsA("Decal") or obj:IsA("Texture") then
                        obj.Transparency = value
                    elseif obj:IsA("MeshPart") or obj:IsA("UnionOperation") or obj:IsA("Part") then
                        obj.Material = value
                    elseif obj:IsA("SurfaceGui") or obj:IsA("BillboardGui") or obj:IsA("Beam") then
                        if obj:IsA("Beam") then
                            obj.Enabled = value
                        elseif obj.Enabled ~= nil then
                            obj.Enabled = value
                        end
                    end
                elseif obj == "GlobalShadows" then
                    game.Lighting.GlobalShadows = value
                elseif obj == "FogEnd" then
                    game.Lighting.FogEnd = value
                end
            end
            if skyBackup then
                local currentSky = game.Lighting:FindFirstChildOfClass("Sky")
                if currentSky then
                    currentSky:Destroy()
                end
                skyBackup.Parent = game.Lighting
                skyBackup = nil
            end
            originalData = {}
        end
    end
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

local clone, platform, originalCFrame, originalCameraSubject

local function CreatePlatform(position)
    local part = Instance.new("Part")
    part.Size = Vector3.new(10, 1, 10)
    part.Position = position - Vector3.new(0, 3, 0)
    part.Anchored = true
    part.CanCollide = true
    part.Transparency = 0.5
    part.Parent = workspace
    return part
end

local function CreateClone()
    local newClone = Character:Clone()
    for _, v in ipairs(newClone:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 0.5
        end
    end
    newClone.Parent = workspace
    return newClone
end

local function ToggleInvisibility(state)
    if state then
        originalCFrame = HumanoidRootPart.CFrame
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -50, 0)
        platform = CreatePlatform(HumanoidRootPart.Position)
        
        task.wait(1)
        
        clone = CreateClone()
        clone:MoveTo(originalCFrame.Position)
        Camera.CameraSubject = clone:FindFirstChildWhichIsA("Humanoid")
        LocalPlayer.Character = clone
    else
        if clone then
            clone:Destroy()
            clone = nil
        end
        
        if platform then
            platform:Destroy()
            platform = nil
        end
        
        if originalCFrame then
            HumanoidRootPart.CFrame = originalCFrame
            originalCFrame = nil
        end
        
        Camera.CameraSubject = Character:FindFirstChildWhichIsA("Humanoid")
        LocalPlayer.Character = Character
    end
end

Tab:Toggle({
    Title = "隐身",
    Value = false,
    Callback = ToggleInvisibility
})
local v_u_1 = require(game.ReplicatedStorage:WaitForChild("Core"))
local v155 = game.Players.LocalPlayer:WaitForChild("Data"):WaitForChild("Character")
local v156 = game.ReplicatedStorage.Characters:FindFirstChild(v155.Value):FindFirstChild("WallCombo")
local v158 = Vector3.new(7, 5, 7)
local v159 = CFrame.new(0, 0, 0)
local v160 = v_u_1.Get("Character", "FullCustomReplication").GetCFrame()
local v163 = game.Players.LocalPlayer.Character

local v167 = {
    ["Size"] = v158,
    ["Offset"] = v159,
    ["CustomValidation"] = function()
        return true
    end,
}

local v_u_168 = v_u_1.Get("Combat", "Hit").Box(nil, v163, v167)
local v58 = v156:GetAttribute("Interrupt")

function Run(p_u_7, p8, p_u_9, p10, ...)
    local v_u_11 = p_u_7 and p_u_7:FindFirstChild("Humanoid") or p_u_7
    local v_u_12 = p_u_7 and p_u_7:FindFirstChild("HumanoidRootPart") or p_u_7
    if p_u_7 and (v_u_11 and v_u_12) then
        local v_u_13 = p_u_7 == game.Players.LocalPlayer.Character
        local v_u_17 = p8
        v_u_1.Get("Combat", "Cancel").Init(v_u_17, p_u_9, p_u_7)
        v_u_1.Get("Combat", "Cancel").Set(v_u_17, p_u_9, p_u_7, "Timeout")
        local v_u_36 = { ... }
        task.spawn(function()
            local v37 = {}
            local v38 = v_u_36
            for i, v in ipairs({ p_u_7, v_u_11, v_u_12, v_u_13, p_u_9 }) do
                v37[i] = v
            end
            for i, v in ipairs(v38) do
                v37[#v37 + 1] = v
            end
            v_u_1.Get("Cosmetics", "KillEmote").RunAfter(v_u_17, table.unpack(v37))
        end)
    end
end

local originPos = v160.Position
local rs = game:GetService("RunService")
local running = false

Tab:Toggle({
    Title = "杀戮光环",
    Value = false,
    Callback = function(state)
        running = state
        if running then
            rs:BindToRenderStep("KillAura", Enum.RenderPriority.Input.Value, function()
                local pos = originPos + v160.LookVector * 6
                for i = 1, 4 do
                    task.spawn(function()
                        v_u_1.Library("Remote").Send("Ability", v156, 9e9, v58, v_u_168, pos)
                        Run(game.Players.LocalPlayer.Character, v156, 9e9, v58, v_u_168, pos)
                    end)
                end
            end)
        else
            rs:UnbindFromRenderStep("KillAura")
        end
    end
})
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local wallComboSpamming = false
local wallComboHeartbeat = nil
local wallComboPerFrame = 2
local wallComboKeybind = Enum.KeyCode.E

local core = require(ReplicatedStorage.Core)
local chars = ReplicatedStorage.Characters
local char = LocalPlayer.Data.Character

local function executeWallCombo()
    local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
    if not head then return end

    local res = core.Get("Combat","Hit").Box(nil, LocalPlayer.Character, {Size = Vector3.new(50,50,50)})
    if res then
        local success, err = pcall(core.Get("Combat","Ability").Activate, chars[char.Value].WallCombo, res, head.Position + Vector3.new(0,0,2.5))
        if not success then
            warn(err)
        end
    end
end

local function updateWallComboHeartbeat()
    if wallComboHeartbeat then
        wallComboHeartbeat:Disconnect()
        wallComboHeartbeat = nil
    end
    if wallComboSpamming then
        wallComboHeartbeat = RunService.Heartbeat:Connect(function()
            for i = 1, wallComboPerFrame do
                executeWallCombo()
            end
        end)
    end
end

UserInputService.InputBegan:Connect(function(input, isProcessed)
    if isProcessed then return end
    if input.KeyCode == wallComboKeybind then
        executeWallCombo()
    end
end)

Tab:Toggle({
    Title = "墙打秒杀",
    Value = false,
    Callback = function(state)
        wallComboSpamming = state
        updateWallComboHeartbeat()
    end
})
Tab:Button({
    Title = "删除墙打特效",
    Desc = "点了该功能就无法恢复墙打特效",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local paths = {
            ReplicatedStorage.Characters.Gon.WallCombo.GonWallCombo.Center,
            ReplicatedStorage.Characters.Gon.WallCombo.GonWallCombo.Explosion,
            ReplicatedStorage.Characters.Gon.WallCombo.GonIntroHands,
            ReplicatedStorage.Characters.Mob.WallCombo.MobWallCombo.Center,
            ReplicatedStorage.Characters.Nanami.WallCombo.NanamiWallCombo.Center,
            ReplicatedStorage.Characters.Stark.WallCombo.StarkWallCombo.Center,
            ReplicatedStorage.Characters.Sukuna.WallCombo.SukunaTransformWallCombo,
            ReplicatedStorage.Characters.Sukuna.WallCombo.SukunaWallCombo
        }

        for _, obj in ipairs(paths) do
            if obj and obj:IsA("Instance") then
                for _, child in ipairs(obj:GetChildren()) do
                    child:Destroy()
                end
            end
        end
    end
})
Tab:Button({
    Title = "删除击杀表情特效",
    Desc = "点击删除击杀表情的部分特效,不可恢复",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local KillEmote = ReplicatedStorage:WaitForChild("Cosmetics"):WaitForChild("KillEmote")

        local function removeEffects(obj)
            for _, child in ipairs(obj:GetChildren()) do
                if child:IsA("ParticleEmitter") 
                or child:IsA("Trail") 
                or child:IsA("Beam") 
                or child:IsA("Fire") 
                or child:IsA("Smoke") 
                or child:IsA("Sparkles") 
                or child:IsA("Light") then
                    child:Destroy()
                else
                    removeEffects(child)
                end
            end
        end

        removeEffects(KillEmote)
        print("KillEmote 特效已删除（保留本体）")
    end
})
 local ReplicatedStorage = game:GetService("ReplicatedStorage")
local multiUseCutscenesToggle = ReplicatedStorage.Settings.Toggles.MultiUseCutscenes

local defaultValue = false

Tab:Toggle({
    Title = "艾斯帕大招技能多次使用(全角色通用)",
    Value = multiUseCutscenesToggle.Value,
    Callback = function(state)
        if state then
            multiUseCutscenesToggle.Value = true
        else
            multiUseCutscenesToggle.Value = defaultValue
        end
    end
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local tpwalking = false
local tpwalkSpeed = 100

Tab:Toggle({
    Title = "速度",
    Value = false,
    Callback = function(state)
        tpwalking = state
        if state then
            spawn(function()
                while tpwalking do
                    local chr = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local hrp = chr:FindFirstChild("HumanoidRootPart")
                    local hum = chr:FindFirstChildWhichIsA("Humanoid")
                    local delta = RunService.Heartbeat:Wait()
                    if hrp and hum and hum.MoveDirection.Magnitude > 0 then
                        hrp.CFrame = hrp.CFrame + (hum.MoveDirection * tpwalkSpeed * delta)
                    end
                end
            end)
        end
    end
})

Tab:Slider({
    Title = "速度调节",
    Value = {
        Min = 0,
        Max = 250,
        Default = tpwalkSpeed,
    },
    Callback = function(value)
        tpwalkSpeed = value
    end
})
Tab:Slider({
    Title = "冲刺加速(默认值100)",
    Value = {
        Min = 0,
        Max = 1000,
        Default = 100,
    },
    Callback = function(value)
        game:GetService("ReplicatedStorage").Settings.Multipliers.DashSpeed.Value = value
    end
})

Tab:Slider({
    Title = "跳跃增强(默认值100)",
    Value = {
        Min = 0,
        Max = 1000,
        Default = 100,
    },
    Callback = function(value)
        game:GetService("ReplicatedStorage").Settings.Multipliers.JumpHeight.Value = value
    end
})

Tab:Slider({
    Title = "攻击加速(默认值100)",
    Value = {
        Min = 0,
        Max = 1000,
        Default = 100,
    },
    Callback = function(value)
        game:GetService("ReplicatedStorage").Settings.Multipliers.MeleeSpeed.Value = value
    end
})
local Players = game:GetService("Players")
local Tab = Window:Tab({
    Title = "碰撞箱扩大",
    Icon = "box",
    Locked = false,
})

local expansionMethod = "Add"
local hitboxX, hitboxY, hitboxZ = 0, 0, 0
local isHitboxExpanded = false
local hitModuleTable = nil
local originalBox = nil
local sizeModifier = Vector3.new(0, 0, 0)

local function setupHitboxHook()
    if hitModuleTable and hitModuleTable._boxSizeModifierHookInstalled then
        print("Hitbox hook already installed.")
        return true
    end
    
    local player = Players.LocalPlayer
    local playerScripts = player:WaitForChild("PlayerScripts")
    local combatFolder = playerScripts:WaitForChild("Combat")
    local hitModule = combatFolder:WaitForChild("Hit")
    
    hitModuleTable = require(hitModule)
    originalBox = hitModuleTable.Box
    
    hitModuleTable.Box = function(...)
        local args = {...}
        if args[3] and typeof(args[3]) == "table" then
            local config = args[3]
            if config.Size and typeof(config.Size) == "Vector3" then
                if not config._originalSize then
                    config._originalSize = config.Size
                end
                if expansionMethod == "Set" then
                    config.Size = sizeModifier
                elseif expansionMethod == "Add" then
                    config.Size = config._originalSize + sizeModifier
                end
            end
            return originalBox(...)
        else
            return originalBox(...)
        end
    end
    hitModuleTable._boxSizeModifierHookInstalled = true
    return true
end

local function applySigmaHitbox(x, y, z)
    if not setupHitboxHook() then
        warn("Failed to setup hitbox hook!")
        return
    end
    sizeModifier = Vector3.new(x, y, z)
    print("Sigma hitbox expansion applied:", sizeModifier)
end

Tab:Input({
    Title = "X 轴向量",
    Value = "0",
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "输入一个数字...",
    Callback = function(input)
        hitboxX = tonumber(input) or 0
        print("Hitbox X vector set to:", hitboxX)
    end
})

Tab:Input({
    Title = "Y 轴向量",
    Value = "0",
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "输入一个数字...",
    Callback = function(input)
        hitboxY = tonumber(input) or 0
        print("Hitbox Y vector set to:", hitboxY)
    end
})

Tab:Input({
    Title = "Z 轴向量",
    Value = "0",
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "输入一个数字...",
    Callback = function(input)
        hitboxZ = tonumber(input) or 0
        print("Hitbox Z vector set to:", hitboxZ)
    end
})

Tab:Dropdown({
    Title = "扩展方法",
    Values = {"Add", "Set"},
    Value = "Add",
    Multi = false,
    AllowNone = false,
    Callback = function(option)
        expansionMethod = option
        print("Hitbox method set to:", expansionMethod)
    end
})

Tab:Button({
    Title = "应用碰撞箱修改",
    Desc = nil,
    Locked = false,
    Callback = function()
        applySigmaHitbox(hitboxX, hitboxY, hitboxZ)
        isHitboxExpanded = true
    end
})

Tab:Button({
    Title = "小幅扩展 (+5范围)",
    Desc = nil,
    Locked = false,
    Callback = function()
        hitboxX, hitboxY, hitboxZ = 5, 5, 5
        applySigmaHitbox(hitboxX, hitboxY, hitboxZ)
        isHitboxExpanded = true
    end
})

Tab:Button({
    Title = "中幅扩展 (+10范围)",
    Desc = nil,
    Locked = false,
    Callback = function()
        hitboxX, hitboxY, hitboxZ = 10, 10, 10
        applySigmaHitbox(hitboxX, hitboxY, hitboxZ)
        isHitboxExpanded = true
    end
})

Tab:Button({
    Title = "大幅扩展 (+20范围)",
    Desc = nil,
    Locked = false,
    Callback = function()
        hitboxX, hitboxY, hitboxZ = 20, 20, 20
        applySigmaHitbox(hitboxX, hitboxY, hitboxZ)
        isHitboxExpanded = true
    end
})
local lightningCharacterSwapTab = Window:Tab({
    Title = "快速切换角色",
    Icon = "bird",
    Locked = false,
})

local lastPosition

local function getHumanoidRootPart()
    local character = LocalPlayer.Character
    return character and character:FindFirstChild("HumanoidRootPart")
end

local function savePosition()
    local rootPart = getHumanoidRootPart()
    if rootPart then
        lastPosition = rootPart.CFrame
    end
end

local function handleKeyPress(characterName)
    savePosition()
    
    local rootPart = getHumanoidRootPart()
    if rootPart then
        rootPart.CFrame = CFrame.new(1011.1289672851562, -1009.359588623046875, 116.37605285644531)
    end

    ReplicatedStorage.Remotes.Character.ChangeCharacter:FireServer(characterName)

    local groundY = workspace.Map.Structural.Ground:GetChildren()[21].Position.Y
    repeat task.wait() until getHumanoidRootPart() and getHumanoidRootPart().Position.Y > groundY
    task.wait(0.15)

    local newRootPart = getHumanoidRootPart()
    if newRootPart and lastPosition then
        repeat
            newRootPart.CFrame = lastPosition
            task.wait(0.1)
        until (newRootPart.Position - lastPosition.Position).Magnitude < 10
    end
end

lightningCharacterSwapTab:Button({
    Title = "快速切换成小杰",
    Locked = false,
    Callback = function() handleKeyPress("Gon") end
})

lightningCharacterSwapTab:Button({
    Title = "快速切换成被诅咒的导师",
    Locked = false,
    Callback = function() handleKeyPress("Nanami") end
})

lightningCharacterSwapTab:Button({
    Title = "快速切换成沉默的艾丝帕",
    Locked = false,
    Callback = function() handleKeyPress("Mob") end
})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local core = require(ReplicatedStorage:WaitForChild("Core"))
local Character = LocalPlayer.Character
local HumanoidRootPart = Character and Character:WaitForChild("HumanoidRootPart")
local orbitToggle = nil
local fakeWallToggle = nil
local serverStatus = "goodstate"

local forceKillEmoteTab = Window:Tab({
    Title = "击杀表情功能",
    Icon = "smile",
    Locked = false,
})

local killEmotes = {}
local isAuraMode = false
local isSpammingSelectedEmote = false
local auraDelay = 0.5
local spamDelay = 0.5
local selectedEmote = ""
local selectedKeybind = Enum.KeyCode.G
local emoteDropdown

local function getRoot(char)
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function useEmote(emoteName)
    local emoteModule = ReplicatedStorage:WaitForChild("Cosmetics"):WaitForChild("KillEmote"):FindFirstChild(emoteName)
    local myRoot = getRoot(LocalPlayer.Character)
    if not myRoot then return end
    local closestTarget = nil
    local shortestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetRoot = getRoot(player.Character)
            if targetRoot then
                local distance = (myRoot.Position - targetRoot.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestTarget = player.Character
                end
            end
        end
    end
    if closestTarget and emoteModule then
        task.spawn(function()
            _G.KillEmote = true
            pcall(function()
                if core and core.Get then
                    core.Get("Combat", "Ability").Activate(emoteModule, closestTarget)
                end
            end)
            _G.KillEmote = false
        end)
    end
end

local function useRandomEmote()
    if #killEmotes > 0 then
        local randomEmote = killEmotes[math.random(1, #killEmotes)]
        useEmote(randomEmote)
    end
end

task.spawn(function()
    while true do
        if isAuraMode then
            useRandomEmote()
            task.wait(auraDelay)
        else
            task.wait(0.1)
        end
    end
end)

task.spawn(function()
    while true do
        if isSpammingSelectedEmote and selectedEmote ~= "" then
            useEmote(selectedEmote)
            task.wait(spamDelay)
        else
            task.wait(0.1)
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, isGameProcessed)
    if isGameProcessed then return end
    if input.KeyCode == selectedKeybind and selectedEmote ~= "" then
        useEmote(selectedEmote)
    end
end)

local function createOrUpdateEmoteDropdown(emoteList)
    local values = emoteList
    if not values or #values == 0 then
        values = {"No emotes found"}
    end
    emoteDropdown = forceKillEmoteTab:Dropdown({
        Title = "击杀表情功能(要靠近别人)",
        Values = values,
        Multi = false,
        AllowNone = false,
        Callback = function(option)
            if option ~= "No emotes found" then
                selectedEmote = option
                useEmote(option)
            end
        end
    })
end

forceKillEmoteTab:Button({
    Title = "刷新击杀表情",
    Desc = "刷新可用的击杀表情",
    Callback = function()
        local currentEmotes = {}
        for _, emote in pairs(ReplicatedStorage:WaitForChild("Cosmetics"):WaitForChild("KillEmote"):GetChildren()) do
            table.insert(currentEmotes, emote.Name)
        end
        killEmotes = currentEmotes
        createOrUpdateEmoteDropdown(killEmotes)
    end
})

for _, emote in pairs(ReplicatedStorage:WaitForChild("Cosmetics"):WaitForChild("KillEmote"):GetChildren()) do
    table.insert(killEmotes, emote.Name)
end

createOrUpdateEmoteDropdown(killEmotes)

forceKillEmoteTab:Toggle({
    Title = "击杀表情光环",
    Desc = "对旁边的人持续使用随机的击杀表情",
    Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(isEnabled)
        isAuraMode = isEnabled
    end
})

forceKillEmoteTab:Slider({
    Title = "击杀表情光环间隔",
    Step = 0.01,
    Value = { Min = 0.01, Max = 5.0, Default = 0.5 },
    Callback = function(value)
        auraDelay = value
    end
})

forceKillEmoteTab:Toggle({
    Title = "持续发送你选择的表情",
    Desc = "持续发送当前选择的表情",
    Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(isEnabled)
        isSpammingSelectedEmote = isEnabled
    end
})

forceKillEmoteTab:Slider({
    Title = "调整你选择的表情速度",
    Step = 0.01,
    Value = { Min = 0.01, Max = 5.0, Default = 0.5 },
    Callback = function(value)
        spamDelay = value
    end
})

local emoteKeybindOptions = { "G", "F", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M", "Q", "E", "R", "T", "Y", "U", "I", "O", "P" }
local emoteKeybindMap = {
    ["G"] = Enum.KeyCode.G, ["F"] = Enum.KeyCode.F, ["H"] = Enum.KeyCode.H,
    ["J"] = Enum.KeyCode.J, ["K"] = Enum.KeyCode.K, ["L"] = Enum.KeyCode.L,
    ["Z"] = Enum.KeyCode.Z, ["X"] = Enum.KeyCode.X, ["C"] = Enum.KeyCode.C,
    ["V"] = Enum.KeyCode.V, ["B"] = Enum.KeyCode.B, ["N"] = Enum.KeyCode.N,
    ["M"] = Enum.KeyCode.M, ["Q"] = Enum.KeyCode.Q, ["E"] = Enum.KeyCode.E,
    ["R"] = Enum.KeyCode.R, ["T"] = Enum.KeyCode.T, ["Y"] = Enum.KeyCode.Y,
    ["U"] = Enum.KeyCode.U, ["I"] = Enum.KeyCode.I, ["O"] = Enum.KeyCode.O,
    ["P"] = Enum.KeyCode.P
}

forceKillEmoteTab:Dropdown({
    Title = "快捷键设置",
    Values = emoteKeybindOptions,
    Value = "G",
    Multi = false,
    AllowNone = false,
    Callback = function(option)
        selectedKeybind = emoteKeybindMap[option]
    end
})

forceKillEmoteTab:Button({
    Title = "随机用一个击杀表情",
    Desc = "字面意思",
    Locked = false,
    Callback = function()
        useRandomEmote()
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