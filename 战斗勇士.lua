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
    Title = "战斗勇士",
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
-- 初始化全局设置
_G.Settings = {
    enabled = false,
    antistuck = true,
    esp = false,
    autoequip = false,
    autospawn = false,
    antiparry = false,
    followclosest = false,
    autohit = false,
    antiradgoll = false,
    usemethod2 = false,
    loopspeed = 1,
    usehitbox = 1,
    range = 20,
    stompaura = false,
    autojump = false
}

-- ESP 系统功能
function addEsp()
    for _, player in pairs(game.Workspace.PlayerCharacters:GetChildren()) do
        if player.Name ~= game.Players.LocalPlayer.Name then
            if not player.HumanoidRootPart:FindFirstChild("eyeesspee") then
                local headGui = Instance.new("BillboardGui", player:WaitForChild("Head"))
                headGui.LightInfluence = 0
                headGui.Size = UDim2.new(40, 40, 1, 1)
                headGui.StudsOffset = Vector3.new(0, 3, 0)
                headGui.ZIndexBehavior = "Global"
                headGui.ClipsDescendants = false
                headGui.AlwaysOnTop = true
                headGui.Name = "Head"
                
                local nameText = Instance.new("TextBox", headGui)
                nameText.BackgroundTransparency = 1
                nameText.ClearTextOnFocus = false
                nameText.MultiLine = true
                nameText.Size = UDim2.new(1, 1, 1, 1)
                nameText.Font = "GothamBold"
                nameText.Text = player.Name
                nameText.TextScaled = true
                nameText.TextYAlignment = "Top"
                nameText.TextColor3 = Color3.fromRGB(255, 55, 55)
                
                local rootGui = Instance.new("BillboardGui", player:WaitForChild("HumanoidRootPart"))
                rootGui.LightInfluence = 0
                rootGui.Size = UDim2.new(3, 3, 5, 5)
                rootGui.StudsOffset = Vector3.new(0, 0, 0)
                rootGui.ZIndexBehavior = "Global"
                rootGui.ClipsDescendants = false
                rootGui.AlwaysOnTop = true
                rootGui.Name = "eyeesspee"
                
                local boxText = Instance.new("TextBox", rootGui)
                boxText.BackgroundTransparency = 1
                boxText.ClearTextOnFocus = false
                boxText.MultiLine = true
                boxText.Size = UDim2.new(1, 1, 1, 1)
                boxText.Font = "GothamBold"
                boxText.Text = " "
                boxText.BackgroundTransparency = 0.85
                boxText.TextScaled = true
                boxText.TextYAlignment = "Top"
                boxText.BackgroundColor3 = Color3.fromRGB(126, 0, 0)
            end
        end
    end
end

function removeEsp()
    for _, player in pairs(game.Workspace.PlayerCharacters:GetChildren()) do
        if player.Name ~= game.Players.LocalPlayer.Name then
            if player.HumanoidRootPart:FindFirstChild("eyeesspee") then
                player.HumanoidRootPart:FindFirstChild("eyeesspee"):Destroy()
                if player.Head:FindFirstChild("Head") then
                    player.Head.Head:Destroy()
                end
            end
        end
    end
end

-- 随机玩家功能
function randomPlayer()
    math.randomseed(os.time())
    local players = game.Players:GetPlayers()
    if #players > 0 then
        local randomPlayer = players[math.random(1, #players)]
        return randomPlayer.DisplayName
    end
    return ""
end

-- 连线功能
function addLine(from, to)
    if not to.Parent.Torso:FindFirstChild("Beam") then
        local beam = Instance.new("Beam")
        beam.Parent = to.Parent.Torso
        beam.Attachment0 = from.Parent.Torso.Attachment
        beam.Attachment1 = to.Parent.Torso.Attachment
        beam.Name = "Beam"
    end
end

function remLine(target)
    if target.Parent.Torso:FindFirstChild("Beam") then
        target.Parent.Torso:FindFirstChild("Beam"):Destroy()
    end
end

-- 走到最近的玩家
function walkToClosest()
    local closestHrp = nil
    local shortestDistance = 999999
    local localHrp = game.Workspace.PlayerCharacters[game.Players.LocalPlayer.Name]:FindFirstChild("HumanoidRootPart")
    
    for _, player in pairs(game.Workspace.PlayerCharacters:GetChildren()) do
        if player.Name ~= game.Players.LocalPlayer.Name and player.Humanoid.Health ~= 0 then
            local targetHrp = player:FindFirstChild("HumanoidRootPart")
            if targetHrp then
                local distance = (localHrp.Position - targetHrp.Position).Magnitude
                if distance < shortestDistance and player.Humanoid.Health ~= 0 then
                    shortestDistance = distance
                    closestHrp = targetHrp
                end
            end
        end
    end
    
    if closestHrp then
        game.Workspace.PlayerCharacters[game.Players.LocalPlayer.Name]:FindFirstChild("Humanoid").WalkToPoint = closestHrp.Position
    end
end

-- 获取最近的玩家HRP
function getClosestHrp()
    local closestHrp = nil
    local shortestDistance = 999999
    local localHrp = game.Workspace.PlayerCharacters[game.Players.LocalPlayer.Name]:FindFirstChild("HumanoidRootPart")
    
    for _, player in pairs(game.Workspace.PlayerCharacters:GetChildren()) do
        if player.Name ~= game.Players.LocalPlayer.Name and player.Humanoid.Health ~= 0 then
            local targetHrp = player:FindFirstChild("HumanoidRootPart")
            if targetHrp then
                local distance = (localHrp.Position - targetHrp.Position).Magnitude
                if distance < shortestDistance then
                    if distance <= _G.Settings.range and player.Humanoid.Health ~= 0 then
                        shortestDistance = distance
                        closestHrp = targetHrp
                    end
                end
            end
        end
    end
    
    return closestHrp
end

-- 设置附件位置
function setAttachmentWorldCFrame(attachment, cframe)
    if attachment and cframe then
        attachment.CFrame = attachment.Parent.CFrame:toObjectSpace(cframe)
    end
end

-- 主循环计时器
local espTimer = 0
local followTimer = 0
local attackTimer = 0
local stompTimer = 0
local antiRagdollTimer = 0

-- 主渲染循环
game:GetService("RunService").RenderStepped:Connect(function()
    -- 自动重生
    if game.Players.LocalPlayer.PlayerGui.RoactUI:FindFirstChild("MainMenu") and _G.Settings.autospawn then
        keypress(0x20) -- 空格键
        task.wait(0.1)
        keyrelease(0x20)
    end
    
    -- 自动装备武器
    if _G.Settings.autoequip then
        local character = game.Workspace.PlayerCharacters[game.Players.LocalPlayer.Name]
        if character and not character:FindFirstChildOfClass("Tool") and not game.Players.LocalPlayer.PlayerGui.RoactUI:FindFirstChild("MainMenu") then
            keypress(0x31) -- 1键
            task.wait(0.1)
            keyrelease(0x31)
        end
    end
    
    -- ESP更新
    espTimer = espTimer + 1
    if espTimer >= 60 then
        if _G.Settings.esp then
            addEsp()
        else
            removeEsp()
        end
        espTimer = 0
    end
    
    -- 跟随最近的玩家
    followTimer = followTimer + 1
    if followTimer >= 10 then
        if _G.Settings.followclosest then
            walkToClosest()
        end
        followTimer = 0
    end
    
    -- 攻击计时器
    attackTimer = attackTimer + 1
    stompTimer = stompTimer + 1
    
    local character = game.Workspace.PlayerCharacters[game.Players.LocalPlayer.Name]
    if not character then return end
    
    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then return end
    
    -- 移除多余的命中框
    if tool.Hitboxes:FindFirstChild("Hitbox2") then
        tool.Hitboxes.Hitbox2:Destroy()
    end
    
    local closestHrp = getClosestHrp()
    if not closestHrp then return end
    
    local equipProgress = tool:FindFirstChild("ClientEquipProgress")
    if not equipProgress then return end
    
    -- 攻击逻辑
    if not _G.Settings.usemethod2 then
        if attackTimer >= _G.Settings.loopspeed then
            attackTimer = 0
            for i, hitbox in pairs(tool.Hitboxes.Hitbox:GetChildren()) do
                if hitbox.Name == "DmgPoint" then
                    if i <= _G.Settings.usehitbox then
                        if _G.Settings.antiparry then
                            if closestHrp.Parent.SemiTransparentShield.Transparency == 1 then
                                equipProgress.Value = 1
                                if _G.Settings.enabled then
                                    setAttachmentWorldCFrame(
                                        hitbox,
                                        CFrame.new(
                                            closestHrp.Position + 
                                            Vector3.new(
                                                math.random(-1, 1),
                                                math.random(-1, 1),
                                                math.random(-1, 1)
                                            )
                                        )
                                    )
                                end
                            else
                                setAttachmentWorldCFrame(
                                    hitbox,
                                    CFrame.new(closestHrp.Position + Vector3.new(123, 123, 123))
                                )
                                equipProgress.Value = 0
                            end
                        else
                            if _G.Settings.enabled then
                                setAttachmentWorldCFrame(
                                    hitbox,
                                    CFrame.new(
                                        closestHrp.Position + 
                                        Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1))
                                    )
                                )
                            end
                        end
                    else
                        setAttachmentWorldCFrame(
                            hitbox,
                            CFrame.new(
                                character:FindFirstChild("Head").Position + Vector3.new(0, 10, 0)
                            )
                        )
                    end
                end
            end
        end
        
        -- 踩踏光环
        if _G.Settings.stompaura and character.Stomp then
            for i, stompHitbox in pairs(character.Stomp.Hitboxes.RightLegHitbox:GetChildren()) do
                if stompHitbox.Name == "DmgPoint" then
                    stompHitbox.Visible = true
                    if i <= _G.Settings.usehitbox then
                        if closestHrp.Parent.Humanoid.Health <= 15 then
                            setAttachmentWorldCFrame(
                                stompHitbox,
                                CFrame.new(
                                    closestHrp.Position + 
                                    Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1))
                                )
                            )
                            if stompTimer >= 30 then
                                keypress(0x51) -- Q键
                                task.wait(0.1)
                                keyrelease(0x51)
                                stompTimer = 0
                            end
                        end
                    end
                end
            end
        end
    end
end)
local Combat = Window:Tab({Title = "战斗勇士", Icon = "swords"})

-- 主要功能
Combat:Toggle({
    Title = "自动行走",
    Value = false,
    Callback = function(state)
        _G.Settings.followclosest = state
    end
})

Combat:Toggle({
    Title = "自动重生",
    Value = false,
    Callback = function(state)
        _G.Settings.autospawn = state
    end
})

Combat:Toggle({
    Title = "自动装备",
    Value = false,
    Callback = function(state)
        _G.Settings.autoequip = state
    end
})

Combat:Toggle({
    Title = "自动攻击",
    Value = false,
    Callback = function(state)
        _G.Settings.autohit = state
        if state then
            task.spawn(function()
                while _G.Settings.autohit do
                    mouse1click()
                    task.wait(1)
                end
            end)
        end
    end
})

-- 其他功能
local OtherFunctions = Window:Tab({Title = "其他功能", Icon = "shield"})

OtherFunctions:Toggle({
    Title = "反招架",
    Value = false,
    Callback = function(state)
        _G.Settings.antiparry = state
    end
})

OtherFunctions:Toggle({
    Title = "反辐射",
    Value = false,
    Callback = function(state)
        _G.Settings.antiradgoll = state
        if state then
            task.spawn(function()
                while _G.Settings.antiradgoll do
                    pcall(function()
                        game:GetService("Players").LocalPlayer.Character.Humanoid.RagdollRemoteEvent:FireServer(false)
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end
})

OtherFunctions:Toggle({
    Title = "玩家透视",
    Value = false,
    Callback = function(state)
        _G.Settings.esp = state
        if not state then
            removeEsp()
        end
    end
})

-- 反盾功能
OtherFunctions:Button({
    Title = "反盾",
    Callback = function()
        local lp = game.Players.LocalPlayer
        local animationInfo = {}
        
        function getAnimationInfo(id)
            local success, info = pcall(function()
                return game:GetService("MarketplaceService"):GetProductInfo(id)
            end)
            if success then
                return info
            end
            return {Name = ''}
        end
        
        function block(player)
            keypress(0x46) -- F键
            task.wait(0.1)
            keyrelease(0x46)
        end
        
        local attackAnimations = {'Slash', 'Swing', 'Sword'}
        
        function setupPlayer(v)
            local function setupCharacter(char)
                local humanoid = char:WaitForChild("Humanoid", 5)
                if humanoid then
                    humanoid.AnimationPlayed:Connect(function(track)
                        local animationId = track.Animation.AnimationId
                        local info = animationInfo[animationId]
                        
                        if not info then
                            local idMatch = animationId:match("%d+")
                            if idMatch then
                                info = getAnimationInfo(tonumber(idMatch))
                                animationInfo[animationId] = info
                            end
                        end
                        
                        if info and lp.Character and lp.Character:FindFirstChild("Head") and v.Character and v.Character:FindFirstChild("Head") then
                            local distance = (v.Character.Head.Position - lp.Character.Head.Position).Magnitude
                            if distance < 15 then
                                for _, animName in pairs(attackAnimations) do
                                    if info.Name:match(animName) then
                                        pcall(block, v)
                                        break
                                    end
                                end
                            end
                        end
                    end)
                end
            end
            
            if v.Character then
                setupCharacter(v.Character)
            end
            v.CharacterAdded:Connect(setupCharacter)
        end
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= lp then
                setupPlayer(player)
            end
        end
        
        game.Players.PlayerAdded:Connect(setupPlayer)
        
        WindUI:Notify({Title = "提示", Content = "反盾功能已开启", Duration = 3})
    end
})

-- 无敌功能
OtherFunctions:Button({
    Title = "敌人打不死",
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local spawnbox = workspace:FindFirstChild("SpawnBox")
            
            if spawnbox and spawnbox:FindFirstChild("SpawnPart") then
                hrp.CFrame = spawnbox.SpawnPart.CFrame
                WindUI:Notify({Title = "提示", Content = "已传送到出生点", Duration = 3})
            else
                WindUI:Notify({Title = "错误", Content = "未找到出生点", Duration = 3})
            end
        end
    end
})

-- 保存设置功能
function saveSettings()
    WindUI:Notify({Title = "提示", Content = "设置已保存", Duration = 2})
end

-- 加载设置功能
function loadSettings()
    WindUI:Notify({Title = "提示", Content = "设置已加载", Duration = 2})
end

































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