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
local win = UILib:Window("天脚本 | 彩虹朋友2",Color3.fromRGB(102, 255, 153), Enum.KeyCode.RightControl)

local Tab = win:Tab("基础功能")

Tab:Toggle("自动收集物品", false, function(Value)
    Get = Value 
end)

Tab:Toggle("自动放置物品", false, function(Value)
    Put = Value 
end)

Tab:Toggle("自动收集眼球", false, function(Value)
_G.toggle = Value
while _G.toggle do task.wait()
    for i,v in pairs(game:GetService("Workspace"):FindFirstChild("ignore"):GetDescendants()) do
        if v.Name == "RootPart" and v:IsA("Part") and v.Parent.Name == "Looky" then
            game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = v.CFrame 
            task.wait()
        end
    end
  end
end)

Tab:Toggle("怪物上色内透", false, function(bool)
    if bool then
        local runService = game:GetService("RunService")
        event = runService.RenderStepped:Connect(function()
            for _,v in pairs(game:GetService("Workspace").Monsters:GetChildren()) do
                if not v:FindFirstChild("Lol") then
                    local esp = Instance.new("Highlight", v)
                    esp.Name = "Lol"
                    esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    esp.FillColor = Color3.new(0, 0, 255)
                end
            end
        end)
    end
    if not bool then
        event:Disconnect()
        for _,v in pairs(game:GetService("Workspace").Monsters:GetChildren()) do
            v:FindFirstChild("Lol"):Destroy()
        end
    end
end)

Tab:Toggle("物品上色内透", false, function(bool)
    if bool then
        local runService = game:GetService("RunService")
        event = runService.RenderStepped:Connect(function()
            for _,v in pairs(game:GetService("Workspace"):GetChildren()) do
                if v:FindFirstChild("TouchTrigger") then
                    if not v:FindFirstChild("Lol") then
                        local esp = Instance.new("Highlight", v)
                        esp.Name = "Lol"
                        esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        esp.FillColor = Color3.new(0, 255, 0)
                    end
                end
            end
        end)
    end
    if not bool then
        event:Disconnect()
        for _,v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v:FindFirstChild("TouchTrigger") then
                v:FindFirstChild("Lol"):Destroy()
            end
        end
    end
end)

local RunService = game:GetService("RunService")
RunService.Stepped:Connect(function() 
    if Get then 
        Model = { 
            "Block"..math.random(1, 24), 
            "FoodOrange", 
            "FoodPink", 
            "FoodGreen", 
            "Fuse"..math.random(1, 14), 
            "Battery", 
            "LightBulb", 
            "GasCanister", 
            "CakeMix" 
        } 
        for i, v in pairs(game.Workspace:GetChildren()) do 
            if table.find(Model, v.Name) then 
                v.TouchTrigger.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
            end 
        end 
    end 
end) 

RunService.Stepped:Connect(function() 
    if Put then 
        for i, v in pairs(game.Workspace.GroupBuildStructures:GetChildren()) do 
            v.Trigger.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
        end 
    end 
end)

RunService.Stepped:Connect(function() 
    for i, v in pairs(game.Workspace.ignore:GetChildren()) do 
        if v.Name == "Looky" then 
            v.Highlight.Enabled = EO 
        end 
    end 
end)