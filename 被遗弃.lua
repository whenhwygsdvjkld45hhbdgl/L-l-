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
    Title = "被遗弃",
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
    ["主要"] = "Main",
    ["发电机功能"] = "Generator Functions",
    ["自动修发电机"] = "Auto Repair Generators",
    ["修电箱延迟[秒]"] = "Repair Delay [Seconds]",
    ["设置修理发电机的间隔时间"] = "Set the interval time for repairing generators",
    
    -- 披萨类
    ["披萨类"] = "Pizza Functions",
    ["自动吃披萨(追踪)"] = "Auto Eat Pizza (Tracking)",
    ["传送吃披萨"] = "Teleport Pizza Eating",
    ["生命值设置"] = "Health Settings",
    ["当生命值低于设置值时自动吃披萨"] = "Auto eat pizza when health is below set value",
    
    -- 攻击类
    ["攻击"] = "Attack",
    ["自动斩[怪Shedletsky]"] = "Auto Slash [Monster Shedletsky]",
    ["斩击距离"] = "Slash Distance",
    ["设置自动斩击的触发距离"] = "Set the trigger distance for auto slash",
    
    -- 金币类
    ["金币"] = "Coins",
    ["自动翻金币"] = "Auto Flip Coins",
    ["金币目标数量"] = "Coin Target Amount",
    
    -- 提示类
    ["提示"] = "Alerts",
    ["杀手靠近提示"] = "Killer Proximity Alert",
    ["警告距离"] = "Warning Distance",
    ["三角炸弹生成提示"] = "Tripmine Spawn Alert",
    ["实体生成提示"] = "Entity Spawn Alert",
    
    -- 格挡类
    ["格挡类"] = "Block Functions",
    ["开启自动格挡"] = "Enable Auto Block",
    ["格挡距离"] = "Block Distance",
    
    -- 飞行类
    ["绕过飞行"] = "Bypass Flight",
    ["绕过飞行 (开/关)"] = "Bypass Flight (On/Off)",
    ["飞行速度"] = "Flight Speed",
    ["滑动调整"] = "Slide to adjust",
    
    -- 自瞄类
    ["自瞄类"] = "Aim Assist",
    ["选择自瞄方式"] = "Select Aim Method",
    ["自瞄距离"] = "Aim Distance",
    ["设置自瞄的最大距离"] = "Set maximum aim distance",
    ["自瞄范围"] = "Aim FOV",
    ["设置自瞄的范围"] = "Set aim field of view",
    ["隔墙检测"] = "Wall Detection",
    ["掩体检测已开启"] = "Cover detection enabled",
    ["掩体检测已关闭"] = "Cover detection disabled",
    
    -- 自瞄目标列表
    ["无"] = "None",
    ["玩家自瞄(幸存者)"] = "Player Aim (Survivors)",
    ["玩家自瞄(杀手)"] = "Player Aim (Killers)",
    ["1x4自瞄"] = "1x4 Aim",
    ["酷小孩自瞄"] = "Cool Kid Aim",
    ["约翰自瞄"] = "John Aim",
    ["杰森自瞄"] = "Jason Aim",
    ["机会自瞄"] = "Chance Aim",
    ["两次自瞄"] = "Two Time Aim",
    ["谢德利茨基自瞄"] = "Shedletsky Aim",
    ["访客自瞄"] = "Guest Aim",
    
    -- 透视类
    ["透视"] = "ESP",
    ["启用透视主开关"] = "Enable ESP Master Switch",
    ["透视幸存者"] = "ESP Survivors",
    ["透视杀手"] = "ESP Killers",
    ["透视物品"] = "ESP Items",
    ["透视发电机"] = "ESP Generators",
    ["彩虹渐变"] = "Rainbow Gradient",
    ["显示名称"] = "Show Names",
    ["透明度"] = "Transparency",
    ["设置填充的透明度"] = "Set fill transparency",
    
    -- 动作功能
    ["动作功能"] = "Emote Functions",
    ["选择动作"] = "Select Emote",
    ["确认播放动作"] = "Confirm Play Emote",
    
    -- 动作列表
    ["Silly Billy"] = "Silly Billy",
    ["Silly of it"] = "Silly of it",
    ["Subterfuge"] = "Subterfuge",
    ["Aw Shucks"] = "Aw Shucks",
    ["Miss The Quiet"] = "Miss The Quiet",
    ["VIP (新音频)"] = "VIP (New Audio)",
    ["VIP (旧音频)"] = "VIP (Old Audio)",
    
    -- 塔夫炸弹
    ["塔夫炸弹"] = "Tripmine Functions",
    ["三角炸弹自动追踪"] = "Auto Track Tripmines",
    ["弹飞炸弹"] = "Launch Bombs",
    ["弹飞检测距离"] = "Launch Detection Distance",
    ["设置弹飞炸弹的检测距离"] = "Set bomb launch detection distance",
    ["弹飞力度"] = "Launch Force",
    ["设置弹飞炸弹的力度"] = "Set bomb launch force",
    
    -- 反怪物类
    ["反怪物类"] = "Anti-Monster",
    ["自动删除约翰多乱码路径"] = "Auto Remove John Doe Glitch Paths",
    ["反约翰多尖刺"] = "Anti John Doe Spikes",
    ["自动删除约翰多陷阱"] = "Auto Remove John Doe Traps",
    ["反1x4弹窗"] = "Anti 1x4 Popup",
    ["执行间隔(秒)"] = "Execution Interval (Seconds)",
    ["设置自动执行的间隔时间"] = "Set auto execution interval time",
    
    -- 人物设置
    ["人物"] = "Character",
    ["无限体力"] = "Infinite Stamina",
    ["启用体力大小调节"] = "Enable Stamina Size Adjustment",
    ["启用体力恢复调节"] = "Enable Stamina Regeneration Adjustment",
    ["启用体力消耗调节"] = "Enable Stamina Consumption Adjustment",
    ["启用速度"] = "Enable Speed",
    ["无限体力恢复速度"] = "Infinite Stamina Regeneration Speed",
    ["体力大小"] = "Stamina Size",
    ["体力恢复"] = "Stamina Regeneration",
    ["体力消耗"] = "Stamina Consumption",
    ["走路速度"] = "Walk Speed",
    
    -- UI设置
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
    ["提示"] = "Alert",
    ["提示提示"] = "Notification",
    ["已开启"] = "Enabled",
    ["已关闭"] = "Disabled",
    ["已选择"] = "Selected",
    ["设置成功"] = "Set Successfully",
    ["你的角色不是"] = "Your character is not",
    ["无法生效"] = "Cannot take effect",
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
    ["重启脚本生效"] = "Restart script to take effect"
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

-- 启动翻译引擎
task.spawn(function()
    task.wait(2) -- 等待UI加载完成
    setupTranslationEngine()
end)

-- 创建翻译通知函数（可选）
local function showTranslatedNotification(title, content, duration)
    local translatedTitle = translateText(title)
    local translatedContent = translateText(content)
    
    WindUI:Notify({
        Title = translatedTitle,
        Content = translatedContent,
        Duration = duration or 4
    })
end

local Main = Window:Tab({Title = "主要", Icon = "settings"})

Main:Section({Title = "发电机功能"})

local repairDelay = 4.2
local autoRepairEnabled = false
local repairConnection = nil

Main:Toggle({
    Title = "自动修发电机",
    Default = false,
    Callback = function(state)
        autoRepairEnabled = state
        
        if state then
            WindUI:Notify({
                Title = "提示",
                Content = "自动修发电机已开启",
                Duration = 4
            })
            
            repairConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if not autoRepairEnabled then return end
                
                local map = workspace:FindFirstChild("Map")
                local ingame = map and map:FindFirstChild("Ingame")
                local currentMap = ingame and ingame:FindFirstChild("Map")

                if currentMap then
                    for _, obj in ipairs(currentMap:GetChildren()) do
                        if obj.Name == "Generator" and obj:FindFirstChild("Progress") and obj.Progress.Value < 100 then
                            local remote = obj:FindFirstChild("Remotes") and obj.Remotes:FindFirstChild("RE")
                            if remote then
                                remote:FireServer()
                            end
                        end
                    end
                end
            end)
        else
            if repairConnection then
                repairConnection:Disconnect()
                repairConnection = nil
            end
            WindUI:Notify({
                Title = "提示",
                Content = "自动修发电机已关闭",
                Duration = 4
            })
        end
    end
})

Main:Slider({
    Title = "修电箱延迟[秒]",
    Desc = "设置修理发电机的间隔时间",
    Value = {
        Min = 0.5,
        Max = 10,
        Default = 4.2,
    },
    Callback = function(value)
        repairDelay = value
        WindUI:Notify({
            Title = "提示",
            Content = "修理间隔设置为: " .. string.format("%.1f", value) .. "秒",
            Duration = 4
        })
    end
})

Main:Section({Title = "披萨类"})

local HealthEatPizza = 50
local pizzaConnection = nil
local pizzaTPConnection = nil
local pizzaAttractionActive = false
Main:Toggle({
    Title = "自动吃披萨(追踪)",
    Default = false,
    Callback = function(enabled)
        pizzaAttractionActive = enabled
        
        if pizzaConnection then
            pizzaConnection:Disconnect()
            pizzaConnection = nil
        end
        
        if enabled then
            local lastCheck = 0
            pizzaConnection = game:GetService("RunService").Stepped:Connect(function(_, deltaTime)
                lastCheck += deltaTime
                
                if lastCheck < 0.3 then return end
                lastCheck = 0
                
                local player = game:GetService("Players").LocalPlayer
                local character = player.Character
                
                if not character or not character:FindFirstChild("Humanoid") or not character:FindFirstChild("HumanoidRootPart") then
                    return
                end
                
                local humanoid = character.Humanoid
                local rootPart = character.HumanoidRootPart
                
                if HealthEatPizza and humanoid.Health >= HealthEatPizza then
                    return
                end
                
                local pizzaFolder = workspace:FindFirstChild("Pizzas") or workspace.Map
                if not pizzaFolder then return end
                
                local closestPizza, closestDistance = nil, math.huge
                for _, pizza in ipairs(pizzaFolder:GetDescendants()) do
                    if pizza:IsA("BasePart") and pizza.Name == "Pizza" then
                        local distance = (rootPart.Position - pizza.Position).Magnitude
                        if distance < closestDistance then
                            closestPizza = pizza
                            closestDistance = distance
                        end
                    end
                end
                
                if closestPizza then
                    closestPizza.CFrame = closestPizza.CFrame:Lerp(
                        rootPart.CFrame * CFrame.new(0, 0, -2),
                        0.5
                    )
                    
                    if not closestPizza:FindFirstChild("AttractEffect") then
                        local effect = Instance.new("ParticleEmitter")
                        effect.Name = "AttractEffect"
                        effect.Texture = "rbxassetid://242487987"
                        effect.LightEmission = 0.8
                        effect.Size = NumberSequence.new(0.5)
                        effect.Parent = closestPizza
                    end
                end
            end)
        end
    end
})
Main:Toggle({
    Title = "传送吃披萨",
    Default = false,
    Callback = function(enabled)
        if pizzaTPConnection then
            pizzaTPConnection:Disconnect()
            pizzaTPConnection = nil
        end
        
        if enabled then
            local lastCheck = 0
            pizzaTPConnection = game:GetService("RunService").Stepped:Connect(function(_, deltaTime)
                lastCheck += deltaTime
                
                if lastCheck < 0.3 then return end
                lastCheck = 0
                
                local player = game:GetService("Players").LocalPlayer
                local character = player.Character
                
                if not character or not character:FindFirstChild("Humanoid") or not character:FindFirstChild("HumanoidRootPart") then
                    return
                end
                
                local humanoid = character.Humanoid
                local rootPart = character.HumanoidRootPart
                
                if HealthEatPizza and humanoid.Health >= HealthEatPizza then
                    return
                end
                
                local pizzaFolder = workspace:FindFirstChild("Pizzas") or workspace.Map
                if not pizzaFolder then return end
                
                local closestPizza, closestDistance = nil, math.huge
                for _, pizza in ipairs(pizzaFolder:GetDescendants()) do
                    if pizza:IsA("BasePart") and pizza.Name == "Pizza" then
                        local distance = (rootPart.Position - pizza.Position).Magnitude
                        if distance < closestDistance then
                            closestPizza = pizza
                            closestDistance = distance
                        end
                    end
                end
                
                if closestPizza then
                    closestPizza.CFrame = rootPart.CFrame * CFrame.new(0, 0, -2)
                    
                    if not closestPizza:FindFirstChild("TeleportEffect") then
                        local effect = Instance.new("ParticleEmitter")
                        effect.Name = "TeleportEffect"
                        effect.Texture = "rbxassetid://242487987"
                        effect.LightEmission = 0.8
                        effect.Size = NumberSequence.new(0.5)
                        effect.Lifetime = NumberRange.new(0.5)
                        effect.Parent = closestPizza
                        
                        delay(1, function()
                            if effect and effect.Parent then
                                effect:Destroy()
                            end
                        end)
                    end
                end
            end)
        end
    end
})
Main:Slider({
    Title = "生命值设置",
    Desc = "当生命值低于设置值时自动吃披萨",
    Value = {
        Min = 10,
        Max = 130,
        Default = 50,
    },
    Callback = function(Value)
        HealthEatPizza = Value
    end
})

Main:Section({Title = "攻击"})
local autoSlashEnabled = false
local slashConnection = nil
local RunService = game:GetService("RunService")
local SlashDistance = 10

local function checkAndSlash()
    local player = game.Players.LocalPlayer
    if not player or not player.Character then return end
    
    local character = player.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local killersFolder = workspace:FindFirstChild("Players")
    if not killersFolder then return end
    
    local killers = killersFolder:FindFirstChild("Killers")
    if not killers then return end
    
    local playerPosition = humanoidRootPart.Position
    
    for _, killer in ipairs(killers:GetChildren()) do
        local killerRoot = killer:FindFirstChild("HumanoidRootPart")
        if killerRoot then
            local distance = (playerPosition - killerRoot.Position).Magnitude
            if distance <= SlashDistance then
                local args = {
                    [1] = "UseActorAbility",
                    [2] = "Slash"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                break
            end
        end
    end
end

Main:Toggle({
    Title = "自动斩[怪Shedletsky]",
    Default = false,
    Callback = function(state)
        autoSlashEnabled = state
        
        if state then
            if slashConnection then
                slashConnection:Disconnect()
            end
            slashConnection = RunService.Heartbeat:Connect(function()
                if autoSlashEnabled then
                    checkAndSlash()
                end
            end)
            
            WindUI:Notify({
                Title = "提示提示",
                Content = "自动斩击已开启 | 距离:" .. SlashDistance .. "米",
                Duration = 4
            })
        else
            if slashConnection then
                slashConnection:Disconnect()
                slashConnection = nil
            end
            
            WindUI:Notify({
                Title = "提示提示",
                Content = "自动斩击已关闭",
                Duration = 4
            })
        end
    end
})

Main:Slider({
    Title = "斩击距离",
    Desc = "设置自动斩击的触发距离",
    Value = {
        Min = 5,
        Max = 30,
        Default = 10,
    },
    Callback = function(Value)
        SlashDistance = Value
        WindUI:Notify({
            Title = "提示提示",
            Content = "斩击距离设置为: " .. Value .. "米",
            Duration = 4
        })
    end
})

Main:Section({Title = "金币"})

local autoFlipCoins = false
local flipTarget = 3 
local flipConnection = nil

Main:Toggle({
    Title = "自动翻金币",
    Default = false,
    Callback = function(state)
        autoFlipCoins = state
        
        if state then
            WindUI:Notify({
                Title = "提示",
                Content = "自动翻金币已开启 - 目标: 3个",
                Duration = 4
            })
            
            flipTarget = 3
            flipConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if not autoFlipCoins then return end
                
                local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
                local chargesText = playerGui:FindFirstChild("MainUI") and 
                                   playerGui.MainUI:FindFirstChild("AbilityContainer") and
                                   playerGui.MainUI.AbilityContainer:FindFirstChild("Shoot") and
                                   playerGui.MainUI.AbilityContainer.Shoot:FindFirstChild("Charges")
                
                if chargesText and chargesText:IsA("TextLabel") then
                    local currentCharges = tonumber(chargesText.Text) or 0
                    
                    if currentCharges < flipTarget then
                        local args = {
                            [1] = "UseActorAbility",
                            [2] = "CoinFlip"
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                    end
                end
            end)
        else
            if flipConnection then
                flipConnection:Disconnect()
                flipConnection = nil
            end
            WindUI:Notify({
                Title = "提示",
                Content = "自动翻金币已关闭",
                Duration = 4
            })
        end
    end
})
Main:Dropdown({
    Title = "金币目标数量",
    Values = {"1", "2", "3"},
    Default = "3",
    Callback = function(value)
        flipTarget = tonumber(value)
        WindUI:Notify({
            Title = "提示",
            Content = "金币目标数量设置为: " .. value .. "个",
            Duration = 4
        })
    end
})

Main:Section({Title = "提示"})

local WarningDistance = 100
Main:Toggle({
    Title = "杀手靠近提示",
    Default = false,
    Callback = function(enabled)
        local players = game:GetService("Players")
        local run_service = game:GetService("RunService")
        local local_player = players.LocalPlayer
        local lastWarningTime = 0
        local warningCooldown = 5
        
        if enabled then
            WindUI:Notify({
                Title = "提示提示",
                Content = "杀手靠近提示已开启，检测距离: " .. WarningDistance .. "米",
                Duration = 4
            })
            
            local warningConnection = run_service.RenderStepped:Connect(function()
                local character = local_player.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                
                local killersFolder = workspace.Players:FindFirstChild("Killers")
                if not killersFolder then return end
                
                local closestDistance = math.huge
                local closestKiller = nil
                
             
                for _, killer in ipairs(killersFolder:GetChildren()) do
                    if killer:IsA("Model") and killer:FindFirstChild("HumanoidRootPart") then
                        local distance = (character.HumanoidRootPart.Position - killer.HumanoidRootPart.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestKiller = killer
                        end
                    end
                end
                
                if closestKiller and closestDistance <= WarningDistance then
                    local currentTime = tick()
                    if currentTime - lastWarningTime >= warningCooldown then
                        WindUI:Notify({
                            Title = "提示提示",
                            Content = "警告! 杀手 " .. closestKiller.Name .. " 在 " .. math.floor(closestDistance) .. " 米内!",
                            Duration = 4
                        })
                        lastWarningTime = currentTime
                    end
                end
            end)
        else
            WindUI:Notify({
                Title = "提示提示",
                Content = "杀手靠近提示已关闭",
                Duration = 4
            })
        end
    end
})
Main:Slider({
    Title = "警告距离",
    Desc = "",
    Value = {
        Min = 10,
        Max = 200,
        Default = 100,
    },
    Callback = function(Value)
        WarningDistance = Value
        WindUI:Notify({
            Title = "提示提示",
            Content = "警告距离设置为: " .. Value .. "米",
            Duration = 4
        })
    end
})
Main:Toggle({
    Title = "三角炸弹生成提示",
    Default = false,
    Callback = function(enabled)
        if enabled then
            WindUI:Notify({
                Title = "提示提示",
                Content = "三角炸弹生成提示已开启",
                Duration = 4
            })
            
            local NotifySubspaceTripmine = workspace.Map.Ingame.DescendantAdded:Connect(function(v)
                if v.Name == "塔夫三角炸弹" then
                    WindUI:Notify({
                        Title = "提示提示",
                        Content = "三角炸弹已生成！",
                        Duration = 4
                    })
                end
            end)
        else
            if NotifySubspaceTripmine then
                NotifySubspaceTripmine:Disconnect()
            end
            WindUI:Notify({
                Title = "提示提示",
                Content = "三角炸弹生成提示已关闭",
                Duration = 4
            })
        end
    end
})
Main:Toggle({
    Title = "实体生成提示",
    Default = false,
    Callback = function(enabled)
        if enabled then
            WindUI:Notify({
                Title = "提示提示",
                Content = "实体生成提示已开启",
                Duration = 4
            })
            
            local NotifyEntityKillers = workspace.DescendantAdded:Connect(function(v)
                if v:IsA("Model") then
                    if v.Name == "PizzaDeliveryRig" or v.Name == "Bunny" or v.Name == "Mafiaso1" or v.Name == "Mafiaso2" or v.Name == "Mafiaso3" then
                        WindUI:Notify({
                            Title = "提示提示",
                            Content = "实体 '" .. v.Name .. "' 生成了！",
                            Duration = 4
                        })
                    elseif v.Name == "1x1x1x1Zombie" then
                        WindUI:Notify({
                            Title = "提示提示",
                            Content = "实体 '1x1x1x1 (僵尸)' 生成了！",
                            Duration = 4
                        })
                    end
                end
            end)
        else
            if NotifyEntityKillers then
                NotifyEntityKillers:Disconnect()
            end
            WindUI:Notify({
                Title = "提示提示",
                Content = "实体生成提示已关闭",
                Duration = 4
            })
        end
    end
})

local Main = Window:Tab({Title = "格挡类", Icon = "settings"})
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local config = {
    Enabled = false,
    BaseDistance = 16,
    ScanInterval = 0.02,
    BlockCooldown = 0.35,
    MoveCompBase = 1.5,
    MoveCompFactor = 0.25,
    SpeedThreshold = 8,
    PredictBase = 4,
    PredictMax = 8,
    PredictFactor = 0.22,
    TargetAngle = 50,
    MinAttackSpeed = 12
}

local animationIds = {
    ["126830014841198"] = true,
    ["126355327951215"] = true,
    ["121086746534252"] = true,
    ["18885909645"] = true,
    ["98456918873918"] = true,
    ["105458270463374"] = true,
    ["83829782357897"] = true,
    ["125403313786645"] = true,
    ["118298475669935"] = true,
    ["82113744478546"] = true,
    ["70371667919898"] = true,
    ["99135633258223"] = true,
    ["97167027849946"] = true,
    ["109230267448394"] = true,
    ["139835501033932"] = true,
    ["126896426760253"] = true,
}

local LocalPlayer = Players.LocalPlayer
local RemoteEvent
local success, err = pcall(function()
    RemoteEvent = ReplicatedStorage:WaitForChild("Modules", 10):WaitForChild("Network", 10):WaitForChild("RemoteEvent", 10)
end)
if not success or not RemoteEvent then
    warn("Failed to find RemoteEvent: ", err)
end
local lastBlockTime = 0
local combatConnection = nil

local function HasTargetAnimation(character)
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then return false end
    
    for _, track in pairs(animator:GetPlayingAnimationTracks()) do
        if track.Animation then
            local animId = track.Animation.AnimationId
            if animId then
                animId = tostring(animId:match("%d+"))
            else
                animId = ""
            end
            if animationIds[animId] then
                return true
            end
        end
    end
    return false
end

local function GetMoveCompensation()
    if not LocalPlayer.Character then return 0 end
    local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return 0 end
    
    local speed = rootPart.Velocity.Magnitude
    if speed <= config.SpeedThreshold then return 0 end
    
    return config.MoveCompBase + (speed - config.SpeedThreshold) * config.MoveCompFactor
end

local function GetTotalDetectionRange(killer)
    local base = config.BaseDistance
    local moveBonus = GetMoveCompensation()
    local predict = 0
    
    if killer:FindFirstChild("HumanoidRootPart") then
        local killerSpeed = killer.HumanoidRootPart.Velocity.Magnitude
        predict = math.min(
            config.PredictBase + killerSpeed * config.PredictFactor,
            config.PredictMax
        )
    end
    
    return base + moveBonus + predict
end

local function IsTargetingMe(killer)
    local myCharacter = LocalPlayer.Character
    if not myCharacter then return false end
    
    local myRoot = myCharacter:FindFirstChild("HumanoidRootPart")
    local killerRoot = killer:FindFirstChild("HumanoidRootPart")
    if not myRoot or not killerRoot then return false end
    
    local toPlayer = (myRoot.Position - killerRoot.CFrame.Position)
    if toPlayer.Magnitude == 0 then return false end -- Avoid division by zero
    toPlayer = toPlayer.Unit
    local facing = killerRoot.CFrame.LookVector
    if math.deg(math.acos(toPlayer:Dot(facing))) < config.TargetAngle then
        return true
    end
    
    local velocity = killerRoot.Velocity
    if velocity.Magnitude > config.MinAttackSpeed then
        return velocity.Unit:Dot(toPlayer) > 0.7
    end
    
    return false
end

local function GetThreateningKillers()
    local killers = {}
    local killersFolder = workspace:FindFirstChild("Killers")
    if not killersFolder then
        for _, child in ipairs(workspace:GetChildren()) do
            if child.Name == "Killers" and child:IsA("Folder") then
                killersFolder = child
                break
            end
        end
    end
    if not killersFolder then return killers end
    
    local myCharacter = LocalPlayer.Character
    if not myCharacter then return killers end
    
    local myRoot = myCharacter:FindFirstChild("HumanoidRootPart")
    if not myRoot then return killers end
    
    for _, killer in ipairs(killersFolder:GetChildren()) do
        if killer:FindFirstChild("HumanoidRootPart") then
            local killerRoot = killer.HumanoidRootPart
            local distance = (killerRoot.Position - myRoot.Position).Magnitude
            local detectRange = GetTotalDetectionRange(killer)
            
            if distance <= detectRange and HasTargetAnimation(killer) and IsTargetingMe(killer) then
                table.insert(killers, {
                    killer = killer,
                    dangerScore = distance / (killerRoot.Velocity.Magnitude + 1)
                })
            end
        end
    end
    
    table.sort(killers, function(a, b)
        return a.dangerScore < b.dangerScore
    end)
    
    return killers
end

local function GetAdjustedCooldown()
    if not LocalPlayer.Character then return config.BlockCooldown end
    local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return config.BlockCooldown end
    
    return rootPart.Velocity.Magnitude > config.SpeedThreshold 
        and config.BlockCooldown * 0.9 
        or config.BlockCooldown
end

local function PerformBlock()
    local now = os.clock()
    if now - lastBlockTime >= GetAdjustedCooldown() then
        local success, result = pcall(function()
            RemoteEvent:FireServer("UseActorAbility", "Block")
        end)
        if success then
            lastBlockTime = now
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local moveSpeed = LocalPlayer.Character.HumanoidRootPart.Velocity.Magnitude
                if moveSpeed > config.SpeedThreshold then
                    lastBlockTime = lastBlockTime + 0.03 * (moveSpeed / config.SpeedThreshold)
                end
            end
        end
    end
end

local function CombatLoop()
    local killers = GetThreateningKillers()
    if #killers > 0 then
        PerformBlock()
    end
end

Main:Toggle({
    Title = "开启自动格挡",
    Default = false,
    Callback = function(enabled)
        config.Enabled = enabled
        if enabled then
            if combatConnection then
                combatConnection:Disconnect()
            end
            combatConnection = RunService.Stepped:Connect(function()
                pcall(CombatLoop)
            end)
        elseif combatConnection then
            combatConnection:Disconnect()
            combatConnection = nil
        end
    end
})

Main:Slider({
    Title = "格挡距离",
    Default = 16,
    Min = 5,
    Max = 30,
    Rounding = 1,
    Callback = function(value)
        config.BaseDistance = value
    end
})

LocalPlayer.CharacterAdded:Connect(function()
    if config.Enabled and combatConnection then
        combatConnection:Disconnect()
        combatConnection = RunService.Stepped:Connect(CombatLoop)
    end
end)

local Main = Window:Tab({Title = "绕过飞行", Icon = "settings"})

local CFSpeed = 50
local CFLoop = nil

local function StartCFly()
    local speaker = game.Players.LocalPlayer
    local character = speaker.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass('Humanoid')
    local head = character:WaitForChild("Head")
    
    if not humanoid or not head then return end
    
    humanoid.PlatformStand = true
    head.Anchored = true
    
    if CFLoop then 
        CFLoop:Disconnect() 
        CFLoop = nil
    end
    
    CFLoop = RunService.Heartbeat:Connect(function(deltaTime)
        if not character or not humanoid or not head then 
            if CFLoop then 
                CFLoop:Disconnect() 
                CFLoop = nil
            end
            return 
        end
        
        local moveDirection = humanoid.MoveDirection * (CFSpeed * deltaTime)
        local headCFrame = head.CFrame
        local camera = workspace.CurrentCamera
        local cameraCFrame = camera.CFrame
        local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
        cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
        local cameraPosition = cameraCFrame.Position
        local headPosition = headCFrame.Position

        local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
        head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
    end)
end

local function StopCFly()
    local speaker = game.Players.LocalPlayer
    local character = speaker.Character
    
    if CFLoop then
        CFLoop:Disconnect()
        CFLoop = nil
    end
    
    if character then
        local humanoid = character:FindFirstChildOfClass('Humanoid')
        local head = character:FindFirstChild("Head")
        
        if humanoid then
            humanoid.PlatformStand = false
        end
        if head then
            head.Anchored = false
        end
    end
end

Main:Toggle({
    Title = "绕过飞行 (开/关)",
    Default = false,
    Callback = function(v)
        if v == true then
            StartCFly()
        else
            StopCFly()
        end
    end
})

Main:Slider({
    Title = "飞行速度",
    Desc = "滑动调整",
    Value = {
        Min = 1,
        Max = 200,
        Default = 50,
    },
    Callback = function(Value)
        CFSpeed = Value
    end
})


local Main = Window:Tab({Title = "自瞄类", Icon = "settings"})

local selectedAimbot = "无"
local aimbotList = {
    "无",
    "玩家自瞄(幸存者)",
    "玩家自瞄(杀手)", 
    "1x4自瞄",
    "酷小孩自瞄",
    "约翰自瞄",
    "杰森自瞄",
    "机会自瞄",
    "两次自瞄",
    "谢德利茨基自瞄",
    "访客自瞄"
}
local aimSettings = {
    distance = 100,
    fov = 100,
    size = 10,
    noWall = false,
    rainbowMode = true
}

local aimbotData = {
    FOVring = nil,
    connections = {}
}

Main:Dropdown({
    Title = "选择自瞄方式",
    Values = aimbotList,
    Default = "无",
    Callback = function(value)
        selectedAimbot = value
        
       
        stopAllAimbots()
        
        if value ~= "无" then
            WindUI:Notify({
                Title = "提示提示",
                Content = "已选择: " .. value,
                Duration = 4
            })
            
          
            if value == "玩家自瞄(幸存者)" then
                startPlayerAimbot(false) 
            elseif value == "玩家自瞄(杀手)" then
                startPlayerAimbot(false) 
            elseif value == "1x4自瞄" then
                start1x4Aimbot()
            elseif value == "酷小孩自瞄" then
                startCoolAimbot()
            elseif value == "约翰自瞄" then
                startJohnAimbot()
            elseif value == "杰森自瞄" then
                startJasonAimbot()
            elseif value == "机会自瞄" then
                startChanceAimbot()
            elseif value == "两次自瞄" then
                startTwoAimbot()
            elseif value == "谢德利茨基自瞄" then
                startShedletskyAimbot()
            elseif value == "访客自瞄" then
                startGuestAimbot()
            end
        else
            WindUI:Notify({
                Title = "提示提示",
                Content = "自瞄已关闭",
                Duration = 4
            })
        end
    end
})
Main:Slider({
    Title = "自瞄距离",
    Desc = "设置自瞄的最大距离",
    Value = {
        Min = 0,
        Max = 1000,
        Default = 100,
    },
    Callback = function(Value)
        aimSettings.distance = Value
        WindUI:Notify({
            Title = "提示提示",
            Content = "自瞄距离设置为: " .. Value .. "米",
            Duration = 4
        })
    end
})

Main:Slider({
    Title = "自瞄范围",
    Desc = "设置自瞄的范围",
    Value = {
        Min = 0,
        Max = 1000,
        Default = 100,
    },
    Callback = function(Value)
        aimSettings.fov = Value
        if aimbotData.FOVring then
            aimbotData.FOVring.Radius = Value
        end
        WindUI:Notify({
            Title = "提示提示",
            Content = "自瞄范围设置为: " .. Value,
            Duration = 4
        })
    end
})

Main:Toggle({
    Title = "隔墙检测",
    Default = false,
    Callback = function(state)
        aimSettings.noWall = state
        WindUI:Notify({
            Title = "提示提示",
            Content = state and "掩体检测已开启" or "掩体检测已关闭",
            Duration = 4
        })
    end
})
local function stopAllAimbots()
    if aimbotData.FOVring then
        aimbotData.FOVring:Remove()
        aimbotData.FOVring = nil
    end
    if aimbotData.connections.aimConnection then
        aimbotData.connections.aimConnection:Disconnect()
        aimbotData.connections.aimConnection = nil
    end
    
    for name, connection in pairs(aimbotData.connections) do
        if connection and connection.Disconnect then
            connection:Disconnect()
        end
    end
    aimbotData.connections = {}
end
local function startPlayerAimbot(isKiller)
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local Cam = workspace.CurrentCamera
    local UserInputService = game:GetService("UserInputService")
    local RaycastParams = RaycastParams.new()
    RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    aimbotData.FOVring = Drawing.new("Circle")
    aimbotData.FOVring.Visible = true
    aimbotData.FOVring.Thickness = 2
    aimbotData.FOVring.Filled = false
    aimbotData.FOVring.Color = Color3.fromHSV(0, 1, 1)

    aimbotData.connections.aimConnection = RunService.RenderStepped:Connect(function()
        aimbotData.FOVring.Radius = aimSettings.fov
        aimbotData.FOVring.Position = Cam.ViewportSize / 2

        local targetFolder = isKiller and workspace.Players:FindFirstChild("Killers") or workspace.Players:FindFirstChild("Survivors")
        local target = nil
        local closestDist = math.huge
        local mousePos = Cam.ViewportSize / 2

        if targetFolder then
            for _, model in pairs(targetFolder:GetChildren()) do
                local hrp = model:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local screenPos, onScreen = Cam:WorldToViewportPoint(hrp.Position)
                    local distance = (Cam.CFrame.Position - hrp.Position).Magnitude
                    if onScreen and distance <= aimSettings.distance then
                        if aimSettings.noWall then
                            RaycastParams.FilterDescendantsInstances = {
                                Players.LocalPlayer.Character,
                                workspace.Players
                            }
                            local result = workspace:Raycast(Cam.CFrame.Position, hrp.Position - Cam.CFrame.Position, RaycastParams)
                            if result and not result.Instance:IsDescendantOf(model) then
                                break
                            end
                        end
                        local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        if screenDist < closestDist and screenDist <= aimSettings.fov then
                            closestDist = screenDist
                            target = hrp
                        end
                    end
                end
            end
        end

        if target then
            local lookVector = (target.Position - Cam.CFrame.Position).Unit
            Cam.CFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
        end

        if aimSettings.rainbowMode and aimbotData.FOVring then
            local hue = (tick() * 0.2) % 1
            aimbotData.FOVring.Color = Color3.fromHSV(hue, 1, 1)
        end
    end)
end
local function start1x4Aimbot()
    local aimbot1x1sounds = {"rbxassetid://79782181585087", "rbxassetid://128711903717226"}
    
    if game:GetService("Players").LocalPlayer.Character.Name ~= "1x1x1x1" then
        WindUI:Notify({
            Title = "提示提示",
            Content = "你的角色不是1x4，无法生效",
            Duration = 4
        })
        return 
    end

    aimbotData.connections["1x4"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
        for _, v in pairs(aimbot1x1sounds) do
            if child.Name == v then
                local survivors = {}
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game:GetService("Players").LocalPlayer then
                        local character = player.Character
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            table.insert(survivors, character)
                        end
                    end
                end

                local nearestSurvivor = nil
                local shortestDistance = math.huge  
                
                for _, survivor in pairs(survivors) do
                    local survivorHRP = survivor.HumanoidRootPart
                    local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    
                    if playerHRP then
                        local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            nearestSurvivor = survivor
                        end
                    end
                end
                
                if nearestSurvivor then
                    local nearestHRP = nearestSurvivor.HumanoidRootPart
                    local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    
                    if playerHRP then
                        local direction = (nearestHRP.Position - playerHRP.Position).Unit
                        local num = 1
                        local maxIterations = 100 
                        
                        while num <= maxIterations do
                            task.wait(0.01)
                            num = num + 1
                            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                            playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                        end
                    end
                end
            end
        end
    end)
end
local function startCoolAimbot()
    local coolsounds = {"rbxassetid://111033845010938", "rbxassetid://106484876889079"}
    
    if game:GetService("Players").LocalPlayer.Character.Name ~= "c00lkidd" then
        WindUI:Notify({
            Title = "提示提示",
            Content = "你的角色不是c00lkidd，无法生效",
            Duration = 4
        })
        return 
    end

    aimbotData.connections["cool"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
        for _, v in pairs(coolsounds) do
            if child.Name == v then
                local survivors = {}
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game:GetService("Players").LocalPlayer then
                        local character = player.Character
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            table.insert(survivors, character)
                        end
                    end
                end

                local nearestSurvivor = nil
                local shortestDistance = math.huge  
                
                for _, survivor in pairs(survivors) do
                    local survivorHRP = survivor.HumanoidRootPart
                    local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    
                    if playerHRP then
                        local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            nearestSurvivor = survivor
                        end
                    end
                end
                
                if nearestSurvivor then
                    local nearestHRP = nearestSurvivor.HumanoidRootPart
                    local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    
                    if playerHRP then
                        local direction = (nearestHRP.Position - playerHRP.Position).Unit
                        local num = 1
                        local maxIterations = 100 
                        
                        if child.Name == "rbxassetid://79782181585087" then
                            maxIterations = 220  
                        end

                        while num <= maxIterations do
                            task.wait(0.01)
                            num = num + 1
                            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                        end
                    end
                end
            end
        end
    end)
end
local function startJohnAimbot()
    local johnaimbotsounds = {"rbxassetid://109525294317144"}
    
    if game:GetService("Players").LocalPlayer.Character.Name ~= "JohnDoe" then
        WindUI:Notify({
            Title = "提示提示",
            Content = "角色不对，无法生效",
            Duration = 4
        })
        return 
    end

    aimbotData.connections["john"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
        for _, v in pairs(johnaimbotsounds) do
            if child.Name == v then
                local survivors = {}
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game:GetService("Players").LocalPlayer then
                        local character = player.Character
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            table.insert(survivors, character)
                        end
                    end
                end

                local nearestSurvivor = nil
                local shortestDistance = math.huge  
                
                for _, survivor in pairs(survivors) do
                    local survivorHRP = survivor.HumanoidRootPart
                    local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    
                    if playerHRP then
                        local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            nearestSurvivor = survivor
                        end
                    end
                end
                
                if nearestSurvivor then
                    local nearestHRP = nearestSurvivor.HumanoidRootPart
                    local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local maxIterations = 330
                    if playerHRP then
                        local direction = (nearestHRP.Position - playerHRP.Position).Unit
                        local num = 1
                        
                        while num <= maxIterations do
                            task.wait(0.01)
                            num = num + 1
                            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                            playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                        end
                    end
                end
            end
        end
    end)
end
local function startJasonAimbot()
    local jasonaimbotsounds = {"rbxassetid://112809109188560", "rbxassetid://102228729296384"}
    
    if game:GetService("Players").LocalPlayer.Character.Name ~= "Jason" then
        WindUI:Notify({
            Title = "提示提示",
            Content = "角色不对，无法生效",
            Duration = 4
        })
        return 
    end

    aimbotData.connections["jason"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
        for _, v in pairs(jasonaimbotsounds) do
            if child.Name == v then
                local survivors = {}
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game:GetService("Players").LocalPlayer then
                        local character = player.Character
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            table.insert(survivors, character)
                        end
                    end
                end

                local nearestSurvivor = nil
                local shortestDistance = math.huge  
                
                for _, survivor in pairs(survivors) do
                    local survivorHRP = survivor.HumanoidRootPart
                    local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    
                    if playerHRP then
                        local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            nearestSurvivor = survivor
                        end
                    end
                end
                
                if nearestSurvivor then
                    local nearestHRP = nearestSurvivor.HumanoidRootPart
                    local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local maxIterations = 70
                    if playerHRP then
                        local direction = (nearestHRP.Position - playerHRP.Position).Unit
                        local num = 1
                        
                        while num <= maxIterations do
                            task.wait(0.01)
                            num = num + 1
                            playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                        end
                    end
                end
            end
        end
    end)
end
local function startChanceAimbot()
    if game.Players.LocalPlayer.Character.Name ~= "Chance" then
        WindUI:Notify({
            Title = "提示提示",
            Content = "你用的角色好像不是机会,无法生效",
            Duration = 4
        })
        return
    end
    
    local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")
            
    aimbotData.connections["chance"] = RemoteEvent.OnClientEvent:Connect(function(...)
        local args = {...}
        if args[1] == "UseActorAbility" and args[2] == "Shoot" then 
            local killerContainer = game.Workspace.Players:FindFirstChild("Killers")
            if killerContainer then 
                local killer = killerContainer:FindFirstChildOfClass("Model")
                if killer and killer:FindFirstChild("HumanoidRootPart") then 
                    local killerHRP = killer.HumanoidRootPart
                    local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if playerHRP then 
                        local TMP = 0.35
                        local AMD = 2
                        local endTime = tick() + AMD
                        while tick() < endTime do
                            RunService.RenderStepped:Wait()
                            local predictedTarget = killerHRP.Position + (killerHRP.Velocity * TMP)
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = killerHRP.CFrame + Vector3.new(0, 0, -2)
                        end
                    end
                end
            end
        end
    end)
end
local function startTwoAimbot()
    local TWOsounds = {"rbxassetid://86710781315432", "rbxassetid://99820161736138"}
    
    if game:GetService("Players").LocalPlayer.Character.Name ~= "TwoTime" then
        WindUI:Notify({
            Title = "提示提示",
            Content = "你的角色不是Two Time，无法生效",
            Duration = 4
        })
        return 
    end

    aimbotData.connections["two"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
        for _, v in pairs(TWOsounds) do
            if child.Name == v then
                local survivors = {}
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game:GetService("Players").LocalPlayer then
                        local character = player.Character
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            table.insert(survivors, character)
                        end
                    end
                end

                local nearestSurvivor = nil
                local shortestDistance = math.huge  
                
                for _, survivor in pairs(survivors) do
                    local survivorHRP = survivor.HumanoidRootPart
                    local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    
                    if playerHRP then
                        local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            nearestSurvivor = survivor
                        end
                    end
                end
                
                if nearestSurvivor then
                    local nearestHRP = nearestSurvivor.HumanoidRootPart
                    local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    
                    if playerHRP then
                        local direction = (nearestHRP.Position - playerHRP.Position).Unit
                        local num = 1
                        local maxIterations = 100 
                        
                        if child.Name == "rbxassetid://79782181585087" then
                            maxIterations = 220  
                        end

                        while num <= maxIterations do
                            task.wait(0.01)
                            num = num + 1
                            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                            playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))  
                        end
                    end
                end
            end
        end
    end)
end
local function startShedletskyAimbot()
    if game:GetService("Players").LocalPlayer.Character.Name ~= "Shedletsky" then
        WindUI:Notify({
            Title = "提示提示",
            Content = "你用的角色好像不是谢德利茨基,无法生效",
            Duration = 4
        })
        return
    end
    
    aimbotData.connections["shed"] = game:GetService("Players").LocalPlayer.Character.Sword.ChildAdded:Connect(function(child)
        if child:IsA("Sound") then 
            local FAN = child.Name
            if FAN == "rbxassetid://12222225" or FAN == "83851356262523" then 
                local killersFolder = game.Workspace.Players:FindFirstChild("Killers")
                if killersFolder then 
                    local killer = killersFolder:FindFirstChildOfClass("Model")
                    if killer and killer:FindFirstChild("HumanoidRootPart") then 
                        local killerHRP = killer.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if playerHRP then 
                            local num = 1
                            local maxIterations = 100
                            while num <= maxIterations do
                                task.wait(0.01)
                                num = num + 1
                                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, killerHRP.Position)
                                playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, killerHRP.Position)
                            end
                        end
                    end
                end
            end
        end
    end)
end
local function startGuestAimbot()
    local guestaimbotsounds = {"rbxassetid://106397684977541"}
    
    aimbotData.connections["guest"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
        for _, v in ipairs(guestaimbotsounds) do
            if child.Name == v then
                local targetkiller = game.Workspace.Players:FindFirstChild("Killers"):FindFirstChildOfClass("Model")
                if targetkiller and targetkiller:FindFirstChild("HumanoidRootPart") then
                    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local direction = (targetkiller.HumanoidRootPart.Position - game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Unit
                        local number = 1
                        game:GetService("RunService").RenderStepped:Connect(function()
                            if number <= 100 then
                                task.wait(0.01)
                                number = number + 1
                                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position, Vector3.new(targetkiller.HumanoidRootPart.Position.X, targetkiller.HumanoidRootPart.Position.Y, targetkiller.HumanoidRootPart.Position.Z))
                            end
                        end)
                    end
                end
            end
        end
    end)
end
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    if selectedAimbot ~= "无" then
        stopAllAimbots()
        selectedAimbot = "无"
    end
end)

local Main = Window:Tab({Title = "透视", Icon = "settings"})

local HighlightSettings = {
    Enabled = false,
    ShowSurvivors = false,
    ShowKillers = false,
    ShowItems = false,
    ShowGenerators = false,
    RainbowMode = false,
    ShowNames = false,
    connection = nil,
    highlights = {}
}

-- 彩虹色生成函数
local function getRainbowColor()
    local hue = (tick() * 0.5) % 1
    return Color3.fromHSV(hue, 1, 1)
end

-- 创建高亮对象
local function createHighlight(object, objectType)
    if not object or not object.Parent then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "RainbowESP"
    highlight.Adornee = object
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Enabled = true
    highlight.FillTransparency = 0.7
    highlight.OutlineTransparency = 0
    
    -- 创建名称标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "NameTag"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = object:FindFirstChild("Head") or object.PrimaryPart or object:FindFirstChildWhichIsA("BasePart")
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 100
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = object.Name
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = billboard
    
    billboard.Parent = object
    
    HighlightSettings.highlights[object] = {
        highlight = highlight,
        billboard = billboard,
        type = objectType
    }
    
    return highlight
end

-- 更新高亮颜色
local function updateHighlightColors()
    for object, data in pairs(HighlightSettings.highlights) do
        if data.highlight and data.highlight.Parent then
            if HighlightSettings.RainbowMode then
                data.highlight.FillColor = getRainbowColor()
                data.highlight.OutlineColor = getRainbowColor()
            else
                -- 根据类型设置固定颜色
                if data.type == "Survivor" then
                    data.highlight.FillColor = Color3.fromRGB(0, 191, 255)
                    data.highlight.OutlineColor = Color3.fromRGB(0, 191, 255)
                elseif data.type == "Killer" then
                    data.highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    data.highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                elseif data.type == "Item" then
                    data.highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    data.highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
                elseif data.type == "Generator" then
                    data.highlight.FillColor = Color3.fromRGB(255, 255, 0)
                    data.highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                end
            end
        end
    end
end

-- 清理高亮对象
local function cleanupHighlights()
    for _, data in pairs(HighlightSettings.highlights) do
        if data.highlight then
            data.highlight:Destroy()
        end
        if data.billboard then
            data.billboard:Destroy()
        end
    end
    HighlightSettings.highlights = {}
end

-- 更新高亮显示
local function updateHighlights()
    -- 处理幸存者
    if HighlightSettings.ShowSurvivors then
        local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            for _, survivor in ipairs(survivorsFolder:GetChildren()) do
                if survivor:IsA("Model") and not HighlightSettings.highlights[survivor] then
                    local highlight = createHighlight(survivor, "Survivor")
                    if highlight then
                        highlight.Parent = game.CoreGui
                    end
                end
            end
        end
    end
    
    -- 处理杀手
    if HighlightSettings.ShowKillers then
        local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
        if killersFolder then
            for _, killer in ipairs(killersFolder:GetChildren()) do
                if killer:IsA("Model") and not HighlightSettings.highlights[killer] then
                    local highlight = createHighlight(killer, "Killer")
                    if highlight then
                        highlight.Parent = game.CoreGui
                    end
                end
            end
        end
    end
    
    -- 处理物品
    if HighlightSettings.ShowItems then
        -- 医疗箱
        for _, medkit in ipairs(workspace:GetDescendants()) do
            if medkit:IsA("Model") and medkit.Name == "Medkit" and not HighlightSettings.highlights[medkit] then
                local highlight = createHighlight(medkit, "Item")
                if highlight then
                    highlight.Parent = game.CoreGui
                end
            end
        end
        
        -- 可乐
        for _, cola in ipairs(workspace:GetDescendants()) do
            if cola:IsA("Model") and cola.Name == "BloxyCola" and not HighlightSettings.highlights[cola] then
                local highlight = createHighlight(cola, "Item")
                if highlight then
                    highlight.Parent = game.CoreGui
                end
            end
        end
        
        -- 三角炸弹
        for _, tripmine in ipairs(workspace:GetDescendants()) do
            if tripmine:IsA("Model") and tripmine.Name == "SubspaceTripmine" and not HighlightSettings.highlights[tripmine] then
                local highlight = createHighlight(tripmine, "Item")
                if highlight then
                    highlight.Parent = game.CoreGui
                end
            end
        end
    end
    
  
    if HighlightSettings.ShowGenerators then
        for _, generator in ipairs(workspace:GetDescendants()) do
            if generator:IsA("Model") and generator.Name == "Generator" and not HighlightSettings.highlights[generator] then
                local highlight = createHighlight(generator, "Generator")
                if highlight then
                    highlight.Parent = game.CoreGui
                end
            end
        end
    end
    
    -- 清理不再存在的对象
    for object, data in pairs(HighlightSettings.highlights) do
        if not object or not object.Parent then
            if data.highlight then data.highlight:Destroy() end
            if data.billboard then data.billboard:Destroy() end
            HighlightSettings.highlights[object] = nil
        end
    end
end
Main:Toggle({
    Title = "启用透视主开关",
    Default = false,
    Callback = function(enabled)
        HighlightSettings.Enabled = enabled
        if enabled then
            WindUI:Notify({
                Title = "提示提示",
                Content = "透视已开启",
                Duration = 4
            })
            
       
            if not HighlightSettings.connection then
                HighlightSettings.connection = game:GetService("RunService").RenderStepped:Connect(function()
                    updateHighlights()
                    if HighlightSettings.RainbowMode then
                        updateHighlightColors()
                    end
                end)
            end
        else
        
            if HighlightSettings.connection then
                HighlightSettings.connection:Disconnect()
                HighlightSettings.connection = nil
            end
          
            cleanupHighlights()
            
            WindUI:Notify({
                Title = "提示提示",
                Content = "透视已关闭",
                Duration = 4
            })
        end
    end
})
Main:Toggle({
    Title = "透视幸存者",
    Default = false,
    Callback = function(enabled)
        HighlightSettings.ShowSurvivors = enabled
        WindUI:Notify({
            Title = "提示提示",
            Content = enabled and "幸存者显示已开启" or "幸存者显示已关闭",
            Duration = 4
        })
    end
})

Main:Toggle({
    Title = "透视杀手",
    Default = false,
    Callback = function(enabled)
        HighlightSettings.ShowKillers = enabled
        WindUI:Notify({
            Title = "提示提示",
            Content = enabled and "杀手显示已开启" or "杀手显示已关闭",
            Duration = 4
        })
    end
})

Main:Toggle({
    Title = "透视物品",
    Default = false,
    Callback = function(enabled)
        HighlightSettings.ShowItems = enabled
        WindUI:Notify({
            Title = "提示提示",
            Content = enabled and "物品显示已开启" or "物品显示已关闭",
            Duration = 4
        })
    end
})

Main:Toggle({
    Title = "透视发电机",
    Default = false,
    Callback = function(enabled)
        HighlightSettings.ShowGenerators = enabled
        WindUI:Notify({
            Title = "提示提示",
            Content = enabled and "发电机已开启" or "发电机已关闭",
            Duration = 4
        })
    end
})

Main:Toggle({
    Title = "彩虹渐变",
    Default = false,
    Callback = function(enabled)
        HighlightSettings.RainbowMode = enabled
        WindUI:Notify({
            Title = "提示提示",
            Content = enabled and "彩虹已开启" or "彩虹已关闭",
            Duration = 4
        })
    end
})

Main:Toggle({
    Title = "显示名称",
    Default = false,
    Callback = function(enabled)
        HighlightSettings.ShowNames = enabled
        for _, data in pairs(HighlightSettings.highlights) do
            if data.billboard then
                data.billboard.Enabled = enabled
            end
        end
        WindUI:Notify({
            Title = "提示提示",
            Content = enabled and "名称显示已开启" or "名称显示已关闭",
            Duration = 4
        })
    end
})
Main:Slider({
    Title = "透明度",
    Desc = "设置填充的透明度",
    Value = {
        Min = 0,
        Max = 1,
        Default = 0.7,
    },
    Callback = function(Value)
        for _, data in pairs(HighlightSettings.highlights) do
            if data.highlight then
                data.highlight.FillTransparency = Value
            end
        end
        WindUI:Notify({
            Title = "提示提示",
            Content = "透明度设置为: " .. string.format("%.1f", Value),
            Duration = 4
        })
    end
})
local Main = Window:Tab({Title = "动作功能", Icon = "settings"})

local selectedAction = nil
local actionList = {
    "Silly Billy",
    "Silly of it", 
    "Subterfuge",
    "Aw Shucks",
    "Miss The Quiet",
    "VIP (新音频)",
    "VIP (旧音频)"
}

Main:Dropdown({
    Title = "选择动作",
    Values = actionList,
    Default = "Silly Billy",
    Callback = function(value)
        selectedAction = value
    end
})
Main:Button({
    Title = "确认播放动作",
    Callback = function()
        if not selectedAction then
            WindUI:Notify({
                Title = "提示提示",
                Content = "请先选择一个动作",
                Duration = 4
            })
            return
        end

        WindUI:Notify({
            Title = "提示提示",
            Content = "开始播放动作: " .. selectedAction,
            Duration = 4
        })
        if selectedAction == "Silly Billy" then
            PlaySillyBilly()
        elseif selectedAction == "Silly of it" then
            PlaySillyOfIt()
        elseif selectedAction == "Subterfuge" then
            PlaySubterfuge()
        elseif selectedAction == "Aw Shucks" then
            PlayAwShucks()
        elseif selectedAction == "Miss The Quiet" then
            PlayMissTheQuiet()
        elseif selectedAction == "VIP (新音频)" then
            PlayVIPNew()
        elseif selectedAction == "VIP (旧音频)" then
            PlayVIPOld()
        end
    end
})
function PlaySillyBilly()
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    humanoid.PlatformStand = true
    humanoid.JumpPower = 0
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = rootPart
    
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://107464355830477"
    local animationTrack = humanoid:LoadAnimation(animation)
    animationTrack:Play()
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://77601084987544"
    sound.Parent = rootPart
    sound.Volume = 0.5
    sound.Looped = false
    sound:Play()
    
    animationTrack.Stopped:Connect(function()
        humanoid.PlatformStand = false
        if bodyVelocity and bodyVelocity.Parent then
            bodyVelocity:Destroy()
        end
        
        for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
            local asset = char:FindFirstChild(assetName)
            if asset then asset:Destroy() end
        end
    end)
end

function PlaySillyOfIt()
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    humanoid.PlatformStand = true
    humanoid.JumpPower = 0
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = rootPart
    
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://107464355830477"
    local animationTrack = humanoid:LoadAnimation(animation)
    animationTrack:Play()
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://120176009143091"
    sound.Parent = rootPart
    sound.Volume = 0.5
    sound.Looped = false
    sound:Play()
    
    animationTrack.Stopped:Connect(function()
        humanoid.PlatformStand = false
        if bodyVelocity and bodyVelocity.Parent then
            bodyVelocity:Destroy()
        end
        
        for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
            local asset = char:FindFirstChild(assetName)
            if asset then asset:Destroy() end
        end
    end)
end

function PlaySubterfuge()
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    humanoid.PlatformStand = true
    humanoid.JumpPower = 0
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = rootPart
    
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://87482480949358"
    local animationTrack = humanoid:LoadAnimation(animation)
    animationTrack:Play()
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://132297506693854"
    sound.Parent = rootPart
    sound.Volume = 2
    sound.Looped = false
    sound:Play()
    
    local args = {
        [1] = "PlayEmote",
        [2] = "Animations",
        [3] = "_Subterfuge"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
    animationTrack.Stopped:Connect(function()
        humanoid.PlatformStand = false
        if bodyVelocity and bodyVelocity.Parent then
            bodyVelocity:Destroy()
        end
    end)
end

function PlayAwShucks()
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    humanoid.PlatformStand = false
    humanoid.JumpPower = 0
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = rootPart
    
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://74238051754912"
    local animationTrack = humanoid:LoadAnimation(animation)
    animationTrack:Play()
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://123236721947419"
    sound.Parent = rootPart
    sound.Volume = 0.5
    sound.Looped = false
    sound:Play()
    
    local args = {
        [1] = "PlayEmote",
        [2] = "Animations",
        [3] = "Shucks"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
    animationTrack.Stopped:Connect(function()
        humanoid.PlatformStand = false
        if bodyVelocity and bodyVelocity.Parent then
            bodyVelocity:Destroy()
        end
    end)
end

function PlayMissTheQuiet()
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    humanoid.PlatformStand = true
    humanoid.JumpPower = 0
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = rootPart
    
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://100986631322204"
    local animationTrack = humanoid:LoadAnimation(animation)
    animationTrack:Play()
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://131936418953291"
    sound.Parent = rootPart
    sound.Volume = 0.5
    sound.Looped = false
    sound:Play()
    
    animationTrack.Stopped:Connect(function()
        humanoid.PlatformStand = false
        if bodyVelocity and bodyVelocity.Parent then
            bodyVelocity:Destroy()
        end
        
        for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
            local asset = char:FindFirstChild(assetName)
            if asset then asset:Destroy() end
        end
    end)
end

function PlayVIPNew()
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    humanoid.PlatformStand = false
    humanoid.JumpPower = 0
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = rootPart
    
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://138019937280193"
    local animationTrack = humanoid:LoadAnimation(animation)
    animationTrack:Play()
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://109474987384441"
    sound.Parent = rootPart
    sound.Volume = 0.5
    sound.Looped = true
    sound:Play()
    
    local effect = game:GetService("ReplicatedStorage").Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
    effect.Name = "PlayerEmoteVFX"
    effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
    effect.WeldConstraint.Part0 = char.PrimaryPart
    effect.WeldConstraint.Part1 = effect
    effect.Parent = char
    effect.CanCollide = false
    
    local args = {
        [1] = "PlayEmote",
        [2] = "Animations",
        [3] = "HakariDance"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
    animationTrack.Stopped:Connect(function()
        humanoid.PlatformStand = false
        if bodyVelocity and bodyVelocity.Parent then
            bodyVelocity:Destroy()
        end
    end)
end

function PlayVIPOld()
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    humanoid.PlatformStand = false
    humanoid.JumpPower = 0
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = rootPart
    
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://138019937280193"
    local animationTrack = humanoid:LoadAnimation(animation)
    animationTrack:Play()
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://87166578676888"
    sound.Parent = rootPart
    sound.Volume = 0.5
    sound.Looped = true
    sound:Play()
    
    local effect = game:GetService("ReplicatedStorage").Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
    effect.Name = "PlayerEmoteVFX"
    effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
    effect.WeldConstraint.Part0 = char.PrimaryPart
    effect.WeldConstraint.Part1 = effect
    effect.Parent = char
    effect.CanCollide = false
    
    local args = {
        [1] = "PlayEmote",
        [2] = "Animations",
        [3] = "HakariDance"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
    animationTrack.Stopped:Connect(function()
        humanoid.PlatformStand = false
        if bodyVelocity and bodyVelocity.Parent then
            bodyVelocity:Destroy()
        end
    end)
end

local Main = Window:Tab({Title = "塔夫炸弹", Icon = "settings"})
local tripmineData = {
    active = false,
    killerParts = {},
    tripmineParts = {},
    connections = {},
    speed = 20,
    survivorNames = {}
}
Main:Toggle({
    Title = "三角炸弹自动追踪",
    Default = false,
    Callback = function(enabled)
        if enabled then
            WindUI:Notify({
                Title = "提示提示",
                Content = "追踪已开启",
                Duration = 4
            })
            
            local TRPSP = 80
            local UPDAT = 0.1
            local For = 16000
            local KILLNAMEE = "Jason"
            local activeConnections = {}

            local function GetKIPOs()
                local killerPositions = {}
                local KILlEF = workspace:FindFirstChild("Players")
                if KILlEF then
                    KILlEF = KILlEF:FindFirstChild("Killers")
                end

                if not KILlEF then
                    local jasonModel = workspace:FindFirstChild(KILLNAMEE, true)
                    if jasonModel and jasonModel:IsA("Model") then
                        local primaryPart = jasonModel.PrimaryPart or jasonModel:FindFirstChild("HumanoidRootPart") or jasonModel:FindFirstChild("Torso")
                        if primaryPart then
                            table.insert(killerPositions, {
                                position = primaryPart.Position,
                                model = jasonModel,
                                name = jasonModel.Name,
                            })
                        end
                    end
                    return killerPositions
                end

                for _, obj in pairs(KILlEF:GetChildren()) do
                    if obj:IsA("Model") then
                        local primaryPart = obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Torso")
                        if primaryPart then
                            table.insert(killerPositions, {
                                position = primaryPart.Position,
                                model = obj,
                                name = obj.Name,
                            })
                        end
                    end
                end

                return killerPositions
            end

            local function ALTRP()
                local tripmines = {}
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and string.find(obj.Name, "SubspaceTripmine") then
                        local primaryPart = obj.PrimaryPart or obj:FindFirstChildOfClass("Part")
                        if primaryPart then
                            table.insert(tripmines, {
                                model = obj,
                                part = primaryPart,
                                name = obj.Name,
                            })
                        end
                    end
                end
                return tripmines
            end

            local function UPTAR()
                local killerPositions = GetKIPOs()
                local tripmines = ALTRP()

                if #killerPositions == 0 or #tripmines == 0 then return end

                for _, tripmine in pairs(tripmines) do
                    local currentPos = tripmine.part.Position
                    local NEARTarget = nil
                    local NEARDistance = math.huge

                    for _, target in pairs(killerPositions) do
                        local distance = (target.position - currentPos).Magnitude
                        if distance < NEARDistance then
                            NEARDistance = distance
                            NEARTarget = target
                        end
                    end

                    if NEARTarget then
                        local direction = (NEARTarget.position - currentPos).Unit
                        local distance = (NEARTarget.position - currentPos).Magnitude
                        local adjustedSpeed = math.min(TRPSP, distance * 2)
                        local KILLVETOR = direction * adjustedSpeed

                        local bodyVelocity = tripmine.part:FindFirstChild("BodyVelocity")
                        if not bodyVelocity then
                            for _, child in pairs(tripmine.part:GetChildren()) do
                                if child:IsA("BodyVelocity") or child:IsA("BodyPosition") then
                                    child:Destroy()
                                end
                            end
                            bodyVelocity = Instance.new("BodyVelocity")
                            bodyVelocity.MaxForce = Vector3.new(For, For, For)
                            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                            bodyVelocity.Parent = tripmine.part
                        end

                        if bodyVelocity then
                            local currentVel = bodyVelocity.Velocity
                            local smoothVel = currentVel:lerp(KILLVETOR, 0.3)
                            bodyVelocity.Velocity = smoothVel
                        end
                    end
                end
            end

            local lastUpdate = 0
            local connection = game:GetService("RunService").Heartbeat:Connect(function()
                local currentTime = tick()
                if currentTime - lastUpdate >= UPDAT then
                    lastUpdate = currentTime
                    UPTAR()
                end
            end)

            table.insert(activeConnections, connection)

        else
            WindUI:Notify({
                Title = "提示提示",
                Content = "V2追踪系统已关闭",
                Duration = 4
            })
        end
    end
})
Main:Toggle({
    Title = "弹飞炸弹",
    Default = false,
    Callback = function(enabled)
        if enabled then
            WindUI:Notify({
                Title = "提示提示",
                Content = "弹飞炸弹功能已开启",
                Duration = 4
            })
            
            local TRPSP = 3000
            local UPDATE_INTERVAL = 0.2
            local DETECTION_RANGE = 30
            local KILLER_NAME = "Jason"
            
            local systemActive = true
            local heartbeatConnection = nil
            local lastUpdate = 0
            
            local function GetKillerPositions()
                local killerPositions = {}
                local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
                
                if killersFolder then
                    for _, model in ipairs(killersFolder:GetChildren()) do
                        if model:IsA("Model") then
                            local primaryPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
                            if primaryPart then
                                table.insert(killerPositions, primaryPart)
                            end
                        end
                    end
                else
                    local killerModel = workspace:FindFirstChild(KILLER_NAME, true)
                    if killerModel and killerModel:IsA("Model") then
                        local primaryPart = killerModel.PrimaryPart or killerModel:FindFirstChildWhichIsA("BasePart")
                        if primaryPart then
                            table.insert(killerPositions, primaryPart)
                        end
                    end
                end
                
                return killerPositions
            end

            local function LaunchTripmine(tripminePart, direction)
                for _, child in ipairs(tripminePart:GetChildren()) do
                    if child:IsA("BodyMover") then
                        child:Destroy()
                    end
                end
                
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Velocity = direction * TRPSP
                bodyVelocity.P = 1000
                bodyVelocity.Parent = tripminePart
                
                tripminePart.CanCollide = false
                
                delay(5, function()
                    if tripminePart and tripminePart.Parent then
                        tripminePart:Destroy()
                    end
                end)
            end

            local function UpdateBombs()
                local now = tick()
                if now - lastUpdate < UPDATE_INTERVAL then return end
                lastUpdate = now
                
                local killers = GetKillerPositions()
                if #killers == 0 then return end
                
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj.Name:find("SubspaceTripmine") then
                        local primaryPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        if primaryPart then
                            local minePos = primaryPart.Position
                            local nearestKiller, minDist = nil, DETECTION_RANGE
                            
                            for _, killer in ipairs(killers) do
                                local dist = (killer.Position - minePos).Magnitude
                                if dist < minDist then
                                    minDist = dist
                                    nearestKiller = killer
                                end
                            end
                            
                            if nearestKiller then
                                local dir = (minePos - nearestKiller.Position).Unit
                                dir = dir + Vector3.new(0, 0.8, 0)
                                LaunchTripmine(primaryPart, dir)
                            end
                        end
                    end
                end
            end

            heartbeatConnection = game:GetService("RunService").Stepped:Connect(function()
                if systemActive then
                    UpdateBombs()
                end
            end)

        else
            WindUI:Notify({
                Title = "提示提示",
                Content = "弹飞炸弹功能已关闭",
                Duration = 4
            })
        end
    end
})
Main:Slider({
    Title = "弹飞检测距离",
    Desc = "设置弹飞炸弹的检测距离",
    Value = {
        Min = 10,
        Max = 50,
        Default = 30,
    },
    Callback = function(Value)
        WindUI:Notify({
            Title = "提示提示",
            Content = "弹飞检测距离设置为: " .. Value .. "米",
            Duration = 4
        })
    end
})

Main:Slider({
    Title = "弹飞力度",
    Desc = "设置弹飞炸弹的力度",
    Value = {
        Min = 1000,
        Max = 5000,
        Default = 3000,
    },
    Callback = function(Value)
        WindUI:Notify({
            Title = "提示提示",
            Content = "弹飞力度设置为: " .. Value,
            Duration = 4
        })
    end
})

local Main = Window:Tab({Title = "反怪物类", Icon = "settings"})
local function safeDestroy(obj)
    if obj and obj.Parent then
        obj:Destroy()
    end
end
local function removeTouchInterests(object)
    for _, child in ipairs(object:GetDescendants()) do
        if child:IsA("TouchTransmitter") or child.Name == "TouchInterest" then
            safeDestroy(child)
        end
    end
end

Main:Toggle({
    Title = "自动删除约翰多乱码路径",
    Default = false,
    Callback = function(enabled)
        if enabled then
            WindUI:Notify({
                Title = "提示提示",
                Content = "约翰多乱码路径去除已开启",
                Duration = 4
            })
            
            local function RemoveTouchInterests()
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                
                local killers = playersFolder:FindFirstChild("Killers")
                if not killers then return end

                for _, killer in ipairs(killers:GetChildren()) do
                    if killer:FindFirstChild("JohnDoeTrail") then
                        for _, trail in ipairs(killer.JohnDoeTrail:GetDescendants()) do
                            if trail.Name == "Trail" then
                                removeTouchInterests(trail)
                            end
                        end
                    end
                end
            end

            RemoveTouchInterests()

            local DisabledJohnDoeTrail = game:GetService("RunService").Heartbeat:Connect(function()
                RemoveTouchInterests()
            end)
        else
            if DisabledJohnDoeTrail then
                DisabledJohnDoeTrail:Disconnect()
            end
            WindUI:Notify({
                Title = "提示提示",
                Content = "约翰多乱码路径去除已关闭",
                Duration = 4
            })
        end
    end
})

Main:Toggle({
    Title = "反约翰多尖刺",
    Default = false,
    Callback = function(enabled)
        if enabled then
            WindUI:Notify({
                Title = "提示提示",
                Content = "反约翰多尖刺已开启",
                Duration = 4
            })
            
            local function RemoveSpikes()
                local map = workspace:FindFirstChild("Map")
                if not map then return end
                
                for _, spike in ipairs(map:GetDescendants()) do
                    if spike.Name == "Spike" then
                        safeDestroy(spike)
                    end
                end
            end

            RemoveSpikes()

            local AntiJohnDoeSpike = game:GetService("RunService").Heartbeat:Connect(RemoveSpikes)
        else
            if AntiJohnDoeSpike then
                AntiJohnDoeSpike:Disconnect()
            end
            WindUI:Notify({
                Title = "提示提示",
                Content = "反约翰多尖刺已关闭",
                Duration = 4
            })
        end
    end
})

Main:Toggle({
    Title = "自动删除约翰多陷阱",
    Default = false,
    Callback = function(enabled)
        if enabled then
            WindUI:Notify({
                Title = "提示提示",
                Content = "约翰多陷阱去除已开启",
                Duration = 4
            })
            
            local function CleanShadows()
                local map = workspace:FindFirstChild("Map")
                if not map then return end
                
                local ingame = map:FindFirstChild("Ingame")
                if not ingame then return end
                
                for _, shadow in ipairs(ingame:GetDescendants()) do
                    if shadow.Name == "Shadow" then
                        removeTouchInterests(shadow)
                        safeDestroy(shadow)
                    end
                end
            end

            CleanShadows()

            local AntiJohnDoeStomp = game:GetService("RunService").Heartbeat:Connect(function()
                CleanShadows()
            end)
        else
            if AntiJohnDoeStomp then
                AntiJohnDoeStomp:Disconnect()
            end
            WindUI:Notify({
                Title = "提示提示",
                Content = "约翰多陷阱去除已关闭",
                Duration = 4
            })
        end
    end
})
local AutoPopup = {
    Enabled = false,
    Task = nil,
    Connections = {},
    Interval = 0.5
}

local function deletePopups()
    if not LocalPlayer or not LocalPlayer:FindFirstChild("PlayerGui") then
        return false
    end
    
    local tempUI = LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
    if not tempUI then
        return false
    end
    
    local deleted = false
    for _, popup in ipairs(tempUI:GetChildren()) do
        if popup.Name == "1x1x1x1Popup" then
            popup:Destroy()
            deleted = true
        end
    end
    return deleted
end

local function triggerEntangled()
    local args = { [1] = "Entangled" }
    pcall(function()
        RemoteEvent:FireServer(unpack(args))
    end)
end

Main:Toggle({
    Title = "反1x4弹窗",
    Default = false,
    Callback = function(enabled)
        if enabled then
            WindUI:Notify({
                Title = "提示提示",
                Content = "反1x4弹窗已开启",
                Duration = 4
            })
            
        
            local function updateSurvivors()
             
            end
            local function updateKillers()
            
            end
            
            updateSurvivors()
            updateKillers()
            local lastTime = os.clock()
            AutoPopup.Connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
                local deltaTime = os.clock() - lastTime
                lastTime = os.clock()
                deletePopups()
                triggerEntangled()
            end)
        else
            for _, conn in pairs(AutoPopup.Connections) do
                conn:Disconnect()
            end
            AutoPopup.Connections = {}
            
            WindUI:Notify({
                Title = "提示提示",
                Content = "反1x4弹窗已关闭",
                Duration = 4
            })
        end
    end
})

Main:Slider({
    Title = "执行间隔(秒)",
    Desc = "设置自动执行的间隔时间",
    Value = {
        Min = 0.5,
        Max = 3.5,
        Default = 0.5,
    },
    Callback = function(value)
        AutoPopup.Interval = value
        WindUI:Notify({
            Title = "提示提示",
            Content = "执行间隔设置为: " .. value .. "秒",
            Duration = 4
        })
    end
})

local Main = Window:Tab({Title = "人物", Icon = "settings"})
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StaminaSettings = {
    MaxStamina = 100,
    StaminaGain = 25,
    StaminaLoss = 10,
    SprintSpeed = 28,
    InfiniteGain = 9999
}
local SettingToggles = {
    MaxStamina = false,
    StaminaGain = false,
    StaminaLoss = false,
    SprintSpeed = false
}
local SprintingModule = ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Character"):WaitForChild("Game"):WaitForChild("Sprinting")
local GetModule = function() return require(SprintingModule) end
task.spawn(function()
    while true do
        local m = GetModule()
        for key, value in pairs(StaminaSettings) do
            if SettingToggles[key] then
                m[key] = value
            end
        end
        task.wait(0.5)
    end
end)
local bai = {Spr = false}
local connection

Main:Toggle({
    Title = "无限体力",
    Default = false,
    Callback = function(state)
        bai.Spr = state
        local Sprinting = GetModule()

        if state then
            Sprinting.StaminaLoss = 0
            Sprinting.StaminaGain = StaminaSettings.InfiniteGain

            if connection then connection:Disconnect() end
            connection = RunService.Heartbeat:Connect(function()
                if not bai.Spr then return end
                Sprinting.StaminaLoss = 0
                Sprinting.StaminaGain = StaminaSettings.InfiniteGain
            end)
            
            WindUI:Notify({
                Title = "提示提示",
                Content = "无限体力已开启",
                Duration = 4
            })
        else
            Sprinting.StaminaLoss = StaminaSettings.StaminaLoss
            Sprinting.StaminaGain = StaminaSettings.StaminaGain

            if connection then
                connection:Disconnect()
                connection = nil
            end
            
            WindUI:Notify({
                Title = "提示提示",
                Content = "无限体力已关闭",
                Duration = 4
            })
        end
    end
})


Main:Toggle({
    Title = "启用体力大小调节",
    Default = false,
    Callback = function(Value)
        SettingToggles.MaxStamina = Value
        WindUI:Notify({
            Title = "提示提示",
            Content = Value and "体力大小调节已启用" or "体力大小调节已禁用",
            Duration = 4
        })
    end
})

Main:Toggle({
    Title = "启用体力恢复调节",
    Default = false,
    Callback = function(Value)
        SettingToggles.StaminaGain = Value
        WindUI:Notify({
            Title = "提示提示",
            Content = Value and "体力恢复调节已启用" or "体力恢复调节已禁用",
            Duration = 4
        })
    end
})

Main:Toggle({
    Title = "启用体力消耗调节",
    Default = false,
    Callback = function(Value)
        SettingToggles.StaminaLoss = Value
        WindUI:Notify({
            Title = "提示提示",
            Content = Value and "体力消耗调节已启用" or "体力消耗调节已禁用",
            Duration = 4
        })
    end
})

Main:Toggle({
    Title = "启用速度",
    Default = false,
    Callback = function(Value)
        SettingToggles.SprintSpeed = Value
        WindUI:Notify({
            Title = "提示提示",
            Content = Value and "奔跑速度调节已启用" or "奔跑速度调节已禁用",
            Duration = 4
        })
    end
})

Main:Slider({
    Title = "无限体力恢复速度",
    Value = {
        Min = 0,
        Max = 50000,
        Default = 9999,
    },
    Callback = function(Value)
        StaminaSettings.InfiniteGain = Value
        WindUI:Notify({
            Title = "提示提示",
            Content = "无限体力恢复速度设置为: " .. Value,
            Duration = 4
        })
    end
})

Main:Slider({
    Title = "体力大小",
    Value = {
        Min = 0,
        Max = 99999,
        Default = 100,
    },
    Callback = function(Value)
        StaminaSettings.MaxStamina = Value
        WindUI:Notify({
            Title = "提示提示",
            Content = "体力大小设置为: " .. Value,
            Duration = 4
        })
    end
})

Main:Slider({
    Title = "体力恢复",
    Value = {
        Min = 0,
        Max = 250,
        Default = 25,
    },
    Callback = function(Value)
        StaminaSettings.StaminaGain = Value
        WindUI:Notify({
            Title = "提示提示",
            Content = "体力恢复速度设置为: " .. Value,
            Duration = 4
        })
    end
})

Main:Slider({
    Title = "体力消耗",
    Value = {
        Min = 0,
        Max = 100,
        Default = 10,
    },
    Callback = function(Value)
        StaminaSettings.StaminaLoss = Value
        WindUI:Notify({
            Title = "提示提示",
            Content = "体力消耗速度设置为: " .. Value,
            Duration = 4
        })
    end
})

Main:Slider({
    Title = "走路速度",
    Value = {
        Min = 0,
        Max = 200,
        Default = 28,
    },
    Callback = function(Value)
        StaminaSettings.SprintSpeed = Value
        WindUI:Notify({
            Title = "提示提示",
            Content = "奔跑速度设置为: " .. Value,
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