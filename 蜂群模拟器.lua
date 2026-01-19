task.defer(function()
local name = {
    ["Home"] = "主页",
    ["Farming"] = "自动",
    ["Teleport"] = "传送",
    ["Items"] = "物品",
    ["Combat"] = "战斗",
    ["Setting"] = "设置",
    ["Credits"] = "制作人员",
    ["Owner - .Kron"] = "作者大司马",
    ["Version - 1.0"] = "版本V3",
    ["Settings"] = "设置",
    ["Rejoin Server"] = "重新加入服务器",
    ["Copy Discord Server"] = "欢迎使用大司马脚本",
    ["Select Field"] = "选择田地",
    ["Autofarm"] = "自动传送",
    ["Auto Dig"] = "自动挖掘",
    ["Sprinkler"] = "洒水器",
    ["Convert Ballons"] = "转换气球",
    ["Extra Settings"] = "其他功能",
    ["Farm Bubble"] = "自动刷泡泡",
    ["Locations"] = "地点",
    ["Select Location"] = "选择地点",
    ["Teleport to Selected Location"] = "传送到选定地点",
    ["Your Hive"] = "你的蜂巢",
    ["Teleport to Hive"] = "传送到蜂巢",
    ["Use All Buffs [Blue Pollen]"] = "使用所有增益[蓝色花粉]",
    ["Use All Buffs [Red Pollen]"] = "使用所有增益[红色花粉]",
    ["Use Blue Extract"] = "使用蓝色提取物",
    ["Use Red Extract"] = "使用红色提取物",
    ["Use Glitter"] = "使用闪光粉",
    ["Use Glue"] = "使用胶水",
    ["Use Oil"] = "使用油",
    ["Use Enzymes"] = "使用酶",
    ["Use Tropical Drink"] = "使用热带饮料",
    ["Use Purple Potion"] = "使用紫色药水",
    ["Use Super Smoothie"] = "使用超级冰沙",
    ["Use Marshmallow Bee"] = "使用棉花糖蜜蜂",
    ["Dispensers"] = "分配器",
    ["Use All Dispenserse"] = "使用所有分配器",
    ["Train Crab"] = "训练螃蟹",
    ["Train Snail"] = "训练蜗牛",
    ["Toggle UI"] = "切换UI",
    ["LeftAlt"] = "左Alt键",
    ["AutoFarm Speed"] = "自动传送速度",
    ["Loop AutoFarm Speed"] = "循环自动传送速度",
}
    while true do
        task.wait()
        local coreGui = game:GetService("CoreGui")
        local kronHub = coreGui:FindFirstChild("KronHub")
        if not kronHub then continue end

        for _, descendant in ipairs(kronHub:GetDescendants()) do
            if (descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox")) then
                descendant.Text = name[descendant.Text] or descendant.Text
            end
        end
    end
end)
task.wait()
loadstring(game:HttpGet("https://raw.githubusercontent.com/DevKron/Kron_Hub/refs/heads/main/bss"))()