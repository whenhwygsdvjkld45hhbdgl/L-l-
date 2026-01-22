local setting = {
    autobuild = false,
    autocollect = false,
    autocollectcrate = false,
    autocollectdollar = false,
    autocollectchest = false
}

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/whenheet/-ui2/refs/heads/main/%E5%B0%8F%E4%BA%91ui(2).lua"))()

local window = library:new("大司马脚本｜元素力量大亨")

local Page = window:Tab("主要功能",'16060333448')

local Section = Page:section("功能",true)

Section:Toggle("自动建造", "", setting.autobuild, function(state)
    setting.autobuild = state
    task.spawn(function()
        while setting.autobuild and task.wait() do
            for _,v in next,workspace.Tycoons:GetChildren() do
                if v.Name == game.Players.LocalPlayer.Name then
                    for _,a in next,v.Buttons:GetChildren() do
                        if a.Button.Color == Color3.fromRGB(0,127,0) then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a.Button.CFrame
                        end
                    end
                end
            end
        end
    end)
end)

Section:Toggle("自动收集钱", "", setting.autocollect, function(state)
    setting.autocollect = state
    task.spawn(function()
        while setting.autocollect and task.wait(5) do
            for _,v in next,workspace.Tycoons:GetChildren() do
                if v.Name == game.Players.LocalPlayer.Name then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Auxiliary.Collector.Collect.CFrame
                end
            end
        end
    end)
end)

Section:Toggle("自动收集钱箱", "", setting.autocollectcrate, function(state)
    setting.autocollectcrate = state
    task.spawn(function()
        while setting.autocollectcrate and task.wait() do
            for _,v in next,workspace:GetChildren() do
                if v.Name == "BalloonCrate" then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Crate.CFrame
                    fireproximityprompt(v.Crate.ProximityPrompt)
                end
            end
        end
    end)
end)

Section:Toggle("自动收集boss掉的钱", "", setting.autocollectdollar, function(state)
    setting.autocollectdollar = state
    task.spawn(function()
        while setting.autocollectdollar and task.wait() do
            for _,v in next,workspace:GetChildren() do
                if v.Name == "Dollar" then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                end
            end
        end
    end)
end)

Section:Toggle("自动收集宝箱", "", setting.autocollectchest, function(state)
    setting.autocollectchest = state
    task.spawn(function()
        while setting.autocollectchest and task.wait() do
            for _, v in pairs(workspace.Treasure.Chests:GetChildren()) do
                if v.Name == "Chest" then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    fireproximityprompt(v.ProximityPrompt)
                end
            end
        end
    end)
end)

Section:Button("传送一次中心", function()
    local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    wait(0.5)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Center.CFrame
    wait(0.3)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
end)