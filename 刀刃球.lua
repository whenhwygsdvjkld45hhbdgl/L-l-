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
    Title = "刀刃球",
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






    local LanguageTab = Window:Tab({Title = "语言设置", Icon = "globe"})

local Translations = {
    -- 窗口标题和标签页
    ["大司马脚本"] = "大司马脚本",
    ["尊贵的"] = "Respected ",
    ["欢迎使用大司马脚本"] = "Welcome to 大司马脚本",
    ["刀刃球"] = "Blade Ball",
    ["大司马脚本 V1"] = "大司马脚本 V1",
    ["主要"] = "Main",
    ["美化剑"] = "Sword Skins",
    ["透视"] = "ESP",
    ["玩家"] = "Player",
    ["语言设置"] = "Language Settings",

    -- 主要功能
    ["预判击球"] = "Prediction Hit",
    ["自动闪避球"] = "Auto Dodge Ball",
    ["传送击打"] = "Teleport Hit",
    ["防近球传送"] = "Anti Close Ball Teleport",
    ["防CD传送"] = "Anti CD Teleport",
    
    -- 格挡设置
    ["格挡类型"] = "Parry Type",
    ["相机"] = "Camera",
    ["随机"] = "Random",
    ["向后"] = "Backward",
    ["直线"] = "Straight",
    ["向上"] = "Upward",
    ["向左"] = "Left",
    ["向右"] = "Right",
    ["随机目标"] = "Random Target",
    ["随机格挡精度"] = "Random Parry Accuracy",
    ["幻影模式检测"] = "Phantom Mode Detection",
    ["无限模式检测"] = "Infinity Mode Detection",
    ["按键触发"] = "Keypress Trigger",
    ["通知"] = "Notifications",

    -- 美化剑功能
    ["开启美化剑[先选择]"] = "Enable Sword Skin [Select First]",
    ["选择剑皮肤 [普通]"] = "Select Sword Skin [Common]",
    ["选择剑皮肤 [好的]"] = "Select Sword Skin [Good]",
    ["选择剑皮肤 [代码]"] = "Select Sword Skin [Code]",
    ["选择剑皮肤 [独家商品]"] = "Select Sword Skin [Exclusive]",
    ["选择剑皮肤 [限时模式]"] = "Select Sword Skin [Limited Time]",
    ["选择剑皮肤 [排位赛]"] = "Select Sword Skin [Ranked]",
    ["选择剑皮肤 [顶级]"] = "Select Sword Skin [Top Tier]",
    ["选择剑皮肤 [限量版]"] = "Select Sword Skin [Limited Edition]",

    -- 透视功能
    ["透视球状态"] = "Ball Status ESP",
    ["透视球速度"] = "Ball Speed ESP",
    ["透视轨迹"] = "Ball Trail ESP",
    ["未找到球"] = "No Ball Found",
    ["球状态 | DYHUB"] = "Ball Status | DYHUB",
    ["速度"] = "Speed",
    ["距离"] = "Distance",
    ["目标"] = "Target",
    ["静止"] = "Stationary",
    ["飞行中"] = "Flying",

    -- 玩家功能
    ["速度 (开/关)"] = "Speed (On/Off)",
    ["速度设置"] = "Speed Settings",
    ["滑动调整"] = "Slide to adjust",

    -- 通知消息
    ["传送预判击打已开启"] = "Teleport Prediction Hit Enabled",
    ["传送预判击打已关闭"] = "Teleport Prediction Hit Disabled",
    ["触发击打 | 速度"] = "Trigger Hit | Speed",
    ["比例"] = "Ratio",
    ["传送回原位"] = "Teleported Back to Original Position",
    ["击打目标是自己，不传送回原位"] = "Hit target is self, not teleporting back",
    ["击打CD中，向后传送15米 | 剩余CD"] = "Hit CD active, teleporting back 15m | Remaining CD",
    ["秒"] = "seconds",
    ["检测到近球，向后传送15米 | 距离"] = "Close ball detected, teleporting back 15m | Distance",
    ["米"] = "meters",
    ["CD保护触发 | 以超快速度将球传送至安全位置"] = "CD Protection Triggered | Teleporting ball to safe position at ultra speed",
    ["加载中..."] = "Loading...",

    -- 语言设置
    ["当前语言"] = "Current Language",
    ["中文"] = "Chinese",
    ["英文"] = "English",
    ["应用语言"] = "Apply Language",
    ["语言更改"] = "Language Change",
    ["成功"] = "Success",
    ["语言"] = "Language",
    ["当前语言已经是"] = "Current language is already",
    ["请重启脚本以使更改生效"] = "Please restart the script for changes to take effect"
}

local currentLanguage = "Chinese"
local languageChanged = false

LanguageTab:Dropdown({
    Title = "当前语言",
    Values = {"中文", "English"},
    Value = "中文",
    Callback = function(option)
        if option == "English" then
            currentLanguage = "English"
        else
            currentLanguage = "Chinese"
        end
        languageChanged = true
    end
})

LanguageTab:Button({
    Title = "应用语言",
    Callback = function()
        if languageChanged then
            WindUI:Notify({
                Title = "语言更改",
                Content = "请重启脚本以使更改生效",
                Duration = 5,
                Icon = "info"
            })
            languageChanged = false
        else
            WindUI:Notify({
                Title = "语言",
                Content = "当前语言已经是 " .. currentLanguage,
                Duration = 3,
                Icon = "info"
            })
        end
    end
})

local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    
    if currentLanguage == "English" then
        return Translations[text] or text
    else
        for cn, en in pairs(Translations) do
            if text == en then
                return cn
            end
        end
        return text
    end
end

local function translateGUI(gui)
    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) then
        pcall(function()
            local text = gui.Text
            if text and text ~= "" then
                local translatedText = translateText(text)
                if translatedText ~= text then
                    gui.Text = translatedText
                end
            end
        end)
    end
end

local function scanAndTranslate()
    for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
        translateGUI(gui)
    end
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
            translateGUI(gui)
        end
    end
end

local function setupDescendantListener(parent)
    parent.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
            task.wait(0.1)
            translateGUI(descendant)
        end
    end)
end

local function setupTranslationEngine()
    pcall(setupDescendantListener, game:GetService("CoreGui"))
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        pcall(setupDescendantListener, player.PlayerGui)
    end
    scanAndTranslate()
    while true do
        scanAndTranslate()
        task.wait(3)
    end
end

task.spawn(function()
    task.wait(2)
    setupTranslationEngine()
end)
    
        local Main = Window:Tab({Title = "主要", Icon = "settings"})
local function GetBall()
    for _, Ball in ipairs(workspace.Balls:GetChildren()) do
        if Ball:GetAttribute("realBall") then
            return Ball
        end
    end
    return nil
end

local function IsTarget(ball)
    return ball:GetAttribute("target") == tostring(game.Players.LocalPlayer)
end

local function ZJ()
    local Max_Distance = math.huge
    local Found_Entity = nil
    local Player = game.Players.LocalPlayer
    
    for _, Entity in pairs(workspace.Alive:GetChildren()) do
        if tostring(Entity) ~= tostring(Player) then
            if Entity.PrimaryPart then
                local Distance = Player:DistanceFromCharacter(Entity.PrimaryPart.Position)
                if Distance < Max_Distance then
                    Max_Distance = Distance
                    Found_Entity = Entity
                end
            end
        end
    end
    
    return Found_Entity
end

local function IsSpamming(entity, radius)
    if not entity then return false end
    local Player = game.Players.LocalPlayer
    local Distance = Player:DistanceFromCharacter(entity.PrimaryPart.Position)
    return Distance <= radius
end

Main:Toggle({
    Title = "预判击球",
    Default = false,
    Callback = function(Value)
        AP = Value
        local connection = nil
        
        if connection then
            connection:Disconnect()
            connection = nil
        end
        
        if Value then
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local VirtualInputManager = game:GetService("VirtualInputManager")
            local Player = Players.LocalPlayer
            
            connection = RunService.Heartbeat:Connect(function()
                if not AP then 
                    if connection then
                        connection:Disconnect()
                        connection = nil
                    end
                    return 
                end
                
                local character = Player.Character
                if not character then return end
                
                local HRP = character:FindFirstChild("HumanoidRootPart")
                if not HRP then return end
                
                local ball = GetBall()
                if not ball then return end
                
                local DY = ball.zoomies.VectorVelocity or ball.AssemblyLinearVelocity
                local BallSpeed = DY.Magnitude
                local Distance = Player:DistanceFromCharacter(ball.Position) - 3
                local Radius = ball.Velocity.Magnitude / 2.2 + (Player:GetNetworkPing() * 20)
                
                if ((HRP.Position - ball.Position).Unit:Dot(DY.Unit) > 0) and IsTarget(ball) and Distance <= Radius then
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "自动闪避球",
    Default = false,
    Callback = function(Value)
        AT = Value
        local connection = nil
        
        if connection then
            connection:Disconnect()
            connection = nil
        end
        
        if Value then
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local VirtualInputManager = game:GetService("VirtualInputManager")
            local Player = Players.LocalPlayer
            
            connection = RunService.Heartbeat:Connect(function()
                if not AT then 
                    if connection then
                        connection:Disconnect()
                        connection = nil
                    end
                    return 
                end
                
                local character = Player.Character
                if not character then return end
                
                local HRP = character:FindFirstChild("HumanoidRootPart")
                if not HRP then return end
                
                local ball = GetBall()
                if not ball then return end
                
                local DY = ball.zoomies.VectorVelocity or ball.AssemblyLinearVelocity
                local BallSpeed = DY.Magnitude
                
                if ((HRP.Position - ball.Position).Unit:Dot(DY.Unit) > 0) and IsTarget(ball) then
                    HRP.CFrame = ball.CFrame + Vector3.new(0.9*BallSpeed, -(0.9*BallSpeed), 0)
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                end
            end)
        end
    end
})

local AutoSpam = false
local connection = nil
local originalPosition = nil

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Player = Players.LocalPlayer

local function StopAuto()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    originalPosition = nil
    AutoSpam = false
    warn("传送预判击打已关闭")
end

local function StartAuto()
    if connection then
        connection:Disconnect()
    end

    AutoSpam = true
    warn("传送预判击打已开启")

    connection = RunService.Heartbeat:Connect(function()
        if not AutoSpam then return end

        local character = Player.Character
        if not character then return end

        local HRP = character:FindFirstChild("HumanoidRootPart")
        local highlight = character:FindFirstChild("Highlight")
        if not HRP or not highlight then return end

        for _, Ball in ipairs(workspace.Balls:GetChildren()) do
            if Ball:GetAttribute("realBall") then
                local Speed = Ball.zoomies.VectorVelocity.Magnitude
                local Distance = (HRP.Position - Ball.Position).Magnitude
                local ratio = Distance / Speed

                if ratio <= 0.7 then
                    originalPosition = HRP.Position

                    local ballVelocity = Ball.zoomies.VectorVelocity.Unit
                    local teleportPosition = Ball.Position - (ballVelocity * 5)

                    HRP.CFrame = CFrame.new(teleportPosition)

                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    warn("触发击打 | 速度:", Speed, "距离:", Distance, "比例:", ratio)

                    task.delay(0, function()
                        if originalPosition and HRP then
                            local hitTarget = Ball:GetAttribute("lastHit")
                            if hitTarget ~= Player.Name then
                                HRP.CFrame = CFrame.new(originalPosition)
                                warn("传送回原位")
                            else
                                warn("击打目标是自己，不传送回原位")
                            end
                        end
                    end)

                    break
                end
            end
        end
    end)
end

Main:Toggle({
    Title = "传送击打",
    Default = false,
    Callback = function(Value)
        if Value then
            StartAuto()
        else
            StopAuto()
        end
    end
})


Main:Toggle({
    Title = "防近球传送",
    Default = false,
    Callback = function(Value)
        local AntiBall = Value
        local connection = nil
        local cooldown = false
        
      
        if not Value then
            if connection then
                connection:Disconnect()
                connection = nil
            end
            cooldown = false
            return
        end
        
      
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        
        connection = RunService.Heartbeat:Connect(function()
            if not AntiBall or cooldown then return end
            
            local character = Player.Character
            if not character then return end
            
            local HRP = character:FindFirstChild("HumanoidRootPart")
            if not HRP then return end
            
            local combat = character:FindFirstChild("Combat")
            if combat then
                local hitCD = combat:FindFirstChild("HitCD")
                if hitCD and hitCD.Value > 0 then
                    cooldown = true
                    
                    local backwardVector = -HRP.CFrame.LookVector * 15
                    local newPosition = HRP.Position + backwardVector
                    
                    HRP.CFrame = CFrame.new(newPosition)
                    
                    warn("击打CD中，向后传送15米 | 剩余CD:", math.floor(hitCD.Value*100)/100, "秒")
                    
                    task.delay(0, function()
                        cooldown = false
                    end)
                    
                    return
                end
            end
            
            for _, Ball in ipairs(workspace.Balls:GetChildren()) do
                if Ball:GetAttribute("realBall") then
                    local distance = (HRP.Position - Ball.Position).Magnitude
                    
                    if distance < 5 then
                        cooldown = true
                        
                        local backwardVector = -HRP.CFrame.LookVector * 30
                        local newPosition = HRP.Position + backwardVector
                        
                        HRP.CFrame = CFrame.new(newPosition)
                        
                        warn("检测到近球，向后传送15米 | 距离:", math.floor(distance*100)/100, "米")
                        
                        task.delay(0, function()
                            cooldown = false
                        end)
                        
                        break
                    end
                end
            end
        end)
    end
})

Main:Toggle({
    Title = "防CD传送",
    Default = false,
    Callback = function(Value)
        local AutoEvade = Value
        local connection = nil
        local safeDistance = 30
        local teleportSpeed = 5000
        
 
        if not Value then
            if connection then
                connection:Disconnect()
                connection = nil
            end
            return
        end
        
      
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        
        connection = RunService.Heartbeat:Connect(function()
            if not AutoEvade then return end
            
            local character = Player.Character
            if not character then return end
            
            local HRP = character:FindFirstChild("HumanoidRootPart")
            if not HRP then return end
            
            local canHit = true
            local hitCooldown = character:FindFirstChild("HitCooldown")
            if hitCooldown and hitCooldown.Value > 0 then
                canHit = false
            end
            
            for _, Ball in ipairs(workspace.Balls:GetChildren()) do
                if Ball:GetAttribute("realBall") then
                    local target = Ball:GetAttribute("target")
                    local isTargetingMe = target and target == Player.UserId
                    
                    if not canHit and isTargetingMe then
                        local lookVector = HRP.CFrame.LookVector
                        local evadePosition = HRP.Position - (lookVector * safeDistance)
                        
                        evadePosition = Vector3.new(
                            math.clamp(evadePosition.X, -100, 100), 
                            HRP.Position.Y, 
                            math.clamp(evadePosition.Z, -100, 100)
                        )
                        
                        local direction = (evadePosition - Ball.Position).Unit
                        local velocity = direction * teleportSpeed
                        
                        if Ball:FindFirstChild("zoomies") then
                            Ball.zoomies.VectorVelocity = velocity
                        else
                            Ball:PivotTo(CFrame.new(evadePosition))
                        end
                        
                        warn("CD保护触发 | 以超快速度将球传送至安全位置")
                        break
                    end
                end
            end
        end)
    end
})


local autoParryEnabled = false
local parryType = "相机"
local parryAccuracy = 100
local randomAccuracy = false
local phantomDetection = false
local infinityDetection = false
local keypressEnabled = false
local notifyEnabled = false

Main:Dropdown({
    Title = "格挡类型",
    Values = {"相机", "随机", "向后", "直线", "向上", "向左", "向右", "随机目标"},
    Value = "相机",
    Callback = function(option)
        parryType = option
    end
})


Main:Toggle({
    Title = "随机格挡精度",
    Value = false,
    Callback = function(value)
        randomAccuracy = value
        getgenv().RandomParryAccuracyEnabled = value
    end
})

Main:Toggle({
    Title = "幻影模式检测",
    Value = false,
    Callback = function(value)
        phantomDetection = value
        PhantomV2Detection = value
    end
})

Main:Toggle({
    Title = "无限模式检测",
    Value = false,
    Callback = function(value)
        infinityDetection = value
        getgenv().InfinityDetection = value
    end
})

Main:Toggle({
    Title = "按键触发",
    Value = false,
    Callback = function(value)
        keypressEnabled = value
        getgenv().AutoParryKeypress = value
    end
})

Main:Toggle({
    Title = "通知",
    Value = false,
    Callback = function(value)
        notifyEnabled = value
    end
})
local Main = Window:Tab({Title = "美化剑", Icon = "settings"})

local enabled = false
local swordName = "Base Sword"
local p = game:GetService("Players").LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local swords = require(rs:WaitForChild("Shared", 9e9):WaitForChild("ReplicatedInstances", 9e9):WaitForChild("Swords", 9e9))
local ctrl, playFx, lastParry = nil, nil, 0

task.spawn(function()
    while task.wait(1) and not ctrl do
        for _, v in getconnections(rs.Remotes.FireSwordInfo.OnClientEvent) do
            if v.Function and islclosure(v.Function) then
                local u = getupvalues(v.Function)
                if #u == 1 and type(u[1]) == "table" then
                    ctrl = u[1]
                    break
                end
            end
        end
    end
end)

local function getSlash(name)
    local s = swords:GetSword(name)
    return (s and s.SlashName) or "SlashEffect"
end

local function setSword()
    if not enabled then return end
    if not p.Character then return end
    
    pcall(function()
        setupvalue(rawget(swords, "EquipSwordTo"), 2, false)
        swords:EquipSwordTo(p.Character, swordName)
        if ctrl then
            ctrl:SetSword(swordName)
        end
    end)
end

task.spawn(function()
    while task.wait(1) do
        if enabled and swordName ~= "" and p.Character then
            if p:GetAttribute("CurrentlyEquippedSword") ~= swordName or not p.Character:FindFirstChild(swordName) then
                setSword()
            end
            
            for _, m in pairs(p.Character:GetChildren()) do
                if m:IsA("Model") and m.Name ~= swordName then
                    m:Destroy()
                end
            end
        end
    end
end)

Main:Toggle({
    Title = "开启美化剑[先选择]",
    Value = false,
    Callback = function(value)
        enabled = value
        if value then
            setSword()
        end
    end
})

Main:Dropdown({
    Title = "选择剑皮肤 [普通]",
    Values = {"Base Sword", "Titan's Gleam", "Awakened Titan's Gleam", "Void Hammer", "Awakened Void Hammer",
        "Righteous Blade", "Awakened Righteous Blade", "Emperor's Axe", "Awakened Emperor's Axe",
        "Lunar Hammer", "Awakened Lunar Hammer", "Sunburst Axe", "Awakened Sunburst Axe",
        "Emerald Katana", "Awakened Emerald Katana", "Sky Axe", "Awakened Sky Axe",
        "Blazing Darkblade", "Awakened Blazing Darkblade", "Anchored Crusher", "Awakened Anchored Crusher",
        "Crystal Staff", "Awakened Crystal Staff", "Lunar Protector", "Awakened Lunar Protector",
        "Eggquinox Blade", "Awakened Eggquinox Blade", "Empyreal Blade", "Awakened Empyreal Blade",
        "Celestial Aegis", "Awakened Celestial Aegis", "Architect", "Awakened Architect",
        "Subversion", "Awakened Subversion", "Staff of Despair", "Awakened Staff of Despair",
        "Moral Duality", "Awakened Moral Duality", "Medusa's Wraith", "Awakened Medusa's Wraith",
        "Winter's Touch", "Awakened Winter's Touch", "Venomweaver", "Awakened Venomweaver",
        "Hydra's Bane", "Awakened Hydra's Bane", "Periastron's Glory", "Awakened Periastron's Glory",
        "Bane of Ferocity", "Awakened Bane of Ferocity", "Forgotten Scythe", "Awakened Forgotten Scythe",
        "Trinity Axe", "Awakened Trinity Axe", "Fabled Sword", "Awakened Fabled Sword",
        "Ashblade", "Awakened Ashblade", "Nightfall", "Awakened Nightfall",
        "Ancient Defender", "Awakened Ancient Defender", "Kraken's Wraith", "Awakened Kraken's Wraith",
        "Cursed Abyss", "Awakened Cursed Abyss", "Megatooth Relic", "Awakened Megatooth Relic",
        "Phoenix Rebirth", "Awakened Phoenix Rebirth", "Frozen Eternity", "Awakened Frozen Eternity",
        "Dragon's Wraith", "Awakened Dragon's Wraith", "Kraken's Fury", "Awakened Kraken's Fury",
        "Ethereal Scythe", "Awakened Ethereal Scythe", "Cybotic Scythe", "Awakened Cybotic Scythe",
        "Netherfang", "Awakened Netherfang", "大司马脚本 Reaper", "Awakened 大司马脚本 Reaper",
        "Aurora's Wrath", "Awakened Aurora's Wrath", "Chrono Fang", "Awakened Chrono Fang",
        "Void Engine Blade", "Awakened Void Engine Blade", "Eclipse Desire", "Awakened Eclipse Desire",
        "Exo-Godslayer", "Awakened Exo-Godslayer", "Everbloom Fang", "Awakened Everbloom Fang",
        "Oblivion Scythe", "Awakened Oblivion Scythe", "Mythic Eggclipse", "Awakened Mythic Eggclipse",
        "Oni's Pact", "Awakened Oni's Pact", "Voltage Edge", "Awakened Voltage Edge"},
    Default = "Base Sword",
    Callback = function(value)
        swordName = value
        if enabled then
            setSword()
        end
    end
})

Main:Dropdown({
    Title = "选择剑皮肤 [好的]",
    Values = {"Base Sword", "Ban Hammer", "Chroma Ban Hammer", "Failsafe", "Borealis", "Noob", "Celestial Lance",
        "Midas Thorn", "Dragon Scythe", "Blackhole Gauntlets", "Flowing Fists", "Halberd", "princ2", "Nothing",
        "BAH", "InceptionTime's Hammer", "Pillar", "Small Sapling", "Skib", "HardRockStick",
        "Stratocaster Electric Guitar", "Bobber", "Ultimate Ruby", "Pretty Princess Wand", "Princess Fan",
        "Godsaber", "COAL", "Ancient Cutlass", "Great Axe", "Ancient Spear", "SentinelStaff", "Hallow's Wrath",
        "Dual Dragonfire Katana", "Witchfire Blade", "Mighty Ninja's Racket", "Pink Warrior's Racket",
        "Angry Canaries Racket", "Giant Feet Racket", "Mirror Blade", "Flamingo SlayerOLD", "Ice Breaker",
        "Peppermint Slasher", "Winter's Slicer", "Holly Edge", "New Year's Edge", "Eggscalibur", "Guardian Blade",
        "Void Slicer", "Quantum Edge", "Zombie Sword", "Vampire Sword", "Yeti Blade", "Crimson Claus",
        "Elven Spark", "Chrono Slicer", "Phoenix Fang", "Falling Petals Katana", "Blossom Kiss Blade",
        "Lover's Axe", "Iridescent Stormblade", "Spectral Fang", "Papa Smurf Shield", "Smurf's Hammer",
        "Link Blade", "Eclipse Fang", "Awakened Onyx Katana", "Barnacle Edge", "Claymore of the Damned",
        "Regal Radianceblade", "Blight's Bane", "Tide Caller", "Arcane's Blade", "Veil's Descent", "Quantum Blade",
        "Sundered Skies", "Sunbeam Saber", "Phoenix's Edge", "Griffon's Clasp", "Pulse Blade", "Bronze Shear",
        "Laser Longsword", "Magic Wand", "giveable apex", "giveable champ", "SpyderSammy",
        "Color Changing Sword Test", "Titan Blade", "RAPIER_PLACEHOLDER", "blade nil"},
    Default = "Base Sword",
    Callback = function(value)
        swordName = value
        if enabled then
            setSword()
        end
    end
})

Main:Dropdown({
    Title = "选择剑皮肤 [代码]",
    Values = {"Base Sword", "The Nooblade", "Naturic Cutlass", "Hotdog Sword", "Remnant Sword", "Pumpkin PieBlade",
        "1B Sword", "Ball on a Stick", "Comically Large Flashlight", "Equinox Ball Kebab", "Bubble Wand",
        "Midas Thorn", "SPARKLERR"},
    Default = "Base Sword",
    Callback = function(value)
        swordName = value
        if enabled then
            setSword()
        end
    end
})

Main:Dropdown({
    Title = "选择剑皮肤 [独家商品]",
    Values = {"Base Sword", "Void Guardian", "Retribution Guitar", "Dragon's Omen", "Starscope Sniper",
        "Inksoul Brush", "Dual Star Staffs", "Blackhole Sword", "Blackhole Set"},
    Default = "Base Sword",
    Callback = function(value)
        swordName = value
        if enabled then
            setSword()
        end
    end
})

Main:Dropdown({
    Title = "选择剑皮肤 [限时模式]",
    Values = {"Base Sword", "Cosmic Starblade", "大司马脚本shard Blade", "Dawnblade", "Revenant's Vow", "Starfall",
        "Leafsong", "Poseidon's Trident", "Storm Slicer", "Serpent's Katana", "Katana of the Red Flames",
        "Inferno Scythe", "Flamingo Slayer", "Cybotic Champion", "Futuristic Edge", "Cyber Slasher",
        "Wraith's Whisper", "Crypt Keeper", "Soulbinder's Edge", "Nightmare Reaver", "Infernal Fang",
        "Phantom Warrior", "Glacial Fang", "大司马脚本bite Edge", "Winter Sovereign Blade", "Electric Ice Blade",
        "Aurora Warrior", "Resolution Rumble Champion", "Resolution Rumble Warrior", "Ruby Cutter",
        "Thorned Coilblade", "Eclipse Backsword", "Runebreaker Staff", "Rose Greatsword", "Ethereal Sovereign",
        "Chroma Fortune Cleaver", "Mystical Crossbow", "Keyblade", "Spring Championblade", "Electric Sunblade",
        "Enchanted Backblade", "Pastel Spear", "Tidewither", "Water Bow", "Sundue Slash"},
    Default = "Base Sword",
    Callback = function(value)
        swordName = value
        if enabled then
            setSword()
        end
    end
})

Main:Dropdown({
    Title = "选择剑皮肤 [排位赛]",
    Values = {"Base Sword", "Ranked Season 1 Top 1", "Ranked Season 1 Top 50", "Ranked Season 1 Top 200",
        "Cyber Cleaveblade", "Ranked Season 2 Top 1", "Ranked Season 2 Top 50", "Ranked Season 2 Top 200",
        "Azure Thunderbolt", "Ranked Season 3 Top 1", "Ranked Season 3 Top 50", "Ranked Season 3 Top 200",
        "Champion's Excalibur", "Ranked Season 4 Top 1", "Ranked Season 4 Top 25", "Ranked Season 4 Top 100",
        "Valor's Rage", "Ranked Season 5 Top 1", "Ranked Season 5 Top 50", "Ranked Season 5 Top 200",
        "Ranked Season 5 Champion", "Ranked Season 6 Top 1", "Ranked Season 6 Top 50", "Ranked Season 6 Top 200",
        "Ranked Season 6 Champion", "Ranked Season 7 Top 1", "Ranked Season 7 Top 50", "Ranked Season 7 Top 200",
        "Ranked Season 7 Champion", "Ranked Season 8 Top 1", "Ranked Season 8 Top 50", "Ranked Season 8 Top 200",
        "Ranked Season 8 Champion", "Ranked Season 9 Top 1", "Ranked Season 9 Top 50", "Ranked Season 9 Top 200",
        "Ranked Season 9 Champion", "Ranked Season 10 Top 1", "Ranked Season 10 Top 50", "Ranked Season 10 Top 200",
        "Ranked Season 10 Champion", "Ranked Season 11 Top 1", "Ranked Season 11 Top 50", "Ranked Season 11 Top 200",
        "Ranked Season 11 Champion", "Ranked Season 12 Top 1", "Ranked Season 12 Top 50", "Ranked Season 12 Top 200",
        "Ranked Season 12 Champion", "Ranked Season 13 Champion"},
    Default = "Base Sword",
    Callback = function(value)
        swordName = value
        if enabled then
            setSword()
        end
    end
})

Main:Dropdown({
    Title = "选择剑皮肤 [顶级]",
    Values = {"Base Sword", "Avis Scythe", "The Nooblade", "Flowing Katana", "Santa's Wrecker", "Venom Blade",
        "Resolution Blade", "Horizon Reaper", "Plasma Beam Blade", "Allseeing Seer", "Blade of the Damned",
        "Icarus' Scythe", "Mortal's Demise", "Ocean's Fury", "Sandstorm Slasher", "Cybotic Greatsword",
        "Cyber King's", "Soulreaper's Scythe", "Voidstrike Blade", "Winter's Wrath", "Glacial Blade",
        "Turkey Slayer", "Gilded Harvest", "Crystal Reaver", "Arctic King's Blade", "New Years Greatsword",
        "New Years Slicer", "Rose Railgun", "Rose Backsword", "Voidhunter Scythe", "Aethertech Blade",
        "Amethyst Greatsword", "Poison Ivy", "Voided Greatscythe", "Celestial Spear", "Duet of Destruction",
        "Melody of Ruin", "Sci Fi Axe", "Sci Fi Blade", "Eternal Autumn", "Harvest Reaper", "Clans King",
        "Clans Warrior", "Rose Piercer", "Amethyst Slicer", "Chroma Shortaxe", "Opal Staff", "Amethyst Dagger",
        "Amethyst Blade", "Teal Longsword", "Ice Mage Staff"},
    Default = "Base Sword",
    Callback = function(value)
        swordName = value
        if enabled then
            setSword()
        end
    end
})

Main:Dropdown({
    Title = "选择剑皮肤 [限量版]",
    Values = {"Base Sword", "Serpent", "Polar Bear", "Chroma Cards", "Penguin"},
    Default = "Base Sword",
    Callback = function(value)
        swordName = value
        if enabled then
            setSword()
        end
    end
})

local Main = Window:Tab({Title = "透视", Icon = "settings"})
Main:Toggle({
    Title = "透视球状态",
    Value = false,
    Callback = function(value)
        if value then
            local player = Players.LocalPlayer

            statsGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
            statsGui.Name = "BallStatsUI"
            statsGui.ResetOnSpawn = false

            local frame = Instance.new("Frame", statsGui)
            frame.Size = UDim2.new(0, 180, 0, 80)
            frame.Position = UDim2.new(1, -200, 0, 100)
            frame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
            frame.BackgroundTransparency = 0.2
            frame.BorderSizePixel = 0
            frame.Active = true
            frame.Draggable = true

            local label = Instance.new("TextLabel", frame)
            label.Size = UDim2.new(1, -10, 1, -10)
            label.Position = UDim2.new(0, 5, 0, 5)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextYAlignment = Enum.TextYAlignment.Top
            label.Text = "加载中..."

            statsConnection = RunService.RenderStepped:Connect(function()
                local function GetBall()
                    for _, Ball in ipairs(workspace:WaitForChild("Balls"):GetChildren()) do
                        if Ball:GetAttribute("realBall") then
                            return Ball
                        end
                    end
                end

                local ball = GetBall()
                if not ball then
                    label.Text = "未找到球"
                    return
                end

                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                local speed = math.floor(ball.Velocity.Magnitude)
                local distance = math.floor((ball.Position - hrp.Position).Magnitude)
                local target = ball:GetAttribute("target") or "无"
                local status = speed < 3 and "静止" or "飞行中"

                label.Text = string.format(
                    "球状态 | DYHUB\n速度: %s\n距离: %s\n目标: %s",
                    speed, distance, target
                )
            end)
        else
            if statsConnection then
                statsConnection:Disconnect()
                statsConnection = nil
            end
            if statsGui then
                statsGui:Destroy()
                statsGui = nil
            end
        end
    end
})

Main:Toggle({
    Title = "透视球速度",
    Value = false,
    Callback = function(value)
        if value then
            trailConnection = RunService.RenderStepped:Connect(function()
                local function GetBall()
                    for _, Ball in ipairs(workspace:WaitForChild("Balls"):GetChildren()) do
                        if Ball:GetAttribute("realBall") then
                            return Ball
                        end
                    end
                end

                local function CreateRainbowTrail(ball)
                    if ball:FindFirstChild("TriasTrail") then return end

                    local at1 = Instance.new("Attachment", ball)
                    local at2 = Instance.new("Attachment", ball)
                    at1.Position = Vector3.new(0, 0.5, 0)
                    at2.Position = Vector3.new(0, -0.5, 0)

                    local trail = Instance.new("Trail")
                    trail.Name = "TriasTrail"
                    trail.Attachment0 = at1
                    trail.Attachment1 = at2
                    trail.Lifetime = 0.3
                    trail.MinLength = 0.1
                    trail.WidthScale = NumberSequence.new(1)
                    trail.FaceCamera = true
                    trail.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 127, 0)),
                        ColorSequenceKeypoint.new(0.32, Color3.fromRGB(255, 255, 0)),
                        ColorSequenceKeypoint.new(0.48, Color3.fromRGB(0, 255, 0)),
                        ColorSequenceKeypoint.new(0.64, Color3.fromRGB(0, 0, 255)),
                        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(75, 0, 130)),
                        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(148, 0, 211))
                    })

                    trail.Parent = ball
                end

                local ball = GetBall()
                if ball and not ball:FindFirstChild("TriasTrail") then
                    CreateRainbowTrail(ball)
                end
            end)
        else
            if trailConnection then
                trailConnection:Disconnect()
                trailConnection = nil
            end

            for _, Ball in ipairs(workspace:WaitForChild("Balls"):GetChildren()) do
                local trail = Ball:FindFirstChild("TriasTrail")
                if trail then
                    trail:Destroy()
                end
                for _, att in ipairs(Ball:GetChildren()) do
                    if att:IsA("Attachment") then
                        att:Destroy()
                    end
                end
            end
        end
    end
})

Main:Toggle({
    Title = "透视轨迹",
    Value = false,
    Callback = function(value)
        if value then
            trailConnection = RunService.RenderStepped:Connect(function()
                local function GetBall()
                    for _, Ball in ipairs(workspace:WaitForChild("Balls"):GetChildren()) do
                        if Ball:GetAttribute("realBall") then
                            return Ball
                        end
                    end
                end

                local function CreateRainbowTrail(ball)
                    if ball:FindFirstChild("TriasTrail") then return end

                    local at1 = Instance.new("Attachment", ball)
                    local at2 = Instance.new("Attachment", ball)
                    at1.Position = Vector3.new(0, 0.5, 0)
                    at2.Position = Vector3.new(0, -0.5, 0)

                    local trail = Instance.new("Trail")
                    trail.Name = "TriasTrail"
                    trail.Attachment0 = at1
                    trail.Attachment1 = at2
                    trail.Lifetime = 0.3
                    trail.MinLength = 0.1
                    trail.WidthScale = NumberSequence.new(1)
                    trail.FaceCamera = true
                    trail.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 127, 0)),
                        ColorSequenceKeypoint.new(0.32, Color3.fromRGB(255, 255, 0)),
                        ColorSequenceKeypoint.new(0.48, Color3.fromRGB(0, 255, 0)),
                        ColorSequenceKeypoint.new(0.64, Color3.fromRGB(0, 0, 255)),
                        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(75, 0, 130)),
                        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(148, 0, 211))
                    })

                    trail.Parent = ball
                end

                local ball = GetBall()
                if ball and not ball:FindFirstChild("TriasTrail") then
                    CreateRainbowTrail(ball)
                end
            end)
        else
            if trailConnection then
                trailConnection:Disconnect()
                trailConnection = nil
            end

            for _, Ball in ipairs(workspace:WaitForChild("Balls"):GetChildren()) do
                local trail = Ball:FindFirstChild("TriasTrail")
                if trail then
                    trail:Destroy()
                end
                for _, att in ipairs(Ball:GetChildren()) do
                    if att:IsA("Attachment") then
                        att:Destroy()
                    end
                end
            end
        end
    end
})

local Main = Window:Tab({Title = "玩家", Icon = "settings"})

Main:Toggle({
    Title = "速度 (开/关)",
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
    Desc = "滑动调整",
    Value = {
        Min = 1,
        Max = 150,
        Default = 1,
    },
    Callback = function(Value)
        Speed = Value
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