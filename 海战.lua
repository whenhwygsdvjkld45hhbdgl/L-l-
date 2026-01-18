task.defer(function()
local name = {
    ["Naval Warfare"] = "海战脚本",
    ["Info"] = "信息",
    ["Target"] = "目标",
    ["Combat"] = "战斗",
    ["Select version"] = "选择版本",
    ["Extra features list"] = "额外功能列表",
    ["No key!! Feel free to use the advanced version"] = "无需密钥！！可免费使用高级版",
    ["Basic Features"] = "基础功能",
    ["Advanced Features"] = "高级功能",
    ["Discord invite, key changes weekly btw"] = "Discord邀请链接（密钥每周更换）",
    ["Discord invite"] = "Discord邀请",
    ["Target section"] = "目标模块",
    ["Ship defense"] = "舰船防御",
    ["Plane section"] = "飞机模块",
    ["Auto restock planes - basically infinite bombs and such"] = "自动补给飞机弹药 - 无限炸弹等",
    ["Teleports"] = "传送功能",
    ["Other"] = "其他",
    ["Godmode"] = "上帝模式",
    ["Plane"] = "飞机",
    ["Server"] = "服务器",
    ["Teleport"] = "传送",
    ["Player"] = "玩家",
    ["ESP"] = "透视",
    ["Updates/fixes"] = "更新/修复",
    ["July 7 Added tracers to ESP section by jaimz, client tools in the other section, and added plane section\nJuly 20 Added auto shoot ships, renamed anti-air into ship defense, removed Claim Islands tab, added kill opposite team.\nJuly 24 A silent aim sort of..\nOctober 11 Added teleport to opposite team harbor, battleships and carriers. Bug fixes and bypass for naval warfare's new no damage update. Added server section, Destroy Enemy Planes. RPG only section, destroy enemy carriers or battleships. Added highlighter to ship targeting and prioritizing. Finally, some GUI updates. Type '/e key' in roblox chat for keyboard (not mine)."] = "7月7日：jaimz在ESP部分添加了追踪线，在其他部分添加了客户端工具，并新增了飞机部分\n1月18日：添加自动射击船只功能，将防空重命名为舰船防御，移除占领岛屿标签，添加击杀敌方队伍功能\n1月18日：添加了类似静默瞄准的功能\n1月18日：添加传送至敌方港口、战列舰和航母功能。修复漏洞并绕过海军作战的无伤害更新。新增服务器部分-摧毁敌机。RPG专属部分-摧毁敌方航母或战列舰。为舰船目标添加高亮和优先级。最后更新了GUI界面。在Roblox聊天中输入'/e key'获取键盘(非本人制作)",
    ["Send a suggestion or simply a message"] = "发送建议或留言",
    ["Copy discord server"] = "复制Discord服务器",
    ["Target information"] = "目标信息",
    ["Selected Target's Team: Japan\nSelected Target's Coins: 14"] = "所选目标队伍: 日本\n所选目标金币: 14",
    ["Selected Target's Wins: 3\nSelected Target's Score: 1"] = "所选目标胜利数: 3\n所选目标得分: 1",
    ["Select your target"] = "选择你的目标",
    ["Select Target"] = "选择目标",
    ["Equips gun automatically if not equipped."] = "若未装备则自动装备枪支",
    ["Kill Target"] = "击杀目标",
    ["Make sure to equip the rifle, will kill target when able to."] = "请确保装备步枪，将在可能时击杀目标",
    ["Loop Kill Target"] = "循环击杀目标",
    ["Fling Target"] = "抛掷目标",
    ["Teleport to target"] = "传送至目标",
    ["View Target"] = "观察目标",
    ["Must hold the gun out for aura to work."] = "必须持枪才能使光环生效",
    ["Silent aim, It's whatever yk, rifle only btw"] = "静默瞄准，步枪专用",
    ["Silent Aim"] = "静默瞄准",
    ["Customize silent aim radius"] = "自定义静默瞄准半径",
    ["130"] = "130",
    ["Rifle"] = "步枪",
    ["Rifle kill aura"] = "步枪击杀光环",
    ["Infinite ammo - might need to execute twice or so"] = "无限弹药 - 可能需要执行两次",
    ["Shoot rifle fast"] = "快速射击步枪",
    ["Shoot rifle fast (mobile)"] = "快速射击步枪(手机)",
    ["Shoot rifle fast (PC - hold E)"] = "快速射击步枪(PC-按住E)",
    ["Auto kill opposite team"] = "自动击杀敌方队伍",
    ["INFO"] = "信息",
    ["First sit down in any turret, only the minigun turrets will work for this. It will only kill the people who aren't seated but kills them instantly when they aren't sitting anymore and when they spawn. very op imo"] = "首先坐在任何炮塔中(仅机枪炮塔有效)。只击杀未就座玩家，在他们离开座位或重生时立即击杀。非常强力",
    ["Formerly known as anti-air"] = "原名为防空",
    ["How to use anti-air"] = "防空使用说明",
    ["You need to be in any type of turret for these, it can even be the turret in the back of a plane. It will shoot any nearby targets within a 2.4k stud radius. It has a decent prediction, not perfect but gets about 80% of planes down"] = "需处于任何类型炮塔中(包括飞机尾部炮塔)。将射击2.4k单位半径内的目标，预测算法良好(约80%命中率)",
    ["Auto aim and shoot at the planes"] = "自动瞄准射击飞机",
    ["Auto aim and shoot"] = "自动瞄准射击",
    ["Auto aim - automatically aims with prediction."] = "自动瞄准 - 带预测的自动瞄准",
    ["Auto aim"] = "自动瞄准",
    ["Auto aim ship"] = "自动瞄准舰船",
    ["How to use"] = "使用说明",
    ["There may be some bugs still, made a fix so it only shoots the closest, and highlighter to see. If any bugs please let me know, maybe video it."] = "可能存在漏洞，已修复为仅射击最近目标并添加高亮显示。如有问题请反馈(最好录像)",
    ["Auto shoot islands n harbors"] = "自动射击岛屿和港口",
    ["Auto shoot islands and harbors"] = "自动射击岛屿和港口",
    ["Auto shoot ships"] = "自动射击船只",
    ["Carrier"] = "航母",
    ["Battleship"] = "战列舰",
    ["All"] = "全部",
    ["Prioritize"] = "优先级",
    ["Read before use"] = "使用前必读",
    ["Saftey walls - self explanatory"] = "安全墙 - 顾名思义",
    ["Auto reload Large Bomber"] = "大型轰炸机自动装弹",
    ["Auto reload Torpedo Bomber"] = "鱼雷轰炸机自动装弹",
    ["Auto reload Bomber"] = "轰炸机自动装弹",
    ["Instructions"] = "说明",
    ["Auto Bomb Opposite Team"] = "自动轰炸敌方队伍",
    ["Use"] = "使用",
    ["Auto Destroy Enemy Planes - stay seated"] = "自动摧毁敌机 - 保持就座",
    ["Islands"] = "岛屿",
    ["Teleport to island A"] = "传送至A岛",
    ["Teleport to island B"] = "传送至B岛",
    ["Teleport to island C"] = "传送至C岛",
    ["Ships"] = "舰船",
    ["Teleport to team carrier"] = "传送至己方航母",
    ["Teleport to team battleship"] = "传送至己方战列舰",
    ["Harbor"] = "港口",
    ["Teleport to team harbor"] = "传送至己方港口",
    ["Opp teleports"] = "敌方传送",
    ["Teleports for enemy team, if you can't seem to minimize the gui, try scroling all the way up then minimize."] = "敌方队伍传送点。若无法最小化GUI，尝试滚动到最上方再最小化",
    ["Enemy ships"] = "敌方舰船",
    ["Enemy battleships"] = "敌方战列舰",
    ["Teleport to enemy battleship"] = "传送至敌方战列舰",
    ["Enemy carriers"] = "敌方航母",
    ["Teleport to enemy carrier"] = "传送至敌方航母",
    ["Refresh carrier and battleship if it doesn't automatically."] = "若未自动刷新，请手动刷新航母/战列舰",
    ["Refresh if not auto refreshed"] = "未自动刷新时手动刷新",
    ["Enemy harbor"] = "敌方港口",
    ["Teleport to enemy harbor"] = "传送至敌方港口",
    ["Player scripts"] = "玩家脚本",
    ["Mobile Fly"] = "手机飞行",
    ["Respawn where died"] = "在死亡处重生",
    ["or a type of god mode :0 (turn off if you wanna drive normally)"] = "或类似上帝模式 :0 (正常驾驶时请关闭)",
    ["God mode (Toggle)"] = "上帝模式(开关)",
    ["Player modification"] = "玩家修改",
    ["Walkspeed"] = "移动速度",
    ["Jump power"] = "跳跃力量",
    ["Submarine ESP"] = "潜艇透视",
    ["Highlight Submarines"] = "高亮显示潜艇",
    ["Enable/disable ESP"] = "启用/禁用透视",
    ["Player ESP"] = "玩家透视",
    ["Choose how you want your ESP"] = "选择透视显示方式",
    ["Boxes"] = "方框",
    ["Name Tags"] = "名称标签",
    ["Health Text"] = "生命值文字",
    ["Distance Indicators"] = "距离指示器",
    ["Tracers"] = "追踪线",
    ["Team Colors"] = "队伍颜色",
    ["You can walk on water and you can land planes on it."] = "可在水面行走和降落飞机",
    ["Walk on water"] = "水上行走",
    ["Infinite Yield"] = "无限Yield",
    ["Client sided tools"] = "客户端工具",
    ["Get RPG"] = "获取RPG",
    ["Get Parachute"] = "获取降落伞",
    ["Get Binocular"] = "获取望远镜"
}

    while true do
        task.wait(0.1)
        local coreGui = game:GetService("CoreGui")
        local orion = coreGui:FindFirstChild("Orion")
        if not orion then continue end

        local children = orion:GetChildren()
        if #children < 2 then continue end
        
        local targetContainer = children[2]
        if not targetContainer then continue end

        local topBar = targetContainer:FindFirstChild("TopBar")
        if not topBar then continue end

        local titleLabel = topBar:FindFirstChild("TextLabel")
        if titleLabel and titleLabel:IsA("TextLabel") then
            titleLabel.Text = "大司马脚本 | 海战"
        end

        for _, descendant in ipairs(orion:GetDescendants()) do
            if (descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox")) then
                descendant.Text = name[descendant.Text] or descendant.Text
            end
        end
    end
end)

task.wait()
getgenv().gethui = nil
loadstring(game:HttpGet("https://raw.githubusercontent.com/raimbowo1/test/main/naval"))()
