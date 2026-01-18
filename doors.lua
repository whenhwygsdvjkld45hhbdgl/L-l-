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
    Icon = "palette",
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
    Icon = "palette",
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
    Title = "doors",
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



local Language = Window:Tab({Title = "语言设置", Icon = "globe"})

local Translations = {
    -- 主要标签
    ["人物"] = "Movement",
    ["禁用反作弊"] = "Disable Anti-Cheat",
    ["在电梯中使用，可能会有bug但通常有效"] = "Use in elevator, may have bugs but usually works",
    ["反作弊绕过"] = "Anti-Cheat Bypass",
    ["请上梯子以激活绕过"] = "Please climb ladder to activate bypass",
    ["反作弊操纵"] = "Anti-Cheat Manipulation",
    ["反作弊操纵按键"] = "Anti-Cheat Manipulation Key",
    ["开启速度"] = "Enable Speed",
    ["将你的行走速度更改为设定值"] = "Change your walk speed to set value",
    ["速度数值"] = "Speed Value",
    ["速度"] = "Speed",
    ["设置你的行走速度"] = "Set your walk speed",
    ["即时加速度"] = "Instant Acceleration",
    ["移除改变方向时的减速效果"] = "Remove slowdown when changing direction",
    ["开启飞行"] = "Enable Flight",
    ["飞行电脑切换键"] = "Flight Toggle Key",
    ["飞行速度"] = "Flight Speed",
    ["更改飞行速度"] = "Change flight speed",
    ["穿墙模式"] = "Noclip Mode",
    ["让你可以穿过墙壁"] = "Allows you to pass through walls",
    ["穿墙电脑切换键"] = "Noclip Toggle Key",
    ["更快爬梯"] = "Faster Ladder Climbing",
    ["爬梯速度"] = "Ladder Speed",
    ["爬梯的加速值，过高可能不稳定"] = "Ladder climbing speed, too high may be unstable",
    ["始终可跳跃"] = "Always Can Jump",
    ["让你随时可以跳跃"] = "Allows you to jump anytime",
    
    -- 自动类标签
    ["自动类"] = "Automation",
    ["自动锚点代码求解"] = "Auto Anchor Code Solver",
    ["自动断路器游戏"] = "Auto Breaker Game",
    ["自动隐藏[防怪物]"] = "Auto Hide [Anti-Monster]",
    ["自动为你隐藏"] = "Automatically hide for you",
    ["自动隐藏模式"] = "Auto Hide Mode",
    ["Safety"] = "Safety",
    ["Close Call"] = "Close Call",
    ["预测时间"] = "Prediction Time",
    ["距离倍数"] = "Distance Multiplier",
    ["自动互动"] = "Auto Interact",
    ["自动互动距离"] = "Auto Interact Distance",
    ["自动矿车推动"] = "Auto Minecart Push",
    ["自动拾取投掷物"] = "Auto Pickup Throwables",
    ["自动破门"] = "Auto Break Doors",
    ["自动拾取"] = "Auto Pickup",
    ["自动开火"] = "Auto Fire",
    ["自动房间"] = "Auto Rooms",
    ["反AFK"] = "Anti-AFK",
    ["自动门范围"] = "Auto Door Range",
    ["即时互动"] = "Instant Interaction",
    ["既时互动范围提升"] = "Instant Interaction Range Boost",
    
    -- 规避类标签
    ["规避类"] = "Avoidance",
    ["规避Screech"] = "Avoid Screech",
    ["规避Gloom蛋"] = "Avoid Gloom Eggs",
    ["规避Dread"] = "Avoid Dread",
    ["规避Giggle"] = "Avoid Giggle",
    ["规避Figure听觉"] = "Avoid Figure Hearing",
    ["让游戏认为你在蹲下"] = "Make game think you're crouching",
    ["规避Surge"] = "Avoid Surge",
    ["规避Halt"] = "Avoid Halt",
    ["规避Lookman"] = "Avoid Lookman",
    ["规避Snare"] = "Avoid Snare",
    ["规避Seek障碍物"] = "Avoid Seek Obstacles",
    ["规避Dupe门"] = "Avoid Dupe Doors",
    ["规避真空区域"] = "Avoid Void Areas",
    ["规避Eyes"] = "Avoid Eyes",
    ["当Eyes出现时自动向下看以防止伤害"] = "Automatically look down when Eyes appear to prevent damage",
    ["规避A-90"] = "Avoid A-90",
    ["移除A90"] = "Remove A90",
    ["规避虚空效果"] = "Avoid Void Effects",
    ["规避Haste效果"] = "Avoid Haste Effects",
    ["规避Firedamp"] = "Avoid Firedamp",
    ["规避矿井氛围"] = "Avoid Mine Atmosphere",
    ["规避氧气/理智效果"] = "Avoid Oxygen/Sanity Effects",
    ["无雾效果"] = "No Fog Effect",
    ["无相机抖动"] = "No Camera Shake",
    ["无头部晃动"] = "No Head Bobbing",
    ["无过场动画"] = "No Cutscenes",
    ["规避隐藏边缘"] = "Avoid Hide Vignette",
    ["移除隐藏时的黑暗边缘"] = "Remove dark edges when hiding",
    ["防卡顿"] = "Anti-Lag",
    ["防香蕉皮"] = "Anti-Banana",
    ["防Jeff杀手"] = "Anti-Jeff Killer",
    
    -- 透视功能标签
    ["透视功能"] = "ESP Features",
    ["ESP设置[展开]"] = "ESP Settings [Expand]",
    ["启用追踪线"] = "Enable Tracers",
    ["启用方向箭头"] = "Enable Direction Arrows",
    ["ESP类型"] = "ESP Type",
    ["高亮"] = "Highlight",
    ["文字"] = "Text",
    ["选择框"] = "Selection Box",
    ["物体透视[展开]"] = "Object ESP [Expand]",
    ["门透视"] = "Door ESP",
    ["目标物品透视"] = "Objective Item ESP",
    ["金币透视"] = "Coin ESP",
    ["矿洞发电机透视"] = "Mine Generator ESP",
    ["杠杆透视"] = "Lever ESP",
    ["所有物品透视"] = "All Items ESP",
    ["柜子透视"] = "Closet ESP",
    ["锚点透视"] = "Anchor ESP",
    ["图书馆书籍透视"] = "Library Book ESP",
    ["宝箱透视"] = "Chest ESP",
    ["实体透视[展开]"] = "Entity ESP [Expand]",
    ["追逐者透视"] = "Seek ESP",
    ["雕像透视"] = "Figure ESP",
    ["伏击透视"] = "Ambush ESP",
    ["冲刺透视"] = "Rush ESP",
    ["陷阱透视"] = "Snare ESP",
    ["傻笑透视"] = "Giggle ESP",
    ["眼柄透视"] = "Eyestalk ESP",
    ["曼德拉草透视"] = "Mandrake ESP",
    ["园丁透视"] = "Groundskeeper ESP",
    ["闪电透视"] = "Blitz ESP",
    
    -- 颜色选项
    ["红色"] = "Red",
    ["绿色"] = "Green",
    ["蓝色"] = "Blue",
    ["黄色"] = "Yellow",
    ["紫色"] = "Purple",
    ["青色"] = "Cyan",
    ["粉色"] = "Pink",
    ["橙色"] = "Orange",
    ["白色"] = "White",
    ["彩虹动态"] = "Rainbow Dynamic",
    
    -- 提示标签
    ["提示"] = "Notifications",
    ["实体刷新提示[展开]"] = "Entity Spawn Notifications [Expand]",
    ["尖啸者提示"] = "Screech Notification",
    ["暂停实体提示"] = "Halt Notification",
    ["雕像提示"] = "Figure Notification",
    ["眼睛提示"] = "Eyes Notification",
    ["追逐者提示"] = "Seek Notification",
    ["冲刺提示"] = "Rush Notification",
    ["伏击提示"] = "Ambush Notification",
    ["A-60提示"] = "A-60 Notification",
    ["A-120提示"] = "A-120 Notification",
    ["傻笑提示"] = "Giggle Notification",
    ["咕噜提示"] = "Grumble Notification",
    ["暗影蝙蝠提示"] = "Gloombat Notification",
    ["恐惧提示"] = "Dread Notification",
    ["观察者提示"] = "Lookman Notification",
    ["陷阱提示"] = "Snare Notification",
    ["世界莲花提示"] = "World Lotus Notification",
    ["荆棘提示"] = "Bramble Notification",
    ["乌鸦提示"] = "Caws Notification",
    ["眼柄提示"] = "Eyestalk Notification",
    ["爷爷提示"] = "Grampy Notification",
    ["园丁提示"] = "Groundskeeper Notification",
    ["曼德拉草提示"] = "Mandrake Notification",
    ["纪念碑提示"] = "Monument Notification",
    ["浪涌提示"] = "Surge Notification",
    ["闪电提示"] = "Blitz Notification",
    
    -- UI设置标签
    ["ui设置"] = "UI Settings",
    ["二改wind原版ui"] = "Modified Wind Original UI",
    ["启用边框"] = "Enable Border",
    ["启用字体颜色"] = "Enable Font Color",
    ["启用音效"] = "Enable Sound Effects",
    ["启用背景模糊"] = "Enable Background Blur",
    ["边框颜色方案"] = "Border Color Scheme",
    ["选择喜欢的颜色组合"] = "Select preferred color combination",
    ["字体颜色方案"] = "Font Color Scheme",
    ["选择文字颜色组合"] = "Select text color combination",
    ["字体样式"] = "Font Style",
    ["选择文字字体样式"] = "Select text font style",
    ["边框转动速度"] = "Border Rotation Speed",
    ["调整边框旋转的快慢"] = "Adjust border rotation speed",
    ["UI整体缩放"] = "UI Overall Scale",
    ["调整UI大小比例"] = "Adjust UI size ratio",
    ["UI透明度"] = "UI Transparency",
    ["调整整个UI的透明度"] = "Adjust overall UI transparency",
    ["调整UI宽度"] = "Adjust UI Width",
    ["调整窗口的宽度"] = "Adjust window width",
    ["调整UI高度"] = "Adjust UI Height",
    ["调整窗口的高度"] = "Adjust window height",
    ["边框粗细"] = "Border Thickness",
    ["调整边框的粗细"] = "Adjust border thickness",
    ["圆角大小"] = "Corner Radius",
    ["调整UI圆角的大小"] = "Adjust UI corner radius",
    ["恢复UI到原位"] = "Reset UI Position",
    ["重置UI大小"] = "Reset UI Size",
    ["随机字体"] = "Random Font",
    ["随机颜色"] = "Random Color",
    ["刷新字体颜色"] = "Refresh Font Color",
    ["刷新字体样式"] = "Refresh Font Style",
    ["测试所有字体"] = "Test All Fonts",
    ["导出设置"] = "Export Settings",
    
    -- 颜色方案
    ["彩虹颜色"] = "Rainbow Colors",
    ["黑红颜色"] = "Black Red Colors",
    ["蓝白颜色"] = "Blue White Colors",
    ["紫金颜色"] = "Purple Gold Colors",
    ["蓝黑颜色"] = "Blue Black Colors",
    ["绿紫颜色"] = "Green Purple Colors",
    ["粉蓝颜色"] = "Pink Blue Colors",
    ["橙青颜色"] = "Orange Cyan Colors",
    ["红金颜色"] = "Red Gold Colors",
    ["银蓝颜色"] = "Silver Blue Colors",
    ["霓虹颜色"] = "Neon Colors",
    ["森林颜色"] = "Forest Colors",
    ["火焰颜色"] = "Fire Colors",
    ["海洋颜色"] = "Ocean Colors",
    ["日落颜色"] = "Sunset Colors",
    ["银河颜色"] = "Galaxy Colors",
    ["糖果颜色"] = "Candy Colors",
    ["金属颜色"] = "Metal Colors",
    
    -- 通用提示
    ["提示"] = "Notification",
    ["已开启"] = "Enabled",
    ["已禁用"] = "Disabled",
    ["已选择"] = "Selected",
    ["设置成功"] = "Set Successfully",
    ["距离设置为"] = "Distance set to",
    ["速度设置为"] = "Speed set to",
    ["透明度设置为"] = "Transparency set to",
    ["间隔设置为"] = "Interval set to",
    ["目标数量设置为"] = "Target amount set to",
    ["力度设置为"] = "Force set to",
    ["范围设置为"] = "Range set to",
    
    -- 语言设置
    ["语言设置"] = "Language Settings",
    ["当前语言"] = "Current Language",
    ["中文"] = "Chinese",
    ["英文"] = "English",
    ["应用语言"] = "Apply Language",
    ["重启脚本生效"] = "Restart script to take effect",
    
    -- 实体描述
    ["尖啸者已生成"] = "Screech has spawned",
    ["暂停实体已出现"] = "Halt entity has appeared",
    ["检测到雕像"] = "Figure detected",
    ["眼睛实体已生成"] = "Eyes entity has spawned",
    ["追逐者已生成"] = "Seek has spawned",
    ["冲刺正在接近"] = "Rush is approaching",
    ["伏击正在接近"] = "Ambush is approaching",
    ["A-60 正在冲刺"] = "A-60 is rushing",
    ["A-120 在附近"] = "A-120 is nearby",
    ["傻笑在天花板上"] = "Giggle is on the ceiling",
    ["咕噜在巡逻"] = "Grumble is patrolling",
    ["暗影蝙蝠群来袭"] = "Gloombat swarm incoming",
    ["恐惧实体已激活"] = "Dread entity activated",
    ["观察者在注视"] = "Lookman is watching",
    ["陷阱已生成"] = "Snare has spawned",
    ["检测到世界莲花"] = "World Lotus detected",
    ["荆棘在生长"] = "Bramble is growing",
    ["乌鸦在飞行"] = "Caws is flying",
    ["眼柄将要追逐"] = "Eyestalk will chase",
    ["爷爷已出现"] = "Grampy has appeared",
    ["园丁在附近"] = "Groundskeeper is nearby",
    ["曼德拉草在尖叫"] = "Mandrake is screaming",
    ["纪念碑已激活"] = "Monument activated",
    ["浪涌在充能"] = "Surge is charging",
    ["闪电即将到来"] = "Blitz is coming",
    
    -- 其他
    ["反作弊"] = "Anti-Cheat",
    ["反作弊已禁用，你可以飞行穿过一切"] = "Anti-Cheat disabled, you can fly through everything",
    ["错误"] = "Error",
    ["您的执行器不支持replicatesignal功能"] = "Your executor does not support replicatesignal function",
    ["你需要在电梯中使用此功能"] = "You need to use this function in the elevator",
    ["已绕过反作弊，攀爬重置"] = "Anti-Cheat bypassed, climbing reset",
    ["移速"] = "Movement Speed",
    ["自定义移速已启用"] = "Custom movement speed enabled",
    ["自定义移速已禁用"] = "Custom movement speed disabled",
    ["移速已更新"] = "Movement speed updated",
    ["加速度"] = "Acceleration",
    ["即时加速度已启用"] = "Instant acceleration enabled",
    ["即时加速度已禁用"] = "Instant acceleration disabled",
    ["飞行"] = "Flight",
    ["飞行模式已启用"] = "Flight mode enabled",
    ["飞行模式已禁用"] = "Flight mode disabled",
    ["飞行速度已更新"] = "Flight speed updated",
    ["穿墙"] = "Noclip",
    ["穿墙模式已启用"] = "Noclip mode enabled",
    ["穿墙模式已禁用"] = "Noclip mode disabled",
    ["爬梯"] = "Ladder",
    ["梯子加速已启用"] = "Ladder acceleration enabled",
    ["梯子加速已禁用"] = "Ladder acceleration disabled",
    ["爬梯速度已更新"] = "Ladder speed updated",
    ["跳跃"] = "Jump",
    ["始终跳跃已启用"] = "Always jump enabled",
    ["始终跳跃已禁用"] = "Always jump disabled",
    ["锚点代码"] = "Anchor Code",
    ["自动开火"] = "Auto Fire",
    ["正在向"] = "Firing at",
    ["开火"] = "fire",
    ["自动门"] = "Auto Door",
    ["自动门范围已启用"] = "Auto door range enabled",
    ["自动门范围已禁用"] = "Auto door range disabled",
    ["即时互动"] = "Instant Interaction",
    ["互动范围"] = "Interaction Range",
    ["实体刷新"] = "Entity Spawn",
    ["边框"] = "Border",
    ["字体颜色"] = "Font Color",
    ["音效"] = "Sound Effects",
    ["背景模糊"] = "Background Blur"
}

local currentLanguage = "中文"
local languageChanged = false

Language:Dropdown({
    Title = "当前语言",
    Values = {"中文", "English"},
    Value = "中文",
    Callback = function(option)
        if option == "English" then
            currentLanguage = "English"
        else
            currentLanguage = "中文"
        end
        languageChanged = true
    end
})

Language:Button({
    Title = "应用语言",
    Callback = function()
        if languageChanged then
            WindUI:Notify({
                Title = "语言切换",
                Content = "请重启脚本使更改生效",
                Duration = 5,
                Icon = "info"
            })
            languageChanged = false
        else
            WindUI:Notify({
                Title = "语言",
                Content = "语言已设置为 " .. (currentLanguage == "中文" and "中文" or "English"),
                Duration = 3,
                Icon = "info"
            })
        end
    end
})

-- 翻译函数
local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    
    if currentLanguage == "English" then
        return Translations[text] or text
    else
        -- 如果是英文，找对应的中文
        for cn, en in pairs(Translations) do
            if text == en then
                return cn
            end
        end
        return text
    end
end

-- 翻译UI元素
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

-- 扫描并翻译所有UI
local function scanAndTranslate()
    -- 翻译WindUI界面
    if Window and Window.UIElements then
        for _, gui in ipairs(Window.UIElements:GetDescendants()) do
            translateGUI(gui)
        end
    end
    
    -- 翻译游戏内UI
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
            translateGUI(gui)
        end
    end
end

-- 设置监听器
local function setupDescendantListener(parent)
    parent.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
            task.wait(0.1) -- 等待元素完全加载
            translateGUI(descendant)
        end
    end)
end

-- 设置翻译引擎
local function setupTranslationEngine()
    -- 设置WindUI监听
    if Window and Window.UIElements then
        pcall(setupDescendantListener, Window.UIElements)
    end
    
    -- 设置游戏UI监听
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        pcall(setupDescendantListener, player.PlayerGui)
    end
    
    -- 初始翻译
    scanAndTranslate()
    
    -- 定期更新翻译
    while true do
        scanAndTranslate()
        task.wait(3) -- 每3秒检查一次
    end
end

-- 创建翻译通知函数
local function showTranslatedNotification(title, content, duration)
    local translatedTitle = translateText(title)
    local translatedContent = translateText(content)
    
    WindUI:Notify({
        Title = translatedTitle,
        Content = translatedContent,
        Duration = duration or 4
    })
end

-- 替换原有的通知调用
local originalNotify = WindUI.Notify
WindUI.Notify = function(notification)
    if type(notification) == "table" then
        if currentLanguage == "English" then
            notification.Title = translateText(notification.Title) or notification.Title
            notification.Content = translateText(notification.Content) or notification.Content
        end
    end
    return originalNotify(notification)
end

-- 启动翻译引擎
task.spawn(function()
    task.wait(2) -- 等待UI加载完成
    setupTranslationEngine()
end)

-- 在脚本开头添加翻译通知的替换
local function initializeTranslatedNotifications()
    -- 替换所有 WindUI:Notify 调用为翻译版本
    local function createTranslatedNotify()
        return function(notification)
            if type(notification) == "string" then
                -- 如果是字符串格式的通知
                showTranslatedNotification("提示", notification, 3)
            elseif type(notification) == "table" then
                -- 如果是表格格式的通知
                local title = notification.Title or "提示"
                local content = notification.Content or ""
                local duration = notification.Duration or 3
                showTranslatedNotification(title, content, duration)
            end
        end
    end
    
    -- 创建全局翻译通知函数
    _G.TranslatedNotify = createTranslatedNotify()
end

-- 初始化翻译通知系统
initializeTranslatedNotifications()


    local MovementTab = Window:Tab({Title = "人物", Icon = "running"})
    MovementTab:Button({
        Title = "禁用反作弊",
        Tooltip = "在电梯中使用，可能会有bug但通常有效",
        Callback = function()
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")

            if currentRoom == 0 then
                if replicatesignal then
                    replicatesignal(LocalPlayer.Kill)
                    WindUI:Notify("反作弊", "反作弊已禁用，你可以飞行穿过一切", 10)
                else
                    WindUI:Notify("错误", "您的执行器不支持replicatesignal功能", 5)
                end
            else
                WindUI:Notify("提示", "你需要在电梯中使用此功能", 5)
            end
        end
    })
    MovementTab:Toggle({
        Title = "反作弊绕过",
        Default = false,
        Callback = function(Value)
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local RemoteFolder = game:GetService("ReplicatedStorage"):FindFirstChild("RemotesFolder")

            if not Value then
                if RemoteFolder and RemoteFolder:FindFirstChild("ClimbLadder") then
                    RemoteFolder.ClimbLadder:FireServer()
                end
            else
                WindUI:Notify("反作弊", "请上梯子以激活绕过", 9)
            end
        end
    })

   
    local LocalPlayer = game:GetService("Players").LocalPlayer
    LocalPlayer.Character:GetAttributeChangedSignal("Climbing"):Connect(function()
        if LocalPlayer.Character:GetAttribute("Climbing") == true then
            task.spawn(function()
                task.wait(0.1)
                LocalPlayer.Character:SetAttribute("Climbing", false)
                WindUI:Notify("反作弊", "已绕过反作弊，攀爬重置", 7)
            end)
        end
    end)

  
    MovementTab:Toggle({
        Title = "反作弊操纵",
        Default = false,
        Callback = function(Value)
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local Camera = workspace.CurrentCamera
            local LocalPlayer = Players.LocalPlayer
            local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
            local UserInputService = game:GetService("UserInputService")
            local savedCamCFrame
            local camLocked = false
            local acmButton
            local acmButtonActive = false

            local BUTTON_SIZE = UDim2.new(0, 70, 0, 35)
            local BUTTON_POSITION = UDim2.new(1, -80, 0.5, -17)
            local BUTTON_COLOR = Color3.fromRGB(45, 45, 45)
            local BUTTON_ACTIVE_COLOR = Color3.fromRGB(90, 90, 90)
            local BUTTON_TEXT_COLOR = Color3.fromRGB(255, 255, 255)

            local function createACMButton()
                if not UserInputService.TouchEnabled or acmButton then
                    return
                end

                local screenGui = Instance.new("ScreenGui")
                screenGui.Name = "ACMGui"
                screenGui.ResetOnSpawn = false
                screenGui.Parent = PlayerGui

                local button = Instance.new("TextButton")
                button.Name = "ACMButton"
                button.Size = BUTTON_SIZE
                button.Position = BUTTON_POSITION
                button.BackgroundColor3 = BUTTON_COLOR
                button.Text = "ACM"
                button.TextColor3 = BUTTON_TEXT_COLOR
                button.Font = Enum.Font.GothamBold
                button.TextSize = 16
                button.BorderSizePixel = 0
                button.Parent = screenGui

                button.MouseButton1Down:Connect(function()
                    acmButtonActive = true
                    button.BackgroundColor3 = BUTTON_ACTIVE_COLOR
                end)

                button.MouseButton1Up:Connect(function()
                    acmButtonActive = false
                    button.BackgroundColor3 = BUTTON_COLOR
                end)

                acmButton = screenGui
            end

            local function removeACMButton()
                if acmButton then
                    acmButton:Destroy()
                    acmButton = nil
                    acmButtonActive = false
                end
            end

            if Value then
                createACMButton()
                
                RunService.RenderStepped:Connect(function()
                    local cam = workspace.CurrentCamera
                    if not cam then return end

                    local active = Value and acmButtonActive
                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")

                    if active and hrp then
                        if not camLocked then
                            savedCamCFrame = cam.CFrame
                            cam.CameraType = Enum.CameraType.Scriptable
                            camLocked = true
                            hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, 10000)
                        end

                        cam.CFrame = savedCamCFrame
                    elseif camLocked then
                        cam.CameraType = Enum.CameraType.Custom
                        camLocked = false
                        savedCamCFrame = nil
                    end
                end)
            else
                removeACMButton()
            end
        end
    })

    MovementTab:Keybind({
        Title = "反作弊操纵按键",
        Default = "T",
        Mode = "Hold",
        Callback = function(Value) end
    })
    
    local SpeedValue = 21
    local SpeedEnabled = false
    local SpeedConnection = nil
    local BypassLabel = nil

    MovementTab:Toggle({
        Title = "开启速度",
        Default = false,
        Tooltip = "将你的行走速度更改为设定值",
        Callback = function(Value)
            SpeedEnabled = Value
            local LocalPlayer = game:GetService("Players").LocalPlayer
            
            if Value then
                SpeedConnection = game:GetService("RunService").Heartbeat:Connect(function()
                    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.WalkSpeed = SpeedValue
                    end
                end)
                WindUI:Notify("移速", "自定义移速已启用: " .. SpeedValue, 3)
            else
                if SpeedConnection then
                    SpeedConnection:Disconnect()
                    SpeedConnection = nil
                end
                WindUI:Notify("移速", "自定义移速已禁用", 3)
            end
        end
    })

    MovementTab:Slider({
        Title = "速度数值",
        Value = {Min = 0, Max = 100, Default = 21},
        Suffix = " 速度",
        Tooltip = "设置你的行走速度",
        Callback = function(Value)
            SpeedValue = Value
            if SpeedEnabled then
                WindUI:Notify("移速", "移速已更新: " .. Value, 2)
            end
        end
    })
    MovementTab:Toggle({
        Title = "即时加速度",
        Default = false,
        Tooltip = "移除改变方向时的减速效果",
        Callback = function(Value)
            local LocalPlayer = game:GetService("Players").LocalPlayer
            local OldAccel = PhysicalProperties.new(0.01, 0.7, 0, 1, 1)
            
            local function updateAcceleration()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CustomPhysicalProperties = Value and PhysicalProperties.new(100, 0, 0, 0, 0) or OldAccel
                end
            end

            if Value then
                updateAcceleration()
                WindUI:Notify("加速度", "即时加速度已启用", 3)
            else
                updateAcceleration()
                WindUI:Notify("加速度", "即时加速度已禁用", 3)
            end
            LocalPlayer.CharacterAdded:Connect(function()
                task.wait(1.5)
                updateAcceleration()
            end)
        end
    })
    local isFlying = false
    local flyConnections = {}
    local flyKeys = {
        W = false,
        A = false,
        S = false,
        D = false,
        Space = false,
        Shift = false,
    }
    local FlySpeed = 50

    local function startFly()
        local player = game.Players.LocalPlayer
        local character = player.Character

        if not character then
            return
        end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            return
        end

        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then
            return
        end
        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"
        bv.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = hrp

        local bg = Instance.new("BodyGyro")
        bg.Name = "FlyGyro"
        bg.MaxTorque = Vector3.new(1000000000, 1000000000, 1000000000)
        bg.P = 20000
        bg.D = 1000
        bg.Parent = hrp

        humanoid.AutoRotate = false
        humanoid.PlatformStand = true
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        local inputBegan = game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
            if gpe then return end
            
            if input.KeyCode == Enum.KeyCode.W then
                flyKeys.W = true
            elseif input.KeyCode == Enum.KeyCode.A then
                flyKeys.A = true
            elseif input.KeyCode == Enum.KeyCode.S then
                flyKeys.S = true
            elseif input.KeyCode == Enum.KeyCode.D then
                flyKeys.D = true
            elseif input.KeyCode == Enum.KeyCode.Space then
                flyKeys.Space = true
            elseif input.KeyCode == Enum.KeyCode.LeftShift then
                flyKeys.Shift = true
            end
        end)

        table.insert(flyConnections, inputBegan)

        local inputEnded = game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then
                flyKeys.W = false
            elseif input.KeyCode == Enum.KeyCode.A then
                flyKeys.A = false
            elseif input.KeyCode == Enum.KeyCode.S then
                flyKeys.S = false
            elseif input.KeyCode == Enum.KeyCode.D then
                flyKeys.D = false
            elseif input.KeyCode == Enum.KeyCode.Space then
                flyKeys.Space = false
            elseif input.KeyCode == Enum.KeyCode.LeftShift then
                flyKeys.Shift = false
            end
        end)

        table.insert(flyConnections, inputEnded)
        local renderConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera

            if not cam or not hrp or not hrp:FindFirstChild("FlyVelocity") or not humanoid or humanoid.Health <= 0 then
                stopFly()
                return
            end

            local move = Vector3.new(0, 0, 0)

            if flyKeys.W then
                move = move + cam.CFrame.LookVector
            end
            if flyKeys.S then
                move = move - cam.CFrame.LookVector
            end
            if flyKeys.A then
                move = move - cam.CFrame.RightVector
            end
            if flyKeys.D then
                move = move + cam.CFrame.RightVector
            end
            if flyKeys.Space then
                move = move + Vector3.new(0, 1, 0)
            end
            if flyKeys.Shift then
                move = move - Vector3.new(0, 1, 0)
            end

            local direction = (move.Magnitude > 0) and (move.Unit * FlySpeed) or Vector3.new(0, 0, 0)
            bv.Velocity = direction
            bg.CFrame = cam.CFrame
        end)

        table.insert(flyConnections, renderConnection)
    end

    local function stopFly()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local hrp = character and character:FindFirstChild("HumanoidRootPart")

        if hrp then
            local flyVelocity = hrp:FindFirstChild("FlyVelocity")
            if flyVelocity then
                flyVelocity:Destroy()
            end

            local flyGyro = hrp:FindFirstChild("FlyGyro")
            if flyGyro then
                flyGyro:Destroy()
            end
        end

        if humanoid then
            humanoid.AutoRotate = true
            humanoid.PlatformStand = false
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end

        for _, conn in ipairs(flyConnections) do
            conn:Disconnect()
        end

        flyConnections = {}
        flyKeys = {
            W = false,
            A = false,
            S = false,
            D = false,
            Space = false,
            Shift = false,
        }
    end

    MovementTab:Toggle({
        Title = "开启飞行",
        Default = false,
        Callback = function(Value)
            isFlying = Value

            if Value then
                startFly()
                WindUI:Notify("飞行", "飞行模式已启用", 3)
            else
                stopFly()
                WindUI:Notify("飞行", "飞行模式已禁用", 3)
            end
        end
    })

    MovementTab:Keybind({
        Title = "飞行电脑切换键",
        Default = "F",
        Mode = "Toggle",
        Callback = function(Value) end
    })

    MovementTab:Slider({
        Title = "飞行速度",
        Value = {Min = 0, Max = 150, Default = 50},
        Suffix = " 速度",
        Tooltip = "更改飞行速度",
        Callback = function(Value)
            FlySpeed = Value
            if isFlying then
                WindUI:Notify("飞行", "飞行速度已更新: " .. Value, 2)
            end
        end
    })
    local noclipConnection = nil
    local originalGroups = {}

    MovementTab:Toggle({
        Title = "穿墙模式",
        Default = false,
        Tooltip = "让你可以穿过墙壁",
        Callback = function(Value)
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local lp = Players.LocalPlayer

            local function enableNoclip()
                if noclipConnection then
                    return
                end

                noclipConnection = RunService.Stepped:Connect(function()
                    if lp.Character then
                        for _, part in pairs(lp.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                                if not originalGroups[part] then
                                    originalGroups[part] = part.CollisionGroup
                                end
                                part.CollisionGroup = "Default"
                            end
                        end
                    end
                end)
            end

            local function disableNoclip()
                if noclipConnection then
                    noclipConnection:Disconnect()
                    noclipConnection = nil
                end

                local char = lp.Character
                if not char then
                    return
                end

                local collision = char:FindFirstChild("Collision")
                local crouch = collision and collision:FindFirstChild("CollisionCrouch")

                if collision and crouch then
                    local crouching = collision.CollisionGroup == "PlayerCrouching"
                    collision.CanCollide = not crouching
                    crouch.CanCollide = crouching
                end
            end

            if Value then
                enableNoclip()
                WindUI:Notify("穿墙", "穿墙模式已启用", 3)
            else
                disableNoclip()
                WindUI:Notify("穿墙", "穿墙模式已禁用", 3)
            end
        end
    })

    MovementTab:Keybind({
        Title = "穿墙电脑切换键",
        Default = "N",
        Mode = "Toggle",
        Callback = function(Value) end
    })
    local LadderSpeedValue = 20
    local LadderSpeedEnabled = false
    local LadderConnection = nil

    MovementTab:Toggle({
        Title = "更快爬梯",
        Default = false,
        Callback = function(on)
            local LocalPlayer = game.Players.LocalPlayer
            local RunService = game:GetService("RunService")

            if on then
                LadderConnection = RunService.Heartbeat:Connect(function()
                    local char = LocalPlayer.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")

                    if hum and hrp and hum:GetState() == Enum.HumanoidStateType.Climbing then
                        hrp.Velocity = Vector3.new(hrp.Velocity.X, LadderSpeedValue, hrp.Velocity.Z)
                    end
                end)
                WindUI:Notify("爬梯", "梯子加速已启用", 3)
            elseif LadderConnection then
                LadderConnection:Disconnect()
                LadderConnection = nil
                WindUI:Notify("爬梯", "梯子加速已禁用", 3)
            end
        end
    })

    MovementTab:Slider({
        Title = "爬梯速度",
        Value = {Min = 0, Max = 100, Default = 20},
        Suffix = " 速度",
        Tooltip = "爬梯的加速值，过高可能不稳定",
        Callback = function(Value)
            LadderSpeedValue = Value
            if LadderSpeedEnabled then
                WindUI:Notify("爬梯", "爬梯速度已更新: " .. Value, 2)
            end
        end
    })
    MovementTab:Toggle({
        Title = "始终可跳跃",
        Default = false,
        Tooltip = "让你随时可以跳跃",
        Callback = function(Value)
            local LocalPlayer = game.Players.LocalPlayer
            LocalPlayer.Character:SetAttribute("CanJump", Value)
            
            if Value then
                WindUI:Notify("跳跃", "始终跳跃已启用", 3)
            else
                WindUI:Notify("跳跃", "始终跳跃已禁用", 3)
            end
            LocalPlayer.CharacterAdded:Connect(function(newCharacter)
                task.wait(1.5)
                newCharacter:SetAttribute("CanJump", Value)
            end)
        end
    })
    local B = Window:Tab({Title = "自动类", Icon = "puzzle"})
    B:Toggle({
        Title = "自动锚点代码求解",
        Default = false,
        Callback = function(enabled)
            local running = false
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Workspace = game:GetService("Workspace")
            
            if enabled then
                if running then return end
                running = true
                
                task.spawn(function()
                    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
                    
                    local function findFrame()
                        local mainUI = playerGui:FindFirstChild("MainUI")
                        if mainUI and mainUI:FindFirstChild("MainFrame") then
                            local frame = mainUI.MainFrame:FindFirstChild("AnchorHintFrame")
                            if frame then return frame end
                        end

                        local anchorUI = playerGui:FindFirstChild("AnchorHintUI")
                        if anchorUI then
                            local frame = anchorUI:FindFirstChild("AnchorHintFrame")
                            if frame then return frame end
                        end
                        return nil
                    end

                    while running do
                        task.wait(0.9)
                        local frame = findFrame()
                        
                        if frame then
                            local anchorName = (frame:FindFirstChild("AnchorCode") and frame.AnchorCode.Text) or ''
                            local codeText = (frame:FindFirstChild("Code") and frame.Code.Text) or ''
                            
                            if anchorName ~= '' and codeText ~= '' then
                                local anchorObject
                                for _, obj in ipairs(Workspace.CurrentRooms:GetDescendants()) do
                                    if obj.Name == "MinesAnchor" then
                                        local sign = obj:FindFirstChild("Sign")
                                        if sign then
                                            local label = sign:FindFirstChild("TextLabel") or sign:FindFirstChildWhichIsA("TextLabel")
                                            if label and label.Text == anchorName then
                                                anchorObject = obj
                                                break
                                            end
                                        end
                                    end
                                end

                                if anchorObject then
                                    local note = anchorObject:FindFirstChild("Note")
                                    if not note then
                                        WindUI:Notify("锚点代码", "锚点 " .. anchorName .. " 代码是 " .. codeText, 3)
                                    else
                                        local surfaceGui = note:FindFirstChildOfClass("SurfaceGui") or note:FindFirstChild("SurfaceGui")
                                        local noteText = (surfaceGui and surfaceGui:FindFirstChild("TextLabel") and surfaceGui.TextLabel.Text) or '0'
                                        local noteValue = tonumber(noteText) or 0
                                        local solved = ''
                                        
                                        for i = 1, #codeText do
                                            local digit = tonumber(codeText:sub(i, i)) or 0
                                            digit = (digit + noteValue) % 10
                                            solved = solved .. tostring(digit)
                                        end
                                        
                                        WindUI:Notify("锚点代码", "锚点 " .. anchorName .. " 代码是 " .. solved, 5)
                                    end
                                end
                            end
                        else
                            task.wait(0.25)
                        end
                    end
                end)
            else
                running = false
            end
        end
    })
    B:Toggle({
        Title = "自动断路器游戏",
        Default = false,
        Callback = function(Value)
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local LocalPlayer = Players.LocalPlayer
            local RemoteFolder = ReplicatedStorage:FindFirstChild("RemotesFolder") or ReplicatedStorage:FindFirstChild("EntityInfo") or ReplicatedStorage:FindFirstChild("Bricks")
            
            while task.wait() and Value do
                if not Value then break end
                
                local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
                if currentRoom ~= 100 then
                    WindUI:Notify("提示", "你需要在100号房间使用此功能", 5)
                    break
                end

                local Breaker = nil
                for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
                    if v.Name == "ElevatorBreaker" then
                        Breaker = v
                        break
                    end
                end

                if Breaker then
                    local solved = true
                    for _, v in ipairs(Breaker:GetChildren()) do
                        if v.Name == "BreakerSwitch" then
                            local codeText = Breaker:WaitForChild("SurfaceGui").Frame.Code.Text
                            if v:GetAttribute("ID") == tonumber(codeText) then
                                if Breaker.SurfaceGui.Frame.Code.Frame.BackgroundTransparency == 0 then
                                    v:SetAttribute("Enabled", true)
                                    if not v.Sound.Playing then
                                        v.Sound.Playing = true
                                    end
                                    v.Material = Enum.Material.Neon
                                    v.Light.Attachment.Spark:Emit(1)
                                    v.PrismaticConstraint.TargetPosition = -0.2
                                else
                                    v:SetAttribute("Enabled", false)
                                    if not v.Sound.Playing then
                                        v.Sound.Playing = true
                                    end
                                    v.PrismaticConstraint.TargetPosition = 0.2
                                    v.Material = Enum.Material.Glass
                                    solved = false
                                end
                            end
                        end
                    end

                    if solved and RemoteFolder then
                        local breakerRemote = RemoteFolder:FindFirstChild("BreakerMinigame")
                        if breakerRemote then
                            breakerRemote:FireServer("Solved")
                        end
                    end
                end
            end
        end
    })
    B:Toggle({
        Title = "自动隐藏[防怪物]",
        Default = false,
        Risky = true,
        Tooltip = "自动为你隐藏",
        Callback = function(Value)
            local EntityDistances = {
                RushMoving = 50,
                BackdoorRush = 50,
                AmbushMoving = 100,
                A60 = 100,
                A120 = 35,
            }
            local Rooms = workspace.CurrentRooms
            local LocalPlayer = game.Players.LocalPlayer
            local Connections = {}

            local function GetHiding()
                local Closest, Prompt
                local currRoom = Rooms and Rooms[LocalPlayer:GetAttribute("CurrentRoom")]
                if not currRoom then return nil end

                local char = LocalPlayer.Character
                if not char then return nil end

                local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Collision") or char.PrimaryPart
                if not hrp then return nil end

                local function distFromPlayer(model)
                    if not model then return math.huge end
                    local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
                    if not part then return math.huge end
                    return (part.Position - hrp.Position).Magnitude
                end

                local assets = currRoom:FindFirstChild("Assets")
                if assets then
                    for _, v in pairs(assets:GetChildren()) do
                        if v:IsA("Model") then
                            if ((v.Name == "Locker_Large") or (v.Name == "Wardrobe") or (v.Name == "Toolshed") or (v.Name == "Bed") or (v.Name == "Rooms_Locker") or (v.Name == "Rooms_Locker_Fridge") or (v.Name == "Backdoor_Wardrobe")) and v:FindFirstChild("HidePrompt") and v:FindFirstChild("HiddenPlayer") then
                                if not v.HiddenPlayer.Value and not v:FindFirstChild("HideEntityOnSpot", true) then
                                    if Closest then
                                        if distFromPlayer(v) < distFromPlayer(Closest) then
                                            Closest = v
                                            Prompt = v.HidePrompt
                                        end
                                    else
                                        Closest = v
                                        Prompt = v.HidePrompt
                                    end
                                end
                            elseif v.Name == "Double_Bed" then
                                for _, x in pairs(v:GetChildren()) do
                                    if x.Name == "DoubleBed" and x:FindFirstChild("HidePrompt") and x:FindFirstChild("HiddenPlayer") then
                                        if not x.HiddenPlayer.Value and not x:FindFirstChild("HideEntityOnSpot", true) then
                                            if Closest then
                                                if distFromPlayer(x) < distFromPlayer(Closest) then
                                                    Closest = x
                                                    Prompt = x.HidePrompt
                                                end
                                            else
                                                Closest = x
                                                Prompt = x.HidePrompt
                                            end
                                        end
                                    end
                                end
                            elseif v.Name == "Dumpster" then
                                for _, x in pairs(v:GetChildren()) do
                                    if x:FindFirstChild("HidePrompt") and x:FindFirstChild("HiddenPlayer") then
                                        local dumpsterBaseHasSpot = v:FindFirstChild("DumpsterBase") and v.DumpsterBase:FindFirstChild("HideEntityOnSpot")
                                        if not x.HiddenPlayer.Value and not dumpsterBaseHasSpot then
                                            if Closest then
                                                if distFromPlayer(x) < distFromPlayer(Closest) then
                                                    Closest = x
                                                    Prompt = x.HidePrompt
                                                end
                                            else
                                                Closest = x
                                                Prompt = x.HidePrompt
                                            end
                                        end
                                    end
                                end
                            end
                        elseif v:IsA("Folder") then
                            if v.Name == "Blockage" then
                                for _, x in pairs(v:GetChildren()) do
                                    if x:IsA("Model") and x.Name == "Wardrobe" and x:FindFirstChild("HiddenPlayer") and x:FindFirstChild("HidePrompt") then
                                        if not x.HiddenPlayer.Value then
                                            if Closest then
                                                if distFromPlayer(x) < distFromPlayer(Closest) then
                                                    Closest = x
                                                    Prompt = x.HidePrompt
                                                end
                                            else
                                                Closest = x
                                                Prompt = x.HidePrompt
                                            end
                                        end
                                    end
                                end
                            elseif v.Name == "Vents" then
                                for _, x in pairs(v:GetChildren()) do
                                    if x.Name == "CircularVent" and x:FindFirstChild("Grate") and x.Grate:FindFirstChild("HidePrompt") and x:FindFirstChild("HiddenPlayer") then
                                        if not x.HiddenPlayer.Value and not v:FindFirstChild("HideEntityOnSpot", true) then
                                            if Closest then
                                                if distFromPlayer(x) < distFromPlayer(Closest) then
                                                    Closest = x
                                                    Prompt = x.Grate.HidePrompt
                                                end
                                            else
                                                Closest = x
                                                Prompt = x.Grate.HidePrompt
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                for _, v in pairs(currRoom:GetChildren()) do
                    if v:IsA("Model") then
                        if v.Name == "CircularVent" and v:FindFirstChild("Grate") and v.Grate:FindFirstChild("HidePrompt") and v:FindFirstChild("HiddenPlayer") then
                            if not v.HiddenPlayer.Value and not v:FindFirstChild("HideEntityOnSpot", true) then
                                if Closest then
                                    if distFromPlayer(v) < distFromPlayer(Closest) then
                                        Closest = v
                                        Prompt = v.Grate.HidePrompt
                                    end
                                else
                                    Closest = v
                                    Prompt = v.Grate.HidePrompt
                                end
                            end
                        end
                    end
                end

                return Prompt
            end

            if Value then
                table.insert(Connections, workspace.ChildAdded:Connect(function(v)
                    if v:IsA("Model") and EntityDistances[v.Name] then
                        task.wait(1)
                        local Part = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart", true)
                        if not Part then return end

                        v:SetAttribute("_Prediction", Part.Position)

                        while task.wait() and v.Parent do
                            task.spawn(function()
                                local LastPosition = Part.Position
                                task.wait(0.3333333333333333)
                                if Part and Part.Parent then
                                    v:SetAttribute("_Prediction", Part.Position - LastPosition)
                                end
                            end)

                            if Value then
                                local IncludeList = {}
                                for _, Room in pairs(Rooms:GetChildren()) do
                                    if Room:FindFirstChild("Assets") then
                                        table.insert(IncludeList, Room.Assets)
                                    end
                                    if Room:FindFirstChild("Parts") then
                                        table.insert(IncludeList, Room.Parts)
                                    end
                                end

                                local RaycastParams = RaycastParams.new()
                                RaycastParams.FilterDescendantsInstances = IncludeList
                                RaycastParams.FilterType = Enum.RaycastFilterType.Include

                                local Count = {0.2, 0.4, 0.6, 0.8, 1}
                                local entityInRange = false

                                for i = 1, #Count do
                                    local Number = 1.5 * Count[i]
                                    local predAttr = v:GetAttribute("_Prediction")
                                    local Prediction = (predAttr and (predAttr * 3)) or Vector3.new(0, 0, 0)
                                    Prediction = Prediction * Number

                                    local char = LocalPlayer.Character
                                    if not char then break end

                                    local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Collision") or char.PrimaryPart
                                    if not hrp then break end

                                    if Vector3.new(Prediction.X, 0, Prediction.Z).Magnitude > 1 then
                                        local PredictionPosition = Part.Position + Prediction
                                        local Raycast
                                        if true then
                                            Raycast = workspace:Raycast(hrp.Position, PredictionPosition - hrp.Position, RaycastParams)
                                        end

                                        local distMultiplier = 1
                                        local mode = "Safety"
                                        local adjust = 0

                                        if mode == "Safety" then
                                            adjust = 20
                                        elseif mode == "Close Call" then
                                            adjust = -20
                                        end

                                        local adjustedDistance = EntityDistances[v.Name] + adjust
                                        local distanceToEntity = (PredictionPosition - hrp.Position).Magnitude

                                        if not Raycast and distanceToEntity <= (adjustedDistance * distMultiplier) then
                                            entityInRange = true
                                            local Prompt = GetHiding()
                                            if Prompt then
                                                pcall(function()
                                                    fireproximityprompt(Prompt)
                                                end)
                                            end
                                            break
                                        end
                                    end
                                end

                                local char = LocalPlayer.Character
                                if char and not entityInRange and char:GetAttribute("Hiding") then
                                    char:SetAttribute("Hiding", false)
                                end
                            end
                        end
                    end
                end))
            else
                for _, conn in ipairs(Connections) do
                    conn:Disconnect()
                end
                Connections = {}
            end
        end
    })

B:Dropdown({
        Title = "自动隐藏模式",
        Values = {"Safety", "Close Call"},
        Default = "Safety",
        Callback = function(Value) end
    })

   B:Slider({
        Title = "预测时间",
        Value = {Min = 0.1, Max = 1.5, Default = 1.5},
        Suffix = "s",
        Callback = function(Value) end
    })

    B:Slider({
        Title = "距离倍数",
        Value = {Min = 1, Max = 1.5, Default = 1},
        Suffix = "x",
        Callback = function(Value) end
    })
    local AutoInteractDistance = 10
    B:Toggle({
        Title = "自动互动",
        Default = false,
        Callback = function(Value)
            if Value then
                local RunService = game:GetService("RunService")
                local LocalPlayer = game.Players.LocalPlayer

                local AutoInteractConnection
                local CachedInteractables = {}
                local PromptSeen = {}
                local InteractableModels = {
                    AlarmClock = true, GlitchCub = true, Aloe = true, BandagePack = true, Battery = true,
                    TimerLever = true, OuterPart = true, BatteryPack = true, Candle = true, LiveBreakerPolePickup = true,
                    Compass = true, Crucifix = true, ElectricalRoomKey = true, Flashlight = true, Glowstick = true,
                    HolyHandGrenade = true, Lantern = true, LaserPointer = true, Lighter = true, Lockpick = true,
                    LotusFlower = true, LotusPetalPickup = true, Multitool = true, NVCS3000 = true, OutdoorsKey = true,
                    Shears = true, SkeletonKey = true, Smoothie = true, SolutionPaper = true, Spotlight = true,
                    StarlightVial = true, StarlightJug = true, StarlightBottle = true, Vitamins = true,
                }

                local function PickRootPart(obj, prompt)
                    if prompt and prompt.Parent and prompt.Parent:IsA("BasePart") then
                        return prompt.Parent
                    end
                    if obj:IsA("Model") then
                        if obj.PrimaryPart and obj.PrimaryPart:IsA("BasePart") then
                            return obj.PrimaryPart
                        end
                        local common = obj:FindFirstChild("Main", true) or obj:FindFirstChild("Handle", true) or obj:FindFirstChild("Door", true)
                        if common and common:IsA("BasePart") then
                            return common
                        end
                    end
                    return obj:FindFirstChildWhichIsA("BasePart", true)
                end

                local function AddPromptsFromObject(obj)
                    for _, desc in ipairs(obj:GetDescendants()) do
                        if desc:IsA("ProximityPrompt") and not PromptSeen[desc] then
                            local root = PickRootPart(obj, desc)
                            if root then
                                PromptSeen[desc] = true
                                table.insert(CachedInteractables, {
                                    prompt = desc,
                                    part = root,
                                    last = 0,
                                })
                            end
                        end
                    end
                end

                local function CollectTargets(folder)
                    for _, v in ipairs(folder:GetChildren()) do
                        if v:IsA("Model") or v:IsA("Folder") then
                            if v.Name == "DrawerContainer" or InteractableModels[v.Name] or v.Name == "RoomsLootItem" or v.Name == "Locker_Small" or v.Name == "Toolbox" or v.Name == "ChestBox" or v.Name == "Toolshed_Small" or v.Name == "CrucifixOnTheWall" then
                                AddPromptsFromObject(v)
                            end
                            CollectTargets(v)
                        end
                    end
                end

                local function RefreshTargets()
                    CachedInteractables = {}
                    PromptSeen = {}
                    local CurrentRoom = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]
                    if not CurrentRoom then return end
                    CollectTargets(CurrentRoom)
                end

                local lastCheck = 0
                local interval = 0.2

                local function AutoInteractStep(dt)
                    lastCheck = lastCheck + dt
                    if lastCheck < interval then return end
                    lastCheck = 0

                    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Collision") then
                        return
                    end

                    local charPos = LocalPlayer.Character.Collision.Position
                    local now = tick()

                    for i = #CachedInteractables, 1, -1 do
                        local entry = CachedInteractables[i]
                        local prompt, part = entry.prompt, entry.part

                        if not prompt or not prompt.Parent or not part or not part:IsDescendantOf(workspace) then
                            table.remove(CachedInteractables, i)
                        else
                            local dist = (part.Position - charPos).Magnitude
                            if dist <= AutoInteractDistance and (now - (entry.last or 0)) >= 0.35 then
                                entry.last = now
                                task.spawn(function()
                                    pcall(function()
                                        fireproximityprompt(prompt)
                                    end)
                                end)
                            end
                        end
                    end
                end

                RefreshTargets()
                AutoInteractConnection = RunService.Heartbeat:Connect(AutoInteractStep)

                local attributeConn
                local roomDescConn

                attributeConn = LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
                    RefreshTargets()
                    if roomDescConn then
                        roomDescConn:Disconnect()
                        roomDescConn = nil
                    end
                    local cr = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]
                    if cr then
                        roomDescConn = cr.DescendantAdded:Connect(function()
                            task.defer(RefreshTargets)
                        end)
                    end
                end)

                local cr = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]
                if cr then
                    roomDescConn = cr.DescendantAdded:Connect(function()
                        task.defer(RefreshTargets)
                    end)
                end

                _G.StopAutoInteract = function()
                    if AutoInteractConnection then
                        AutoInteractConnection:Disconnect()
                        AutoInteractConnection = nil
                    end
                    if attributeConn then
                        attributeConn:Disconnect()
                        attributeConn = nil
                    end
                    if roomDescConn then
                        roomDescConn:Disconnect()
                        roomDescConn = nil
                    end
                    CachedInteractables, PromptSeen = {}, {}
                end
            elseif _G.StopAutoInteract then
                _G.StopAutoInteract()
                _G.StopAutoInteract = nil
            end
        end
    })

    B:Slider({
        Title = "自动互动距离",
        Value = {Min = 1, Max = 20, Default = 10},
        Suffix = " studs",
        Callback = function(Value)
            AutoInteractDistance = Value
        end
    })
    B:Toggle({
        Title = "自动矿车推动",
        Default = false,
        Callback = function(Value)
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local LocalPlayer = Players.LocalPlayer
            local Workspace = game:GetService("Workspace")
            local Rooms = Workspace:WaitForChild("CurrentRooms")

            if _G.AutoMinecartConn then
                _G.AutoMinecartConn:Disconnect()
                _G.AutoMinecartConn = nil
            end
            if _G.AutoMinecartLoop then
                _G.AutoMinecartLoop:Disconnect()
                _G.AutoMinecartLoop = nil
            end

            if Value then
                local function tryPush(cartModel)
                    local cart = cartModel:FindFirstChild("Cart")
                    if not cart then return end
                    local prompt = cart:FindFirstChild("PushPrompt")
                    if not prompt then return end

                    local character = LocalPlayer.Character
                    local root = character and character:FindFirstChild("HumanoidRootPart")
                    if not root then return end

                    if (root.Position - prompt.Parent.Position).Magnitude <= (prompt.MaxActivationDistance or 10) then
                        fireproximityprompt(prompt)
                    end
                end

                _G.AutoMinecartConn = Rooms.DescendantAdded:Connect(function(obj)
                    if obj.Name == "MinecartMoving" then
                        task.defer(function()
                            tryPush(obj)
                        end)
                    end
                end)

                _G.AutoMinecartLoop = RunService.Heartbeat:Connect(function()
                    local character = LocalPlayer.Character
                    local root = character and character:FindFirstChild("HumanoidRootPart")
                    if not root then return end

                    for _, obj in ipairs(Rooms:GetDescendants()) do
                        if obj.Name == "MinecartMoving" then
                            tryPush(obj)
                        end
                    end
                end)
            else
                if _G.AutoMinecartConn then
                    _G.AutoMinecartConn:Disconnect()
                end
                if _G.AutoMinecartLoop then
                    _G.AutoMinecartLoop:Disconnect()
                end
                _G.AutoMinecartConn = nil
                _G.AutoMinecartLoop = nil
            end
        end
    })
    B:Toggle({
        Title = "自动拾取投掷物",
        Default = false,
        Callback = function(Value)
            local targetProps = {
                "WoodenCrate", "OilBarrel", "GarbageBag", "Trashcan", 
                "CardboardBox_Normal", "Hat_Stand", "CardboardBox_Wide", "Office_Chair"
            }
            local running = true

            if Value then
                task.spawn(function()
                    while running and Value do
                        local bigProps = workspace:FindFirstChild("BigProps")
                        if bigProps then
                            for _, name in ipairs(targetProps) do
                                local prop = bigProps:FindFirstChild(name)
                                if prop then
                                    for _, d in ipairs(prop:GetDescendants()) do
                                        if d:IsA("ProximityPrompt") then
                                            d.MaxActivationDistance = 20
                                            if d.Enabled then
                                                pcall(fireproximityprompt, d)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        task.wait(0.5)
                    end
                end)
            else
                running = false
            end
        end
    })
    B:Toggle({
        Title = "自动破门",
        Default = false,
        Callback = function(Value)
            local connections = {}
            local running = false
            local targetNames = {"DoorPieceBottom", "DoorPieceTop"}

            local function safeDisconnect()
                for _, c in ipairs(connections) do
                    if c and c.Disconnect then
                        pcall(function() c:Disconnect() end)
                    elseif c and c.disconnect then
                        pcall(function() c:disconnect() end)
                    end
                end
                connections = {}
            end

            local function handlePrompt(p)
                pcall(function() p.MaxActivationDistance = 40 end)
                if p.Enabled then
                    pcall(fireproximityprompt, p)
                end
            end

            local function processModel(m)
                for _, n in ipairs(targetNames) do
                    local part = m:FindFirstChild(n, true)
                    if part then
                        for _, d in ipairs(part:GetDescendants()) do
                            if d:IsA("ProximityPrompt") then
                                pcall(handlePrompt, d)
                            end
                        end

                        local con = part.DescendantAdded:Connect(function(desc)
                            if desc:IsA("ProximityPrompt") then
                                pcall(function() task.defer(handlePrompt, desc) end)
                            end
                        end)
                        table.insert(connections, con)
                    end
                end
            end

            local function scanAll()
                local cr = workspace:FindFirstChild("CurrentRooms")
                if not cr then return end

                for _, room in ipairs(cr:GetDescendants()) do
                    if room:IsA("Model") or room:IsA("Folder") then
                        processModel(room)
                    end
                end
            end

            if Value then
                running = true
                safeDisconnect()
                
                task.spawn(function()
                    scanAll()
                    local cr = workspace:FindFirstChild("CurrentRooms")
                    if cr then
                        local con = cr.DescendantAdded:Connect(function(d)
                            if not running then return end
                            local model = d
                            while model and not (model:IsA("Model") or model:IsA("Folder")) do
                                model = model.Parent
                            end
                            if model then
                                task.defer(processModel, model)
                            end
                        end)
                        table.insert(connections, con)
                    end

                    while running and Value do
                        scanAll()
                        task.wait(0.8)
                    end
                end)
            else
                running = false
                safeDisconnect()
            end
        end
    })
    B:Toggle({
        Title = "自动拾取",
        Default = false,
        Callback = function(Value)
            local connections = {}
            local running = false

            local function safeDisconnect()
                for _, c in ipairs(connections) do
                    if c and c.Disconnect then
                        pcall(function() c:Disconnect() end)
                    elseif c and c.disconnect then
                        pcall(function() c:disconnect() end)
                    end
                end
                connections = {}
            end

            local function handlePrompt(p)
                pcall(function() p.MaxActivationDistance = 40 end)
                if p.Enabled then
                    pcall(fireproximityprompt, p)
                end
            end

            local function processDrop(d)
                for _, desc in ipairs(d:GetDescendants()) do
                    if desc:IsA("ProximityPrompt") then
                        pcall(handlePrompt, desc)
                    end
                end

                local con = d.DescendantAdded:Connect(function(desc)
                    if desc:IsA("ProximityPrompt") then
                        pcall(function() task.defer(handlePrompt, desc) end)
                    end
                end)
                table.insert(connections, con)
            end

            local function scanDrops()
                local drops = workspace:FindFirstChild("Drops")
                if not drops then return end

                for _, child in ipairs(drops:GetChildren()) do
                    if child:IsA("Model") or child:IsA("Folder") then
                        processDrop(child)
                    end
                end
            end

            if Value then
                running = true
                safeDisconnect()
                
                task.spawn(function()
                    scanDrops()
                    local drops = workspace:FindFirstChild("Drops")
                    if drops then
                        local con = drops.ChildAdded:Connect(function(c)
                            if not running then return end
                            if c:IsA("Model") or c:IsA("Folder") then
                                task.defer(processDrop, c)
                            end
                        end)
                        table.insert(connections, con)
                    end

                    while running and Value do
                        scanDrops()
                        task.wait(0.8)
                    end
                end)
            else
                running = false
                safeDisconnect()
            end
        end
    })
    B:Toggle({
        Title = "自动开火",
        Default = false,
        Callback = function(Value)
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local LocalPlayer = Players.LocalPlayer
            local Camera = workspace.CurrentCamera
            local RAY_DISTANCE = 50
            local con = nil
            local triggered = false

            local function safeMouse1Press() pcall(mouse1press) end
            local function safeMouse1Release() pcall(mouse1release) end

            local function isTargetVisible(targetPos)
                local rayParams = RaycastParams.new()
                rayParams.FilterType = Enum.RaycastFilterType.Exclude
                rayParams.FilterDescendantsInstances = {LocalPlayer.Character}

                local origin = Camera.CFrame.Position
                local direction = targetPos - origin
                local result = workspace:Raycast(origin, direction, rayParams)

                if not result then return true end
                return (result.Instance.Position - targetPos).Magnitude < 3
            end

            local function update()
                if not LocalPlayer.Character or not Camera then
                    if triggered then
                        safeMouse1Release()
                        triggered = false
                    end
                    return
                end

                local myChar = LocalPlayer.Character
                local myHead = myChar:FindFirstChild("Head")
                if not myHead then return end

                local lookVector = Camera.CFrame.LookVector
                local origin = Camera.CFrame.Position
                local bestTarget = nil
                local bestDot = 0.995

                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local targetPos = plr.Character.HumanoidRootPart.Position
                        local dirToTarget = (targetPos - origin).Unit
                        local dot = lookVector:Dot(dirToTarget)

                        if dot > bestDot then
                            local dist = (targetPos - origin).Magnitude
                            if dist < RAY_DISTANCE and isTargetVisible(targetPos) then
                                bestDot = dot
                                bestTarget = plr
                            end
                        end
                    end
                end

                if bestTarget then
                    if not triggered then
                        WindUI:Notify("自动开火", "正在向 " .. bestTarget.Name .. " 开火", 2)
                        safeMouse1Press()
                        triggered = true
                    end
                elseif triggered then
                    safeMouse1Release()
                    triggered = false
                end
            end

            if Value then
                if con and con.Connected then
                    con:Disconnect()
                end
                con = RunService.RenderStepped:Connect(function()
                    pcall(update)
                end)
            else
                if con then
                    con:Disconnect()
                    con = nil
                end
                if triggered then
                    safeMouse1Release()
                    triggered = false
                end
            end
        end
    })
    B:Toggle({
        Title = "自动房间",
        Default = false,
        Callback = function(enabled)
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local PathfindingService = game:GetService("PathfindingService")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Workspace = game:GetService("Workspace")
            local player = Players.LocalPlayer
            local rooms = Workspace:WaitForChild("CurrentRooms")
            local gameData = ReplicatedStorage:WaitForChild("GameData")
            local floor = gameData:WaitForChild("Floor")
            local active = false
            local runner
            local clone

            local function stop()
                active = false
                if runner then
                    runner:Disconnect()
                    runner = nil
                end
                if clone and clone.Parent then
                    clone:Destroy()
                end
                player:SetAttribute("AutoRoomsActive", false)
            end

            if not enabled then
                stop()
                return
            end

            player:SetAttribute("AutoRoomsActive", true)
            active = true

            if player.Character and player.Character:FindFirstChild("CollisionPart") then
                clone = player.Character.CollisionPart:Clone()
                clone.Name = "_AutoRoomsCollision"
                clone.Massless = true
                clone.Anchored = false
                clone.CanCollide = false
                clone.CanQuery = false
                clone.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0.7, 0, 1, 1)
                clone.Parent = player.Character
            end

            local function findClosestLocker()
                local best, bestDist = nil, math.huge
                for _, obj in ipairs(rooms:GetDescendants()) do
                    if obj.Name == "Rooms_Locker" or obj.Name == "Rooms_Locker_Fridge" then
                        if obj.PrimaryPart then
                            local dist = (player.Character.HumanoidRootPart.Position - obj.PrimaryPart.Position).Magnitude
                            if dist < bestDist then
                                best = obj
                                bestDist = dist
                            end
                        end
                    end
                end
                return best
            end

            local function walkTo(target)
                local char = player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end

                local path = PathfindingService:CreatePath({
                    AgentRadius = 2,
                    AgentHeight = 1,
                    AgentCanJump = false,
                    WaypointSpacing = 5,
                })

                path:ComputeAsync(char.HumanoidRootPart.Position, target.Position)

                if path.Status == Enum.PathStatus.Success then
                    for _, waypoint in ipairs(path:GetWaypoints()) do
                        if not active then return end
                        char:FindFirstChildOfClass("Humanoid"):MoveTo(waypoint.Position)
                        char.Humanoid.MoveToFinished:Wait()
                    end
                end
            end

            runner = RunService.Heartbeat:Connect(function()
                if not active then return end
                if floor.Value ~= "Rooms" then return stop() end
                if gameData.LatestRoom.Value >= 1000 then return stop() end

                local entity = Workspace:FindFirstChild("A60") or Workspace:FindFirstChild("A120") or Workspace:FindFirstChild("GlitchRush") or Workspace:FindFirstChild("GlitchAmbush")

                if entity and entity.PrimaryPart and entity.PrimaryPart.Position.Y > -6 then
                    local locker = findClosestLocker()
                    if locker and locker.PrimaryPart then
                        local hide = locker:FindFirstChild("HidePoint")
                        if not hide then
                            hide = Instance.new("Part")
                            hide.Name = "HidePoint"
                            hide.Anchored = true
                            hide.Transparency = 1
                            hide.CanCollide = false
                            hide.Position = locker.PrimaryPart.Position + (locker.PrimaryPart.CFrame.LookVector * 7)
                            hide.Parent = locker
                        end

                        walkTo(hide)
                        task.wait(0.1)

                        local prompt = locker:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then
                            if fireproximityprompt then
                                fireproximityprompt(prompt)
                            else
                                prompt:InputHoldBegin()
                                prompt:InputHoldEnd()
                            end
                        end
                    end
                else
                    local currentRoom = gameData.LatestRoom.Value
                    local door = rooms[currentRoom] and rooms[currentRoom]:FindFirstChild("Door", true)
                    if door and door:FindFirstChild("Door") then
                        walkTo(door.Door)
                    end
                end
            end)
        end
    })

   B:Toggle({
        Title = "反AFK",
        Default = false,
        Callback = function(Value)
            local Players = game:GetService("Players")
            local VirtualUser = game:GetService("VirtualUser")
            local LocalPlayer = Players.LocalPlayer
            local AntiAFKConnection

            if Value then
                AntiAFKConnection = LocalPlayer.Idled:Connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
                WindUI:Notify("反AFK", "反AFK已启用", 3)
            elseif AntiAFKConnection then
                AntiAFKConnection:Disconnect()
                AntiAFKConnection = nil
                WindUI:Notify("反AFK", "反AFK已禁用", 3)
            end
        end
    })
    B:Toggle({
        Title = "自动门范围",
        Default = false,
        Callback = function(Value)
            local doorReachLoop

            if Value then
                local Rooms = workspace:FindFirstChild("CurrentRooms")
                if not Rooms then return end

                doorReachLoop = task.spawn(function()
                    while Value do
                        for _, room in pairs(Rooms:GetChildren()) do
                            local door = room:FindFirstChild("Door")
                            if door and door:FindFirstChild("ClientOpen") then
                                door.ClientOpen:FireServer()
                            end
                        end
                        task.wait(0.5)
                    end
                end)
                WindUI:Notify("自动门", "自动门范围已启用", 3)
            else
                doorReachLoop = nil
                WindUI:Notify("自动门", "自动门范围已禁用", 3)
            end
        end
    })
    B:Toggle({
        Title = "即时互动",
        Default = false,
        Callback = function(Value)
            if getgenv().ProximityConnection then
                getgenv().ProximityConnection:Disconnect()
                getgenv().ProximityConnection = nil
            end

            local function modifyPrompt(prompt, instant)
                if not prompt:IsA("ProximityPrompt") then return end
                if instant then
                    if not prompt:GetAttribute("OriginalHoldDuration") then
                        prompt:SetAttribute("OriginalHoldDuration", prompt.HoldDuration)
                        prompt:SetAttribute("OriginalLineOfSight", prompt.RequiresLineOfSight)
                    end
                    prompt.HoldDuration = 0
                    prompt.RequiresLineOfSight = false
                else
                    prompt.HoldDuration = prompt:GetAttribute("OriginalHoldDuration") or 1
                    prompt.RequiresLineOfSight = prompt:GetAttribute("OriginalLineOfSight") or true
                end
            end

            local currentRooms = workspace:FindFirstChild("CurrentRooms")
            if currentRooms then
                for _, prompt in ipairs(currentRooms:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") then
                        modifyPrompt(prompt, Value)
                    end
                end
            end

            if Value and currentRooms then
                getgenv().ProximityConnection = currentRooms.DescendantAdded:Connect(function(descendant)
                    if descendant:IsA("ProximityPrompt") then
                        modifyPrompt(descendant, true)
                    end
                end)
            end

            WindUI:Notify("即时互动", Value and "已启用" or "已禁用", 3)
        end
    })
    B:Slider({
        Title = "既时互动范围提升",
        Value = {Min = 1, Max = 5, Default = 1},
        Suffix = "x",
        Callback = function(multiplier)
            local originalRanges = {}
            local rangeConnections = {}

            local function updateProximityPromptRanges(multiplier)
                local function modifyPrompt(prompt)
                    if not originalRanges[prompt] then
                        originalRanges[prompt] = prompt.MaxActivationDistance
                    end
                    prompt.MaxActivationDistance = originalRanges[prompt] * multiplier
                end

                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant:IsA("ProximityPrompt") then
                        modifyPrompt(descendant)
                    end
                end
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.PlayerGui then
                        for _, descendant in pairs(player.PlayerGui:GetDescendants()) do
                            if descendant:IsA("ProximityPrompt") then
                                modifyPrompt(descendant)
                            end
                        end
                    end
                end
            end

            local function setupRangeConnections(multiplier)
                for _, connection in pairs(rangeConnections) do
                    connection:Disconnect()
                end
                rangeConnections = {}

                table.insert(rangeConnections, workspace.DescendantAdded:Connect(function(descendant)
                    if descendant:IsA("ProximityPrompt") then
                        task.wait(0.1)
                        originalRanges[descendant] = descendant.MaxActivationDistance
                        descendant.MaxActivationDistance = originalRanges[descendant] * multiplier
                    end
                end))

                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.PlayerGui then
                        table.insert(rangeConnections, player.PlayerGui.DescendantAdded:Connect(function(descendant)
                            if descendant:IsA("ProximityPrompt") then
                                task.wait(0.1)
                                originalRanges[descendant] = descendant.MaxActivationDistance
                                descendant.MaxActivationDistance = originalRanges[descendant] * multiplier
                            end
                        end))
                    end
                end
            end

            if multiplier == 1 then
                for prompt, originalRange in pairs(originalRanges) do
                    if prompt and prompt.Parent then
                        prompt.MaxActivationDistance = originalRange
                    end
                end
                for _, connection in pairs(rangeConnections) do
                    connection:Disconnect()
                end
                rangeConnections = {}
            else
                updateProximityPromptRanges(multiplier)
                setupRangeConnections(multiplier)
            end

            WindUI:Notify("互动范围", "已设置为 " .. multiplier .. "x", 3)
        end
    })
    local A = Window:Tab({Title = "规避类", Icon = "shield"})
    A:Toggle({
        Title = "规避Screech",
        Default = false,
        Callback = function(on)
            if on then
                for _, inst in ipairs(workspace:GetDescendants()) do
                    if inst.Name == "Screech" then
                        pcall(function()
                            inst:Destroy()
                        end)
                    end
                end

                getgenv().AntiScreechConn = workspace.DescendantAdded:Connect(function(inst)
                    if inst.Name == "Screech" then
                        task.defer(function()
                            if inst and inst.Parent then
                                pcall(function()
                                    inst:Destroy()
                                end)
                            end
                        end)
                    end
                end)
            elseif getgenv().AntiScreechConn then
                getgenv().AntiScreechConn:Disconnect()
                getgenv().AntiScreechConn = nil
            end
        end
    })

    A:Toggle({
        Title = "规避Gloom蛋",
        Default = false,
        Callback = function(Value)
            if getgenv().AntiGloomConn then
                getgenv().AntiGloomConn:Disconnect()
                getgenv().AntiGloomConn = nil
            end

            local rooms = workspace:WaitForChild("CurrentRooms")

            if Value then
                for _, v in ipairs(rooms:GetDescendants()) do
                    if v.Name == "GloomEgg" then
                        local egg = v:FindFirstChild("Egg")
                        if egg then
                            egg.CanTouch = false
                        end
                    end
                end

                getgenv().AntiGloomConn = rooms.DescendantAdded:Connect(function(v)
                    if v.Name == "GloomEgg" then
                        local egg = v:WaitForChild("Egg", 8999999488)
                        egg.CanTouch = false
                    elseif v.Name == "Egg" and v.Parent and v.Parent.Name == "GloomEgg" then
                        v.CanTouch = false
                    end
                end)
            else
                for _, v in ipairs(rooms:GetDescendants()) do
                    if v.Name == "GloomEgg" then
                        local egg = v:FindFirstChild("Egg")
                        if egg then
                            egg.CanTouch = true
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Dread",
        Default = false,
        Callback = function(isEnabled)
            local player = game:GetService("Players").LocalPlayer
            local modules = player.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules
            local dreadModule = modules:FindFirstChild("Dread") or modules:FindFirstChild("_Dread")

            if dreadModule then
                dreadModule.Name = isEnabled and "_Dread" or "Dread"
            end
        end
    })

    A:Toggle({
        Title = "规避Giggle",
        Default = false,
        Callback = function(Value)
            if getgenv().AntiGiggleConn then
                getgenv().AntiGiggleConn:Disconnect()
                getgenv().AntiGiggleConn = nil
            end

            local rooms = workspace:WaitForChild("CurrentRooms")

            if Value then
                for _, v in ipairs(rooms:GetDescendants()) do
                    if v.Name == "GiggleCeiling" then
                        local hitbox = v:FindFirstChild("Hitbox")
                        if hitbox then
                            hitbox.CanTouch = false
                        end
                    end
                end

                getgenv().AntiGiggleConn = rooms.DescendantAdded:Connect(function(v)
                    if v.Name == "GiggleCeiling" then
                        local hitbox = v:WaitForChild("Hitbox", 8999999488)
                        hitbox.CanTouch = false
                    elseif v.Name == "Hitbox" and v.Parent and v.Parent.Name == "GiggleCeiling" then
                        v.CanTouch = false
                    end
                end)
            else
                for _, v in ipairs(rooms:GetDescendants()) do
                    if v.Name == "GiggleCeiling" then
                        local hitbox = v:FindFirstChild("Hitbox")
                        if hitbox then
                            hitbox.CanTouch = true
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Figure听觉",
        Default = false,
        Tooltip = "让游戏认为你在蹲下",
        Callback = function(Value)
            local crouchConnection
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local RunService = game:GetService("RunService")

            if crouchConnection then
                crouchConnection:Disconnect()
                crouchConnection = nil
            end

            if Value then
                crouchConnection = RunService.Heartbeat:Connect(function()
                    ReplicatedStorage.RemotesFolder.Crouch:FireServer(true)
                end)
            else
                ReplicatedStorage.RemotesFolder.Crouch:FireServer(false)
            end
        end
    })

    A:Toggle({
        Title = "规避Surge",
        Default = false,
        Callback = function(Value)
            if Value then
                local surgeClient = game.ReplicatedStorage:WaitForChild("FloorReplicated"):WaitForChild("ClientRemote"):FindFirstChild("SurgeClient")
                if surgeClient then
                    surgeClient:Destroy()
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Halt",
        Default = false,
        Callback = function(Value)
            local entityModules = game:GetService("ReplicatedStorage"):WaitForChild("ModulesClient"):WaitForChild("EntityModules")

            if Value then
                local shade = entityModules:FindFirstChild("Shade")
                if shade and shade:IsA("ModuleScript") then
                    shade.Name = "_Shade"
                end
            else
                local shade = entityModules:FindFirstChild("_Shade")
                if shade and shade:IsA("ModuleScript") then
                    shade.Name = "Shade"
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Lookman",
        Default = false,
        Callback = function(Value)
            if Value then
                if workspace:FindFirstChild("BackdoorLookman") then
                    game.ReplicatedStorage.RemotesFolder.MotorReplication:FireServer(-890)
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Snare",
        Default = false,
        Callback = function(Value)
            local currentRooms = workspace:WaitForChild("CurrentRooms")

            local function handleSnare(snare)
                if snare.Name == "Snare" then
                    local hitbox = snare:FindFirstChild("Hitbox")
                    if hitbox then
                        hitbox.CanTouch = not Value
                    else
                        snare.ChildAdded:Connect(function(child)
                            if child.Name == "Hitbox" then
                                child.CanTouch = not Value
                            end
                        end)
                    end
                end
            end

            for _, v in ipairs(currentRooms:GetDescendants()) do
                handleSnare(v)
            end

            currentRooms.DescendantAdded:Connect(handleSnare)
        end
    })

    A:Toggle({
        Title = "规避Seek障碍物",
        Default = false,
        Callback = function(Value)
            local Rooms = workspace.CurrentRooms

            if Value then
                getgenv().AntiSeekObstaclesConn = Rooms.DescendantAdded:Connect(function(desc)
                    if desc.Name == "Seek_Arm" then
                        desc:WaitForChild("AnimatorPart", 8999999488)
                        desc.AnimatorPart.CanTouch = false
                        desc.AnimatorPart.Transparency = 1

                        for _, part in desc:GetDescendants() do
                            if part:IsA("BasePart") then
                                part.Transparency = 1
                            end
                        end
                    elseif desc.Name == "ChandelierObstruction" then
                        desc:WaitForChild("HurtPart", 8999999488)
                        desc.HurtPart.CanTouch = false
                        desc.HurtPart.Transparency = 1

                        for _, part in desc:GetDescendants() do
                            if part:IsA("BasePart") then
                                part.Transparency = 1
                            end
                        end
                    end
                end)

                for _, v in Rooms:GetDescendants() do
                    if v.Name == "Seek_Arm" and v:IsA("Model") then
                        v:WaitForChild("AnimatorPart", 8999999488)
                        v.AnimatorPart.CanTouch = false
                        v.AnimatorPart.Transparency = 1

                        for _, part in v:GetDescendants() do
                            if part:IsA("BasePart") then
                                part.Transparency = 1
                            end
                        end
                    elseif v.Name == "ChandelierObstruction" and v:IsA("Model") then
                        v:WaitForChild("HurtPart", 8999999488)
                        v.HurtPart.CanTouch = false
                        v.HurtPart.Transparency = 1

                        for _, part in v:GetDescendants() do
                            if part:IsA("BasePart") then
                                part.Transparency = 1
                            end
                        end
                    end
                end
            else
                if getgenv().AntiSeekObstaclesConn then
                    getgenv().AntiSeekObstaclesConn:Disconnect()
                end

                for _, v in Rooms:GetDescendants() do
                    if v.Name == "Seek_Arm" and v:IsA("Model") then
                        v:WaitForChild("AnimatorPart", 8999999488)
                        v.AnimatorPart.CanTouch = true
                        v.AnimatorPart.Transparency = 0

                        for _, part in v:GetDescendants() do
                            if part:IsA("BasePart") then
                                part.Transparency = 0
                            end
                        end
                    elseif v.Name == "ChandelierObstruction" and v:IsA("Model") then
                        v:WaitForChild("HurtPart", 8999999488)
                        v.HurtPart.CanTouch = true
                        v.HurtPart.Transparency = 0

                        for _, part in v:GetDescendants() do
                            if part:IsA("BasePart") then
                                part.Transparency = 0
                            end
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Dupe门",
        Default = false,
        Callback = function(Value)
            for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
                if v.Name == "DoorFake" then
                    v:WaitForChild("Hidden").CanTouch = not Value

                    local lock = v:FindFirstChild("Lock")
                    if lock then
                        local prompt = lock:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then
                            prompt.ClickablePrompt = not Value
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = "规避真空区域",
        Default = false,
        Callback = function(Value)
            for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
                if v.Name == "SideroomSpace" then
                    for _, part in ipairs(v:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanTouch = not Value
                            part.CanCollide = Value
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Eyes",
        Default = false,
        Tooltip = "当Eyes出现时自动向下看以防止伤害",
        Callback = function(Value)
            local LocalPlayer = game.Players.LocalPlayer
            local Connections = {}

            if Value then
                Connections.AntiEyes = game:GetService("RunService").RenderStepped:Connect(function()
                    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        return
                    end
                    if not LocalPlayer.Character:GetAttribute("Hiding") then
                        for _, v in pairs(workspace:GetChildren()) do
                            if v.Name == "Eyes" and v:FindFirstChild("Core") and v.Core:FindFirstChild("Ambience") and v.Core.Ambience.Playing then
                                game.ReplicatedStorage.RemotesFolder.MotorReplication:FireServer(-650)
                                break
                            end
                        end
                    end
                end)
            elseif Connections.AntiEyes then
                Connections.AntiEyes:Disconnect()
                Connections.AntiEyes = nil
            end
        end
    })

    A:Toggle({
        Title = "规避A-90",
        Default = false,
        Tooltip = "移除A90",
        Callback = function(ad)
            local LocalPlayer = game.Players.LocalPlayer
            local modules = LocalPlayer.PlayerGui:FindFirstChild("MainUI") and 
                           LocalPlayer.PlayerGui.MainUI:FindFirstChild("Initiator") and 
                           LocalPlayer.PlayerGui.MainUI.Initiator:FindFirstChild("Main_Game") and 
                           LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game:FindFirstChild("RemoteListener") and 
                           LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener:FindFirstChild("Modules")
            local c3 = modules and (modules:FindFirstChild("A90") or modules:FindFirstChild("_A90"))

            if c3 then
                c3.Name = ad and "_A90" or "A90"
            end

            local remote = (game:GetService("ReplicatedStorage"):FindFirstChild("RemotesFolder") and 
                           game:GetService("ReplicatedStorage").RemotesFolder:FindFirstChild("A90")) or 
                           game:GetService("ReplicatedStorage").RemotesFolder:FindFirstChild("_A90")

            if remote then
                remote.Name = ad and "_A90" or "A90"
            end
        end
    })
    A:Toggle({
        Title = "规避虚空效果",
        Default = false,
        Callback = function(Value)
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local entityModules = ReplicatedStorage:FindFirstChild("ModulesClient") and 
                                 ReplicatedStorage.ModulesClient:FindFirstChild("EntityModules")

            if not entityModules then
                return
            end

            local voidModule = entityModules:FindFirstChild("Void") or entityModules:FindFirstChild("_Void")

            if not voidModule then
                return
            end

            if Value then
                if voidModule.Name == "Void" then
                    voidModule.Name = "_Void"
                end
            elseif voidModule.Name == "_Void" then
                voidModule.Name = "Void"
            end
        end
    })

    A:Toggle({
        Title = "规避Haste效果",
        Default = false,
        Callback = function(Value)
            if game.ReplicatedStorage.FloorReplicated.ClientRemote:FindFirstChild("Haste") then
                local HasteChanged = game.ReplicatedStorage.FloorReplicated.ClientRemote.Haste.Ambience:GetPropertyChangedSignal("Playing"):Connect(function()
                    if Value then
                        game.ReplicatedStorage.FloorReplicated.ClientRemote.Haste.Ambience.Playing = false
                    end
                end)
            end

            for _, v in workspace.CurrentCamera:GetChildren() do
                if v.Name == "LiveSanity" and workspace:FindFirstChild("EntityModel") then
                    v.Enabled = not Value
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Firedamp",
        Default = false,
        Callback = function(Value)
            local camera = workspace:WaitForChild("Camera")
            local targets = {
                LiveSantity = true,
                LiveFiredamp = true,
            }

            local function checkAndDelete(obj)
                if targets[obj.Name] then
                    obj:Destroy()
                end
            end

            if getgenv().AntiFiredampConnection then
                getgenv().AntiFiredampConnection:Disconnect()
                getgenv().AntiFiredampConnection = nil
            end

            if Value then
                for _, child in ipairs(camera:GetChildren()) do
                    checkAndDelete(child)
                end

                getgenv().AntiFiredampConnection = camera.ChildAdded:Connect(function(child)
                    checkAndDelete(child)
                end)
            end
        end
    })

    A:Toggle({
        Title = "规避矿井氛围",
        Default = false,
        Callback = function(Value)
            local Lighting = game:GetService("Lighting")
            if Value then
                local caveAtmosphere = Lighting:FindFirstChild("CaveAtmosphere")
                if caveAtmosphere then
                    caveAtmosphere:Destroy()
                end

                local caves = Lighting:FindFirstChild("Caves")
                if caves then
                    caves:Destroy()
                end
            end
        end
    })

    A:Toggle({
        Title = "规避氧气/理智效果",
        Default = false,
        Callback = function(Value)
            local Lighting = game:GetService("Lighting")
            if Value then
                local sanity = Lighting:FindFirstChild("Sanity")
                if sanity then
                    sanity:Destroy()
                end

                local oxygenCC = Lighting:FindFirstChild("OxygenCC")
                if oxygenCC then
                    oxygenCC:Destroy()
                end

                local oxygenBlur = Lighting:FindFirstChild("OxygenBlur")
                if oxygenBlur then
                    oxygenBlur:Destroy()
                end
            end
        end
    })

    A:Toggle({
        Title = "无雾效果",
        Default = false,
        Callback = function(Value)
            local lighting = game:GetService("Lighting")
            local cave = lighting:FindFirstChild("CaveAtmosphere")

            if Value then
                if cave and cave:IsA("Atmosphere") then
                    cave.Density = 0
                else
                    lighting.FogStart = 1000000
                    lighting.FogEnd = 1000000
                end
            elseif cave and cave:IsA("Atmosphere") then
                cave.Density = 0.15
            else
                lighting.FogStart = 150
                lighting.FogEnd = 150
            end
        end
    })

    A:Toggle({
        Title = "无相机抖动",
        Default = false,
        Callback = function(Value)
            local RequiredMainGame = require(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Initiator"):WaitForChild("Main_Game"))
            
            task.spawn(function()
                while Value and RequiredMainGame do
                    task.wait()
                    if typeof(RequiredMainGame.csgo) == "CFrame" then
                        RequiredMainGame.csgo = CFrame.new()
                    end
                end
            end)
        end
    })

    A:Toggle({
        Title = "无头部晃动",
        Default = false,
        Callback = function(Value)
            local RunService = game:GetService("RunService")
            local RequiredMainGame = require(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Initiator"):WaitForChild("Main_Game"))

            if Value then
                if not getgenv().HeadBobDisabler then
                    getgenv().HeadBobDisabler = RunService.RenderStepped:Connect(function()
                        if RequiredMainGame and RequiredMainGame.spring then
                            if typeof(RequiredMainGame.spring.Target) == "Vector3" then
                                RequiredMainGame.spring.Target = Vector3.zero
                                RequiredMainGame.spring.Position = Vector3.zero
                            end
                        end
                    end)
                end
            elseif getgenv().HeadBobDisabler then
                getgenv().HeadBobDisabler:Disconnect()
                getgenv().HeadBobDisabler = nil
            end
        end
    })
    A:Toggle({
        Title = "无过场动画",
        Default = false,
        Callback = function(Value)
            local player = game:GetService("Players").LocalPlayer
            local RemoteListener = player.PlayerGui.MainUI.Initiator.Main_Game:WaitForChild("RemoteListener")
            local CutScenes = RemoteListener:FindFirstChild("Cutscenes") or RemoteListener:FindFirstChild("_Cutscenes")

            if not CutScenes then
                CutScenes = RemoteListener:WaitForChild("Cutscenes", 3) or RemoteListener:WaitForChild("_Cutscenes", 3)
            end

            if CutScenes then
                CutScenes.Name = Value and "_Cutscenes" or "Cutscenes"
            end
        end
    })

    A:Toggle({
        Title = "规避隐藏边缘",
        Default = false,
        Tooltip = "移除隐藏时的黑暗边缘",
        Callback = function(Value)
            local LocalPlayer = game.Players.LocalPlayer
            LocalPlayer.PlayerGui.MainUI.MainFrame.HideVignette.Image = Value and "rbxassetid://0" or "rbxassetid://6100076320"
        end
    })

   A:Toggle({
        Title = "防卡顿",
        Default = false,
        Callback = function(Value)
            local Modifiers = workspace:FindFirstChild("Modifiers")
            if Modifiers and not Modifiers:FindFirstChild("Jammin") then
                return
            end

            local mainTrack = game["SoundService"]:FindFirstChild("Main")
            if mainTrack then
                local jamming = mainTrack:FindFirstChild("Jamming")
                if jamming then
                    jamming.Enabled = not Value
                end
            end

            local mainUI = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("MainUI")
            if mainUI then
                local healthGui = mainUI:FindFirstChild("Initiator") and 
                                 mainUI.Initiator:FindFirstChild("Main_Game") and 
                                 mainUI.Initiator.Main_Game:FindFirstChild("Health")
                if healthGui then
                    local jamSound = healthGui:FindFirstChild("Jam")
                    if jamSound then
                        jamSound.Playing = not Value
                    end
                end
            end
        end
    })
    A:Toggle({
        Title = "防香蕉皮",
        Default = false,
        Callback = function(Value)
            local currentRooms = workspace:WaitForChild("CurrentRooms")
            
            if getgenv().antiBananaConn then
                getgenv().antiBananaConn:Disconnect()
                getgenv().antiBananaConn = nil
            end

            for _, v in pairs(currentRooms:GetDescendants()) do
                if v.Name == "BananaPeel" and v:IsA("BasePart") then
                    v.CanTouch = not Value
                end
            end

            if Value then
                getgenv().antiBananaConn = currentRooms.DescendantAdded:Connect(function(v)
                    if v.Name == "BananaPeel" and v:IsA("BasePart") then
                        v.CanTouch = false
                    end
                end)
            end
        end
    })

    A:Toggle({
        Title = "防Jeff杀手",
        Default = false,
        Callback = function(Value)
            local currentRooms = workspace:WaitForChild("CurrentRooms")
            
            if getgenv().antiJeffConn then
                getgenv().antiJeffConn:Disconnect()
                getgenv().antiJeffConn = nil
            end

            for _, model in pairs(currentRooms:GetDescendants()) do
                if model.Name == "JeffTheKiller" and model:IsA("Model") then
                    for _, part in ipairs(model:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanTouch = not Value
                        end
                    end
                end
            end

            if Value then
                getgenv().antiJeffConn = currentRooms.DescendantAdded:Connect(function(v)
                    if v.Name == "JeffTheKiller" and v:IsA("Model") then
                        for _, part in ipairs(v:GetChildren()) do
                            if part:IsA("BasePart") then
                                part.CanTouch = false
                            end
                        end
                    end
                end)
            end
        end
    })
    local ESPTab = Window:Tab({Title = "透视功能", Icon = "eye"})
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/mstudio45/MSESP/refs/heads/main/source.luau"))()
ESPLibrary.GlobalConfig.Distance = false
local ColorConfig = {
    ["红色"] = Color3.fromRGB(255, 0, 0),
    ["绿色"] = Color3.fromRGB(0, 255, 0),
    ["蓝色"] = Color3.fromRGB(0, 0, 255),
    ["黄色"] = Color3.fromRGB(255, 255, 0),
    ["紫色"] = Color3.fromRGB(255, 0, 255),
    ["青色"] = Color3.fromRGB(0, 255, 255),
    ["粉色"] = Color3.fromRGB(255, 182, 193),
    ["橙色"] = Color3.fromRGB(255, 165, 0),
    ["白色"] = Color3.fromRGB(255, 255, 255),
    ["彩虹动态"] = Color3.fromRGB(255, 0, 0)
}
local ESPGroup = ESPTab:Section({Title = "ESP设置[展开]", Side = "Left"})

ESPGroup:Toggle({
    Title = "启用追踪线",
    Default = false,
    Callback = function(Value)
        _G.EnableTracers = Value
        UpdateAllESP()
    end
})

ESPGroup:Toggle({
    Title = "启用方向箭头", 
    Default = false,
    Callback = function(Value)
        _G.EnableArrows = Value
        UpdateAllESP()
    end
})

ESPGroup:Dropdown({
    Title = "ESP类型",
    Values = {"高亮", "文字", "选择框"},
    Default = "高亮",
    Callback = function(Value)
        local espTypes = {
            ["高亮"] = "Highlight",
            ["文字"] = "Text", 
            ["选择框"] = "SelectionBox"
        }
        _G.ESPType = espTypes[Value]
        UpdateAllESP()
    end
})

local ObjectESPGroup = ESPTab:Section({Title = "物体透视[展开]", Side = "Left"})

local ObjectESPConfig = {
    {
        Name = "DoorESP",
        Title = "门透视",
        DefaultColor = "白色",
        Models = {"Door"},
        DisplayName = "门"
    },
    {
        Name = "ObjectiveESP", 
        Title = "目标物品透视",
        DefaultColor = "黄色",
        Models = {"KeyObtain", "FuseObtain", "LiveBreakerPolePickup"},
        DisplayName = "目标物品"
    },
    {
        Name = "CoinESP",
        Title = "金币透视",
        DefaultColor = "白色", 
        Models = {"GoldPile"},
        DisplayName = "金币"
    },
    {
        Name = "MinesGeneratorESP",
        Title = "矿洞发电机透视",
        DefaultColor = "青色",
        Models = {"MinesGenerator"},
        DisplayName = "发电机"
    },
    {
        Name = "LeverESP",
        Title = "杠杆透视",
        DefaultColor = "橙色",
        Models = {"LeverForGate"},
        DisplayName = "杠杆"
    },
    {
        Name = "ItemESP",
        Title = "所有物品透视", 
        DefaultColor = "黄色",
        Models = {
            "AlarmClock", "Aloe", "BandagePack", "Battery", "BatteryPack", "Candle",
            "Compass", "Crucifix", "Flashlight", "Glowstick", "HolyHandGrenade",
            "Lantern", "LaserPointer", "Lighter", "Lockpick", "LotusFlower", 
            "Multitool", "NVCS3000", "Shears", "SkeletonKey", "Smoothie", "Vitamins"
        },
        DisplayName = "物品"
    },
    {
        Name = "ClosetESP",
        Title = "柜子透视",
        DefaultColor = "粉色",
        Models = {"Wardrobe", "Toolshed", "Locker_Large", "Backdoor_Wardrobe"},
        DisplayName = "柜子"
    },
    {
        Name = "AnchorESP",
        Title = "锚点透视",
        DefaultColor = "粉色",
        Models = {"MinesAnchor"},
        DisplayName = "锚点"
    },
    {
        Name = "LibraryBookESP",
        Title = "图书馆书籍透视",
        DefaultColor = "青色", 
        Models = {"LiveHintBook"},
        DisplayName = "书籍"
    },
    {
        Name = "ChestESP",
        Title = "宝箱透视",
        DefaultColor = "绿色",
        Models = {"ChestBox", "ChestBoxLocked"},
        DisplayName = "宝箱"
    }
}

local EntityESPConfig = {
    {
        Name = "SeekESP",
        Title = "追逐者透视", 
        DefaultColor = "红色",
        Models = {"SeekMoving"},
        DisplayName = "追逐者"
    },
    {
        Name = "FigureESP",
        Title = "雕像透视",
        DefaultColor = "白色",
        Models = {"FigureRig"},
        DisplayName = "雕像"
    },
    {
        Name = "AmbushESP",
        Title = "伏击透视",
        DefaultColor = "白色",
        Models = {"AmbushMoving"},
        DisplayName = "伏击"
    },
    {
        Name = "RushESP", 
        Title = "冲刺透视",
        DefaultColor = "白色",
        Models = {"RushMoving"},
        DisplayName = "冲刺"
    },
    {
        Name = "SnareESP",
        Title = "陷阱透视",
        DefaultColor = "白色",
        Models = {"Snare"},
        DisplayName = "陷阱"
    },
    {
        Name = "GiggleESP",
        Title = "傻笑透视",
        DefaultColor = "白色",
        Models = {"GiggleCeiling"},
        DisplayName = "傻笑"
    },
    {
        Name = "EyestalkESP",
        Title = "眼柄透视",
        DefaultColor = "白色", 
        Models = {"EyestalkMoving"},
        DisplayName = "眼柄"
    },
    {
        Name = "MandrakeESP",
        Title = "曼德拉草透视",
        DefaultColor = "白色",
        Models = {"Mandrake"},
        DisplayName = "曼德拉草"
    },
    {
        Name = "GroundskeeperESP",
        Title = "园丁透视",
        DefaultColor = "白色",
        Models = {"Groundskeeper"},
        DisplayName = "园丁"
    },
    {
        Name = "BlitzESP",
        Title = "闪电透视",
        DefaultColor = "白色",
        Models = {"BackdoorRush"},
        DisplayName = "闪电"
    }
}

for _, config in ipairs(ObjectESPConfig) do
    ObjectESPGroup:Toggle({
        Title = config.Title,
        Default = false,
        Callback = function(Value)
            CreateESP(config.Name, Value, config.Models, config.DisplayName, _G[config.Name .. "_Color"])
        end
    })
    
    ObjectESPGroup:Dropdown({
        Title = config.Title .. "颜色",
        Values = {"红色", "绿色", "蓝色", "黄色", "紫色", "青色", "粉色", "橙色", "白色", "彩虹动态"},
        Default = config.DefaultColor,
        Callback = function(Value)
            _G[config.Name .. "_Color"] = ColorConfig[Value]
            if _G[config.Name .. "_Enabled"] then
                CreateESP(config.Name, true, config.Models, config.DisplayName, _G[config.Name .. "_Color"])
            end
        end
    })
end
local EntityESPGroup = ESPTab:Section({Title = "实体透视[展开]", Side = "Right"})
for _, config in ipairs(EntityESPConfig) do
    EntityESPGroup:Toggle({
        Title = config.Title,
        Default = false,
        Callback = function(Value)
            CreateESP(config.Name, Value, config.Models, config.DisplayName, _G[config.Name .. "_Color"])
        end
    })
    
    EntityESPGroup:Dropdown({
        Title = config.Title .. "颜色",
        Values = {"红色", "绿色", "蓝色", "黄色", "紫色", "青色", "粉色", "橙色", "白色", "彩虹动态"},
        Default = config.DefaultColor,
        Callback = function(Value)
            _G[config.Name .. "_Color"] = ColorConfig[Value]
            if _G[config.Name .. "_Enabled"] then
                CreateESP(config.Name, true, config.Models, config.DisplayName, _G[config.Name .. "_Color"])
            end
        end
    })
end
local ESPData = {}
local RainbowConnection
function CreateESP(espName, enabled, targetModels, displayName, color)
    if not enabled then
     
        if ESPData[espName] then
            for _, element in pairs(ESPData[espName].Elements) do
                if element and element.Destroy then
                    element:Destroy()
                end
            end
            
            if ESPData[espName].Connections then
                for _, conn in pairs(ESPData[espName].Connections) do
                    if conn then conn:Disconnect() end
                end
            end
            
            ESPData[espName] = nil
        end
        _G[espName .. "_Enabled"] = false
        return
    end
    
  
    _G[espName .. "_Enabled"] = true
    
    if not ESPData[espName] then
        ESPData[espName] = {
            Elements = {},
            Connections = {},
            Models = targetModels,
            DisplayName = displayName,
            Color = color or Color3.fromRGB(255, 255, 255)
        }
    else
       
        for _, element in pairs(ESPData[espName].Elements) do
            if element and element.Destroy then
                element:Destroy()
            end
        end
        ESPData[espName].Elements = {}
    end
    
    ESPData[espName].Color = color or ESPData[espName].Color
    
    local function AddESPToObject(obj)
        if not obj:IsA("Model") then return end
        
        local isValid = false
        for _, modelName in ipairs(targetModels) do
            if obj.Name == modelName then
                isValid = true
                break
            end
        end
        
        if not isValid then return end
        
        local targetPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
        if not targetPart then return end
        
     
        for _, existingElement in pairs(ESPData[espName].Elements) do
            if existingElement.Object == obj then
                return
            end
        end
        
        local espSettings = {
            Name = displayName,
            Model = targetPart,
            Color = ESPData[espName].Color,
            MaxDistance = 1000,
            TextSize = 14,
            ESPType = _G.ESPType or "Highlight",
            FillColor = ESPData[espName].Color,
            OutlineColor = ESPData[espName].Color,
            FillTransparency = 0.7,
            OutlineTransparency = 0,
            Tracer = {
                Enabled = _G.EnableTracers or false,
                Color = ESPData[espName].Color,
                From = "Bottom",
            },
            Arrow = {
                Enabled = _G.EnableArrows or false,
                Color = ESPData[espName].Color,
            },
        }
        
        local espElement = ESPLibrary:Add(espSettings)
        
        table.insert(ESPData[espName].Elements, {
            Object = obj,
            Element = espElement,
            Part = targetPart
        })
    end
    
   
    for _, obj in ipairs(workspace:GetDescendants()) do
        AddESPToObject(obj)
    end
    
   
    local addedConn = workspace.DescendantAdded:Connect(function(obj)
        if _G[espName .. "_Enabled"] then
            AddESPToObject(obj)
        end
    end)
    local removingConn = workspace.DescendantRemoving:Connect(function(obj)
        if not _G[espName .. "_Enabled"] then return end
        
        for i, elementData in ipairs(ESPData[espName].Elements) do
            if elementData.Object == obj then
                if elementData.Element and elementData.Element.Destroy then
                    elementData.Element:Destroy()
                end
                table.remove(ESPData[espName].Elements, i)
                break
            end
        end
    end)
    
 
    local updateConn = game:GetService("RunService").Heartbeat:Connect(function()
        if not _G[espName .. "_Enabled"] then
            updateConn:Disconnect()
            return
        end
        
        local player = game.Players.LocalPlayer
        local character = player and player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if not rootPart then return end
        
      
        local currentColor = ESPData[espName].Color
        if ESPData[espName].Color == ColorConfig["彩虹动态"] then
            local time = tick()
            local r = math.sin(time * 2) * 0.5 + 0.5
            local g = math.sin(time * 2 + 2) * 0.5 + 0.5  
            local b = math.sin(time * 2 + 4) * 0.5 + 0.5
            currentColor = Color3.new(r, g, b)
        end
        
        for i, elementData in ipairs(ESPData[espName].Elements) do
            if elementData.Object and elementData.Object.Parent and elementData.Part and elementData.Part.Parent then
                if elementData.Element then
                    local distance = (rootPart.Position - elementData.Part.Position).Magnitude
                    elementData.Element.CurrentSettings.Name = string.format("%s\n%d单位", displayName, math.floor(distance))
                    
                 
                    elementData.Element.CurrentSettings.Color = currentColor
                    elementData.Element.CurrentSettings.FillColor = currentColor
                    elementData.Element.CurrentSettings.OutlineColor = currentColor
                    elementData.Element.CurrentSettings.Tracer.Color = currentColor
                    elementData.Element.CurrentSettings.Arrow.Color = currentColor
                    
                 
                    elementData.Element.CurrentSettings.Tracer.Enabled = _G.EnableTracers or false
                    elementData.Element.CurrentSettings.Arrow.Enabled = _G.EnableArrows or false
                    elementData.Element.CurrentSettings.ESPType = _G.ESPType or "Highlight"
                end
            else
              
                if elementData.Element and elementData.Element.Destroy then
                    elementData.Element:Destroy()
                end
                table.remove(ESPData[espName].Elements, i)
            end
        end
    end)
    
    table.insert(ESPData[espName].Connections, addedConn)
    table.insert(ESPData[espName].Connections, removingConn) 
    table.insert(ESPData[espName].Connections, updateConn)
end
function UpdateAllESP()
    for espName, data in pairs(ESPData) do
        if _G[espName .. "_Enabled"] then
            CreateESP(espName, true, data.Models, data.DisplayName, data.Color)
        end
    end
end
for _, config in ipairs(ObjectESPConfig) do
    _G[config.Name .. "_Color"] = ColorConfig[config.DefaultColor]
end

for _, config in ipairs(EntityESPConfig) do
    _G[config.Name .. "_Color"] = ColorConfig[config.DefaultColor]
end
local function StartRainbowEffect()
    if RainbowConnection then RainbowConnection:Disconnect() end
    
    RainbowConnection = game:GetService("RunService").Heartbeat:Connect(function()
        local time = tick()
        local r = math.sin(time * 2) * 0.5 + 0.5
        local g = math.sin(time * 2 + 2) * 0.5 + 0.5
        local b = math.sin(time * 2 + 4) * 0.5 + 0.5
        
        ColorConfig["彩虹动态"] = Color3.new(r, g, b)
        for espName, data in pairs(ESPData) do
            if data.Color == ColorConfig["彩虹动态"] and _G[espName .. "_Enabled"] then
                data.Color = ColorConfig["彩虹动态"]
            end
        end
    end)
end
local function CleanupESP()
    for espName, data in pairs(ESPData) do
        for _, elementData in pairs(data.Elements) do
            if elementData.Element and elementData.Element.Destroy then
                elementData.Element:Destroy()
            end
        end
        
        for _, conn in pairs(data.Connections) do
            if conn then conn:Disconnect() end
        end
    end
    
    ESPData = {}
    
    if RainbowConnection then
        RainbowConnection:Disconnect()
        RainbowConnection = nil
    end
end
game:GetService("Players").LocalPlayer.AncestryChanged:Connect(function(_, parent)
    if not parent then
        CleanupESP()
    end
end)
StartRainbowEffect()
_G.ESPType = "Highlight"
_G.EnableTracers = false
_G.EnableArrows = false
    local NotificationTab = Window:Tab({Title = "提示", Icon = "bell"})

local EntityNotifyGroup = NotificationTab:Section({Title = "实体刷新提示[展开]", Side = "Left"})

local EntityNotifications = {
    Screech = {
        Description = "尖啸者已生成",
        Color = Color3.fromRGB(255, 255, 0)
    },
    Halt = {
        Description = "暂停实体已出现", 
        Color = Color3.fromRGB(0, 255, 255)
    },
    FigureRig = {
        Description = "检测到雕像",
        Color = Color3.fromRGB(255, 0, 0)
    },
    Eyes = {
        Description = "眼睛实体已生成",
        Color = Color3.fromRGB(127, 30, 220)
    },
    SeekMoving = {
        Description = "追逐者已生成",
        Color = Color3.fromRGB(255, 100, 100)
    },
    RushMoving = {
        Description = "冲刺正在接近",
        Color = Color3.fromRGB(0, 255, 0)
    },
    AmbushMoving = {
        Description = "伏击正在接近", 
        Color = Color3.fromRGB(80, 255, 110)
    },
    A60 = {
        Description = "A-60 正在冲刺",
        Color = Color3.fromRGB(200, 50, 50)
    },
    A120 = {
        Description = "A-120 在附近",
        Color = Color3.fromRGB(55, 55, 55)
    },
    GiggleCeiling = {
        Description = "傻笑在天花板上",
        Color = Color3.fromRGB(200, 200, 200)
    },
    GrumbleRig = {
        Description = "咕噜在巡逻",
        Color = Color3.fromRGB(150, 150, 150)
    },
    GloombatSwarm = {
        Description = "暗影蝙蝠群来袭",
        Color = Color3.fromRGB(100, 100, 100)
    },
    Dread = {
        Description = "恐惧实体已激活",
        Color = Color3.fromRGB(80, 80, 80)
    },
    BackdoorLookman = {
        Description = "观察者在注视",
        Color = Color3.fromRGB(110, 15, 15)
    },
    Snare = {
        Description = "陷阱已生成",
        Color = Color3.fromRGB(100, 100, 100)
    },
    WorldLotus = {
        Description = "检测到世界莲花",
        Color = Color3.fromRGB(200, 230, 50)
    },
    Bramble = {
        Description = "荆棘在生长",
        Color = Color3.fromRGB(50, 150, 30)
    },
    Caws = {
        Description = "乌鸦在飞行",
        Color = Color3.fromRGB(30, 30, 30)
    },
    Eyestalk = {
        Description = "眼柄将要追逐",
        Color = Color3.fromRGB(150, 80, 200)
    },
    Grampy = {
        Description = "爷爷已出现",
        Color = Color3.fromRGB(180, 180, 180)
    },
    Groundskeeper = {
        Description = "园丁在附近",
        Color = Color3.fromRGB(100, 150, 50)
    },
    Mandrake = {
        Description = "曼德拉草在尖叫",
        Color = Color3.fromRGB(130, 80, 30)
    },
    Monument = {
        Description = "纪念碑已激活",
        Color = Color3.fromRGB(150, 150, 150)
    },
    Surge = {
        Description = "浪涌在充能",
        Color = Color3.fromRGB(230, 130, 30)
    },
    BackdoorRush = {
        Description = "闪电即将到来",
        Color = Color3.fromRGB(230, 130, 30)
    }
}

local NotifyConnections = {}

EntityNotifyGroup:Toggle({
    Title = "尖啸者提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Screech", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "暂停实体提示", 
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Halt", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "雕像提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("FigureRig", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "眼睛提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Eyes", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "追逐者提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("SeekMoving", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "冲刺提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("RushMoving", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "伏击提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("AmbushMoving", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "A-60提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("A60", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "A-120提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("A120", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "傻笑提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("GiggleCeiling", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "咕噜提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("GrumbleRig", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "暗影蝙蝠提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("GloombatSwarm", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "恐惧提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Dread", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "观察者提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("BackdoorLookman", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "陷阱提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Snare", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "世界莲花提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("WorldLotus", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "荆棘提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Bramble", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "乌鸦提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Caws", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "眼柄提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Eyestalk", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "爷爷提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Grampy", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "园丁提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Groundskeeper", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "曼德拉草提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Mandrake", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "纪念碑提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Monument", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "浪涌提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Surge", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "闪电提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("BackdoorRush", Value)
    end
})

function SetupEntityNotification(entityName, enabled)
    if NotifyConnections[entityName] then
        NotifyConnections[entityName]:Disconnect()
        NotifyConnections[entityName] = nil
    end

    if not enabled then return end

    local entityData = EntityNotifications[entityName]
    if not entityData then return end

    local function onEntityAdded(obj)
        if obj.Name == entityName then
            WindUI:Notify("实体刷新", entityData.Description, 5)
        end
    end

    NotifyConnections[entityName] = workspace.ChildAdded:Connect(onEntityAdded)

    local rooms = workspace:FindFirstChild("CurrentRooms")
    if rooms then
        local roomConn = rooms.DescendantAdded:Connect(function(obj)
            if obj.Name == entityName then
                WindUI:Notify("实体刷新", entityData.Description, 5)
            end
        end)
        NotifyConnections[entityName .. "_Rooms"] = roomConn
    end
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