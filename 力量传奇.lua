local L = loadstring or load
local Notis = 'https://raw.githubusercontent.com/CF-Trail/random/main/FE2Notifs.lua'
local NotificationLib = "https://raw.githubusercontent.com/BloodLetters/Ash-Libs/refs/heads/main/source.lua"
local EspLib = "https://raw.githubusercontent.com/ImamGV/Script/main/ESP"
local Lib = "https://raw.githubusercontent.com/gycgchgyfytdttr/DE/refs/heads/main/%E9%80%9A%E7%94%A8ui.lua"
local SY = "https://raw.githubusercontent.com/AxerRe/ProSite/refs/heads/main/views/Axrewatermark.lib"
local splib = L(game:HttpGet(Lib))()
local LibESP = L(game:HttpGet(EspLib))()
local GUI = L(game:HttpGet(NotificationLib))()
local notifs = L(game:HttpGet(Notis))()
local WatermarkLib = L(game:HttpGet(SY))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local V = "2.0"
local Window = splib:MakeWindow({
 Name = "大司马脚本 力量传奇" .. V,
 HidePremium = false,
 SaveConfig = true,
 Setting = true,
 ToggleIcon = "rbxassetid://98541457845136",
 ConfigFolder = "T保存配置",
 CloseCallback = true
})

local Tab = Window:MakeTab({"锻炼功能", "cool"})

local dul = {"哑铃","倒立","仰卧起坐","俯卧撑"}

local dq = ""

local cs = Tab:AddDropdown({
  Name = "请选择锻炼类型",
  Options = dul,
  Default = "...",
  Callback = function(Value)
     dq = Value         
  end
})

Tab:AddToggle({
  Name = "自动锻炼",  
  Default = false,
  Callback = function(Value)
     autowork = Value
		game:GetService("RunService").Stepped:connect(
		function()
			pcall(
				function()
					if autowork then
					local args = {
    [1] = "rep"
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
						if autowork then
						    if dq == "哑铃" then
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack.Weight)
							elseif dq == "倒立" then
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack.Handstands)
							elseif dq == "仰卧起坐" then
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack.Situps)
							elseif dq == "俯卧撑" then
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack.Pushups)
							end	
						end
					end
				end
			)
		end
		)
  end
})

local pao = {"海滩","冰霜","神话","永恒","传说"}

local pj = ""

local Section = Tab:AddSection("跑步机")

local cs = Tab:AddDropdown({
  Name = "请选择跑步机类型",
  Options = pao,
  Default = "...",
  Callback = function(Value)
     pj = Value         
  end
})

_G.autoses = true

function autoses()
	while _G.autoses == true do
	wait()
	local args = {
    [1] = "changeSpeed",
    [2] = 2
}

game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer(unpack(args))

	end
end	

Tab:AddToggle({
  Name = "自动设置速度",  
  Default = false,
  Callback = function(Value)
    _G.autoses = Value
        autoses()
  end
})

Tab:AddToggle({
  Name = "自动跑步",  
  Default = false,
  Callback = function(Value)
  if pj == "海滩" then
        getgenv().spam = Value
while getgenv().spam do
wait()
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(238.671112, 5.40315914, 387.713165, -0.0160072874, -2.90710176e-08, -0.99987185, -3.3434191e-09, 1, -2.90212157e-08, 0.99987185, 2.87843993e-09, -0.0160072874)
local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:BindToRenderStep("move",
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:WaitForChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end

if not getgenv().spam then
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:UnbindFromRenderStep("move",
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
elseif pj == "冰霜" then
 if game.Players.LocalPlayer.Agility.Value >= 2000 then
getgenv().spam = Value
while getgenv().spam do
wait()
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-3005.37866, 14.3221855, -464.697876, -0.015773816, -1.38508964e-08, 0.999875605, -5.13225586e-08, 1, 1.30429667e-08, -0.999875605, -5.11104332e-08, -0.015773816)
local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:BindToRenderStep("move",
    -- run after the character
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:WaitForChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
end

if not getgenv().spam then
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:UnbindFromRenderStep("move",
    -- run after the character
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
elseif pj == "神话" then
if game.Players.LocalPlayer.Agility.Value >= 2000 then
getgenv().spam = Value
while getgenv().spam do
wait()
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2571.23706, 15.6896839, 898.650391, 0.999968231, 2.23868635e-09, -0.00797206629, -1.73198844e-09, 1, 6.35660768e-08, 0.00797206629, -6.3550246e-08, 0.999968231)
local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:BindToRenderStep("move",
    -- run after the character
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:WaitForChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
end

if not getgenv().spam then
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:UnbindFromRenderStep("move",
    -- run after the character
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
elseif pj == "永恒" then
 if game.Players.LocalPlayer.Agility.Value >= 3500 then
getgenv().spam = Value
while getgenv().spam do
wait()
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7077.79102, 29.6702118, -1457.59961, -0.0322036594, -3.31122768e-10, 0.99948132, -6.44344267e-09, 1, 1.23684493e-10, -0.99948132, -6.43611742e-09, -0.0322036594)
local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:BindToRenderStep("move",
    -- run after the character
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:WaitForChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
end

if not getgenv().spam then
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:UnbindFromRenderStep("move",
    -- run after the character
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
elseif pj == "传说" then
 if game.Players.LocalPlayer.Agility.Value >= 3000 then
getgenv().spam = Value
while getgenv().spam do
wait()
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4370.82812, 999.358704, -3621.42773, -0.960604727, -8.41949266e-09, -0.27791819, -6.12478646e-09, 1, -9.12496567e-09, 0.27791819, -7.06329528e-09, -0.960604727)
local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:BindToRenderStep("move",
    -- run after the character
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:WaitForChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
end

if not getgenv().spam then
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:UnbindFromRenderStep("move",
    -- run after the character
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
end
end
})

local Tab = Window:MakeTab({"重生功能", "cool"})

_G.auto_reb = true

function auto_reb()
	while _G.auto_reb == true do
	wait()
	 game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")	
	end
end	

Tab:AddToggle({
  Name = "自动重生",
  Default = false,
  Callback = function(Value)
    _G.auto_reb = Value
        auto_reb()
  end
})

Tab:AddSection({
    Title = "自动停止"
})

local gr = {"280","580","980","1480","2080","2780","3580","4480","5480","6580","7780","9080","10480","11980","13580","15280","17080","18980"}

local grcs = 0

local cs = Tab:AddDropdown({
  Name = "绿石头卡宠重生",
  Options = gr,
  Default = "...",
  Callback = function(Value)
   grcs = Value
  end
})


local bcs = {"1480","2980","4980","7480","10480","13980","17980","22480","27480","32980","38980","45480","52480","59980","67980","76480","85480","94980"}

local cs = Tab:AddDropdown({
  Name = "白石头卡宠重生",
  Options = gr,
  Default = "...",
  Callback = function(Value)
   grcs = Value
  end
})


local cscs = {"189980"}

local cs = Tab:AddDropdown({
  Name = "橙石头卡宠重生",
  Options = gr,
  Default = "...",
  Callback = function(Value)
   grcs = Value
  end
})

_G.autoting = true

function autoting()
	while _G.autoting == true do
	wait()
	if game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value >= (""..grcs) then
	     game.Players.LocalPlayer:Kick("已自动重生到"..grcs.."已自动为你踢出")
	else
	     game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")	
end	         
	end
end	

local autostop = Tab:AddToggle({
  Name = "自动重生",  
  Default = false,
  Callback = function(Value)
    _G.autoting = Value
        autoting()
  end
})

local Tab = Window:MakeTab({"卡宠功能", "cool"})

local deg = {"小石头","中石头","大石头","沙滩石头","蓝石头","紫石头","橙石头","白石头","绿石头"}

local sxnl = ""

local n = ""

local cs = Tab:AddDropdown({
  Name = "选择要打的石头",
  Description = "打石头过程中死了会自动帮你停止（隔空只有蓝橙白绿可打）",
  Options = deg,
  Default = "...",
  Callback = function(Value)
     n = Value
     if n == "小石头" then
     sxnl = "0"
     elseif n == "中石头" then
     sxnl = "10"
     elseif n == "大石头" then
     sxnl = "100"
     elseif n == "沙滩石头" then
     sxnl = "5k"
     elseif n == "蓝石头" then
     sxnl = "150k"
     elseif n == "紫石头" then
     sxnl = "400k"
     elseif n == "橙石头" then
     sxnl = "750k"
     elseif n == "白石头" then
     sxnl = "1m"
     elseif n == "绿石头" then
     sxnl = "5m"
     end
  end
})

local Section = Tab:AddSection("传送型自动打石头")

Tab:AddToggle({
  Name = "自动打石头",  
  Description = "如果开了挥拳速度请不要设置太低，否则无法打",
  Default = false,
  Callback = function(Value)
 getgenv().RK0 = Value
 while getgenv().RK0 do
 wait()
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if v:IsA("Tool") and v.Name == "Punch" then
    game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v)
end
end

for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if h:IsA("Tool") and h.Name == "Punch" then 
h:Activate()
end
end
if n == "小石头" then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(7.60643005, 4.02632904, 2104.54004, -0.23040159, -8.53662385e-08, -0.973095655, -4.68743764e-08, 1, -7.66279342e-08, 0.973095655, 2.79580536e-08, -0.23040159)
elseif n == "中石头" then
if game.Players.LocalPlayer.Durability.Value >= 10 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-157.680908, 3.72453046, 434.871185, 0.923298299, -1.81774684e-09, -0.384083599, 3.45247031e-09, 1, 3.56670582e-09, 0.384083599, -4.61917082e-09, 0.923298299)
end
elseif n == "大石头" then
if game.Players.LocalPlayer.Durability.Value >= 100 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(162.233673, 3.66615629, -164.686783, -0.921312928, -1.80826774e-07, -0.38882193, -9.13036544e-08, 1, -2.48719346e-07, 0.38882193, -1.93647494e-07, -0.921312928)
end
elseif n == "沙滩石头" then
if game.Players.LocalPlayer.Durability.Value >= 5000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(329.831482, 3.66450214, -618.48407, -0.806075394, -8.67358096e-08, 0.591812849, -1.05715522e-07, 1, 2.57029176e-09, -0.591812849, -6.04919563e-08, -0.806075394)
end
elseif n == "蓝石头" then
if game.Players.LocalPlayer.Durability.Value >= 150000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-2566.78076, 3.97019577, -277.503235, -0.923934579, -4.11600105e-08, -0.382550538, -3.38838042e-08, 1, -2.57576183e-08, 0.382550538, -1.08360858e-08, -0.923934579)
end
elseif n == "紫石头" then
if game.Players.LocalPlayer.Durability.Value >= 400000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2155.61743, 3.79830337, 1227.06482, -0.551303148, -9.16796949e-09, -0.834304988, -5.61318245e-08, 1, 2.61027839e-08, 0.834304988, 6.12216127e-08, -0.551303148)
end
elseif n == "橙石头" then
if game.Players.LocalPlayer.Durability.Value >= 750000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7285.6499, 3.66624784, -1228.27417, 0.857643783, -1.58175091e-08, -0.514244199, -1.22581563e-08, 1, -5.12025977e-08, 0.514244199, 5.02172774e-08, 0.857643783)
end
elseif n == "白石头" then
if game.Players.LocalPlayer.Durability.Value >= 1000000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4160.87109, 987.829102, -4136.64502, -0.893115997, 1.25481356e-05, 0.44982639, 5.02490684e-06, 1, -1.79187136e-05, -0.44982639, -1.37431543e-05, -0.893115997) 
end
elseif n == "绿石头" then
if game.Players.LocalPlayer.Durability.Value >= 5000000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-8957.54395, 5.53625107, -6126.90186, -0.803919137, 6.6065212e-08, 0.594738603, -8.93136143e-09, 1, -1.23155459e-07, -0.594738603, -1.04318865e-07, -0.803919137) 
end
end
end
if not getgenv().RK0 then
game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools()        
end
end
})

local Section = Tab:AddSection("隔空型自动打石头")

Tab:AddToggle({
  Name = "自动打石头",  
  Default = false,
  Callback = function(Value)
  if n == "蓝石头" then
     getgenv().FrozenRock = Value
        spawn(function()
            while wait() do
                if getgenv().FrozenRock then
                    firetouchinterest(game.workspace.machinesFolder["Frozen Rock"].Rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                    wait(0.01)
                    firetouchinterest(game.workspace.machinesFolder["Frozen Rock"].Rock, game.Players.LocalPlayer.Character.LeftHand, 1)
                end
            end
        end)
   elseif n == "橙石头" then   
    getgenv().InfernoRock = Value
        spawn(function()
            while wait() do
                if getgenv().InfernoRock then
                    firetouchinterest(game.workspace.machinesFolder["Inferno Rock"].Rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                    wait(0.01)
                    firetouchinterest(game.workspace.machinesFolder["Inferno Rock"].Rock, game.Players.LocalPlayer.Character.LeftHand, 1)
                end
            end
        end)
        elseif n == "白石头" then
        getgenv().RockOfLegends = Value
        spawn(function()
            while wait() do
                if getgenv().RockOfLegends then
                    firetouchinterest(game.workspace.machinesFolder["Rock Of Legends"].Rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                    wait(0.01)
                    firetouchinterest(game.workspace.machinesFolder["Rock Of Legends"].Rock, game.Players.LocalPlayer.Character.LeftHand, 1)
                end
            end
        end)
        elseif n == "绿石头" then
        getgenv().MuscleKing = Value
        spawn(function()
            while wait() do
                if getgenv().MuscleKing then
                    firetouchinterest(game.workspace.machinesFolder["Muscle King Mountain"].Rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                    wait(0.01)
                    firetouchinterest(game.workspace.machinesFolder["Muscle King Mountain"].Rock, game.Players.LocalPlayer.Character.LeftHand, 1)
                end
            end
        end)  
        end
  end
})

Tab:AddToggle({
  Name = "自动挥拳",  
  Default = false,
  Callback = function(Value)
    punstone = Value
		game:GetService("RunService").Stepped:connect(
		function()
			pcall(
				function()
					if punstone then
					local args = {
    [1] = "punch",
    [2] = "leftHand"
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))

						if punstone then
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(
								game:GetService("Players").LocalPlayer.Backpack.Punch
							)
						end
					end
				end
			)
		end
		)
  end
})

local qq = Tab:AddSection("提示：隔空打石头，切换石头前，请先把自动打石头给关了")

local qq = Tab:AddSection("提示：自动挥拳是给隔空打石头用的")

local Tab = Window:MakeTab({"宠物商店", "cool"})

local buyjc = {"暗星","赛博龙","肌肉之王"}

local bpqq = ""

local cs = Tab:AddDropdown({
  Name = "金宠购买",
  Options = buyjc,
  Default = "...",
  Callback = function(Value)
     buyp = Value
     if buyp == "暗星" then
     bpqq = "Darkstar Hunter" 
     elseif buyp == "赛博龙" then
     bpqq = "Cybernetic Showdown Dragon"
     elseif buyp == "肌肉之王" then
     bpqq = "Muscle King"
     end       
  end
})

_G.autobuyp = true

function autobuyp()
	while _G.autobuyp == true do
	wait()
	local args = {
    [1] = game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild(""..bpqq)
}

game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(unpack(args))
	end
end	

Tab:AddToggle({
  Name = "自动购买",  
  Default = false,
  Callback = function(Value)
    _G.autobuyp = Value
        autobuyp()
  end
})

local Tab = Window:MakeTab({"快速重生", "cool"})

Tab:AddToggle({
  Name = "自动锻炼",  
  Default = false,
  Callback = function(Value)
llzddl = arg
		game:GetService("RunService").Stepped:connect(
		function()
			pcall(
				function()
					if llzddl then
					local args = {
    [1] = "rep"
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
						if llzddl then
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(
								game:GetService("Players").LocalPlayer.Backpack.Weight
							)
						end
					end
				end
			)
		end
		)
  end
})

_G.autotpjr = true

function autotpjr()
	while _G.autotpjr == true do
	wait()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8625.9296875, 13.566278457641602, -5730.4736328125)
	end
end	

Tab:AddToggle({
  Name = "自动传送到肌肉之王",  
  Default = false,
  Callback = function(Value)
    _G.autotpjr = Value
        autotpjr()
  end
})

_G.autoshe2 = true

function autoshe2()
	while _G.autoshe2 == true do
	wait()
	local args = {
    [1] = "changeSize",
    [2] = 2
}

game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer(unpack(args))

	end
end	

Tab:AddToggle({
  Name = "自动设置大小为2",  
  Default = false,
  Callback = function(Value)
    _G.autoshe2 = Value
        autoshe2()
  end
})

local Section = Tab:AddSection("重生请手动去重生功能开启")

local Tab = Window:MakeTab({"玩家信息", "cool"})

Tab:AddSection("自身信息")

local myl = Tab:AddSection("力量:")
spawn(function()
while wait() do
pcall(function()
myl:Set("力量:"..game:GetService("Players").LocalPlayer.leaderstats.Strength.Value )
end)
end
end)

local nlll = Tab:AddSection("耐力:")
spawn(function()
while wait() do
pcall(function()
nlll:Set("耐力:"..game:GetService("Players").LocalPlayer.Durability.Value)
end)
end
end)

local mjjj = Tab:AddSection("敏捷:")
spawn(function()
while wait() do
pcall(function()
mjjj:Set("敏捷:"..game:GetService("Players").LocalPlayer.Agility.Value)
end)
end
end)

local mycs = Tab:AddSection("重生:")
spawn(function()
while wait() do
pcall(function()
mycs:Set("重生:"..game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value)
end)
end
end)

local mybs = Tab:AddSection("宝石:")
spawn(function()
while wait() do
pcall(function()
mybs:Set("宝石:"..game:GetService("Players").LocalPlayer.Gems.Value)
end)
end
end)
