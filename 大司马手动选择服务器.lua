local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/whenheeeww/chenui/refs/heads/main/%E8%BE%B0ui(1).lua"))()
local window = library.new(library, "大司马脚本", "选择服务器")

local mainTab = window:Tab("关于")
local combatSection = mainTab:section("简单的关于", true)

combatSection:Button("作者大司马",function()
    setclipboard("QQ3383348357")
end)
combatSection:Button("感谢购买大司马脚本",function()
    setclipboard("QQ3383348357")
end)

combatSection:Button("点我复制作者QQ",function()
    setclipboard("3383348357")
end)
combatSection:Button("点我复制作者QQ群",function()
    setclipboard("1028199013")
end)
combatSection:Button("点我复制作者QQ副群",function()
    setclipboard("287240944")
end)

local scriptTab = window:Tab("选择游戏")
local scriptSection = scriptTab:section("请选择服务器", true)

scriptSection:SearchBox("搜索脚本")

scriptSection:Button("俄亥俄州", function()
    loadstring("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/%E4%BF%84%E4%BA%A5%E4%BF%84%E5%B7%9E2(7).lua")()
end)

scriptSection:Button("nico的下一个机器人", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/Nico%E7%9A%84%E4%B8%8B%E4%B8%80%E4%B8%AA%E6%9C%BA%E5%99%A8%E4%BA%BA(2).lua"))()
end)

scriptSection:Button("BF", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/BF%20(2)(4).lua"))()
end)

scriptSection:Button("chin", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/chin.lua", true))()
end)

scriptSection:Button("doors", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/doors.lua", true))()
end)

scriptSection:Button("暴力区", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/%E6%9A%B4%E5%8A%9B%E5%8C%BA.lua", true))()
end)

scriptSection:Button("被遗弃", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."被遗弃.lua", true))()
end)

scriptSection:Button("餐厅大亨", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."餐厅大亨.lua", true))()
end)

scriptSection:Button("成为乞丐", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."成为乞丐.lua", true))()
end)

scriptSection:Button("刀刃球", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."刀刃球.lua", true))()
end)

scriptSection:Button("躲避", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."躲避.lua", true))()
end)

scriptSection:Button("伐木大亨", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."伐木大亨.lua", true))()
end)

scriptSection:Button("河北唐县", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."河北唐县.lua", true))()
end)

scriptSection:Button("极速传奇", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."极速传奇.lua", true))()
end)

scriptSection:Button("监狱人生", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."监狱人生.lua", true))()
end)

scriptSection:Button("建造一架飞机", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."建造一架飞机.lua", true))()
end)

scriptSection:Button("紧急汉堡", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."紧急汉堡.lua", true))()
end)

scriptSection:Button("开战宇宙", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."开战宇宙.lua", true))()
end)

scriptSection:Button("矿井", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."矿井.lua", true))()
end)

scriptSection:Button("力量传奇", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."力量传奇.lua", true))()
end)

scriptSection:Button("脑叶公司", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."脑叶公司.lua", true))()
end)

scriptSection:Button("皮肤信奉者", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."皮肤信奉者.lua", true))()
end)

scriptSection:Button("破坏模拟器", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."破坏模拟器.lua", true))()
end)

scriptSection:Button("启示录", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."启示录.lua", true))()
end)

scriptSection:Button("汽车经销大亨", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."汽车经销大亨.lua", true))()
end)

scriptSection:Button("枪战竞技场", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."枪战竞技场.lua", true))()
end)

scriptSection:Button("请捐赠", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."请捐赠.lua", true))()
end)

scriptSection:Button("森林中的99夜", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."森林中的99页.lua", true))()
end)

scriptSection:Button("死铁轨", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."死铁轨.lua", true))()
end)

scriptSection:Button("死亡球", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."死亡球.lua", true))()
end)

scriptSection:Button("寻宝模拟器", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."寻宝模拟器(1).lua", true))()
end)

scriptSection:Button("一路向西", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."一路向西1.lua", true))()
end)

scriptSection:Button("战斗勇士", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."战斗勇士.lua", true))()
end)

scriptSection:Button("战争大亨", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."战争大亨.lua", true))()
end)

scriptSection:Button("殖民地", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."殖民地.lua", true))()
end)

scriptSection:Button("终极战场", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."终极战场.lua", true))()
end)

scriptSection:Button("穷小子打工记", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."穷小子打工记.lua", true))()
end)

scriptSection:Button("彩虹朋友", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."彩虹朋友.lua", true))()
end)

scriptSection:Button("汽车破坏", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."汽车破坏(1).lua", true))()
end)

scriptSection:Button("提升模拟器", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."提升模拟器.lua", true))()
end)

scriptSection:Button("超级大力士模拟器", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."超级大力士模拟器.lua", true))()
end)

scriptSection:Button("蜂群模拟器", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."蜂群模拟器.lua", true))()
end)

scriptSection:Button("火箭发射器", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."火箭发射模拟器.lua", true))()
end)

scriptSection:Button("吃掉世界", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."吃掉世界.lua", true))()
end)

scriptSection:Button("幸运方块", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."幸运方块.lua", true))()
end)

scriptSection:Button("在超市生活一周", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."在超市生活一周(3).lua", true))()
end)

scriptSection:Button("压力", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."压力.lua", true))()
end)

scriptSection:Button("感染性微笑", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."感染的微笑.lua", true))()
end)

scriptSection:Button("恶魔学", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."恶魔学(1).lua", true))()
end)

scriptSection:Button("digit", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."Dig it(2).lua", true))()
end)

scriptSection:Button("元素力量大亨", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."元素力量大亨.lua", true))()
end)

scriptSection:Button("画我", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."画我.lua", true))()
end)

scriptSection:Button("自然灾害", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."自然灾害.lua", true))()
end)

scriptSection:Button("通缉", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/%E9%80%9A%E7%BC%891.lua", true))()
end)

scriptSection:Button("盲射", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/%E8%82%93(1).lua", true))()
end)

scriptSection:Button("隐藏或死亡", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."隐藏或死亡(1).lua", true))()
end)

scriptSection:Button("监狱人生", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/%E7%9B%91%E7%8B%B1%E4%BA%BA%E7%94%9F.lua", true))()
end)

scriptSection:Button("bf二海", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/BF%20(2)(4).lua"))()
end)

scriptSection:Button("bf三海", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/BF%20(2)(4).lua"))()
end)

scriptSection:Button("巴掌模拟器", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/%E5%B7%B4%E6%8E%8C%E6%A8%A1%E6%8B%9F%E5%99%A8.lua"))()
end)

scriptSection:Button("鱼 (16732694052)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/%E5%B7%B4%E6%8E%8C%E6%A8%A1%E6%8B%9F%E5%99%A8.lua"))()
end)

scriptSection:Button("鱼 (131716211654599)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/%E5%B7%B4%E6%8E%8C%E6%A8%A1%E6%8B%9F%E5%99%A8.lua"))()
end)

scriptSection:Button("chin (13977939077)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/chin.lua", true))()
end)

scriptSection:Button("森林中的99夜 (126509999114328)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."森林中的99页.lua", true))()
end)

scriptSection:Button("海战", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."海战.lua", true))()
end)

scriptSection:Button("种植花园", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/".."种植花园.lua"))()
end)

scriptSection:Button("通用脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenhwygsdvjkld45hhbdgl/L-l-/refs/heads/main/%E5%A4%A7%E5%8F%B8%E9%A9%AC%E4%BB%98%E8%B4%B9%E9%80%9A%E7%94%A8(2).lua"))()
end)
