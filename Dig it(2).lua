local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/whenheet/-ui2/refs/heads/main/%E5%B0%8F%E4%BA%91ui(2).lua"))()

local window = library:new("大司马脚本")

local Page = window:Tab("主要功能",'16060333448')

local Section = Page:section("功能",true)

local autodig = false
local autoarea = false
local autoCreatePile = false

Section:Toggle("自动挖掘1", "", false, function(state)
    autodig = state
    pcall(function()
        while autodig and task.wait() do
            spawn(function()
                if game.Players.LocalPlayer.Character:FindFirstChild("Shovel") then
                    if game.Players.LocalPlayer:GetAttribute("IsDigging") == true then
                    Shovel = game.Players.LocalPlayer.Character:FindFirstChild("Shovel").Highlight.Adornee
                    repeat task.wait()
                    	game.ReplicatedStorage.Source.Network.RemoteFunctions.Digging:InvokeServer({
                        	Command = "DigPile",
                        	TargetPileIndex = Shovel:GetAttribute("PileIndex")
                        })
                    until game.Players.LocalPlayer:GetAttribute("IsDigging") == false
                    end
                end
            end)
        end
    end)
end)

Section:Toggle("自动挖掘2", "", false, function(state)
    autoarea = state
    pcall(function()
        while autodig and task.wait() do
            spawn(function()
                if game.Player.PlayerGui:FindFirstChild("Main") then
                    if game.Player.PlayerGui:FindFirstChild("Main"):FindFirstChild("DigMinigame") then
                        DigMinigame = game.Player.PlayerGui:FindFirstChild("Main"):FindFirstChild("DigMinigame")
                        DigMinigame.Cursor.Position = DigMinigame.Area.Position
                    end
                end
            end)
        end
    end)
end)

Section:Toggle("自动铲", "", false, function(state)
    autoCreatePile = state
    pcall(function()
        while autoCreatePile and task.wait() do
            spawn(function()
                if game.Players.LocalPlayer:GetAttribute("PileCount") == 0 then
                	game.ReplicatedStorage.Source.Network.RemoteFunctions.Digging:InvokeServer({
                	    Command = "CreatePile"
                	})
                end
            end)
        end
    end)
end)