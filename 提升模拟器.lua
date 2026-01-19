local OpenUI = Instance.new("ScreenGui") 
local ImageButton = Instance.new("ImageButton") 
local UICorner = Instance.new("UICorner") 
OpenUI.Name = "OpenUI" 
OpenUI.Parent = game.CoreGui 
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
local win = UILib:Window("大司马脚本 | 提升模拟器",Color3.fromRGB(102, 255, 153), Enum.KeyCode.RightControl)

local Tab = win:Tab("基础功能")
local Tab2 = win:Tab("购买功能")

Tab:Toggle("自动锻炼", false, function(Value)
AutoLift = Value
while AutoLift do wait()
local ohTable1 = {
	[1] = "GainMuscle"
}
game:GetService("ReplicatedStorage").RemoteEvent:FireServer(ohTable1)
    end
end)

Tab:Toggle("自动出售", false, function(Value)
AutoSell = Value
while AutoSell do wait()
local ohTable1 = {
	[1] = "SellMuscle"
}

game:GetService("ReplicatedStorage").RemoteEvent:FireServer(ohTable1)
    end
end)

Tab:Toggle("打开商店", false, function(Value)
if Value == true then
game:GetService("Players").LocalPlayer.PlayerGui["Main_Gui"]["UpgradeMenu_Frame"].Visible = true
else
game:GetService("Players").LocalPlayer.PlayerGui["Main_Gui"]["UpgradeMenu_Frame"].Visible = false
end
end)

Tab2:Toggle("自动购买举重物品", false, function(Value)
    local function parseCurrency(text)
        local number = text:match("^(.-)[KkMmBbTt]?$")
        local suffix = text:match("[KkMmBbTt]$")
        number = tonumber(number)
    
        if suffix then
            if suffix == 'K' or suffix == 'k' then
                number = number * 1000
            elseif suffix == 'M' or suffix == 'm' then
                number = number * 1000000
            elseif suffix == 'B' or suffix == 'b' then
                number = number * 1000000000
            elseif suffix == 'T' or suffix == 't' then
                number = number * 1000000000000
            end
        end
    
        return number
    end
    getgenv().buyfarm = Value
    task.spawn(function()
        while true do
            task.wait()
            if not getgenv().buyfarm then
                break
            end
            for i, v in pairs(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui").Main_Gui.UpgradeInfo_Frame.PageList.Page01:GetChildren()) do
                if v:IsA("ImageButton") and v:FindFirstChild("LockImage").Visible == false and v:FindFirstChild("tlPrice") and v:FindFirstChild("tlPrice").Text ~= "Owned" and v:FindFirstChild("tlPrice").Text ~= "Equipped" and v:FindFirstChild("tlPrice").Text ~= "" and v:FindFirstChild("tlPrice").Text ~= " " and v:FindFirstChild("tlPrice").Text ~= nil and parseCurrency(v:FindFirstChild("tlPrice").Text) ~= nil and not string.find(v:FindFirstChild("tlPrice").Text, "R") then
                    local tlPriceText = v:WaitForChild("tlPrice").Text
                    local cashStatusText = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui").Main_Gui.DataMenu_Frame.Cash:WaitForChild("Status").Text
                    local tlPriceNumber = parseCurrency(tlPriceText)
                    local cashStatusNumber = parseCurrency(cashStatusText)
                    if tlPriceNumber <= cashStatusNumber then
                        for try = 1, 142 do
                            if v:FindFirstChild("tlPrice").Text == "Equipped" or v:FindFirstChild("tlPrice") == "Owned" then
                                break
                            end
                            local args = {
                                [1] = {
                                    [1] = "BuyItem",
                                    [2] = "Income_Item",
                                    [3] = v.Name,
                                    [4] = try
                                }
                            }
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                        end
                    end
                end
            end
        end
    end)
end)

Tab2:Toggle("自动购买背包容量", false, function(Value)
    local function parseCurrency(text)
        local number = text:match("^(.-)[KkMmBbTt]?$")
        local suffix = text:match("[KkMmBbTt]$")
        number = tonumber(number)
    
        if suffix then
            if suffix == 'K' or suffix == 'k' then
                number = number * 1000
            elseif suffix == 'M' or suffix == 'm' then
                number = number * 1000000
            elseif suffix == 'B' or suffix == 'b' then
                number = number * 1000000000
            elseif suffix == 'T' or suffix == 't' then
                number = number * 1000000000000
            end
        end
    
        return number
    end
    getgenv().buyfarma = Value
    task.spawn(function()
        while true do
            task.wait()
            if not getgenv().buyfarma then
                break
            end
            for i, v in pairs(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui").Main_Gui.UpgradeInfo_Frame.PageList.Page02:GetChildren()) do
                if v:IsA("ImageButton") and v:FindFirstChild("LockImage").Visible == false and v:FindFirstChild("tlPrice") and v:FindFirstChild("tlPrice").Text ~= "Owned" and v:FindFirstChild("tlPrice").Text ~= "Equipped" and v:FindFirstChild("tlPrice").Text ~= "" and v:FindFirstChild("tlPrice").Text ~= " " and v:FindFirstChild("tlPrice").Text ~= nil and parseCurrency(v:FindFirstChild("tlPrice").Text) ~= nil and not string.find(v:FindFirstChild("tlPrice").Text, "R") then
                    local tlPriceText = v:WaitForChild("tlPrice").Text
                    local cashStatusText = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui").Main_Gui.DataMenu_Frame.Cash:WaitForChild("Status").Text
                    local tlPriceNumber = parseCurrency(tlPriceText)
                    local cashStatusNumber = parseCurrency(cashStatusText)
                    if tlPriceNumber <= cashStatusNumber then
                        for try = 1, 78 do
                            if v:FindFirstChild("tlPrice").Text == "Equipped" or v:FindFirstChild("tlPrice") == "Owned" then
                                break
                            end
                            local args = {
                                [1] = {
                                    [1] = "BuyItem",
                                    [2] = "Bag_Item",
                                    [3] = v.Name,
                                    [4] = try
                                }
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))                        
                        end
                    end
                end
            end
        end
    end)
end)

Tab2:Toggle("自动购买重生", false, function(Value)
    local function parseCurrency(text)
        local number = text:match("^(.-)[KkMmBbTt]?$")
        local suffix = text:match("[KkMmBbTt]$")
        number = tonumber(number)
    
        if suffix then
            if suffix == 'K' or suffix == 'k' then
                number = number * 1000
            elseif suffix == 'M' or suffix == 'm' then
                number = number * 1000000
            elseif suffix == 'B' or suffix == 'b' then
                number = number * 1000000000
            elseif suffix == 'T' or suffix == 't' then
                number = number * 1000000000000
            end
        end
    
        return number
    end
    getgenv().buyfarmb = Value
    task.spawn(function()
        while true do
            task.wait()
            if not getgenv().buyfarmb then
                break
            end
            for i, v in pairs(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui").Main_Gui.UpgradeInfo_Frame.PageList.Page03:GetChildren()) do
                if v:IsA("ImageButton") and v:FindFirstChild("LockImage").Visible == false and v:FindFirstChild("tlPrice") and v:FindFirstChild("tlPrice").Text ~= "Owned" and v:FindFirstChild("tlPrice").Text ~= "Equipped" and v:FindFirstChild("tlPrice").Text ~= "" and v:FindFirstChild("tlPrice").Text ~= " " and v:FindFirstChild("tlPrice").Text ~= nil and parseCurrency(v:FindFirstChild("tlPrice").Text) ~= nil and not string.find(v:FindFirstChild("tlPrice").Text, "R") then
                    local tlPriceText = v:WaitForChild("tlPrice").Text
                    local cashStatusText = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui").Main_Gui.DataMenu_Frame.Cash:WaitForChild("Status").Text
                    local tlPriceNumber = parseCurrency(tlPriceText)
                    local cashStatusNumber = parseCurrency(cashStatusText)
                    if tlPriceNumber <= cashStatusNumber then
                        for try = 1, 80 do
                            if v:FindFirstChild("tlPrice").Text == "Equipped" or v:FindFirstChild("tlPrice") == "Owned" then
                                break
                            end
                            local args = {
                                [1] = {
                                    [1] = "BuyItem",
                                    [2] = "Rebirth_Item",
                                    [3] = v.Name,
                                    [4] = try
                                }
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))                                                
                        end
                    end
                end
            end
        end
    end)
end)