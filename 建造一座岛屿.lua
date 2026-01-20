local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/whenheet/dasimaui/refs/heads/main/%E4%BB%98%E8%B4%B9%E7%89%88ui(2).lua"))()

local window = library:new("大司马脚本｜建造一座岛屿")

local Page = window:Tab("主要功能",'16060333448')

local Section = Page:section("功能",true)

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local plot = game:GetService("Workspace"):WaitForChild("Plots"):WaitForChild(plr.Name)

local land = plot:FindFirstChild("Land")
local resources = plot:WaitForChild("Resources")
local expand = plot:WaitForChild("Expand")

local TurtleLib = game:GetService("CoreGui"):FindFirstChild("TurtleUiLib")

getgenv().settings = {
	farm = false,
	expand = false,
	craft = false,
	sell = false,
	gold = false,
	collect = false,
	harvest = false,
    hive = false
}

local expand_delay = 0.1
local craft_delay = 0.1

Section:Toggle("自动挥舞", "", settings.farm, function(b)
	settings.farm = b
	task.spawn(function()
		while settings.farm do
			for _, r in ipairs(resources:GetChildren()) do
				game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("HitResource"):FireServer(r)
				task.wait()
			end
			task.wait()
		end
	end)
end)
Section:Toggle("自动建造岛屿", "", settings.expand, function(b)
	settings.expand = b
	task.spawn(function()
		while settings.expand do
			for _, exp in ipairs(expand:GetChildren()) do
				local top = exp:FindFirstChild("Top")
				if top then
					local bGui = top:FindFirstChild("BillboardGui")
					if bGui then
						for _, contribute in ipairs(bGui:GetChildren()) do
							if contribute:IsA("Frame") and contribute.Name ~= "Example" then
								local args = {
									exp.Name,
									contribute.Name,
									1
								}
								game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("ContributeToExpand"):FireServer(unpack(args))
							end
						end
					end
				end
				task.wait(0.01)
			end
			task.wait(expand_delay)
		end
	end)
end)
Section:Toggle("自动制造", "", settings.craft, function(b)
	settings.craft = b
	task.spawn(function()
		while settings.craft do
			for _, c in pairs(plot:GetDescendants()) do
				if c.Name == "Crafter" then
					local attachment = c:FindFirstChildOfClass("Attachment")
					if attachment then
						game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(attachment)
					end
				end
			end
			task.wait(craft_delay)
		end
	end)
end)
Section:Toggle("自动放置金矿", "", settings.gold, function(b)
	settings.gold = b
	task.spawn(function()
		while settings.gold do
			for _, mine in pairs(land:GetDescendants()) do
				if mine:IsA("Model") and mine.Name == "GoldMineModel" then
					game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Goldmine"):FireServer(mine.Parent.Name, 1)
				end
			end
			task.wait(1)
		end
	end)
end)
Section:Toggle("自动收集金币", "", settings.collect, function(b)
	settings.collect = b
	task.spawn(function()
		while settings.collect do
			for _, mine in pairs(land:GetDescendants()) do
				if mine:IsA("Model") and mine.Name == "GoldMineModel" then
					game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Goldmine"):FireServer(mine.Parent.Name, 2)
				end
			end
			task.wait(1)
		end
	end)
end)
Section:Toggle("自动售卖", "", settings.sell, function(b)
	settings.sell = b
	task.spawn(function()
		while settings.sell do
			for _, crop in pairs(plr.Backpack:GetChildren()) do
				if crop:GetAttribute("Sellable") then
					local a = {
						false,
						{
							crop:GetAttribute("Hash")
						}
					}
					game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("SellToMerchant"):FireServer(unpack(a))
				end
			end
			task.wait(1)
		end
	end)
end)
Section:Toggle("自动收获", "", settings.harvest, function(b)
	settings.harvest = b
	task.spawn(function()
		while settings.harvest do
			for _, crop in pairs(plot:FindFirstChild("Plants"):GetChildren()) do
				game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Harvest"):FireServer(crop.Name)
			end
			task.wait(1)
		end
	end)
end)
Section:Toggle("自动收集蜂巢", "", settings.hive, function(b)
    settings.hive = b
    task.spawn(function()
        while settings.hive do
            for _, spot in ipairs(land:GetDescendants()) do
                if spot:IsA("Model") and spot.Name:match("Spot") then
                    game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Hive"):FireServer(spot.Parent.Name, spot.Name, 2)
                end
            end
            task.wait(1)
        end
    end)
end)

local items = {}
for _, item in ipairs(plr.PlayerGui.Main.Menus.Merchant.Inner.ScrollingFrame.Hold:GetChildren()) do
	if item:IsA("Frame") and item.Name ~= "Example" then
		table.insert(items, item.Name)
	end
end

local item = nil
Section:Dropdown("选择物品", "", items, function(name)
	item = name
end)
Section:Button("购买物品", function()
	if item ~= nil then
		local a = {
			item,
			false
		}
		game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("BuyFromMerchant"):FireServer(unpack(a))
	end
end)
Section:Toggle("自动购买物品", "", false, function(b)
	settings.auto_buy = b
	task.spawn(function()
		while settings.auto_buy do
			if item then
				local a = {
					item,
					false
				}
				game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("BuyFromMerchant"):FireServer(unpack(a))
			end
			task.wait(0.25)
		end
	end)
end)
Section:Textbox("建造间隔", "", "", function(t)
	expand_delay = t
end)
Section:Textbox("制造间隔", "", "", function(t)
	craft_delay = t
end)