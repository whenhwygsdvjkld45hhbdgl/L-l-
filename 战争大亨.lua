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
    Title = "战争大亨",
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





        local Main = Window:Tab({Title = "主要", Icon = "settings"})
local autoCrateEnabled = false
local crateThread = nil

Main:Toggle({
    Title = "自动箱子",
    Default = false,
    Callback = function(Value)
        autoCrateEnabled = Value
        
        if Value then
            if crateThread then
                coroutine.close(crateThread)
                crateThread = nil
            end
            
            crateThread = coroutine.create(function()
                local TweenService = game:GetService("TweenService")
                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer
                local Crate = workspace["Game Systems"]["Crate Workspace"]
                local Oil = workspace.Tycoon.Tycoons[LocalPlayer.Team.Name].Essentials["Oil Collector"]
                
                while autoCrateEnabled do
                    for _, crate in Crate:GetChildren() do
                        if not autoCrateEnabled then break end
                        
                        local StealPrompt = crate:WaitForChild("StealPrompt")
                        if StealPrompt.Enabled then
                            StealPrompt.MaxActivationDistance = 10
                            LocalPlayer.Character.HumanoidRootPart.CFrame = crate.CFrame
                            StealPrompt.PromptShown:Wait()
                            task.wait(1)
                            StealPrompt:InputHoldBegin()
                            StealPrompt.Triggered:Wait()
                            
                            local Tween = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(), {
                                CFrame = Oil:WaitForChild("CratePromptPart").CFrame
                            })
                            Tween:Play()
                            
                            Oil:WaitForChild("CratePromptPart"):WaitForChild("SellPrompt").PromptShown:Wait()
                            task.wait(1)
                            fireproximityprompt(Oil:WaitForChild("CratePromptPart"):WaitForChild("SellPrompt"))
                        end
                    end
                    task.wait(0.5)
                end
            end)
            
            coroutine.resume(crateThread)
            WindUI:Notify({
                Title = "自动开启",
                Content = "自动箱子功能已启动",
                Icon = "📦",
                Duration = 3
            })
        else
            if crateThread then
                coroutine.close(crateThread)
                crateThread = nil
            end
            WindUI:Notify({
                Title = "自动关闭",
                Content = "自动箱子功能已停止",
                Icon = "⏹️",
                Duration = 3
            })
        end
    end
})

local autoUpgradeEnabled = false
local upgradeThread = nil

Main:Toggle({
    Title = "自动升级基地",
    Default = false,
    Callback = function(Value)
        autoUpgradeEnabled = Value
        
        if Value then
            if upgradeThread then
                coroutine.close(upgradeThread)
                upgradeThread = nil
            end
            
            upgradeThread = coroutine.create(function()
                while autoUpgradeEnabled do
                  
                    local tycoon = workspace.Tycoon.Tycoons[game.Players.LocalPlayer.Team.Name]
                    if tycoon then
                        local upgradeButtons = tycoon:FindFirstChild("UpgradeButtons")
                        if upgradeButtons then
                            for _, button in pairs(upgradeButtons:GetChildren()) do
                                if not autoUpgradeEnabled then break end
                                
                                local prompt = button:FindFirstChild("Prompt")
                                if prompt and prompt:IsA("ProximityPrompt") then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = button.CFrame
                                    fireproximityprompt(prompt)
                                    task.wait(1)
                                end
                            end
                        end
                    end
                    task.wait(2)
                end
            end)
            
            coroutine.resume(upgradeThread)
            WindUI:Notify({
                Title = "升级开启",
                Content = "自动升级功能已启动",
                Icon = "",
                Duration = 3
            })
        else
            if upgradeThread then
                coroutine.close(upgradeThread)
                upgradeThread = nil
            end
            WindUI:Notify({
                Title = "升级关闭",
                Content = "自动升级功能已停止",
                Icon = "",
                Duration = 3
            })
        end
    end
})

-- 坠落无伤害功能
local blockFDMG = false
local oldNamecall = nil
local isHookActive = false

local function initHook()
    if isHookActive then return end
    
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        if blockFDMG and getnamecallmethod() == "FireServer" and tostring(self) == "FDMG" then
            return nil
        end
        return oldNamecall(self, ...)
    end)
    
    isHookActive = true
end

local function removeHook()
    if not isHookActive or not oldNamecall then return end
    
    hookmetamethod(game, "__namecall", oldNamecall)
    oldNamecall = nil
    isHookActive = false
end

Main:Toggle({
    Title = "坠落无伤害",
    Default = false,
    Callback = function(Value)
        blockFDMG = Value
        
        if Value then
            if not isHookActive then
                initHook()
                WindUI:Notify({
                    Title = "保护开启",
                    Content = "坠落伤害已禁用",
                    Icon = "✓",
                    Duration = 3
                })
            end
        else
            if isHookActive then
                removeHook()
                WindUI:Notify({
                    Title = "保护关闭",
                    Content = "坠落伤害已启用",
                    Icon = "⚠️",
                    Duration = 3
                })
            end
        end
    end
})

-- 删除所有门功能
Main:Button({
    Title = "删除所有门",
    Callback = function()
        local deletedCount = 0
        for _, tycoon in pairs(Workspace.Tycoon.Tycoons:GetChildren()) do
            for _, obj in pairs(tycoon.PurchasedObjects:GetChildren()) do
                if obj.Name:find("Door") or obj.Name:find("Gate") then 
                    obj:Destroy()
                    deletedCount = deletedCount + 1
                end
            end
        end
        
        WindUI:Notify({
            Title = "清理完成",
            Content = "已删除 " .. deletedCount .. " 个门/闸门",
            Icon = "🗑️",
            Duration = 3
        })
    end
})

-- 无CD状态功能
Main:Toggle({
    Title = "无CD状态",
    Default = false,
    Callback = function(Value)
        if Value then
            local ContextActions = game:GetService("Workspace")[game.Players.LocalPlayer.Name].ContextActions
            local ContextMain = require(ContextActions.ContextMain)
            
            ContextMain:New({
                RobPlayerLength = 0.1,
                FixWallLength = 0.1,
                CrackSafeLength = 0.1,
                RobSafeLength = 0.1,
                RobRegisterLength = 0.1,
                PickCellLength = 0.1,
                SkinAnimalLength = 0.1
            }, 200, {
                "Get out of my shop! Outlaws are not welcome here!",
                "Hey, scoundrel! Get out before I call the sheriff!",
                "You're an outlaw! We don't serve your type here!"
            }, {
                "This here's a bandit camp! Get out!",
                "Get lost, cowboy!",
                "Are you an outlaw? Didn't think so! Scram!"
            })
            
            WindUI:Notify({
                Title = "CD移除",
                Content = "所有动作冷却时间已移除",
                Icon = "⚡",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "CD恢复",
                Content = "动作冷却时间已恢复正常",
                Icon = "⏰",
                Duration = 3
            })
        end
    end
})

-- 原地重生功能
local deathPosition = nil
local deathOrientation = nil

local function setupDeathTracking()
    local player = game.Players.LocalPlayer
    
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        
        humanoid.Died:Connect(function()
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                deathPosition = rootPart.Position
                deathOrientation = rootPart.CFrame - rootPart.Position
            end
        end)
    end)
    
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    deathPosition = rootPart.Position
                    deathOrientation = rootPart.CFrame - rootPart.Position
                end
            end)
        end
    end
end

setupDeathTracking()

Main:Button({
    Title = "原地重生",
    Description = "在死亡位置重生角色",
    Callback = function()
        if not deathPosition then
            WindUI:Notify({
                Title = "错误",
                Content = "没有记录死亡位置",
                Icon = "❌",
                Duration = 3
            })
            return
        end
        
        local player = game.Players.LocalPlayer
        local character = player.Character
        
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                WindUI:Notify({
                    Title = "提示",
                    Content = "角色仍然存活，无需重生",
                    Icon = "ℹ️",
                    Duration = 3
                })
                return
            end
        end
        
        local connection
        connection = player.CharacterAdded:Connect(function(newCharacter)
            local newRootPart = newCharacter:WaitForChild("HumanoidRootPart", 5)
            local newHumanoid = newCharacter:WaitForChild("Humanoid", 5)
            
            if newRootPart and newHumanoid then
                wait(0.5)
                newRootPart.CFrame = CFrame.new(deathPosition) * deathOrientation
                deathPosition = nil
                deathOrientation = nil
                
                WindUI:Notify({
                    Title = "重生成功",
                    Content = "已在死亡位置重生",
                    Icon = "🔄",
                    Duration = 3
                })
            end
            
            if connection then
                connection:Disconnect()
            end
        end)
        
        if not character then
            local currentTeam = player.Team
            player.Team = nil
            wait(0.1)
            player.Team = currentTeam
        else
            player:LoadCharacter()
        end
        
        delay(10, function()
            if connection then
                connection:Disconnect()
                WindUI:Notify({
                    Title = "超时",
                    Content = "重生过程超时",
                    Duration = 3,
                })
            end
        end)
    end
})
local Main = Window:Tab({Title = "武器", Icon = "settings"})
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

-- 获得RPG功能
local function getRPG()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local TycoonsFolder = workspace.Tycoon.Tycoons
    local savedPosition
    
    local function findNearestTeleportPosition()
        local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local playerPosition = humanoidRootPart.Position
        local closestDistance = math.huge
        local closestCFrame = nil
        
        for _, tycoonModel in ipairs(TycoonsFolder:GetChildren()) do
            if tycoonModel:IsA("Model") then
                local purchasedObjects = tycoonModel:FindFirstChild("PurchasedObjects")
                if purchasedObjects then
                    local rpgGiver = purchasedObjects:FindFirstChild("RPG Giver")
                    if rpgGiver then
                        local prompt = rpgGiver:FindFirstChild("Prompt")
                        if prompt and prompt:IsA("BasePart") then
                            local distance = (playerPosition - prompt.Position).Magnitude
                            if distance < closestDistance then
                                closestDistance = distance
                                closestCFrame = prompt.CFrame
                            end
                        end
                    end
                end
            end
        end
        return closestCFrame
    end

    local function teleportPlayer()
        local character = localPlayer.Character
        if not character then
            WindUI:Notify({
                Title = "错误",
                Content = "角色不存在",
                Icon = "x",
                Duration = 3
            })
            return
        end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            savedPosition = humanoidRootPart.CFrame
        end
        
        local targetCFrame = findNearestTeleportPosition()
        if targetCFrame then
            humanoidRootPart.CFrame = targetCFrame
            
            spawn(function()
                while wait(0.5) do
                    if not character.Parent then
                        break
                    end
                    
                    local backpack = localPlayer:FindFirstChild("Backpack")
                    if backpack and backpack:FindFirstChild("RPG") then
                        humanoidRootPart.CFrame = savedPosition
                        WindUI:Notify({
                            Title = "成功",
                            Content = "已获得RPG",
                            Icon = "✓",
                            Duration = 3
                        })
                        break
                    end
                end
            end)
        else
            WindUI:Notify({
                Title = "错误",
                Content = "未能找到RPG",
                Icon = "x",
                Duration = 3
            })
        end
    end
    
    teleportPlayer()
end

-- 全图RPG轰炸功能
local loopActive = false
local rpgAttackThread = nil
local C_NPlayers = {} -- 不攻击的玩家名单

local function startRPGAttack()
    if rpgAttackThread then
        coroutine.close(rpgAttackThread)
        rpgAttackThread = nil
    end
    
    rpgAttackThread = coroutine.create(function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RocketSystem = ReplicatedStorage:WaitForChild("RocketSystem")
        local FireRocket = RocketSystem.Events.FireRocket
        local RocketHit = RocketSystem.Events.RocketHit
        local attackPhase = "attack"
        local phaseStartTime = os.clock()
        
        while loopActive do
            local currentTime = os.clock()
            local elapsed = currentTime - phaseStartTime
            
            if not loopActive then break end
            
            if attackPhase == "attack" then
                if elapsed >= 3 then
                    attackPhase = "pause"
                    phaseStartTime = os.clock()
                else
                    local character = LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local attackPosition = character.HumanoidRootPart.Position + Vector3.new(0, 1000, 0)
                        local weapon = character:FindFirstChild("RPG")
                        
                        if weapon then
                            for _, player in ipairs(Players:GetPlayers()) do
                                if player ~= LocalPlayer and player.Character and not table.find(C_NPlayers, player.Name) then
                                    local target = player.Character:FindFirstChild("HumanoidRootPart")
                                    if target then
                                        FireRocket:InvokeServer(Vector3.new(), weapon, weapon, attackPosition)
                                        RocketHit:FireServer(attackPosition, Vector3.new(), weapon, weapon, target, nil, "asdfghvcqawRocket4")
                                        task.wait(0.3)
                                    end
                                end
                            end
                        else
                            WindUI:Notify({
                                Title = "警告",
                                Content = "未找到RPG武器",
                                Icon = "⚠️",
                                Duration = 3
                            })
                            loopActive = false
                            break
                        end
                    end
                end
            elseif attackPhase == "pause" then
                if elapsed >= 2 then
                    attackPhase = "attack"
                    phaseStartTime = os.clock()
                end
            end
            
            task.wait(0.1)
        end
    end)
    
    coroutine.resume(rpgAttackThread)
end

local function stopRPGAttack()
    loopActive = false
    if rpgAttackThread then
        coroutine.close(rpgAttackThread)
        rpgAttackThread = nil
    end
end

-- UI界面整合
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
            WindUI:Notify({
                Title = "保护开启",
                Content = "管理员检测已启用",
                Icon = "✓",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "保护关闭",
                Content = "管理员检测已禁用",
                Icon = "⚠️",
                Duration = 3
            })
        end
    end
})

Main:Button({
    Title = "获取RPG",
    Callback = function()
        getRPG()
    end
})

Main:Toggle({
    Title = "全图RPG轰炸",
    Default = false,
    Callback = function(Value)
        loopActive = Value
        if Value then
            startRPGAttack()
            WindUI:Notify({
                Title = "攻击开启",
                Content = "RPG轰炸已启动",
                Icon = "⚡",
                Duration = 3
            })
        else
            stopRPGAttack()
            WindUI:Notify({
                Title = "攻击关闭",
                Content = "RPG轰炸已停止",
                Icon = "✓",
                Duration = 3
            })
        end
    end
})

-- 不攻击玩家名单下拉菜单
local PlayerList = {}
for _, player in next, game:GetService("Players"):GetPlayers() do
    table.insert(PlayerList, player.Name)
end

Main:Dropdown({
    Title = "不攻击的玩家(多选)",
    Values = PlayerList,
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(selectedPlayers)
        C_NPlayers = selectedPlayers or {}
        WindUI:Notify({
            Title = "名单更新",
            Content = "已更新不攻击玩家名单",
            Icon = "✓",
            Duration = 3
        })
    end
})

-- 玩家列表刷新按钮
Main:Button({
    Title = "刷新玩家列表",
    Callback = function()
        PlayerList = {}
        for _, player in next, game:GetService("Players"):GetPlayers() do
            table.insert(PlayerList, player.Name)
        end
        WindUI:Notify({
            Title = "刷新成功",
            Content = "玩家列表已更新",
            Icon = "✓",
            Duration = 3
        })
    end
})

-- 玩家加入退出监听
game:GetService("Players").PlayerAdded:Connect(function(player)
    if not table.find(PlayerList, player.Name) then
        table.insert(PlayerList, player.Name)
    end
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    if table.find(PlayerList, player.Name) then
        table.remove(PlayerList, table.find(PlayerList, player.Name))
    end
end)

local shieldAttackActive = false
local shieldAttackThread = nil

Main:Toggle({
    Title = "护盾攻击",
    Default = false,
    Callback = function(Value)
        shieldAttackActive = Value
        
        if Value then
            if shieldAttackThread then
                coroutine.close(shieldAttackThread)
                shieldAttackThread = nil
            end
            
            shieldAttackThread = coroutine.create(function()
                while shieldAttackActive do
                    if not shieldAttackActive then break end
                    
                    local rpg = LP.Character and LP.Character:FindFirstChild("RPG")
                    if not rpg then
                        task.wait(1)
                        continue
                    end
                    
                    local attackPosition = LP.Character.HumanoidRootPart.Position + Vector3.new(0, 1000, 0)
                    local tycoonFolder = workspace:WaitForChild("Tycoon"):WaitForChild("Tycoons")
                    
                    for _, tycoon in ipairs(tycoonFolder:GetChildren()) do
                        if not shieldAttackActive then break end
                        
                        if tycoon:FindFirstChild("Owner") and tycoon.Owner.Value ~= LP then
                            local shield = tycoon:FindFirstChild("PurchasedObjects", true) and
                                          tycoon.PurchasedObjects:FindFirstChild("Base Shield", true) and
                                          tycoon.PurchasedObjects["Base Shield"]:FindFirstChild("Shield", true) and
                                          tycoon.PurchasedObjects["Base Shield"].Shield:FindFirstChild("Shield4", true)
                            
                            if shield then
                                local fireArgs = { Vector3.new(0, 0, 0), rpg, rpg, attackPosition }
                                
                                for _ = 1, 2 do
                                    local hitArgs = {attackPosition, Vector3.new(0, -1, 0), rpg, rpg, shield, nil, string.format("%sRocket%d", string.char(math.random(65, 90)), math.random(1, 1000))}
                                    RocketSystem.Events.RocketHit:FireServer(unpack(hitArgs))
                                    RocketSystem.Events.FireRocket:InvokeServer(unpack(fireArgs))
                                    task.wait(0.3)
                                end
                            end
                        end
                    end
                    
                    task.wait(0.3)
                end
            end)
            
            coroutine.resume(shieldAttackThread)
            WindUI:Notify({
                Title = "攻击开启",
                Content = "护盾攻击已启动",
                Icon = "🛡️",
                Duration = 3
            })
        else
            if shieldAttackThread then
                coroutine.close(shieldAttackThread)
                shieldAttackThread = nil
            end
            WindUI:Notify({
                Title = "攻击关闭",
                Content = "护盾攻击已停止",
                Icon = "⏹️",
                Duration = 3
            })
        end
    end
})

local Main = Window:Tab({Title = "修改", Icon = "settings"})

Main:Button({
    Title = "全枪无限子弹",
    Callback = function()
        local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local gk = true 
local uj = nil
local deathConnection = nil

local originalGunData = {}

local function apn()
    for i, v in next, getgc(false) do
        if typeof(v) == "function" then
            local info = getinfo(v)
            if tostring(info.name) == "fireGun" then
                local gunTable = getupvalue(v, 1)
                
                if not originalGunData[gunTable] then
                    originalGunData[gunTable] = {}
                    for key, value in pairs(gunTable) do
                        if typeof(value) ~= "function" then
                            originalGunData[gunTable][key] = value
                        end
                    end
                    
                    for key, value in pairs(gunTable) do
                        if typeof(value) == "table" then
                            originalGunData[gunTable][key] = {}
                            for subKey, subValue in pairs(value) do
                                originalGunData[gunTable][key][subKey] = subValue
                            end
                        end
                    end
                end
                
                rawset(gunTable, "Ammo", math.huge)
                rawset(gunTable, "Distance", math.huge)
                rawset(gunTable, "BSpeed", 99999)
                rawset(gunTable, "BDrop", 0)
                rawset(gunTable, "FireRate", 2000)
                rawset(gunTable, "MaxSpread", 0)
                rawset(gunTable, "MinSpread", 0)
                rawset(gunTable.FireModes, "Auto", true)
                rawset(gunTable.FireModes, "Semi", true)
                rawset(gunTable.FireModes, "ChangeFiremode", true)
                rawset(gunTable, "MinRecoilPower", 0)
                rawset(gunTable, "MaxRecoilPower", 0)
                rawset(gunTable, "RecoilPowerStepAmount", 0)
                rawset(gunTable, "RecoilPunch", 0)
                rawset(gunTable, "DPunchBase", 0)
                rawset(gunTable, "AimRecover", 1)
                rawset(gunTable, "HPunchBase", 0)
                rawset(gunTable, "VPunchBase", 0)
                rawset(gunTable, "PunchRecover", 1)
                rawset(gunTable, "SwayBase", 0)
                rawset(gunTable, "AimRecoilReduction", math.huge)
                
                for key, value in next, gunTable do
                    if typeof(value) == "table" then
                        for subKey, subValue in next, value do
                            if typeof(subValue) == "number" then
                                rawset(value, subKey, 0)
                            end
                        end
                    end
                end
            end
        end
    end
end

local function resetGuns()
    for gunTable, data in pairs(originalGunData) do
        for key, value in pairs(data) do
            if typeof(value) == "table" then
                if gunTable[key] then
                    for subKey, subValue in pairs(value) do
                        rawset(gunTable[key], subKey, subValue)
                    end
                end
            else
                rawset(gunTable, key, value)
            end
        end
    end
    originalGunData = {}
end

local function onCharacterDeath()
    resetGuns() 
    
    if gk then
        LocalPlayer.CharacterAdded:Wait()
        task.wait(1)  
        apn()
    end
end

local function setupDeathListener()
    if deathConnection then
        deathConnection:Disconnect()
        deathConnection = nil
    end
    
    deathConnection = LocalPlayer.CharacterAdded:Connect(function(char)
        local humanoid = char:WaitForChild("Humanoid")
        humanoid.Died:Connect(onCharacterDeath)
    end)
    
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Died:Connect(onCharacterDeath)
        end
    end
end

gk = true

if LocalPlayer.Character then
    apn()
end

setupDeathListener()

uj = LocalPlayer.CharacterAdded:Connect(function()
    if gk then
        task.wait(1) 
        apn()
        setupDeathListener()  
    end
end)

    end
})

Main:Button({
    Title = "全载具无限子弹",
    Callback = function()
        _G.AutoModifyEnabled = true
_G.FireRateValue = 2000
_G.InfiniteOverheat = true
_G.ZeroCooldown = true

local processedObjects = setmetatable({}, {__mode = "v"})
local weaponCache = setmetatable({}, {__mode = "v"})
local lastScanTime = 0
local SCAN_INTERVAL = 5 

local function isWeaponObject(obj)
    if type(obj) ~= "table" then return false end
    
    if weaponCache[obj] ~= nil then
        return weaponCache[obj]
    end
    
    local hasFireRate = rawget(obj, "FireRate") ~= nil
    local hasOverheat = rawget(obj, "OverheatCount") ~= nil
    
    local isWeapon = hasFireRate and hasOverheat
    weaponCache[obj] = isWeapon
    
    return isWeapon
end

local function modifyWeapon(weapon)
    if not weapon._OriginalFireRate then
        weapon._OriginalFireRate = weapon.FireRate
        weapon._OriginalOverheatIncrement = weapon.OverheatIncrement
        weapon._OriginalCooldownTime = weapon.CooldownTime
        weapon._OriginalOverheatCount = weapon.OverheatCount
        weapon._OriginalDepleteDelay = weapon.DepleteDelay
    end
    
    if _G.ZeroCooldown then
        rawset(weapon, "OverheatIncrement", 0)
        rawset(weapon, "CooldownTime", 0)
    else
        rawset(weapon, "OverheatIncrement", weapon._OriginalOverheatIncrement)
        rawset(weapon, "CooldownTime", weapon._OriginalCooldownTime)
    end
    
    rawset(weapon, "FireRate", _G.FireRateValue)
    
    if _G.InfiniteOverheat then
        rawset(weapon, "OverheatCount", math.huge)
        rawset(weapon, "DepleteDelay", math.huge)
    else
        rawset(weapon, "OverheatCount", weapon._OriginalOverheatCount)
        rawset(weapon, "DepleteDelay", weapon._OriginalDepleteDelay)
    end
    
    processedObjects[weapon] = true
end

local function scanForWeapons()
    local objects = getgc(true)
    local foundWeapons = {}
    
    for i = 1, #objects do
        local obj = objects[i]
        if isWeaponObject(obj) and not processedObjects[obj] then
            table.insert(foundWeapons, obj)
        end
    end
    
    for i = 1, #foundWeapons do
        modifyWeapon(foundWeapons[i])
    end
    
    local registry = debug.getregistry()
    if isWeaponObject(registry) and not processedObjects[registry] then
        modifyWeapon(registry)
    end
end

spawn(function()
    while true do
        local currentTime = tick()
        
        if _G.AutoModifyEnabled and (currentTime - lastScanTime) >= SCAN_INTERVAL then
            scanForWeapons()
            lastScanTime = currentTime
        end
        
        task.wait(1) 
    end
end)
    end
})

Main:Button({
    Title = "直升机无限烟火",
    Callback = function()

local flareInterval = 0.5

while true do
    local args = {
        workspace:WaitForChild("Game Systems"):WaitForChild("Helicopter Workspace"):WaitForChild("AH-6 Littlebird"):WaitForChild("Misc"):WaitForChild("Turrets"):WaitForChild("AH Weapons"):WaitForChild("Flares"),
        workspace:WaitForChild("Game Systems"):WaitForChild("Helicopter Workspace"):WaitForChild("AH-6 Littlebird"),
        workspace:WaitForChild("Game Systems"):WaitForChild("Helicopter Workspace"):WaitForChild("AH-6 Littlebird"):WaitForChild("Misc"):WaitForChild("Turrets"):WaitForChild("SoundPart")
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("RocketSystem"):WaitForChild("Events"):WaitForChild("FireFlare"):FireServer(unpack(args))
    
    wait(flareInterval)
end
    end
})

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local old
local main = {
    enable = false,
    teamcheck = false,
    friendcheck = false,
    enablenpc = false
}

local function getClosestHead()
    local closestHead
    local closestDistance = math.huge
    
    if not LocalPlayer.Character then return end
    if not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local skip = false
            
            if main.teamcheck and player.Team == LocalPlayer.Team then
                skip = true
            end
            
            if not skip and main.friendcheck and LocalPlayer:IsFriendsWith(player.UserId) then
                skip = true
            end
            
            if not skip then
                local character = player.Character
                local root = character:FindFirstChild("HumanoidRootPart")
                local head = character:FindFirstChild("Head")
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                
                if root and head and humanoid and humanoid.Health > 0 then
                    local distance = (root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestHead = head
                        closestDistance = distance
                    end
                end
            end
        end
    end
    return closestHead
end

local function getClosestNpcHead()
    local closestHead
    local closestDistance = math.huge
    
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local localHrp = LocalPlayer.Character.HumanoidRootPart
    
    for _, object in ipairs(Workspace:GetDescendants()) do
        if object:IsA("Model") then
            local humanoid = object:FindFirstChildOfClass("Humanoid")
            local hrp = object:FindFirstChild("HumanoidRootPart") or object.PrimaryPart
            local head = object:FindFirstChild("Head")
            
            if humanoid and hrp and humanoid.Health > 0 then
                local isPlayer = false
                for _, pl in ipairs(Players:GetPlayers()) do
                    if pl.Character == object then
                        isPlayer = true
                        break
                    end
                end
                
                if not isPlayer and head then
                    local distance = (hrp.Position - localHrp.Position).Magnitude
                    if distance < closestDistance then
                        closestHead = head
                        closestDistance = distance
                    end
                end
            end
        end
    end
    return closestHead
end

old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "Raycast" and not checkcaller() then
        local origin = args[1] or Camera.CFrame.Position
        
        if main.enable then
            local closestHead = getClosestHead()
            if closestHead then
                return {
                    Instance = closestHead,
                    Position = closestHead.Position,
                    Normal = (origin - closestHead.Position).Unit,
                    Material = Enum.Material.Plastic,
                    Distance = (closestHead.Position - origin).Magnitude
                }
            end
        end
        
        if main.enablenpc then
            local closestNpcHead = getClosestNpcHead()
            if closestNpcHead then
                return {
                    Instance = closestNpcHead,
                    Position = closestNpcHead.Position,
                    Normal = (origin - closestNpcHead.Position).Unit,
                    Material = Enum.Material.Plastic,
                    Distance = (closestNpcHead.Position - origin).Magnitude
                }
            end
        end
    end
    return old(self, ...)
end))
local Main = Window:Tab({Title = "子弹追踪", Icon = "settings"})
Main:Toggle({
    Title = "开启子弹追踪",
    Image = "bird",
    Value = false,
    Callback = function(state)
        main.enable = state
    end
})

Main:Toggle({
    Title = "开启队伍验证",
    Image = "bird",
    Value = false,
    Callback = function(state)
        main.teamcheck = state
    end
})

Main:Toggle({
    Title = "开启好友验证",
    Image = "bird",
    Value = false,
    Callback = function(state)
        main.friendcheck = state
    end
})

Main:Toggle({
    Title = "开启NPC子弹追踪",
    Image = "bird",
    Value = false,
    Callback = function(state)
        main.enablenpc = state
    end
})

local Main = Window:Tab({Title = "透视", Icon = "settings"})
local ESP = {
    Enabled = false,
    OutlineEnabled = false,
    NameEnabled = false,
    DistanceEnabled = false,
    HealthEnabled = false
}

local function outline(part, color, enabled)
    local hl = part:FindFirstChild("Highlight")
    if not hl then
        local HL = Instance.new("Highlight", part)
        HL.FillTransparency = 1
        HL.OutlineTransparency = 0
        HL.OutlineColor = color
        HL.Enabled = enabled
    else
        local HL = hl
        HL.OutlineColor = color
        HL.Enabled = enabled
    end
end

local function AddESP(part, text, enabled)
    local bg = part:FindFirstChild("BillboardGui")
    if not bg then
        local BG = Instance.new("BillboardGui", workspace)
        BG.AlwaysOnTop = true
        BG.Size = UDim2.new(0, 100, 0, 50)
        BG.StudsOffset = Vector3.new(0, 1.4, 0)
        BG.Enabled = enabled
        local TL = Instance.new("TextLabel", BG)
        TL.BackgroundTransparency = 1
        TL.Size = UDim2.new(0, 100, 0, 50)
        TL.FontFace = Font.fromId(12187376739)
        TL.Text = text
        TL.TextSize = 10
        TL.Parent = BG
        BG.Parent = part
    else
        local BG = bg
        local TL = BG:FindFirstChild("TextLabel")
        TL.Text = text
        BG.Enabled = enabled
    end
end

Main:Toggle({
    Title = "ESP 总开关",
    Value = false,
    Callback = function(value)
        ESP.Enabled = value
        if not value then
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player.Character then
                    outline(player.Character, Color3.new(1, 1, 1), false)
                    local bg = player.Character:FindFirstChild("BillboardGui")
                    if bg then bg.Enabled = false end
                end
            end
        end
    end
})

Main:Toggle({
    Title = "描边",
    Value = false,
    Callback = function(value)
        ESP.OutlineEnabled = value
    end
})

Main:Toggle({
    Title = "透视名称",
    Value = false,
    Callback = function(value)
        ESP.NameEnabled = value
    end
})

Main:Toggle({
    Title = "透视距离",
    Value = false,
    Callback = function(value)
        ESP.DistanceEnabled = value
    end
})

Main:Toggle({
    Title = "透视血量",
    Value = false,
    Callback = function(value)
        ESP.HealthEnabled = value
    end
})

game:GetService("RunService").Heartbeat:Connect(function()
    if not ESP.Enabled then return end
    
    local hue = (tick() % 5) / 5
    local rainbowColor = Color3.fromHSV(hue, 1, 1)
    
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer and player.Character then
            outline(player.Character, rainbowColor, ESP.OutlineEnabled)
            
            local textParts = {}
            if ESP.NameEnabled then
                table.insert(textParts, "用户名:"..player.Name)
            end
            if ESP.DistanceEnabled then
                table.insert(textParts, "距离:"..tostring(math.round(game:GetService("Players").LocalPlayer:DistanceFromCharacter(player.Character.HumanoidRootPart.Position))))
            end
            if ESP.HealthEnabled then
                table.insert(textParts, "血量:"..tostring(player.Character.Humanoid.Health))
            end
            
            AddESP(player.Character, table.concat(textParts, "\n"), ESP.Enabled)
            
            local bg = player.Character:FindFirstChild("BillboardGui")
            if bg then
                local TL = bg:FindFirstChild("TextLabel")
                if TL then
                    TL.TextColor3 = rainbowColor
                end
            end
        end
    end
end)

local Main = Window:Tab({Title = "自瞄", Icon = "settings"})
local isAiming = false
local isPredicting = false 
local isLowHealthPriority = false 
local fov = 50 
local plr = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Cam = workspace.CurrentCamera

local targetPart = "Head"
local teamCheck = false
local aliveCheck = false
local predictionDistance = 1.5
local wallCheck = false
local FOVring = Drawing.new("Circle")
FOVring.Visible = false
FOVring.Thickness = 2
FOVring.Color = Color3.fromRGB(255, 0, 0) 
FOVring.Filled = false
FOVring.Radius = fov
FOVring.Position = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)

local aimConnection = nil
local function updateDrawings()
    FOVring.Position = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
end
local function removeFOVring()
    FOVring.Visible = false
    if FOVring then
        FOVring:Remove()
    end
end

local function lookAt(target)
    local lookVector = (target - Cam.CFrame.Position).Unit
    local newCFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
    Cam.CFrame = newCFrame
end
local function isSameTeam(player)
    return player.Team == plr.Team
end

local function isLookingAtWall(player, distance)
    if not wallCheck then return true end
    
    local character = plr.Character
    if not character then return false end
    
    local part = player.Character and player.Character:FindFirstChild(targetPart)
    if not part then return false end
    
    local ray = Ray.new(Cam.CFrame.Position, (part.Position - Cam.CFrame.Position).Unit * distance)
    local hit, _ = workspace:FindPartOnRayWithIgnoreList(ray, {character})
    
    return not hit or not hit:IsDescendantOf(player.Character)
end

local function isPlayerAlive(player)
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health > 0
end

local function getClosestPlayerInFOV()
    local nearest = nil
    local last = math.huge
    local lowestHealthPlayer = nil
    local lowestHealth = math.huge
    local playerMousePos = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= plr then
        
            if teamCheck and isSameTeam(player) then continue end
            
            local character = player.Character
            if character and character:FindFirstChild(targetPart) then
             
                if aliveCheck and not isPlayerAlive(player) then continue end
                
             
                if wallCheck and isLookingAtWall(player, 100) then continue end
                
                local part = character[targetPart]
                local ePos, isVisible = Cam:WorldToViewportPoint(part.Position)
                local distance = (Vector2.new(ePos.x, ePos.y) - playerMousePos).Magnitude

                if distance < last and isVisible and distance < fov then
                    last = distance
                    nearest = player
                end

            
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    if humanoid.Health < lowestHealth then
                        lowestHealth = humanoid.Health
                        lowestHealthPlayer = player
                    end
                end
            end
        end
    end

    if isLowHealthPriority and lowestHealthPlayer then
        return lowestHealthPlayer
    end

    return nearest
end

local function predictNextPosition(player, deltaTime)
    if not isPredicting then
        return player.Character and player.Character:FindFirstChild(targetPart) and player.Character[targetPart].Position
    end
    
    local character = player.Character
    if not character or not character:FindFirstChild(targetPart) then return end

    local part = character[targetPart]
    local velocity = part.Velocity
    local nextPosition = part.Position + velocity * deltaTime * predictionDistance
    return nextPosition
end
local function toggleAiming(v)
    if v then 
     
        isAiming = true
        FOVring.Visible = true
        FOVring.Radius = fov
        
        
        if aimConnection then
            aimConnection:Disconnect()
        end
        
        aimConnection = RunService.RenderStepped:Connect(function(dt)
            if not isAiming then return end  
            updateDrawings()
            local closest = getClosestPlayerInFOV()
            if closest and closest.Character and closest.Character:FindFirstChild(targetPart) then
                local targetPosition = predictNextPosition(closest, dt)
                if targetPosition then
                    lookAt(targetPosition)
                end
            end
        end)
    else 
      
        isAiming = false
        
       
        if aimConnection then
            aimConnection:Disconnect()
            aimConnection = nil
        end
        
      
        FOVring.Visible = false
        
        -- 重置相机（可选）
        -- Cam.CFrame = workspace.CurrentCamera.CFrame
    end
end

local function togglePredicting(v)
    isPredicting = v
end
local function toggleLowHealthPriority(v)
    isLowHealthPriority = v
end

Main:Toggle({
    Title = "开启自瞄",
    Default = false,
    Callback = function(Value)
        toggleAiming(Value)
    end
})

Main:Toggle({
    Title = "预判自瞄",
    Default = false,
    Callback = function(Value)
        togglePredicting(Value)
    end
})

Main:Dropdown({
    Title = "自瞄玩家身体部位",
    Values = {"头", "胸", "左手", "右手", "左腿", "右腿"},
    Default = "头",
    Callback = function(Value)
        local partMap = {
            ["头"] = "Head",
            ["胸"] = "UpperTorso",
            ["左手"] = "LeftHand",
            ["右手"] = "RightHand",
            ["左腿"] = "LeftFoot",
            ["右腿"] = "RightFoot"
        }
        targetPart = partMap[Value] 
    end
})

Main:Dropdown({
    Title = "自瞄圈颜色",
    Values = {"红色", "黄色", "绿色", "蓝色", "紫色", "橙色", "黑色"},
    Default = "红色",
    Callback = function(Value)
        local colorMap = {
            ["红色"] = Color3.fromRGB(255, 0, 0),
            ["黄色"] = Color3.fromRGB(255, 255, 0),
            ["绿色"] = Color3.fromRGB(0, 255, 0),
            ["蓝色"] = Color3.fromRGB(0, 0, 255),
            ["紫色"] = Color3.fromRGB(128, 0, 128),
            ["橙色"] = Color3.fromRGB(255, 165, 0),
            ["黑色"] = Color3.fromRGB(0, 0, 0)
        }
        FOVring.Color = colorMap[Value]
    end
})

Main:Toggle({
    Title = "活体检测",
    Default = false,
    Callback = function(Value)
        aliveCheck = Value
    end
})

Main:Toggle({
    Title = "墙壁检测",
    Default = false,
    Callback = function(Value)
        wallCheck = Value
    end
})

local Main = Window:Tab({Title = "传送", Icon = "settings"})

local Positions = {
    ["Alpha"] = CFrame.new(-1197, 65, -4790),
    ["Bravo"] = CFrame.new(-220, 65, -4919),
    ["Charlie"] = CFrame.new(797, 65, -4740),
    ["Delta"] = CFrame.new(2044, 65, -3984),
    ["Echo"] = CFrame.new(2742, 65, -3031),
    ["Foxtrot"] = CFrame.new(3045, 65, -1788),
    ["Golf"] = CFrame.new(3376, 65, -562),
    ["Hotel"] = CFrame.new(3290, 65, 587),
    ["Juliet"] = CFrame.new(2955, 65, 1804),
    ["Kilo"] = CFrame.new(2569, 65, 2926),
    ["Lima"] = CFrame.new(989, 65, 3419),
    ["Omega"] = CFrame.new(-319, 65, 3932),
    ["Romeo"] = CFrame.new(-1479, 65, 3722),
    ["Sierra"] = CFrame.new(-2528, 65, 2549),
    ["Tango"] = CFrame.new(-3018, 65, 1503),
    ["Victor"] = CFrame.new(-3587, 65, 634),
    ["Yankee"] = CFrame.new(-3957, 65, -287),
    ["Zulu"] = CFrame.new(-4049, 65, -1334)
}
Main:Dropdown({
    Title = "传送基地", 
    Values = {"Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "Juliet", "Kilo", "Lima", "Omega", "Romeo", "Sierra", "Tango", "Victor", "Yankee", "Zulu"}, 
    Value = "Alpha", 
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Positions[Value]
            WindUI:Notify({
                Title = "传送成功",
                Content = "已传送到 " .. Value .. " 基地",
                Icon = "📍",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "传送失败",
                Content = "角不存在",
                Icon = "❌",
                Duration = 3
            })
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