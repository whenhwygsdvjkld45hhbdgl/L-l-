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
    Title = "枪战竞技场",
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
    -- 标签页标题
    ["暴力功能"] = "Rage Functions",
    ["视觉功能"] = "Visuals",
    ["修改功能"] = "Exploits", 
    ["武器设置"] = "Weapon Settings",
    ["设置"] = "Settings",
    ["语言设置"] = "Language Settings",
    
    -- 静默瞄准部分
    ["静默瞄准"] = "Silent Aim",
    ["静默瞄准 + 半穿墙"] = "Silent Aim + Wallbang",
    ["暴力模式"] = "Rage Mode",
    ["FOV设置"] = "FOV Settings",
    ["显示FOV圆圈"] = "Show FOV Circle",
    ["FOV半径"] = "FOV Radius",
    ["设置瞄准范围半径"] = "Set aiming range radius",
    ["瞄准部位"] = "Aim Part",
    ["头部"] = "Head",
    ["躯干"] = "Torso", 
    ["身体根部"] = "Humanoid Root Part",
    ["命中几率 (%)"] = "Hit Chance (%)",
    ["设置瞄准命中几率"] = "Set aiming hit chance",
    
    -- ESP设置部分
    ["ESP设置"] = "ESP Settings",
    ["方框ESP"] = "Box ESP",
    ["名称ESP"] = "Name ESP",
    ["距离ESP"] = "Distance ESP",
    ["骨骼ESP"] = "Skeleton ESP",
    ["生命值ESP"] = "Health ESP",
    ["追踪线ESP"] = "Tracer ESP",
    ["透视材质"] = "Chams",
    ["队伍检查"] = "Team Check",
    ["追踪线起点"] = "Tracer Origin",
    ["屏幕底部"] = "Bottom Screen",
    ["鼠标位置"] = "Cursor",
    ["屏幕顶部"] = "Top Screen",
    
    -- 作弊功能部分
    ["战斗作弊"] = "Combat Cheats",
    ["无后坐力"] = "No Recoil",
    ["无限弹药"] = "Infinite Ammo",
    ["移除敌方力场"] = "Remove Enemy Forcefields",
    ["移除力场"] = "Remove Forcefields",
    ["重新生成角色"] = "Respawn Character",
    ["重新生成"] = "Respawn",
    ["角色正在重新生成"] = "Character is respawning",
    
    -- 武器设置部分
    ["主武器"] = "Primary Weapon",
    ["选择主武器"] = "Select Primary Weapon",
    ["选择主武器迷彩"] = "Select Primary Camo",
    ["应用主武器"] = "Apply Primary Weapon",
    ["武器设置"] = "Weapon Settings",
    ["已应用主武器"] = "Applied primary weapon",
    ["应用主武器迷彩"] = "Apply Primary Camo",
    ["迷彩设置"] = "Camo Settings",
    ["已应用主武器迷彩"] = "Applied primary weapon camo",
    ["副武器"] = "Secondary Weapon",
    ["选择副武器"] = "Select Secondary Weapon",
    ["选择副武器迷彩"] = "Select Secondary Camo",
    ["应用副武器"] = "Apply Secondary Weapon",
    ["已应用副武器"] = "Applied secondary weapon",
    ["应用副武器迷彩"] = "Apply Secondary Camo",
    ["已应用副武器迷彩"] = "Applied secondary weapon camo",
    
    -- 通知消息
    ["已开启静默瞄准"] = "Silent Aim enabled",
    ["已关闭静默瞄准"] = "Silent Aim disabled",
    ["已开启暴力模式"] = "Rage Mode enabled", 
    ["已关闭暴力模式"] = "Rage Mode disabled",
    ["已开启方框ESP"] = "Box ESP enabled",
    ["已关闭方框ESP"] = "Box ESP disabled",
    ["已开启名称ESP"] = "Name ESP enabled",
    ["已关闭名称ESP"] = "Name ESP disabled",
    ["已开启距离ESP"] = "Distance ESP enabled",
    ["已关闭距离ESP"] = "Distance ESP disabled",
    ["已开启骨骼ESP"] = "Skeleton ESP enabled",
    ["已关闭骨骼ESP"] = "Skeleton ESP disabled",
    ["已开启生命值ESP"] = "Health ESP enabled",
    ["已关闭生命值ESP"] = "Health ESP disabled",
    ["已开启追踪线ESP"] = "Tracer ESP enabled",
    ["已关闭追踪线ESP"] = "Tracer ESP disabled",
    ["已开启透视材质"] = "Chams enabled",
    ["已关闭透视材质"] = "Chams disabled",
    ["已开启队伍检查"] = "Team Check enabled",
    ["已关闭队伍检查"] = "Team Check disabled",
    ["已开启无后坐力"] = "No Recoil enabled",
    ["已关闭无后坐力"] = "No Recoil disabled",
    ["已开启无限弹药"] = "Infinite Ammo enabled",
    ["已关闭无限弹药"] = "Infinite Ammo disabled",
    ["已开启移除力场"] = "Remove Forcefields enabled",
    ["已关闭移除力场"] = "Remove Forcefields disabled",
    
    -- 语言设置
    ["当前语言"] = "Current Language",
    ["中文"] = "Chinese", 
    ["英文"] = "English",
    ["应用语言"] = "Apply Language",
    ["语言更改"] = "Language Change",
    ["成功"] = "Success",
    ["语言"] = "Language",
    ["当前语言已经是"] = "Current language is already",
    ["成功"] = "ok"
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
    
        local players = game:GetService("Players")
local player = players.LocalPlayer
local rs = game:GetService("RunService")
local camera = workspace.CurrentCamera
local replicated = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService('UserInputService')
local RageTab = Window:Tab({Title = "暴力功能", Icon = "crosshair"})
local VisualsTab = Window:Tab({Title = "视觉功能", Icon = "eye"})
local ExploitsTab = Window:Tab({Title = "修改功能", Icon = "zap"})
local WeaponsTab = Window:Tab({Title = "武器设置", Icon = "gun"})
local SettingsTab = Window:Tab({Title = "设置", Icon = "settings"})
local silentaim = false
local noforcefields = false
local norecoil = false
local infiniteammo = false
local fovcircle = false
local fovradius = 100
local hitchance = 100
local hitpart = "Head"
local aimbotEnabled = false
local aimbotFOVEnabled = false
local aimbot360FOV = false
local aimbotSmoothing = 0
local predictionEnabled = false
local triggerbotEnabled = false
local isTriggerbotShooting = false
local espCustomEnabled = false
local nameESPEnabled = false
local distanceESPEnabled = false
local skeletonESPEnabled = false
local healthESPEnabled = false
local tracerESPEnabled = false
local chamsEnabled = false
local espDistance = 325
local aimbotFOVRadius = 100
local fovColor = Color3.fromRGB(255, 255, 255)
local skeletonESPColor = Color3.new(0.403922, 0.349020, 0.701961)
local tracerOrigin = 'Bottom Screen'
local chamsColor = Color3.new(1, 0, 0)
local ragebotEnabled = false
local isRagebotShooting = false
local teamCheck = true
local projectileSpeed = 1000
local weapons, camos = {}, {}
for _, v in pairs(replicated.Weapons:GetChildren()) do table.insert(weapons, v.Name) end
for _, v in pairs(replicated.Camos:GetChildren()) do table.insert(camos, v.Name) end
local primary, secondary, primarycamo, secondarycamo
primary = weapons[1] or ""
secondary = weapons[1] or ""
primarycamo = camos[1] or ""
secondarycamo = camos[1] or ""
local vortex = player:WaitForChild("PlayerScripts"):WaitForChild("Vortex")
local s = vortex.Modifiers:FindFirstChild("Steadiness")
local m = vortex.Modifiers:FindFirstChild("Mobility")

local function removeRecoil()
    if norecoil then
        if s and s.Value > 0 then s.Value = 0 end
        if m and m.Value > 0 then m.Value = 0 end
    end
end
if s then s.Changed:Connect(removeRecoil) end
if m then m.Changed:Connect(removeRecoil) end
local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, prop)
    if infiniteammo and tostring(self) == "StoredAmmo" and prop == "Value" then
        return math.huge
    end
    return oldIndex(self, prop)
end)

rs.RenderStepped:Connect(function()
    if infiniteammo and vortex.Enabled then
        local restock = getsenv(vortex).Restock
        if restock then restock() end
    end
end)
rs.RenderStepped:Connect(function()
    if noforcefields then
        for _, v in pairs(workspace.Env:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("FullSphere") and v.Name:find("Forcefield") then
                if v.FullSphere.Color ~= Color3.fromRGB(0, 102, 255) then
                    v:Destroy()
                end
            end
        end
    end
end)
local Drawing = Drawing
local vector2 = Vector2.new
local c_workspace = game:GetService("Workspace")
local fovCircle = Drawing.new("Circle")
fovCircle.Radius = fovradius
fovCircle.Visible = false
fovCircle.Color = fovColor
fovCircle.Thickness = 2
fovCircle.Transparency = 1
fovCircle.Filled = false
fovCircle.Position = UserInputService:GetMouseLocation()

local aimbotFOVCircle = Drawing.new("Circle")
aimbotFOVCircle.Radius = aimbotFOVRadius
aimbotFOVCircle.Visible = false
aimbotFOVCircle.Color = fovColor
aimbotFOVCircle.Thickness = 2
aimbotFOVCircle.Transparency = 1
aimbotFOVCircle.Filled = false
aimbotFOVCircle.Position = UserInputService:GetMouseLocation()
local espCache = {}
local skeletonCache = {}
local healthCache = {}
local tracerCache = {}
local chamsCache = {}
local function isPlayerVisible(target)
    if not target or not target:FindFirstChild(hitpart) then return false end
    local origin = camera.CFrame.Position
    local targetPos = target[hitpart].Position
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {player.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local raycastResult = workspace:Raycast(origin, targetPos - origin, raycastParams)
    return not raycastResult or raycastResult.Instance:IsDescendantOf(target)
end

local function predictPosition(target)
    if not predictionEnabled or not target or not target:FindFirstChild(hitpart) or not target:FindFirstChild("HumanoidRootPart") then
        return target and target[hitpart].Position
    end
    local velocity = target.HumanoidRootPart.Velocity
    local distance = (player.Character.HumanoidRootPart.Position - target[hitpart].Position).Magnitude
    local travel_time = distance / projectileSpeed
    return target[hitpart].Position + (velocity * travel_time)
end

local function getClosestPlayer()
    local closest, distance = nil, fovradius
    for _, character in c_workspace:GetChildren() do
        if character and character:FindFirstChild("Head") then
            local actualPlayer = players:GetPlayerFromCharacter(character) or character
            if actualPlayer == player then continue end
            if not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Humanoid") then continue end
            local humanoid = character.Humanoid
            if humanoid.Health <= 0 then continue end
            local team_attribute = actualPlayer:GetAttribute("Team")
            if teamCheck and team_attribute and team_attribute == player:GetAttribute("Team") then continue end
            local w2s, onscreen = camera:WorldToViewportPoint(character.Head.Position)
            if onscreen then
                local dist = (vector2(w2s.X, w2s.Y) - (camera.ViewportSize / 2)).Magnitude
                if dist < distance and dist <= fovradius then
                    closest = character
                    distance = dist
                end
            end
        end
    end
    return closest
end
local closest_player = nil
rs.RenderStepped:Connect(function()
    fovCircle.Position = camera.ViewportSize / 2
    fovCircle.Radius = fovradius
    fovCircle.Visible = fovcircle

    aimbotFOVCircle.Position = camera.ViewportSize / 2
    aimbotFOVCircle.Radius = aimbotFOVRadius
    aimbotFOVCircle.Visible = aimbotFOVEnabled and not aimbot360FOV

    if silentaim then
        closest_player = getClosestPlayer()
    else
        closest_player = nil
    end
end)

RageTab:Section({Title = "静默瞄准"})

RageTab:Toggle({
    Title = "静默瞄准 + 半穿墙",
    Default = false,
    Callback = function(state)
        silentaim = state
        WindUI:Notify({
            Title = "静默瞄准",
            Content = state and "已开启静默瞄准" or "已关闭静默瞄准",
            Duration = 4
        })
    end
})

RageTab:Toggle({
    Title = "暴力模式",
    Default = false,
    Callback = function(state)
        ragebotEnabled = state
        if not ragebotEnabled and isRagebotShooting then
            mouse1release()
            isRagebotShooting = false
        end
        WindUI:Notify({
            Title = "暴力模式",
            Content = state and "已开启暴力模式" or "已关闭暴力模式",
            Duration = 4
        })
    end
})

RageTab:Section({Title = "FOV设置"})

RageTab:Toggle({
    Title = "显示FOV圆圈",
    Default = false,
    Callback = function(state)
        fovcircle = state
    end
})

RageTab:Slider({
    Title = "FOV半径",
    Desc = "设置瞄准范围半径",
    Value = {
        Min = 10,
        Max = 1000,
        Default = 100,
    },
    Callback = function(value)
        fovradius = value
    end
})

RageTab:Dropdown({
    Title = "瞄准部位",
    Values = {"头部", "躯干", "身体根部"},
    Callback = function(value)
        if value == "头部" then
            hitpart = "Head"
        elseif value == "躯干" then
            hitpart = "Torso"
        elseif value == "身体根部" then
            hitpart = "HumanoidRootPart"
        end
    end
})

RageTab:Slider({
    Title = "命中几率 (%)",
    Desc = "设置瞄准命中几率",
    Value = {
        Min = 0,
        Max = 100,
        Default = 100,
    },
    Callback = function(value)
        hitchance = value
    end
})
VisualsTab:Section({Title = "ESP设置"})

VisualsTab:Toggle({
    Title = "方框ESP",
    Default = false,
    Callback = function(state)
        espCustomEnabled = state
        if not espCustomEnabled then
            for character, esp in pairs(espCache) do
                esp.Box.Visible = false
            end
        end
        WindUI:Notify({
            Title = "方框ESP",
            Content = state and "已开启方框ESP" or "已关闭方框ESP",
            Duration = 4
        })
    end
})

VisualsTab:Toggle({
    Title = "名称ESP",
    Default = false,
    Callback = function(state)
        nameESPEnabled = state
        if not nameESPEnabled then
            for character, esp in pairs(espCache) do
                esp.Name.Visible = false
            end
        end
        WindUI:Notify({
            Title = "名称ESP",
            Content = state and "已开启名称ESP" or "已关闭名称ESP",
            Duration = 4
        })
    end
})

VisualsTab:Toggle({
    Title = "距离ESP",
    Default = false,
    Callback = function(state)
        distanceESPEnabled = state
        if not distanceESPEnabled then
            for character, esp in pairs(espCache) do
                esp.Distance.Visible = false
            end
        end
        WindUI:Notify({
            Title = "距离ESP",
            Content = state and "已开启距离ESP" or "已关闭距离ESP",
            Duration = 4
        })
    end
})

VisualsTab:Toggle({
    Title = "骨骼ESP",
    Default = false,
    Callback = function(state)
        skeletonESPEnabled = state
        if not skeletonESPEnabled then
            for character, _ in pairs(skeletonCache) do
                clearSkeleton(character)
            end
        end
        WindUI:Notify({
            Title = "骨骼ESP",
            Content = state and "已开启骨骼ESP" or "已关闭骨骼ESP",
            Duration = 4
        })
    end
})

VisualsTab:Toggle({
    Title = "生命值ESP",
    Default = false,
    Callback = function(state)
        healthESPEnabled = state
        if not healthESPEnabled then
            for character, _ in pairs(healthCache) do
                clearHealthESP(character)
            end
        end
        WindUI:Notify({
            Title = "生命值ESP",
            Content = state and "已开启生命值ESP" or "已关闭生命值ESP",
            Duration = 4
        })
    end
})

VisualsTab:Toggle({
    Title = "追踪线ESP",
    Default = false,
    Callback = function(state)
        tracerESPEnabled = state
        if not tracerESPEnabled then
            for character, _ in pairs(tracerCache) do
                clearTracer(character)
            end
        end
        WindUI:Notify({
            Title = "追踪线ESP",
            Content = state and "已开启追踪线ESP" or "已关闭追踪线ESP",
            Duration = 4
        })
    end
})

VisualsTab:Toggle({
    Title = "透视材质",
    Default = false,
    Callback = function(state)
        chamsEnabled = state
        if not chamsEnabled then
            for character, _ in pairs(chamsCache) do
                clearChams(character)
            end
        end
        WindUI:Notify({
            Title = "透视材质",
            Content = state and "已开启透视材质" or "已关闭透视材质",
            Duration = 4
        })
    end
})

VisualsTab:Toggle({
    Title = "队伍检查",
    Default = true,
    Callback = function(state)
        teamCheck = state
        WindUI:Notify({
            Title = "队伍检查",
            Content = state and "已开启队伍检查" or "已关闭队伍检查",
            Duration = 4
        })
    end
})

VisualsTab:Dropdown({
    Title = "追踪线起点",
    Values = {"屏幕底部", "鼠标位置", "屏幕顶部"},
    Callback = function(value)
        if value == "屏幕底部" then
            tracerOrigin = 'Bottom Screen'
        elseif value == "鼠标位置" then
            tracerOrigin = 'Cursor'
        elseif value == "屏幕顶部" then
            tracerOrigin = 'Top Screen'
        end
    end
})

-- 作弊功能标签页
ExploitsTab:Section({Title = "战斗作弊"})

ExploitsTab:Toggle({
    Title = "无后坐力",
    Default = false,
    Callback = function(state)
        norecoil = state
        removeRecoil()
        WindUI:Notify({
            Title = "无后坐力",
            Content = state and "已开启无后坐力" or "已关闭无后坐力",
            Duration = 4
        })
    end
})

ExploitsTab:Toggle({
    Title = "无限弹药",
    Default = false,
    Callback = function(state)
        infiniteammo = state
        WindUI:Notify({
            Title = "无限弹药",
            Content = state and "已开启无限弹药" or "已关闭无限弹药",
            Duration = 4
        })
    end
})

ExploitsTab:Toggle({
    Title = "移除敌方力场",
    Default = false,
    Callback = function(state)
        noforcefields = state
        WindUI:Notify({
            Title = "移除力场",
            Content = state and "已开启移除力场" or "已关闭移除力场",
            Duration = 4
        })
    end
})

ExploitsTab:Button({
    Title = "重新生成角色",
    Callback = function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
            WindUI:Notify({
                Title = "重新生成",
                Content = "角色正在重新生成",
                Duration = 4
            })
        end
    end
})

-- 武器设置标签页
WeaponsTab:Section({Title = "主武器"})

WeaponsTab:Dropdown({
    Title = "选择主武器",
    Values = weapons,
    Callback = function(value)
        primary = value
    end
})

WeaponsTab:Dropdown({
    Title = "选择主武器迷彩",
    Values = camos,
    Callback = function(value)
        primarycamo = value
    end
})

WeaponsTab:Button({
    Title = "应用主武器",
    Callback = function()
        player:SetAttribute("Primary", primary)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        end
        WindUI:Notify({
            Title = "武器设置",
            Content = "已应用主武器: " .. primary,
            Duration = 4
        })
    end
})

WeaponsTab:Button({
    Title = "应用主武器迷彩",
    Callback = function()
        player:SetAttribute("PrimaryCamo", primarycamo)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        end
        WindUI:Notify({
            Title = "迷彩设置",
            Content = "已应用主武器迷彩: " .. primarycamo,
            Duration = 4
        })
    end
})

WeaponsTab:Section({Title = "副武器"})

WeaponsTab:Dropdown({
    Title = "选择副武器",
    Values = weapons,
    Callback = function(value)
        secondary = value
    end
})

WeaponsTab:Dropdown({
    Title = "选择副武器迷彩",
    Values = camos,
    Callback = function(value)
        secondarycamo = value
    end
})

WeaponsTab:Button({
    Title = "应用副武器",
    Callback = function()
        player:SetAttribute("Secondary", secondary)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        end
        WindUI:Notify({
            Title = "武器设置",
            Content = "已应用副武器: " .. secondary,
            Duration = 4
        })
    end
})

WeaponsTab:Button({
    Title = "应用副武器迷彩",
    Callback = function()
        player:SetAttribute("SecondaryCamo", secondarycamo)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        end
        WindUI:Notify({
            Title = "迷彩设置",
            Content = "已应用副武器迷彩: " .. secondarycamo,
            Duration = 4
        })
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