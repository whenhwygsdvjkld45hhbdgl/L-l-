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
local win = UILib:Window("大司马脚本 | 幸运方块",Color3.fromRGB(102, 255, 153), Enum.KeyCode.RightControl)

local Tab = win:Tab("基础功能")
local Tab2 = win:Tab("其他功能")

Tab:Toggle("自动获取黄色方块",false, function(v)
	getgenv().autoblock = v
		while autoblock==true do
game:GetService("ReplicatedStorage"):WaitForChild("SpawnLuckyBlock"):FireServer()
    wait(0.3)
         end
end)
Tab:Toggle("自动获取粉色方块",false, function(v)
	getgenv().autoblock = v
		while autoblock==true do
game:GetService("ReplicatedStorage"):WaitForChild("SpawnSuperBlock"):FireServer()
 wait(0.3)
   end
         end)
Tab:Toggle("自动获取蓝色方块",false, function(v)
	getgenv().autoblock = v
		while autoblock==true do
game:GetService("ReplicatedStorage"):WaitForChild("SpawnDiamondBlock"):FireServer()
      wait(0.3)
     end
   end)
Tab:Toggle("自动获取彩虹方块",false, function(v)
	getgenv().autoblock = v
		while autoblock==true do
game:GetService("ReplicatedStorage"):WaitForChild("SpawnRainbowBlock"):FireServer()
wait(0.3)
                           end
end)
Tab:Toggle("自动获取紫色方块",false, function(v)
	getgenv().autoblock = v
		while autoblock==true do
game:GetService("ReplicatedStorage"):WaitForChild("SpawnGalaxyBlock"):FireServer()
wait(0.3)
end
end)
Tab:Toggle("自动获取所有方块",false, function(v)
getgenv().auto = v
spawn(function(v)
		while auto == true do
game:GetService("ReplicatedStorage"):WaitForChild("SpawnLuckyBlock"):FireServer()
wait()
end
end)

spawn(function(v)
		while auto == true do
game:GetService("ReplicatedStorage"):WaitForChild("SpawnSuperBlock"):FireServer()
wait()
end
end)
spawn(function(v)
		while auto == true do
game:GetService("ReplicatedStorage"):WaitForChild("SpawnDiamondBlock"):FireServer()
wait()
end
                       end)
spawn(function(v)
		while auto == true do
game:GetService("ReplicatedStorage"):WaitForChild("SpawnRainbowBlock"):FireServer()
wait()
end
end)
spawn(function(v)
		while auto == true do
game:GetService("ReplicatedStorage"):WaitForChild("SpawnGalaxyBlock"):FireServer()
wait()
end
end)
end)

local plrlist = {}
local plr = nil
for i, v in pairs(game:GetService("Players"):GetChildren()) do
table.insert(plrlist,v.Name)
end

local drop = Tab2:Dropdown("玩家列表", plrlist, function(m)
for i, b in pairs(game:GetService("Workspace"):GetChildren()) do
if m == b.name then
plr = m
end
end
end)

Tab2:Button("刷新列表", function()
drop:Clear()
for i, v in pairs(game.Players:GetChildren()) do
if v:IsA("Player") then
drop:Add(v.Name)
end
end
end)

Tab2:Toggle("锁定传送",false, function(t)
if plr == nil then
 elseif plr ~= nil then
getgenv().autotele = t
spawn(function()
while autotele do wait()
pcall(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[plr].Character.HumanoidRootPart.CFrame wait()
end)
end
end)
end
end)

Tab2:Toggle("查看玩家",false, function(h) 
 if plr == nil then
 elseif plr ~= nil then 
 getgenv().view = h 
 spawn(function() 
 while view do wait() 
 workspace.CurrentCamera.CameraSubject = game.Players[plr].Character 
 if view == false then 
 workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character 
 end 
 end 
 end) 
 end 
 end)