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
    Title = "极速传奇",
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
    ["极速传奇"] = "Speed Legend",
    ["主要功能"] = "Main Features",
    ["比赛功能"] = "Race Features",
    ["数值修改"] = "Stats Editor",
    ["能量球收集"] = "Orb Collection",
    ["水晶功能"] = "Crystal Features",
    ["宠物功能"] = "Pet Features",
    ["宠物进化"] = "Pet Evolution",
    ["重生设置"] = "Rebirth Settings",
    ["信息"] = "Information",
    
    -- Main Features
    ["自动重生"] = "Auto Rebirth",
    ["获取所有宝箱"] = "Get All Chests",
    ["获取所有通行证"] = "Get All Gamepasses",
    
    -- Race Features
    ["选择比赛地图"] = "Select Race Map",
    ["传送到终点"] = "Teleport to Finish",
    ["自动参加比赛"] = "Auto Join Race",
    ["自动收集光环"] = "Auto Collect Hoops",
    
    -- Stats Editor
    ["修改经验值"] = "Edit EXP",
    ["输入经验值"] = "Enter EXP Value",
    ["修改等级"] = "Edit Level",
    ["输入等级"] = "Enter Level",
    ["修改比赛数"] = "Edit Race Count",
    ["输入比赛次数"] = "Enter Race Count",
    ["修改圈数"] = "Edit Lap Count",
    ["输入圈数"] = "Enter Lap Count",
    ["修改重生次数"] = "Edit Rebirths",
    ["输入重生次数"] = "Enter Rebirth Count",
    ["修改步数"] = "Edit Steps",
    ["输入步数"] = "Enter Step Count",
    ["修改宝石数量"] = "Edit Gems",
    ["输入宝石数量"] = "Enter Gem Count",
    
    -- Orb Collection
    ["选择地区"] = "Select Area",
    ["City"] = "City",
    ["Snow City"] = "Snow City",
    ["Magma City"] = "Magma City",
    ["Desert"] = "Desert",
    ["Space"] = "Space",
    ["Legends Highway"] = "Legends Highway",
    ["自动收集红球"] = "Auto Collect Red Orbs",
    ["自动收集蓝球"] = "Auto Collect Blue Orbs",
    ["自动收集宝石球"] = "Auto Collect Gem Orbs",
    
    -- Crystal Features
    ["选择水晶"] = "Select Crystal",
    ["购买水晶"] = "Buy Crystal",
    ["自动购买水晶"] = "Auto Buy Crystal",
    
    -- Pet Features
    ["选择宠物"] = "Select Pet",
    ["购买宠物"] = "Buy Pet",
    ["自动购买宠物"] = "Auto Buy Pet",
    
    -- Pet Evolution
    ["进化宠物"] = "Evolve Pet",
    ["自动进化宠物"] = "Auto Evolve Pet",
    
    -- Rebirth Settings
    ["设置重生目标"] = "Set Rebirth Goal",
    ["输入重生次数"] = "Enter Rebirth Goal",
    ["自动重生到目标"] = "Auto Rebirth to Goal",
    ["已自动重生到"] = "Auto rebirthed to ",
    ["，已自动为你踢出"] = ", auto kicked",
    
    -- Information
    ["步数: "] = "Steps: ",
    ["经验: "] = "EXP: ",
    ["等级: "] = "Level: ",
    ["比赛次数: "] = "Races: ",
    ["重生: "] = "Rebirths: ",
    ["环: "] = "Hoops: ",
    ["宝石: "] = "Gems: ",
    
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


local Interstellar = {
    getorb = false,
    area = "City",
    mainexe = false,
    hoop = false,
    opencrystal = false,
    petshop = false,
    evolvepet = false,
    birth = 9e9,
    autobirth = false,
}

local Main = Window:Tab({Title = "主要功能", Icon = "star"})

Main:Toggle({
    Title = "自动重生",
    Default = false,
    Callback = function(state)
        Interstellar.mainexe = state
        if Interstellar.mainexe then
            while Interstellar.mainexe do
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
                wait()
            end
        end
    end
})

Main:Button({
    Title = "获取所有宝箱",
    Callback = function()
        for _, v in pairs(game.ReplicatedStorage.chestRewards:GetChildren()) do
            game.ReplicatedStorage.rEvents.checkChestRemote:InvokeServer(v.Name)
        end
    end
})

Main:Button({
    Title = "获取所有通行证",
    Callback = function()
        for i, v in ipairs(game:GetService("ReplicatedStorage").gamepassIds:GetChildren()) do
            v.Parent = game.Players.LocalPlayer.ownedGamepasses
        end 
    end
})

local RaceTab = Window:Tab({Title = "比赛功能", Icon = "flag"})

local Maps = {}
for i, Map in pairs(game:GetService("Workspace").raceMaps:GetChildren()) do
    Maps[i] = Map.Name
end

local selectedMap = ""
RaceTab:Dropdown({
    Title = "选择比赛地图",
    Values = Maps,
    Callback = function(Value)
        selectedMap = Value
    end
})

RaceTab:Button({
    Title = "传送到终点",
    Callback = function()
        if selectedMap ~= "" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.raceMaps[selectedMap].finishPart.CFrame
        end
    end
})

RaceTab:Toggle({
    Title = "自动参加比赛",
    Default = false,
    Callback = function(state)
        Interstellar.mainexe = state
        if Interstellar.mainexe then
            if game.PlaceId == 3101667897 then
                while Interstellar.mainexe do
                    game:GetService("ReplicatedStorage").rEvents.raceEvent:FireServer("joinRace")
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.raceMaps.Grassland.finishPart.CFrame
                    task.wait(0.1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.raceMaps.Magma.finishPart.CFrame
                    task.wait(0.1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.raceMaps.Desert.finishPart.CFrame
                    task.wait(0.3)
                end
            elseif game.PlaceId == 3276265788 then
                while Interstellar.mainexe do
                    game:GetService("ReplicatedStorage").rEvents.raceEvent:FireServer("joinRace")
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.raceMaps.Speedway.finishPart.CFrame
                    task.wait(0.2)
                end
            elseif game.PlaceId == 3232996272 then
                while Interstellar.mainexe do
                    game:GetService("ReplicatedStorage").rEvents.raceEvent:FireServer("joinRace")
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.raceMaps.Starway.finishPart.CFrame
                    task.wait(0.2)
                end
            end
        end
    end
})

RaceTab:Toggle({
    Title = "自动收集光环",
    Default = false,
    Callback = function(state)
        Interstellar.hoop = state
        if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
            while Interstellar.hoop do
                for i, hoops in ipairs(workspace.Hoops:GetChildren()) do
                    if hoops.Name == "Hoop" then
                        hoops.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        wait()
                    end
                end
            end
        end
    end
})

local EditTab = Window:Tab({Title = "数值修改", Icon = "edit"})

EditTab:Input({
    Title = "修改经验值",
    Placeholder = "输入经验值",
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.exp.Value = tonumber(Value) or 0
    end
})

EditTab:Input({
    Title = "修改等级",
    Placeholder = "输入等级",
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.level.Value = tonumber(Value) or 1
    end
})

EditTab:Input({
    Title = "修改比赛数",
    Placeholder = "输入比赛次数",
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.leaderstats.Races.Value = tonumber(Value) or 0
    end
})

EditTab:Input({
    Title = "修改圈数",
    Placeholder = "输入圈数",
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.leaderstats.Hoops.Value = tonumber(Value) or 0
    end
})

EditTab:Input({
    Title = "修改重生次数",
    Placeholder = "输入重生次数",
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value = tonumber(Value) or 0
    end
})

EditTab:Input({
    Title = "修改步数",
    Placeholder = "输入步数",
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.leaderstats.Steps.Value = tonumber(Value) or 0
    end
})

EditTab:Input({
    Title = "修改宝石数量",
    Placeholder = "输入宝石数量",
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.Gems.Value = tonumber(Value) or 0
    end
})

local OrbTab = Window:Tab({Title = "能量球收集", Icon = "globe"})

OrbTab:Dropdown({
    Title = "选择地区",
    Values = {"City","Snow City","Magma City","Desert","Space", "Legends Highway"},
    Callback = function(Value)
        Interstellar.area = Value
    end
})

OrbTab:Toggle({
    Title = "自动收集红球",
    Default = false,
    Callback = function(state)
        Interstellar.getorb = state
        spawn(function()
            while Interstellar.getorb do wait()
                pcall(function()
                    game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", Interstellar.area)
                end)
            end
        end)
    end
})

OrbTab:Toggle({
    Title = "自动收集蓝球",
    Default = false,
    Callback = function(state)
        Interstellar.getorb = state
        spawn(function()
            while Interstellar.getorb do wait()
                pcall(function()
                    game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", Interstellar.area)
                end)
            end
        end)
    end
})

OrbTab:Toggle({
    Title = "自动收集宝石球",
    Default = false,
    Callback = function(state)
        Interstellar.getorb = state
        spawn(function()
            while Interstellar.getorb do
                pcall(function()
                    game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", Interstellar.area)
                end)
            end
        end)
    end
})

local CrystalTab = Window:Tab({Title = "水晶功能", Icon = "gem"})

local crystalshow = {}
for i, crystal in pairs(game:GetService("Workspace").mapCrystalsFolder:GetChildren()) do
    crystalshow[i] = crystal.Name
end

local OpenCrystal = ""
CrystalTab:Dropdown({
    Title = "选择水晶",
    Values = crystalshow,
    Callback = function(Value)
        OpenCrystal = Value
    end
})

CrystalTab:Button({
    Title = "购买水晶",
    Callback = function()
        game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", OpenCrystal)
    end
})

CrystalTab:Toggle({
    Title = "自动购买水晶",
    Default = false,
    Callback = function(state)
        Interstellar.opencrystal = state
        if Interstellar.opencrystal then
            while Interstellar.opencrystal do
                game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", OpenCrystal)
                wait()
            end
        end
    end
})

local PetTab = Window:Tab({Title = "宠物功能", Icon = "paw"})

local petshow = {}
for i, pet in pairs(game:GetService("ReplicatedStorage").cPetShopFolder:GetChildren()) do
    petshow[i] = pet.Name
end

local BuyPetShop = ""
PetTab:Dropdown({
    Title = "选择宠物",
    Values = petshow,
    Callback = function(Value)
        BuyPetShop = Value
    end
})

PetTab:Button({
    Title = "购买宠物",
    Callback = function()
        game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild(BuyPetShop))
    end
})

PetTab:Toggle({
    Title = "自动购买宠物",
    Default = false,
    Callback = function(state)
        Interstellar.petshop = state
        if Interstellar.petshop then
            while Interstellar.petshop do
                game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild(BuyPetShop))
                wait()
            end
        end
    end
})

local EvolveTab = Window:Tab({Title = "宠物进化", Icon = "shield"})

local EvolvePet = ""
EvolveTab:Dropdown({
    Title = "选择宠物",
    Values = petshow,
    Callback = function(Value)
        EvolvePet = Value
    end
})

EvolveTab:Button({
    Title = "进化宠物",
    Callback = function()
        game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer("evolvePet", EvolvePet)
    end
})

EvolveTab:Toggle({
    Title = "自动进化宠物",
    Default = false,
    Callback = function(state)
        Interstellar.evolvepet = state
        if Interstellar.evolvepet then
            while Interstellar.evolvepet do
                game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer("evolvePet", EvolvePet)
                wait()
            end
        end
    end
})

local BirthTab = Window:Tab({Title = "重生设置", Icon = "refresh-cw"})

BirthTab:Input({
    Title = "设置重生目标",
    Placeholder = "输入重生次数",
    Callback = function(Value)
        Interstellar.birth = tonumber(Value) or 99999999999999999999999999999
    end
})

BirthTab:Toggle({
    Title = "自动重生到目标",
    Default = false,
    Callback = function(state)
        if game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value >= Interstellar.birth then
            game.Players.LocalPlayer:Kick("已自动重生到"..Interstellar.birth.."，已自动为你踢出")
        else
            Interstellar.autobirth = state
            if Interstellar.autobirth then
                while Interstellar.autobirth do
                    game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
                    wait()
                end
            end
        end
    end
})

local Info = Window:Tab({Title = "信息", Icon = "settings"})

Info:Paragraph({
    Title = "步数: " .. game:GetService("Players").LocalPlayer.leaderstats.Steps.Value,
    Callback = function(Value)
        return "步数: " .. game:GetService("Players").LocalPlayer.leaderstats.Steps.Value
    end
})

Info:Paragraph({
    Title = "经验: " .. game:GetService("Players").LocalPlayer.exp.Value,
    Callback = function(Value)
        return "经验: " .. game:GetService("Players").LocalPlayer.exp.Value
    end
})

Info:Paragraph({
    Title = "等级: " .. game:GetService("Players").LocalPlayer.level.Value,
    Callback = function(Value)
        return "等级: " .. game:GetService("Players").LocalPlayer.level.Value
    end
})

Info:Paragraph({
    Title = "比赛次数: " .. game:GetService("Players").LocalPlayer.leaderstats.Races.Value,
    Callback = function(Value)
        return "比赛次数: " .. game:GetService("Players").LocalPlayer.leaderstats.Races.Value
    end
})

Info:Paragraph({
    Title = "重生: " .. game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value,
    Callback = function(Value)
        return "重生: " .. game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value
    end
})

Info:Paragraph({
    Title = "环: " .. game:GetService("Players").LocalPlayer.leaderstats.Hoops.Value,
    Callback = function(Value)
        return "环: " .. game:GetService("Players").LocalPlayer.leaderstats.Hoops.Value
    end
})

Info:Paragraph({
    Title = "宝石: " .. game:GetService("Players").LocalPlayer.Gems.Value,
    Callback = function(Value)
        return "宝石: " .. game:GetService("Players").LocalPlayer.Gems.Value
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