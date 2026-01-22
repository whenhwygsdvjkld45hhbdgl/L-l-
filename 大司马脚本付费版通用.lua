local RevenantLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/Revenant", true))()
RevenantLib.DefaultColor = Color3.fromRGB(255, 0, 0)
RevenantLib:Notification({
  Text = "我们不支持该服务器\u{e000}",
  Duration = 6,
})
wait(1)
RevenantLib:Notification({
  Text = "已自动为您切换通用脚本\u{e000}",
  Duration = 6,
})
wait(1)
RevenantLib:Notification({
  Text = "您可以在售后群催更^ω^",
  Duration = 6,
})
local PlayerConfig = {
  playernamedied = "",
  dropdown = {},
  LoopTeleport = false,
  message = "",
  sayCount = 1,
  sayFast = false,
  autoSay = false,
}
local MovementConfig = {
  tpwalkslow = 0,
  tpwalkmobile = 0,
  tpwalkquick = 0,
  tpwalkslowenable = false,
  tpwalkmobileenable = false,
  tpwalkquickenable = false,
  spinspeed = 0,
  HitboxStatue = false,
  HitboxSize = 0,
  HitboxTransparency = 1,
  HitboxBrickColor = "Really red",
  DefaultFPS = 60,
  CurrentFPS = 60,
  FPSLocked = false,
  FPSVisible = false,
}
local ColorConfig = {
  ['红色']= Color3.fromRGB(255, 0, 0),
  ['蓝色'] = Color3.fromRGB(0, 0, 255),
  ['黄色'] = Color3.fromRGB(255, 255, 0),
  ['绿色'] = Color3.fromRGB(0, 255, 0),
  ['青色'] = Color3.fromRGB(0, 255, 255),
  ['橙色'] = Color3.fromRGB(255, 165, 0),
  ['紫色'] = Color3.fromRGB(128, 0, 128),
  ['白色'] = Color3.fromRGB(255, 255, 255),
  ['黑色'] = Color3.fromRGB(0, 0, 0),
}
local AimConfig = {
  fovsize = 50,
  fovlookAt = false,
  fovcolor = Color3.fromRGB(0, 255, 0),
  fovthickness = 2,
  Visible = false,
  distance = 200,
  ViewportSize = 2,
  Transparency = 5,
  Position = "Head",
  teamCheck = false,
  wallCheck = false,
  aliveCheck = false,
  prejudgingselfsighting = false,
  prejudgingselfsightingdistance = 100,
  smoothness = 5,
  aimSpeed = 5,
  targetLock = false,
  hitMarker = false,
  dynamicFOV = false,
  dynamicFOVScale = 1.5,
  priorityMode = "Smart",
  aimMode = "AI",
  autoFire = false,
  fireRate = 10,
  bulletDelay = 0.1,
  weaponSwitch = false,
  threatPriority = false,
  healthPriority = false,
}
local BodyPartMap = {
  ['头部'] = "Head",
  ['脖子'] = "HumanoidRootPart",
  ['躯干'] = "Torso",
  ['左臂'] = "Left Arm",
  ['右臂'] = "Right Arm",
  ['左腿'] = "Left Leg",
  ['右腿'] = "Right Leg",
  ['左手'] = "LeftHand",
  ['右手'] = "RightHand",
  ['左小臂'] = "LeftLowerArm",
  ['右小臂'] = "RightLowerArm",
  ['左大臂'] = "LeftUpperArm",
  ['右大臂'] = "RightUpperArm",
  ['左脚'] = "LeftFoot",
  ['左小腿'] = "LeftLowerLeg",
  ['上半身'] = "UpperTorso",
  ['左大腿'] = "LeftUpperLeg",
  ['右脚'] = "RightFoot",
  ['右小腿'] = "RightLowerLeg",
  ['下半身'] = "LowerTorso",
  ['右大腿'] = "RightUpperLeg",
}
function shuaxinlb(includeSelf)
  
  PlayerConfig.dropdown = {}
  if includeSelf == true then
    for _, player in pairs(game.Players:GetPlayers()) do
      table.insert(PlayerConfig.dropdown, player.Name)
    end
  else
    local localPlayer = game.Players.LocalPlayer
    for _, player in pairs(game.Players:GetPlayers()) do
      if player ~= localPlayer then
        table.insert(PlayerConfig.dropdown, player.Name)
      end
    end
  end
end
shuaxinlb(true)
function Notify(title, text, icon, duration)
  
  game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = title,
    Text = text,
    Icon = icon,
    Duration = duration,
  })
end
local function SafeCall(func, ...)
  
  local success, result = pcall(func, ...)
  if not success then
    return nil
  end
  return result
end
local FOVCircle = nil
local FOVLine1 = nil
local FOVLine2 = nil
local function InitFOV(radius, color, thickness, transparency)
  
  local RunService = game:GetService("RunService")
  local UserInputService = game:GetService("UserInputService")
  local Players = game:GetService("Players")
  local Camera = game.Workspace.CurrentCamera
  if FOVCircle then
    FOVCircle:Remove()
    FOVCircle = nil
  end
  FOVCircle = Drawing.new("Circle")
  FOVCircle.Visible = true
  FOVCircle.Thickness = thickness
  FOVCircle.Color = color
  FOVCircle.Filled = false
  FOVCircle.Radius = radius
  FOVCircle.Position = Camera.ViewportSize / 2
  FOVCircle.Transparency = transparency
  FOVLine1 = Drawing.new("Line")
  FOVLine1.Visible = false
  FOVLine1.Thickness = 2
  FOVLine1.Color = Color3.fromRGB(255, 0, 0)
  FOVLine1.Transparency = 1
  FOVLine2 = Drawing.new("Line")
  FOVLine2.Visible = true
  FOVLine2.Thickness = 1
  FOVLine2.Color = Color3.fromRGB(255, 255, 255)
  FOVLine2.Transparency = 1
  local function UpdateFOVDisplay()
    
    local viewportSize = Camera.ViewportSize
    FOVCircle.Position = viewportSize / 2
    if AimConfig.dynamicFOV then
      FOVCircle.Radius = AimConfig.fovsize * AimConfig.dynamicFOVScale
    else
      FOVCircle.Radius = AimConfig.fovsize
    end
    FOVLine2.From = Vector2.new(viewportSize.X / 2 - 5, viewportSize.Y / 2)
    FOVLine2.To = Vector2.new(viewportSize.X / 2 + 5, viewportSize.Y / 2)
    FOVLine2.From = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2 - 5)
    FOVLine2.To = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2 + 5)
  end
  UserInputService.InputBegan:Connect(function(input)
    
    if input.KeyCode == Enum.KeyCode.Delete then
      RunService:UnbindFromRenderStep("FOVUpdate")
      FOVCircle:Remove()
      FOVCircle = nil
      FOVLine1:Remove()
      FOVLine1 = nil
      FOVLine2:Remove()
      FOVLine2 = nil
    end
  end)
  RunService.RenderStepped:Connect(function()
    
    UpdateFOVDisplay()
  end)
end
local function CleanupFOV()
  
  if FOVCircle then
    FOVCircle:Remove()
    FOVCircle = nil
  end
  if FOVLine1 then
    FOVLine1:Remove()
    FOVLine1 = nil
  end
  if FOVLine2 then
    FOVLine2:Remove()
    FOVLine2 = nil
  end
end
local function UpdateFOVSettings()
  
  if FOVCircle then
    FOVCircle.Thickness = AimConfig.fovthickness
    FOVCircle.Radius = AimConfig.fovsize
    FOVCircle.Color = AimConfig.fovcolor
    FOVCircle.Transparency = AimConfig.Transparency / 10
  end
end
local function IsSameTeam(player)
  
  return player.Team == game.Players.LocalPlayer.Team
end
local function IsAlive(player)
  
  return player.Character and player.Character:FindFirstChild("Humanoid") and 0 < player.Character.Humanoid.Health
end
local function CheckWall(player, bodyPart)
  
  
  if not AimConfig.wallCheck then
    return true
  end
  local localCharacter = game.Players.LocalPlayer.Character
  if not localCharacter then
    return false
  end
  local targetPart = player.Character and player.Character:FindFirstChild(bodyPart)
  if not targetPart then
    return false
  end
  local ray = Ray.new(game.Workspace.CurrentCamera.CFrame.Position, targetPart.Position - game.Workspace.CurrentCamera.CFrame.Position)
  local workspace = game.Workspace
  local hitPart, hitPosition = workspace:FindPartOnRayWithIgnoreList(ray, {
    localCharacter
  })
  local isVisible
  if hitPart then
    isVisible = hitPart:IsDescendantOf(player.Character)
  else
    isVisible = true
  end
  return isVisible
end
local function PredictPosition(player, part)
  
  return part.Position + part.AssemblyLinearVelocity * ((part.Position - game.Workspace.CurrentCamera.CFrame.Position)).Magnitude / 1000
end
local function IsInFOV(position)
  
  local camera = game.Workspace.CurrentCamera
  local viewportPoint = camera:WorldToViewportPoint(position)
  return (Vector2.new(viewportPoint.X, viewportPoint.Y) - camera.ViewportSize / 2).Magnitude <= AimConfig.fovsize
end
local function GetBestTarget(bodyPart)
  
  local bestScore = -math.huge
  local bestTarget = nil	
  for _, player in ipairs(game.Players:GetPlayers()) do
    if (not AimConfig.aliveCheck or IsAlive(player)) and player ~= game.Players.LocalPlayer then
      local targetPart = player.Character and player.Character:FindFirstChild(bodyPart)
      if targetPart then
        local distance = (targetPart.Position - game.Workspace.CurrentCamera.CFrame.Position).Magnitude
        -- ...existing code...
        local speed = targetPart.AssemblyLinearVelocity.Magnitude
        local camera = workspace.CurrentCamera
        local screenPoint, isVisible = camera:WorldToViewportPoint(targetPart.Position) -- screenPoint 是 Vector3
        local crosshairDistance = math.huge
        
        if isVisible and screenPoint then
            local viewportPos = Vector2.new(screenPoint.X, screenPoint.Y)
            crosshairDistance = (viewportPos - camera.ViewportSize / 2).Magnitude
        end
        
        local priorityScore = 0
        if AimConfig.priorityMode == "Distance" then
            priorityScore = -distance
        -- ...existing code...
        elseif AimConfig.priorityMode == "Crosshair" then
          priorityScore = -crosshairDistance
        elseif AimConfig.priorityMode == "Speed" then
          priorityScore = speed
        elseif AimConfig.priorityMode == "Smart" then
          priorityScore = -distance * 0.5 + speed * 0.3 - crosshairDistance * 0.2
        end
        if AimConfig.threatPriority then
          priorityScore = priorityScore * (player:GetAttribute("ThreatLevel") or 1)
        end
        if AimConfig.healthPriority then
          priorityScore = priorityScore * 1 / player.Character.Humanoid.Health
        end
        if bestScore < priorityScore and distance <= AimConfig.distance and (not AimConfig.teamCheck or AimConfig.teamCheck and not IsSameTeam(player)) and (not AimConfig.wallCheck or AimConfig.wallCheck and CheckWall(player, bodyPart)) then
          bestScore = priorityScore
          bestTarget = player
        end
      end
    end
  end
  return bestTarget
end
local function AimAI()
  
  local target = GetBestTarget(AimConfig.Position)
  if target and target.Character:FindFirstChild(AimConfig.Position) then
    local targetPart = target.Character[AimConfig.Position]
    local targetPosition = targetPart.Position
    if IsInFOV(targetPosition) then
      if AimConfig.prejudgingselfsighting then
        targetPosition = PredictPosition(target, targetPart)
      end
      if (not AimConfig.teamCheck or not IsSameTeam(target)) and (not AimConfig.wallCheck or CheckWall(target, AimConfig.Position)) then
        local smoothnessFactor = math.max(0.1, 1 / AimConfig.smoothness)
        local aimSpeedFactor = math.max(0.1, AimConfig.aimSpeed * 0.1)
        local currentCFrame = game.Workspace.CurrentCamera.CFrame
        game.Workspace.CurrentCamera.CFrame = currentCFrame:Lerp(CFrame.new(currentCFrame.Position, targetPosition), smoothnessFactor * aimSpeedFactor)
        if FOVLine1 then
          local viewportPoint = game.Workspace.CurrentCamera:WorldToViewportPoint(targetPosition)
          FOVLine1.From = Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X / 2, game.Workspace.CurrentCamera.ViewportSize.Y / 2)
          FOVLine1.To = Vector2.new(viewportPoint.X, viewportPoint.Y)
          FOVLine1.Visible = true
        end
        if AimConfig.autoFire then
          local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
          if tool and 1 / AimConfig.fireRate <= tick() - (tool:GetAttribute("LastFireTime") or 0) then
            tool:Activate()
            tool:SetAttribute("LastFireTime", tick())
          end
        end
      end
    elseif FOVLine1 then
      FOVLine1.Visible = false
    end
  elseif FOVLine1 then
    FOVLine1.Visible = false
  end
end
local function AimFunction()
  
  local target = GetBestTarget(AimConfig.Position)
  if target and target.Character:FindFirstChild(AimConfig.Position) then
    local targetPart = target.Character[AimConfig.Position]
    local targetPosition = targetPart.Position
    if IsInFOV(targetPosition) then
      local timeToTarget = ((targetPart.Position - game.Workspace.CurrentCamera.CFrame.Position)).Magnitude / 1000
      local predictedPosition = targetPosition + targetPart.AssemblyLinearVelocity * timeToTarget + 0.5 * Vector3.new(0, -workspace.Gravity, 0) * timeToTarget ^ 2
      if (not AimConfig.teamCheck or not IsSameTeam(target)) and (not AimConfig.wallCheck or CheckWall(target, AimConfig.Position)) then
        local smoothnessFactor = math.max(0.1, 1 / AimConfig.smoothness)
        local aimSpeedFactor = math.max(0.1, AimConfig.aimSpeed * 0.1)
        local currentCFrame = game.Workspace.CurrentCamera.CFrame
        game.Workspace.CurrentCamera.CFrame = currentCFrame:Lerp(CFrame.new(currentCFrame.Position, predictedPosition), smoothnessFactor * aimSpeedFactor)
        if FOVLine1 then
          local viewportPoint = game.Workspace.CurrentCamera:WorldToViewportPoint(predictedPosition)
          FOVLine1.From = Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X / 2, game.Workspace.CurrentCamera.ViewportSize.Y / 2)
          FOVLine1.To = Vector2.new(viewportPoint.X, viewportPoint.Y)
          FOVLine1.Visible = true
        end
        if AimConfig.autoFire then
          local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
          if tool and 1 / AimConfig.fireRate <= tick() - (tool:GetAttribute("LastFireTime") or 0) then
            tool:Activate()
            tool:SetAttribute("LastFireTime", tick())
          end
        end
      end
    elseif FOVLine1 then
      FOVLine1.Visible = false
    end
  elseif FOVLine1 then
    FOVLine1.Visible = false
  end
end
local function UpdateDynamicFOV()
  
  if AimConfig.dynamicFOV then
    local target = GetBestTarget(AimConfig.Position)
    if target and target.Character:FindFirstChild(AimConfig.Position) then
      AimConfig.fovsize = math.clamp(20 / ((target.Character[AimConfig.Position].Position - game.Workspace.CurrentCamera.CFrame.Position)).Magnitude / 50 * (1 + target.Character[AimConfig.Position].AssemblyLinearVelocity.Magnitude / 100), 10, 100)
      UpdateFOVSettings()
    end
  end
end
game:GetService("RunService").RenderStepped:Connect(function()
  
  if AimConfig.fovlookAt then
    if AimConfig.aimMode == "AI" then
      AimAI()
    elseif AimConfig.aimMode == "Function" then
      AimFunction()
    end
    UpdateDynamicFOV()
  end
end)
local MotionBlurEnabled = false
local BlurEffectInstance = nil
local BlurAmount = 15
local BlurAmplifier = 5
local BlurSmoothness = 0.15
local BlurThreshold = 0.05
local BlurIntensity = 1
local BlurColor = Color3.new(0, 0, 0)
local BlurDirection = Vector2.new(1, 0)
local BlurUV = {
  0,
  0,
  1,
  1
}
local PreviousLookVector = Vector3.zero
local LastUpdateTime = tick()
local BlurTypes = {
  "MotionBlur",
  "RadialBlur",
  "DirectionalBlur"
}
local CurrentBlurType = BlurTypes[1]
local BlurPresets = {
  {
    name = "默认",
    amount = 15,
    amplifier = 5,
    smoothness = 0.15,
    threshold = 0.05,
  },
  {
    name = "强烈",
    amount = 25,
    amplifier = 10,
    smoothness = 0.05,
    threshold = 0.02,
  },
  {
    name = "柔和",
    amount = 8,
    amplifier = 3,
    smoothness = 0.2,
    threshold = 0.1,
  }
}
local function CreateBlurEffect(parent)
  
  if BlurEffectInstance then
    BlurEffectInstance:Destroy()
  end
  BlurEffectInstance = Instance.new("BlurEffect", parent)
  BlurEffectInstance.Name = "EnhancedMotionBlur"
  BlurEffectInstance.Size = 0
end
local function UpdateMotionBlur(camera, humanoid)
  
  if not BlurEffectInstance or not MotionBlurEnabled then
    return 
  end
  local currentLookVector = camera.CFrame.LookVector
  local lookVectorChange = (currentLookVector - PreviousLookVector).Magnitude
  if BlurThreshold < lookVectorChange then
    BlurEffectInstance.Size = BlurEffectInstance.Size + (math.abs(lookVectorChange) * BlurAmount * BlurAmplifier - BlurEffectInstance.Size) * BlurSmoothness
  else
    BlurEffectInstance.Size = BlurEffectInstance.Size * (1 - BlurSmoothness)
  end
  PreviousLookVector = currentLookVector
end
local function SetBlurType(blurType)
  
  CurrentBlurType = blurType
  if BlurEffectInstance then
    BlurEffectInstance:Destroy()
    CreateBlurEffect(workspace.CurrentCamera)
  end
end
local function ApplyBlurPreset(preset)
  
  BlurAmount = preset.amount
  BlurAmplifier = preset.amplifier
  BlurSmoothness = preset.smoothness
  BlurThreshold = preset.threshold
end
local TeleportWalkThreads = 5
local TeleportWalkEnabled = false
local TeleportWalkRunning = false
local LocalPlayer = game:GetService("Players").LocalPlayer
local HeartbeatService = game:GetService("RunService").Heartbeat
local function TeleportWalk(character, humanoid)
  
  if TeleportWalkEnabled == true then
    TeleportWalkRunning = false
    HeartbeatService:Wait()
    task.wait(0.1)
    HeartbeatService:Wait()
    for threadIndex = 1, TeleportWalkThreads, 1 do
      spawn(function()
        
        TeleportWalkRunning = true
        while TeleportWalkRunning do
          local deltaTime = HeartbeatService:Wait()
          if deltaTime then
            if character then
              if humanoid then
                if humanoid.Parent then
                  local moveMagnitude = humanoid.MoveDirection.Magnitude
                  if moveMagnitude > 0 then
                    character:TranslateBy(humanoid.MoveDirection)
                  end
                else
                  break
                end
              else
                break
              end
            else
              break
            end
          else
            break
          end
        end
      end)
    end
  end
end
LocalPlayer.CharacterAdded:Connect(function(character)
  
  local characterInstance = LocalPlayer.Character
  if characterInstance then
    task.wait(0.7)
    characterInstance.Humanoid.PlatformStand = false
    characterInstance.Animate.Disabled = false
  end
end)
local UILibrary = loadstring(game:HttpGet([[https://raw.githubusercontent.com/whenheet/-ui2/refs/heads/main/%E5%B0%8F%E4%BA%91ui(2).lua]]))():new("大司马脚本通用")
local InfoTab = UILibrary:Tab("『信息』", "18930406865")
local PlayerInfoSection = InfoTab:section("玩家信息", true)
PlayerInfoSection:Label("您的注入器:" .. identifyexecutor())
PlayerInfoSection:Label("您的用户名:" .. game.Players.LocalPlayer.Character.Name)
PlayerInfoSection:Label("您的名称:" .. game.Players.LocalPlayer.DisplayName)
PlayerInfoSection:Label("您当前服务器的ID:" .. game.GameId)
PlayerInfoSection:Label("您的用户ID:" .. game.Players.LocalPlayer.UserId)
PlayerInfoSection:Label("您的客户端ID:" .. game:GetService("RbxAnalyticsService"):GetClientId())
PlayerInfoSection:Toggle("开/关皮脚本用户名称显示", "Toggle", false, function(enabled)
  
  if enabled then
    XM = true
    while XM do
      local screenGui = Instance.new("ScreenGui", game.CoreGui)
      local textLabel = Instance.new("TextLabel", screenGui)
      local gradient = Instance.new("UIGradient")
      screenGui.Name = "UserGui"
      screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
      screenGui.Enabled = true
      textLabel.Name = "UserLabel"
      textLabel.BackgroundColor3 = Color3.new(1, 1, 1)
      textLabel.BackgroundTransparency = 1
      textLabel.BorderColor3 = Color3.new(0, 0, 0)
      textLabel.Position = UDim2.new(0.8, 0.8, 0.0009, 0)
      textLabel.Size = UDim2.new(0, 135, 0, 50)
      textLabel.Font = Enum.Font.GothamSemibold
      textLabel.Text = "尊贵的皮脚本用户: " .. game.Players.LocalPlayer.DisplayName
      textLabel.TextColor3 = Color3.new(1, 1, 1)
      textLabel.TextScaled = true
      textLabel.TextSize = 14
      textLabel.TextWrapped = true
      textLabel.Visible = true
      gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.1, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(139, 0, 255)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.9, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0))
      })
      gradient.Rotation = 10
      gradient.Parent = textLabel
      game:GetService("TweenService"):Create(gradient, TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {
        Rotation = 360,
      }):Play()
      wait(0.1)
    end
  else
    XM = false
  end
end)
local AuthorInfoSection = InfoTab:section("作者信息", true)
AuthorInfoSection:Label("皮脚本")
AuthorInfoSection:Label("永不跑路的脚本")
AuthorInfoSection:Label("作者: 小皮")
AuthorInfoSection:Label("作者QQ: 2131869117")
AuthorInfoSection:Label("皮脚本QQ主群: 894995244")
AuthorInfoSection:Label("皮脚本QQ副群: 1002100032")
AuthorInfoSection:Label("皮脚本QQ二群: 746849372")
AuthorInfoSection:Label("皮脚本QQ三群: 571553667")
AuthorInfoSection:Label("皮脚本QQ四群: 609250910")
AuthorInfoSection:Label("解卡群: 252251548")
AuthorInfoSection:Label("解卡群二群: 954149920")
AuthorInfoSection:Label("十分感谢月星对我的支持与帮助")
AuthorInfoSection:Label("给我提供了许多的功能源码")
AuthorInfoSection:Label("谢谢您的支持与帮助^ω^")
AuthorInfoSection:Button("复制作者QQ", function()
  
  setclipboard("2131869117")
end)
AuthorInfoSection:Button("复制皮脚本QQ主群", function()
  
  setclipboard("894995244")
end)
AuthorInfoSection:Button("复制皮脚本QQ副群", function()
  
  setclipboard("1002100032")
end)
AuthorInfoSection:Button("复制皮脚本QQ二群", function()
  
  setclipboard("746849372")
end)
AuthorInfoSection:Button("复制皮脚本QQ三群", function()
  
  setclipboard("571553667")
end)
AuthorInfoSection:Button("复制皮脚本QQ四群", function()
  
  setclipboard("609250910")
end)
AuthorInfoSection:Button("复制解卡群", function()
  
  setclipboard("252251548")
end)
AuthorInfoSection:Button("复制解卡群二群", function()
  
  setclipboard("954149920")
end)
local UISettingsSection = InfoTab:section("UI设置", true)
UISettingsSection:Toggle("脚本框架变小一点", "", false, function(enabled)
  
  if enabled then
    game:GetService("CoreGui").frosty.Main.Style = "DropShadow"
  else
    game:GetService("CoreGui").frosty.Main.Style = "Custom"
  end
end)
UISettingsSection:Button("关闭脚本", function()
  
  game:GetService("CoreGui").frosty:Destroy()
end)
local AnnouncementSection = UILibrary:Tab("信息公告", "18930406865"):section("公告", true)
AnnouncementSection:Label("我们不支持当前服务器")
AnnouncementSection:Label("已启动通用脚本")
AnnouncementSection:Label("要是支持的服务器未启动请在售后群反馈")
local GeneralTab = UILibrary:Tab("『通用』", "18930406865")
local LocalPlayerSection = GeneralTab:section("本地玩家", true)
local sliderMethod = "Slider"
local sliderLabel = "设置速度"
LocalPlayerSection[sliderMethod](LocalPlayerSection, sliderLabel, "WalkSpeed", game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, 16, 400, false, function(walkSpeed)
  
  spawn(function()
    
    while task.wait() do
      local humanoid = game.Players.LocalPlayer.Character.Humanoid
      humanoid.WalkSpeed = walkSpeed
    end
  end)
end)
sliderMethod = "Slider"
sliderLabel = "设置跳跃高度"
LocalPlayerSection:Slider("设置跳跃高度", "JumpPower", game.Players.LocalPlayer.Character.Humanoid.JumpPower, 50, 400, false, function(jumpPower)
  
  spawn(function()
    
    while task.wait() do
      local humanoid = game.Players.LocalPlayer.Character.Humanoid
      humanoid.JumpPower = jumpPower
    end
  end)
end)
sliderMethod = "Slider"
sliderLabel = "设置血量"
LocalPlayerSection:Slider("设置血量", "Sliderflag", 100, 100, 10000, false, function(health)
  
  game.Players.LocalPlayer.Character.Humanoid.Health = health
end)
sliderMethod = "Slider"
sliderLabel = "设置血量上限"
LocalPlayerSection:Slider("设置血量上限", "Slider", 100, 100, 10000, false, function(maxHealth)
  
  game.Players.LocalPlayer.Character.Humanoid.MaxHealth = maxHealth
end)
sliderMethod = "Slider"
sliderLabel = "设置缩放距离"
LocalPlayerSection:Slider("设置缩放距离", "ZOOOOOM OUT!", 128, 128, 200000, false, function(zoomDistance)
  
  game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = zoomDistance
end)
sliderMethod = "Slider"
sliderLabel = "设置缩放焦距(正常70)"
LocalPlayerSection:Slider("设置缩放焦距(正常70)", "Sliderflag", 70, 0.1, 250, false, function(fieldOfView)
  
  game.Workspace.CurrentCamera.FieldOfView = fieldOfView
end)
sliderMethod = "Slider"
sliderLabel = "设置帧率FPS"
LocalPlayerSection:Slider("设置帧率FPS", "Sliderflag", 300, 300, 100000, false, function(fps)
  
  setfpscap(fps)
end)
sliderMethod = "Slider"
sliderLabel = "设置玩家头部大小"
LocalPlayerSection:Slider("设置玩家头部大小", "Head", 1, 0, 1000, false, function(headSize)
  
  local headSizeConfig = {
    Size = headSize,
  }
  -- ...existing code...
  local Players = game:GetService("Players")
  local localPlayer = Players.LocalPlayer
  function IsPlayerAlive(player)
      if not player then
          return false
      end
      local character = player.Character
      if not character then
          return false
      end
      local head = character:FindFirstChild("Head")
      local humanoid = character:FindFirstChildWhichIsA("Humanoid") or character:FindFirstChild("Humanoid")
      if head and humanoid and humanoid.Health and humanoid.Health > 0 then
          return true
      end
      return false
  end
  for _, player in pairs(Players:GetPlayers()) do
    if player ~= localPlayer and IsPlayerAlive(player) then
      player.Character.Head.Massless = true
      player.Character.Head.Size = Vector3.new(headSizeConfig.Size, headSizeConfig.Size, headSizeConfig.Size)
    end
-- ...existing code...
    player.CharacterAdded:Connect(function()
      
      while not IsPlayerAlive(player) do
        wait()
      end
      player.Character.Head.Massless = true
      player.Character.Head.Size = Vector3.new(headSizeConfig.Size, headSizeConfig.Size, headSizeConfig.Size)
    end)
    
  end
  Players.PlayerAdded:Connect(function(newPlayer)
    
    newPlayer.CharacterAdded:Wait()
    if IsPlayerAlive(newPlayer) then
      newPlayer.Character.Head.Massless = true
      newPlayer.Character.Head.Size = Vector3.new(headSizeConfig.Size, headSizeConfig.Size, headSizeConfig.Size)
    end
    newPlayer.CharacterAdded:Connect(function()
      
      while not IsPlayerAlive(newPlayer) do
        wait()
      end
      newPlayer.Character.Head.Massless = true
      newPlayer.Character.Head.Size = Vector3.new(headSizeConfig.Size, headSizeConfig.Size, headSizeConfig.Size)
    end)
  end)
end)
textboxMethod = "Textbox"
textboxLabel = "设置重力"
LocalPlayerSection:Textbox("设置重力", "Gravity", "输入", function(gravity)
  
  spawn(function()
    
    while task.wait() do
      local workspace = game.Workspace
      workspace.Gravity = gravity
    end
  end)
end)
textboxMethod = "Textbox"
textboxLabel = "设置快速跑步"
LocalPlayerSection:Textbox("设置快速跑步", "run", "输入", function(speedValue)
  
  Speed = speedValue
end)
LocalPlayerSection:Toggle("开启快速跑步(开/关)", "switch", false, function(enabled)
  
  if enabled == true then
    sudu = game:GetService("RunService").Heartbeat:Connect(function()
      
      if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid and game:GetService("Players").LocalPlayer.Character.Humanoid.Parent and 0 < game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection.Magnitude then
        game:GetService("Players").LocalPlayer.Character:TranslateBy(game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection * Speed / 0.5)
      end
    end)
  elseif not enabled and sudu then
    sudu:Disconnect()
    sudu = nil
  end
end)
local GeneralSection = GeneralTab:section("通用", true)
GeneralSection:Toggle("夜视", "Light", false, function(enabled)
  
  spawn(function()
    
    while task.wait() do
      local lighting = game.Lighting
      if enabled then
        lighting.Ambient = Color3.new(1, 1, 1)
      else
        lighting.Ambient = Color3.new(0, 0, 0)
      end
    end
  end)
end)
GeneralSection:Button("透视", function()
  
  loadstring(game:HttpGet("https://pastefy.app/LE2hzECZ/raw"))()
end)
local dropdownMethod = "Dropdown"
local dropdownLabel = "选择帧率FPS"
GeneralSection:Dropdown("选择帧率FPS", "CameraType", {
  "FPS 5",
  "FPS 15",
  "FPS 30 ",
  "FPS 45",
  "FPS 60",
  "FPS 90",
  "FPS 120",
  "FPS 240",
  "最大FPS"
}, function(selectedFPS)
  
  if selectedFPS == "FPS 5" then
    setfpscap(5)
  elseif selectedFPS == "FPS 15" then
    setfpscap(15)
  elseif selectedFPS == "FPS 30" then
    setfpscap(30)
  elseif selectedFPS == "FPS 45" then
    setfpscap(45)
  elseif selectedFPS == "FPS 60" then
    setfpscap(60)
  elseif selectedFPS == "FPS 90" then
    setfpscap(90)
  elseif selectedFPS == "FPS 120" then
    setfpscap(120)
  elseif selectedFPS == "FPS 240" then
    setfpscap(240)
  elseif selectedFPS == "最大FPS" then
    setfpscap(10000)
  end
end)
GeneralSection:Toggle("开启杀戮光环", "Toggle", false, function(enabled)
  
  local Players = nil	
  local isRunning = nil	
  if enabled then
    local existingConnections = getgenv().configs and getgenv().configs.connections
    if existingConnections then
      local disableEvent = getgenv().configs.Disable
      for _, connection in pairs(existingConnections) do
        connection:Disconnect()
      end
      disableEvent:Fire()
      disableEvent:Destroy()
      table.clear(getgenv().configs)
    end
    local disableEvent = Instance.new("BindableEvent")
    getgenv().configs = {
      connections = {},
      Disable = disableEvent,
      Size = Vector3.new(10, 10, 10),
      DeathCheck = true,
    }
    Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local localPlayer = Players.LocalPlayer
    isRunning = true
    local overlapParams = OverlapParams.new()
    overlapParams.FilterType = Enum.RaycastFilterType.Include
    local function GetCharacter(player)
      
      if not player then
        player = localPlayer
      end
      return player.Character
    end
    -- ...existing code...
    local function GetHumanoid(model)
      
      if not model then
        return nil
      end

      -- safe check for Instance-like objects
      if type(model) == "userdata" and model.IsA then
        if model:IsA("Player") then
          -- if a Player was passed, use its character
          model = GetCharacter(model)
        end

        if model and type(model) == "userdata" and model.IsA then
          if model:IsA("Model") then
            return model:FindFirstChildWhichIsA("Humanoid") or model:FindFirstChild("Humanoid")
          elseif model:IsA("Humanoid") then
            return model
          end
        end
      end

      return nil
    end
-- ...existing code...
    local function IsAlive(humanoid)
      
      return humanoid and 0 < humanoid.Health
    end
    local function HasTouchTransmitter(tool)
      
      return tool and tool:FindFirstChildWhichIsA("TouchTransmitter", true)
    end
    local function GetOtherCharacters(excludeCharacter)
      
      local characters = {}
      for _, player in pairs(Players:GetPlayers()) do
        table.insert(characters, GetCharacter(player))
      end
      for index, character in pairs(characters) do
        if character == excludeCharacter then
          table.remove(characters, index)
          break
        end
      end
      return characters
    end
    local function ActivateTool(tool, part, targetPart)
      
      if tool:IsDescendantOf(workspace) then
        tool:Activate()
        firetouchinterest(part, targetPart, 1)
        firetouchinterest(part, targetPart, 0)
      end
    end
    table.insert(getgenv().configs.connections, disableEvent.Event:Connect(function()
      
      isRunning = false
    end))
    while isRunning do
      local localCharacter = GetCharacter()
      if IsAlive(GetHumanoid(localCharacter)) then
        local tool = localCharacter and localCharacter:FindFirstChildWhichIsA("Tool")
        local touchTransmitter = tool and HasTouchTransmitter(tool)
        if touchTransmitter then
          local toolPart = touchTransmitter.Parent
          local otherCharacters = GetOtherCharacters(localCharacter)
          overlapParams.FilterDescendantsInstances = otherCharacters
          for _, part in pairs(workspace:GetPartBoundsInBox(toolPart.CFrame, toolPart.Size + getgenv().configs.Size, overlapParams)) do
            local characterModel = part:FindFirstAncestorWhichIsA("Model")
            if table.find(otherCharacters, characterModel) then
              if getgenv().configs.DeathCheck and IsAlive(GetHumanoid(characterModel)) then
                ActivateTool(tool, toolPart, part)
              elseif not getgenv().configs.DeathCheck then
                ActivateTool(tool, toolPart, part)
              end
            end
          end
        end
      end
      RunService.Heartbeat:Wait()
    end
    
  else
    local disableEvent = getgenv().configs.Disable
    if disableEvent then
      disableEvent:Fire()
      disableEvent:Destroy()
    end
    local configs = getgenv().configs
    local connections = configs.connections
    for _, connection in pairs(connections) do
      connection:Disconnect()
    end
    table.clear(connections)
    Run = false
  end
end)
GeneralSection:Button("隐身道具", function()
  
  loadstring(game:HttpGet([[https://gist.githubusercontent.com/skid123skidlol/cd0d2dce51b3f20ad1aac941da06a1a1/raw/f58b98cce7d51e53ade94e7bb460e4f24fb7e0ff/%257BFE%257D%2520Invisible%2520Tool%2520(can%2520hold%2520tools)]], true))()
end)
-- ...existing code...
GeneralSection:Toggle("循环恢复血量", "HF", false, function(enabled)
  if enabled then
    getgenv().HFLoop = true
    task.spawn(function()
      while getgenv().HFLoop do
        local lp = game.Players.LocalPlayer
        local hum = lp and lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid")
        if hum and hum.Parent then
          hum.Health = 9000000000
        end
        task.wait(0.5)
      end
    end)
  else
    getgenv().HFLoop = false
  end
end)
-- ...existing code...
GeneralSection:Button("锁定视野", function()
  
  loadstring(game:HttpGet("https://pastefy.app/nekmtvpA/raw"))()
end)
GeneralSection:Toggle("解锁最大视野", "Cam", false, function(enabled)
  
  Cam1 = enabled
  if Cam1 then
    Cam2()
  end
end)
function Cam2()
  
  while Cam1 do
    wait(0.1)
    local localPlayer = game:GetService("Players").LocalPlayer
    localPlayer.CameraMaxZoomDistance = 9000000000
  end
  while not Cam1 do
    wait(0.1)
    local localPlayer = game:GetService("Players").LocalPlayer
    localPlayer.CameraMaxZoomDistance = 32
  end
end
GeneralSection:Toggle("子弹追踪", "silent", false, function(enabled)
  
  local camera = nil	
  local Players = nil	
  local localPlayer = nil	
  local originalNamecall = nil	
  local originalIndex = nil	
  if enabled then
    camera = workspace.CurrentCamera
    Players = game.Players
    localPlayer = Players.LocalPlayer
    local mouse = localPlayer:GetMouse()
    function ClosestPlayer()
      
      local closestDistance = math.huge
      local closestPlayer = nil
      for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Team ~= localPlayer.Team and player.Character then
          local head = player.Character:FindFirstChild("Head")
          if head then
            local screenPoint, isVisible = camera:WorldToScreenPoint(head.Position)
            if isVisible then
              local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)).Magnitude
              if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
              end
            end
          end
        end
      end
      return closestPlayer
    end
    local metatable = getrawmetatable(game)
    originalNamecall = metatable.__namecall
    originalIndex = metatable.__index
    setreadonly(metatable, false)
    metatable.__namecall = newcclosure(function(self, ...)
      
      local args = {
        ...
      }
      if getnamecallmethod() == "FindPartOnRayWithIgnoreList" and not checkcaller() then
        local targetPlayer = ClosestPlayer()
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
          args[1] = Ray.new(camera.CFrame.Position, ((targetPlayer.Character.Head.Position - camera.CFrame.Position)).Unit * 1000)
          return originalNamecall(self, unpack(args))
        end
      end
      return originalNamecall(self, ...)
    end)
    metatable.__index = newcclosure(function(self, key)
      
      if key == "Clips" then
        return workspace.Map
      end
      return originalIndex(self, key)
    end)
    setreadonly(metatable, true)
    
  else
    camera = workspace.CurrentCamera
    Players = game.Players
    localPlayer = Players.LocalPlayer
    local mouse = localPlayer:GetMouse()
    function ClosestPlayer()
      
      local closestDistance = math.huge
      local closestPlayer = nil
      for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Team ~= localPlayer.Team and player.Character then
          local head = player.Character:FindFirstChild("Head")
          if head then
            local screenPoint, isVisible = camera:WorldToScreenPoint(head.Position)
            if isVisible then
              local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)).Magnitude
              if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
              end
            end
          end
        end
      end
      return closestPlayer
    end
    local gameInstance = game
    local metatable = getrawmetatable(gameInstance)
    originalNamecall = metatable.__namecall
    originalIndex = metatable.__index
    setreadonly(metatable, false)
    metatable.__namecall = newcclosure(function(self, ...)
      
      local args = {
        ...
      }
      if getnamecallmethod() == "FindPartOnRayWithIgnoreList" and not checkcaller() then
        local targetPlayer = ClosestPlayer()
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
          args[1] = Ray.new(camera.CFrame.Position, ((targetPlayer.Character.Head.Position - camera.CFrame.Position)).Unit * 1000)
          return originalNamecall(self, unpack(args))
        end
      end
      return originalNamecall(self, ...)
    end)
    metatable.__index = newcclosure(function(self, key)
      
      if key == "Clips" then
        return workspace.Map
      end
      return originalIndex(self, key)
    end)
    setreadonly(metatable, true)
    
  end
end)
GeneralSection:Button("查看游戏中的所有玩家（包括血量条）", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/G2zb992X", true))()
end)
GeneralSection:Button("工具包", function()
  
  loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()
end)
GeneralSection:Button("老外传送至玩家身边", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Infinity2346/Tect-Menu/main/Teleport%20Gui.lua"))()
end)
GeneralSection:Button("点击传送道具", function()
  
  loadstring(game:HttpGet("https://pastefy.app/Jf2QXOwa/raw"))()
end)
GeneralSection:Button("Dex", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/renlua/Script-Tutorial/refs/heads/main/dex.lua"))()
end)
GeneralSection:Toggle("穿墙", "NoClip", false, function(enabled)
  
  local workspace = game:GetService("Workspace")
  local Players = game:GetService("Players")
  if enabled then
    Clipon = true
  else
    Clipon = false
  end
  Stepped = game:GetService("RunService").Stepped:Connect(function()
    
    if Clipon then
      for _, child in pairs(workspace:GetChildren()) do
        if child.Name == Players.LocalPlayer.Name then
          for _, part in pairs(workspace[Players.LocalPlayer.Name]:GetChildren()) do
            if part:IsA("BasePart") then
              part.CanCollide = false
            end
          end
        end
      end
    else
      Stepped:Disconnect()
    end
  end)
end)
GeneralSection:Button("皮飞行", function()
  
  loadstring(game:HttpGet([[https://pastefy.app/J9x7RnEZ/raw]]))()
end)
GeneralSection:Button("飞车", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/vb/main/%E9%A3%9E%E8%BD%A6.lua"))()
end)
GeneralSection:Button("自瞄", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/dingding123hhh/sgbs/main/%E4%B8%81%E4%B8%81%20%E6%B1%89%E5%8C%96%E8%87%AA%E7%9E%84.txt]]))()
end)
GeneralSection:Button("皮甩飞", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/%E7%9A%AE%E7%94%A9%E9%A3%9E.lua]]))()
end)
GeneralSection:Button("甩飞所有人", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
end)
GeneralSection:Button("死亡笔记", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/1_1.txt_2024-08-08_153358.OTed.lua]]))()
end)
GeneralSection:Button("铁拳", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt]]))()
end)
GeneralSection:Button("电脑键盘", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt]], true))()
end)
GeneralSection:Toggle("无法移动", "Fake flag", false, function(enabled)
  
  local localPlayer = game.Players.LocalPlayer
  local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  if enabled then
    for _, child in pairs(character:GetChildren()) do
      if child:IsA("BasePart") then
        child.Anchored = true
      end
    end
  else
    for _, child in pairs(character:GetChildren()) do
      if child:IsA("BasePart") then
        child.Anchored = false
      end
    end
  end
end)
GeneralSection:Button("自杀", function()
  
  game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)
GeneralSection:Button("踏空行走", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float"))()
end)
GeneralSection:Button("通用ESP", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP"))()
end)
GeneralSection:Button("踢人脚本(仅娱乐)", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/c8320f69b6aa4f5d.txt_2024-08-08_214628.OTed.lua]]))()
end)
GeneralSection:Button("动画中心", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui]], true))()
end)
GeneralSection:Button("爬墙", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)
GeneralSection:Button("替身", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/SkrillexMe/SkrillexLoader/main/SkrillexLoadMain]]))()
end)
GeneralSection:Button("操人脚本", function()
  
  loadstring(game:HttpGet("https://pastefy.app/BkeffrT5/raw"))()
end)
GeneralSection:Button("圈圈自瞄(可调)", function()
  
  loadstring(game:HttpGet("https://pastefy.app/YnfF3sje/raw"))()
end)
GeneralSection:Button("iw指令", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", true))()
end)
GeneralSection:Toggle("人物不可见状态(隐身)", "Invisible Character", false, function(enabled)
  
  local localPlayer = game.Players.LocalPlayer
  for _, child in pairs((localPlayer.Character or localPlayer.CharacterAdded:Wait()):GetChildren()) do
    local isBasePart = child:IsA("BasePart")
    if isBasePart then
      if enabled then
        isBasePart = 1
      else
        isBasePart = 0
      end
      child.Transparency = isBasePart
      child.CanCollide = not enabled
    elseif child:IsA("Accessory") then
      local handle = child.Handle
      local transparency = nil	
      if enabled then
        transparency = 1
      else
        transparency = 0
      end
      handle.Transparency = transparency
    end
  end
end)
GeneralSection:Toggle("获取所有玩家背包", "GetBackPack", false, function(enabled)
  
  if enabled then
    while enabled do
      for _, player in pairs(game.Players:GetChildren()) do
        wait()
        for _, tool in pairs(player.Backpack:GetChildren()) do
          tool.Parent = game.Players.LocalPlayer.Backpack
          wait()
        end
      end
    end
  end
end)
GeneralSection:Button("获取当前道具", function()
  
  loadstring(game:HttpGet("https://pastefy.app/3FU05Dyt/raw"))()
end)
GeneralSection:Button("装备全部道具", function()
  
  loadstring(game:HttpGet("https://pastefy.app/uBqVR9JC/raw"))()
end)
GeneralSection:Button("删除道具", function()
  
  loadstring(game:HttpGet("https://pastefy.app/r4LHK4p0/raw"))()
end)
GeneralSection:Button("删除所有道具", function()
  
  loadstring(game:HttpGet("https://pastefy.app/8HB71Lbj/raw"))()
end)
GeneralSection:Toggle("自动互动", "AutoInteract", false, function(enabled)
  
  if enabled then
    autoInteract = true
    while autoInteract do
      for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then
          fireproximityprompt(descendant)
        end
      end
      task.wait(0.25)
    end
  else
    autoInteract = false
  end
end)
GeneralSection:Button("快速互动", function()
  
  game.ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
    
    prompt.HoldDuration = 0
  end)
end)
GeneralSection:Toggle("圆圈高亮透视", "ESP", false, function(enabled)
  
  for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
      if enabled then
        local highlight = Instance.new("Highlight")
        highlight.Parent = player.Character
        highlight.Adornee = player.Character
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Parent = player.Character
        billboardGui.Adornee = player.Character
        billboardGui.Size = UDim2.new(0, 100, 0, 100)
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)
        billboardGui.AlwaysOnTop = true
        local textLabel = Instance.new("TextLabel")
        textLabel.Parent = billboardGui
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = player.Name
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.TextStrokeTransparency = 0.5
        textLabel.TextScaled = true
        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Parent = billboardGui
        imageLabel.Size = UDim2.new(0, 50, 0, 50)
        imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
        imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        imageLabel.BackgroundTransparency = 1
        imageLabel.Image = "rbxassetid://2200552246"
      else
        if player.Character:FindFirstChildOfClass("Highlight") then
          player.Character:FindFirstChildOfClass("Highlight"):Destroy()
        end
        if player.Character:FindFirstChildOfClass("BillboardGui") then
          player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
        end
      end
    end
  end
end)
GeneralSection:Toggle("无限跳", "IJ", false, function(enabled)
  
  getgenv().InfJ = enabled
  game:GetService("UserInputService").JumpRequest:connect(function()
    
    if InfJ == true then
      game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
  end)
end)
GeneralSection:Toggle("无敌", "LSTM", false, function(enabled)
  if enabled then
    local camera = workspace.CurrentCamera
    local cameraCFrame = camera.CFrame
    local character = LocalPlayer and LocalPlayer.Character
    local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
      local clonedHumanoid = humanoid:Clone()
      clonedHumanoid.Parent = character
      clonedHumanoid:SetStateEnabled(Enum.HumanoidStateType.Health, false)
      clonedHumanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
      clonedHumanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
      clonedHumanoid.BreakJointsOnDeath = true
      humanoid:Destroy()
      LocalPlayer.Character = nil
      LocalPlayer.Character = character
      camera.CameraSubject = clonedHumanoid

      task.wait() -- 稍作等待以确保对象稳定
      local targetCFrame = cameraCFrame or camera.CFrame
      camera.CFrame = targetCFrame

      clonedHumanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
      local animate = character:FindFirstChild("Animate")
      if animate then
        animate.Disabled = true
        task.wait()
        animate.Disabled = false
      end
      clonedHumanoid.Health = clonedHumanoid.MaxHealth
    end
  else
    local lpChar = game.Players.LocalPlayer and game.Players.LocalPlayer.Character
    local lpHum = lpChar and lpChar:FindFirstChildWhichIsA("Humanoid")
    if lpHum then
      lpHum.Health = 100
    end
  end
end)
GeneralSection:Toggle("上帝模式", "No Description", false, function(enabled)
  local Players = game:GetService("Players")
  local localPlayer = Players and Players.LocalPlayer
  if not localPlayer then
    return
  end

  local function getCharacter()
    return localPlayer.Character or localPlayer.CharacterAdded:Wait()
  end

  local character = localPlayer.Character
  if not character then
    character = getCharacter()
  end

  if enabled then
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if hrp and not character:FindFirstChild("GodModeHRPClone") then
      local clone = hrp:Clone()
      clone.Name = "GodModeHRPClone"
      clone.Parent = character
    end
  else
    if character then
      local clone = character:FindFirstChild("GodModeHRPClone")
      if clone then
        clone:Destroy()
      end
    end
  end
end)
GeneralSection:Toggle("靠近自动攻击(需要拿起武器)", "Toggle", false, function(enabled)
  
  local Players = nil	
  local isRunning = nil	
  if enabled then
    local r1_585 = getgenv().configs and getgenv().configs.connections
    if r1_585 then
      local r2_585 = getgenv().configs.Disable
      r3_585 = pairs
      for r6_585, r7_585 in r3_585(r1_585) do
        r7_585:Disconnect()
      end
      r2_585:Fire()
      r2_585:Destroy()
      table.clear(getgenv().configs)
    end
    local r2_585 = Instance.new("BindableEvent")
    r3_585 = getgenv()
    r3_585.configs = {
      connections = {},
      Disable = r2_585,
      Size = Vector3.new(10, 10, 10),
      DeathCheck = true,
    }
    r3_585 = game:GetService("Players")
    local r4_585 = game:GetService("RunService")
    local r5_585 = r3_585.LocalPlayer
    r6_585 = true
    local r7_585 = OverlapParams.new()
    r7_585.FilterType = Enum.RaycastFilterType.Include
    local function r8_585(r0_591)
      
      if not r0_591 then
        r0_591 = r5_585
      end
      return r0_591.Character
    end
-- ...existing code...
    local function r9_585(r0_590)
      -- 安全版：接受 Player / Model / Humanoid，并返回 Humanoid 或 nil
      if not r0_590 then
        return nil
      end

      -- 如果传入的是 Player，则获取其角色（使用文件中已有的 r8_585）
      local candidate = r0_590
      if type(candidate) == "userdata" and candidate.IsA then
        if candidate:IsA("Player") then
          candidate = r8_585(candidate)
        end

        if candidate and type(candidate) == "userdata" and candidate.IsA then
          if candidate:IsA("Model") then
            return candidate:FindFirstChildWhichIsA("Humanoid") or candidate:FindFirstChild("Humanoid")
          elseif candidate:IsA("Humanoid") then
            return candidate
          end
        end
      end

      return nil
    end
-- ...existing code...
    local function r10_585(r0_587)
      
      return r0_587 and 0 < r0_587.Health
    end
    local function r11_585(r0_588)
      
      return r0_588 and r0_588:FindFirstChildWhichIsA("TouchTransmitter", true)
    end
    local function r12_585(r0_589)
      
      local r1_589 = {}
      for r5_589, r6_589 in pairs(r3_585:GetPlayers()) do
        table.insert(r1_589, r8_585(r6_589))
      end
      for r5_589, r6_589 in pairs(r1_589) do
        if r6_589 == r0_589 then
          table.remove(r1_589, r5_589)
          break
        end
      end
      return r1_589
    end
    local function r13_585(r0_592, r1_592, r2_592)
      
      if r0_592:IsDescendantOf(workspace) then
        r0_592:Activate()
        firetouchinterest(r1_592, r2_592, 1)
        firetouchinterest(r1_592, r2_592, 0)
      end
    end
    table.insert(getgenv().configs.connections, r2_585.Event:Connect(function()
      
      r6_585 = false
    end))
    while r6_585 do
      local r14_585 = r8_585()
      if r10_585(r9_585(r14_585)) then
        local r15_585 = r14_585 and r14_585:FindFirstChildWhichIsA("Tool")
        local r16_585 = r15_585 and r11_585(r15_585)
        if r16_585 then
          local r17_585 = r16_585.Parent
          local r18_585 = r12_585(r14_585)
          r7_585.FilterDescendantsInstances = r18_585
          for r23_585, r24_585 in pairs(workspace:GetPartBoundsInBox(r17_585.CFrame, r17_585.Size + getgenv().configs.Size, r7_585)) do
            local r25_585 = r24_585:FindFirstAncestorWhichIsA("Model")
            if table.find(r18_585, r25_585) then
              if getgenv().configs.DeathCheck and r10_585(r9_585(r25_585)) then
                r13_585(r15_585, r17_585, r24_585)
              elseif not getgenv().configs.DeathCheck then
                r13_585(r15_585, r17_585, r24_585)
              end
            end
          end
        end
      end
      r4_585.Heartbeat:Wait()
    end
    
  else
    local r1_585 = getgenv().configs.Disable
    if r1_585 then
      r1_585:Fire()
      r1_585:Destroy()
    end
    r3_585 = getgenv
    r3_585 = r3_585()
    r3_585 = r3_585.configs
    r3_585 = r3_585.connections
    for r5_585, r6_585 in pairs(r3_585) do
      r6_585:Disconnect()
    end
    r3_585 = getgenv
    r3_585 = r3_585()
    r3_585 = r3_585.configs
    r3_585 = r3_585.connections
    table.clear(r3_585)
    Run = false
  end
end)
GeneralSection:Button("坐下", function()
  
  game.Players.LocalPlayer.Character.Humanoid.Sit = true
end)
GeneralSection:Toggle("声音折磨", "Sound", false, function(enabled)
  
  getgenv().spamSoond = enabled
  if enabled then
    spamSound()
  end
end)
function spamSound()
  
  while getgenv().spamSoond == true do
    local soundInstance = Instance.new("Sound")
    local descendants = game:GetDescendants()
    for _, descendant in next, descendants do
      if descendant:IsA("Sound") then
        descendant:Play()
      end
    end
    soundInstance:Remove()
    task.wait()
  end
end
GeneralSection:Toggle("七彩建筑", "BasePart", false, function(enabled)
  
  local baseParts = nil	
  if enabled then
    Break = false
    r1_665 = {}
    local r2_665 = Enum.Material:GetEnumItems()
    for r6_665, r7_665 in pairs(game.Workspace:GetDescendants()) do
      if r7_665:IsA("BasePart") then
        table.insert(r1_665, r7_665)
      end
    end
    game.Workspace.DescendantAdded:Connect(function(r0_666)
      
      if r0_666:IsA("BasePart") then
        table.insert(r1_665, r0_666)
      end
    end)
    while task.wait(0.025) do
      local r3_665 = pairs
      local r4_665 = r1_665
      for r6_665, r7_665 in r3_665(r4_665) do
        r7_665.Material = r2_665[math.random(1, #r2_665)]
        r7_665.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
        if Break then
        end
      end
    end
    
  else
    r1_665 = true
    Break = r1_665
  end
end)
GeneralSection:Button("吸人(无法关闭)", function()
  
  loadstring(game:HttpGet("https://pastefy.app/fF3DMBNF/raw"))()
end)
GeneralSection:Button("人物螺旋上天", function()
  
  loadstring(game:HttpGet("https://pastefy.app/xV1T3PAi/raw"))()
end)
GeneralSection:Button("无限R币", function()
  
  loadstring(game:HttpGet("https://pastefy.app/SxhPVOyM/raw"))()
end)
GeneralSection:Button("聊天气泡美化", function()
  
  loadstring(game:HttpGet("https://pastefy.app/lCEPuiQO/raw"))()
end)
GeneralSection:Button("人物绘制", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/pmgp7mdm"))()
end)
GeneralSection:Toggle("人物显示", "RWXS", false, function(enabled)
  
  getgenv().enabled = enabled
  getgenv().filluseteamcolor = true
  getgenv().outlineuseteamcolor = true
  getgenv().fillcolor = Color3.new(1, 0, 0)
  getgenv().outlinecolor = Color3.new(1, 1, 1)
  getgenv().filltrans = 0.5
  getgenv().outlinetrans = 0.5
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/Highlight-ESP.lua"))()
end)
GeneralSection:Button("无后坐快速射击", function()
  
  loadstring(game:HttpGet("https://pastefy.app/Vbnh3Ycg/raw"))()
end)
GeneralSection:Button("无限子弹", function()
  
  loadstring(game:HttpGet("https://pastefy.app/bYg3smqm/raw"))()
end)
GeneralSection:Button("弹人(实体)", function()
  
  loadstring(game:HttpGet("https://pastefy.app/4r9e4F3p/raw"))()
end)
GeneralSection:Button("弹人(半实体)", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/UTWcDtzj"))()
end)
GeneralSection:Button("获得管理员权限", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/sZpgTVas"))()
end)
GeneralSection:Button("重新加入游戏", function()
  
  loadstring(game:HttpGet("https://pastefy.app/XXabqNiv/raw"))()
end)
GeneralSection:Button("显示FPS", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/g54KFcUU"))()
end)
GeneralSection:Button("显示时间", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/RycMWV3a"))()
end)
GeneralSection:Button("F3X", function()
  
  loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
end)
GeneralSection:Button("保存游戏", function()
  
  saveinstance()
end)
GeneralSection:Button("离开游戏", function()
  
  game:Shutdown()
end)
GeneralSection:Button("玩家加入与退出提示", function()
  
  loadstring(game:HttpGet("https://pastefy.app/KexNS25n/raw"))()
end)
GeneralSection:Label("修改时间")
GeneralSection:Button("凌晨12点", function()
  
  loadstring(game:HttpGet("https://pastefy.app/xFX51PIw/raw"))()
end)
GeneralSection:Button("下午4点", function()
  
  loadstring(game:HttpGet("https://pastefy.app/sIrAGJxJ/raw"))()
end)
GeneralSection:Button("中午11点", function()
  
  loadstring(game:HttpGet("https://pastefy.app/rccCMBch/raw"))()
end)
GeneralSection:Button("早上6点", function()
  
  loadstring(game:HttpGet("https://pastefy.app/h9VLRgYR/raw"))()
end)
GeneralSection:Label("轰炸Webhook")
textboxMethod = "Textbox"
textboxLabel = "Webhook链接"
GeneralSection:Textbox("Webhook链接", "text", "输入", function(webhookUrl)
  
  local webhook = ""
  webhook = webhookUrl
end)
GeneralSection:Button("复制轰炸", function()
  
  setclipboard("", 9999)
end)
GeneralSection:Label("设置相机")
dropdownMethod = "Dropdown"
dropdownLabel = "选择相机方式"
GeneralSection:Dropdown("选择相机方式", "CameraType", {
  "自定义 ",
  "附加 ",
  "固定",
  "跟随",
  "动态观察",
  "可脚本化",
  "跟踪",
  "观看"
}, function(cameraType)
  
  if cameraType == "自定义" then
    game.Workspace.CurrentCamera.CameraType = "Custom"
  elseif cameraType == "附加" then
    game.Workspace.CurrentCamera.CameraType = "Attach"
  elseif cameraType == "固定" then
    game.Workspace.CurrentCamera.CameraType = "Fixed"
  elseif cameraType == "跟随" then
    game.Workspace.CurrentCamera.CameraType = "Follow"
  elseif cameraType == "动态观察" then
    game.Workspace.CurrentCamera.CameraType = "Orbital"
  elseif cameraType == "可脚本化" then
    game.Workspace.CurrentCamera.CameraType = "Scriptable"
  elseif cameraType == "跟踪" then
    game.Workspace.CurrentCamera.CameraType = "Track"
  elseif cameraType == "观看" then
    game.Workspace.CurrentCamera.CameraType = "Watch"
  end
end)
GeneralSection:Toggle("切板摄像机的遮挡模式", "DevCameraOcclusionMode", false, function(r0_607)
  
  if state then
    game:GetService("Players").LocalPlayer.DevCameraOcclusionMode = "Invisicam"
  else
    game:GetService("Players").LocalPlayer.DevCameraOcclusionMode = "Zoom"
  end
end)
dropdownMethod = "Dropdown"
dropdownLabel = "相机"
GeneralSection:Dropdown("相机", "Camera", {
  "经典",
  "第一人称"
}, function(cameraMode)
  
  if cameraMode == "经典" then
    game:GetService("Players").LocalPlayer.CameraMode = "Classic"
  elseif cameraMode == "第一人称" then
    game:GetService("Players").LocalPlayer.CameraMode = "LockFirstPerson"
  end
end)
local SpinRangeTab = UILibrary:Tab("『旋转与范围』", "18930406865")
local SpinRangeSection = SpinRangeTab:section("旋转与范围", true)
SpinRangeSection:Label("旋转")
textboxMethod = "Textbox"
textboxLabel = "设置旋转速度"
SpinRangeSection:Textbox("设置旋转速度", "TextBoxFlag", "输入", function(speed)
  
  bin.speed = tonumber(speed) or 100
end)
SpinRangeSection:Toggle("开启/关闭旋转", "Spinbot", false, function(enabled)
  
  local localPlayer = game:GetService("Players").LocalPlayer
  repeat
    task.wait()
  until localPlayer.Character
  local humanoidRootPart = localPlayer.Character:WaitForChild("HumanoidRootPart")
  localPlayer.Character:WaitForChild("Humanoid").AutoRotate = false
  if enabled then
    local angularVelocity = Instance.new("AngularVelocity")
    angularVelocity.Attachment0 = humanoidRootPart:WaitForChild("RootAttachment")
    angularVelocity.MaxTorque = math.huge
    angularVelocity.AngularVelocity = Vector3.new(0, bin.speed, 0)
    angularVelocity.Parent = humanoidRootPart
    angularVelocity.Name = "Spinbot"
  else
    local spinbot = humanoidRootPart:FindFirstChild("Spinbot")
    if spinbot then
      spinbot:Destroy()
    end
  end
end)
SpinRangeSection:Label("范围")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
getgenv().HitboxSize = 15
getgenv().HitboxTransparency = 0.9
getgenv().HitboxStatus = false
getgenv().TeamCheck = false
SpinRangeSection:Toggle("开启/关闭范围", "HitboxStatus", false, function(enabled)
  
  getgenv().HitboxStatus = enabled
  game:GetService("RunService").RenderStepped:connect(function()
    
    if HitboxStatus == true and TeamCheck == false then
      for _, player in next, game:GetService("Players"):GetPlayers() do
        if player.Name ~= game:GetService("Players").LocalPlayer.Name then
          pcall(function()
            
            player.Character.HumanoidRootPart.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
            player.Character.HumanoidRootPart.Transparency = HitboxTransparency
            player.Character.HumanoidRootPart.BrickColor = BrickColor.new(MovementConfig.HitboxBrickColor)
            player.Character.HumanoidRootPart.Material = "Neon"
            player.Character.HumanoidRootPart.CanCollide = false
          end)
        end
        
      end
    elseif HitboxStatus == true and TeamCheck == true then
      for _, player in next, game:GetService("Players"):GetPlayers() do
        if game:GetService("Players").LocalPlayer.Team ~= player.Team then
          pcall(function()
            
            player.Character.HumanoidRootPart.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
            player.Character.HumanoidRootPart.Transparency = HitboxTransparency
            player.Character.HumanoidRootPart.BrickColor = BrickColor.new(MovementConfig.HitboxBrickColor)
            player.Character.HumanoidRootPart.Material = "Neon"
            player.Character.HumanoidRootPart.CanCollide = false
          end)
        end
        
      end
    else
      for _, player in next, game:GetService("Players"):GetPlayers() do
        if player.Name ~= game:GetService("Players").LocalPlayer.Name then
          pcall(function()
            
            player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
            player.Character.HumanoidRootPart.Transparency = 1
            player.Character.HumanoidRootPart.BrickColor = BrickColor.new(MovementConfig.HitboxBrickColor)
            player.Character.HumanoidRootPart.Material = "Plastic"
            player.Character.HumanoidRootPart.CanCollide = false
          end)
        end
        
      end
    end
  end)
end)
textboxMethod = "Textbox"
textboxLabel = "范围大小设置"
SpinRangeSection:Textbox("范围大小设置", "HitboxSize", "输入", function(size)
  
  getgenv().HitboxSize = size
end)
SpinRangeSection:Toggle("队伍检测", "TeamCheck", false, function(enabled)
  
  getgenv().TeamCheck = enabled
  ESP_SETTINGS.Teamcheck = true
end)
textboxMethod = "Textbox"
textboxLabel = "范围透明度设置（调0更好区分队伍)"
SpinRangeSection:Textbox("范围透明度设置（调0更好区分队伍)", "HitboxTransparency", "输入", function(transparency)
  
  getgenv().HitboxTransparency = transparency
end)
dropdownMethod = "Dropdown"
dropdownLabel = "选择范围颜色"
SpinRangeSection:Dropdown("选择范围颜色", "Hitbox", {
  "Really blue",
  "Really black",
  "Really red",
  "Really pink",
  "Really brown",
  "Really yellow",
  "Really green",
  "Really orange",
  "Really purple",
  "Really light gray"
}, function(color)
  
  MovementConfig.HitboxBrickColor = color
end)
local QuickSettingsSection = SpinRangeTab:section("快捷设置范围与旋转", true)
QuickSettingsSection:Label("范围")
QuickSettingsSection:Button("范围清空", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/RqrTrPF5"))()
end)
QuickSettingsSection:Button("范围10", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/DT94B37a"))()
end)
QuickSettingsSection:Button("范围20", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/Kyyt1e4g"))()
end)
QuickSettingsSection:Button("范围50", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/pMtKEgWd"))()
end)
QuickSettingsSection:Button("范围100", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/aLBSXPYE"))()
end)
QuickSettingsSection:Button("范围150", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/RWxsQuU9"))()
end)
QuickSettingsSection:Button("范围200", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/hbp3RV2p"))()
end)
QuickSettingsSection:Button("范围300", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/x8cZhegq"))()
end)
QuickSettingsSection:Button("范围400", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/LixK0gG3"))()
end)
QuickSettingsSection:Button("范围500", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/yXWMGLYJ"))()
end)
QuickSettingsSection:Label("旋转")
QuickSettingsSection:Button("旋转清零", function()
  
  loadstring(game:HttpGet("https://pastefy.app/UOWFy58g/raw"))()
end)
QuickSettingsSection:Button("旋转10", function()
  
  loadstring(game:HttpGet("https://pastefy.app/pX8CKeHn/raw"))()
end)
QuickSettingsSection:Button("旋转30", function()
  
  loadstring(game:HttpGet("https://pastefy.app/1Ob0oE2h/raw"))()
end)
QuickSettingsSection:Button("旋转50", function()
  
  loadstring(game:HttpGet("https://pastefy.app/4UL7XrJU/raw"))()
end)
QuickSettingsSection:Button("旋转100", function()
  
  loadstring(game:HttpGet("https://pastefy.app/6agZDErY/raw"))()
end)
QuickSettingsSection:Button("旋转150", function()
  
  loadstring(game:HttpGet("https://pastefy.app/MqAalYjs/raw"))()
end)
QuickSettingsSection:Button("旋转200", function()
  
  loadstring(game:HttpGet("https://pastefy.app/00mtNBML/raw"))()
end)
QuickSettingsSection:Button("旋转250", function()
  
  loadstring(game:HttpGet("https://pastefy.app/CR2woYXY/raw"))()
end)
QuickSettingsSection:Button("旋转300", function()
  
  loadstring(game:HttpGet("https://pastefy.app/5SbEaumY/raw"))()
end)
QuickSettingsSection:Button("旋转400", function()
  
  loadstring(game:HttpGet("https://pastefy.app/pjkZd07i/raw"))()
end)
QuickSettingsSection:Button("旋转500", function()
  
  loadstring(game:HttpGet("https://pastefy.app/9emFsJ7N/raw"))()
end)
local HubScriptsSection = UILibrary:Tab("『HUB脚本』", "18930406865"):section("HUB脚本", true)
HubScriptsSection:Button("EZ-HUB", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/debug42O/Ez-Industries-Launcher-Data/master/Launcher.lua]], true))()
end)
HubScriptsSection:Button("reen script", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/xDepressionx/Free-Script/main/KingLegacy.lua"))()
end)
HubScriptsSection:Button("Maru_Hub", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/raw-scriptpastebin/raw/main/B_Genesis"))()
end)
HubScriptsSection:Button("Xenon_Hub", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/1f0yt/community/master/legacy"))()
end)
HubScriptsSection:Button("ipper_hub", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/hajibeza/RIPPER-HUB/main/King%20Leagacy"))()
end)
HubScriptsSection:Button("trike_hub", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Strikehubv2z/StormSKz/main/All_in_one"))()
end)
HubScriptsSection:Button("unfair hub", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/rblxscriptsnet/unfair/main/rblxhub.lua", true))()
end)
HubScriptsSection:Button(" Shadow Hub V2", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Alexcirer/Alexcirer/main/V%20d"))()
end)
HubScriptsSection:Button("Zen_Hub", function()
  
  loadstring(game:HttpGet("https://shz.al/~aboutnnn/Zen_Hub.lua"))()
end)
HubScriptsSection:Button("PlaybackX Hub", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/NeaPchX2/Playback-X-HUB/main/Protected.lua.txt"))()
end)
HubScriptsSection:Button("Tianhe\'s script hub", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/xdQVhQdm"))()
end)
HubScriptsSection:Button("Mango hub", function()
  
  loadstring(game:HttpGet("https://gitlab.com/L1ZOT/mango-hub/-/raw/main/Mango-Bloxf-Fruits-Beta"))()
end)
HubScriptsSection:Button("VG hub", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G-Hub/main/V.Ghub"))()
end)
HubScriptsSection:Button("Owl-Hub", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))()
end)
HubScriptsSection:Button("HOHO_hub", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
end)
local TeleportSection = UILibrary:Tab("『传送与甩飞』", "18930406865"):section("传送与甩飞玩家", true)
dropdownMethod = "Dropdown"
dropdownLabel = "选择玩家名称"
local playerDropdown = TeleportSection:Dropdown("选择玩家名称", "Dropdown", PlayerConfig.dropdown, function(selectedPlayer)
  
  PlayerConfig.playernamedied = selectedPlayer
end)
TeleportSection:Button("刷新玩家名称", function()
  
  shuaxinlb(true)
  playerDropdown:SetOptions(PlayerConfig.dropdown)
end)
TeleportSection:Button("传送到玩家旁边", function()
  
  local localRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
  local targetPlayer = game.Players:FindFirstChild(PlayerConfig.playernamedied)
  if targetPlayer and targetPlayer.Character and targetPlayer.Character.HumanoidRootPart then
    localRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
    Notify("大司马脚本", "已经传送到玩家身边", "rbxassetid://18941716391", 5)
  else
    Notify("大司马脚本", "无法传送 原因: 玩家已消失", "rbxassetid://18941716391", 5)
  end
end)
TeleportSection:Toggle("循环锁定传送", "Loop", false, function(enabled)
  
  if enabled then
    PlayerConfig.LoopTeleport = true
    Notify("大司马脚本", "已开启循环传送", "rbxassetid://18941716391", 5)
    while PlayerConfig.LoopTeleport do
      local localRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
      local targetPlayer = game.Players:FindFirstChild(PlayerConfig.playernamedied)
      if targetPlayer and targetPlayer.Character and targetPlayer.Character.HumanoidRootPart then
        localRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
      end
      wait()
    end
  else
    PlayerConfig.LoopTeleport = false
    Notify("大司马脚本", "已关闭循环传送", "rbxassetid://18941716391", 5)
  end
end)
TeleportSection:Button("把玩家传送过来", function()
  
  local localRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
  local targetPlayer = game.Players:FindFirstChild(PlayerConfig.playernamedied)
  if targetPlayer and targetPlayer.Character and targetPlayer.Character.HumanoidRootPart then
    targetPlayer.Character.HumanoidRootPart.CFrame = localRootPart.CFrame + Vector3.new(0, 3, 0)
    Notify("大司马脚本", "已将玩家传送过来", "rbxassetid://18941716391", 5)
  else
    Notify("大司马脚本", "无法传送 原因: 玩家已消失", "rbxassetid://18941716391", 5)
  end
end)
TeleportSection:Toggle("循环传送玩家过来", "Loop", false, function(enabled)
  
  if enabled then
    PlayerConfig.LoopTeleport = true
    Notify("大司马脚本", "已开启循环传送玩家过来", "rbxassetid://", 5)
    while PlayerConfig.LoopTeleport do
      local localRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
      local targetPlayer = game.Players:FindFirstChild(PlayerConfig.playernamedied)
      if targetPlayer and targetPlayer.Character and targetPlayer.Character.HumanoidRootPart then
        targetPlayer.Character.HumanoidRootPart.CFrame = localRootPart.CFrame + Vector3.new(0, 3, 0)
      end
      wait()
    end
  else
    PlayerConfig.LoopTeleport = false
    Notify("大司马脚本", "已关闭循环传送玩家过来", "rbxassetid://18941716391", 5)
  end
end)
TeleportSection:Toggle("吸全部玩家", "Get All", false, function(enabled)
  
  if enabled then
    while enabled do
      for _, player in next, game:GetService("Players"):GetPlayers() do
        if player.Name ~= game:GetService("Players").LocalPlayer.Name then
          local localPosition = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
          local lookVector = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector
          player.Character.HumanoidRootPart.CFrame = CFrame.new(localPosition + lookVector * 3, localPosition + lookVector * 4)
          wait()
        end
      end
    end
  end
end)
TeleportSection:Toggle("查看玩家", "look player", false, function(enabled)
  
  if enabled then
    game:GetService("Workspace").CurrentCamera.CameraSubject = game:GetService("Players"):FindFirstChild(PlayerConfig.playernamedied).Character.Humanoid
    Notify("大司马脚本", "已开启查看玩家", "rbxassetid://18941716391", 5)
  else
    game:GetService("Workspace").CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
    Notify("大司马脚本", "已关闭查看玩家", "rbxassetid://18941716391", 5)
  end
end)
TeleportSection:Button("甩飞一次", function()
  
  if PlayerConfig.playernamedied ~= nil and PlayerConfig.playernamedied ~= nil then
    local targetNames = {
      PlayerConfig.playernamedied
    }
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local isAllOrOthers = false
    local function FindPlayerByName(name)
      
      name = name:lower()
      if name == "all" or name == "others" then
        isAllOrOthers = true
        return 
      end
      if name == "random" then
        local allPlayers = Players:GetPlayers()
        if table.find(allPlayers, localPlayer) then
          table.remove(allPlayers, table.find(allPlayers, localPlayer))
        end
        return allPlayers[math.random(#allPlayers)]
      end
      if name ~= "random" and name ~= "all" and name ~= "others" then
        for _, player in next, Players:GetPlayers() do
          if player ~= localPlayer then
            if player.Name:lower():match("^" .. name) then
              return player
            end
            if player.DisplayName:lower():match("^" .. name) then
              return player
            end
          end
        end
      else
        return 
      end
    end
    local function SendNotification(title, text, duration)
      
      game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration,
      })
    end
    local function ThrowPlayer(targetPlayer)
      
      local localCharacter = localPlayer.Character
      local localHumanoid = localCharacter and localCharacter:FindFirstChildOfClass("Humanoid")
      local localRootPart = localHumanoid and localHumanoid.RootPart
      local targetCharacter = targetPlayer.Character
      local targetHumanoid = nil
      local targetRootPart = nil
      local targetHead = nil
      local targetAccessory = nil
      local accessoryHandle = nil
      if targetCharacter:FindFirstChildOfClass("Humanoid") then
        targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
      end
      if targetHumanoid and targetHumanoid.RootPart then
        targetRootPart = targetHumanoid.RootPart
      end
      if targetCharacter:FindFirstChild("Head") then
        targetHead = targetCharacter.Head
      end
      if targetCharacter:FindFirstChildOfClass("Accessory") then
        targetAccessory = targetCharacter:FindFirstChildOfClass("Accessory")
      end
      if Accessoy and targetAccessory:FindFirstChild("Handle") then
        accessoryHandle = targetAccessory.Handle
      end
      if localCharacter and localHumanoid and localRootPart then
        if localRootPart.Velocity.Magnitude < 50 then
          getgenv().OldPos = localRootPart.CFrame
        end
        if targetHumanoid and targetHumanoid.Sit and not isAllOrOthers then
          return SendNotification("玩家消失", "已停止", 5)
        end
        if targetHead then
          workspace.CurrentCamera.CameraSubject = targetHead
        elseif not targetHead and accessoryHandle then
          workspace.CurrentCamera.CameraSubject = accessoryHandle
        elseif targetHumanoid and targetRootPart then
          workspace.CurrentCamera.CameraSubject = targetHumanoid
        end
        if not targetCharacter:FindFirstChildWhichIsA("BasePart") then
          return 
        end
        local function ApplyThrowForce(part, offset, rotation)
          
          localRootPart.CFrame = CFrame.new(part.Position) * offset * rotation
          localCharacter:SetPrimaryPartCFrame(CFrame.new(part.Position) * offset * rotation)
          localRootPart.Velocity = Vector3.new(90000000, 900000000, 90000000)
          localRootPart.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
        end
        local function PerformThrowAnimation(part)
          
          local timeoutDuration = 2
          local startTime = tick()
          local rotationAngle = 0
          while localRootPart do
            local velocityMagnitude = part.Velocity.Magnitude
            if velocityMagnitude < 50 then
              rotationAngle = rotationAngle + 100
              ApplyThrowForce(part, CFrame.new(0, 1.5, 0) + targetHumanoid.MoveDirection * part.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(rotationAngle), 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(0, -1.5, 0) + targetHumanoid.MoveDirection * part.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(rotationAngle), 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(2.25, 1.5, -2.25) + targetHumanoid.MoveDirection * part.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(rotationAngle), 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(-2.25, -1.5, 2.25) + targetHumanoid.MoveDirection * part.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(rotationAngle), 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(0, 1.5, 0) + targetHumanoid.MoveDirection, CFrame.Angles(math.rad(rotationAngle), 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(0, -1.5, 0) + targetHumanoid.MoveDirection, CFrame.Angles(math.rad(rotationAngle), 0, 0))
                task.wait()
              else
              ApplyThrowForce(part, CFrame.new(0, 1.5, targetHumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(0, -1.5, -targetHumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(0, 1.5, targetHumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(0, 1.5, targetRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(0, -1.5, -targetRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(0, 1.5, targetRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                task.wait()
              ApplyThrowForce(part, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                task.wait()
              end
            velocityMagnitude = part.Velocity.Magnitude
            if velocityMagnitude <= 500 then
              local partParent = part.Parent
              if partParent == targetPlayer.Character then
                partParent = targetPlayer.Parent
                if partParent == Players then
                  local hasCharacter = not targetPlayer.Character
                  if hasCharacter ~= targetCharacter then
                    local isSitting = targetHumanoid.Sit
                    if not isSitting then
                      local health = localHumanoid.Health
                      if health > 0 then
                        local currentTime = tick()
                        if startTime + timeoutDuration < currentTime then
                          break
                        end
                      else
                        break
                      end
                    else
                      break
                    end
                  else
                    break
                  end
                else
                  break
                end
              else
                break
              end
            else
              break
            end
          end
        end
        workspace.FallenPartsDestroyHeight = 0 / 0
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "EpixVel"
        bodyVelocity.Parent = localRootPart
        bodyVelocity.Velocity = Vector3.new(900000000, 900000000, 900000000)
        bodyVelocity.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)
        localHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        if targetRootPart and targetHead then
          if (targetRootPart.CFrame.p - targetHead.CFrame.p).Magnitude > 5 then
            PerformThrowAnimation(targetHead)
          else
            PerformThrowAnimation(targetRootPart)
          end
        elseif targetRootPart and not targetHead then
          PerformThrowAnimation(targetRootPart)
        elseif not targetRootPart and targetHead then
          PerformThrowAnimation(targetHead)
        elseif not targetRootPart and not targetHead and targetAccessory and accessoryHandle then
          PerformThrowAnimation(accessoryHandle)
        else
          return SendNotification("大司马脚本", "已开/关", 5)
        end
        bodyVelocity:Destroy()
        localHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = localHumanoid
        repeat
          localRootPart.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
          localCharacter:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
          localHumanoid:ChangeState("GettingUp")
          table.foreach(localCharacter:GetChildren(), function(_, child)
            
            if child:IsA("BasePart") then
              local zeroVector = Vector3.new()
              child.RotVelocity = Vector3.new()
              child.Velocity = zeroVector
            end
          end)
          task.wait()
        until (localRootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
        
      else
        SendNotification("玩家消失", "已停止", 5)
      end
    end
    if targetNames[1] then
      for _, name in next, targetNames, nil do
        local foundPlayer = FindPlayerByName(name)
        if foundPlayer then
          ThrowPlayer(foundPlayer)
        end
      end
    else
      return 
    end
    if isAllOrOthers then
      for _, player in next, Players:GetPlayers() do
        if player ~= localPlayer then
          ThrowPlayer(player)
        end
      end
    end
    for _, name in next, targetNames, nil do
      local foundPlayer = FindPlayerByName(name)
      if foundPlayer and foundPlayer ~= localPlayer then
        if foundPlayer.UserId ~= 1414978355 then
          ThrowPlayer(foundPlayer)
        else
          SendNotification("检测到玩家消失", "己停止", 5)
        end
      elseif not FindPlayerByName(name) and not isAllOrOthers then
        SendNotification("未获取到玩家或工具", "已停止", 5)
      end
    end
    
  end
end)
TeleportSection:Toggle("循环甩飞", "AutoFling", false, function(r0_53)
  
  if PlayerConfig.playernamedied ~= nil and PlayerConfig.playernamedied ~= nil then
    getgenv().autofling = r0_53
    spawn(function()
      
      while autofling do
        wait()
        pcall(function()
          
          local r0_55 = {
            PlayerConfig.playernamedied
          }
          local r1_55 = game:GetService("Players")
          local r2_55 = r1_55.LocalPlayer
          local r3_55 = false
          local function r4_55(r0_61)
            
            r0_61 = r0_61:lower()
            if r0_61 == "all" or r0_61 == "others" then
              r3_55 = true
              return 
            end
            if r0_61 == "random" then
              local r1_61 = r1_55:GetPlayers()
              if table.find(r1_61, r2_55) then
                table.remove(r1_61, table.find(r1_61, r2_55))
              end
              return r1_61[math.random(#r1_61)]
            end
            if r0_61 ~= "random" and r0_61 ~= "all" and r0_61 ~= "others" then
              local r1_61 = next
              local r2_61, r3_61 = r1_55:GetPlayers()
              for r4_61, r5_61 in r1_61, r2_61, r3_61 do
                if r5_61 ~= r2_55 then
                  if r5_61.Name:lower():match("^" .. r0_61) then
                    return r5_61
                  end
                  if r5_61.DisplayName:lower():match("^" .. r0_61) then
                    return r5_61
                  end
                end
              end
            else
              return 
            end
          end
          local function r5_55(r0_60, r1_60, r2_60)
            
            game:GetService("StarterGui"):SetCore("SendNotification", {
              Title = r0_60,
              Text = r1_60,
              Duration = r2_60,
            })
          end
          local function r6_55(r0_56)
            
            local r1_56 = r2_55.Character
            local r2_56 = r1_56 and r1_56:FindFirstChildOfClass("Humanoid")
            local r3_56 = r2_56 and r2_56.RootPart
            local r4_56 = r0_56.Character
            local r5_56 = nil
            local r6_56 = nil
            local r7_56 = nil
            local r8_56 = nil
            local r9_56 = nil
            if r4_56:FindFirstChildOfClass("Humanoid") then
              r5_56 = r4_56:FindFirstChildOfClass("Humanoid")
            end
            if r5_56 and r5_56.RootPart then
              r6_56 = r5_56.RootPart
            end
            if r4_56:FindFirstChild("Head") then
              r7_56 = r4_56.Head
            end
            if r4_56:FindFirstChildOfClass("Accessory") then
              r8_56 = r4_56:FindFirstChildOfClass("Accessory")
            end
            if Accessoy and r8_56:FindFirstChild("Handle") then
              r9_56 = r8_56.Handle
            end
            if r1_56 and r2_56 and r3_56 then
              if r3_56.Velocity.Magnitude < 50 then
                getgenv().OldPos = r3_56.CFrame
              end
              if r5_56 and r5_56.Sit and not r3_55 then
                return r5_55("大司马脚本", "错误❌", 5)
              end
              if r7_56 then
                workspace.CurrentCamera.CameraSubject = r7_56
              elseif not r7_56 and r9_56 then
                workspace.CurrentCamera.CameraSubject = r9_56
              elseif r5_56 and r6_56 then
                workspace.CurrentCamera.CameraSubject = r5_56
              end
              if not r4_56:FindFirstChildWhichIsA("BasePart") then
                return 
              end
              local function r10_56(r0_58, r1_58, r2_58)
                
                r3_56.CFrame = CFrame.new(r0_58.Position) * r1_58 * r2_58
                r1_56:SetPrimaryPartCFrame(CFrame.new(r0_58.Position) * r1_58 * r2_58)
                r3_56.Velocity = Vector3.new(90000000, 900000000, 90000000)
                r3_56.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
              end
              local function r11_56(r0_57)
                
                local r1_57 = 2
                local r2_57 = tick()
                local r3_57 = 0
                while r3_56 do
                  local r4_57 = r5_56
                  if r4_57 then
                    r4_57 = r0_57.Velocity.Magnitude
                    if r4_57 < 50 then
                      r3_57 = r3_57 + 100
                      r10_56(r0_57, CFrame.new(0, 1.5, 0) + r5_56.MoveDirection * r0_57.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(r3_57), 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(0, -1.5, 0) + r5_56.MoveDirection * r0_57.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(r3_57), 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(2.25, 1.5, -2.25) + r5_56.MoveDirection * r0_57.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(r3_57), 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(-2.25, -1.5, 2.25) + r5_56.MoveDirection * r0_57.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(r3_57), 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(0, 1.5, 0) + r5_56.MoveDirection, CFrame.Angles(math.rad(r3_57), 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(0, -1.5, 0) + r5_56.MoveDirection, CFrame.Angles(math.rad(r3_57), 0, 0))
                      task.wait()
                    else
                      r10_56(r0_57, CFrame.new(0, 1.5, r5_56.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(0, -1.5, -r5_56.WalkSpeed), CFrame.Angles(0, 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(0, 1.5, r5_56.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(0, 1.5, r6_56.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(0, -1.5, -r6_56.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(0, 1.5, r6_56.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                      task.wait()
                      r10_56(r0_57, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                      task.wait()
                    end
                    r4_57 = r0_57.Velocity.Magnitude
                    if r4_57 <= 500 then
                      r4_57 = r0_57.Parent
                      if r4_57 == r0_56.Character then
                        r4_57 = r0_56.Parent
                        if r4_57 == r1_55 then
                          r4_57 = not r0_56.Character
                          if r4_57 ~= r4_56 then
                            r4_57 = r5_56.Sit
                            if not r4_57 then
                              r4_57 = r2_56.Health
                              if r4_57 > 0 then
                                r4_57 = tick()
                                if r2_57 + r1_57 < r4_57 then
                                  break
                                end
                              else
                                break
                              end
                            else
                              break
                            end
                          else
                            break
                          end
                        else
                          break
                        end
                      else
                        break
                      end
                    else
                      break
                    end
                  else
                    break
                  end
                end
              end
              workspace.FallenPartsDestroyHeight = 0 / 0
              local r12_56 = Instance.new("BodyVelocity")
              r12_56.Name = "EpixVel"
              r12_56.Parent = r3_56
              r12_56.Velocity = Vector3.new(900000000, 900000000, 900000000)
              r12_56.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)
              r2_56:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
              if r6_56 and r7_56 then
                if (r6_56.CFrame.p - r7_56.CFrame.p).Magnitude > 5 then
                  r11_56(r7_56)
                else
                  r11_56(r6_56)
                end
              elseif r6_56 and not r7_56 then
                r11_56(r6_56)
              elseif not r6_56 and r7_56 then
                r11_56(r7_56)
              elseif not r6_56 and not r7_56 and r8_56 and r9_56 then
                r11_56(r9_56)
              else
                return r5_55("大司马脚本", "已开/关", 5)
              end
              r12_56:Destroy()
              r2_56:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
              workspace.CurrentCamera.CameraSubject = r2_56
              repeat
                r3_56.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
                r1_56:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
                r2_56:ChangeState("GettingUp")
                table.foreach(r1_56:GetChildren(), function(r0_59, r1_59)
                  
                  if r1_59:IsA("BasePart") then
                    local r2_59 = Vector3.new()
                    r1_59.RotVelocity = Vector3.new()
                    r1_59.Velocity = r2_59
                  end
                end)
                task.wait()
              until (r3_56.Position - getgenv().OldPos.p).Magnitude < 25
              workspace.FallenPartsDestroyHeight = getgenv().FPDH
              
            else
-- ...existing code...
              local r10_56 = r5_55
              local r11_56 = "玩家消失"
              local r12_56 = "已停止"
              local r13_56 = 5
              r10_56(r11_56, r12_56, r13_56)
-- ...existing code...
            end
          end
          if r0_55[1] then
            for r10_55, r11_55 in next, r0_55, nil do
              r4_55(r11_55)
            end
          else
            return 
          end
          if r3_55 then
            local r7_55 = next
            local r8_55, r9_55 = r1_55:GetPlayers()
            for r10_55, r11_55 in r7_55, r8_55, r9_55 do
              r6_55(r11_55)
            end
          end
          for r10_55, r11_55 in next, r0_55, nil do
            if r4_55(r11_55) and r4_55(r11_55) ~= r2_55 then
              if r4_55(r11_55).UserId ~= 1414978355 then
                local r12_55 = r4_55(r11_55)
                if r12_55 then
                  r6_55(r12_55)
                end
              else
                r5_55("检测到玩家消失", "已停止", 5)
              end
            elseif not r4_55(r11_55) and not r3_55 then
              r5_55("未获取到玩家或工具", "已停止", 5)
            end
          end
        end)
      end
    end)
  end
end)
TeleportSection:Toggle("开启指定自瞄目标", "Aimbot", false, function(r0_462)
  
  if r0_462 then
    while r0_462 do
      local r1_462 = workspace.CurrentCamera
      local r2_462 = game.Players:FindFirstChild(PlayerConfig.playernamedied)
      local r3_462 = r2_462 and r2_462.Character and r2_462.Character.HumanoidRootPart
      if r3_462 and r1_462 then
        r1_462.CFrame = CFrame.new(r1_462.CFrame.Position, r1_462.CFrame.Position + (r3_462.Position - r1_462.CFrame.Position).unit)
        wait()
      else
        break
      end
    end
  end
end)

r50_0 = UILibrary

r71_0 = r50_0:Tab("『自动说话』", "18930406865"):section("自动说话", true)
local r74_0 = "Textbox"
r74_0 = "你要说的话"
r71_0:Textbox("你要说的话", "TextBoxFlag", "填写你想要说的话", function(r0_664)
  
  bin.message = r0_664
end)
r74_0 = "Textbox"
r74_0 = "说话次数"
r71_0:Textbox("说话次数", "TextBoxFlag", "输入说话次数", function(r0_683)
  
  bin.sayCount = tonumber(r0_683) or 1
end)
r71_0:Button("说话", function()
  
  bin.sayFast = true
  for r3_481 = 1, bin.sayCount, 1 do
    if bin.sayFast then
      game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(bin.message, "All")
      wait(0.1)
    end
  end
  bin.sayFast = false
end)
r71_0:Button("停止说话", function()
  
  bin.sayFast = false
end)
r71_0:Toggle("全自动说话", "ToggleFlag", false, function(r0_443)
  
  bin.autoSay = r0_443
  if r0_443 then
    while bin.autoSay do
      game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(bin.message, "All")
      wait(0.1)
    end
  else
    bin.autoSay = false
  end
end)
r71_0:Label("骂人区")
r71_0:Label("Roblox发言有限制 连续7条后要冷却10秒")
_G.szj = true
function szj()
  
  while _G.szj == true do
    wait(1)
    local r0_300 = {
      [1] = "是不是",
      [2] = "All",
    }
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(r0_300))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "沙不沙",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "乐不乐",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "糙溺麻",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "词穷仔",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "逗不逗",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "喔楠菲",
      [2] = "All",
    }))
  end
end
r71_0:Toggle("三字经", "MR", false, function(r0_120)
  
  _G.szj = r0_120
  szj()
end)
_G.sz = true
function sz()
  
  while _G.sz == true do
    wait()
    wait(1)
    local r0_242 = {
      [1] = "狗仗人势",
      [2] = "All",
    }
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(r0_242))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "猪狗不如",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "狼心狗肺",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "厚颜无耻",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "恬不知耻",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "司跌司麻",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "阳奉阴违",
      [2] = "All",
    }))
  end
end
r71_0:Toggle("四字成语", "MR", false, function(r0_397)
  
  _G.sz = r0_397
  sz()
end)
_G.sb = true
function sb()
  
  while _G.sb == true do
    wait()
    wait(1)
    local r0_377 = {
      [1] = "损人不利己",
      [2] = "All",
    }
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(r0_377))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "害人又害己",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "活着浪费空气，司了浪费土地",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "给你爱因斯坦的脑子都没有用",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "整天不干正事",
      [2] = "All",
    }))
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
      [1] = "没用的东西",
      [2] = "All",
    }))
  end
end
r71_0:Toggle("骂人语录(我老师爱用×＿×)", "MR", false, function(r0_189)
  
  _G.sb = r0_189
  sb()
end)
local r73_0 = r50_0:Tab("『时间』", "18930406865"):section("时间", true)
r74_0 = r73_0:Label("1")
local r75_0 = r73_0:Label("2")
local r76_0 = r73_0:Label("3")
local r77_0 = r73_0:Label("4")
local r78_0 = r73_0:Label("5")

  
  task.spawn(function()
    
    
    while true do
      r74_0.Text = "当前时间: " .. os.date("%Y-%m-%d %H:%M:%S")
      local r3_442 = os.time({
        year = 2025,
        month = 1,
        day = 29,
        hour = 0,
        min = 0,
        sec = 0,
      }) - os.time()
      if r3_442 > 0 then
        r75_0.Text = string.format("春节倒计时: %d天%d小时%d分钟%d秒", math.floor(r3_442 / 86400), math.floor(r3_442 % 86400 / 3600), math.floor(r3_442 % 3600 / 60), r3_442 % 60)
      else
        r75_0.Text = "过年啦！！！"
      end
      wait(1)
    end
  end)


  
  task.spawn(function()
    
    
    while true do
      local r2_634 = os.time({
        year = 2026,
        month = 1,
        day = 1,
        hour = 0,
        min = 0,
        sec = 0,
      }) - os.time()
      if r2_634 > 0 then
        r76_0.Text = string.format("跨年倒计时: %d天%d小时%d分钟%d秒", math.floor(r2_634 / 86400), math.floor(r2_634 % 86400 / 3600), math.floor(r2_634 % 3600 / 60), r2_634 % 60)
      else
        r76_0.Text = "跨年啦！！！"
      end
      wait(1)
    end
  end)


  
  task.spawn(function()
    
    
    while true do
      local r2_78 = os.time({
        year = 2025,
        month = 1,
        day = 28,
        hour = 0,
        min = 0,
        sec = 0,
      }) - os.time()
      if r2_78 > 0 then
        r77_0.Text = string.format("除夕倒计时: %d天%d小时%d分钟%d秒", math.floor(r2_78 / 86400), math.floor(r2_78 % 86400 / 3600), math.floor(r2_78 % 3600 / 60), r2_78 % 60)
      else
        r77_0.Text = "除夕啦！！！"
      end
      wait(1)
    end
  end)


  
  task.spawn(function()
    
    
    while true do
      local r2_671 = os.time({
        year = 2025,
        month = 2,
        day = 12,
        hour = 0,
        min = 0,
        sec = 0,
      }) - os.time()
      if r2_671 > 0 then
        r78_0.Text = string.format("元宵节倒计时: %d天%d小时%d分钟%d秒", math.floor(r2_671 / 86400), math.floor(r2_671 % 86400 / 3600), math.floor(r2_671 % 3600 / 60), r2_671 % 60)
      else
        r78_0.Text = "元宵节啦！！！"
      end
      wait(1)
    end
  end)

local r84_0 = r50_0:Tab("『透视ESP』", "18930406865"):section("透视ESP", true)
r84_0:Label("①透视ESP")
r84_0:Label("每个服务器都可以用 『推荐开启』")
local r85_0 = game:GetService("RunService")
local r86_0 = game:GetService("Players")
local r87_0 = r86_0.LocalPlayer
local r88_0 = false
local r89_0 = false
local r90_0 = false
local r91_0 = false
local r92_0 = false
local function r93_0(r0_451)
  
  local r1_451 = Instance.new("BillboardGui")
  local r2_451 = Instance.new("TextLabel")
  r1_451.Name = "NameESP"
  r1_451.Adornee = r0_451.Character:WaitForChild("Head")
  r1_451.Size = UDim2.new(0, 100, 0, 50)
  r1_451.StudsOffset = Vector3.new(0, 3, 0)
  r1_451.AlwaysOnTop = true
  r2_451.Parent = r1_451
  r2_451.BackgroundTransparency = 1
  r2_451.Text = r0_451.Name
  r2_451.Size = UDim2.new(1, 0, 1, 0)
  r2_451.TextColor3 = Color3.new(1, 1, 1)
  r2_451.TextScaled = true
  local r3_451 = Instance.new("TextLabel")
  r3_451.Parent = r1_451
  r3_451.BackgroundTransparency = 1
  r3_451.Position = UDim2.new(0, 0, 0, 30)
  r3_451.Size = UDim2.new(1, 0, 0.5, 0)
  r3_451.TextColor3 = Color3.new(1, 1, 1)
  r3_451.TextScaled = true
  local function r4_451()
    
    if r1_451.Parent then
      r3_451.Text = string.format("距离%.2f米", (r87_0.Character.HumanoidRootPart.Position - r0_451.Character.HumanoidRootPart.Position).Magnitude)
    end
  end
  spawn(function()
    
    while r1_451.Parent do
      r4_451()
      wait(0.1)
    end
  end)
  r1_451.Parent = r0_451.Character:WaitForChild("Head")
end
local function r94_0(r0_282)
  
  if r0_282.Character and r0_282.Character:FindFirstChild("Head") and r0_282.Character.Head:FindFirstChild("NameESP") then
    r0_282.Character.Head.NameESP:Destroy()
  end
end
local function r95_0(r0_86)
  
  local r1_86 = Instance.new("Highlight")
  r1_86.Name = "HighlightESP"
  r1_86.Adornee = r0_86.Character
  r1_86.FillTransparency = 0.5
  r1_86.OutlineColor = Color3.new(1, 1, 1)
  r1_86.OutlineTransparency = 0
  r1_86.Parent = r0_86.Character
  local function r2_86()
    
    if r0_86.Team and r0_86.Team.TeamColor then
      r1_86.FillColor = r0_86.Team.TeamColor.Color
    else
      r1_86.FillColor = Color3.new(1, 1, 1)
    end
  end
  r2_86()
  r0_86:GetPropertyChangedSignal("Team"):Connect(r2_86)
end
local function r96_0(r0_413)
  
  if r0_413.Character and r0_413.Character:FindFirstChild("Head") and r0_413.Character:FindFirstChild("HighlightESP") then
    r0_413.Character.HighlightESP:Destroy()
  end
end
local function r97_0(r0_646)
  
  local r1_646 = Drawing.new("Line")
  r1_646.Visible = false
  r1_646.Color = Color3.new(1, 1, 1)
  r1_646.Thickness = 1
  r1_646.Transparency = 1
  r85_0.RenderStepped:Connect(function()
    
    if r90_0 and r0_646.Character and r0_646.Character:FindFirstChild("HumanoidRootPart") and r87_0.Character and r87_0.Character:FindFirstChild("HumanoidRootPart") then
      r1_646.Visible = true
      local r1_647, r2_647 = workspace.CurrentCamera:WorldToViewportPoint(r0_646.Character.HumanoidRootPart.Position)
      if r2_647 then
        r1_646.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
        r1_646.To = Vector2.new(r1_647.X, r1_647.Y)
      else
        r1_646.Visible = false
      end
    else
      r1_646.Visible = false
    end
  end)
  r0_646.CharacterRemoving:Connect(function()
    
    r1_646:Remove()
  end)
end
local function r98_0(r0_37)
  
  if r0_37:FindFirstChild("TracerESP") then
    r0_37.TracerESP:Destroy()
  end
end
local function r99_0(r0_252)
  
  local r1_252 = Instance.new("BoxHandleAdornment")
  r1_252.Name = "BoxESP"
  r1_252.Size = r0_252.Character:GetExtentsSize() * 1.1
  r1_252.Adornee = r0_252.Character
  r1_252.AlwaysOnTop = true
  r1_252.ZIndex = 5
  r1_252.Transparency = 0.5
  r1_252.Color3 = Color3.new(1, 0, 0)
  r1_252.Parent = r0_252.Character
end
local function r100_0(r0_295)
  
  if r0_295.Character:FindFirstChild("BoxESP") then
    r0_295.Character.BoxESP:Destroy()
  end
end
local function r101_0(r0_611)
  
  local r1_611 = Drawing.new("Square")
  r1_611.Visible = false
  r1_611.Transparency = 0.5
  r1_611.Color = Color3.new(1, 0, 0)
  r1_611.Thickness = 2
  r85_0.RenderStepped:Connect(function()
    
    if r92_0 and r0_611.Character and r0_611.Character:FindFirstChild("HumanoidRootPart") and r87_0.Character and r87_0.Character:FindFirstChild("HumanoidRootPart") then
      r1_611.Visible = true
      local r0_612 = r0_611.Character.HumanoidRootPart
      local r1_612, r2_612 = workspace.CurrentCamera:WorldToViewportPoint(r0_612.Position)
      if r2_612 then
        local r3_612 = r0_611.Character:GetExtentsSize()
        local r4_612 = workspace.CurrentCamera:WorldToViewportPoint((r0_612.CFrame * CFrame.new(r3_612.X / -2, r3_612.Y / 2, 0)).p)
        local r5_612 = workspace.CurrentCamera:WorldToViewportPoint((r0_612.CFrame * CFrame.new(r3_612.X / 2, -r3_612.Y / 2, 0)).p)
        r1_611.Size = Vector2.new(r5_612.X - r4_612.X, r5_612.Y - r4_612.Y)
        r1_611.Position = Vector2.new(r4_612.X, r4_612.Y)
      else
        r1_611.Visible = false
      end
    else
      r1_611.Visible = false
    end
  end)
  r0_611.CharacterRemoving:Connect(function()
    
    r1_611:Remove()
  end)
end
local function r102_0(r0_446)
  
end
local function r103_0(r0_392)
  
  r0_392.CharacterAdded:Connect(function(r0_393)
    
    wait(1)
    if r88_0 then
      r93_0(r0_392)
    end
    if r89_0 then
      r95_0(r0_392)
    end
    if r90_0 then
      r97_0(r0_392)
    end
    if r91_0 then
      r99_0(r0_392)
    end
    if r92_0 then
      r101_0(r0_392)
    end
  end)
end
local function r104_0(r0_49)
  
  r94_0(r0_49)
  r96_0(r0_49)
  r98_0(r0_49)
  r100_0(r0_49)
end
local function r105_0(r0_3)
  
  r88_0 = r0_3
  for r4_3, r5_3 in pairs(r86_0:GetPlayers()) do
    if r5_3 ~= r87_0 then
      r94_0(r5_3)
    end
  end
  
  
  
  
end
local function r106_0(r0_251)
  
  r89_0 = r0_251
  for r4_251, r5_251 in pairs(r86_0:GetChildren()) do
    if r5_251 ~= r87_0 then
      r96_0(r5_251)
    end
  end
  
  
  
  
end
local function r107_0(r0_553)
  
  r90_0 = r0_553
  for r4_553, r5_553 in pairs(r86_0:GetPlayers()) do
    if r5_553 ~= r87_0 then
      if r90_0 then
        r97_0(r5_553)
      else
        r98_0(r5_553)
      end
    end
  end
end
local function r108_0(r0_376)
  
  r91_0 = r0_376
  for r4_376, r5_376 in pairs(r86_0:GetPlayers()) do
    if r5_376 ~= r87_0 then
      if r91_0 then
        r99_0(r5_376)
      else
        r100_0(r5_376)
      end
    end
  end
end
local function r109_0(r0_318)
  
  r92_0 = r0_318
  for r4_318, r5_318 in pairs(r86_0:GetPlayers()) do
    if r5_318 ~= r87_0 then
      if r92_0 then
        r101_0(r5_318)
      else
        r102_0(r5_318)
      end
    end
  end
end
for r113_0, r114_0 in pairs(r86_0:GetPlayers()) do
  if r114_0 ~= r87_0 then
    r103_0(r114_0)
  end
end
r86_0.PlayerAdded:Connect(function(r0_593)
  
  if r0_593 ~= r87_0 then
    r103_0(r0_593)
  end
end)
r86_0.PlayerRemoving:Connect(r104_0)
r84_0:Toggle("透视位置", "ESP", false, function(r0_228)
  
  local function r1_228(r0_231)
    
    if r0_231.Character and r0_231.Character:FindFirstChildOfClass("Humanoid") then
      r0_231.Character.Humanoid.NameDisplayDistance = 9000000000
      r0_231.Character.Humanoid.NameOcclusion = "NoOcclusion"
      r0_231.Character.Humanoid.HealthDisplayDistance = 9000000000
      r0_231.Character.Humanoid.HealthDisplayType = "AlwaysOn"
      r0_231.Character.Humanoid.Health = r0_231.Character.Humanoid.Health
    end
  end
  for r5_228, r6_228 in pairs(game.Players:GetPlayers()) do
    r1_228(r6_228)
    r6_228.CharacterAdded:Connect(function()
      
      task.wait(0.33)
      r1_228(r6_228)
    end)
    
  end
  game.Players.PlayerAdded:Connect(function(r0_229)
    
    r1_228(r0_229)
    r0_229.CharacterAdded:Connect(function()
      
      task.wait(0.33)
      r1_228(r0_229)
    end)
  end)
end)
r84_0:Toggle("透视名字", "ESP", false, function(r0_64)
  
  r105_0(r0_64)
end)
r84_0:Toggle("开启内透", "ESP", false, function(r0_570)
  
  r106_0(r0_570)
end)
r84_0:Toggle("透视射线", "ESP", false, function(r0_535)
  
  r107_0(r0_535)
end)
r84_0:Toggle("透视3D框", "ESP", false, function(r0_342)
  
  r108_0(r0_342)
end)
r84_0:Toggle("透视2D框", "ESP", false, function(r0_475)
  
  r109_0(r0_475)
end)
r84_0:Label("②透视ESP")
local r110_0 = loadstring(game:HttpGet("https://pastefy.app/gR9TNZLb/raw"))()
r110_0:Toggle(true)
r110_0.Players = false
r110_0.Tracers = false
r110_0.Boxes = false
r110_0.Names = false
r110_0.TeamColor = false
r110_0.TeamMates = false
r84_0:Toggle("开启/关闭透视(总开关 必开)", "ESP", false, function(r0_178)
  
  r110_0.Players = r0_178
end)
r84_0:Toggle("显示名称", "ESP", false, function(r0_626)
  
  r110_0.Names = r0_626
end)
r84_0:Toggle("显示框框", "ESP", false, function(r0_531)
  
  r110_0.Boxes = r0_531
end)
r84_0:Toggle("显示射线", "ESP", false, function(r0_660)
  
  r110_0.Tracers = r0_660
end)
r84_0:Toggle("开启/关闭透视队伍验证", "ESP", false, function(r0_711)
  
  r110_0.TeamColor = r0_711
end)
r84_0:Label("③透视ESP")
getgenv().ESPEnabled = false
getgenv().ShowBox = false
getgenv().ShowHealth = false
getgenv().ShowName = false
getgenv().ShowDistance = false
getgenv().ShowTracer = false
getgenv().TeamCheck = false
local r111_0 = game:GetService("Players")
local r112_0 = game:GetService("RunService")
local r113_0 = workspace.CurrentCamera
local r114_0 = r111_0.LocalPlayer
local function r115_0(r0_693)
  
  local r1_693 = Drawing.new("Square")
  r1_693.Visible = false
  r1_693.Color = Color3.new(1, 1, 1)
  r1_693.Thickness = 1
  r1_693.Filled = false
  local r2_693 = Drawing.new("Text")
  r2_693.Visible = false
  r2_693.Color = Color3.new(0, 1, 0)
  r2_693.Size = 16
  local r3_693 = Drawing.new("Text")
  r3_693.Visible = false
  r3_693.Color = Color3.new(1, 1, 1)
  r3_693.Size = 16
  local r4_693 = Drawing.new("Text")
  r4_693.Visible = false
  r4_693.Color = Color3.new(1, 1, 0)
  r4_693.Size = 16
  local r5_693 = Drawing.new("Line")
  r5_693.Visible = false
  r5_693.Color = Color3.new(1, 0, 0)
  r5_693.Thickness = 1
  r112_0.RenderStepped:Connect(function()
    
    if not getgenv().ESPEnabled or not r0_693.Character or not r0_693.Character:FindFirstChild("HumanoidRootPart") or not r0_693.Character:FindFirstChild("Humanoid") or r0_693 == r114_0 then
      r1_693.Visible = false
      r2_693.Visible = false
      r3_693.Visible = false
      r4_693.Visible = false
      r5_693.Visible = false
      return 
    end
    if getgenv().TeamCheck and r0_693.Team == r114_0.Team then
      r1_693.Visible = false
      r2_693.Visible = false
      r3_693.Visible = false
      r4_693.Visible = false
      r5_693.Visible = false
      return 
    end
    local r0_694 = r0_693.Character
    local r1_694 = r0_694:FindFirstChild("HumanoidRootPart")
    local r2_694 = r0_694:FindFirstChild("Humanoid")
    if r1_694 and r2_694 and 0 < r2_694.Health then
      local r3_694, r4_694 = r113_0:WorldToViewportPoint(r1_694.Position)
      local r5_694, r6_694 = r113_0:WorldToViewportPoint(r1_694.Position + Vector3.new(0, 3, 0))
      local r7_694, r8_694 = r113_0:WorldToViewportPoint(r1_694.Position - Vector3.new(0, 3, 0))
      if getgenv().ShowBox and r4_694 then
        r1_693.Size = Vector2.new(1000 / r3_694.Z, r5_694.Y - r7_694.Y)
        r1_693.Position = Vector2.new(r3_694.X - r1_693.Size.X / 2, r3_694.Y - r1_693.Size.Y / 2)
        r1_693.Visible = true
      else
        r1_693.Visible = false
      end
      if getgenv().ShowHealth and r4_694 then
        r2_693.Position = Vector2.new(r3_694.X, r3_694.Y - r1_693.Size.Y / 2 - 20)
        r2_693.Text = "血量: " .. math.floor(r2_694.Health)
        r2_693.Visible = true
      else
        r2_693.Visible = false
      end
      if getgenv().ShowName and r4_694 then
        r3_693.Position = Vector2.new(r3_694.X, r3_694.Y - r1_693.Size.Y / 2 - 40)
        r3_693.Text = "名字: " .. r0_693.Name
        r3_693.Visible = true
      else
        r3_693.Visible = false
      end
      if getgenv().ShowDistance and r4_694 then
        r4_693.Position = Vector2.new(r3_694.X, r3_694.Y + r1_693.Size.Y / 2 + 20)
        r4_693.Text = "距离: " .. math.floor((r114_0.Character.HumanoidRootPart.Position - r1_694.Position).Magnitude) .. " ㎝"
        r4_693.Visible = true
      else
        r4_693.Visible = false
      end
-- ...existing code...
      if getgenv().ShowTracer then
        local r9_694 = r5_693
        local tracerStart = getgenv().TracerStart
        local startPos

        if tracerStart == "Bottom" then
          startPos = Vector2.new(r113_0.ViewportSize.X / 2, r113_0.ViewportSize.Y)
        elseif tracerStart == "Center" or tracerStart == "Middle" then
          startPos = Vector2.new(r113_0.ViewportSize.X / 2, r113_0.ViewportSize.Y / 2)
        elseif typeof(tracerStart) == "Vector2" then
          startPos = tracerStart
        else
          -- 默认回退到屏幕中心
          startPos = Vector2.new(r113_0.ViewportSize.X / 2, r113_0.ViewportSize.Y / 2)
        end

        r9_694.From = startPos
        r5_693.To = Vector2.new(r3_694.X, r3_694.Y)
        r5_693.Visible = r4_694
      else
        r5_693.Visible = false
      end
-- ...existing code...
    else
      r1_693.Visible = false
      r2_693.Visible = false
      r3_693.Visible = false
      r4_693.Visible = false
      r5_693.Visible = false
    end
  end)
end
for r119_0, r120_0 in pairs(r111_0:GetPlayers()) do
  if r120_0 ~= r114_0 then
    r115_0(r120_0)
  end
end
r111_0.PlayerAdded:Connect(function(r0_571)
  
  if r0_571 ~= r114_0 then
    r115_0(r0_571)
  end
end)
r84_0:Toggle("ESP总开关[必开]", "Enabled", false, function(r0_269)
  
  getgenv().ESPEnabled = r0_269
end)
r84_0:Toggle("身体方框", "Box", false, function(r0_540)
  
  getgenv().ShowBox = r0_540
end)
r84_0:Toggle("血量", "Health", false, function(r0_132)
  
  getgenv().ShowHealth = r0_132
end)
r84_0:Toggle("用户名", "Name", false, function(r0_616)
  
  getgenv().ShowName = r0_616
end)
r84_0:Toggle("距离", "Distance", false, function(r0_510)
  
  getgenv().ShowDistance = r0_510
end)
r84_0:Toggle("天线", "Tracer", false, function(r0_494)
  
  getgenv().ShowTracer = r0_494
end)
r84_0:Toggle("团队判断", "Team check", false, function(r0_356)
  
  getgenv().TeamCheck = r0_356
end)
local r117_0 = r50_0:Tab("『自瞄』", "18930406865"):section("自瞄", true)
r117_0:Label("圈圈自瞄")
r117_0:Toggle("显示圈圈自瞄", "open/close", false, function(r0_42)
  
  if r0_42 then
    InitFOV(AimConfig.fovsize, AimConfig.fovcolor, AimConfig.fovthickness, AimConfig.Transparency)
  else
    CleanupFOV()
  end
end)
r117_0:Toggle("开启/关闭圈圈自瞄", "open/close", false, function(r0_507)
  
  AimConfig.fovlookAt = r0_507
end)
local r120_0 = "Slider"
r120_0 = "圈圈自瞄厚度"
r117_0:Slider("圈圈自瞄厚度", "thickness", 2, 0, 10, false, function(r0_144)
  
  AimConfig.fovthickness = r0_144
  UpdateFOVSettings()
end)
r120_0 = "Slider"
r120_0 = "圈圈自瞄大小"
r117_0:Slider("圈圈自瞄大小", "Size", 50, 0, 100, false, function(r0_642)
  
  AimConfig.fovsize = r0_642
  UpdateFOVSettings()
end)
r120_0 = "Slider"
r120_0 = "圈圈自瞄透明度"
r117_0:Slider("圈圈自瞄透明度", "Transparency", 5, 0, 10, false, function(r0_473)
  
  AimConfig.Transparency = r0_473
  UpdateFOVSettings()
end)
r120_0 = "Slider"
r120_0 = "圈圈自瞄距离"
r117_0:Slider("圈圈自瞄距离", "distance", 200, 10, 500, false, function(r0_705)
  
  AimConfig.distance = r0_705
end)
r120_0 = "Dropdown"
r120_0 = "选择圈圈自瞄颜色"
local r118_0 = r117_0:Dropdown("选择圈圈自瞄颜色", "Dropdown", {
  "红色",
  "蓝色",
  "黄色",
  "绿色",
  "青色",
  "橙色",
  "紫色",
  "白色",
  "黑色"
}, function(r0_103)
  
  AimConfig.fovcolor = ColorConfig[r0_103]
  UpdateFOVSettings()
  drop.Text = "圈圈自瞄颜色" .. r0_103
end)
local r121_0 = "Dropdown"
r121_0 = "选择圈圈自瞄部位"
local r119_0 = r117_0:Dropdown("选择圈圈自瞄部位", "Dropdown", {
  "头部",
  "脖子",
  "躯干",
  "左臂",
  "右臂",
  "左腿",
  "右腿",
  "左手",
  "右手",
  "左小臂",
  "右小臂",
  "左大臂",
  "右大臂",
  "左脚",
  "左小腿",
  "上半身",
  "左大腿",
  "右脚",
  "右小腿",
  "下半身",
  "右大腿",
  nil
}, function(r0_378)
  
  AimConfig.Position = BodyPartMap[r0_378]
  UpdateFOVSettings()
  r118_0.Text = "选择圈圈自瞄部位" .. r0_378
end)
r117_0:Toggle("队伍检测", "Enable/Disable Team Check", false, function(r0_709)
  
  AimConfig.teamCheck = r0_709
end)
r117_0:Toggle("活体检测", "Alive Check", false, function(r0_546)
  
  AimConfig.aliveCheck = r0_546
end)
r117_0:Toggle("墙壁检测", "Enable/Disable Wall Check", false, function(r0_268)
  
  AimConfig.wallCheck = r0_268
end)
r117_0:Toggle("预判自瞄", "prejudging self-sighting", false, function(r0_71)
  
  AimConfig.prejudgingselfsighting = r0_71
end)
local r122_0 = "Slider"
r122_0 = "预判距离"
r117_0:Slider("预判距离", "distance", 100, 10, 500, false, function(r0_276)
  
  AimConfig.prejudgingselfsightingdistance = r0_276
end)
r117_0:Label("Distance距离优先 : 优先瞄准距离最近的敌人")
r117_0:Label("Crosshair准星优先 : 优先瞄准准星附近的敌人")
r117_0:Label("Speed速度优先 : 优先瞄准移动速度最快的敌人")
r117_0:Label("Smart智能模式 : 综合距离、速度和准星距离，自动选择最佳目标")
r122_0 = "Dropdown"
r122_0 = "圈圈自瞄优先模式"
r120_0 = r117_0:Dropdown("圈圈自瞄优先模式", "Priority Mode", {
  "Distance",
  "Crosshair",
  "Speed",
  "Smart"
}, function(r0_193)
  
  AimConfig.priorityMode = r0_193
  r119_0.Text = "圈圈自瞄优先模式" .. r0_193
end)
r117_0:Label("AI自瞄 : 使用AI算法进行自瞄")
r117_0:Label("函数自瞄 : 使用数学函数进行自瞄")
local r123_0 = "Dropdown"
r123_0 = "自瞄模式"
r121_0 = r117_0:Dropdown("自瞄模式", "Aim Mode", {
  "AI",
  "Function"
}, function(r0_119)
  
  AimConfig.aimMode = r0_119
  r120_0.Text = "自瞄模式" .. r0_119
end)
local r124_0 = "Slider"
r124_0 = "平滑度"
r117_0:Slider("平滑度", "Smoothness", 5, 0, 10, false, function(r0_524)
  
  AimConfig.smoothness = r0_524
end)
r124_0 = "Slider"
r124_0 = "自瞄速度"
r117_0:Slider("自瞄速度", "Aim Speed", 5, 0, 10, false, function(r0_209)
  
  AimConfig.aimSpeed = r0_209
end)
r117_0:Label("动态自瞄")
r117_0:Toggle("动态自瞄FOV", "Dynamic FOV Scaling", false, function(r0_2)
  
  AimConfig.dynamicFOV = r0_2
  if r0_2 then
    AimConfig.fovsize = 20 / AimConfig.smoothness * AimConfig.aimSpeed
    UpdateFOVSettings()
  else
    AimConfig.fovsize = 20
    UpdateFOVSettings()
  end
end)
r124_0 = "Slider"
r124_0 = "动态FOV缩放比例"
r117_0:Slider("动态FOV缩放比例", "Dynamic FOV Scale", 1.5, 1, 3, false, function(r0_448)
  
  AimConfig.dynamicFOVScale = r0_448
  if AimConfig.dynamicFOV then
    AimConfig.fovsize = 20 / AimConfig.smoothness * AimConfig.aimSpeed * r0_448
    UpdateFOVSettings()
  end
end)
r117_0:Toggle("自动开火", "Auto Fire", false, function(r0_167)
  
  AimConfig.autoFire = r0_167
end)
r124_0 = "Slider"
r124_0 = "开火频率"
r117_0:Slider("开火频率", "Fire Rate", 10, 1, 20, false, function(r0_479)
  
  AimConfig.fireRate = r0_479
end)
r124_0 = "Slider"
r124_0 = "子弹延迟"
r117_0:Slider("子弹延迟", "Bullet Delay", 0.1, 0, 1, false, function(r0_710)
  
  AimConfig.bulletDelay = r0_710
end)
r117_0:Toggle("武器切换", "Weapon Switch", false, function(r0_411)
  
  AimConfig.weaponSwitch = r0_411
end)
r117_0:Toggle("威胁度优先", "Threat Priority", false, function(r0_472)
  
  AimConfig.threatPriority = r0_472
end)
r117_0:Toggle("血量优先", "Health Priority", false, function(r0_239)
  
  AimConfig.healthPriority = r0_239
end)
r123_0 = r50_0:Tab("『FE娱乐脚本』", "18930406865"):section("脚本", true)
r123_0:Button("FE cmd", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/cmd/main/testing-main.lua"))()
end)
r123_0:Button("FE C00lgui", function()
  
  loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()
end)
r123_0:Button("FE 1x1x1x1", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/JipYNCht", true))()
end)
r123_0:Button("FE 大长腿", function()
  
  loadstring(game:HttpGet([[https://gist.githubusercontent.com/1BlueCat/7291747e9f093555573e027621f08d6e/raw/23b48f2463942befe19d81aa8a06e3222996242c/FE%2520Da%2520Feets]]))()
end)
r123_0:Button("FE 用头", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/BK4Q0DfU"))()
end)
r123_0:Button("FE 复仇者", function()
  
  loadstring(game:HttpGet("https://pastefy.ga/iGyVaTvs/raw", true))()
end)
r123_0:Button("FE 鼠标", function()
  
  loadstring(game:HttpGet("https://pastefy.ga/V75mqzaz/raw", true))()
end)
r123_0:Button("FE 变怪物", function()
  
  loadstring(game:HttpGetAsync("https://pastebin.com/raw/jfryBKds"))()
end)
r123_0:Button("FE 香蕉枪", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/BananaGunByNerd.lua"))()
end)
r123_0:Button("FE 超长级把", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/ESWSFND7", true))()
end)
r123_0:Button("FE 动画中心", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui]], true))()
end)
r123_0:Button("FE 变玩家", function()
  
  loadstring(game:HttpGet("https://pastebin.com/raw/PvnN4B8R"))()
end)
r123_0:Button("FE 猫娘R63", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/Pendulum%20Hub%20V5.lua]]))()
end)
r123_0:Button("FE", function()
  
  loadstring(game:HttpGet("https://pastefy.ga/a7RTi4un/raw"))()
end)
r123_0:Button("FE R6撸管", function()
  
  loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)
r123_0:Button("FE R15撸管", function()
  
  loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)
r123_0:Button("FE R6远程操蛋", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/YE-R6CB-SCRIPT.lua]]))()
end)
r123_0:Button("FE R15远程操蛋", function()
  
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/YE-R15CB-SCRIPT.lua]]))()
end)
r123_0:Button("FE Tuber93入侵弹窗图显示", function()
  
  loadstring(game:HttpGet("https://pastefy.app/veGCWoZ6/raw"))()
end)
r123_0:Button("FE 修改大司马脚本天空", function()
  
  loadstring(game:HttpGet("https://pastefy.app/HZaYQYHa/raw"))()
end)
r123_0:Button("FE 黑客入侵", function()
  
  loadstring(game:HttpGet("https://pastefy.app/qQOkHeaY/raw"))()
end)
local r125_0 = r50_0:Tab("『音乐』", "18930406865"):section("音乐", true)
r125_0:Label("输入音乐ID即可 播放音乐仅自己可听见")
local r128_0 = "Textbox"
r128_0 = "音乐播放器"
r125_0:Textbox("音乐播放器", "Textbox", "输入音乐ID", true, function(r0_310)
  
  local r1_310 = r0_310
  if r1_310 then
    audio.SoundId = "rbxassetid://" .. r1_310
    audio:Play()
  end
end)
r125_0:Button("停止播放", function()
  
  audio:Stop()
end)
r125_0:Label("下面是音乐合集↓")
r125_0:Button("防空警报", function()
  
  local r0_168 = Instance.new("Sound")
  r0_168.SoundId = "rbxassetid://792323017"
  r0_168.Parent = game.Workspace
  r0_168:Play()
end)
r125_0:Button("义勇军进行曲", function()
  
  local r0_39 = Instance.new("Sound")
  r0_39.SoundId = "rbxassetid://1845918434"
  r0_39.Parent = game.Workspace
  r0_39:Play()
end)
r125_0:Button("彩虹瀑布", function()
  
  local r0_17 = Instance.new("Sound")
  r0_17.SoundId = "rbxassetid://1837879082"
  r0_17.Parent = game.Workspace
  r0_17:Play()
end)
r125_0:Button("雨中牛郎", function()
  
  local r0_206 = Instance.new("Sound")
  r0_206.SoundId = "rbxassetid://16831108393"
  r0_206.Parent = game.Workspace
  r0_206:Play()
end)
r125_0:Button("钢管落地(大声)", function()
  
  local r0_6 = Instance.new("Sound")
  r0_6.SoundId = "rbxassetid://6729922069"
  r0_6.Parent = game.Workspace
  r0_6:Play()
end)
r125_0:Button("钢管落地", function()
  
  local r0_414 = Instance.new("Sound")
  r0_414.SoundId = "rbxassetid://6011094380"
  r0_414.Parent = game.Workspace
  r0_414:Play()
end)
r125_0:Button("闪灯", function()
  
  local r0_684 = Instance.new("Sound")
  r0_684.SoundId = "rbxassetid://8829969521"
  r0_684.Parent = game.Workspace
  r0_684:Play()
end)
r125_0:Button("全损音质", function()
  
  local r0_551 = Instance.new("Sound")
  r0_551.SoundId = "rbxassetid://6445594239"
  r0_551.Parent = game.Workspace
  r0_551:Play()
end)
r125_0:Button("串稀", function()
  
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://4809574295"
  r0_395.Parent = game.Workspace
  r0_395:Play()
end)
r125_0:Button("手枪开枪", function()
  
  local r0_410 = Instance.new("Sound")
  r0_410.SoundId = "rbxassetid://6569844325"
  r0_410.Parent = game.Workspace
  r0_410:Play()
end)
r125_0:Button("喝可乐", function()
  
  local r0_121 = Instance.new("Sound")
  r0_121.SoundId = "rbxassetid://6911756959"
  r0_121.Parent = game.Workspace
  r0_121:Play()
end)
r125_0:Button("Doors TheHunt 倒计时开始", function()
  
  local r0_361 = Instance.new("Sound")
  r0_361.SoundId = "rbxassetid://16695384009"
  r0_361.Parent = game.Workspace
  r0_361:Play()
end)
r125_0:Button("Doors TheHunt 倒计时结束", function()
  
  local r0_641 = Instance.new("Sound")
  r0_641.SoundId = "rbxassetid://16695021133"
  r0_641.Parent = game.Workspace
  r0_641:Play()
end)
r125_0:Button("你他妈劈我瓜是吧", function()
  
  local r0_141 = Instance.new("Sound")
  r0_141.SoundId = "rbxassetid://7309604510"
  r0_141.Parent = game.Workspace
  r0_141:Play()
end)
r125_0:Button("未知核爆倒计时", function()
  
  local r0_238 = Instance.new("Sound")
  r0_238.SoundId = "rbxassetid://9133927345"
  r0_238.Parent = game.Workspace
  r0_238:Play()
end)
r125_0:Button("火车音", function()
  
  local r0_487 = Instance.new("Sound")
  r0_487.SoundId = "rbxassetid://3900067524"
  r0_487.Parent = game.Workspace
  r0_487:Play()
end)
r125_0:Button("Gentry Road", function()
  
  local r0_23 = Instance.new("Sound")
  r0_23.SoundId = "rbxassetid://5567523008"
  r0_23.Parent = game.Workspace
  r0_23:Play()
end)
r125_0:Button("植物大战僵尸", function()
  
  local r0_600 = Instance.new("Sound")
  r0_600.SoundId = "rbxassetid://158260415"
  r0_600.Parent = game.Workspace
  r0_600:Play()
end)
r125_0:Button("早安越南", function()
  
  local r0_224 = Instance.new("Sound")
  r0_224.SoundId = "rbxassetid://8295016126"
  r0_224.Parent = game.Workspace
  r0_224:Play()
end)
r125_0:Button("愤怒芒西 Evade?", function()
  
  local r0_495 = Instance.new("Sound")
  r0_495.SoundId = "rbxassetid://5029269312"
  r0_495.Parent = game.Workspace
  r0_495:Play()
end)
r125_0:Button("梅西", function()
  
  local r0_163 = Instance.new("Sound")
  r0_163.SoundId = "rbxassetid://7354576319"
  r0_163.Parent = game.Workspace
  r0_163:Play()
end)
r125_0:Button("永春拳", function()
  
  local r0_692 = Instance.new("Sound")
  r0_692.SoundId = "rbxassetid://1845973140"
  r0_692.Parent = game.Workspace
  r0_692:Play()
end)
r125_0:Button("带劲的音乐", function()
  
  local r0_306 = Instance.new("Sound")
  r0_306.SoundId = "rbxassetid://18841891575"
  r0_306.Parent = game.Workspace
  r0_306:Play()
end)
r125_0:Button("韩国国歌", function()
  
  local r0_116 = Instance.new("Sound")
  r0_116.SoundId = "rbxassetid://1837478300"
  r0_116.Parent = game.Workspace
  r0_116:Play()
end)
r125_0:Button("哥哥你女朋友不会吃醋吧?", function()
  
  local r0_330 = Instance.new("Sound")
  r0_330.SoundId = "rbxassetid://8715811379"
  r0_330.Parent = game.Workspace
  r0_330:Play()
end)
r125_0:Button("蜘蛛侠出场声音", function()
  
  local r0_66 = Instance.new("Sound")
  r0_66.SoundId = "rbxassetid://9108472930"
  r0_66.Parent = game.Workspace
  r0_66:Play()
end)
r125_0:Button("消防车", function()
  
  local r0_176 = Instance.new("Sound")
  r0_176.SoundId = "rbxassetid://317455930"
  r0_176.Parent = game.Workspace
  r0_176:Play()
end)
r125_0:Button("万圣节1������", function()
  
  local r0_456 = Instance.new("Sound")
  r0_456.SoundId = "rbxassetid://1837467198"
  r0_456.Parent = game.Workspace
  r0_456:Play()
end)
r125_0:Button("好听的", function()
  
  local r0_434 = Instance.new("Sound")
  r0_434.SoundId = "rbxassetid://1844125168"
  r0_434.Parent = game.Workspace
  r0_434:Play()
end)
r125_0:Button("妈妈生的", function()
  
  local r0_420 = Instance.new("Sound")
  r0_420.SoundId = "rbxassetid://6689498326"
  r0_420.Parent = game.Workspace
  r0_420:Play()
end)
r125_0:Button("Music Ball-CTT", function()
  
  local r0_250 = Instance.new("Sound")
  r0_250.SoundId = "rbxassetid://9045415830"
  r0_250.Parent = game.Workspace
  r0_250:Play()
end)
r125_0:Button("电音", function()
  
  local r0_11 = Instance.new("Sound")
  r0_11.SoundId = "rbxassetid://6911766512"
  r0_11.Parent = game.Workspace
  r0_11:Play()
end)
r125_0:Button("梗合集", function()
  
  local r0_477 = Instance.new("Sound")
  r0_477.SoundId = "rbxassetid://8161248815"
  r0_477.Parent = game.Workspace
  r0_477:Play()
end)
r125_0:Button("Its been so long", function()
  
  local r0_273 = Instance.new("Sound")
  r0_273.SoundId = "rbxassetid://6913550990"
  r0_273.Parent = game.Workspace
  r0_273:Play()
end)
r125_0:Button("Baller", function()
  
  local r0_12 = Instance.new("Sound")
  r0_12.SoundId = "rbxassetid://13530439660"
  r0_12.Parent = game.Workspace
  r0_12:Play()
end)
r125_0:Button("男娘必听", function()
  
  local r0_241 = Instance.new("Sound")
  r0_241.SoundId = "rbxassetid://6797864253"
  r0_241.Parent = game.Workspace
  r0_241:Play()
end)
r125_0:Button("螃蟹之舞", function()
  
  local r0_688 = Instance.new("Sound")
  r0_688.SoundId = "rbxassetid://54100886218"
  r0_688.Parent = game.Workspace
  r0_688:Play()
end)
r125_0:Button("布鲁克林惨案", function()
  
  local r0_681 = Instance.new("Sound")
  r0_681.SoundId = "rbxassetid://6783714255"
  r0_681.Parent = game.Workspace
  r0_681:Play()
end)
r125_0:Button("航空模拟器音乐", function()
  
  local r0_100 = Instance.new("Sound")
  r0_100.SoundId = "rbxassetid://1838080629"
  r0_100.Parent = game.Workspace
  r0_100:Play()
end)
local r127_0 = r50_0:Tab("『其他脚本』", "18930406865"):section("其他脚本", true)
r127_0:Button("鸭Hub", function()
  
  loadstring(game:HttpGet(utf8.char((function()
    
    return table.unpack({
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      112,
      97,
      115,
      116,
      101,
      98,
      105,
      110,
      46,
      99,
      111,
      109,
      47,
      114,
      97,
      119,
      47,
      81,
      89,
      49,
      113,
      112,
      99,
      115,
      106,
      nil,
      nil,
      nil
    })
  end)())))()
end)
