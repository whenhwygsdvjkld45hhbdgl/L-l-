getgenv().SlowDownSpeed = false

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
local win = UILib:Window("大司马脚本 | 感染的微笑",Color3.fromRGB(0, 255, 0), Enum.KeyCode.RightControl)

local Tab = win:Tab("主要功能")

Tab:Toggle("自动抓(微笑)", false, function(Value)
    getgenv().InfectAura = Value
        if getgenv().InfectAura then
            getgenv().InfectAuraConnection = game:GetService("RunService").Stepped:Connect(function()
                pcall(function()
                    game:GetService("Players").LocalPlayer.Character.Infected.InfectEvent:FireServer()
                end)
            end)
        else
            if getgenv().InfectAuraConnection then
                getgenv().InfectAuraConnection:Disconnect()
                getgenv().InfectAuraConnection = nil
            end
        end
end)

Tab:Textbox("输入速度",false, function(Value)
    getgenv().SlowDownSpeed = Value
end)

Tab:Toggle("开启微笑速度", false, function(Value)
    getgenv().SlowDownSpeed = getgenv().SlowDownSpeed or 16
        getgenv().NoSlowDown = Value
        if getgenv().NoSlowDown then
            SteppedConnection = game:GetService("RunService").Stepped:Connect(function()
                pcall(function()
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().SlowDownSpeed
                end)
            end)
        else
            if SteppedConnection then
                SteppedConnection:Disconnect()
                SteppedConnection = nil
            end
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
end)

Tab:Toggle("自动棒球棍击打", false, function(Value)
    getgenv().HitAura = Value
        if getgenv().HitAura then
            getgenv().HitAuraConnection = game:GetService("RunService").Stepped:Connect(function()
                pcall(function()
                    local character = game:GetService("Players").LocalPlayer.Character
                    if character then
                        local bat = character:FindFirstChildOfClass("Tool")
                        if bat and bat.Name == "Bat" and bat:FindFirstChild("SwingEvent") then
                            bat.SwingEvent:FireServer()
                        end
                           if packedice and packedice.Name == "Packed Ice" and packedice:FindFirstChild("SwingEvent") then
                           packedice.SwingEvent:FireServer()
                        end
                    end
                end)
            end)
        else
            if getgenv().HitAuraConnection then
                getgenv().HitAuraConnection:Disconnect()
                getgenv().HitAuraConnection = nil
            end
        end
end)


Tab:Toggle("自动玻璃瓶击打", false, function(Value)
    getgenv().HitAura = Value
        if getgenv().HitAura then
            getgenv().HitAuraConnection = game:GetService("RunService").Stepped:Connect(function()
                pcall(function()
                    local character = game:GetService("Players").LocalPlayer.Character
                    if character then
                        local bottle = character:FindFirstChildOfClass("Tool")
                        if bottle and bottle.Name == "Bottle" and bottle:FindFirstChild("SwingEvent") then
                            bottle.SwingEvent:FireServer()
                        end
                           if packedice and packedice.Name == "Packed Ice" and packedice:FindFirstChild("SwingEvent") then
                           packedice.SwingEvent:FireServer()
                        end
                    end
                end)
            end)
        else
            if getgenv().HitAuraConnection then
                getgenv().HitAuraConnection:Disconnect()
                getgenv().HitAuraConnection = nil
            end
        end
end)

Tab:Toggle("玩家透视", false, function(val)
    getgenv().enabled = val
        getgenv().uselocalplayer = false
        getgenv().filluseteamcolor = false
        getgenv().outlineuseteamcolor = false
        getgenv().fillcolor = Color3.new(190, 190, 0)
        getgenv().outlinecolor = Color3.new(190, 190, 0)
        getgenv().filltrans = 0.8
        getgenv().outlinetrans = 0.8

        local holder = game.CoreGui:FindFirstChild("ESPHolder") or Instance.new("Folder")
        holder.Name = "ESPHolder"
        holder.Parent = game.CoreGui
        holder.RobloxLocked = false

        if enabled == false then
            holder:Destroy()
        end

        if uselocalplayer == false and holder:FindFirstChild(game.Players.LocalPlayer.Name) then
            holder:FindFirstChild(game.Players.LocalPlayer.Name):Destroy()
        end

        while getgenv().enabled do
            task.wait()
            for _,v in pairs(game.Players:GetChildren()) do
                local chr = v.Character
                if chr ~= nil then
                    local esp = holder:FindFirstChild(v.Name) or Instance.new("Highlight")
                    esp.Name = v.Name
                    if uselocalplayer == false and esp.Name == game.Players.LocalPlayer.Name then
                    else
                        esp.Parent = holder
                        if filluseteamcolor then
                            esp.FillColor = v.TeamColor.Color
                        else
                            esp.FillColor = fillcolor 
                        end
                        if outlineuseteamcolor then
                            esp.OutlineColor = v.TeamColor.Color
                        else
                            esp.OutlineColor = outlinecolor    
                        end
                        esp.FillTransparency = filltrans
                        esp.OutlineTransparency = outlinetrans
                        esp.Adornee = chr
                        esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    end
                end
            end
        end
end)

Tab:Button("获取武器", function()
local previousCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
local destinationCFrame = CFrame.new(-19, -3, -17) 
        local humanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
        humanoidRootPart.CFrame = destinationCFrame 
    wait()
        firetouchinterest(humanoidRootPart, game.Workspace.Map.HumanBase.Vendor.BatCollection.HitBox, 0) 
        firetouchinterest(humanoidRootPart, game.Workspace.Map.HumanBase.Vendor.BatCollection.HitBox, 1) 
        fireclickdetector(game.Workspace.Map.HumanBase.Vendor.BatCollection.ClickDetector)
        wait(0.111111) 
        humanoidRootPart.CFrame = previousCFrame 
end)