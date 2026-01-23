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
    Title = "忍者传奇",
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
    -- Window and UI elements
    ["大司马脚本"] = "大司马脚本",
    ["尊贵的"] = "Respected ",
    ["欢迎使用大司马脚本"] = "Welcome to 大司马脚本",
    ["忍者传奇"] = "Ninja Legend",
    ["主要"] = "Main",
    ["复制宠物"] = "Duplicate Pets",
    ["破解通行证"] = "Unlock Gamepasses",
    ["信息"] = "Information",
    ["自动刷boss"] = "Auto Farm Bosses",
    ["修改金币"] = "Edit Currency",
    ["人物"] = "Character",
    ["抽奖"] = "Gacha",
    
    -- Main Features
    ["自动挥刀"] = "Auto Swing",
    ["自动售卖"] = "Auto Sell",
    ["自动重生职位"] = "Auto Rebirth Ranks",
    ["自动购买称号"] = "Auto Buy Titles",
    ["自动购买刀"] = "Auto Buy Swords",
    ["自动把圈传送过来"] = "Teleport Hoops",
    ["自动吸气"] = "Auto Collect Chi",
    ["获取所有元素[永久]"] = "Get All Elements [Permanent]",
    ["自动收集元素"] = "Auto Collect Elements",
    
    -- Duplicate Pets
    ["宠物名字"] = "Pet Name",
    ["例如: Red Dragon"] = "e.g.: Red Dragon",
    ["复制次数"] = "Duplicate Count",
    ["写"] = "Enter",
    ["例如: 5"] = "e.g.: 5",
    ["复制宠物"] = "Duplicate Pet",
    ["pet6666"] = "pet6666",
    
    -- Unlock Gamepasses
    ["解锁+2宠物栏位通行证"] = "Unlock +2 Pet Slots",
    ["解锁+3宠物栏位通行证"] = "Unlock +3 Pet Slots",
    ["解锁+4宠物栏位通行证"] = "Unlock +4 Pet Slots",
    ["解锁+100容量通行证"] = "Unlock +100 Capacity",
    ["解锁+200容量通行证"] = "Unlock +200 Capacity",
    ["解锁+20容量通行证"] = "Unlock +20 Capacity",
    ["解锁+60容量通行证"] = "Unlock +60 Capacity",
    ["解锁无限弹药通行证"] = "Unlock Infinite Ammo",
    ["解锁无限忍术通行证"] = "Unlock Infinite Ninjitsu",
    ["解锁永久岛屿通行证"] = "Unlock Permanent Islands",
    ["解锁双倍金币通行证"] = "Unlock x2 Coins",
    ["解锁双倍伤害通行证"] = "Unlock x2 Damage",
    ["解锁双倍生命值通行证"] = "Unlock x2 Health",
    ["解锁双倍忍术通行证"] = "Unlock x2 Ninjitsu",
    ["解锁双倍速度通行证"] = "Unlock x2 Speed",
    ["解锁更快剑速通行证"] = "Unlock Faster Sword",
    ["解锁3个宠物克隆通行证"] = "Unlock x3 Pet Clones",
    
    -- Information
    ["忍术: "] = "Ninjitsu: ",
    ["杀戮: "] = "Kills: ",
    ["阶级: "] = "Rank: ",
    ["条纹: "] = "Streak: ",
    ["气: "] = "Chi: ",
    ["硬币: "] = "Coins: ",
    ["决斗: "] = "Duels: ",
    ["宝石: "] = "Gems: ",
    ["灵魂: "] = "Souls: ",
    ["业报: "] = "Karma: ",
    
    -- Auto Farm Bosses
    ["普通Boss"] = "Normal Boss",
    ["永恒Boss"] = "Eternal Boss",
    ["岩浆Boss"] = "Magma Boss",
    
    -- Edit Currency
    ["初始化第一步"] = "Initialize Step 1",
    ["初始化第二步"] = "Initialize Step 2",
    ["输入数字上传数据"] = "Enter Number to Upload",
    ["请输入数字"] = "Please enter a number",
    ["循环上传"] = "Loop Upload",
    ["恢复金币"] = "Reset Currency",
    
    -- Character
    ["修改连跳上限"] = "Change Multi-Jump Limit",
    ["输入连跳次数"] = "Enter Jump Count",
    ["解锁所有岛屿"] = "Unlock All Islands",
    
    -- Gacha
    ["选择抽奖机"] = "Select Gacha Machine",
    ["自动购买"] = "Auto Buy",
    
    -- Language Settings
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

local AutoSettings = {
    AutoSwing = false,
    AutoSell = false,
    AutoR = false,
    AutoS = false,
    AutoB = false,
    AutoC = false,
    AutoE = false,
    AutoCr = false,
    AutoTa = false,
    AutoBo = false,
    AutoBo1 = false,
    AutoBo2 = false
}

for k, v in pairs(AutoSettings) do
    getgenv()[k] = v
end

local function teleportTo(placeCFrame)
    local plyr = game.Players.LocalPlayer
    if plyr.Character then
        plyr.Character.HumanoidRootPart.CFrame = placeCFrame
    end
end

Main:Toggle({
    Title = "自动挥刀",
    Default = false,
    Callback = function(state)
        getgenv().AutoSwing = state
        
        if state then
            spawn(function()
                while AutoSwing == true do
                    if not getgenv() then break end
                    local args = {[1] = "swingKatana"}
                    game.Players.LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))    
                    wait()
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "自动售卖",
    Default = false,
    Callback = function(state)
        getgenv().AutoSell = state
        
        if state then
            spawn(function()
                while AutoSell == true do
                    if not getgenv() then break end
                    local playerHead = game.Players.LocalPlayer.Character.Head
                    for _, v in pairs(game:GetService("Workspace").sellAreaCircles.sellAreaCircle16.circleInner:GetDescendants()) do
                        if v.Name == "TouchInterest" and v.Parent then
                            firetouchinterest(playerHead, v.Parent, 0)
                            wait(0.1)
                            firetouchinterest(playerHead, v.Parent, 1)
                            break
                        end
                    end
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "自动重生职位",
    Default = false,
    Callback = function(state)
        getgenv().AutoR = state
        
        if state then
            spawn(function()
                while AutoR == true do
                    if not getgenv() then break end
                    local ranks = {
                        "Grasshopper", "Apprentice", "Samurai", "Assassin", "Shadow",
                        "Ninja", "Master Ninja", "Sensei", "Master Sensei", "Ninja Legend",
                        "Master Of Shadows", "Immortal Assassin", "Eternity Hunter", "Shadow Legend", "Dragon Warrior",
                        "Dragon Master", "Chaos Sensei", "Chaos Legend", "Master Of Elements", "Elemental Legend",
                        "Ancient Battle Master", "Ancient Battle Legend", "Legendary Shadow Duelist", "Master Legend Assassin", "Mythic Shadowmaster",
                        "Legendary Shadowmaster", "Awakened Scythemaster", "Awakened Scythe Legend", "Master Legend Zephyr", "Golden Sun Shuriken Master",
                        "Golden Sun Shuriken Legend", "Dark Sun Samurai Legend", "Dragon Evolution Form I", "Dragon Evolution Form II", "Dragon Evolution Form III",
                        "Dragon Evolution Form IV", "Dragon Evolution Form V", "Cybernetic Electro Master", "Cybernetic Electro Legend", "Shadow Chaos Assassin",
                        "Shadow Chaos Legend", "Infinity Sensei", "Infinity Legend", "Aether Genesis Master Ninja", "Master Legend Sensei Hunter",
                        "Skystorm Series Samurai Legend", "Master Elemental Hero", "Eclipse Series Soul Master", "Starstrike Master Sensei", "Evolved Series Master Ninja",
                        "Dark Elements Guardian", "Elite Series Master Legend", "Infinity Shadows Master", "Lighting Storm Sensei",
                        "Dark Elements Blademaster", "Rising Shadow Eternal Ninja", "Skyblade Ninja Master", "Shadow Storm Sensei", "Comet Strike Lion",
                        "Cybernetic Azure Sensei", "Ultra Genesis Shadow"
                    }
                    
                    for i = 1, #ranks, 5 do
                        for j = i, math.min(i+4, #ranks) do
                            local args = {[1] = "buyRank", [2] = ranks[j]}
                            game.Players.LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))
                        end
                        wait()
                    end
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "自动购买称号",
    Default = false,
    Callback = function(state)
        getgenv().AutoB = state
        
        if state then
            spawn(function()
                while AutoB == true do
                    if not getgenv() then break end
                    local args = {[1] = "buyAllBelts", [2] = "Blazing Vortex Island"}
                    game.Players.LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))        
                    wait(0.5)
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "自动购买刀",
    Default = false,
    Callback = function(state)
        getgenv().AutoS = state
        
        if state then
            spawn(function()
                while AutoS == true do
                    if not getgenv() then break end
                    local args = {[1] = "buyAllSwords", [2] = "Blazing Vortex Island"}
                    game.Players.LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))        
                    wait(0.5)
                end
            end)
        end
    end
})

local isRunning = false
Main:Toggle({
    Title = "自动把圈传送过来",
    Default = false,
    Callback = function(state)
        if state and not isRunning then
            isRunning = true
            spawn(function()
                while isRunning do
                    local playerCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    local children = workspace.Hoops:GetChildren()
                    for i, child in ipairs(children) do
                        if child.Name == "Hoop" then
                            child.CFrame = playerCFrame
                        end
                    end
                    wait()
                end
            end)
        else
            isRunning = false
        end
    end
})

Main:Toggle({
    Title = "自动吸气",
    Default = false,
    Callback = function(state)
        getgenv().AutoC = state
        
        if state then
            spawn(function()
                while AutoC == true do
                    if not getgenv() then break end
                    local coinLocations = {
                        game:GetService("Workspace").spawnedCoins.Valley["Pink Chi Crate"].CFrame,
                        game:GetService("Workspace").spawnedCoins.Valley["Blue Chi Crate"].CFrame,
                        game:GetService("Workspace").spawnedCoins.Valley["Chi Crate"].CFrame
                    }
                    
                    for _, location in ipairs(coinLocations) do
                        teleportTo(location)
                        wait(0.1)
                    end
                    wait()
                end
            end)
        end
    end
})

Main:Button({
    Title = "获取所有元素[永久]",
    Callback = function()
        for i, v in pairs(game:GetService("ReplicatedStorage").Elements:GetChildren()) do
            local allelement = v.Name
            game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer(allelement)
        end
    end
})


Main:Toggle({
    Title = "自动收集元素",
    Default = false,
    Callback = function(state)
        getgenv().AutoE = state
        
        if state then
            spawn(function()
                while AutoE == true do
                    if not getgenv() then break end
                    local elements = {
                        "Inferno", "大司马脚本", "Lightning", "Electral Chaos",
                        "Shadow Charge", "Masterful Wrath", "Shadowfire",
                        "Eternity Storm", "Blazing Entity"
                    }
                    
                    for _, element in ipairs(elements) do
                        local args = {[1] = element}
                        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("elementMasteryEvent"):FireServer(unpack(args))
                        wait()
                    end
                end
            end)
        end
    end
})

local Main = Window:Tab({Title = "复制宠物", Icon = "settings"})
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local petsFolder = player.petsFolder
local rarePets = petsFolder.Rare
local petNameInput = ""
local copyCount = 1
Main:Input({
    Title = "宠物名字",
    Desc = "宠物名",
    Value = "",
    Placeholder = "例如: Red Dragon",
    Color = Color3.fromRGB(0, 170, 255),
    Callback = function(input)
        petNameInput = input
    end
})

Main:Input({
    Title = "复制次数",
    Desc = "写",
    Value = "1",
    Placeholder = "例如: 5",
    Color = Color3.fromRGB(0, 170, 255),
    Callback = function(input)
        copyCount = tonumber(input) or 1
    end
})

Main:Button({
    Title = "复制宠物",
    Desc = "pet6666",
    Color = Color3.fromRGB(0, 170, 255),
    Callback = function()
        if petNameInput and petNameInput ~= "" then
            local targetPet = rarePets[petNameInput]
            if targetPet then
                for i = 1, copyCount do
                    local petClone = targetPet:Clone()
                    petClone.Parent = rarePets
                    petClone.Name = petNameInput .. " (Copy " .. i .. ")"
                    task.wait(0.1)
                end
            else
           
            end
        else
        end
    end
})

local Main = Window:Tab({Title = "破解通行证", Icon = "settings"})
Main:Button({
    Title = "解锁+2宠物栏位通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["+2 Pet Slots"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁+3宠物栏位通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["+3 Pet Slots"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁+4宠物栏位通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["+4 Pet Slots"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁+100容量通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["+100 Capacity"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁+200容量通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["+200 Capacity"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁+20容量通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["+20 Capacity"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁+60容量通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["+60 Capacity"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁无限弹药通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["Infinite Ammo"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁无限忍术通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["Infinite Ninjitsu"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁永久岛屿通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["Permanent Islands Unlock"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁双倍金币通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["x2 Coins"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁双倍伤害通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["x2 Damage"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁双倍生命值通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["x2 Health"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁双倍忍术通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["x2 Ninjitsu"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁双倍速度通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["x2 Speed"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})
Main:Button({
    Title = "解锁更快剑速通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["Faster Sword"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

Main:Button({
    Title = "解锁3个宠物克隆通行证",
    Callback = function()
        game:GetService("ReplicatedStorage").gamepassIds["x3 Pet Clones"].Parent = game.Players.LocalPlayer.ownedGamepasses
    end
})

local Main = Window:Tab({Title = "信息", Icon = "settings"})

Main:Paragraph({
    Title = "忍术: " .. game:GetService("Players").LocalPlayer.leaderstats.Ninjitsu.Value,
    Callback = function(Value)
        return "忍术: " .. game:GetService("Players").LocalPlayer.leaderstats.Ninjitsu.Value
    end
})

Main:Paragraph({
    Title = "杀戮: " .. game:GetService("Players").LocalPlayer.leaderstats.Kills.Value,
    Callback = function(Value)
        return "杀戮: " .. game:GetService("Players").LocalPlayer.leaderstats.Kills.Value
    end
})

Main:Paragraph({
    Title = "阶级: " .. game:GetService("Players").LocalPlayer.leaderstats.Rank.Value,
    Callback = function(Value)
        return "阶级: " .. game:GetService("Players").LocalPlayer.leaderstats.Rank.Value
    end
})

Main:Paragraph({
    Title = "条纹: " .. game:GetService("Players").LocalPlayer.leaderstats.Streak.Value,
    Callback = function(Value)
        return "条纹: " .. game:GetService("Players").LocalPlayer.leaderstats.Streak.Value
    end
})

Main:Paragraph({
    Title = "气: " .. game:GetService("Players").LocalPlayer.Chi.Value,
    Callback = function(Value)
        return "气: " .. game:GetService("Players").LocalPlayer.Chi.Value
    end
})

Main:Paragraph({
    Title = "硬币: " .. game:GetService("Players").LocalPlayer.Coins.Value,
    Callback = function(Value)
        return "硬币: " .. game:GetService("Players").LocalPlayer.Coins.Value
    end
})

Main:Paragraph({
    Title = "决斗: " .. game:GetService("Players").LocalPlayer.Duels.Value,
    Callback = function(Value)
        return "决斗: " .. game:GetService("Players").LocalPlayer.Duels.Value
    end
})

Main:Paragraph({
    Title = "宝石: " .. game:GetService("Players").LocalPlayer.Gems.Value,
    Callback = function(Value)
        return "宝石: " .. game:GetService("Players").LocalPlayer.Gems.Value
    end
})

Main:Paragraph({
    Title = "灵魂: " .. game:GetService("Players").LocalPlayer.Souls.Value,
    Callback = function(Value)
        return "灵魂: " .. game:GetService("Players").LocalPlayer.Souls.Value
    end
})

Main:Paragraph({
    Title = "业报: " .. game:GetService("Players").LocalPlayer.Karma.Value,
    Callback = function(Value)
        return "业报: " .. game:GetService("Players").LocalPlayer.Karma.Value
    end
})

local Main = Window:Tab({Title = "自动刷boss", Icon = "settings"})

Main:Toggle({
    Title = "普通Boss",
    Default = false,
    Callback = function(state)
        getgenv().AutoBo = state
        
        if state then
            spawn(function()
                while AutoBo == true do
                    if not getgenv() then break end
                    teleportTo(game:GetService("Workspace").bossFolder.RobotBoss.UpperTorso.CFrame)
                    local args = {[1] = "swingKatana"}
                    game.Players.LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))
                    wait()
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "永恒Boss",
    Default = false,
    Callback = function(state)
        getgenv().AutoBo1 = state
        
        if state then
            spawn(function()
                while AutoBo1 == true do
                    if not getgenv() then break end
                    teleportTo(game:GetService("Workspace").bossFolder.EternalBoss.UpperTorso.CFrame)
                    local args = {[1] = "swingKatana"}
                    game.Players.LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))
                    wait()
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "岩浆Boss",
    Default = false,
    Callback = function(state)
        getgenv().AutoBo2 = state
        
        if state then
            spawn(function()
                while AutoBo2 == true do
                    if not getgenv() then break end
                    teleportTo(game:GetService("Workspace").bossFolder.AncientMagmaBoss.UpperTorso.CFrame)
                    local args = {[1] = "swingKatana"}
                    game.Players.LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))
                    wait()
                end
            end)
        end
    end
})

local Main = Window:Tab({Title = "修改金币", Icon = "settings"})

Main:Button({
    Title = "初始化第一步",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("zenMasterEvent"):FireServer("convertGems", -9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)
    end
})

Main:Button({
    Title = "初始化第二步",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("elementMasteryEvent"):FireServer("Shadow Charge")
    end
})

local isLooping = false
local lastInputValue = 0

Main:Input({
    Title = "输入数字上传数据",
    Value = "",
    Placeholder = "请输入数字",
    Callback = function(I)
        local num = tonumber(I)
        if num and num > 0 then
            lastInputValue = num
            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("zenMasterEvent"):FireServer("convertGems", num)
        end
    end
})

Main:Toggle({
    Title = "循环上传",
    Default = false,
    Callback = function(state)
        isLooping = state
        if state then
            spawn(function()
                while isLooping and lastInputValue > 0 do
                    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("zenMasterEvent"):FireServer("convertGems", lastInputValue)
                    wait(0.5)
                end
            end)
        end
    end
})

Main:Button({
    Title = "恢复金币",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("zenMasterEvent"):FireServer("convertGems", 1)
    end
})

local Main = Window:Tab({Title = "人物", Icon = "settings"})
Main:Input({
    Title = "修改连跳上限",
    Placeholder = "输入连跳次数",
    Callback = function(Value)
        game.Players.LocalPlayer.multiJumpCount.Value = tonumber(Value)
    end
})

Main:Button({
    Title = "解锁所有岛屿",
    Callback = function()
        local positions = {
            CFrame.new(26, 766, -114),
            CFrame.new(247, 2013, 347),
            CFrame.new(162, 4047, 13),
            CFrame.new(200, 5656, 13),
            CFrame.new(200, 9284, 13),
            CFrame.new(200, 13679, 13),
            CFrame.new(200, 17686, 13),
            CFrame.new(200, 24069, 13),
            CFrame.new(197, 28256, 7),
            CFrame.new(197, 33206, 7),
            CFrame.new(197, 39317, 7),
            CFrame.new(197, 46010, 7),
            CFrame.new(197, 52607, 7),
            CFrame.new(197, 59594, 7),
            CFrame.new(197, 66668, 7),
            CFrame.new(197, 70270, 7),
            CFrame.new(197, 74442, 7),
            CFrame.new(197, 79746, 7),
            CFrame.new(197, 83198, 7),
            CFrame.new(197, 91245, 7)
        }
        
        for _, pos in ipairs(positions) do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
            wait(0.1)
        end
    end
})

local Main = Window:Tab({Title = "抽奖", Icon = "settings"})

local eggs = {}
for i, v in pairs(game.Workspace.mapCrystalsFolder:GetChildren()) do
    table.insert(eggs, v.Name)
end

local selectegg = ""
Main:Dropdown({
    Title = "选择抽奖机", 
    Values = eggs,
    Value = "",
    Callback = function(selectedEgg)
        selectegg = selectedEgg
    end
})

Main:Toggle({
    Title = "自动购买", 
    Default = false,
    Callback = function(state)
        getgenv().openegg = state
        while getgenv().openegg do
            wait()
            local A_1 = "openCrystal"
            local A_2 = selectegg
            local Event = game:GetService("ReplicatedStorage").rEvents.openCrystalRemote
            Event:InvokeServer(A_1, A_2)
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
