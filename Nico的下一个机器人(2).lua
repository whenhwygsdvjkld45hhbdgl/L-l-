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

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/lyyanai/rbx/refs/heads/main/lsui"))()

local win = lib:Window("大司马脚本 | Nico的下一个机器人", Color3.fromRGB(102, 255, 153), Enum.KeyCode.RightControl)

local WS = false
local Speed = 0.5
local Run = false
local Sliding = false
local Farm = false
local SpinSpeed = 4

local PlayerTab = win:Tab("基础功能")
local MainTab = win:Tab("自动功能")

PlayerTab:Toggle("自动奔跑", false, function(Value)
    Run = Value
end)

PlayerTab:Toggle("自动滑铲", false, function(Value)
    Sliding = Value
end)

PlayerTab:Textbox("移动速度(默认0.5)", false, function(Value)
    Speed = tonumber(Value) or 0.5
end)

PlayerTab:Toggle("移动速度开关", false, function(Value)
    WS = Value
end)

MainTab:Toggle("自动刷积分", false, function(Value)
    Farm = Value
end)

MainTab:Textbox("旋转速度(默认4)", false, function(Value)
    SpinSpeed = tonumber(Value) or 4
end)

game:GetService("RunService").Heartbeat:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if not character or not character:FindFirstChild("Humanoid") or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    if WS then
        character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame + character.Humanoid.MoveDirection * Speed
    end
    
    if Farm and #workspace.bots:GetChildren() >= 1 then
        if workspace.bots:GetChildren()[1]:FindFirstChild("hitbox") then 
            character.HumanoidRootPart.CFrame = CFrame.new(workspace.bots:GetChildren()[1].hitbox.Position + Vector3.new(math.sin(tick() * SpinSpeed * math.pi) * 10, -2, math.cos(tick() * SpinSpeed * math.pi) * 10))
            workspace.Gravity = 0
            if character:FindFirstChild("DownedHighlight") then
                game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("player"):WaitForChild("char"):WaitForChild("respawnchar"):FireServer()
            end
        end
    else
        workspace.Gravity = 100
    end

    if Run and wait(0.1) then
        if game.Players.LocalPlayer.Character:WaitForChild("scripts"):WaitForChild("movement"):WaitForChild("running").Value == false then
            game.Players.LocalPlayer.Character:WaitForChild("scripts"):WaitForChild("movement"):WaitForChild("running").Value = true
        end
    end

    if Sliding and wait(0.1) then
        if game.Players.LocalPlayer.Character:WaitForChild("scripts"):WaitForChild("movement"):WaitForChild("sliding").Value == false then
            game.Players.LocalPlayer.Character:WaitForChild("scripts"):WaitForChild("movement"):WaitForChild("sliding").Value = true
        end
    end
    
end)