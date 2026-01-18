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
    Title = "紧急汉堡",
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

local AntiCheatTab = Window:Tab({Title = "系统", Icon = "shield"})

AntiCheatTab:Section({Title = "两个都开"})

AntiCheatTab:Button({
    Title = "饶过检测",
    Callback = function()
        local function funcnil()
            local func = nil
            for i,v in pairs(getgc(true)) do
                if type(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.Code.controllers.antiCheatController and tostring(getinfo(v).name) ~= nil and tostring(getinfo(v).name) ~= "" then
                    func = v
                end
            end
            return func
        end
        
        repeat task.wait()
            for i,v in pairs(getgc(true)) do
                if type(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.Code.controllers.antiCheatController then
                    warn(getinfo(v).name)
                    hookfunction(v,function()
                        return 
                    end)
                end
            end
            wait(1)
            print(funcnil())
        until funcnil() == nil
        wait(2)
        warn("反检测已禁用")
    end
})

AntiCheatTab:Toggle({
    Title = "防挂机",
    Default = false,
    Callback = function(state)
        if state then
            warn("防挂机运行中")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                warn("触发防挂机")
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):ClickButton2(Vector2.new())
            end)
        end
    end
})

local AutoWorkTab = Window:Tab({Title = "自动工作", Icon = "clock"})

AutoWorkTab:Toggle({
    Title = "自动公交车司机",
    Default = false,
    Callback = function(state)
        getfenv().busman = state
        if state then
            spawn(function()
                while getfenv().busman do
                    task.wait()
                    pcall(function()
                        local plr = game.Players.LocalPlayer
                        local car = workspace.Vehicles:FindFirstChild(plr.Name)
                        if workspace.Vehicles:FindFirstChild(plr.Name) and string.find(tostring(car:GetAttribute("Model")),"Bus Driver") and partfind() ~= nil and game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                            car.DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                        end
                    end)
                end
            end)
            
            spawn(function()
                while getfenv().busman do
                    task.wait()
                    pcall(function()
                        if game.Players.LocalPlayer.Character.Humanoid.Health < 60 and game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                            game.Players.LocalPlayer.Character:BreakJoints()
                            warn("角色血量过低，已重置")
                        end
                    end)
                end
            end)
            
            while getfenv().busman do
                wait()
                pcall(function()
                    workspace.Gravity = 196
                    local plr = game.Players.LocalPlayer
                    local car = workspace.Vehicles[plr.Name]
                    if workspace.Vehicles:FindFirstChild(plr.Name) and game.Players.LocalPlayer.Team ~= game:GetService("Teams").BusCompany then
                        repeat wait()
                            workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                        until game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil
                        wait()
                        workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(CFrame.new(-1683.09375, 15.630923271179199, -1286.167236328125))
                        wait(5)
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                        wait(2)
                        
                        if game.Players.LocalPlayer:DistanceFromCharacter(Vector3.new(-1683.09375, 5.630923271179199, -1286.167236328125)) < 50 then
                           
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(-1708.8741455078125, 5.616213321685791, -1281.946044921875))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(-1730.544677734375, 5.683385848999023, -1280.9140625))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            
                          
                            repeat wait()
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"E",false,game)
                            until shiftfind() ~= nil
                            
                            wait(3)
                            local busdriver = getfenv().drivertype or "Rural Bus Driver"
                            for i,v in pairs(shiftfind():GetDescendants()) do
                                if v.ClassName == "ImageButton" and v.Name == busdriver then
                                    if v.Parent ~= nil then
                                        firesignal(v.MouseButton1Click)
                                    end
                                end
                            end
                            
                            wait(3)
                            for i,v in pairs(shiftfind():GetDescendants()) do
                                if v.ClassName == "ImageButton" and v.ImageColor3 == Color3.fromRGB(142, 68, 173) then
                                    if v.Parent ~= nil then
                                        firesignal(v.MouseButton1Click)
                                    end
                                end
                            end
                            
                            wait(2)
                          
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(-1722.3858642578125, 5.645286560058594, -1264.3126220703125))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            
                            repeat wait()
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"E",false,game)
                            until dealership() ~= nil and dealership().Enabled == true or partfind() ~= nil
                            
                            wait(2)
                            for i,v in pairs(dealership():GetDescendants()) do
                                if v.ClassName == "TextLabel" and v.Text == "Stuttgart Omnibus" then
                                    local plr = game.Players.LocalPlayer
                                    repeat wait()
                                        if v.Parent ~= nil then
                                            firesignal(v.Parent.MouseButton1Click)
                                            for a,b in pairs(dealership():GetDescendants()) do
                                                if b.ClassName == "ImageButton" and b:FindFirstChildOfClass("TextLabel").Text == "Spawn Vehicle" or b.ClassName == "ImageButton" and b:FindFirstChildOfClass("TextLabel").Text == "Unlock Vehicle" then
                                                    firesignal(b.MouseButton1Click)
                                                end
                                            end
                                        end
                                    until workspace.Vehicles:FindFirstChild(plr.Name) and partfind() ~= nil or partfind() ~= nil
                                end
                            end
                        end
                    elseif partfind() ~= nil and game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                     
                        workspace.Gravity = 0
                        local plr = game.Players.LocalPlayer
                        local chr = plr.Character
                        local car = workspace.Vehicles[plr.Name]
                        car.PrimaryPart = car.Body.Mass
                        local pos = destination() or partfind()
                        
                      
                        if (car.WorldPivot.Position-Vector3.new(pos.Position.X,car.PrimaryPart.Position.Y,pos.Position.Z)).magnitude > 100 then
                            local TweenService = game:GetService("TweenService")
                            local TweenInfoToUse = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
                            local TweenValue = Instance.new("CFrameValue")
                            TweenValue.Value = car.WorldPivot
                            TweenValue.Changed:Connect(function()
                                car:PivotTo(TweenValue.Value)
                            end)
                            getfenv().tween = TweenService:Create(TweenValue, TweenInfoToUse, {Value=car.WorldPivot+Vector3.new(0,1000,0)})
                            getfenv().tween:Play()
                            repeat task.wait()
                            until getfenv().tween.PlaybackState == Enum.PlaybackState.Cancelled or getfenv().tween.PlaybackState == Enum.PlaybackState.Completed or getfenv().tween.PlaybackState == Enum.PlaybackState.Paused
                        end
                        
                    
                        local plr = game.Players.LocalPlayer
                        local pos = destination() or partfind()
                        local car = workspace.Vehicles[plr.Name]
                        if (car.WorldPivot.Position-Vector3.new(pos.Position.X,car.PrimaryPart.Position.Y,pos.Position.Z)).magnitude < 100 then
                            car:PivotTo(pos.CFrame)
                            workspace.Gravity = 196
                            for i,v in pairs(workspace.BusStops:GetDescendants()) do
                                if v.Name == "SelectionBox" and v.Visible == true then
                                    car:PivotTo(v.Parent.CFrame+Vector3.new(0,5,0))
                                end
                            end
                            local time = tick()
                            repeat task.wait()
                            until partfind() == nil or game.Players.LocalPlayer:DistanceFromCharacter(partfind().Position) > 70 or tick() - time >= 5
                        end
                    end
                end)
            end
        end
    end
})

AutoWorkTab:Toggle({
    Title = "自动卡车司机",
    Default = false,
    Callback = function(state)
        getfenv().trucker = state
        if state then
            spawn(function()
                while getfenv().trucker do
                    task.wait()
                    pcall(function()
                        if workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name) and workspace.Vehicles[game.Players.LocalPlayer.Name].Body:FindFirstChild("Trailer") and game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                            local plr = game.Players.LocalPlayer
                            local car = workspace.Vehicles[plr.Name]
                            if getfenv().tween ~= nil then
                                getfenv().tween:Cancel()
                                print("Tween Cancelled")
                            end
                            car.DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                        end
                    end)
                end
            end)
            
            spawn(function()
                while getfenv().trucker do
                    task.wait()
                    pcall(function()
                        if game.Players.LocalPlayer.Character.Humanoid.Health < 60 and game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                            game.Players.LocalPlayer.Character:BreakJoints()
                            warn("角色血量过低，已重置")
                        end
                    end)
                end
            end)
            
            spawn(function()
                while getfenv().trucker do
                    task.wait()
                    pcall(function()
                        for i,v in pairs(workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):GetDescendants()) do
                            pcall(function()
                                v.Velocity = Vector3.new(0,0,0)
                            end)
                        end
                    end)
                end
            end)
            
            while getfenv().trucker do
                wait()
                pcall(function()
                    workspace.Gravity = 196
                    if workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name) and not workspace.Vehicles[game.Players.LocalPlayer.Name].Body:FindFirstChild("Trailer") then
                        repeat wait()
                            workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                        until game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil
                        wait()
                        workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(CFrame.new(717.53125, 15.626567840576172, 1462.559814453125))
                        wait(1)
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                        wait(2)
                        
                        if game.Players.LocalPlayer:DistanceFromCharacter(Vector3.new(717.53125, 15.626567840576172, 1462.559814453125)) < 50 then
                            -- 移动到工作地点
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(712.7074584960938, 5.587162017822266, 1437.5025634765625))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(707.704345703125, 5.657994270324707, 1426.1021728515625))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            
                            -- 开始工作
                            repeat wait()
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"E",false,game)
                            until shiftfind() ~= nil
                            
                            wait(3)
                            local timestried = 0 
                            repeat wait()
                                if game.Players.LocalPlayer.Team ~= game:GetService("Teams").TruckCompany then
                                    repeat wait()
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false,"E",false,game)
                                    until shiftfind() ~= nil
                                    task.wait(1)
                                    if game.Players.LocalPlayer.Team ~= game:GetService("Teams").TruckCompany and timestried > 10 then
                                        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
                                            if v.ClassName == "TextLabel" and v.Text == "Start Shift" then
                                                firesignal(v.Parent.MouseButton1Click)
                                            end
                                        end
                                        timestried = 0
                                    end
                                    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
                                        if v.ClassName == "ImageButton" and v.ImageColor3 == Color3.fromRGB(39, 174, 96) then
                                            if v.Parent ~= nil then
                                                pcall(function()
                                                    firesignal(v.MouseButton1Down)
                                                end)
                                            end
                                        end
                                    end
                                    timestried=timestried+1
                                    task.wait(1)
                                end
                            until findxpui() ~= nil
                            
                            -- 选择任务
                            repeat wait()
                            until findxpui() ~= nil and findxpui().Enabled == true
                            _G.rat = nil
                            local num = 0
                            for i,v in pairs(findxpui():GetDescendants()) do
                                if v.ClassName == "TextLabel" and string.find(v.Text,"XP") then
                                    local Val = tonumber(v.Text:split(" ")[1])
                                    if Val > num then
                                        num = Val
                                        print(Val)
                                        _G.rat = v.Parent
                                    end
                                end
                            end
                            if _G.rat ~= nil then
                                firesignal(_G.rat.MouseButton1Click)
                            end
                            
                            -- 前往车辆经销商
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(699.1327514648438, 5.645294189453125, 1407.9368896484375))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(700.1976318359375, 5.645294189453125, 1408.7381591796875))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            
                            repeat wait()
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"E",false,game)
                            until dealership()~= nil and dealership().Enabled == true
                            
                          
                            for i,v in pairs(dealership():GetDescendants()) do
                                if v.ClassName == "TextLabel" and v.Text == "Stuttgart Lastkraft" then
                                    repeat wait()
                                        if v.Parent ~= nil then
                                            firesignal(v.Parent.MouseButton1Click)
                                            wait(1)
                                            for a,b in pairs(dealership():GetDescendants()) do
                                                if b.ClassName == "TextLabel" and b.Text == "Spawn Vehicle" or b.ClassName == "TextLabel" and b.Text == "Unlock Vehicle" then
                                                    firesignal(b.Parent.MouseButton1Click)
                                                end
                                            end
                                        end
                                    until workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name) and workspace.Vehicles[game.Players.LocalPlayer.Name].Body:FindFirstChild("Trailer")
                                end
                            end
                        end
                    elseif workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name) and workspace.Vehicles[game.Players.LocalPlayer.Name].Body:FindFirstChild("Trailer") and game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                        -- 自动运送货物
                        workspace.Gravity = 0
                        local plr = game.Players.LocalPlayer
                        local chr = plr.Character
                        local car = workspace.Vehicles[plr.Name]
                        local pos = destination() or partfind()
                        car.PrimaryPart = car.Body.Mass
                        
                        -- 飞行到目的地
                        if (car.WorldPivot.Position-Vector3.new(pos.Position.X,car.PrimaryPart.Position.Y,pos.Position.Z)).magnitude > 100 then
                            car:PivotTo(car.WorldPivot+Vector3.new(0,500,0))
                        end
                        
                        local plr = game.Players.LocalPlayer
                        local pos = destination() or partfind()
                        local car = workspace.Vehicles[plr.Name]
                        if (car.WorldPivot.Position-Vector3.new(pos.Position.X,car.PrimaryPart.Position.Y,pos.Position.Z)).magnitude > 100 then
                            local TweenService = game:GetService("TweenService")
                            local TweenInfoToUse = TweenInfo.new(dist/80, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
                            local TweenValue = Instance.new("CFrameValue")
                            TweenValue.Value = car.WorldPivot
                            TweenValue.Changed:Connect(function()
                                car:PivotTo(TweenValue.Value)
                            end)
                            getfenv().tween = TweenService:Create(TweenValue, TweenInfoToUse, {Value=pos.CFrame+Vector3.new(0,500,0)})
                            getfenv().tween:Play()
                            repeat task.wait()
                            until getfenv().tween.PlaybackState == Enum.PlaybackState.Cancelled or getfenv().tween.PlaybackState == Enum.PlaybackState.Completed or getfenv().tween.PlaybackState == Enum.PlaybackState.Paused
                        end
                        
                        -- 降落
                        local plr = game.Players.LocalPlayer
                        local pos = destination() or partfind()
                        local car = workspace.Vehicles[plr.Name]
                        if (car.WorldPivot.Position-Vector3.new(pos.Position.X,car.PrimaryPart.Position.Y,pos.Position.Z)).magnitude < 100 then
                            car:PivotTo(pos.CFrame)
                            workspace.Gravity = 196
                            for i,v in pairs(workspace.DeliveryDestinations:GetDescendants()) do
                                if v.Name == "SelectionBox" and v.Visible == true then
                                    car:PivotTo(v.Parent.CFrame+Vector3.new(0,5,0))
                                end
                            end
                            local time = tick()
                            repeat task.wait()
                            until partfind() == nil or game.Players.LocalPlayer:DistanceFromCharacter(partfind().Position) > 70 or tick() - time > 40
                        end
                    end
                end)
            end
        end
    end
})

local PlayerTab = Window:Tab({Title = "玩家设置", Icon = "user"})

PlayerTab:Toggle({
    Title = "防坠落伤害",
    Default = false,
    Callback = function(state)
        getfenv().ANTIFALL = state
        if getfenv().ANTIFALL then
            getfenv().nofall = game:GetService("RunService").RenderStepped:Connect(function()
                if workspace:Raycast(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(0, -20, 0)).Instance ~= nil and 
                   game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity.Y < -30 then 
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                end
            end)
        else
            getfenv().nofall:Disconnect()
        end
    end
})

PlayerTab:Toggle({
    Title = "防倒地",
    Default = false,
    Callback = function(state)
        getfenv().downed = state
        if getfenv().downed == true then
            getfenv().antichanged1 = game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                game.Players.LocalPlayer.Character.Humanoid.Health = 100
            end)
        else
            getfenv().antichanged1:Disconnect()
        end
    end
})

PlayerTab:Button({
    Title = "重置角色",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end
})

PlayerTab:Button({
    Title = "无限耐力",
    Callback = function()
        if getfenv().firsttime == nil then
            getfenv().firsttime = true
            local func 
            for i,v in pairs(getgc(true)) do
                if type(v) == "function" and getinfo(v).name == "setStamina" then
                    warn(getinfo(v).name)
                    func = v
                end
            end
            hookfunction(func,function(...)
                local args = {...}
                return args[1],math.huge
            end)
        end
    end
})

local AimbotTab = Window:Tab({Title = "自动瞄准", Icon = "crosshair"})

local function teams()
    local teams = {"选择敌方队伍"}
    for i,v in pairs(game:GetService("Teams"):GetChildren()) do
        table.insert(teams,v.Name)
    end
    return teams
end

AimbotTab:Dropdown({
    Title = "选择敌方队伍",
    Values = teams(),
    Callback = function(state) 
        if state ~= "选择敌方队伍" then
            getfenv().enemy = state
        end
    end
})

AimbotTab:Toggle({
    Title = "自动瞄准",
    Default = false,
    Callback = function(state)
        getfenv().aimbot = state
        local function canaim(ye)
            return game:GetService("Players").LocalPlayer:DistanceFromCharacter(ye) < 3
        end
        
        while getfenv().aimbot do
            task.wait()
            if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and canaim(workspace.Camera.CFrame.Position) then
                local plr = nil
                local distance = math.huge
                for a,b in pairs(game.Players:GetPlayers()) do
                    if b.Team.Name == getfenv().enemy then
                        pcall(function()
                            local Dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - b.Character.Head.Position).magnitude
                            if Dist < distance then
                                distance = Dist
                                plr = b
                            end
                        end)
                    end
                end
                if plr ~= nil then
                    workspace.Camera.CameraType = "Follow"
                    workspace.Camera.CFrame = CFrame.new(workspace.Camera.CFrame.Position,plr.Character.Head.Position)
                end
            end
        end
    end
})

AimbotTab:Toggle({
    Title = "高亮敌人",
    Default = false,
    Callback = function(state)
        getfenv().highlight = state
        if getfenv().highlight == false then
            for i,v in pairs(game.Players:GetChildren()) do
                if v.ClassName == "Player" and v.Team.Name == getfenv().enemy and v.Character ~= nil and v.Character:FindFirstChild("Highlight") then
                    v.Character:FindFirstChild("Highlight"):Destroy()
                    task.wait()
                end
            end
        end
        while getfenv().highlight do
            task.wait()
            for i,v in pairs(game.Players:GetChildren()) do
                if v.ClassName == "Player" and v.Team.Name == getfenv().enemy and v.Character ~= nil and not v.Character:FindFirstChild("Highlight") then
                    Instance.new("Highlight",v.Character)
                    task.wait()
                end
            end
        end
    end
})

local TeleportTab = Window:Tab({Title = "传送", Icon = "map-pin"})

TeleportTab:Section({Title = "传送点1"})
TeleportTab:Dropdown({
    Title = "选择传送点",
    Values = {"传送点","警察局","银行","停车场","珠宝店","监狱","公交公司","卡车公司","医院"},
    Callback = function(state)
        print(state)
        workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).Body.Mass
        if state == "警察局" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-1549.2081298828125, 5.615050315856934, 2935.314697265625)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2
        elseif state == "银行" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-1174.68115234375, 5.874685287475586, 3209.03271484375)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2
        elseif state == "停车场" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-993.5323486328125, -11.622750282287598, 3705.0126953125)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2
        elseif state == "珠宝店" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-396.0776062011719, 5.6145405769348145, 3508.26318359375)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "监狱" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-548.9014282226562, 5.6149725914001465, 2832.7587890625)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "卡车公司" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(717.53125, 15.626567840576172, 1462.559814453125)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "公交公司" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-1683.09375, 15.630923271179199, -1286.167236328125)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "医院" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-304.7102966308594, 5.623022079467773, 1018.22119140625)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        end
    end
})

TeleportTab:Section({Title = "传送点2"})
TeleportTab:Dropdown({
    Title = "选择传送点",
    Values = {"传送点","工具店","汽车经销商","农场商店","Ares加油站","Osso加油站","Gas-N-Go加油站"},
    Callback = function(state)
        print(state)
        workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).Body.Mass
        if state == "工具店" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-733.7286376953125, 5.614245414733887, 677.4180908203125)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "汽车经销商" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-1422.2327880859375, 5.624246120452881, 939.8997802734375)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "农场商店" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-840.9263305664062, 5.378037929534912, -1179.6783447265625)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "Ares加油站" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-873.4227294921875, 5.614551067352295, 1500.887451171875)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "Osso加油站" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-26.49447250366211, 5.615009307861328, -766.71630859375)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "Gas-N-Go加油站" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-1544.445556640625, 5.628605842590332, 3811.127685546875)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        end
    end
})

local function destination()
    local dest = nil
    for i,v in pairs(workspace.DeliveryDestinations:GetDescendants()) do
        if v.Name == "SelectionBox" and v.Visible == true and v.Transparency ~= 1 then
            dest = v.Parent
        end
    end
    return dest
end

local function getplayer(plr)
    local player = nil
    for i,v in pairs(game.Players:GetPlayers()) do
        if string.find(v.Name,plr) or string.find(v.DisplayName,plr) then
            player = v.Name
            break
        end
    end
    return player
end

local function shiftfind()
    local shift = nil
    local uifind = nil
    local busdriver = getfenv().drivertype or "Rural Bus Driver"
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
        if v.ClassName == "TextLabel" and v.Text == "Start Shift" or v.ClassName == "ImageButton" and v.Name == busdriver then
            shift = v.Parent
        end
    end
    if shift ~= nil then
        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
            if shift:IsDescendantOf(v) then
                uifind = v
            end
        end
    end
    return uifind
end

local function dealership()
    local deal = nil
    local uifind = nil
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
        if v.ClassName == "TextLabel" and v.Text == "Stuttgart Lastkraft" or v.ClassName == "TextLabel" and v.Text == "Stuttgart Omnibus" then
            deal = v
        end
    end
    if deal ~= nil then
        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
            if deal:IsDescendantOf(v) then
                uifind = v
            end
        end
    end
    return uifind
end

local function partfind()
    local part = nil
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
        if v.ClassName == "BillboardGui" and v.Adornee ~= nil then
            part = v.Adornee
        end
    end
    return part
end

local function findxpui() 
    local xpui = nil
    local test = nil
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
        if v.ClassName == "TextLabel" and string.find(v.Text,"XP") and v.Parent.ClassName == "ImageButton" and tonumber(v.Text:split(" ")[1]) then
            test = v
            break
        end
    end
    if test ~= nil then
        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
            if test:IsDescendantOf(v) then
                xpui = v
            end
        end
    end
    return xpui
end
getfenv().jump = game.Players.LocalPlayer.Character.Humanoid.JumpHeight































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