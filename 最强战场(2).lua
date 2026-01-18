task.defer(function()
local name = {
    ["| Home"] = "公告",
    ["| Main"] = "基础功能",
    ["| Farming"] = "自动功能",
    ["| Killer"] = "杀戮功能",
    ["| Misc"] = "其他功能",
    ["Speed Hub X | Official Server"] = "极速中心X | 官方服务器",
    ["Join"] = "加入",
    ["Local Player"] = "本地玩家",
    ["Set WalkSpeed"] = "设置移动速度",
    ["Set JumpPower"] = "设置跳跃力量",
    ["Enable WalkSpeed"] = "启用移动速度",
    ["This Can Set Walk Speed!"] = "可自定义移动速度！",
    ["Enable JumpPower"] = "启用跳跃力量",
    ["This Can Set JumpPower!"] = "可自定义跳跃力量！",
    ["No Clip"] = "穿墙模式",
    ["Infinits Jump Ping"] = "无限跳跃（低延迟）",
    ["Skill"] = "技能设置",
    ["Auto Ultimate"] = "自动必杀技",
    ["This is Meaning Auto Use Ultimate"] = "自动释放终极技能",
    ["Auto Dash"] = "自动冲刺",
    ["This is Meaning Auto Use Dash"] = "自动使用冲刺技能",
    ["Aim"] = "瞄准辅助",
    ["Choose Aim Part"] = "选择瞄准部位",
    ["Head"] = "头部",
    ["Aimlock"] = "锁定瞄准",
    ["Aimlock = Lock Camera Player"] = "锁定=固定镜头至目标",
    ["Body"] = "身体",
    ["Anti-Knockback"] = "防击退",
    ["BETA"] = "测试",
    ["Anti-Stun"] = "防眩晕",
    ["Anti-Busy"] = "防僵直",
    ["Player"] = "玩家选项",
    ["Auto Void"] = "自动虚空步",
    ["Auto Block"] = "自动格挡",
    ["Anti-Slow"] = "防减速",
    ["Character"] = "角色设置",
    ["Choose Equip Character"] = "选择指定角色",
    ["Equip Character"] = "装备角色",
    ["Safe Mode"] = "安全模式",
    ["Health"] = "生命值",
    ["Until Health To back"] = "生命值恢复阈值",
    ["Auto To Safe Mode At Health"] = "低血量自动保护",
    ["Auto Kill"] = "自动击杀",
    ["Auto Play To Kill"] = "自动战斗模式",
    ["Select Player"] = "选择玩家",
    ["Auto Kill Player"] = "自动击杀玩家",
    ["Auto Play To Kill Player"] = "自动攻击目标玩家",
    ["Teleport Player"] = "传送至玩家",
    ["Spectate Player"] = "观战玩家",
    ["Misc"] = "其他功能",
    ["Auto Dodge Attack"] = "自动闪避",
    ["Server"] = "服务器",
    ["Server Hop"] = "切换服务器",
    ["Server Hop [Low Player]"] = "切换至低人数服务器",
    ["Rejoin"] = "重新加入",
    ["ESP"] = "透视功能",
    ["ESP Player"] = "玩家透视",
    ["Torso"] = "躯干",
    ["HumanoidRootPart"] = "身体",
    ["Bald"] = "最强英雄",
    ["Hunter"] = "英雄猎人",
    ["Cyborg"] = "破坏性机器人",
    ["Ninja"] = "致命忍者",
    ["Batter"] = "残忍的恶魔",
    ["Blade"] = "刀锋大师",
    ["Esper"] = "狂野的精神",
    ["Purple"] = "武术家"
}
    while true do
        task.wait(0.5)
        local coreGui = game:GetService("CoreGui")
        local hubUI = coreGui:FindFirstChild("Speed Hub X Lib V3")
        if not hubUI then continue end

        local hub = hubUI:FindFirstChild("Hub")
        if not hub then continue end

        local components = hub:FindFirstChild("Components")
        if not components then continue end

        local topBar = components:FindFirstChild("Top Bar")
        if topBar then
            local title = topBar:FindFirstChild("Title")
            if title then
                title.Text = "大司马脚本 | 最强战场"
            end
        end

        for _, descendant in ipairs(hubUI:GetDescendants()) do
            if (descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox")) then
                descendant.Text = name[descendant.Text] or descendant.Text
            end
        end
    end
end)
task.wait()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()