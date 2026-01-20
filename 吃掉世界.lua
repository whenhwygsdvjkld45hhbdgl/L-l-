local autoGrabEnabled = false
local autoEatEnabled = false
local autoSellEnabled = false
local autoBuyMaxSizeEnabled = false
local autoBuySpeedEnabled = false
local autoBuySizeMultiplierEnabled = false
local autoUpgradeEatSpeedEnabled = false
local autoThrowEnabled = false

local function autoGrab()
    while autoGrabEnabled do
        local args = {
            [1] = false,
            [2] = false
        }
        game:GetService("Players").LocalPlayer.Character.Events.Grab:FireServer(unpack(args))
        wait(0.1)
    end
end

local function autoEat()
    while autoEatEnabled do
        game:GetService("Players").LocalPlayer.Character.Events.Eat:FireServer()
        wait(0.1)
    end
end

local function autoSell()
    while autoSellEnabled do
        game:GetService("Players").LocalPlayer.Character.Events.Sell:FireServer()
        wait(0.1)
    end
end

local function autoBuyMaxSize()
    local args = { "MaxSize" }
    while autoBuyMaxSizeEnabled do
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PurchaseEvent"):FireServer(unpack(args))
        wait(0.1)
    end
end

local function autoBuySpeed()
    local args = { "Speed" }
    while autoBuySpeedEnabled do
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PurchaseEvent"):FireServer(unpack(args))
        print("Purchasing Speed")
        wait(0.1)
    end
end

local function autoBuySizeMultiplier()
    local args = { "Multiplier" }
    while autoBuySizeMultiplierEnabled do
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PurchaseEvent"):FireServer(unpack(args))
        wait(0.1)
    end
end

local function autoUpgradeEatSpeed()
    local args = { "EatSpeed" }
    while autoUpgradeEatSpeedEnabled do
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PurchaseEvent"):FireServer(unpack(args))
        wait(0.1)
    end
end

local function autoThrow()
    while autoThrowEnabled do
        game:GetService("Players").LocalPlayer.Character.Events.Grab:FireServer()
        wait(2)
        game:GetService("Players").LocalPlayer.Character.Events.Throw:FireServer()
    end
end

local function autoThrow()
    while autoThrowEnabled do
        game:GetService("Players").LocalPlayer.Character.Events.Grab:FireServer()
        wait(2)
        game:GetService("Players").LocalPlayer.Character.Events.Throw:FireServer()
    end
end

local OpenUI = Instance.new("ScreenGui") 
local ImageButton = Instance.new("ImageButton") 
local UICorner = Instance.new("UICorner") 
OpenUI.Name = "OpenUI" 
OpenUI.Parent = game:GetService("CoreGui") 
OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling 
ImageButton.Parent = OpenUI 
ImageButton.BackgroundColor3 = Color3.fromRGB(105, 105, 105) 
ImageButton.BackgroundTransparency = 0.8
ImageButton.Position = UDim2.new(0.9, 0, 0.1, 0) 
ImageButton.Size = UDim2.new(0, 50, 0, 50) 
ImageButton.Image = "rbxassetid://14369638300" 
ImageButton.Draggable = true 
ImageButton.Transparency = 1
UICorner.CornerRadius = UDim.new(0, 200) 
UICorner.Parent = ImageButton 
ImageButton.MouseButton1Click:Connect(function()
	local vim = game:service("VirtualInputManager")
	vim:SendKeyEvent(true, "RightControl", false, game)
	local vim = game:service("VirtualInputManager")
	vim:SendKeyEvent(false, "RightControl", false, game)
end)

local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/lyyanai/rbx/main/lsui"))()
local win = UILib:Window("大司马脚本 | 吃掉世界",Color3.fromRGB(0, 255, 0), Enum.KeyCode.RightControl)

local mainTab = win:Tab("自动功能")
local extraTab = win:Tab("购买功能")
local pvpTab = win:Tab("其他功能")

mainTab:Toggle("自动拿建筑", false, function(Value)
    autoGrabEnabled = Value
    if Value then
        coroutine.wrap(autoGrab)()
    else
    end
end)

mainTab:Toggle("自动吃建筑", false, function(Value)
    autoEatEnabled = Value
    if Value then
        coroutine.wrap(autoEat)()
    else
    end
end)

mainTab:Toggle("自动出售", false, function(Value)
    autoSellEnabled = Value
    if Value then
        coroutine.wrap(autoSell)()
    else
    end
end)

extraTab:Toggle("自动买最大尺寸", false, function(Value)
    autoBuyMaxSizeEnabled = Value
    if Value then
        coroutine.wrap(autoBuyMaxSize)()
    else
    end
end)

extraTab:Toggle("自动买步行速度", false, function(Value)
    autoBuySpeedEnabled = Value
    if Value then
        coroutine.wrap(autoBuySpeed)()
    else
    end
end)

extraTab:Toggle("自动买大小乘数", false, function(Value)
    autoBuySizeMultiplierEnabled = Value
    if Value then
        coroutine.wrap(autoBuySizeMultiplier)()
    else
    end
end)

extraTab:Toggle("升级吃东西速度", false, function(Value)
    autoUpgradeEatSpeedEnabled = Value
    if Value then
        coroutine.wrap(autoUpgradeEatSpeed)()
    else
    end
end)

pvpTab:Toggle("自动扔石头", false, function(Value)
    autoThrowEnabled = Value
    if Value then
        coroutine.wrap(autoThrow)()
    else
    end
end)