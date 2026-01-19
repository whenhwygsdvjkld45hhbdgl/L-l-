task.defer(function()
    while true do
local name = {
    ["Character"] = "玩家",
    ["Teleport"] = "传送",
    ["Combat"] = "战斗",
    ["Trolling"] = "恶搞",
    ["ESP"] = "透视",
    ["Visual"] = "视觉",
    ["Emotes MM2"] = "表情",
    ["Other"] = "其他",
    ["Autofarm"] = "自动",
    ["Report Bugs"] = "报告Bug",
    ["Hub Status"] = "脚本状态",
    ["About Script"] = "关于脚本",
    ["Settings"] = "UI设置",
    ["WalkSpeed"] = "移速设置",
    ["Enable WalkSpeed"] = "修改移速",
    ["JumpPower"] = "跳跃设置",
    ["Enable JumpPower"] = "修改跳跃",
    ["Fly Speed"] = "飞行速度",
    ["Fly"] = "开启飞行",
    ["Noclip"] = "人物穿墙",
    ["Infinite Jump"] = "无限跳跃",
    ["FOV"] = "修改视野",
    ["Respawn"] = "重生",
    ["Grabber"] = "拿枪功能",
    ["Grab Gun"] = "拿枪",
    ["Create Grab Gun Button"] = "显示拿枪UI",
    ["Auto Grab Gun"] = "自动拿枪",
    ["Teleport To Coordinate"] = "传送地点",
    ["Teleport to Map"] = "传送到地图",
    ["Teleport to Voting Room"] = "传送到投票室",
    ["Teleport to Lobby"] = "传送到大厅",
    ["Teleport to Secret Room"] = "传送到秘密房间",
    ["Teleport To Humanoid"] = "传送玩家",
    ["Teleport to"] = "传送到",
    ["Teleport to Murderer"] = "传送到杀手",
    ["Teleport to Sheriff"] = "传送到警长",
    ["Teleport to Random Player"] = "传送到随机玩家",
    ["Auto Dodge Knifes"] = "自动躲避刀",
    ["Godmode"] = "无敌模式",
    ["Two Lifes"] = "两条命",
    ["Free Roblox Emotes"] = "免费Roblox表情",
    ["Its FE and keybind comma [ , ]"] = "这是FE，别人可以看见",
    ["Create Fake Knife"] = "创建假刀",
    ["Need Fake Knife from Marketplace"] = "需要从市场获取假刀",
    ["Sprint"] = "开启疾跑",
    ["Shoot Murderer"] = "射击杀手",
    ["View Sheriff"] = "查看警长",
    ["Silent Aim Type"] = "子弹追踪类型",
    ["Seismic"] = "震动",
    ["Create Silent Aim Gun Button"] = "显示子弹追踪UI",
    ["Auto Kill All"] = "杀死全部",
    ["Select Players"] = "选择玩家",
    ["Auto Kill selected players"] = "自动杀死选中玩家",
    ["Kill Sheriff"] = "杀死警长",
    ["Auto Kill Sheriff"] = "自动杀死警长",
    ["View Murderer"] = "查看杀手",
    ["Knife Aura"] = "刀杀戮光环",
    ["Knife Aura Range"] = "刀杀戮范围",
    ["Create Silent Aim Knife Button"] = "显示静默瞄准UI",
    ["Fling"] = "甩飞",
    ["Select Player"] = "选择玩家",
    ["Fling Player"] = "甩飞玩家",
    ["Fling Murderer"] = "甩飞凶手",
    ["Fling Sheriff"] = "甩飞警长",
    ["Fling Strenght"] = "甩飞力度",
    ["Read if the fling doesn't work"] = "如果甩飞不起作用请阅读以下内容",
    ["If fling does not work then disable ANTI-FLING , it can not be fixed due to the peculiarities of roblox itself. If the fling still does not work and antifling is disabled, then report the error"] = "如果甩飞不起作用，请禁用反甩飞，由于Roblox本身的特性，这无法修复。如果甩飞仍然不起作用且反甩飞关闭，请报告错误",
    ["Fake Die"] = "假死",
    ["Lay On Back"] = "仰卧",
    ["Sit Down"] = "坐下",
    ["Esp Players"] = "透视玩家",
    ["Esp Transparency"] = "透视透明度",
    ["Players Name Esp"] = "玩家名字透视",
    ["ESP Dropped Gun"] = "透视掉落的枪",
    ["Improve Fps"] = "提高帧数",
    ["BoomBox"] = "音响",
    ["Emotes"] = "表情",
    ["Ninja"] = "忍者",
    ["Sit"] = "坐",
    ["Headless"] = "无头",
    ["Dab"] = "Dab",
    ["Zen"] = "禅",
    ["Floss"] = "Floss",
    ["Zombie"] = "僵尸",
    ["Wave"] = "挥手",
    ["Cheer"] = "欢呼",
    ["Laugh"] = "大笑",
    ["Breaker"] = "破坏者",
    ["Break Gun"] = "破坏枪",
    ["Auto Break Gun"] = "自动破坏枪",
    ["Protection"] = "保护",
    ["Anti Trap"] = "反陷阱",
    ["Anti Fling"] = "反甩飞",
    ["Anti Afk"] = "反挂机",
    ["Notify"] = "通知",
    ["GunDrop Notify"] = "掉枪通知",
    ["Expose Roles Into the Chat"] = "在聊天中公开角色",
    ["Server"] = "服务器",
    ["Open Dev Console"] = "打开开发者控制台",
    ["Rejoin"] = "重新加入",
    ["ServerHop"] = "换服",
    ["AutoFarm"] = "自动农场",
    ["Beach Balls"] = "沙滩球",
    ["End round when you're done farming or died"] = "农场结束后或死亡时结束回合",
    ["Innocent = fling murderer \nSheriff = fling murderer"] = "无辜者 = 投掷凶手\n警长 = 投掷凶手",
    ["Kill all when you're done farming"] = "农场结束后击杀所有敌人",
    ["Murderer = kill all"] = "凶手 = 击杀全部",
    ["Farm Speed"] = "农场速度",
    ["Recommend to avoid Anticheat"] = "建议避免反作弊",
    ["Important information"] = "重要信息",
    ["Anti afk mode is already enabled by default. Enjoy the coins autofarm!"] = "反挂机模式已默认启用。享受硬币自动农场！",
    ["Doesnt Work..."] = "不起作用...",
    ["Input"] = "输入",
    ["Send Report Button"] = "发送报告按钮",
    ["How it works?"] = "它是如何工作的？",
    ["You ping me on discord with a message about your report. Your nickname, your selected category and your message are displayed"] = "您在Discord上向我发送您的报告信息。会显示您的昵称、选择的类别和您的消息",
    ["DONT SPAM ME"] = "不要骚扰我",
    ["if you spam my channel, I'll BAN you."] = "如果你骚扰我的频道，我会封禁你。",
    ["Thunder Hub Status"] = "Thunder Hub 状态",
    ["Thunder Hub Murder Mystery"] = "Thunder Hub 杀人神秘",
    ["Working - mobile, working - PC"] = "工作 - 手机，工作 - 电脑",
    ["Thunder Hub TimeBomb Duels"] = "Thunder Hub 定时炸弹决斗",
    ["Status Of the Script:"] = "脚本状态：",
    ["Product Type:"] = "产品类型：",
    ["Free ❌💸"] = "免费❌💸",
    ["Script Version:"] = "脚本版本：",
    ["Launched From The:"] = "启动自：",
    ["PC or Mobile"] = "电脑或手机",
    ["Executor:"] = "执行器：",
    ["Delta"] = "Delta",
    ["Script Support With:"] = "脚本支持：",
    ["Mobile Executors, Wave, Solara, Zorara, Xeno, AWP.GG and some others besides Scythex"] = "移动执行器、Wave、Solara、Zorara、Xeno、AWP.GG以及除Scythex之外的一些",
    ["Credits"] = "鸣谢",
    ["Youtube Channel"] = "Youtube频道",
    ["Script Tester"] = "脚本测试员",
    ["zsharki"] = "zsharki",
    ["Script Tester and Donater"] = "脚本测试员和捐赠者",
    ["qwizkoffc and rdiz890"] = "qwizkoffc 和 rdiz890",
    ["button editing"] = "按钮编辑",
    ["Drag Lock"] = "拖动锁定",
    ["Drag On"] = "拖动开启",
    ["Select Theme"] = "选择主题",
    ["Dark"] = "深色",
    ["Create Theme"] = "创建主题",
    ["Theme Name"] = "主题名称",
    ["Background Color"] = "背景颜色",
    ["Outline Color"] = "描边颜色",
    ["Text Color"] = "文本颜色",
    ["Placeholder Text Color"] = "占位符文本颜色",
    ["Update Theme"] = "更新主题",
    ["Configs"] = "配置",
    ["Configs soon"] = "配置即将推出"
}

        local coreGui = game:GetService("CoreGui")
        if not coreGui:FindFirstChild("WindUI") then
            task.wait()
            continue
        end

        local windUI = coreGui.WindUI
        if not windUI:FindFirstChild("Window") then
            task.wait()
            continue
        end
        
        local window = windUI.Window
        
        for _, child in ipairs(window:GetChildren()) do
            local targetButton = child:FindFirstChild("TextButton") or child
            if targetButton and targetButton:IsA("TextButton") then
                local textLabel = targetButton:FindFirstChild("TextLabel", true)
                if textLabel then
                    textLabel.Text = "打开天脚本"
                end
            end
        end

        for _, child in ipairs(window:GetChildren()) do
            if child:FindFirstChild("Main") then
                local main = child.Main

                if main.Topbar.Left.Title:FindFirstChild("Author") then
                    main.Topbar.Left.Title.Author:Destroy()
                end
                main.Topbar.Left.Title.Title.Text = "天脚本 | 破坏者谜团2"
                main.Topbar.Left.Title.Title.TextSize = 20

                for _, descendant in ipairs(main:GetDescendants()) do
                    if (descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox")) then
                        descendant.Text = name[descendant.Text] or descendant.Text
                    end
                end
                break
            end
        end

        task.wait()
    end
end)
task.wait()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Roma77799/Secrethub/refs/heads/main/GamesMobile/mm2.lua", true))()
gethui().WindUI.Parent = game.CoreGui