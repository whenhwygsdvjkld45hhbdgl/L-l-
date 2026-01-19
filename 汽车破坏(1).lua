local players = game:GetService("Players")
local vu = game:GetService("VirtualUser")

local lp = players.LocalPlayer
local carCollection = workspace.CarCollection
local guiScript = getsenv(lp.PlayerGui:WaitForChild("GUIs"))
local openFunc = guiScript["OpenDealership"]
local spawnFunc = guiScript["SpawnButton"]
local doBreak = false

local function getCurrentCar()
    local car = carCollection:FindFirstChild(lp.Name)
    if not car then return nil end

    local model = car:FindFirstChild("Car")
    if not model then return nil end

    local isNotBroken =
        model:FindFirstChild("Wheels"):FindFirstChildOfClass("Part") and
        model:FindFirstChild("Body"):FindFirstChild("Engine"):FindFirstChildOfClass("MeshPart")

    return isNotBroken and model or nil
end

local function getCharacter()
    return lp.Character or lp.CHaracterAdded:Wait()
end

local function canSpawn()
    return lp.SpawnTimer.Value <= 0
end

local function spawnBestCar()
    openFunc()
    spawnFunc(true, Enum.UserInputState.Begin)
end

local function destroyCar()
    local hum = getCharacter():FindFirstChildOfClass("Humanoid")
    local hrp = getCharacter():FindFirstChild("HumanoidRootPart")

    if not hum or not hrp then return end

    local car = getCurrentCar()

    repeat task.wait() until car.PrimaryPart ~= nil

    repeat task.wait()
        car = getCurrentCar()
        if not car then return end

        task.wait(.1)

        pcall(function()
            if not car.PrimaryPart then return end
            car.PrimaryPart.Velocity = Vector3.new(0, 300, 0)
            car.PrimaryPart.CFrame *= CFrame.Angles(180, 0, 0)
        end)

        task.wait(.1)

        pcall(function()
            if not car.PrimaryPart then return end
            car.PrimaryPart.Velocity = Vector3.new(0, -400, 0)
            car.PrimaryPart.CFrame *= CFrame.Angles(180, 0, 0)
        end)

    until not doBreak
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

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/lyyanai/rbx/main/lsui"))()

local win = lib:Window("大司马脚本 | 汽车破坏",Color3.fromRGB(0, 255, 0), Enum.KeyCode.RightControl)

local tab = win:Tab("自动功能")

local AutofarmEnabled = false

tab:Toggle("自动摧毁汽车(刷钱)", false, function(bool)
    if bool == true then
        AutofarmEnabled = true
        while AutofarmEnabled do
            wait(0.5)
            if canSpawn() then
                doBreak = true
                task.delay(10, function()
                    doBreak = false
                end)
                pcall(function()
                    spawnBestCar()
                    destroyCar()
                end)
            end
        end
    else
        AutofarmEnabled = false
    end
end)

tab:Toggle("防掉线(反挂机)", false, function(bool)
    if bool == true then
        for i,v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
            v:Disable()
        end
    else
        for i,v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
            v:Enable()
        end
    end
end)

tab:Button("生成车辆", function()
    spawnBestCar()
end)

tab:Button("摧毁车辆", function()
    doBreak = true
    task.delay(10, function() doBreak = false end)
    pcall(function()
        destroyCar()
    end)
end)