   
   -- 设置全局变量
getgenv().HP = true
getgenv().buyammo1 = true --手枪子弹
getgenv().buyammo2 = true --自动购买步枪弹药
getgenv().buyammo3 = true --自动购买弓箭
getgenv().buyammo4 = true --自动购买霰弹枪弹药
getgenv().buyammo5 = true --购买狙击枪子弹
getgenv().buyammo6 = true --自动购买小型炸药
getgenv().buyammo7 = true --大型炸药
getgenv().sell = true
getgenv().esp = true

local lp = game:GetService('Players').LocalPlayer
local hum = lp.Character.Humanoid

-- ESP功能
function esp()
	while getgenv().esp == true do
		wait(1)
		for i,v in pairs(game:GetService("Workspace").Animals:GetDescendants()) do
			if v.ClassName == 'Part' and v.Name == 'HumanoidRootPart' then
				if not v.Parent:FindFirstChild("AEsp") then
					local BillboardGui = Instance.new('BillboardGui')
					local TextLabel = Instance.new('TextLabel')
					
					BillboardGui.Parent = v.Parent
					BillboardGui.AlwaysOnTop = true
					BillboardGui.Size = UDim2.new(2, 35, 2, 35)
					BillboardGui.StudsOffset = Vector3.new(0,2,0)
					BillboardGui.Name = 'AEsp'
		
					TextLabel.Parent = BillboardGui
					TextLabel.BackgroundColor3 = Color3.new(1,1,1)
					TextLabel.BackgroundTransparency = 1
					TextLabel.Size = UDim2.new(1, 0, 1, 0)
					TextLabel.Text = v.Parent.AnimalType.Value
					TextLabel.TextColor3 = Color3.new(0.678, 0.847, 0.902)
					TextLabel.TextScaled = true
				end
			end
		end
	end
end

-- 出售功能
function sell()
	while getgenv().sell == true do
		local args = {[1] = "Sell"}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Inventory"):InvokeServer(unpack(args))
		wait(0.5)
	end
end

-- 购买功能
function buyammo1()
	while getgenv().buyammo1 == true do
		local args = {[1] = "PistolAmmo",[2] = true}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("BuyItem"):InvokeServer(unpack(args))
		wait(0.5)
	end
end

function buyammo2()
	while getgenv().buyammo2 == true do
		local args = {[1] = "RifleAmmo",[2] = true}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("BuyItem"):InvokeServer(unpack(args))
		wait(0.5)
	end
end

function buyammo3()
	while getgenv().buyammo3 == true do
		local args = {[1] = "Arrows"}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("BuyItem"):InvokeServer(unpack(args))
		wait(0.5)
	end
end

function buyammo4()
	while getgenv().buyammo4 == true do
		local args = {[1] = "ShotgunAmmo"}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("BuyItem"):InvokeServer(unpack(args))
		wait(0.5)
	end
end

function buyammo5()
	while getgenv().buyammo5 == true do
		local args = {[1] = "SniperAmmo",[2] = true}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("BuyItem"):InvokeServer(unpack(args))
		wait(0.5)
	end
end

function buyammo6()
	while getgenv().buyammo6 == true do
		local args = {[1] = "Dynamite"}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("BuyItem"):InvokeServer(unpack(args))
		wait(0.5)
	end
end

function buyammo7()
	while getgenv().buyammo7 == true do
		local args = {[1] = "BIG Dynamite",[2] = true}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("BuyItem"):InvokeServer(unpack(args))
		wait(0.5)
	end
end

function HP()
	while getgenv().HP == true do
		local args = {[1] = "Health Potion",[2] = true}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("BuyItem"):InvokeServer(unpack(args))
		wait(0.5)
	end
end

-- 初始化WindUI
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

-- 彩虹边框和字体颜色变量
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

-- 字体样式
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

-- 颜色方案
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

-- 字体颜色渐变应用函数
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

-- 字体样式应用到窗口
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

-- 字体颜色应用到窗口
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

-- 创建彩虹边框
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

-- 开始边框动画
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

-- 初始化彩虹边框
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

-- 播放音效
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

-- 应用模糊效果
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

-- 应用UI缩放
local function applyUIScale(scale)
    if Window and Window.UIElements and Window.UIElements.Main then
        local mainFrame = Window.UIElements.Main
        mainFrame.Size = UDim2.new(0, 600 * scale, 0, 400 * scale)
    end
end

-- 创建弹窗
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
                createUI()
            end,
            Variant = "Primary",
        }
    }
})

-- 主UI创建函数
function createUI()
    -- 创建主窗口
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
        Title = "一路向西",
        Color = Color3.fromHex("#ff6b6b")
    })
    
    -- 主题切换按钮
    Window:CreateTopbarButton("theme-switcher", "moon", function()
        WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
        WindUI:Notify({
            Title = "主题已切换",
            Content = "当前主题: "..WindUI:GetCurrentTheme(),
            Duration = 2
        })
    end, 990)
    
    -- 初始化彩虹边框
    if not borderInitialized then
        spawn(function()
            wait(0.5)
            initializeRainbowBorder("彩虹颜色", animationSpeed)
            wait(1)
            applyFontStyleToWindow(currentFontStyle)
        end)
    end
    
    Window:Divider()
    
    local WeaponTab = Window:Tab({
        Title = "武器区",
        Icon = "sword",
    })
    
  
    local DayTab = Window:Tab({
        Title = "白天区",
        Icon = "sun",
    })
    
 
    local ESPTab = Window:Tab({
        Title = "透视区",
        Icon = "eye",
    })
    
    local BuySection = Window:Tab({
        Title = "购买",
        Icon = "buy",
    })
    
    -- 武器区内容
    local WeaponSection = WeaponTab:Section({
        Title = "武器内容",
        Icon = "sword"
    })
    
    -- 无跌落伤害
    WeaponSection:Button({
        Title = "无跌落伤害",
        Callback = function()
            local gamemt = getrawmetatable(game)
            local oldNc = gamemt.__namecall
            setreadonly(gamemt, false)
            
            gamemt.__namecall = newcclosure(function(self, ...)
                if (getnamecallmethod() == 'FireServer' and self.Name == 'ChangeCharacter') then
                    local args = {...}
                    if (args[1] and args[1] == 'Damage') then
                        return nil
                    end
                end 
                return oldNc(self, ...)
            end)
        end
    })
    
    -- 无后座力
    WeaponSection:Button({
        Title = "无后座力",
        Callback = function()
            local mods = {
                FanFire = true, 
                camShakeResist = 0, 
                prepTime = 0, 
                equipTime = 0, 
                Spread = 0, 
                InstantFireAnimation = true
            }
    
            for _, gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
                for prop, value in pairs(mods) do
                    if gun[prop] then
                        gun[prop] = value
                    end
                end
            end
        end
    })
    
    -- 一秒换弹
    WeaponSection:Button({
        Title = "一秒换弹",
        Callback = function()
            local mods = {
                FanFire = true, 
                prepTime = 0, 
                equipTime = 0, 
                camShakeResist = 0, 
                ReloadAnimationSpeed = 10, 
                ReloadSpeed = 0, 
                Spread = 0, 
                InstantFireAnimation = true
            }
    
            for _, gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
                for prop, value in pairs(mods) do
                    if gun[prop] then
                        gun[prop] = value
                    end
                end
            end
        end
    })
    
    -- 子弹汇聚
    WeaponSection:Button({
        Title = "子弹汇聚",
        Callback = function()
            local mods = {
                FanFire = true, 
                prepTime = 0, 
                equipTime = 0, 
                camShakeResist = 0, 
                ReloadAnimationSpeed = 10, 
                ReloadSpeed = 0, 
                Spread = 0, 
                HipFireAccuracy = 0, 
                ZoomAccuracy = 0, 
                InstantFireAnimation = true
            }
    
            for _, gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
                for prop, value in pairs(mods) do
                    if gun[prop] then
                        gun[prop] = value
                    end
                end
            end
        end
    })
    
    -- 无限备弹
    WeaponSection:Button({
        Title = "无限备弹",
        Desc = "死亡后会卡无限子弹 需手动打几发子弹然后切换一下枪",
        Callback = function()
            local mods = {
                FanFire = true, 
                prepTime = 0, 
                equipTime = 0, 
                MaxShots = math.huge, 
                camShakeResist = 0, 
                ReloadAnimationSpeed = 10, 
                ReloadSpeed = 0, 
                Spread = 0, 
                InstantFireAnimation = true
            }
    
            for _, gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
                for prop, value in pairs(mods) do
                    if gun[prop] then
                        gun[prop] = value
                    end
                end
            end
        end
    })
    
    -- 范围伤害
    WeaponSection:Button({
        Title = "范围伤害",
        Callback = function()
            local Camera = game:GetService("Workspace").CurrentCamera
            local Players = game:GetService("Players")
            local LocalPlayer = game:GetService("Players").LocalPlayer
            
            local function GetClosestPlayer()
               local ClosestPlayer = nil
               local FarthestDistance = math.huge
            
               for i, v in pairs(Players.GetPlayers(Players)) do
                   if v ~= LocalPlayer and v.Character and v.Character.FindFirstChild(v.Character, "HumanoidRootPart") then
                       local DistanceFromPlayer = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
            
                       if DistanceFromPlayer < FarthestDistance then
                           FarthestDistance = DistanceFromPlayer
                           ClosestPlayer = v
                       end
                   end
               end
            
               if ClosestPlayer then
                   return ClosestPlayer
               end
            end
            
            local GameMetaTable = getrawmetatable(game)
            local OldGameMetaTableNamecall = GameMetaTable.__namecall
            setreadonly(GameMetaTable, false)
            
            GameMetaTable.__namecall = newcclosure(function(object, ...)
               local NamecallMethod = getnamecallmethod()
               local Arguments = {...}
            
               if tostring(NamecallMethod) == "FindPartOnRayWithIgnoreList" then
                   local ClosestPlayer = GetClosestPlayer()
                   
                   if ClosestPlayer and ClosestPlayer.Character then
                       Arguments[1] = Ray.new(Camera.CFrame.Position, (ClosestPlayer.Character.Head.Position - Camera.CFrame.Position).Unit * (Camera.CFrame.Position - ClosestPlayer.Character.Head.Position).Magnitude)
                   end
               end
            
               return OldGameMetaTableNamecall(object, unpack(Arguments))
            end)
            
            setreadonly(GameMetaTable, true)
        end
    })
    
    -- 白天区内容
    local DaySection = DayTab:Section({
        Title = "白天内容",
        Icon = "sun"
    })
    
    DaySection:Toggle({
        Title = "白天",
        Desc = "开关",
        Callback = function(enabled)
            if not _G.FullBrightExecuted then
                _G.FullBrightEnabled = false
                _G.NormalLightingSettings = {
                    Brightness = game:GetService("Lighting").Brightness,
                    ClockTime = game:GetService("Lighting").ClockTime,
                    FogEnd = game:GetService("Lighting").FogEnd,
                    GlobalShadows = game:GetService("Lighting").GlobalShadows,
                    Ambient = game:GetService("Lighting").Ambient
                }
                
                game:GetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
                    if game:GetService("Lighting").Brightness ~= 1 and game:GetService("Lighting").Brightness ~= _G.NormalLightingSettings.Brightness then
                        _G.NormalLightingSettings.Brightness = game:GetService("Lighting").Brightness
                        if not _G.FullBrightEnabled then
                            repeat
                                wait()
                            until _G.FullBrightEnabled
                        end
                        game:GetService("Lighting").Brightness = 1
                    end
                end)
                
                game:GetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
                    if game:GetService("Lighting").ClockTime ~= 12 and game:GetService("Lighting").ClockTime ~= _G.NormalLightingSettings.ClockTime then
                        _G.NormalLightingSettings.ClockTime = game:GetService("Lighting").ClockTime
                        if not _G.FullBrightEnabled then
                            repeat
                                wait()
                            until _G.FullBrightEnabled
                        end
                        game:GetService("Lighting").ClockTime = 12
                    end
                end)
                
                game:GetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
                    if game:GetService("Lighting").FogEnd ~= 786543 and game:GetService("Lighting").FogEnd ~= _G.NormalLightingSettings.FogEnd then
                        _G.NormalLightingSettings.FogEnd = game:GetService("Lighting").FogEnd
                        if not _G.FullBrightEnabled then
                            repeat
                                wait()
                            until _G.FullBrightEnabled
                        end
                        game:GetService("Lighting").FogEnd = 786543
                    end
                end)
                
                game:GetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
                    if game:GetService("Lighting").GlobalShadows ~= false and game:GetService("Lighting").GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
                        _G.NormalLightingSettings.GlobalShadows = game:GetService("Lighting").GlobalShadows
                        if not _G.FullBrightEnabled then
                            repeat
                                wait()
                            until _G.FullBrightEnabled
                        end
                        game:GetService("Lighting").GlobalShadows = false
                    end
                end)
                
                game:GetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
                    if game:GetService("Lighting").Ambient ~= Color3.fromRGB(178, 178, 178) and game:GetService("Lighting").Ambient ~= _G.NormalLightingSettings.Ambient then
                        _G.NormalLightingSettings.Ambient = game:GetService("Lighting").Ambient
                        if not _G.FullBrightEnabled then
                            repeat
                                wait()
                            until _G.FullBrightEnabled
                        end
                        game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
                    end
                end)
                
                game:GetService("Lighting").Brightness = 1
                game:GetService("Lighting").ClockTime = 12
                game:GetService("Lighting").FogEnd = 786543
                game:GetService("Lighting").GlobalShadows = false
                game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
                
                local LatestValue = true
                spawn(function()
                    repeat
                        wait()
                    until _G.FullBrightEnabled
                    while wait() do
                        if _G.FullBrightEnabled ~= LatestValue then
                            if not _G.FullBrightEnabled then
                                game:GetService("Lighting").Brightness = _G.NormalLightingSettings.Brightness
                                game:GetService("Lighting").ClockTime = _G.NormalLightingSettings.ClockTime
                                game:GetService("Lighting").FogEnd = _G.NormalLightingSettings.FogEnd
                                game:GetService("Lighting").GlobalShadows = _G.NormalLightingSettings.GlobalShadows
                                game:GetService("Lighting").Ambient = _G.NormalLightingSettings.Ambient
                            else
                                game:GetService("Lighting").Brightness = 1
                                game:GetService("Lighting").ClockTime = 12
                                game:GetService("Lighting").FogEnd = 786543
                                game:GetService("Lighting").GlobalShadows = false
                                game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
                            end
                            LatestValue = not LatestValue
                        end
                    end
                end)
            end
            
            _G.FullBrightExecuted = true
            _G.FullBrightEnabled = not _G.FullBrightEnabled
        end
    })
    
      -- 透视区内容
    local ESPSection = ESPTab:Section({
        Title = "透视内容",
        Icon = "eye"
    })
    
    ESPSection:Toggle({
        Title = "动物透视",
        Desc = "开关",
        Callback = function(enabled)
            getgenv().esp = enabled
            if enabled then
                esp()
            end
        end
    })
    
    ESPSection:Button({
        Title = "开启透视",
        Callback = function()
            _G.FriendColor = Color3.fromRGB(0, 0, 255)
            _G.EnemyColor = Color3.fromRGB(255, 0, 0)
            _G.UseTeamColor = true
            
            --------------------------------------------------------------------
            local Holder = Instance.new("Folder", game.CoreGui)
            Holder.Name = "ESP"
            
            local Box = Instance.new("BoxHandleAdornment")
            Box.Name = "nilBox"
            Box.Size = Vector3.new(1, 2, 1)
            Box.Color3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
            Box.Transparency = 0.7
            Box.ZIndex = 0
            Box.AlwaysOnTop = false
            Box.Visible = false
            
            local NameTag = Instance.new("BillboardGui")
            NameTag.Name = "nilNameTag"
            NameTag.Enabled = false
            NameTag.Size = UDim2.new(0, 200, 0, 50)
            NameTag.AlwaysOnTop = true
            NameTag.StudsOffset = Vector3.new(0, 1.8, 0)
            local Tag = Instance.new("TextLabel", NameTag)
            Tag.Name = "Tag"
            Tag.BackgroundTransparency = 1
            Tag.Position = UDim2.new(0, -50, 0, 0)
            Tag.Size = UDim2.new(0, 300, 0, 20)
            Tag.TextSize = 15
            Tag.TextColor3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
            Tag.TextStrokeColor3 = Color3.new(0 / 255, 0 / 255, 0 / 255)
            Tag.TextStrokeTransparency = 0.4
            Tag.Text = "nil"
            Tag.Font = Enum.Font.SourceSansBold
            Tag.TextScaled = false
            
            local LoadCharacter = function(v)
                repeat wait() until v.Character ~= nil
                v.Character:WaitForChild("Humanoid")
                local vHolder = Holder:FindFirstChild(v.Name)
                vHolder:ClearAllChildren()
                local b = Box:Clone()
                b.Name = v.Name .. "Box"
                b.Adornee = v.Character
                b.Parent = vHolder
                local t = NameTag:Clone()
                t.Name = v.Name .. "NameTag"
                t.Enabled = true
                t.Parent = vHolder
                t.Adornee = v.Character:WaitForChild("Head", 5)
                if not t.Adornee then
                    return UnloadCharacter(v)
                end
                t.Tag.Text = v.Name
                b.Color3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
                t.Tag.TextColor3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
                local Update
                local UpdateNameTag = function()
                    if not pcall(function()
                            v.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                            local maxh = math.floor(v.Character.Humanoid.MaxHealth)
                            local h = math.floor(v.Character.Humanoid.Health)
                        end) then
                        Update:Disconnect()
                    end
                end
                UpdateNameTag()
                Update = v.Character.Humanoid.Changed:Connect(UpdateNameTag)
            end
            
            local UnloadCharacter = function(v)
                local vHolder = Holder:FindFirstChild(v.Name)
                if vHolder and (vHolder:FindFirstChild(v.Name .. "Box") ~= nil or vHolder:FindFirstChild(v.Name .. "NameTag") ~= nil) then
                    vHolder:ClearAllChildren()
                end
            end
            
            local LoadPlayer = function(v)
                local vHolder = Instance.new("Folder", Holder)
                vHolder.Name = v.Name
                v.CharacterAdded:Connect(function()
                    pcall(LoadCharacter, v)
                end)
                v.CharacterRemoving:Connect(function()
                    pcall(UnloadCharacter, v)
                end)
                v.Changed:Connect(function(prop)
                    if prop == "TeamColor" then
                        UnloadCharacter(v)
                        wait()
                        LoadCharacter(v)
                    end
                end)
                LoadCharacter(v)
            end
            
            local UnloadPlayer = function(v)
                UnloadCharacter(v)
                local vHolder = Holder:FindFirstChild(v.Name)
                if vHolder then
                    vHolder:Destroy()
                end
            end
            
            for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                spawn(function() pcall(LoadPlayer, v) end)
            end
            
            game:GetService("Players").PlayerAdded:Connect(function(v)
                pcall(LoadPlayer, v)
            end)
            
            game:GetService("Players").PlayerRemoving:Connect(function(v)
                pcall(UnloadPlayer, v)
            end)
            
            game:GetService("Players").LocalPlayer.NameDisplayDistance = 0
            
            if _G.Reantheajfdfjdgs then
                return
            end
            
            _G.Reantheajfdfjdgs = ":suifayhgvsdghfsfkajewfrhk321rk213kjrgkhj432rj34f67df"
            
            local players = game:GetService("Players")
            local plr = players.LocalPlayer
            
            function esp(target, color)
                if target.Character then
                    if not target.Character:FindFirstChild("GetReal") then
                        local highlight = Instance.new("Highlight")
                        highlight.RobloxLocked = true
                        highlight.Name = "GetReal"
                        highlight.Adornee = target.Character
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillColor = color
                        highlight.Parent = target.Character
                    else
                        target.Character.GetReal.FillColor = color
                    end
                end
            end
            
            while task.wait() do
                for i, v in pairs(players:GetPlayers()) do
                    if v ~= plr then
                        esp(v, _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor))
                    end
                end
            end
        end
    })
    
    -- 传送区内容
    local BuySection = BuyTab:Section({
        Title = "购买内容",
        Icon = "shopping-cart"
    })
    
    BuySection:Label({
        Title = "需要靠近NPC"
    })
    
    BuySection:Toggle({
        Title = "自动出售",
        Desc = "开关",
        Callback = function(enabled)
            getgenv().sell = enabled
            if enabled then
                sell()
            end
        end
    })
    
    BuySection:Toggle({
        Title = "手枪子弹",
        Desc = "开关",
        Callback = function(enabled)
            getgenv().buyammo1 = enabled
            if enabled then
                buyammo1()
            end
        end
    })
    
    BuySection:Toggle({
        Title = "步枪子弹",
        Desc = "开关",
        Callback = function(enabled)
            getgenv().buyammo2 = enabled
            if enabled then
                buyammo2()
            end
        end
    })
    
    BuySection:Toggle({
        Title = "购买箭矢",
        Desc = "开关",
        Callback = function(enabled)
            getgenv().buyammo3 = enabled
            if enabled then
                buyammo3()
            end
        end
    })
    
    BuySection:Toggle({
        Title = "霰弹子弹",
        Desc = "开关",
        Callback = function(enabled)
            getgenv().buyammo4 = enabled
            if enabled then
                buyammo4()
            end
        end
    })
    
    BuySection:Toggle({
        Title = "狙击子弹",
        Desc = "开关",
        Callback = function(enabled)
            getgenv().buyammo5 = enabled
            if enabled then
                buyammo5()
            end
        end
    })
    
    BuySection:Toggle({
        Title = "小型炸药",
        Desc = "开关",
        Callback = function(enabled)
            getgenv().buyammo6 = enabled
            if enabled then
                buyammo6()
            end
        end
    })
    
    BuySection:Toggle({
        Title = "大型炸药",
        Desc = "开关",
        Callback = function(enabled)
            getgenv().buyammo7 = enabled
            if enabled then
                buyammo7()
            end
        end
    })
    

    local TeleportSection = TeleportTab:Section({
        Title = "传送内容",
        Icon = "map-pin"
    })
    
    TeleportSection:Label({
        Title = "牛仔传送点"
    })
    
    TeleportSection:Button({
        Title = "滚筒",
        Callback = function()
            local args = {[1] = "StoneCreek",[2] = false}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
        end
    })
    
    TeleportSection:Button({
        Title = "岩石溪",
        Callback = function()
            local args = {[1] = "StoneCreek",[2] = false}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
        end
    })
    
    TeleportSection:Button({
        Title = "灰色山脊",
        Callback = function()
            local args = {[1] = "Grayridge",[2] = false}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
        end
    })
    
    TeleportSection:Button({
        Title = "大矿洞",
        Callback = function()
            local args = {[1] = "Quarry",[2] = false}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
        end
    })
    
    TeleportSection:Label({
        Title = "不法之徒传送点"
    })
    
    TeleportSection:Button({
        Title = "堡垒",
        Callback = function()
            local args = {[1] = "FortCassidy",[2] = true}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
        end
    })
    
    TeleportSection:Button({
        Title = "阿瑟堡",
        Callback = function()
            local args = {[1] = "FortArthur",[2] = true}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
        end
    })
    
    TeleportSection:Button({
        Title = "红色岩石营地",
        Callback = function()
            local args = {[1] = "RedRocks",[2] = true}game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
        end
    })
    
    -- UI设置标签页
    local Settings = Window:Tab({Title = "UI设置", Icon = "palette"})
    
    Settings:Paragraph({
        Title = "UI设置",
        Desc = "二改Wind原版UI",
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
                    if value then
                        startBorderAnimation(Window, animationSpeed)
                    elseif rainbowBorderAnimation then
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
    
    -- 关闭和销毁事件
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