local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/lyyanai/tianscript/refs/heads/main/Library/Wind_UI.lua"))()

print("反挂机已开启")
Start = tick()
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)

--保存文件
local HttpService = game:GetService("HttpService")

local folderPath = "WindUI"
makefolder(folderPath)

local function SaveFile(fileName, data)
    local filePath = folderPath .. "/" .. fileName .. ".lua"
    local jsonData = HttpService:JSONEncode(data)
    writefile(filePath, jsonData)
end

local function LoadFile(fileName)
    local filePath = folderPath .. "/" .. fileName .. ".lua"
    if isfile(filePath) then
        local jsonData = readfile(filePath)
        return HttpService:JSONDecode(jsonData)
    end
end

local function ListFiles()
    local files = {}
    for _, file in ipairs(listfiles(folderPath)) do
        local fileName = file:match("([^/]+)%.lua$")
        if fileName then
            table.insert(files, fileName)
        end
    end
    return files
end


local totalPlayers = 0 
local function updatePlayerCount() 
    totalPlayers = #game.Players:GetPlayers() 
    print("服务器总人数: ".. totalPlayers)
end 
 
game.Players.PlayerAdded:Connect(function() 
    updatePlayerCount() 
end) 
 
game.Players.PlayerRemoving:Connect(function() 
    updatePlayerCount() 
end) 
 
updatePlayerCount() 

--科学记数法
local abbrev = {"", "K", "M", "B", "T", "Qa", "Qi"}

local function Format(value, idp)
	local ex = math.floor(math.log(math.max(1, math.abs(value)), 1000))
	local abbrevs = abbrev [1 + ex] or ("e+"..ex)
	local normal = math.floor(value * ((10 ^ idp) / (1000 ^ ex))) / (10 ^ idp)
	
	return ("%."..idp.."f%s"):format(normal, abbrevs)
end

local player = game.Players.LocalPlayer

local Window = WindUI:CreateWindow({
    Title = "大司马脚本•超级大力士模拟器", 
    Icon = "rbxassetid://125659062095965", 
    Author = "大司马脚本", 
    Folder = "该服务器小天制作",
    Size = UDim2.fromOffset(290, 340), 
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 130, 
    HasOutline = true, 
})

Window:EditOpenButton({
    Title = "打开",
    Icon = "image-upscale",  
    CornerRadius = UDim.new(0,10),
    StrokeThickness = 3,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    )
})

local gg = Window:Tab({
    Title = "脚本公告",
    Icon = "notebook-tabs",
})

gg:Paragraph({
    Title = "大司马脚本公告",
    Desc = "1.欢迎使用大司马脚本，祝你玩得开心！\n2.大司马脚本，此服务器作者小天\n3.脚本默认开启反挂机，请放心使用",
    Image = "smile",
    ImageSize = 20,
})

local Paragraph5 = gg:Paragraph({
    Title = "复制",
    Buttons = {
        {
            Title = "作者快手号",
            Callback = function()
            setclipboard("作者快手号:2615709248")
            end
        },
                {
            Title = "天脚本Q群号",
            Callback = function()
            setclipboard("天脚本Q群号:1054307419")
            end
        },
    }
})

local timehh = gg:Paragraph({
    Title = "当前时间:",
    Desc = "",
    Image = "timer",
    ImageSize = 25,
})
spawn(function()
while wait() do
pcall(function()
timehh:SetDesc(""..os.date("%Y-%m-%d %H:%M:%S"))
end)
end
end)


local fuwuqi = gg:Paragraph({
    Title = "当前服务器总人数:",
    Desc = "",
    Image = "users",
    ImageSize = 25,
})
spawn(function()
while wait() do
pcall(function()
fuwuqi:SetDesc(""..totalPlayers)
end)
end
end)

local gr = Window:Tab({
    Title = "个人信息",
    Icon = "user",
})

gr:Paragraph({
    Title = "账号年龄:"..game.Players.LocalPlayer.AccountAge.."天\n服务器id:"..game.GameId.."\n用户id:"..game.Players.LocalPlayer.UserId.."\n注入器:"..identifyexecutor().."\n用户名:"..game.Players.LocalPlayer.Character.Name.."\n客户端id:\n"..game:GetService("RbxAnalyticsService"):GetClientId(),
    Desc = "\n",
})

local ty = Window:Tab({
    Title = "通用功能",
    Icon = "user-cog",
})

local Input = ty:Input({
    Title = "自定义速度",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false, 
    Callback = function(Text)
    game.Workspace[game.Players.LocalPlayer.Name].Humanoid.WalkSpeed = Text
    end
})

local Input = ty:Input({
    Title = "自定义跳跃高度",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false, 
    Callback = function(Text)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Text
    end
})

local Input = ty:Input({
    Title = "自定义重力",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false, 
    Callback = function(Text)
    game.Workspace.Gravity = Text
    end
})

local Button = ty:Button({
    Title = "重置人物",
    Callback = function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0 
    end,
})

local playnametp = ""
local Input = ty:Input({
    Title = "请输入玩家用户名",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(Text)
    playnametp = Text
    end
})

local Button = ty:Button({
    Title = "传送到玩家",
    Callback = function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players")[playnametp].Character.HumanoidRootPart.CFrame
    end,
})

local ui = Window:Tab({
    Title = "脚本界面",
    Icon = "palette",
})

local fare = {"黑暗", "玫瑰", "白色"}
local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

--ui颜色
local currentThemeName = WindUI:GetCurrentTheme()
local themes = WindUI:GetThemes()

local ThemeAccent = themes[currentThemeName].Accent
local ThemeOutline = themes[currentThemeName].Outline
local ThemeText = themes[currentThemeName].Text
local ThemePlaceholderText = themes[currentThemeName].PlaceholderText

function updateTheme()
    WindUI:AddTheme({
        Name = currentThemeName,
        Accent = ThemeAccent,
        Outline = ThemeOutline,
        Text = ThemeText,
        PlaceholderText = ThemePlaceholderText
    })
    WindUI:SetTheme(currentThemeName)
end

local wcnm = ""
local themeDropdown = ui:Dropdown({
    Title = "选择整体风格",
    Multi = false,
    AllowNone = false,
    Value = nil,
    Values = fare,
    Callback = function(theme)
    if theme == "黑暗" then
        wcnm = "Dark"
    elseif theme == "玫瑰" then
        wcnm = "Rose"    
    elseif theme == "白色" then
        wcnm = "Light"      
    end
    WindUI:SetTheme(wcnm)
    end
})
themeDropdown:Select(WindUI:GetCurrentTheme())

ui:Colorpicker({
    Title = "背景颜色",
    Default = Color3.fromHex(ThemeAccent),
    Callback = function(color)
        ThemeAccent = color:ToHex()
    end
})

ui:Colorpicker({
    Title = "轮毂颜色",
    Default = Color3.fromHex(ThemeOutline),
    Callback = function(color)
        ThemeOutline = color:ToHex()
    end
})

ui:Colorpicker({
    Title = "文字颜色",
    Default = Color3.fromHex(ThemeText),
    Callback = function(color)
        ThemeText = color:ToHex()
    end
})

local ToggleTransparency = ui:Toggle({
    Title = "透明背景",
    Callback = function(e)
        Window:ToggleTransparency(e)
    end,
    Value = WindUI:GetTransparency()
})

ui:Button({
    Title = "刷新界面",
    Callback = function()
        updateTheme()
    end
})

local Best_WorkOut,Best_Num = nil,0
for i,v in pairs(game:GetService("Workspace").Areas:GetDescendants()) do
   if v.Name == "WorkoutNumber" and v.Value > Best_Num then
       Best_WorkOut,Best_Num = v.Parent.Parent,v.Value
   end
end

Window:Divider()

local auto = Window:Tab({
    Title = "主要功能",
    Icon = "zap",
})

_G.auto_la470 = true

function auto_la470()
	while _G.auto_la470 == true do
	wait()
	
		local Plr = game:GetService("Players").LocalPlayer
 local Char = Plr.Character
 local RootPart = Char.HumanoidRootPart
 local LowerTorso = Char.LowerTorso
 
 local Space_Item = game:GetService("Workspace").Areas["Area26_Magic"].DraggableItems:FindFirstChildOfClass("MeshPart")
 
 if Space_Item == nil then
     RootPart.CFrame = CFrame.new(2568.03857421875, 81.60123443603516, 2978.7001953125)
     return true;
 end
 
 local Space = Space_Item:WaitForChild("InteractionPoint")
 local Proximity = Space:FindFirstChild("ProximityPrompt")
 
 
 RootPart.CFrame = Space.CFrame
 wait(0.1)
 Proximity:InputHoldBegin()
 Proximity:InputHoldEnd()
 
 repeat
  for i,v in pairs(game:GetService("Workspace").PlayerDraggables[game.Players.LocalPlayer.UserId]:GetChildren()) do
      v.Anchored = true
      v.CFrame = game:GetService("Workspace").Areas["Area26_Magic"].Goal.CFrame
      wait()
      v.Anchored = false
  end
  wait()
until #game:GetService("Workspace").PlayerDraggables[game.Players.LocalPlayer.UserId]:GetChildren() < 1
	end
end

local Button = auto:Toggle({
    Title = "自动拉物品",
    Value = false,
    Callback = function(state)
        _G.auto_la470 = state
            auto_la470()
    end,
})

auto:Section({ 
    Title = "锻炼",
    TextSize = 25,
})

local dzmus = 0
local Input = auto:Input({
    Title = "自定义锻炼倍数",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(Text)
    dzmus = tonumber(Text)
    end
})


local Button = auto:Toggle({
    Title = "自动锻炼",
    Desc = "如果没有自动装备杠铃请手动装备",
    Value = false,
    Callback = function(state)
    auto = state
    if auto then
 local Plr = game:GetService("Players").LocalPlayer
 local Char = Plr.Character
 local RootPart = Char.HumanoidRootPart
 local Gym = Best_WorkOut
 local Proximity = Gym.ProximityPrompt
 
 RootPart.CFrame = Gym.CFrame
 wait(0.1)

 Proximity:InputHoldBegin()
 wait(0.3)
 Proximity:InputHoldEnd()

while auto do
wait()
 local args = {
    [1] = dzmus,
    [2] = "Default"
}

game:GetService("ReplicatedStorage").StrongMan_UpgradeStrength:InvokeServer(unpack(args))
end
end
    end,
})


local egg = Window:Tab({
    Title = "开蛋功能",
    Icon = "egg",
})

_G.auto_kai25 = true

function auto_kai25()
	while _G.auto_kai25 == true do
	wait()
	local args = {
    [1] = "25Magic"
}

game:GetService("ReplicatedStorage").TGSPetShopRoll:InvokeServer(unpack(args))

	end
end

local Button = egg:Toggle({
    Title = "自动开蛋",
    Desc = "750m能量一次",
    Value = false,
    Callback = function(state)
        _G.auto_kai25 = state
            auto_kai25()
    end,
})

local reb = Window:Tab({
    Title = "重生功能",
    Icon = "refresh-cw",
})

_G.auto_reb = true

function auto_reb()
	while _G.auto_reb == true do
	wait()
	game:GetService("ReplicatedStorage").StrongMan_Rebirth:FireServer()
	end
end

local Button = reb:Toggle({
    Title = "自动重生",
    Value = false,
    Callback = function(state)
        _G.auto_reb = state
            auto_reb()
    end,
})
