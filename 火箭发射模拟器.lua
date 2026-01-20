local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/whenheet/dasimaui/refs/heads/main/%E4%BB%98%E8%B4%B9%E7%89%88ui(2).lua"))()

local Window = WindUI:CreateWindow({
        Title = "大司马脚本<font color='#00FF00'>V3</font>",
        Icon = "rbxassetid://4483362748",
        IconTransparency = 0.5,
        IconThemed = true,
        Author = "作者:大司马",
        Folder = "CloudHub",
        Size = UDim2.fromOffset(400, 300),
        Transparent = true,
        Theme = "Light",
        User = {
            Enabled = true,
            Callback = function() print("clicked") end,
            Anonymous = false
        },
        SideBarWidth = 200,
        ScrollBarEnabled = true,
        Background = "rbxassetid://96291371536118"
    })
    

        Window:EditOpenButton({
            Title = "大司马脚本",
            Icon = "sword",
            CornerRadius = UDim.new(0, 16),
            StrokeThickness = 2,
            Color = ColorSequence.new(Color3.fromHex("FF0F7B"), Color3.fromHex("F89B29")),
            Draggable = true
        })
            
Window:Tag({
    Title = "v2",
    Color = Color3.fromHex("#30ff6a")
})

Window:Tag({
        Title = "大司马脚本", -- 标签汉化
        Color = Color3.fromHex("#315dff")
    })
    local TimeTag = Window:Tag({
        Title = "火箭发射模拟器",
        Color = Color3.fromHex("#000000")
    })

local Tabs = {
    Main = Window:Section({ Title = "信息或功能", Opened = true }),
    gn = Window:Section({ Title = "远程购买", Opened = true }),    
}

local TabHandles = {
  YI = Tabs.Main:Tab({ Title = "信息roblox", Icon = "layout-grid" }),
  Q = Tabs.Main:Tab({ Title = "传送或收集", Icon = "layout-grid" }),
  W = Tabs.gn:Tab({ Title = "传送岛", Icon = "layout-grid" }),  
  T = Tabs.gn:Tab({ Title = "自定义Ul", Icon = "layout-grid" }),       
}

Toggle = TabHandles.Q:Toggle({
    Title = "自动收集燃料",
    Value = false,    
    Callback = function(ARL)         
   
          isFuelScoopEnabled = ARL while true do wait() if isFuelScoopEnabled then for i, h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "FuelScoop" then h:Activate() end end end end

    end
})
    
Button = TabHandles.Q:Button({
    Title = "登上火箭",
    Value = false,    
    Callback = function(state) 
        game:GetService("ReplicatedStorage"):WaitForChild("BoardRocket"):FireServer()
                
        WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
                 
    end
})                 
   
Button = TabHandles.Q:Button({
    Title = "传送发射台",
    Value = false,    
    Callback = function(state) 
               game:GetService("ReplicatedStorage"):WaitForChild("RemovePlayer"):FireServer()
               
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})               
                          
    end
})       
   
Button = TabHandles.W:Button({
    Title = "白云岛",
    Value = false,    
    Callback = function(state)         
   
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-76.13252258300781, 170.55825805664062, -60.4516716003418)

WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
            
    end
})
    
Button = TabHandles.W:Button({
    Title = "漂浮岛",
    Value = false,    
    Callback = function(state)         
   
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-66.51714324951172, 720.4866333007812, -5.391753196716309)

WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
            
    end
})
   
Button = TabHandles.W:Button({
    Title = "卫星岛",
    Value = false,    
    Callback = function(state)         
   
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-34.2462043762207, 1429.4990234375, 1.3739361763000488)

WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
            
    end
})
    
Button = TabHandles.W:Button({
    Title = "蜜蜂迷宫岛",
    Value = false,    
    Callback = function(state)         
   
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6.5361199378967285, 3131.249267578125, -29.759048461914062)

WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
            
    end
})
   
Button = TabHandles.W:Button({
    Title = "月球人援救岛",
    Value = false,    
    Callback = function(state)         
   
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7.212917804718018, 5016.341796875, -19.815933227539062)

WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
            
    end
})
    
Button = TabHandles.W:Button({
    Title = "暗物质岛",
    Value = false,    
    Callback = function(state)         
   
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(68.43186950683594, 6851.94091796875, 7.890637397766113)

WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
            
    end
})
   
Button = TabHandles.W:Button({
    Title = "太空岩石岛",
    Value = false,    
    Callback = function(state)         
   
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(49.92888641357422, 8942.955078125, 8.674375534057617)

WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
            
    end
})
    
Button = TabHandles.W:Button({
    Title = "零号火星岛",
    Value = false,    
    Callback = function(state)         
   
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(54.44503402709961, 11270.0927734375, -1.273137092590332)

WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
            
    end
})
   
Button = TabHandles.W:Button({
    Title = "太空水晶岛",
    Value = false,    
    Callback = function(state)         
   
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11.579089164733887, 15295.6318359375, -27.54974365234375)

WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
            
    end
})
    
Button = TabHandles.W:Button({
    Title = "月球浆果岛",
    Value = false,    
    Callback = function(state)         
   
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-14.601255416870117, 18410.9609375, 0.9418511986732483)

WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
            
    end
})
   
Button = TabHandles.W:Button({
    Title = "铺路实岛",
    Value = false,    
    Callback = function(state)         
   
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3.272758960723877, 22539.494140625, 63.283935546875)
             
    end
})
    
Button = TabHandles.W:Button({
    Title = "流星岛",
    Value = false,    
    Callback = function(state)         
   
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-45.515689849853516, 27961.560546875, -7.358333110809326)

WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
             
    end
})
   
Button = TabHandles.W:Button({
    Title = "升级岛",
    Value = false,    
    Callback = function(state)         
   r.HumanoidRootPart.CFrame = CFrame.new(-2.7595248222351074, 33959.98828125, 53.93095397949219)

WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})
             
    end
})


local Button = TabHandles.T:Button({
    Title = "自定义界面",
    Desc = "个性化您的体验",
    Image = "palette",
    ImageSize = 20,
    Color = "White"
})

local themes = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, themeName)
end
table.sort(themes)

local themeDropdown = TabHandles.T:Dropdown({
    Title = "主题选择",
    Values = themes,
    Value = "Dark",
    Callback = function(theme)
        WindUI:SetTheme(theme)
        WindUI:Notify({
            Title = "主题应用",
            Content = theme,
            Icon = "palette",
            Duration = 2
        })
    end
})

local transparencySlider = TabHandles.T:Slider({
    Title = "透明度",
    Value = { 
        Min = 0,
        Max = 1,
        Default = 0.2,
    },
    Step = 0.1,
    Callback = function(value)
        Window:ToggleTransparency(tonumber(value) > 0)
        WindUI.TransparencyValue = tonumber(value)
    end
})

TabHandles.T:Toggle({
    Title = "启用黑色主题",
    Desc = "使用黑色调主题方案",
    Value = true,
    Callback = function(state)
        WindUI:SetTheme(state and "Dark" or "Light")
        themeDropdown:Select(state and "Dark" or "Light")
    end
})


TabHandles.T:Button({
    Title = "创建新主题",
    Icon = "plus",
    Callback = function()
        Window:Dialog({
            Title = "创建主题",
            Content = "此功能很快就会推出",
            Buttons = {
                {
                    Title = "确认",
                    Variant = "Primary"
                }
            }
        })
    end
})

TabHandles.T:Paragraph({
    Title = "配置管理",
    Desc = "保存你的设置",
    Image = "save",
    ImageSize = 20,
    Color = "White"
})

local configName = "default"
local configFile = nil
local MyPlayerData = {
    name = "Player1",
    level = 1,
    inventory = { "sword", "shield", "potion" }
}

TabHandles.T:Input({
    Title = "配置名称",
    Value = configName,
    Callback = function(value)
        configName = value
    end
})

local ConfigManager = Window.ConfigManager
if ConfigManager then
    ConfigManager:Init(Window)
    
TabHandles.T:Button({
        Title = "保存配置",
        Icon = "save",
        Variant = "Primary",
        Callback = function()
            configFile = ConfigManager:CreateConfig(configName)
            
            configFile:Register("featureToggle", featureToggle)
            configFile:Register("intensitySlider", intensitySlider)
            configFile:Register("modeDropdown", modeDropdown)
            configFile:Register("themeDropdown", themeDropdown)
            configFile:Register("transparencySlider", transparencySlider)
            
            configFile:Set("playerData", MyPlayerData)
            configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
            
            if configFile:Save() then
                WindUI:Notify({ 
                    Title = "保存配置", 
                    Content = "保存为："..configName,
                    Icon = "check",
                    Duration = 3
                })
            else
                WindUI:Notify({ 
                    Title = "错误", 
                    Content = "保存失败",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })

    TabHandles.T:Button({
        Title = "加载配置",
        Icon = "folder",
        Callback = function()
            configFile = ConfigManager:CreateConfig(configName)
            local loadedData = configFile:Load()
            
            if loadedData then
                if loadedData.playerData then
                    MyPlayerData = loadedData.playerData
                end
                
                local lastSave = loadedData.lastSave or "Unknown"
                WindUI:Notify({ 
                    Title = "加载配置", 
                    Content = "正在加载："..configName.."\n上次保存："..lastSave,
                    Icon = "refresh-cw",
                    Duration = 5
                })
                
                Button = TabHandles.Elements:Button({
                    Title = "玩家数据",
                    Desc = string.format("名字: %s\n等级: %d\n库存: %s", 
                        MyPlayerData.name, 
                        MyPlayerData.level, 
                        table.concat(MyPlayerData.inventory, ", "))
                })
            else
                WindUI:Notify({ 
                    Title = "错误", 
                    Content = "加载失败",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })
else
    TabHandles.T:Paragraph({
        Title = "配置管理不可用",
        Desc = "此功能需要配置管理",
        Image = "alert-triangle",
        ImageSize = 20,
        Color = "White"
    })
end
    