local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local PathfindingService = game:GetService("PathfindingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local ExecutorSupport = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheHunterSolo1/Scripts/refs/heads/main/ExecutorTest"))()

local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
repeat task.wait() until game:IsLoaded()
  
  if game:GetService("Players").LocalPlayer:GetAttribute("SupremeLoaded") then
    if getgenv().Library then
      getgenv().Library:Notify("脚本已刷新",4)
    else
      print("脚本已刷新")
    end
    return end
    game:GetService("Players").LocalPlayer:SetAttribute("SupremeLoaded",true)
    
    local LibraryName = '免费脚本'
    
    
    local executionCount = 0
    
    if isfile and writefile and readfile then
      local filename = "ExecutionCount.txt"
      
      
      if isfile(filename) then
        executionCount = tonumber(readfile(filename)) or 0
        executionCount = executionCount + 1
        writefile(filename, tostring(executionCount))
      else
        executionCount = 1
        writefile(filename, "1")
      end
    end
    
    
    if game.PlaceId == 126509999114328 then
      
      local repo = 'https://raw.githubusercontent.com/mstudio45/Obsidian/main/'
      local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheHunterSolo1/Scripts/main/ESPLibrary"))() -- Loading the library
      
      local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
      local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
      local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
      
      local Options = Library.Options
      local Toggles = Library.Toggles
      local Connections = {}
      local Window = Library:CreateWindow({
      Title = LibraryName,
      Center = true,
      ToggleKeybind = Enum.KeyCode.RightControl,
      AutoShow = true,
      NotifySide = "Right",
      ShowCustomCursor = true,
    })
    local PlaySound = true
    local function Notify(txt,duration)
      Library:Notify({
      Title = LibraryName,
      Description = txt .. "!",
      Time = duration,
    })
    if PlaySound then
      local Sound = Instance.new("Sound",game:GetService("SoundService"))
      Sound.SoundId = "rbxassetid://101511361468852"
      
      Sound.Volume = 2
      Sound:Play()
      game:GetService("Debris"):AddItem(Sound, 3)
    end
  end
  
  local function AddESP(part,txt,color)
    ESPLibrary:AddESP({
    Object = part, -- The object you want to highlight
    Text = txt, -- What you want the text to say,
    Color = color -- The color of the esp to set.
  })
end

Notify("加载中 | 99夜",2)


local AlreadyChanged = {}

local ChildrenNames = {
["Lost Child"] = "恐龙儿童",
["Lost Child2"] = "海怪儿童",
["Lost Child3"] = "鱿鱼儿童",
["Lost Child4"] = "考拉儿童"
}


task.wait(2)


local Tabs = {
Home = Window:AddTab('主页', 'house'),
Main = Window:AddTab('玩家', "star"),
Visuals = Window:AddTab('ESP',"eye"),
Settings = Window:AddTab('设置',"settings"),
}



local HomeBox = Tabs.Home:AddLeftGroupbox('主页')

local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)

HomeBox:AddImage("PlayerFace", {
Image = content,
Height = 200,
})

HomeBox:AddDivider()
HomeBox:AddLabel('执行次数 ' .. (tonumber(executionCount) and tonumber(executionCount) >= 1 and executionCount or "Nan"))
local OPBox = Tabs.Main:AddRightGroupbox('种树功能')
OPBox:AddLabel('滥用此功能可能导致服务器崩溃或严重卡顿',true)
OPBox:AddToggle('InfSapling',{
Text = "批量种植树苗",
Default = false,
Tooltip = "自动在所在位置种植树苗"
})
OPBox:AddDropdown("SaplingPlace", {
Values = {"工作台","篝火","玩家" },
Default = 2, -- number index of the value / string
Multi = false, -- true / false, allows multiple choices to be selected

Text = "种树位置",
Tooltip = "选择种植树苗的位置",

Callback = function(Value)
end,


})
OPBox:AddDivider()


local AuraBox = Tabs.Main:AddLeftGroupbox('光环[测试版本]')
local TPBox = Tabs.Main:AddLeftGroupbox('传送')
TPBox:AddLabel('传送的物品你自己得拿了之后别的玩家才会显示',true)
TPBox:AddButton('传送所有木头到玩家',function()

for _, v in pairs(workspace.Items:GetChildren()) do
  if v.Name == "Log" then
    v:PivotTo(LocalPlayer.Character.HumanoidRootPart.CFrame)
    local Sack = LocalPlayer.Inventory:FindFirstChild("Old Sack") or
    LocalPlayer.Inventory:FindFirstChild("Good Sack") or LocalPlayer.Inventory:FindFirstChild("Giant Sack")
    local args = {
    Sack,
    v
  }
  game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestBagStoreItem"):InvokeServer(unpack(args))
  
  local args = {
  Sack,
  v,
  false
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestBagDropItem"):FireServer(unpack(args))

end

end

end)
TPBox:AddButton('传送所有食物到玩家',function()

for _, v in pairs(workspace.Items:GetChildren()) do
  if not (v.Name == "Berry") then
    if v:GetAttribute("RestoreHunger") then
      v:PivotTo(LocalPlayer.Character.HumanoidRootPart.CFrame)
      local Sack = LocalPlayer.Inventory:FindFirstChild("Old Sack") or
      LocalPlayer.Inventory:FindFirstChild("Good Sack") or LocalPlayer.Inventory:FindFirstChild("Giant Sack")
      local args = {
      Sack,
      v
    }
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestBagStoreItem"):InvokeServer(unpack(args))
    
    local args = {
    Sack,
    v,
    false
  }
  game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestBagDropItem"):FireServer(unpack(args))
  
end
end
end

end)
TPBox:AddButton('传送所有燃料到玩家',function()

for _, v in pairs(workspace.Items:GetChildren()) do
  if not (v.Name == "Log" or v.Name == "Sapling") then
    if v:GetAttribute("BurnFuel") then
      v:PivotTo(LocalPlayer.Character.HumanoidRootPart.CFrame)
      local Sack = LocalPlayer.Inventory:FindFirstChild("Old Sack") or
      LocalPlayer.Inventory:FindFirstChild("Good Sack")  or LocalPlayer.Inventory:FindFirstChild("Giant Sack")
      local args = {
      Sack,
      v
    }
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestBagStoreItem"):InvokeServer(unpack(args))
    
    local args = {
    Sack,
    v,
    false
  }
  game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestBagDropItem"):FireServer(unpack(args))
  
end

end
end
end)

TPBox:AddButton('传送所有治疗物品到玩家',function()

for _, v in pairs(workspace.Items:GetChildren()) do
  
  if v.Name == "Bandage" or v.Name == "Medkit" then
    v:PivotTo(LocalPlayer.Character.HumanoidRootPart.CFrame)
    local Sack = LocalPlayer.Inventory:FindFirstChild("Old Sack") or
    LocalPlayer.Inventory:FindFirstChild("Good Sack") or LocalPlayer.Inventory:FindFirstChild("Giant Sack")
    local args = {
    Sack,
    v
  }
  game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestBagStoreItem"):InvokeServer(unpack(args))
  
  local args = {
  Sack,
  v,
  false
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestBagDropItem"):FireServer(unpack(args))

end

end

end)


TPBox:AddButton('传送所有金属到玩家',function()

for _, v in pairs(workspace.Items:GetChildren()) do
  
  if v:GetAttribute("Scrappable") then v:PivotTo(LocalPlayer.Character.HumanoidRootPart.CFrame)
    local Sack = LocalPlayer.Inventory:FindFirstChild("Old Sack") or
    LocalPlayer.Inventory:FindFirstChild("Good Sack") or LocalPlayer.Inventory:FindFirstChild("Giant Sack")
    local args = {
    Sack,
    v
  }
  game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestBagStoreItem"):InvokeServer(unpack(args))
  
  local args = {
  Sack,
  v,
  false
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestBagDropItem"):FireServer(unpack(args))

end

end

end)






local LightingBox = Tabs.Visuals:AddLeftGroupbox('设置')

local ESPBox = Tabs.Visuals:AddRightGroupbox('ESP')
local ESPSettings = Tabs.Visuals:AddLeftGroupbox('ESP 设置[翻译差距是因为游戏内的自动翻译]')

ESPSettings:AddToggle('ShowMarker',{
Text = "显示距离",
Default = false,
Tooltip = "显示目标与你的距离",
Callback = function(Value)
ESPLibrary:SetShowDistance(Value)
end
})
ESPSettings:AddToggle('ShowTracers',{
Text = "显示射线",
Default = false,
Tooltip = "显示3D射线",
Callback = function(Value)
ESPLibrary:SetTracers(Value)
end
})

ESPBox:AddToggle('Children',{
Text = "儿童",
Default = false,
Callback = function(Value)

if Value then
  for _, v in pairs(workspace.Characters:GetChildren()) do
    local Child = ChildrenNames[v.Name]
    if Child then
      AddESP(v, Child, Color3.new(1, 1, 1))
    end
  end
else
  for _, v in pairs(workspace.Characters:GetChildren()) do
    local Child = ChildrenNames[v.Name]
    if Child then
      ESPLibrary:RemoveESP(v)
    end
  end
  
end


end

})
ESPBox:AddToggle('Monsters',{
Text = "怪物",
Default = false,
Callback = function(Value)

if Value then
  for _, v in pairs(workspace.Characters:GetChildren()) do
    if v.Name == "Wolf" or v.Name == "Alpha Wolf" or v.Name == "Mammoth" or v.Name == "Cultist" or v.Name == "Shadow Cultist" or v.Name == "Bear" or v.Name == "Crossbow Cultist" or v.Name == "Frog" or v.Name == "Brutal Cultist" then
      AddESP(v, v.Name, Color3.new(1, 0, 0))
    end
  end
else
  for _, v in pairs(workspace.Characters:GetChildren()) do
    if v.Name == "Wolf" or v.Name == "Alpha Wolf" or v.Name == "Mammoth" or v.Name == "Cultist" or v.Name == "Shadow Cultist" or v.Name == "Bear" or v.Name == "Crossbow Cultist" or v.Name == "Frog" or v.Name == "Brutal Cultist" then
      ESPLibrary:RemoveESP(v)
    end
  end
  
end


end

})
ESPBox:AddToggle('Chest',{
Text = "宝箱",
Default = false,
Callback = function(Value)

if Value then
  table.clear(AlreadyChanged)
  for _, v in pairs(workspace.Items:GetChildren()) do
    if string.match(v.Name, "Chest") then
      AddESP(v, "Chest", Color3.new(1, 0.85, 0))
    end
  end
else
  for _, v in pairs(workspace.Items:GetChildren()) do
    if string.match(v.Name, "Chest") then
      ESPLibrary:RemoveESP(v)
      
    end
  end
end

end
})
ESPBox:AddToggle('Armor',{
Text = "护甲",
Default = false,
Callback = function(Value)

if Value then
  for _, v in pairs(workspace.Items:GetChildren()) do
    if string.match(v.Name, "Body") or string.match(v.Name, "Armor") then
      AddESP(v, v.Name, Color3.new(1, 0.85, 0))
    end
  end
else
  for _, v in pairs(workspace.Items:GetChildren()) do
    if string.match(v.Name, "Body") or string.match(v.Name, "Armor") then
      ESPLibrary:RemoveESP(v)
      
    end
  end
end

end
})

ESPBox:AddToggle('Food',{
Text = "食物",
Default = false,
Callback = function(Value)

if Value then
  for _, v in pairs(workspace.Items:GetChildren()) do
    if v:GetAttribute("RestoreHunger") then
      AddESP(v, v.Name, Color3.new(1, 0.7, 0.8))
    end
  end
else
  for _, v in pairs(workspace.Items:GetChildren()) do
    if v:GetAttribute("RestoreHunger") then
      ESPLibrary:RemoveESP(v)
      
    end
  end
end

end
})

ESPBox:AddToggle('Metals',{
Text = "金属",
Default = false,
Callback = function(Value)

if Value then
  for _, v in pairs(workspace.Items:GetChildren()) do
    if v:GetAttribute("Scrappable") then
      AddESP(v, v.Name, Color3.new(0.5, 0.5, 0.5))
    end
  end
else
  for _, v in pairs(workspace.Items:GetChildren()) do
    if v:GetAttribute("Scrappable") then
      ESPLibrary:RemoveESP(v)
      
    end
  end
end

end
})

table.insert(Connections,workspace.Items.ChildAdded:Connect(function(v)
if Toggles.Metals.Value then
  
  if v:GetAttribute("Scrappable") then
    AddESP(v, v.Name, Color3.new(0.5, 0.5, 0.5))
  end
  
end

if Toggles.Food.Value then
  if v:GetAttribute("RestoreHunger") then
    AddESP(v, v.Name, Color3.new(1, 0.7, 0.8))
  end
  
end

if Toggles.Chest.Value then
  
  
  if string.match(v.Name, "Chest") then
    AddESP(v, "宝箱", Color3.new(1, 0.85, 0))
  end
end
if Toggles.Armor.Value then
  
  
  if string.match(v.Name, "Body") or string.match(v.Name, "护甲") then
    AddESP(v, v.Name, Color3.new(1, 0.85, 0))
  end
end




end))

table.insert(Connections,workspace.Characters.ChildAdded:Connect(function(v)
if Toggles.Children.Value then
  
  local Child = ChildrenNames[v.Name]
  if Child then
    AddESP(v, Child, Color3.new(1, 1, 1))
  end
  
end
if Toggles.Monsters.Value then
  if v.Name == "Wolf" or v.Name == "Alpha Wolf" or v.Name == "Mammoth" or v.Name == "Cultist" or v.Name == "Shadow Cultist" or v.Name == "Bear" or v.Name == "Crossbow Cultist" or v.Name == "Frog" or v.Name == "Brutal Cultist"  then
    AddESP(v, v.Name, Color3.new(1, 0, 0))
  end
  
end

end))
LightingBox:AddToggle('NoFog',{
Text = "去雾",
Tooltip = "没有雾气",
Default = false,
Callback = function(Value)
if not Value then
  Notify("天气改变后恢复",5)
end
end
})
OPBox:AddToggle('InfJump',{
Text = "无限跳跃",
Default = false,
Tooltip = "你可以无限跳跃"
})

table.insert(Connections,UserInputService.JumpRequest:Connect(function()
if Toggles.InfJump.Value then
  
  
  if not  Toggles.InfJump.Value then return end
  LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end

end))
OPBox:AddToggle('InstantPr',{
Text = "快速交互",
Default = false,
Tooltip = "你可以快速拿东西",
Callback = function(Value)
if Value then
  for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
      v:SetAttribute("Duration",v.HoldDuration)
      v.HoldDuration = 0
    end
  end
else
  for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
      v.HoldDuration = v:GetAttribute("Duration") or 5
      v:SetAttribute("Duration",nil)
    end
  end
end
end
})
LightingBox:AddToggle('FullBright',{
Text = "夜视",
Tooltip = "高亮",
Default = false,
Callback = function(Value)
if not Value then
  Notify("天气改变后恢复",5)
end
end
})
AuraBox:AddToggle('KillAura',{
Text = "杀戮光环",
Tooltip = "远距离击杀怪物与动物",
Default = false,
Callback = function(Value)
if Value then
  Notify("需要装备近战武器或者是斧头才能生效",5)
end
end
})
AuraBox:AddSlider("KillAuraRange", {
Text = "杀戮光环范围",
Default = 50,
Min = 50,
Max = 200,
Rounding = 1,
Compact = false,
Tooltip = "需要装备近战武器或者是斧头才能生效",
Callback = function(Value)
end
})

AuraBox:AddToggle('TreeAura',{
Text = "砍树范围",
Tooltip = "远距离砍树",
Default = false,
Callback = function(Value)
if Value then
  Notify("你得拿斧头才能生效",5)
end
end
})
AuraBox:AddSlider("TreeAuraRange", {
Text = "砍树范围",
Default = 50,
Min = 50,
Max = 200,
Rounding = 1,
Compact = false,
Tooltip = "装备斧头才能生效",
Callback = function(Value)
end
})


OPBox:AddToggle('Reheal',{
Text = "自动回血",
Tooltip = "每次受伤自动使用恢复品回血",
Default = false
})
OPBox:AddButton({
Text = "无敌模式",
Tooltip = "死不掉",
DoubleClick = true,
Func = function()
Notify("无敌模式吃一下东西恢复",3)
game.ReplicatedStorage:FindFirstChild("DamagePlayer",true):FireServer(-math.huge)


end
})

table.insert(Connections,LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
if LocalPlayer.Character.Humanoid.Health < 100 then
  
  local GainHP  = (LocalPlayer.Character.Humanoid.Health - LocalPlayer.Character.Humanoid.MaxHealth)
  
  game.ReplicatedStorage:FindFirstChild("DamagePlayer",true):FireServer(GainHP)
  
end

end))
table.insert(Connections,LocalPlayer.CharacterAdded:Connect(function()
task.wait(1.5)

table.insert(Connections,LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
if LocalPlayer.Character.Humanoid.Health < 100 then
  
  local GainHP  = (LocalPlayer.Character.Humanoid.Health - LocalPlayer.Character.Humanoid.MaxHealth)
  
  game.ReplicatedStorage:FindFirstChild("DamagePlayer",true):FireServer(GainHP)
  
end

end))


end))
local KillAuraDelay = 0
local TreeAuraDelay = 0
local ChestCheckingDelay = 0
table.insert(Connections,RunService.Heartbeat:Connect(function(dt)
KillAuraDelay = KillAuraDelay + dt
TreeAuraDelay = TreeAuraDelay + dt
ChestCheckingDelay = ChestCheckingDelay + dt

if Toggles.Chest.Value then
  if ChestCheckingDelay > 1 then
    ChestCheckingDelay = 0
    for _, v in pairs(workspace.Items:GetChildren()) do
      if string.match(v.Name, "宝箱") and not AlreadyChanged[v] then
        if v:GetAttribute("LocalOpened") == true then
          AlreadyChanged[v] = true
          ESPLibrary:RemoveESP(v)
          ESPLibrary:AddESP(v, "已开启宝箱", Color3.new(1, 0.85, 0))
        end
      end
      
      
    end
    
  end
end
if KillAuraDelay > 0.3 then
  KillAuraDelay = 0
  if Toggles.KillAura.Value then
    for i, v in pairs(workspace.Characters:GetChildren()) do
      if not Toggles.KillAura.Value then return end
      if v.Name == "Bunny" or v.Name == "Wolf" or v.Name == "Alpha Wolf" or v.Name == "Mammoth" or v.Name == "Cultist" or v.Name == "Bear" or v.Name == "Crossbow Cultist" or v.Name == "Shadow Cultist" or v.Name == "Frog" or v.Name == "Brutal Cultist"  then
        local Dis = (LocalPlayer.Character.HumanoidRootPart.Position - v:GetPivot().Position).Magnitude
        
        if Dis < Options.KillAuraRange.Value then
          if LocalPlayer:FindFirstChild("Inventory"):FindFirstChild("Old Axe") then
            local args = {
            v,
            LocalPlayer:FindFirstChild("Inventory"):FindFirstChild("Old Axe"),
            math.random(1, 100) .. "_10012952131",
            LocalPlayer.Character.HumanoidRootPart.CFrame
          }
          game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(unpack(args))
          
        elseif LocalPlayer:FindFirstChild("Inventory"):FindFirstChild("Good Axe") then
          local args = {
          v,
          LocalPlayer:FindFirstChild("Inventory"):FindFirstChild("Good Axe"),
          math.random(1, 100) .. "_10012952131",
          LocalPlayer.Character.HumanoidRootPart.CFrame
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(unpack(args))
      elseif LocalPlayer:FindFirstChild("Inventory"):FindFirstChild("Strong Axe") then
        local args = {
        v,
        LocalPlayer:FindFirstChild("Inventory"):FindFirstChild("Strong Axe"),
        math.random(1, 100) .. "_10012952131",
        LocalPlayer.Character.HumanoidRootPart.CFrame
      }
      game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(unpack(args))
      
      
    end
  end
end
end

end
end
if Toggles.TreeAura.Value then
  if TreeAuraDelay > 0.3 then
    TreeAuraDelay = 0
    for _, v in pairs(workspace.Map.Foliage:GetChildren()) do
      if not Toggles.TreeAura.Value then return end
      if string.match(v.Name, "Tree") or string.match(v.Name, "Pine")  then
        local Dis = (LocalPlayer.Character.HumanoidRootPart.Position - v:GetPivot().Position).Magnitude
        if Dis < Options.TreeAuraRange.Value then
          if LocalPlayer:FindFirstChild("Inventory"):FindFirstChild("Old Axe") then
            local args = {
            v,
            LocalPlayer:FindFirstChild("Inventory"):FindFirstChild("Old Axe"),
            math.random(1, 100) .. "_10012952131",
            LocalPlayer.Character.HumanoidRootPart.CFrame
          }
          game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(unpack(args))
          
        elseif LocalPlayer:FindFirstChild("Inventory"):FindFirstChild("Good Axe") then
          local args = {
          v,
          LocalPlayer:FindFirstChild("Inventory"):FindFirstChild("Good Axe"),
          math.random(1, 100) .. "_10012952131",
          LocalPlayer.Character.HumanoidRootPart.CFrame
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(unpack(args))
      elseif LocalPlayer:FindFirstChild("Inventory"):FindFirstChild("Strong Axe") then
        local args = {
        v,
        LocalPlayer:FindFirstChild("Inventory"):FindFirstChild("Strong Axe"),
        math.random(1, 100) .. "_10012952131",
        LocalPlayer.Character.HumanoidRootPart.CFrame
      }
      game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(unpack(args))
      
    end
  end
end
end
end

end
if Toggles.NoFog.Value and Lighting.FogEnd ~= 500000 then
  Lighting.FogEnd = 500000
end

if Toggles.FullBright.Value then
  if  Lighting.Brightness ~= 5 then
    Lighting.Brightness = 5
  end
  if Lighting.GlobalShadows ~= false then
    Lighting.GlobalShadows = false
  end
end

if Toggles.InfSapling.Value then
  if Options.SaplingPlace.Value == "Player" then
    local args = {
    workspace:FindFirstChild("Items"):FindFirstChild("Sapling"),
    LocalPlayer.Character.HumanoidRootPart.Position
  }
  game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestPlantItem"):InvokeServer(unpack(args))
elseif Options.SaplingPlace.Value == "Campfire" then
  local args = {
  workspace:FindFirstChild("Items"):FindFirstChild("Sapling"),
  workspace.Map.Campground.MainFire:GetPivot().Position
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestPlantItem"):InvokeServer(unpack(args))
elseif Options.SaplingPlace.Value == "Scarp-Machine" then
  local args = {
  workspace:FindFirstChild("Items"):FindFirstChild("Sapling"),
  workspace.Map.Campground.Scrapper.Movers.Right.GrindersRight.Position + Vector3.new(0, 2, 0)
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestPlantItem"):InvokeServer(unpack(args))

end
end

end))
table.insert(Connections,workspace.DescendantAdded:Connect(function(v)
if v:IsA("ProximityPrompt") and Toggles.InstantPr.Value then
  v:SetAttribute("Duration",v.HoldDuration)
  v.HoldDuration = 0
end

end))
local MenuGroup = Tabs.Settings:AddLeftGroupbox('脚本界面')
local UtilityBox = Tabs.Settings:AddRightGroupbox('脚本作者')

MenuGroup:AddLabel("Menu bind"):AddKeyPicker("菜单快捷按键", { Default = "RightShift", NoUI = true, Text = "菜单快捷按键" })
Library.ToggleKeybind = Options.MenuKeybind

MenuGroup:AddToggle("ShowKeybinds", { Text = "显示菜单列表", Default = false }):OnChanged(function()
Library.KeybindFrame.Visible = Toggles.ShowKeybinds.Value
end)
MenuGroup:AddToggle("ShowCustomCursor", {
Text = "自定义鼠标",
Default = true,
Callback = function(Value)
Library.ShowCustomCursor = Value
end,
})
MenuGroup:AddDivider()
MenuGroup:AddToggle('PlayNotifySound',{
Text = "播放提示音效",
Default = true,
Callback = function(Value)
PlaySound = Value
end
})
MenuGroup:AddDropdown("NotificationSide", {
Values = { "左侧", "右侧" },
Default = "左侧",

Text = "提示位置",

Callback = function(Value)
Library:SetNotifySide(Value)
end,
})
MenuGroup:AddButton('测试提示',function()
Notify("Hello World",2)

end)
MenuGroup:AddDivider()
MenuGroup:AddDropdown("DPIDropdown", {
Values = { "50%", "75%", "80%", "100%", "125%", "150%", "200%" },
Default = "，100%",

Text = "界面缩放",

Callback = function(Value)
Value = Value:gsub("%%", "")
local DPI = tonumber(Value)

Library:SetDPIScale(DPI)
end,
})
UtilityBox:AddLabel('TheHunterSolo1 - 作者与主程序员',true)

UtilityBox:AddButton({
Text = "卸载脚本",
Func = function()
game.Players.LocalPlayer:SetAttribute("SupremeLoaded", nil)
for _, con in pairs(Connections) do con:Disconnect() end

Library:Unload()
ESPLibrary:Unload()
end
})

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder("SupremeHub")
SaveManager:SetFolder("SupremeHub/99-NightsinForest")
SaveManager:BuildConfigSection(Tabs['Settings'])
ThemeManager:ApplyToTab(Tabs['Settings'])

Notify("加载完成 |  99夜",4)


end
if ReplicatedStorage:FindFirstChild("EntityInfo") or ReplicatedStorage:FindFirstChild("RemotesFolder") or ReplicatedStorage:FindFirstChild("Bricks") then
  
  repeat task.wait() until LocalPlayer.Character
    
    if   getgenv().ScriptLibrary ~= "Linoria" then
      getgenv().ScriptLibrary = getgenv().ScriptLibrary or "Linoria"
    end
    
    local repo = getgenv().ScriptLibrary == "Obsidian" and 'https://raw.githubusercontent.com/mstudio45/Obsidian/main/' or getgenv().ScriptLibrary == "Linoria" and 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
    
    local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
    local NotifyLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Msdoors/Msdoors.gg/refs/heads/main/Scripts/Msdoors/Notification/Source.lua"))()
    task.wait()
    local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
    local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
    local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheHunterSolo1/Scripts/main/ESPLibrary"))() -- Loading the library
    
    local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/projects/refs/heads/main/UI/NotificationLibrary/Source.luau"))()
    local NotificationHandler = NotificationLibrary:New({
    BackgroundColor = Color3.fromRGB(100, 100, 100), -- background color of the notification
    -- TitleColor = Color3.fromRGB(), -- title text color
    -- DescriptionColor = Color3.fromRGB(), -- description text color
    -- Mode = "Light", -- either "Dark" or "Light" | very important to set this so it looks better
    VerticalPosition = "Top", -- either "Top" or "Bottom"
    HorizontalPosition = "Right", -- either "Right" or "Left"
  })
  
  
  
  
  
  
  
  local Options = Library.Options
  local Toggles = Library.Toggles
  local Connections = {}
  local Window = Library:CreateWindow({
  Title = LibraryName,
  Center = true,
  ToggleKeybind = Enum.KeyCode.RightControl,
  AutoShow = true,
  NotifySide = "Right",
  ShowCustomCursor = true,
})
local Notifying = "Library"
local PlaySound = true
local function Notify(txt,duration)
  if Notifying == "Library" then
    Library:Notify(txt, duration)
    
  elseif Notifying == "Doors" then
    
    
    NotifyLibrary({
    Title = LibraryName,
    Description = txt,
    Reason = "",
    Image = "rbxassetid://6023426923",
    Color = Color3.fromRGB(0, 162, 255),
    Style = "EVENT",
    Duration = duration,
    NotifyStyle = "Doors",
  })
  
  
elseif Notifying == "Supreme" then
  NotificationHandler:Create({
  Title = "脚本",
  Description = txt,
  Duration = duration,
  Image = "",
})



end

if PlaySound then
  local Sound = Instance.new("Sound",game:GetService("SoundService"))
  Sound.SoundId = "rbxassetid://101511361468852"
  
  Sound.PlaybackSpeed = 0.77
  Sound.Volume = 2
  Sound:Play()
  game:GetService("Debris"):AddItem(Sound, 3)
end

end


function AddESP(part,txt,color)
  
  
  ESPLibrary:AddESP({
  Object = part, -- The object you want to highlight
  Text = txt, -- What you want the text to say,
  Color = color -- The color of the esp to set.
})

end
function AddEntityESP(part,txt,color)
  if part:IsA("Model") then
    while not part.PrimaryPart do
      for _, v in pairs(part:GetChildren()) do
        if v:IsA("BasePart") then
          part.PrimaryPart = v
        end
      end
      task.wait()
    end
    if part.PrimaryPart then
      part.PrimaryPart.Transparency = 0.99
    end
    if not part:FindFirstChildOfClass("Humanoid") then
      Instance.new("Humanoid",part)
    end
  end
  
  if part.Name == "FigureRig" or part.Name == "FigureRagdoll" then
    
    part:WaitForChild("Root").Size = Vector3.new(0.001, 0.001, 0.001)
  end
  ESPLibrary:AddESP({
  Object = part, -- The object you want to highlight
  Text = txt, -- What you want the text to say,
  Color =  color, --The color of the esp to set.
})

end


function GetLibraryCode()
  local CodeLength = game.ReplicatedStorage.GameData.Floor.Value == "Fools" and 10 or 5
  local Slot = table.create(CodeLength, "_")
  local Paper
  
  for _, plr in pairs(Players:GetPlayers()) do
    local char = plr.Character
    if char then
      Paper = char:FindFirstChild("LibraryHintPaper") or char:FindFirstChild("LibraryHintPaperHard") or
      plr.Backpack:FindFirstChild("LibraryHintPaper") or plr.Backpack:FindFirstChild("LibraryHintPaperHard")
      if Paper then break end
    end
  end
  
  if not Paper then return table.concat(Slot) end
  
  local Hints = LocalPlayer.PlayerGui.PermUI.Hints:GetChildren()
  
  for _, i in pairs(Paper.UI:GetChildren()) do
    if i:IsA("ImageLabel") and i.Name ~= "Image" then
      local Pos = tonumber(i.Name)
      if Pos and Slot[Pos] then
        for _, v in pairs(Hints) do
          if v.Name == "Icon" and v.ImageRectOffset.X == i.ImageRectOffset.X then
            local Label = v:FindFirstChild("TextLabel")
            if Label then
              Slot[Pos] = Label.Text
            end
            break
          end
        end
      end
    end
  end
  
  return table.concat(Slot)
end

if workspace:FindFirstChild("Lobby") then
  
  
  local Tabs = {
  Home = Window:AddTab('主页', 'house'),
  Main = Window:AddTab('游戏', "star"),
  Settings = Window:AddTab('设置',"settings"),
}


local HomeBox = Tabs.Home:AddLeftGroupbox('主页')

local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)

HomeBox:AddImage("PlayerFace", {
Image = content,
Height = 200,
})

HomeBox:AddDivider()
HomeBox:AddLabel('执行次数 ' .. (tonumber(executionCount) and tonumber(executionCount) >= 1 and executionCount or "Nan"))


local Tp = Tabs.Main:AddLeftGroupbox("传送")
Tp:AddLabel('无进度', true)
Tp:AddButton("传送至酒店", function()



local Event = game:GetService("ReplicatedStorage").RemotesFolder.CreateElevator
Event:FireServer(
{
  Mods = {
  "AdminPanel"
},
Settings = {},
Destination = "Hotel",
FriendsOnly = false,
MaxPlayers = "1"
}
)


end)


Tp:AddButton("传送至矿井", function()



local Event = game:GetService("ReplicatedStorage").RemotesFolder.CreateElevator
Event:FireServer(
{
  Mods = {
  "AdminPanel"
},
Settings = {},
Destination = "Mines",
FriendsOnly = false,
MaxPlayers = "1"
}
)


end)


Tp:AddButton("传送至Rooms", function()



local Event = game:GetService("ReplicatedStorage").RemotesFolder.CreateElevator
Event:FireServer(
{
  Mods = {
  "AdminPanel"
},
Settings = {},
Destination = "Rooms",
FriendsOnly = false,
MaxPlayers = "1"
}
)


end)
Tp:AddButton("传送至Backdoor", function()



local Event = game:GetService("ReplicatedStorage").RemotesFolder.CreateElevator
Event:FireServer(
{
  Mods = {
  "AdminPanel"
},
Settings = {},
Destination = "Backdoor",
FriendsOnly = false,
MaxPlayers = "1"
}
)


end)

Tp:AddButton("传送至户外[花园]", function()



local Event = game:GetService("ReplicatedStorage").RemotesFolder.CreateElevator
Event:FireServer(
{
  Mods = {
  "AdminPanel"
},
Settings = {},
Destination = "Outdoors",
FriendsOnly = false,
MaxPlayers = "1"
}
)


end)

local MenuGroup = Tabs.Settings:AddLeftGroupbox('脚本界面')
local UtilityBox = Tabs.Settings:AddRightGroupbox('脚本作者')

MenuGroup:AddLabel("Menu bind"):AddKeyPicker("菜单快捷键", { Default = "RightShift", NoUI = true, Text = "菜单快捷键" })
Library.ToggleKeybind = Options.MenuKeybind

MenuGroup:AddToggle("ShowKeybinds", { Text = "显示快捷键列表", Default = false }):OnChanged(function()
Library.KeybindFrame.Visible = Toggles.ShowKeybinds.Value
end)
MenuGroup:AddToggle("ShowCustomCursor", {
Text = "自定义鼠标",
Default = true,
Callback = function(Value)
Library.ShowCustomCursor = Value
end,
})
MenuGroup:AddDivider()
MenuGroup:AddToggle('PlayNotifySound',{
Text = "播放提示音效",
Default = true,
Callback = function(Value)
PlaySound = Value
end
})
MenuGroup:AddDropdown("NotificationSide", {
Values = { "左侧", "右侧" },
Default = "左侧",

Text = "提示位置",

Callback = function(Value)
Library:SetNotifySide(Value)
end,
})

MenuGroup:AddDropdown("NotifyWay", {
Values = { "Doors", "Library"},
Default = Notifying,

Text = "提示样式库",

Callback = function(Value)
Notifying = Value
end,
})

MenuGroup:AddButton('测试提示',function()
Notify("Hello World",2)

end)

MenuGroup:AddDropdown("Library", {
Values = { "Obsidian", "Linoria" },
Default = 2,

Text = "界面库",

Callback = function(Value)
getgenv().ScriptLibrary = tostring(Value)
Notify('卸载脚本UI后再次执行生效',4)
end,
})

MenuGroup:AddDivider()
MenuGroup:AddDropdown("DPIDropdown", {
Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
Default = "100%",

Text = "界面缩放",

Callback = function(Value)
Value = Value:gsub("%%", "")
local DPI = tonumber(Value)

Library:SetDPIScale(DPI)
end,
})
UtilityBox:AddLabel('TheHunterSolo1 - 作者与主程序员',true)


-- Sets the draggable label visibility

UtilityBox:AddLabel('rhyan57 - Doors提示框作者',true)
UtilityBox:AddLabel('FireBacon - ESP库作者',true)
UtilityBox:AddButton({
Text = "卸载脚本",
Func = function()
LocalPlayer:SetAttribute("SupremeLoaded", nil)
for _, con in pairs(Connections) do con:Disconnect() end


Library:Unload()
ESPLibrary:Unload()

end
})

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder("SupremeHub")
SaveManager:SetFolder("SupremeHub/DOORSLOBBY")
SaveManager:BuildConfigSection(Tabs['设置'])
ThemeManager:ApplyToTab(Tabs['设置'])

Notify("加载完成 | DOORS 大厅 ",4)


else
  
  
  local function GetDistanceToPlayer(Pos)
    local DisA = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position or workspace.CurrentCamera and workspace.CurrentCamera.CFrame.Position or Vector3.new(0, 0, 0)
    
    local Dis = (DisA - Pos).Magnitude
    return Dis
    
  end
  
  local PathFolder = Instance.new("Folder",workspace)
  PathFolder.Name = "PathFolder"
  
  
  
  
  
  
  function PathTo(Pos)
    
    
    local Character = LocalPlayer.Character
    local Root = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChild("Humanoid")
    if not Root or not Humanoid then return end
    
    
    local p = PathfindingService:CreatePath({
    AgentRadius = 2,
    AgentHeight = 5,
    AgentCanJump = true,
    WaypointSpacing = 2,
    AgentCanSprint = false,
    AgentMaxSlope = 45,
    AgentJumpHeight = 0
  })
  local AdjustedPos = Pos and Pos +Vector3.new(0, 0, 1)
  
  p:ComputeAsync(Root.Position, AdjustedPos)
  
  if  p.Status ~= Enum.PathStatus.Success then return end
  
  
  
  for _, waypoint in ipairs(p:GetWaypoints()) do
    if not Toggles.AutoRooms.Value or Library.Unloaded then break end
    
    
    
    
    
    
    
    
    
    local Dist = (Root.Position - waypoint.Position).Magnitude
    if Dist >= 2 then
      Humanoid:MoveTo(waypoint.Position)
      
      
      
      Humanoid.MoveToFinished:Wait()
      
      
      
      
      
      
      
      
      
    end
  end
end




AutoClosetTable = {
RushMoving = 150,
AmbushMoving = 190,
A60 = 210,
A120 = 120,
GlitchRush = 150,
GlitchAmbush = 190,
BackdoorRush = 160,
}



InfCrucfixTable = {
RushMoving = 90,
AmbushMoving = 160,
A60 = 140,
A120 = 99,
GlitchRush = 150,
GlitchAmbush = 110,
}



local Firepp = ExecutorSupport.fireproximityprompt
local Require = ExecutorSupport.require
local ReplicateSignal = ExecutorSupport.replicatesignal
local FireTouch = ExecutorSupport.firetouchinterest
local HookMeta = ExecutorSupport.hookmetamethod
local IsNetworkOwner = ExecutorSupport.isnetworkowner
Items = {
["Bandage"] = "绷带",
["Flashlight"] = "手电筒",
["Battery"] = "电池",
["BatteryPack"] = "电池包",
["SkeletonKey"] = "骷髅钥匙",
["Crucifix"] = "十字架",
["Straplight"] = "肩带灯",
["Lockpick"] = "开锁器",
["Bulklight"] = "大灯",
["Vitamins"] = "维生素",
["Shears"] = "剪刀",
["LaserPointer"] = "激光笔",
["Candle"] = "蜡烛",
["Smoothie"] = "冰沙",
["StarJug"] = "水瓶",
["StardustPickup"] = "星尘",
["ChestBoxLocked"] = "上锁宝箱",
["ChestBox"] = "宝箱",
["Chest_Vine"] = "藤蔓宝箱",
["Toolbox_Locked"] = "上锁工具箱",
["Toolshed_Small"] = "工具棚",
["TimerLever"] = "拉杆",
["HolyGrenade"] = "圣手榴弹",
["ShieldMini"] = "小型护盾",
["ShieldBig"] = "大型护盾",
["CrucifixWall"] = "十字架",
["Glowsticks"] = "荧光棒",
["BandagePack"] = "绷带包",
["AlarmClock"] = "闹钟",
["MinesGenerator"] = "发电机",
["MinesGateButton"] = "门按钮",
["MouseHole"] = "老鼠洞",
["StarVial"] = "星瓶",
["StarBottle"] = "星瓶",
["Compass"] = "指南针",
["Lantern"] = "灯笼",
["KeyIron"] = "铁钥匙",
["GoldGun"] = "金枪",
["Candy"] = "糖果",
["WaterPump"] = "水泵",
["VineGuillotine"] = "藤蔓闸刀",
["Shakelight"] = "摇摇灯",
["LibraryHintPaper"] = "提示纸",
["LotusPetalPickup"] = "莲花瓣",
}


local Floor = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("Floor")

local LatestRoom = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")

local MainGame = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI").Initiator:WaitForChild("Main_Game")
local RemoteListener = MainGame:WaitForChild("RemoteListener")

local RequiredMainGame

local ClientModules = ReplicatedStorage:FindFirstChild("ModulesClient") or ReplicatedStorage:FindFirstChild("ClientModules")

local RemotesFolder = ReplicatedStorage:FindFirstChild("EntityInfo") and ReplicatedStorage:FindFirstChild("EntityInfo")  or ReplicatedStorage:FindFirstChild("Bricks")  and ReplicatedStorage:FindFirstChild("Bricks") or ReplicatedStorage:FindFirstChild("RemotesFolder")
local MotorReplication = RemotesFolder:WaitForChild("MotorReplication")
local CollisionClone
local CamLock = RemotesFolder:WaitForChild("CamLock")

local AnchorArgs
local PL = RemotesFolder:WaitForChild("PL")
local ClutchHeartbeat = RemotesFolder:WaitForChild("ClutchHeartbeat")


local params = RaycastParams.new()
params.FilterDescendantsInstances = {LocalPlayer.Character}




local  SeekPath = Instance.new("Folder",workspace)
SeekPath.Name = "SeekPath"






function ShowSeekPath(v)
  local Part = Instance.new("Part", SeekPath)
  Part.Size = Vector3.new(1.5, 1.5, 1.5)
  Part.Anchored = true
  Part.Shape = "Ball"
  Part.Position = v.Position
  Part.CanCollide = false
  Part.Color = Color3.new(0, 1, 0)
  Debris:AddItem(Part, 60)
  
  
end



function FixBridge(v)
  
  for _, i in pairs(v:GetChildren()) do
    if i.Name == "PlayerBarrier" and i.Rotation.X == 180 then
      local Barrier = i:Clone()
      
      Barrier.CFrame = CFrame.new(i.Position.X, i.Position.Y, i.Position.Z)
      Barrier.CFrame = Barrier.CFrame * CFrame.new(0, -7, 0)
      
      Barrier.Size = Vector3.new(40, 0.1, 40)
      Barrier.Transparency = 0.5
      Barrier.Color = Color3.new(0.5, 0, 0.5)
      Barrier.Material = "ForceField"
      Barrier.Parent = v
      Barrier.Name = "BridgeBarrier"
      Barrier.Anchored = true
      Barrier.CanCollide = true
    end
  end
end




if Require then
  RequiredMainGame = require(MainGame)
end



local getcons = getconnections or get_signal_cons or get_relative_connections

if getcons then
  for _, con in pairs(getcons(LocalPlayer.Idled)) do
    if con.Disable then
      con:Disable()
    end
  end
end



table.insert(Connections,LocalPlayer.CharacterAdded:Connect(function()


task.wait(1.5)
if LocalPlayer.Character then
  MainGame = LocalPlayer.PlayerGui.MainUI.Initiator:WaitForChild("Main_Game")
  RemoteListener = MainGame.RemoteListener
  
  
  params.FilterDescendantsInstances = {LocalPlayer.Character}
  
  
  if Toggles.NoScenes.Value then
    local Cutscene = RemoteListener:FindFirstChild("Cutscenes") or RemoteListener:FindFirstChild("Cutscenes_")
    Cutscene.Name = "Cutscenes_"
  end
  
  if Require then
    RequiredMainGame = require(MainGame)
  end
  
end


if Toggles.Jamming.Value then
  
  if  ReplicatedStorage:FindFirstChild("LiveModifiers") and ReplicatedStorage:FindFirstChild("LiveModifiers"):FindFirstChild("Jammin") then
    local Jam = LocalPlayer.PlayerGui.MainUI.Initiator:FindFirstChild("Main_Game").Health.Jam
    Jam.Playing = false
    local Jamming = game:GetService("SoundService").Main.Jamming
    Jamming.Enabled =  false
  end
  
end





if Toggles.Godmode.Value and RemotesFolder.Name ~= "RemotesFolder" then
  LocalPlayer.Character.Collision.Position -= Vector3.new(0, 4, 0)
end


if Toggles.Dread.Value then
  
  local Dread = LocalPlayer:FindFirstChild("Dread",true) or LocalPlayer:FindFirstChild("_Dread",true)
  
  if Dread then
    Dread.Name = "_Dread"
  end
  
end

if Toggles.Halt.Value then
  
  local Dread = ClientModules.EntityModules:FindFirstChild("Shade",true) or ClientModules.EntityModules:FindFirstChild("_Shade",true)
  
  if Dread then
    Dread.Name = "_Shade"
  end
end

end))



local Tabs = {
Home = Window:AddTab('主页', 'house'),
Main = Window:AddTab('玩家', "star"),
Bypass = Window:AddTab('绕过', "ban"),
Visuals = Window:AddTab('ESP',"eye"),
Floor = Window:AddTab('楼层', "sparkles"),
Settings = Window:AddTab('设置',"settings"),
}

local PlayerBox = Tabs.Main:AddLeftGroupbox('玩家')
local GameBox = Tabs.Main:AddLeftGroupbox('游戏')
local HotelFloor = Tabs.Floor:AddLeftGroupbox('酒店')
local MinesFloor = Tabs.Floor:AddRightGroupbox('矿山')
local FoolsFloor = Tabs.Floor:AddRightGroupbox('愚人节')
local RoomsFloor = Tabs.Floor:AddLeftGroupbox('rooms')
local RetroFloor = Tabs.Floor:AddLeftGroupbox('复古')





local HomeBox = Tabs.Home:AddLeftGroupbox('主页')

local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)

HomeBox:AddImage("PlayerFace", {
Image = content,
Height = 200,
})

HomeBox:AddDivider()
HomeBox:AddLabel('执行次数 ' .. (tonumber(executionCount) and tonumber(executionCount) >= 1 and executionCount or "Nan"))



local AutoBox = Tabs.Main:AddRightGroupbox('自动')

local ReachBox = Tabs.Main:AddRightGroupbox('范围')

local CameraBox = Tabs.Visuals:AddLeftGroupbox('视觉')


local LightingBox = Tabs.Visuals:AddLeftGroupbox('光照')

local ESPBox = Tabs.Visuals:AddRightGroupbox('ESP')

local ESPSettings = Tabs.Visuals:AddRightGroupbox('设置')


local NotifyBox = Tabs.Visuals:AddRightGroupbox('提示')
local BypassEntityBox = Tabs.Bypass:AddLeftGroupbox('实体绕过')

local BypassBox = Tabs.Bypass:AddRightGroupbox('绕过')







RetroFloor:AddToggle('AntiLava',{
Text = "无视岩浆",
Default = false,
Disabled = Floor.Value ~= "Retro" and true or false,
Callback = function(Value)
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
  if v.Name == "Lava" then
    v.CanTouch = not Value
  end
end

end
})

FoolsFloor:AddToggle('AntiBanana',{
Text = "无视香蕉皮",
Default = false,
Disabled = Floor.Value ~= "Fools" and true or false,
Callback = function(Value)
for _, v in pairs(workspace:GetChildren()) do
  if v.Name == "BananaPeel" then
    v.CanTouch = not Value
  end
end

end
})



FoolsFloor:AddToggle('AntiJeff',{
Text = "防Jeff",
Default = false,
Disabled = Floor.Value ~= "Fools" and true or false,
Callback = function(Value)
local v = workspace:FindFirstChild("JeffTheKiller")
if v.Name == "JeffTheKiller" then
  repeat task.wait() until v.PrimaryPart and isnetworkowner(v.PrimaryPart)
    for _, i in pairs(v:GetChildren()) do
      if i:IsA("BasePart") then
        i.CanTouch = Value and false or true
      end
    end
    v.Humanoid.Health = Value and 0 or 100
  end
end
})







GameBox:AddButton({
Text = "复活",
DoubleClick = true,
Func = function()
RemotesFolder.Revive:FireServer()
end
})


GameBox:AddButton({
Text = "重新开局",
DoubleClick = true,
Func = function()
RemotesFolder.PlayAgain:FireServer()
end
})




local Pressed = false
GameBox:AddButton({
Text = "重置人物",
DoubleClick = true,
Func = function()
Pressed = not Pressed

if not Pressed then
  if RemotesFolder:FindFirstChild("Underwater") then
    RemotesFolder.Underwater:FireServer(false)
  end
  return
end

if ReplicateSignal then
  replicatesignal(LocalPlayer.Kill)
else
  Notify("双击可停止", 5)
  task.spawn(function()
  while Pressed and LocalPlayer:GetAttribute("Alive") ~= false do
    if RemotesFolder:FindFirstChild("Underwater") then
      RemotesFolder.Underwater:FireServer(true)
    end
    task.wait()
  end
  
  if RemotesFolder:FindFirstChild("Underwater") then
    RemotesFolder.Underwater:FireServer(false)
  end
  Pressed = false
end)
end
end
})



GameBox:AddButton({
Text = "大厅",
DoubleClick = true,
Func = function()
RemotesFolder.Lobby:FireServer()
end
})

FoolsFloor:AddToggle('InfRevive',{
Text = "无限复活",
Disabled = Floor.Value ~= "Fools" and RemotesFolder.Name ~= "Bricks" and true or false,
Default = false
})



FoolsFloor:AddToggle('DeleteSeekFE',{
Text = "删除 Seek (FE)",
Default = false,
Disabled = Floor.Value ~= "Fools" and RemotesFolder.Name ~= "Bricks"   and true or false,
Callback = function(Value)
if Value then
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "TriggerEventCollision" then
      
      Notify("正在删除 Seek",3)
      
      for _, i  in pairs(v:GetChildren()) do
        if i.Name == "Collision" then
          if FireTouch then
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, i, 0)
          end
        end
      end
      
      task.wait(0.5)
      if v:FindFirstChild("Collision") then
        Notify("删除失败", 3)
      else
        Notify("删除成功", 3)
      end
      
    end
  end
end
end
})

RetroFloor:AddToggle('AntiWall',{
Text = "防Seek障碍",
Default = false,
Disabled = Floor.Value ~= "Retro" and true or false,
Callback = function(Value)
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
  if v.Name == "ScaryWall" then
    for _, i in pairs(v:GetChildren()) do
      if i:IsA("BasePart") then
        i.CanTouch = not Value
      end
      
    end
  end
  
end

end
})


RetroFloor:AddToggle('RealBridge',{
Text = "显示桥梁",
Default = false,
Disabled = Floor.Value ~= "Retro" and true or false,
Callback = function(Value)
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
  if v.Name == "Bridge" then
    if v.CanCollide == false then
      v.Transparency = Value and 1 or 0
    end
    
  end
  
end

end
})

local Figures = {}
MinesFloor:AddToggle('DeleteFigureFE',{
Text = "删除 Figure (FE)",
Default = false,
Disabled = Floor.Value ~= "Mines" and   RemotesFolder.Name ~= "Bricks" and true or false,
Callback = function(Value)

for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
  if v.Name == "FigureRig" or v.Name == "FigureRagdoll" then
    table.insert(Figures,v)
  end
end

end
})










MinesFloor:AddToggle('ShowPath',{
Text = "Seek追逐战显示路径",
Default = false,
Disabled = Floor.Value ~= "Mines" and true or false,
Callback = function(Value)
if Value then
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "SeekGuidingLight" then
      ShowSeekPath(v)
    end
  end
else
  SeekPath:ClearAllChildren()
  
  
end
end
})


MinesFloor:AddToggle('FixBrokenBridge',{
Text = "修补断桥",
Default = false,
Disabled = Floor.Value ~= "Mines" and true or false,
Callback = function(Value)
if Value then
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "Bridge" then
      FixBridge(v)
    end
  end
else
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "BridgeBarrier" then
      v:Destroy()
    end
  end
end
end
})
local DuckBoards = {}
local Nodes = {}

if Require then
  local Control = require(LocalPlayer.PlayerScripts.PlayerModule):GetControls().GetMoveVector
end
MinesFloor:AddToggle('AutoMinecart',{
Text = "自动矿车",
Risky = true,
Default = false,

Disabled =  Floor.Value ~= "Mines" and true or false,
Callback = function(Value)
if Value then
  for _, v in workspace.CurrentRooms:GetDescendants() do
    if v.Name == "DuckBoard" then
      table.insert(DuckBoards, v)
    end
    if string.find(v.Name, "MinecartNode") then
      table.insert(Nodes, v)
    end
    
  end
  
else
  require(LocalPlayer.PlayerScripts.PlayerModule):GetControls().GetMoveVector = Control
  table.clear(Nodes)
  table.clear(DuckBoards)
end
end
})


local Anchors = {}



MinesFloor:AddToggle('AutoAnchorSolver',{
Text = "自动锚点",
Default = false,
Disabled = Floor.Value ~= "Mines" and true or false,
Callback = function(Value)
if Value then
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "MinesAnchor" then
      table.insert(Anchors,v)
    end
  end
end
end
})


MinesFloor:AddToggle('AntiSeekFlood',{
Text = "无视Seek洪水",
Default = false,
Disabled = Floor.Value ~= "Mines" and true or false,
Callback = function(Value)
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
  if v.Name == "SeekFloodline" then
    v.CanCollide = Value
  end
end
end
})





RoomsFloor:AddToggle('AutoRooms',{
Text = "自动 A-1000",
Disabled = Floor.Value ~= "Rooms" and true or false,
Default = false,
Callback = function(Value)

if not Value then
  
  
  PathFolder:ClearAllChildren()
  if LocalPlayer.Character then
    LocalPlayer.Character.Collision.Size = Vector3.new(5.5,3,3)
    LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position)
    PathActive = false
  end
  
end




end
})

if (getrawmetatable or debug.getmetatable) and (setreadonly or make_writeable) and newcclosure then
  local getmt = getrawmetatable or debug.getmetatable
  local setro = setreadonly or (make_writeable and function(t, b) if b then make_writeable(t) else make_readonly(t) end end)
  
  local mt = getmt(game)
  local oldIndex = mt.__index
  
  setro(mt, false)
  
  mt.__index = newcclosure(function(t, k)
  if not checkcaller() and k == "MoveDirection" and t:IsA("Humanoid") then
    local char = LocalPlayer.Character
    if char and Toggles.AutoRooms.Value and not char:GetAttribute("Hiding") then
      return Vector3.new(0, 0, 1)
    end
  end
  return oldIndex(t, k)
end)

setro(mt, true)
end



RoomsFloor:AddToggle('IgnoreA60',{
Text = "防 A-60",
Disabled = Floor.Value ~= "Rooms" and true or false,
})







ESPSettings:AddToggle('ShowDistance',{
Text = "显示距离",
Default = true,
Callback = function(Value)
ESPLibrary:SetShowDistance(Value)
end
})

ESPSettings:AddToggle('ShowTracers',{
Text = "显示射线",
Default = true,
Callback = function(Value)
ESPLibrary:SetTracers(Value)
end
})




ESPSettings:AddToggle('ShowRainbow',{
Text = "彩色渐变",
Default = false,
Callback = function(Value)
ESPLibrary:SetRainbow(Value)
end
})




ESPSettings:AddDropdown("SetESPMode", {
Text = "ESP显示模式",
Values = {"高亮/文字", "文字", "高亮"},

Default = 1,
Multi = false,
Callback = function(Value)
ESPLibrary:SetESPMode(Value)
end
})




ESPSettings:AddDropdown("SetFont", {
Text = "ESP文字字体",
Values = {
"Legacy", "Arial", "ArialBold", "SourceSans", "SourceSansBold",
"SourceSansLight", "SourceSansItalic", "Bodoni", "Garamond",
"Cartoon", "Code", "Highway", "SciFi", "Arcade", "Fantasy",
"Antique", "Gotham", "GothamMedium", "GothamBold", "GothamBlack",
"AmaticSC", "Bangers", "Creepster", "DenkOne", "FredokaOne",
"IndieFlower", "LuckiestGuy", "Michroma", "Nunito", "Oswald",
"PatrickHand", "PermanentMarker", "Roboto", "RobotoCondensed",
"RobotoMono", "Sarpanch", "SpecialElite", "TitilliumWeb", "Ubuntu"
},

Default = 35,
Multi = false,
Callback = function(Value)
ESPLibrary:SetFont(Value)
end
})


PlayerBox:AddSlider("MovementSpeed", {
Text = "移动速度",
Default = 15,
Min = 15,
Max = 21,
Rounding = 1,
Compact = false,

Callback = function(Value)
end,

Tooltip = "行走速度",
})

PlayerBox:AddToggle('EnableMovementSpeed',{
Text = "启用移速",
Default = false,
Callback = function(Value)
if not Value then
  LocalPlayer.Character.Humanoid.WalkSpeed = 15
  
end
end
})

PlayerBox:AddSlider("ClimbingSpeed", {
Text = "攀爬速度",
Default = 15,
Min = 15,
Max = 30,
Rounding = 1,
Compact = false,

Callback = function(Value)
end,

Tooltip = "攀爬速度",
})

PlayerBox:AddToggle('EnableClimbingSpeed',{
Text = "启用攀爬速度",
Default = false,
Callback = function(Value)
if not Value then
  LocalPlayer.Character.Humanoid.WalkSpeed = 15
  
end
end
})

PlayerBox:AddDivider()

local OldAccel
PlayerBox:AddToggle('NoAcc',{
Text = "防滑",
Default = false,
Callback = function(Value)
if Value then
  OldAccel = LocalPlayer.Character.HumanoidRootPart.CustomPhysicalProperties
else
  if OldAccel then
    LocalPlayer.Character.HumanoidRootPart.CustomPhysicalProperties = OldAccel
    OldAccel = nil
  end
end
end
})
PlayerBox:AddToggle('NoClip',{
Text = "穿墙模式",
Default = false,
Tooltip = "你可以穿过墙壁",
Callback = function(Value)
if not Value then
  for _, v in pairs(LocalPlayer.Character:GetChildren()) do
    if not v.Name == "CollisionClone" then
      if v:IsA("BasePart") then
        v.CanCollide  = true
      end
    end
  end
  
end
end
}):AddKeyPicker("NoclipKeybind", {
-- SyncToggleState only works with toggles.
-- It allows you to make a keybind which has its state synced with its parent toggle

-- Example: Keybind which you use to toggle flyhack, etc.
-- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

Default = "N", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
SyncToggleState = true,

-- You can define custom Modes but I have never had a use for it.
Mode ="Toggle" , -- Modes: Always, Toggle, Hold, Press (example down below)

Text = "穿墙模式", -- Text to display in the keybind menu
NoUI = false, -- Set to true if you want to hide from the Keybind menu,

-- Occurs when the keybind is clicked, Value is `true`/`false`
Callback = function(Value)

end,

-- Occurs when the keybind itself is changed, `NewKey` is a KeyCode Enum OR a UserInputType Enum, `NewModifiers` is a table with KeyCode Enum(s) or nil
ChangedCallback = function(NewKey, NewModifiers)
end,
})

PlayerBox:AddToggle('Flight',{
Text = "飞行模式",
Default = false,

Callback = function(Value)
if not Value then
  if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlightVelocity") then
    LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlightVelocity"):Destroy()
  end
  
  
  
end
end
}):AddKeyPicker("FlightKeybind", {
-- SyncToggleState only works with toggles.
-- It allows you to make a keybind which has its state synced with its parent toggle

-- Example: Keybind which you use to toggle flyhack, etc.
-- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

Default = "F", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
SyncToggleState = true,

-- You can define custom Modes but I have never had a use for it.
Mode ="Toggle" , -- Modes: Always, Toggle, Hold, Press (example down below)

Text = "飞行模式", -- Text to display in the keybind menu
NoUI = false, -- Set to true if you want to hide from the Keybind menu,

-- Occurs when the keybind is clicked, Value is `true`/`false`
Callback = function(Value)

end,

-- Occurs when the keybind itself is changed, `NewKey` is a KeyCode Enum OR a UserInputType Enum, `NewModifiers` is a table with KeyCode Enum(s) or nil
ChangedCallback = function(NewKey, NewModifiers)
end,
})

PlayerBox:AddSlider("FlightSpeed", {
Text = "飞行速度",
Default = 15,
Min = 15,
Max = 21,
Rounding = 1,
Compact = false,

Callback = function(Value)
end,

Tooltip = "飞行速度",
})

PlayerBox:AddDivider()
PlayerBox:AddToggle('EnableJump',{
Text = "启用跳跃",
Default = false,
Tooltip = "你可以跳跃",
Callback = function(Value)
if not Value then
  LocalPlayer.Character:SetAttribute("CanJump",false)
end
end
})
PlayerBox:AddToggle('EnableSlide',{
Text = "启用滑铲",
Default = false,
Tooltip = "你可以滑铲",
Callback = function(Value)
if not Value then
  LocalPlayer.Character:SetAttribute("Sliding",false)
end
end
})
PlayerBox:AddDivider()

PlayerBox:AddToggle('InstaInteract',{
Text = "瞬间交互",
Default = false,
Tooltip = "交互立即完成",
Callback = function(Value)
if Value then
  for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
      v:SetAttribute("Duration",v.HoldDuration)
      v.HoldDuration = 0
    end
  end
else
  for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
      
      v.HoldDuration = v:GetAttribute("Duration") or 0
    end
  end
end
end
})
PlayerBox:AddToggle('InfJump',{
Text = "无限跳跃",
Default = false
})

if UserInputService.KeyboardEnabled then
  local d = false
  table.insert(Connections, UserInputService.JumpRequest:Connect(function()
  if Toggles.InfJump.Value and not d and LocalPlayer.Character then
    d = true
    LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping, true)
    task.wait(0.1)
    d = false
  end
end))
elseif UserInputService.TouchEnabled then
  table.insert(Connections, LocalPlayer.CharacterAdded:Connect(function()
  task.wait(1)
  if LocalPlayer.PlayerGui.MainUI.MainFrame.MobileButtons:FindFirstChild("JumpButton") then
    table.insert(Connections, LocalPlayer.PlayerGui.MainUI.MainFrame.MobileButtons.JumpButton.MouseButton1Click:Connect(function()
    if Toggles.InfJump.Value and LocalPlayer.Character then
      LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping, true)
    end
  end))
end
end))
if LocalPlayer.PlayerGui.MainUI.MainFrame.MobileButtons:FindFirstChild("JumpButton") then
  table.insert(Connections, LocalPlayer.PlayerGui.MainUI.MainFrame.MobileButtons.JumpButton.MouseButton1Click:Connect(function()
  if Toggles.InfJump.Value and LocalPlayer.Character then
    LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping, true)
  end
end))
end
end




PlayerBox:AddDivider()
PlayerBox:AddToggle('FastClosetExit',{
Text = "躲藏点快速进出",
Default = false
})
PlayerBox:AddDivider()

PlayerBox:AddToggle('Godmode',{
Text = "无敌模式",
Default = false,
Tooltip = "可能导致卡退或失效",
Risky  = true,

Callback = function(Value)


if Value and RemotesFolder.Name ~= "RemotesFolder" then
  LocalPlayer.Character.Collision.Position -= Vector3.new(0, 4, 0)
end

if Value and RemotesFolder.Name == "RemotesFolder" then
  LocalPlayer.Character:PivotTo(LocalPlayer.Character.CollisionPart.CFrame * CFrame.new(0, -2,0))
end
if not Value and RemotesFolder.Name == "RemotesFolder" then
  LocalPlayer.Character.Humanoid.HipHeight = 2.4
  LocalPlayer.Character.Collision.Size = Vector3.new(5.5, 3, 3)
  
  LocalPlayer.Character.LowerTorso.Root.C1 = CFrame.new(Vector3.new(0, 0, 0))
  LocalPlayer.Character.Collision.CollisionCrouch.Size = Vector3.new(5.5, 3, 3)
  LocalPlayer.Character:PivotTo(LocalPlayer.Character.CollisionPart.CFrame * CFrame.new(0, 2,0))
  
end
if not Value and RemotesFolder.Name ~= "RemotesFolder" then
  LocalPlayer.Character.Collision.Position = LocalPlayer.Character.HumanoidRootPart.Position
end

end
}):AddKeyPicker("GodmodeKeybind", {
-- SyncToggleState only works with toggles.
-- It allows you to make a keybind which has its state synced with its parent toggle

-- Example: Keybind which you use to toggle flyhack, etc.
-- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

Default = "G", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
SyncToggleState = true,

-- You can define custom Modes but I have never had a use for it.
Mode ="Toggle" , -- Modes: Always, Toggle, Hold, Press (example down below)

Text = "无敌模式", -- Text to display in the keybind menu
NoUI = false, -- Set to true if you want to hide from the Keybind menu,

-- Occurs when the keybind is clicked, Value is `true`/`false`
Callback = function(Value)

end,

-- Occurs when the keybind itself is changed, `NewKey` is a KeyCode Enum OR a UserInputType Enum, `NewModifiers` is a table with KeyCode Enum(s) or nil
ChangedCallback = function(NewKey, NewModifiers)
end,
})










local PromptIgnore = {
HidePrompt = true,
ClimbPrompt = true,
PropPrompt = true,
InteractPrompt = true,
RiftPrompt = true,
StarRiftPrompt = true,
NoHidingLilBro = true,
AnimatePrompt = true,
RevivePrompt = true,

}

Interactions = {}

AutoBox:AddToggle("AutoInteract",{
Text = "自动交互",
Default = false,
Tooltip = "靠近时自动与物品交互",
Callback = function(Value)
if Value then
  for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
      if not (PromptIgnore[v.Name] or  v.Parent.Name == "Padlock" or  v.Parent:GetAttribute("JeffShop")) or v.Parent.Name == "RetroWardrobe" or v.Parent.Name == "KeyObtainFake" then
        table.insert(Interactions, v)
        
        
      end
    end
  end
else
  table.clear(Interactions)
end
end
}):AddKeyPicker("AutoInteractKeybind", {
-- SyncToggleState only works with toggles.
-- It allows you to make a keybind which has its state synced with its parent toggle

-- Example: Keybind which you use to toggle flyhack, etc.
-- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

Default = "R", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
SyncToggleState = true,

-- You can define custom Modes but I have never had a use for it.
Mode = Library.IsMobile and "Toggle"  or "Hold", -- Modes: Always, Toggle, Hold, Press (example down below)

Text = "自动交互", -- Text to display in the keybind menu
NoUI = false, -- Set to true if you want to hide from the Keybind menu,

-- Occurs when the keybind is clicked, Value is `true`/`false`
Callback = function(Value)
print("[cb] Keybind clicked!", Value)
end,

-- Occurs when the keybind itself is changed, `NewKey` is a KeyCode Enum OR a UserInputType Enum, `NewModifiers` is a table with KeyCode Enum(s) or nil
ChangedCallback = function(NewKey, NewModifiers)
end,
})
HidingPlaces = {
["Wardrobe"] = "衣柜",
["Rooms_Locker"] = "储物柜",
["Rooms_Locker_Fridge"] = "冰箱",
["Locker_Large"] = "储物柜",
["Backdoor_Wardrobe"] = "衣柜",
["Bed"] = "床",
["Double_Bed"]  = "双人床",
["Toolshed"] = "工具棚",
["RetroWardrobe"] = "衣柜",
["CircularVent"] = "通风口",
["Bed"] = "床",
["Double_Bed"] = "双人床",
}
Closets = {}

function GetNearestHidingSpot()
  local Closest = nil
  local MaxDistance = math.huge
  if #Closets > 0 then
    for _, v in pairs(Closets) do
      if v:FindFirstChild("HiddenPlayer") and v.HiddenPlayer.Value == nil then
        local Dis = GetDistanceToPlayer(v.PrimaryPart.Position)
        if Dis < MaxDistance then
          Closest = v
          MaxDistance = Dis
        end
      end
    end
  end
  return Closest
end

AutoBox:AddSlider("AutoInteractDelay", {
Text = "自动交互延迟",
Default = 0.05,
Min = 0,
Max = 0.2,
Rounding = 2,
Compact = false,

Callback = function(Value)
end,
})
AutoBox:AddSlider("AutoInteractreach", {
Text = "自动交互距离",
Default = 7,
Min = 7,
Max = 12,
Rounding = 2,
Compact = false,

Callback = function(Value)
end,
})
AutoBox:AddDivider()


AutoBox:AddToggle('AutoLibraryCode',{
Text = "自动图书馆密码",
Disabled = Floor.Value ~= "Hotel" and RemotesFolder.Name ~= "Bricks" and Floor.Value ~= "Fools" and Floor.Value ~= "Fools26" and true or false,
Default = false,

})

AutoBox:AddToggle('BruteForceLibCode',{
Text = "暴力破解图书馆密码",
Disabled = Floor.Value ~= "Hotel" and RemotesFolder.Name ~= "Bricks" and Floor.Value ~= "Fools" and Floor.Value ~= "Fools26" and true or false,

Default = false,

})
AutoBox:AddToggle('AutoHeartbeat',{
Text = "自动心跳小游戏",
Default = false
})









local function Breaker(part)
  local label = part:WaitForChild("SurfaceGui"):WaitForChild("Frame"):WaitForChild("Code")
  
  
  local function run()
    task.wait(0.05)
    if not Toggles.AutoBreaker.Value then return end
    
    if Method == "Exploit" then
      RemotesFolder.EBF:FireServer()
      return
    end
    
    if Method == "Legit" then
      local target = tonumber(label.Text)
      
      if target then
        for _, v in part:GetChildren() do
          if v.Name == "BreakerSwitch" and v:GetAttribute("ID") == target then
            local trans = part:WaitForChild("SurfaceGui"):WaitForChild("Frame"):WaitForChild("Code"):WaitForChild("Frame").BackgroundTransparency
            local pc = v:FindFirstChild("PrismaticConstraint")
            local light = v:FindFirstChild("Light")
            local sound = v:FindFirstChild("Sound")
            
            if trans == 0 then
              if v:GetAttribute("Enabled") then return end
              v:SetAttribute("Enabled", true)
              if pc then pc.TargetPosition = -0.2 end
              if light then
                light.Material = Enum.Material.Neon
                local spark = light:FindFirstChild("Spark", true)
                if spark then spark:Emit(1) end
              end
              if sound then sound:Play() end
            elseif trans == 1 then
              if not v:GetAttribute("Enabled") then return end
              v:SetAttribute("Enabled", false)
              if pc then pc.TargetPosition = 0.2 end
              if light then light.Material = Enum.Material.Glass end
              if sound then sound:Play() end
            end
            break
          end
        end
      end
    end
  end
  
  label:GetPropertyChangedSignal("Text"):Connect(run)
  run()
end




AutoBox:AddDivider()
AutoBox:AddToggle('AutoBreaker',{
Text = "自动电闸",
Disabled = Floor.Value == "Mines" and Floor.Value == "Retro" and Floor.Value == "Outdoors" and true or false,
Default = false,
Callback = function(Value)
if Value then
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "ElevatorBreaker" then
      Breaker(v)
    end
  end
end
end
})

AutoBox:AddDropdown("AutoBreakerBoxMethod", {
Values = { "Legit", "Exploit" },
Default = Method,
Disabled = Floor.Value == "Mines" and Floor.Value == "Retro" and Floor.Value == "Outdoors" and true or false,
Text = "自动电闸方式",

Callback = function(Value)
Method = Value
end,
})
AutoBox:AddDivider()


AutoBox:AddToggle('AutoHiding',{
Text = "自动柜子",
Default = false
}):AddKeyPicker("AutoHideKeybind", {
-- SyncToggleState only works with toggles.
-- It allows you to make a keybind which has its state synced with its parent toggle

-- Example: Keybind which you use to toggle flyhack, etc.
-- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

Default = "Q", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
SyncToggleState = true,

-- You can define custom Modes but I have never had a use for it.
Mode = "Toggle", -- Modes: Always, Toggle, Hold, Press (example down below)

Text = "自动柜子", -- Text to display in the keybind menu
NoUI = false, -- Set to true if you want to hide from the Keybind menu,

-- Occurs when the keybind is clicked, Value is `true`/`false`
Callback = function(Value)
print("[cb] Keybind clicked!", Value)
end,

-- Occurs when the keybind itself is changed, `NewKey` is a KeyCode Enum OR a UserInputType Enum, `NewModifiers` is a table with KeyCode Enum(s) or nil
ChangedCallback = function(NewKey, NewModifiers)
end,
})



local OldFogEnd
LightingBox:AddToggle('NoFog',{
Text = "无雾",
Default = false,
Tooltip = "无雾气",
Callback = function(Value)
if not Value then
  for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("Atmosphere") then
      v.Density = 0.94
    end
  end
end
if Value then
  OldFogEnd = Lighting.FogEnd
else
  if OldFogEnd then
    Lighting.FogEnd = OldFogEnd
    OldFogEnd = nil
  end
  
end

end
})
LightingBox:AddToggle('FullBright',{
Text = "高亮",
Default = false,
Tooltip = "让你在黑暗中看清",
Callback = function(Value)
if not Value then
  Lighting.Ambient = Color3.fromRGB(0, 0, 0)
  Lighting.GlobalShadows = true
  for _, v in pairs(workspace.CurrentRooms:GetChildren()) do
    v:SetAttribute("Ambient", v:GetAttribute("OldAmbient"))
  end
end

end
})
local DoorColor = Color3.new(0, 1, 1)
local HidingPlaceColor = Color3.new(0, 0.4, 0)
local LeverColor = Color3.new(0.5, 0.5, 0.5)

local BookColor = Color3.new(0, 0, 0.5)

local BreakerColor = Color3.new(0.5, 1, 0.5)

local ItemsColor = Color3.new(1, 0.5, 1)


local GoldColor = Color3.new(1,1,0)

ESPBox:AddToggle('Door',{
Text = "门",
Default = false,
Callback = function(Value)
if Value then
  local Doo = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") + 1].Door.Door
  if Doo:FindFirstChild("CrossBoards") then
    AddESP(Doo.CrossBoards, "",  DoorColor)
    AddESP(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")].Door.Door.CrossBoards, "", DoorColor)
  end
  AddESP(Doo, "门 " .. Doo.Parent:GetAttribute("RoomID"), DoorColor)
  AddESP(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")].Door.Door, "门 " .. workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")].Door:GetAttribute("RoomID"), DoorColor)
  
else
  for _, v in ipairs(workspace.CurrentRooms:GetChildren()) do
    ESPLibrary:RemoveESP(v.Door.Door)
    if v.Door.Door:FindFirstChild("CrossBoards") then
      ESPLibrary:RemoveESP(v.Door.Door.CrossBoards)
    end
    
  end
end
end
}):AddColorPicker("ColorPicker2", {
Default = DoorColor,
Title = "门ESP颜色",

Callback = function(Value)
DoorColor = Value
Toggles.Door:SetValue(false)
Toggles.Door:SetValue(true)
end,
})


ESPBox:AddToggle('Objective',{
Text = "钥匙",
Default = false,
Callback = function(Value)
if Value then
  
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    local Bro = Items[v.Name]
    if Bro then
      AddESP(v, Bro,ItemsColor)
      
    end
    if v.Name == "MinesAnchor" then
      AddESP(v, "锚点 " .. v:WaitForChild("Sign").TextLabel.Text, ItemsColor)
    end
    
    if v.Name == "KeyObtain" then
      repeat task.wait() until v.PrimaryPart
        AddESP(v, "钥匙", Color3.new(0, 1, 1))
      end
      
      
    end
  else
    for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
      local Bro = Items[v.Name]
      if Bro then
        ESPLibrary:RemoveESP(v)
      end
      
      if v.Name == "MinesAnchor" then
        ESPLibrary:RemoveESP(v)
      end
      
      if v.Name == "KeyObtain" then
        repeat task.wait() until v.PrimaryPart
          ESPLibrary:RemoveESP(v)
        end
      end
    end
    
  end
  
}):AddColorPicker("ColorPicker3", {
Default = ItemsColor,
Title = "钥匙ESP颜色",

Callback = function(Value)
ItemsColor = Value
Toggles.
Objective:SetValue(false)
Toggles.Objective:SetValue(true)
end,
})






for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
  if HidingPlaces[v.Name] then
    table.insert(Closets, v)
  end
end

ESPBox:AddToggle('HidingPlace',{
Text = "躲藏点",
Default = false,
Callback = function(Value)
if Value then
  
  for _, v in pairs(Closets) do
    local Nam =  HidingPlaces[v.Name]
    if Nam and v:IsDescendantOf(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]) then
      AddESP(v, Nam, HidingPlaceColor)
    end
  end
  
  
  
else
  for _, v in pairs(Closets) do
    local Nam =  HidingPlaces[v.Name]
    if Nam then
      ESPLibrary:RemoveESP(v)
    end
  end
  
end
end

}):AddColorPicker("ColorPicker3", {
Default = HidingPlaceColor,
Title = "躲藏点ESP颜色",

Callback = function(Value)
HidingPlaceColor = Value
Toggles.
HidingPlace:SetValue(false)
Toggles.HidingPlace:SetValue(true)
end,
})
ESPBox:AddToggle('GateLever',{
Text = "拉杆",
Default = false,
Callback = function(Value)
if Value then
  
  local Lever = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:FindFirstChild("LeverForGate",true)
  if Lever then
    AddESP(Lever, "拉杆", LeverColor)
  end
  
  
else
  local Lever = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:FindFirstChild("LeverForGate",true)
  if Lever then
    ESPLibrary:RemoveESP(Lever)
  end
end

end

}):AddColorPicker("ColorPicker3", {
Default = LeverColor,
Title = "拉杆ESP颜色",

Callback = function(Value)
LeverColor = Value
Toggles.
GateLever:SetValue(false)
Toggles.GateLever:SetValue(true)
end,
})
ESPBox:AddToggle('Books',{
Text = "书",
Default = false,
Callback = function(Value)
if Value then
  
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "LiveHintBook" then
      AddESP(v, "书",BookColor)
      
    end
  end
else
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "LiveHintBook" then
      ESPLibrary:RemoveESP(v)
    end
  end
end

end

}):AddColorPicker("ColorPicker3", {
Default = BookColor,
Title = "书ESP颜色",

Callback = function(Value)
BookColor = Value
Toggles.
Books:SetValue(false)
Toggles.Books:SetValue(true)
end,
})

ESPBox:AddToggle('Breakers',{
Text = "电闸",
Default = false,
Callback = function(Value)
if Value then
  
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "LiveBreakerPolePickup" then
      AddESP(v, "电闸",BreakerColor)
      
    end
  end
else
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "LiveBreakerPolePickup" then
      ESPLibrary:RemoveESP(v)
    end
  end
end

end

}):AddColorPicker("ColorPicker3", {
Default = BreakerColor,
Title = "电闸ESP颜色",

Callback = function(Value)
BreakerColor = Value
Toggles.
Breakers:SetValue(false)
Toggles.Breakers:SetValue(true)
end,
})


ESPBox:AddToggle('Gold',{
Text = "金币",
Default = false,
Callback = function(Value)
if Value then
  
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "GoldPile" then
      AddESP(v, "金币 " .. v:GetAttribute("GoldValue"), GoldColor)
      
    end
  end
else
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "GoldPile" then
      ESPLibrary:RemoveESP(v)
    end
  end
end

end

}):AddColorPicker("ColorPicker3", {
Default = GoldColor,
Title = "金币ESP颜色",

Callback = function(Value)
GoldColor = Value
Toggles.
Gold:SetValue(false)
Toggles.Gold:SetValue(true)
end,
})





local EntityColor = Color3.new(1, 0, 0)

local roomEntities = {
["Snare"] = "Snare",
["FigureRig"] = "Figure",
["FigureRagdoll"] = "Figure",
["GrumbleRig"] = "Grumble",
["Groundskeeper"] = "Ground Keeper",
["MandrakeLive"] = "Man Drake",
["LiveEntityBramble"] = "Bramble"
}

local workspaceEntities = {
["RushMoving"] = "Rush",
["AmbushMoving"] = "Ambush",
["A60"] = "A-60",
["A120"] = "A-120",
["GlitchRush"] = "Glitch Rush",
["GlitchAmbush"] = "Glitch Ambush",
["Eyes"] = "Eyes",
["Lookman"] = "Eyes",
["BackdoorRush"] = "Blitz",
["BackdoorLookman"] = "Lookman",
["JeffTheKiller"] = "Jeff"
}

ESPBox:AddToggle('Entity', {
Text = "实体",
Default = false,
Callback = function(Value)
task.spawn(function()
if Value then
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    local label = roomEntities[v.Name]
    if label then
      if v.Name == "Snare" then
        if v:FindFirstChild("Hitbox") then AddEntityESP(v, label, EntityColor) end
      else
        AddEntityESP(v, label, EntityColor)
      end
    elseif v.Name == "DoorFake" and v.Parent.Name == "SideroomDupe" then
      AddEntityESP(v:WaitForChild("Door"), "假门", EntityColor)
    elseif v.Name == "GiggleCeiling" then
      task.spawn(function()
      local t = 0
      repeat task.wait(0.1) t = t + 0.1 until t > 2 or v:FindFirstChild("Hitbox")
        if v:FindFirstChild("Hitbox") then AddEntityESP(v, "Giggle", EntityColor) end
      end)
    end
  end
  
  for _, v in pairs(workspace:GetChildren()) do
    local label = workspaceEntities[v.Name]
    if label then AddEntityESP(v, label, EntityColor) end
  end
else
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if roomEntities[v.Name] or v.Name == "GiggleCeiling" or v.Name == "DoorFake" then
      if v.Name == "DoorFake" then
        local door = v:FindFirstChild("Door")
        if door then ESPLibrary:RemoveESP(door) end
      end
      ESPLibrary:RemoveESP(v)
    end
  end
  
  for _, v in pairs(workspace:GetChildren()) do
    if workspaceEntities[v.Name] then
      ESPLibrary:RemoveESP(v)
    end
  end
end
end)
end
}):AddColorPicker("ColorPicker3", {
Default = EntityColor,
Title = "实体ESP颜色",
Callback = function(Value)
EntityColor = Value
if Toggles.Entity.Value then
  Toggles.Entity:SetValue(false)
  Toggles.Entity:SetValue(true)
end
end,
})




CameraBox:AddSlider("FOV", {
Text = "视野范围",
Default = 70,
Min = 70,
Max = 120,
Rounding = 1,
Compact = false,

Callback = function(Value)
end,

Tooltip = "视野范围",
})
CameraBox:AddDivider()
CameraBox:AddToggle('ThirdPerson',{
Text = "第三人称",
Default = false
}):AddKeyPicker("ThirdpersonKeybind", {
-- SyncToggleState only works with toggles.
-- It allows you to make a keybind which has its state synced with its parent toggle

-- Example: Keybind which you use to toggle flyhack, etc.
-- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

Default = "T", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
SyncToggleState = true,

-- You can define custom Modes but I have never had a use for it.
Mode = "Toggle", -- Modes: Always, Toggle, Hold, Press (example down below)

Text = "第三人称", -- Text to display in the keybind menu
NoUI = false, -- Set to true if you want to hide from the Keybind menu,

-- Occurs when the keybind is clicked, Value is `true`/`false`
Callback = function(Value)

end,

-- Occurs when the keybind itself is changed, `NewKey` is a KeyCode Enum OR a UserInputType Enum, `NewModifiers` is a table with KeyCode Enum(s) or nil
ChangedCallback = function(NewKey, NewModifiers)
end,
})

CameraBox:AddSlider("X", {
Text = "X轴",
Default = 2,
Min = -10,
Max = 10,
Rounding = 1,
Compact = false,

Callback = function(Value)
end,

Tooltip = "X轴",
})
CameraBox:AddSlider("Y", {
Text = "Y轴",
Default = 0,
Min = -10,
Max = 10,
Rounding = 1,
Compact = false,

Callback = function(Value)
end,

Tooltip = "Y轴",
})

CameraBox:AddSlider("Z", {
Text = "Z轴",
Default = 4,
Min = -10,
Max = 10,
Rounding = 1,
Compact = false,

Callback = function(Value)
end,

Tooltip = "Z轴",
})




CameraBox:AddToggle('NoCamShake',{
Text = "无抖动",
Disabled = not require and true or false,
})

local OldMinZoom = LocalPlayer.CameraMinZoomDistance
local OldMaxZoom  = LocalPlayer.CameraMaxZoomDistance

CameraBox:AddToggle('Freecam',{
Text = "自由视角",
Default = false,
Callback = function(Value)
if not Value then
  
  local fcPart = workspace:FindFirstChild("FreecamPart")
  
  if fcPart then
    
    
    
    fcPart:Destroy()
    
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.Anchored = false end
    
    LocalPlayer.CameraMinZoomDistance = LocalPlayer:GetAttribute("fc_om") or 0.5
    LocalPlayer.CameraMaxZoomDistance = LocalPlayer:GetAttribute("fc_ox") or 128
  end
  
  
end
end
}):AddKeyPicker("FreecamKeybind", {
-- SyncToggleState only works with toggles.
-- It allows you to make a keybind which has its state synced with its parent toggle

-- Example: Keybind which you use to toggle flyhack, etc.
-- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

Default = "B", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
SyncToggleState = true,

-- You can define custom Modes but I have never had a use for it.
Mode ="Toggle" , -- Modes: Always, Toggle, Hold, Press (example down below)

Text = "自由视角", -- Text to display in the keybind menu
NoUI = false, -- Set to true if you want to hide from the Keybind menu,

-- Occurs when the keybind is clicked, Value is `true`/`false`
Callback = function(Value)

end,

-- Occurs when the keybind itself is changed, `NewKey` is a KeyCode Enum OR a UserInputType Enum, `NewModifiers` is a table with KeyCode Enum(s) or nil
ChangedCallback = function(NewKey, NewModifiers)
end,
})



CameraBox:AddToggle('NoScenes',{
Text = "无过场动画",
Default = false,
Callback = function(Value)
local Cutscene = RemoteListener:FindFirstChild("Cutscenes") or RemoteListener:FindFirstChild("Cutscenes_")
if Value then
  Cutscene.Name = "Cutscenes_"
else
  Cutscene.Name = "Cutscenes"
end
end
})


NotifyBox:AddDropdown("Notify", {
Values = { "Rush","Ambush","GlitchRush","GlitchAmbush","A-60","A-120","Eyes","Blitz","Lookman","Jeff"},
Default = 1, -- number index of the value / string
Multi = true, -- true / false, allows multiple choices to be selected

Text = "选择要提示的实体",

Callback = function(Value)

end,


})
NotifyBox:AddToggle('NotifySpawn',{
Text = "实体提示",
Default = false,
Tooltip = "实体出现提示",
Callback = function(Value)
if Value then
  if workspace:FindFirstChild("RushMoving") and Options.Notify.Value  == "Rush" then
    Notify("Rush 已生成",5)
  end
  if workspace:FindFirstChild("AmbushMoving") and Options.Notify.Value["Ambush"] then
    Notify("Ambush 已生成",5)
  end
  if workspace:FindFirstChild("A60") and Options.Notify.Value["A-60"] then
    Notify("A-60 已生成",5)
  end
  if workspace:FindFirstChild("GlitchRush") and Options.Notify.Value["GlitchRush"] then
    Notify("Glitch Rush 已生成",5)
  end
  if workspace:FindFirstChild("GlitchAmbush") and Options.Notify.Value["GlitchAmbush"] then
    Notify("Glitch Ambush 已生成",5)
  end
  if workspace:FindFirstChild("Eyes") and Options.Notify.Value["Eyes"] then
    Notify("Eyes 已生成",5)
  end
  if workspace:FindFirstChild("Lookman") and Options.Notify.Value["Eyes"] then
    Notify("Eyes 已生成",5)
  end
  if workspace:FindFirstChild("BackdoorRush") and Options.Notify.Value["Blitz"] then
    Notify("Blitz 已生成",5)
  end
  
  if workspace:FindFirstChild("BackdoorLookman") and Options.Notify.Value["Lookman"] then
    Notify("Lookman 已生成",5)
  end
  if workspace:FindFirstChild("A120") and Options.Notify.Value["A-120"] then
    Notify("A-120 已生成",5)
    
    if workspace:FindFirstChild("JeffTheKiller") and Options.Notify.Value["Jeff"] then
      Notify("Jeff 已生成",5)
    end
    
    
  end
  
end
end

})

local FakeScreech = Instance.new("RemoteEvent",RemotesFolder)
FakeScreech.Name = "Screech_"

local FakeA90 = Instance.new("RemoteEvent",RemotesFolder)
FakeA90.Name = "A90_"




local gotToggled = false
local gotToggled2 = false

BypassEntityBox:AddToggle('Screech',{
Text = "防 Screech",
Default = false,
Callback = function(Value)
if Value then
  gotToggled = true
  RemotesFolder.Screech.Name = "Screech_"
  FakeScreech.Name = "Screech"
else
  if gotToggled then
    RemotesFolder["Screech_"].Name = "Screech"
    FakeScreech.Name = "Screech_"
  end
end
end
})
BypassEntityBox:AddToggle('A90',{
Text = "防 A90",
Default = false,
Callback = function(Value)
if Value then
  gotToggled2 = true
  RemotesFolder.A90.Name = "A90_"
  FakeA90.Name = "A90"
else
  if gotToggled2 then
    RemotesFolder["A90_"].Name = "A90"
    FakeA90.Name = "A90_"
  end
end
end
})

BypassEntityBox:AddToggle('Dread',{
Text = "防 Dread",
Default = false,
Callback = function(Value)
if Value then
  local Dread = LocalPlayer:FindFirstChild("Dread",true) or LocalPlayer:FindFirstChild("_Dread",true)
  
  if Dread then
    Dread.Name = "_Dread"
  end
else
  local Dread = LocalPlayer:FindFirstChild("Dread",true) or LocalPlayer:FindFirstChild("_Dread",true)
  
  if Dread then
    Dread.Name = "Dread"
  end
  
end
end
})

BypassEntityBox:AddToggle('Halt',{
Text = "防 Halt",
Default = false,
Callback = function(Value)
if Value then
  local Dread = ClientModules.EntityModules:FindFirstChild("Shade",true) or ClientModules.EntityModules:FindFirstChild("_Shade",true)
  
  if Dread then
    Dread.Name = "_Shade"
  end
else
  local Dread = ClientModules.EntityModules:FindFirstChild("Shade",true) or ClientModules.EntityModules:FindFirstChild("_Shade",true)
  
  if Dread then
    Dread.Name = "Shade"
  end
  
end
end
})



BypassEntityBox:AddToggle('Jamming',{
Text = "防 Jammimg",
Default = false,
Callback = function(Value)
if  ReplicatedStorage:FindFirstChild("LiveModifiers") and ReplicatedStorage:FindFirstChild("LiveModifiers"):FindFirstChild("Jammin") then
  
  local Jam = LocalPlayer.PlayerGui.MainUI.Initiator:FindFirstChild("Main_Game").Health.Jam
  Jam.Playing = not Value
  local Jamming = game:GetService("SoundService").Main.Jamming
  Jamming.Enabled =  not Value
end
end
})


local Surge = Instance.new("RemoteEvent",ReplicatedStorage)
Surge.Name = "SurgeRemote"

BypassEntityBox:AddToggle('BypassSurgeDamage',{
Text = "防 Surge Damage",
Default = false,
Callback = function(Value)
if Value then
  if RemotesFolder:FindFirstChild("SurgeRemote") then
    RemotesFolder.SurgeRemote.Parent = ReplicatedStorage
    Surge.Parent = RemotesFolder
  end
else
  if RemotesFolder:FindFirstChild("SurgeRemote") then
    ReplicatedStorage.SurgeRemote.Parent = RemotesFolder
    Surge.Parent = ReplicatedStorage
  end
end
end
})



BypassEntityBox:AddToggle('Snare',{
Text = "防 藤蔓",
Default = false,
Callback = function(Value)
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
  if   v.Name == "Snare" then
    
    local wait = 0
    repeat task.wait(0.01) wait = wait  + 0.01 until wait > 2 or v:FindFirstChild("Hitbox")
      if v:FindFirstChild("Hitbox") then
        
        v.Hitbox.CanTouch = not Value
      end
    end
  end
end
})

BypassEntityBox:AddToggle('Giggle',{
Text = "防 Giggle",
Default = false,
Disabled = Floor.Value == "Fools" and RemotesFolder.Name == "Bricks" and true or false,
Callback = function(Value)
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
  if   v.Name == "GiggleCeiling" then
    
    local wait = 0
    repeat task.wait(0.01) wait = wait  + 0.01 until wait > 2 or v:FindFirstChild("Hitbox")
      if v:FindFirstChild("Hitbox") then
        
        v.Hitbox.CanTouch = not Value
      end
    end
  end
end
})

BypassEntityBox:AddToggle('Dupe',{
Text = "防 假门",
Default = false,
Callback = function(Value)
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
  if v.Name == "DoorFake"  and v.Parent.Name == "SideroomDupe" then
    v:WaitForChild("Hidden",9e9).CanTouch = not Value
  end
end

end
})

BypassBox:AddToggle('BypassSpeed',{
Text = "速度绕过",
Default = false,
Callback  = function(Value)
Options.MovementSpeed:SetMax(Value and 150 or 21)
Options.FlightSpeed:SetMax(Value and 150 or 21)
end
})

BypassBox:AddDropdown("SpeedBypassMethod", {
Values = { "模式 1", "模式 2" },
Default = 1,

Text = "速度绕过模式",

Callback = function(Value)

end,
})



BypassBox:AddDivider()





BypassBox:AddDropdown("AntiCheatManiMethod", {
Values = { "平移", "坐标" },
Default = 1,

Text = "穿墙方式",

Callback = function(Value)

end,
})



BypassBox:AddToggle('AntiCheatMani',{
Text = "无视反作弊穿墙",
Default = false,
Callback = function(Value)
if not Value then
  
  if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityMani") then
    LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityMani"):Destroy()
  end
  
  if  Toggles.NoClip.Value then
    Toggles.NoClip:SetValue(false)
  end
  
end
end
}):AddKeyPicker("AntiCheatMan", {
-- SyncToggleState only works with toggles.
-- It allows you to make a keybind which has its state synced with its parent toggle

-- Example: Keybind which you use to toggle flyhack, etc.
-- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

Default = "V", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
SyncToggleState = true,

-- You can define custom Modes but I have never had a use for it.
Mode = Library.IsMobile and "Toggle" or "Hold",  -- Modes: Always, Toggle, Hold, Press (example down below)

Text = " 无视反作弊穿墙", -- Text to display in the keybind menu
NoUI = false, -- Set to true if you want to hide from the Keybind menu,

-- Occurs when the keybind is clicked, Value is `true`/`false`
Callback = function(Value)
print("[cb] Keybind clicked!", Value)
end,

-- Occurs when the keybind itself is changed, `NewKey` is a KeyCode Enum OR a UserInputType Enum, `NewModifiers` is a table with KeyCode Enum(s) or nil
ChangedCallback = function(NewKey, NewModifiers)
end,
})

BypassBox:AddLabel("开启假复活后 你将无法交互 并且无法关闭",true)
BypassBox:AddToggle('FakeRevive',{
Text = "假复活",
Default = false,
Disabled = Floor.Value == "Fools" and true or RemotesFolder.Name =="Bricks" and true or false,
Risky = true,
})




local Params = RaycastParams.new()
Params.FilterType = Enum.RaycastFilterType.Exclude
local Direction = Vector3.new(0, -100, 0)

task.spawn(function()
while task.wait(Options.SpeedBypassMethod.Value == "模式 1" and 0 or 0.209)
  
  do
    if Library.Unloaded then break end
    if Options.SpeedBypassMethod.Value == "模式 1" then
      if Toggles.BypassSpeed.Value then
        if CollisionClone then
          CollisionClone.Massless = true
        end
        RemotesFolder.Crouch:FireServer(true, true)
      end
    elseif  Options.SpeedBypassMethod.Value == "模式 2" then
      
      
      local char = LocalPlayer.Character
      local hrp = char and char:FindFirstChild("HumanoidRootPart")
      
      if LocalPlayer:GetAttribute("Alive") and hrp and CollisionClone and CollisionClone.Parent then
        
        
        
        
        
        
        Params.FilterDescendantsInstances = {char, CollisionClone}
        
        if not workspace:Raycast(hrp.Position, Direction, Params) or not Toggles.BypassSpeed.Value then
          CollisionClone.Massless = true
        else
          
          local cp = char:FindFirstChild("CollisionPart")
          if cp and (cp.Anchored or Passed) then
            CollisionClone.Massless = true
            repeat task.wait() until not cp.Anchored or not cp.Parent
              if CollisionClone and CollisionClone.Parent then
                CollisionClone.Massless = true
                task.wait(0.5)
                if CollisionClone and CollisionClone.Parent then
                  CollisionClone.Massless = false
                end
              end
            else
              if LocalPlayer:GetAttribute("Alive") then CollisionClone.Massless = true end
              task.wait(0.209)
              if LocalPlayer:GetAttribute("Alive") and CollisionClone and CollisionClone.Parent then
                CollisionClone.Massless = false
              end
            end
          end
        end
      end
    end
  end)
  
  
  
  
  table.insert(Connections,workspace.ChildAdded:Connect(function(v)
  
  
  
  if Toggles.AntiBanana.Value then
    if v.Name == "BananaPeel" then
      v.CanTouch = false
    end
  end
  if Toggles.AntiJeff.Value then
    if v.Name == "布里吉斯TheKiller" then
      repeat task.wait() until v.PrimaryPart and isnetworkowner(v.PrimaryPart)
        for _, i in pairs(v:GetChildren()) do
          if i:IsA("BasePart") then
            i.CanTouch = false
          end
        end
        v.Humanoid.Health = 0
      end
    end
    
    if Toggles.NotifySpawn.Value then
      if v.Name == "RushMoving" and Options.Notify.Value["Rush"] then
        Notify("Rush 已生成",5)
      end
      if v.Name == "AmbushMoving"  and Options.Notify.Value["Ambush"] then
        Notify("Ambush 已生成",5)
      end
      if v.Name == "A60"  and Options.Notify.Value["A-60"] then
        Notify("A-60 已生成",5)
      end
      if v.Name == "A120"  and Options.Notify.Value["A-120"] then
        Notify("A-120 已生成",5)
      end
      if v.Name == "GlitchRush"  and Options.Notify.Value["GlitchRush"] then
        Notify("Glitch Rush 已生成",5)
      end
      if v.Name == "GlitchAmbush"  and Options.Notify.Value["GlitchAmbush"] then
        Notify("Glitch Ambush 已生成",5)
      end
      if v.Name == "Eyes"  and Options.Notify.Value["Eyes"] then
        Notify("Eyes 已生成",5)
      end
      
      if v.Name == "Lookman"  and Options.Notify.Value["Eyes"] then
        Notify("Eyes 已生成",5)
      end
      
      if v.Name == "BackdoorRush"  and Options.Notify.Value["Blitz"] then
        Notify("Blitz 已生成",5)
      end
      
      if v.Name == "BackdoorLookman"  and Options.Notify.Value["Lookman"] then
        Notify("Lookman 已生成",5)
      end
      
      if v.Name == "JeffTheKiller"  and Options.Notify.Value["Jeff"] then
        Notify("Jeff 已生成",5)
      end
    end
    if Toggles.Entity.Value then
      
      
      if  v.Name == "RushMoving"  then
        AddEntityESP(v, "Rush", EntityColor)
      end
      if v.Name == "AmbushMoving"  then
        AddEntityESP(v, "Ambush", EntityColor)
      end
      if  v.Name == "A60"  then
        AddEntityESP(v, "A-60", EntityColor)
        IsMoving = false
      end
      if v.Name == "A120"  then
        AddEntityESP(v, "A-120", EntityColor)
        IsMoving = false
      end
      if v.Name == "GlitchRush"  then
        AddEntityESP(v, "Glitch Rush", EntityColor)
      end
      if v.Name == "GlitchAmbush"  then
        AddEntityESP(v, "Glitch Ambush", EntityColor)
      end
      if v.Name == "Eyes" or v.Name == "Lookman" then
        AddEntityESP(v, "Eyes", EntityColor)
      end
      if v.Name == "BackdoorRush"   then
        AddEntityESP(v, "Blitz", EntityColor)
      end
      
      if v.Name == "BackdoorLookman" then
        AddEntityESP(v, "Lookman", EntityColor)
      end
      
      if v.Name == "JeffTheKiller" then
        AddEntityESP(v, "Jeff", EntityColor)
      end
      
      
    end
    
    
  end))
  
  
  table.insert(Connections,LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
  
  if Toggles.GateLever.Value then
    
    local OldLever = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") - 1]:FindFirstChild("LeverForGate",true)
    if OldLever then
      ESPLibrary:RemoveESP(OldLever)
    end
    
    local OldLever = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") + 1]:FindFirstChild("LeverForGate",true)
    if OldLever then
      ESPLibrary:RemoveESP(OldLever)
    end
    
    local Lever = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:FindFirstChild("LeverForGate",true)
    if Lever then
      AddESP(Lever, "门闸", LeverColor)
    end
    
    
  end
  if Toggles.Objective.Value then
    local OldKey = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") - 1]:FindFirstChild("KeyObtain",true)
    if OldKey then
      ESPLibrary:RemoveESP(OldKey)
    end
    
    local OldKey = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") + 1]:FindFirstChild("KeyObtain",true)
    if OldKey then
      ESPLibrary:RemoveESP(OldKey)
    end
    
    local Key = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:FindFirstChild("KeyObtain",true)
    if Key then
      AddESP(Key, "钥匙", Color3.new(0, 1, 1))
    end
    
    
    local OldKey = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") - 1]:FindFirstChild("ElectrialKeyObtain",true)
    if OldKey then
      ESPLibrary:RemoveESP(OldKey)
    end
    
    local OldKey = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") + 1]:FindFirstChild("ElectrialKeyObtain",true)
    if OldKey then
      ESPLibrary:RemoveESP(OldKey)
    end
    
    local Key = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:FindFirstChild("ElectrialKeyObtain",true)
    if Key then
      AddESP(Key, "电气间钥匙", Color3.new(0, 1, 1))
    end
    
  end
  
  
  
  if Toggles.HidingPlace.Value then
    for _, v in pairs(Closets) do
      if v:IsDescendantOf(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") - 1]) or v:IsDescendantOf(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") + 1]) then
        ESPLibrary:RemoveESP(v)
      end
      local Nam =  HidingPlaces[v.Name]
      if Nam and v:IsDescendantOf(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")])then
        AddESP(v, Nam, HidingPlaceColor)
      end
      
    end
    
  end
  if Toggles.Door.Value then
    local OldDoor = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") - 1].Door.Door
    if OldDoor then
      ESPLibrary:RemoveESP(OldDoor)
      if OldDoor:FindFirstChild("CrossBoards") then
        ESPLibrary:RemoveESP(OldDoor:FindFirstChild("CrossBoards"))
      end
    end
    
    
    
    local Doo = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") + 1].Door.Door
    if Doo:FindFirstChild("CrossBoards") then
      AddESP(Doo.CrossBoards, "",  DoorColor)
      AddESP(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")].Door.Door.CrossBoards, "", DoorColor)
    end
    
    AddESP(Doo, "门 " .. Doo.Parent:GetAttribute("RoomID"), DoorColor)
    AddESP(workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")].Door.Door, "门 " .. workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")].Door:GetAttribute("RoomID"), DoorColor)
  end
  
  
  
  
  
end))

BypassEntityBox:AddToggle('EyesDamage',{
Text = "防 Eyes",
Default = false
})




BypassEntityBox:AddToggle('LookmanDamage',{
Text = "防 Lookman",
Default = false
})


BypassEntityBox:AddToggle('GloomEggDamage',{
Text = "防 Gloom",
Default = false,
Callback = function(Value)
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
  if v.Name == "GloomEgg" then
    for _, i in pairs(v:GetChildren()) do
      if i:IsA("BasePart")  then
        
        i.CanTouch = not Value
      end
    end
  end
end
end
})







HotelFloor:AddToggle('NotifyLibraryCode',{
Text = "图书馆提示密码",
Disabled = Floor.Value ~= "Hotel" and RemotesFolder.Name ~= "Bricks" and Floor.Value ~= "Fools" and Floor.Value ~= "Fools26" and true or false,

Default = false,
})

HotelFloor:AddToggle('SeekObf',{
Text = "防Seek障碍",
Default = false,
Disabled = Floor.Value == "Retro" and true or false,
Callback = function(Value)

for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
  if v.Name == "Seek_Arm" or v.Name == "ChandelierObstruction" then
    for _, i in pairs(v:GetChildren()) do
      if i:IsA("BasePart") then
        i.CanTouch = not Value
      end
    end
    
  end
end

end
})



BypassEntityBox:AddToggle('FigureHearing',{
Text = "防 Figure",
Default = false,
Disabled = Floor.Value == "Fools" and true or false,
DisabledTooltip = "此楼层不支持功能",
Callback = function(Value)
if not Value then
  RemotesFolder.Crouch:FireServer(false)
else
  RemotesFolder.Crouch:FireServer(true)
  
end

end
})


BypassEntityBox:AddToggle('AntiLag',{
Text = "低画质",
Default = false,
Callback = function(Value)
if Value then
  for _, v in workspace.CurrentRooms:GetDescendants() do
    if v:IsA("BasePart") then
      v:SetAttribute("Mat", v.Material)
      v.Material = "Plastic"
    end
  end
else
  
  for _, v in workspace.CurrentRooms:GetDescendants() do
    if v:IsA("BasePart") then
      if v:GetAttribute("Mat") then
        v.Material = v:GetAttribute("Mat") or "Plastic"
      end
    end
  end
  
  
end
end
})
BypassEntityBox:AddLabel('觉得卡了就关',true)

ReachBox:AddToggle('PromptReach',{
Text = "远程交互",
Default = false,
Callback = function(Value)
if Value then
  for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
      v:SetAttribute("Range", v.MaxActivationDistance)
      v.MaxActivationDistance = v.MaxActivationDistance * 2
    end
  end
  
else
  
  for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
      v.MaxActivationDistance = v:GetAttribute("Range") or v.MaxActivationDistance
    end
  end
end


end
})




ReachBox:AddToggle('PromptClip',{
Text = "穿墙交互",
Default = false,
Callback = function(Value)
if Value then
  for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
      v:SetAttribute("Clip", v.RequiresLineOfSight)
      v.RequiresLineOfSight = false
    end
  end
  
else
  
  for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
      v.RequiresLineOfSight = v:GetAttribute("Clip") or true
    end
  end
end


end
})

ReachBox:AddToggle('DoorReach',{
Text = "开门距离",
Default = false
})

LadderColor = Color3.new(0, 0, 1)
FuseColor = Color3.new(0.2, 0.5, 0.3)
ESPBox:AddToggle('Ladder',{
Text = "梯子",
Default = false,
Callback = function(Value)

if Value then
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "Ladder" then
      AddESP(v, "梯子",LadderColor)
    end
  end
  
else
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "Ladder" then
      ESPLibrary:RemoveESP(v)
    end
  end
  
  
end

end
}):AddColorPicker("ColorPicker2", {
Default = LadderColor,
Title = "梯子 ESP 颜色",

Callback = function(Value)
LadderColor = Value
Toggles.Ladder:SetValue(false)
Toggles.Ladder:SetValue(true)
end,
})
ESPBox:AddToggle('Fuse',{
Text = "保险丝",
Default = false,
Callback = function(Value)

if Value then
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "FuseObtain" then
      AddESP(v, "保险丝",FuseColor)
    end
  end
  
else
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v.Name == "FuseObtain" then
      ESPLibrary:RemoveESP(v)
    end
  end
  
  
end

end
}):AddColorPicker("ColorPicker2", {
Default = FuseColor,
Title = "保险丝 ESP 颜色",

Callback = function(Value)
FuseColor = Value
Toggles.Fuse:SetValue(false)
Toggles.Fuse:SetValue(true)
end,
})

PlayerColor = Color3.new(1, 1, 1)


ESPBox:AddToggle('Player', {
Text = "玩家",
Default = false,
Callback = function(Value)
for _, v in pairs(Players:GetPlayers()) do
  if v ~= LocalPlayer and v.Character then
    ESPLibrary:RemoveESP(v.Character)
    if Value then
      local hum = v.Character:FindFirstChildOfClass("Humanoid")
      if hum and hum.Health > 0 then
        AddESP(v.Character, v.Name .. " [" .. math.floor((hum.Health / hum.MaxHealth) * 100) .. "%]", PlayerColor)
        
        
      end
    end
  end
end
end
}):AddColorPicker("ColorPicker99", {
Default = PlayerColor,
Title = "玩家 ESP 颜色",
Callback = function(Value)
PlayerColor = Value
Toggles.Player:SetValue(false)
Toggles.Player:SetValue(true)
end,
})








BypassBox:AddToggle('LadderBypass',{
Text = "梯子绕过",
Default = false,
Callback = function(Value)

if not Value then
  RemotesFolder:FindFirstChild("ClimbLadder"):FireServer()
end
end
})


BypassBox:AddDivider()
BypassBox:AddLabel("无限十字架仅仅对A-60 A-120 Rush Ambush有效 设备卡和网卡的话可能不生效",true)
BypassBox:AddToggle('InfCrucifix',{
Text = "无限十字架",
Risky = true,
Disabled = Floor.Value == "Rooms" and Floor.Value == "Outdoors" and true or false,
})
BypassBox:AddDivider()



local Stored = {}

local Names = {
Lock = true,
ChestBoxLocked = true,
Cellar = true,
Chest_Vine = true,
CuttableVines = true,
SkullLock = true,
Toolbox_Locked = true,
Lock1 = true,
Lock2 = true,
}




local function InfPrompt(Prompt)
  local Char = LocalPlayer.Character
  if not Char then return end
  
  local RootPart = Char:FindFirstChild("HumanoidRootPart")
  if not RootPart then return end
  
  local Tool = Char:FindFirstChild("Lockpick") or Char:FindFirstChild("SkeletonKey") or Char:FindFirstChild("Shears")
  local Name = Tool and Tool.Name
  
  if Tool then
    if Prompt:GetAttribute("InfItems") and Prompt:GetAttribute("Tool") ~= Name then
      if Prompt.Parent then
        local ExistingPrompt = Prompt.Parent:FindFirstChild("InfPrompt")
        if ExistingPrompt then
          ExistingPrompt:Destroy()
        end
        Prompt:SetAttribute("InfItems", nil)
        Prompt.Enabled = true
      end
    end
    
    if not Prompt:GetAttribute("InfItems") then
      Prompt.Enabled = false
      Prompt:SetAttribute("InfItems", true)
      Prompt:SetAttribute("Tool", Name)
      Prompt.ClickablePrompt = false
      
      local Clone = Prompt:Clone()
      Clone.Name = "InfPrompt"
      Clone.MaxActivationDistance = Prompt.MaxActivationDistance * 0.5
      Clone.Parent = Prompt.Parent
      Clone.Enabled = true
      Clone.ClickablePrompt = true
      
      local Con
      Con = Clone.Triggered:Connect(function()
      Con:Disconnect()
      Clone:Destroy()
      
      if Char:FindFirstChild(Name) then
        task.spawn(function()
        local Drop = nil
        local StartTime = tick()
        
        repeat
          RemotesFolder.DropItem:FireServer(Tool)
          task.wait(0.01)
          
          local ClosestDist = 15
          for _, v in ipairs(workspace.Drops:GetChildren()) do
            if v.Name == Name then
              local Dist = GetDistanceToPlayer(v:GetPivot().Position)
              if Dist < ClosestDist then
                ClosestDist = Dist
                Drop = v
              end
            end
          end
          until Drop or not Char:FindFirstChild(Name) or (tick() - StartTime) > 3
          
          if Name == "Shears" then
            fireproximityprompt(Prompt)
            if Drop then
              local DropPrompt = Drop:FindFirstChildWhichIsA("ProximityPrompt", true)
              if DropPrompt then fireproximityprompt(DropPrompt) end
            end
          else
            if Drop then
              local DropPrompt = Drop:FindFirstChildWhichIsA("ProximityPrompt", true)
              if DropPrompt then fireproximityprompt(DropPrompt) end
            end
            fireproximityprompt(Prompt)
          end
          
          Prompt:SetAttribute("InfItems", nil)
          Prompt:SetAttribute("Tool", nil)
          Prompt.Enabled = true
          Prompt.ClickablePrompt = true
        end)
      else
        Prompt:SetAttribute("InfItems", nil)
        Prompt:SetAttribute("Tool", nil)
        Prompt.Enabled = true
        Prompt.ClickablePrompt = true
      end
    end)
  end
elseif (Char:FindFirstChild("Key") or Char:FindFirstChild("Fuse")) and Prompt:GetAttribute("InfItems") then
  if Prompt.Parent then
    local ExistingPrompt = Prompt.Parent:FindFirstChild("InfPrompt")
    if ExistingPrompt then
      ExistingPrompt:Destroy()
    end
  end
  Prompt:SetAttribute("InfItems", nil)
  Prompt:SetAttribute("Tool", nil)
  Prompt.Enabled = true
  Prompt.ClickablePrompt = true
end
end




BypassBox:AddToggle('InfItems',{
Text = "无限使用道具",
Disabled = Floor.Value == "Fools" and RemotesFolder.Name == "Bricks" and not Firepp and true or false,
Callback = function(Value)
if Value then
  for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
      if Names[v.Parent.Name] or v.Name == "FusesPrompt" or v.Parent.Parent.Name == "Locker_Small_Locked" then
        table.insert(Stored, v)
        
      end
    end
  end
else
  for _, Prompt in pairs(workspace.CurrentRooms:GetDescendants()) do
    if Prompt:IsA("ProximityPrompt") then
      if Names[Prompt.Parent.Name] then
        if Prompt:GetAttribute("InfItems") then
          local Fake = Prompt.Parent:FindFirstChild("InfPrompt")
          if Fake then
            Fake:Destroy()
          end
          Prompt:SetAttribute("InfItems", nil)
          Prompt.Enabled = true
        end
        
      end
    end
  end
  
  table.clear(Stored)
end

end
})






local InfParams = RaycastParams.new()
InfParams.FilterType = Enum.RaycastFilterType.Exclude



local AutoInteract = 0
local AutoLibrary = 0
local AutoAnchorSolver  = 0
local NotifyCode = 0
local InfItemsDelay = 0
local PlayerESP = 0
local DoorReach = 0


table.insert(Connections,RunService.RenderStepped:Connect(function(dt)

AutoInteract += dt
NotifyCode += dt
AutoAnchorSolver += dt
InfItemsDelay += dt
PlayerESP += dt

AutoLibrary += dt
DoorReach += dt


if Toggles.FakeRevive.Value then
  local Char = LocalPlayer.Character
  if Char.Humanoid.Health == 0 then
    Char.Humanoid.Health = 100
    Notify("你需要任何治疗来物品才能交互", 5)
    Char.HumanoidRootPart.Anchored = true
    Camera.CameraType = "Custom"
    LocalPlayer:SetAttribute("Alive", true)
    if not Char:GetAttribute("FakeRevived") then
      Char:SetAttribute("FakeRevived",true)
    end
    
  end
  
  
  if Char:GetAttribute("FakeRevived") then
    
    
    if Char.Humanoid.BreakJointsOnDeath ~= false then
      Char.Humanoid.BreakJointsOnDeath = false
    end
    
    if Char.Humanoid.RequiresNeck ~= false then
      Char.Humanoid.RequiresNeck = false
    end
    
    if Char.Humanoid.PlatformStand ~= false then
      Char.Humanoid.PlatformStand = false
    end
    
    if Char.Humanoid.Health <= 0 then
      Char.Humanoid.Health = 0.1
    end
    
    Char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    
    Char.Humanoid.Sit = false
    
    if Char:FindFirstChild("HumanoidRootPart") then
      Char.HumanoidRootPart.Anchored = false
    end
    
    if Char:FindFirstChild("CollisionPart") and Char.CollisionPart.Anchored ~= false then
      Char.CollisionPart.Anchored = false
    end
    
    if LocalPlayer.PlayerGui.MainUI.Initiator:FindFirstChild("Death") then
      LocalPlayer.PlayerGui.MainUI.Initiator.Death:Destroy()
    end
    
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
    
    
    Char.Humanoid.AutomaticScalingEnabled = true
    Char:SetAttribute("Stunned", false)
    LocalPlayer.PlayerGui.MainUI.Initiator:FindFirstChild("Main_Game").Health.Enabled = not LocalPlayer.PlayerGui.MainUI.Initiator:FindFirstChild("Main_Game").Health.Enabled
    
    
  end
  
end



if not LocalPlayer:GetAttribute("Alive") then
  if Toggles.InfRevive.Value then
    
    RemotesFolder.Revive:FireServer()
  end
  
  if CollisionClone then
    CollisionClone = nil
  end
  return
end



if Camera ~= workspace.CurrentCamera then
  Camera = workspace.CurrentCamera
end

if not LocalPlayer.Character:GetAttribute("Climbing") and Toggles.EnableMovementSpeed.Value then
  if LocalPlayer.Character.Humanoid.WalkSpeed ~= Options.MovementSpeed.Value then
    LocalPlayer.Character.Humanoid.WalkSpeed = Options.MovementSpeed.Value
  end
elseif LocalPlayer.Character:GetAttribute("Climbing") and Toggles.EnableClimbingSpeed.Value then
  if LocalPlayer.Character.Humanoid.WalkSpeed ~= Options.ClimbingSpeed.Value then
    LocalPlayer.Character.Humanoid.WalkSpeed = Options.ClimbingSpeed.Value
  end
end

if Toggles.ThirdPerson.Value then
  Camera.CFrame = Camera.CFrame * CFrame.new(Options.X.Value, Options.Y.Value, Options.Z.Value)
end

for _, v in pairs(LocalPlayer.Character:GetChildren()) do
  if v:IsA("BasePart") and (v.Name == "Head" or v.Name == "FakeHead") then
    v.Transparency = Toggles.ThirdPerson.Value and 0 or 1
    v.LocalTransparencyModifier = Toggles.ThirdPerson.Value and 0 or 1
  end
  
  if v:IsA("Accessory") then
    local handle = v:FindFirstChild("Handle")
    if handle then
      handle.Transparency = Toggles.ThirdPerson.Value and 0 or 1
      handle.LocalTransparencyModifier = Toggles.ThirdPerson.Value and 0 or 1
    end
  end
end




Camera.FieldOfView = Options.FOV.Value










if Toggles.Freecam.Value then
  local char = LocalPlayer.Character
  local hum = char and char:FindFirstChild("Humanoid")
  local root = char and char:FindFirstChild("HumanoidRootPart")
  if root and not root.Anchored then root.Anchored = true end
  
  if not workspace:FindFirstChild("FreecamPart") then
    
    
    
    
    local part = Instance.new("Part")
    part.Name = "FreecamPart"
    part.Size = Vector3.new(0.01, 0.01, 0.01)
    part.Transparency = 1
    part.CanCollide = false
    part.Anchored = true
    part.CFrame = Camera.CFrame
    part.Parent = workspace
    
    LocalPlayer:SetAttribute("fc_om", LocalPlayer.CameraMinZoomDistance)
    LocalPlayer:SetAttribute("fc_ox", LocalPlayer.CameraMaxZoomDistance)
    LocalPlayer.CameraMinZoomDistance = 0
    LocalPlayer.CameraMaxZoomDistance = 0
    
    local rx, ry, rz = Camera.CFrame:ToOrientation()
    LocalPlayer:SetAttribute("fc_p", math.deg(rx))
    LocalPlayer:SetAttribute("fc_y", math.deg(ry))
  end
  
  local fcPart = workspace:FindFirstChild("FreecamPart")
  local curCam = Camera
  
  if fcPart and curCam then
    local delta = UserInputService:GetMouseDelta()
    local sensitivity = UserInputService.KeyboardEnabled and 0.3 or 0.6
    
    local pitch = (LocalPlayer:GetAttribute("fc_p") or 0) - (delta.Y * sensitivity)
    local yaw = (LocalPlayer:GetAttribute("fc_y") or 0) - (delta.X * sensitivity)
    pitch = math.clamp(pitch, -80, 80)
    
    LocalPlayer:SetAttribute("fc_p", pitch)
    LocalPlayer:SetAttribute("fc_y", yaw)
    
    fcPart.CFrame = CFrame.new(fcPart.Position) * CFrame.fromOrientation(math.rad(pitch), math.rad(yaw), 0)
    curCam.CFrame = fcPart.CFrame
    curCam.Focus = curCam.CFrame * CFrame.new(0, 0, -10)
    
    if hum and hum.MoveDirection.Magnitude > 0 then
      local speed = 75
      local moveVec = hum.MoveDirection
      local localMove = curCam.CFrame:VectorToObjectSpace(moveVec)
      local finalMove = (curCam.CFrame.RightVector * localMove.X) + (curCam.CFrame.LookVector * -localMove.Z)
      
      fcPart.Position = fcPart.Position + (finalMove * speed * dt)
    end
  end
end












if Toggles.DeleteFigureFE.Value and Figures then
  for _, v in pairs(Figures) do
    local Root = v:FindFirstChild("Root")
    if not IsNetworkOwner then
      Notify("抱歉你的执行器不支持删除Figure 因为执行器能力不足（", 5)
      Toggles.DeleteFigureFE:SetValue(false)
    end
    if Root and isnetworkowner(Root) then
      if Root:FindFirstChild("BodyForce") then
        Root.BodyForce.Force = Vector3.new(0, -50000, 0)
      else
        Root:PivotTo(CFrame.new(0, -50000, 0))
      end
      
      for _, part in pairs(v:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
          part.CanCollide = false
          part.Anchored = false
        end
      end
      
      if Root.Position.Y < -1000 and not v:GetAttribute("Deleted") then
        Notify("成功删除Figure", 4)
        v:SetAttribute("Deleted", true)
      end
    end
  end
end






if Toggles.AutoAnchorSolver.Value and LatestRoom.Value == 50 and AutoAnchorSolver > 0.5  then
  
  AutoAnchorSolver = 0
  local Hint = LocalPlayer.PlayerGui.MainUI:FindFirstChild("AnchorHintFrame")
  if Anchors and Hint and Hint.Visible then
    local ID = Hint.AnchorCode.Text
    for _, v in pairs(Anchors) do
      if v:FindFirstChild("Sign") and v.Sign.TextLabel.Text == ID then
        
        
        local Code = Hint.Code.Text
        local Note = v:FindFirstChild("Note")
        local NoteText = Note and Note.SurfaceGui.TextLabel.Text or ""
        local Mod = tonumber(string.match(NoteText, "%d+")) or 0
        local Final = ""
        for i = 1, #Code do
          local Digit = tonumber(string.sub(Code, i, i)) or 0
          local Res = string.find(NoteText, "+") and (Digit + Mod) % 10 or (Digit - Mod) % 10
          Final = Final .. tostring(Res < 0 and Res + 10 or Res)
        end
        local Dis = (LocalPlayer.Character.HumanoidRootPart.Position - v:GetPivot().Position).Magnitude
        if Dis < 20 then
          local AnchorRemote = v:FindFirstChildOfClass("RemoteFunction")
          if AnchorRemote then
            AnchorRemote:InvokeServer(tostring(Code))
          end
          Notify("锚点 " .. Final, 1)
        end
      end
      
    end
  end
end






















if Toggles.AutoMinecart.Value and Camera:FindFirstChild("MinecartRig") then
  if LatestRoom.Value < 49 then
    if not LocalPlayer:GetAttribute("NotifyMinecart") then
      Notify("[自动矿车] 不要乱移动", 5)
      LocalPlayer:SetAttribute("NotifyMinecart", true)
    end
    
    local Root = LocalPlayer.Character.HumanoidRootPart
    local ClosestDuckDist = math.huge
    
    for _, v in pairs(DuckBoards) do
      local Dist = GetDistanceToPlayer(v:GetPivot().Position)
      if Dist < ClosestDuckDist then
        ClosestDuckDist = Dist
      end
    end
    
    if RequiredMainGame.crouching ~= (ClosestDuckDist < 30) then
      RequiredMainGame.crouching = (ClosestDuckDist < 30)
    end
    
    local CurrentNode = nil
    local MinDist = math.huge
    for _, Node in pairs(Nodes) do
      if Node:GetAttribute("ForceConnect") then
        local Dist = (Root.Position - Node.Position).Magnitude
        if Dist < MinDist then
          MinDist = Dist
          CurrentNode = Node
        end
      end
    end
    if CurrentNode then
      local CurrentNum = tonumber(string.match(CurrentNode.Name, "%d+"))
      if CurrentNum then
        local Node1
        for _, Node in pairs(Nodes) do
          if Node.Name == "MinecartNode" .. tostring(CurrentNum + 3) then
            Node1 = Node
            break
          end
        end
        
        if Node1 then
          local DistToNode = GetDistanceToPlayer(CurrentNode.Position)
          
          if DistToNode > 30 then
            require(LocalPlayer.PlayerScripts.PlayerModule):GetControls().GetMoveVector = function()
            return Vector3.new(0, 0, -1)
          end
          
        else
          local DirectionToNode = (CurrentNode.Position - Node1.Position).Unit
          local Dot = DirectionToNode:Dot(CurrentNode.CFrame.RightVector)
          
          require(LocalPlayer.PlayerScripts.PlayerModule):GetControls().GetMoveVector = function()
          if Dot > 0.15 then
            return Vector3.new(1, 0, 0)
          elseif Dot < -0.15 then
            return Vector3.new(1, 0, 0)
          end
          return Vector3.new(0, 0, -1)
        end
      end
    end
  end
end
elseif LatestRoom.Value >= 50 then
  if LocalPlayer:GetAttribute("NotifyMinecart") then
    Notify("[自动矿车] 可以移动了", 5)
    LocalPlayer:SetAttribute("NotifyMinecart", false)
  end
  Toggles.AutoMinecart:SetValue(false)
  require(LocalPlayer.PlayerScripts.PlayerModule):GetControls().GetMoveVector = Control
end
end























if Toggles.InfItems.Value and InfItemsDelay > 0.15 then
  InfItemsDelay = 0
  for _, Prompt in pairs(Stored) do
    InfPrompt(Prompt)
  end
end




if Toggles.NotifyLibraryCode.Value and NotifyCode >  5 then
  NotifyCode = 0
  local Code = GetLibraryCode()
  if Code and LatestRoom.Value == 50 then
    Notify("密码 " .. Code)
  end
end



if Toggles.Flight.Value then
  if not LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlightVelocity") then
    local Velocity = Instance.new("BodyVelocity", LocalPlayer.Character.HumanoidRootPart)
    Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    Velocity.Velocity = Vector3.zero
    Velocity.Name = "FlightVelocity"
    Velocity.P = math.huge
  end
  
  if OldAccel then
    LocalPlayer.Character.HumanoidRootPart.CustomPhysicalProperties = OldAccel
  end
  
  local moveDir = LocalPlayer.Character.Humanoid.MoveDirection
  local flatLook = Camera.CFrame.LookVector * Vector3.new(1, 0, 1)
  
  if flatLook.Magnitude < 0.001 then
    flatLook = Camera.CFrame.UpVector * Vector3.new(1, 0, 1) * math.sign(-Camera.CFrame.LookVector.Y)
  end
  
  local flatCam = CFrame.lookAt(Vector3.zero, flatLook)
  local localInput = flatCam:VectorToObjectSpace(moveDir)
  
  LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlightVelocity").Velocity = Camera.CFrame:VectorToWorldSpace(localInput) * Options.FlightSpeed.Value
end




if Toggles.AutoHiding.Value then
  local Closet = GetNearestHidingSpot()
  if Closet then
    for _, v in pairs(workspace:GetChildren()) do
      local Monster = AutoClosetTable[v.Name]
      if Monster then
        local MainPart = v:FindFirstChildWhichIsA("BasePart")
        
        
        if not MainPart  then
          LocalPlayer.Character:SetAttribute("Hiding", false)
        else
          local Dis = GetDistanceToPlayer(MainPart.Position)
          
          if Dis < Monster then
            if not LocalPlayer.Character.PrimaryPart.Anchored then
              fireproximityprompt(Closet:FindFirstChildOfClass("ProximityPrompt"))
            end
          else
            LocalPlayer.Character:SetAttribute("Hiding", false)
          end
        end
      end
    end
  end
end




if Toggles.Godmode.Value then
  if RemotesFolder.Name == "RemotesFolder" then
    if not Toggles.FigureHearing.Value then
      Notify("请开启防飞哥功能 无敌模式需要", 3)
      Toggles.FigureHearing:SetValue(true)
    end
    
    if LocalPlayer.Character.LowerTorso.Root.C1 ~= CFrame.new(0, -2.3, 0) then
      LocalPlayer.Character.LowerTorso.Root.C1 = CFrame.new(0, -2.3, 0)
    end
    
    if LocalPlayer.Character.Humanoid.HipHeight ~= 0.22 then
      LocalPlayer.Character.Humanoid.HipHeight = 0.22
    end
    
    if LocalPlayer.Character.Collision.Size ~= Vector3.new(1, 1, 4) then
      LocalPlayer.Character.Collision.Size = Vector3.new(1, 1, 4)
    end
    
    if LocalPlayer.Character.Collision.CollisionCrouch.Size ~= Vector3.new(1, 1, 4) then
      LocalPlayer.Character.Collision.CollisionCrouch.Size = Vector3.new(1, 1, 4)
    end
  end
  
  if (Floor.Value == "Fools" or RemotesFolder.Name == "Bricks") and not Toggles.NoClip.Value then
    Toggles.NoClip:SetValue(true)
  end
end


if not LocalPlayer.Character:FindFirstChild("CollisionClone") then
  if LocalPlayer.Character:FindFirstChild("CollisionPart") then
    CollisionClone = LocalPlayer.Character.CollisionPart:Clone()
    CollisionClone.Parent = LocalPlayer.Character
    CollisionClone.Name = "CollisionClone"
    CollisionClone.RootPriority = 127
    CollisionClone.Anchored = false
    CollisionClone.CanCollide = false
    
    
    if CollisionClone:FindFirstChild("CollisionCrouch") then
      CollisionClone:FindFirstChild("CollisionCrouch"):Destroy()
    end
  end
  
end

if Toggles.NoScenes.Value and LatestRoom.Value == 100 then
  Toggles.NoScenes:SetValue(false)
end
if not HookMeta then
  if Toggles.FigureHearing.Value then
    if RemotesFolder:FindFirstChild("Crouch") then
      
      RemotesFolder.Crouch:FireServer(true)
    end
  end
end











if Toggles.InfCrucifix.Value and not Toggles.Godmode.Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
  local Origin = LocalPlayer.Character.HumanoidRootPart.Position
  
  for _, Entity in pairs(workspace:GetChildren()) do
    local Range = InfCrucfixTable[Entity.Name]
    if Range and Entity.PrimaryPart then
      local Target = Entity.PrimaryPart.Position
      
      if (Origin - Target).Magnitude < Range then
        InfParams.FilterDescendantsInstances = {LocalPlayer.Character, Entity}
        
        if not workspace:Raycast(Origin, Target - Origin, InfParams) then
          local Tool = LocalPlayer.Character:FindFirstChild("Crucifix")
          if Tool then
            RemotesFolder.DropItem:FireServer(Tool)
            repeat task.wait()
              local Drop = workspace.Drops:FindFirstChild("Crucifix")
              if Drop and Drop:FindFirstChildOfClass("ProximityPrompt") then
                fireproximityprompt(Drop:FindFirstChildOfClass("ProximityPrompt"))
              end
              until LocalPlayer.Character:FindFirstChild("Crucifix")
            end
          end
        end
      end
    end
  end
  
  
  
  if Toggles.AutoLibraryCode.Value then
    
    if LatestRoom.Value == 50 then
      local Code = GetLibraryCode()
      if Code then
        if Toggles.BruteForceLibCode.Value and string.find(Code, "_") then
          local Bruted = ""
          for i = 1, #Code do
            local char = string.sub(Code, i, i)
            Bruted ..= (char == "_" and math.random(0, 9) or char)
          end
          Code = Bruted
        end
        PL:FireServer(Code)
      end
    end
  end
  
  
  
  if Toggles.DoorReach.Value and DoorReach > 0.2 then
    DoorReach = 0
    local Door = workspace.CurrentRooms[LatestRoom.Value].Door
    if Door.Parent and Door.Parent.Name ~= "101" and GetDistanceToPlayer(Door.Door.Position) < 30 then
      
      Door.ClientOpen:FireServer()
    end
  end
  
  if Toggles.NoAcc.Value then
    if not Toggles.Flight.Value then
      if LocalPlayer.Character.HumanoidRootPart.CustomPhysicalProperties ~= PhysicalProperties.new(100, 0.1, 0.1, 0.1, 0.1) then
        LocalPlayer.Character.HumanoidRootPart.CustomPhysicalProperties = PhysicalProperties.new(100, 0.1, 0.1, 0.1, 0.1)
      end
    end
  end
  
  if Toggles.EnableJump.Value then
    if not LocalPlayer.Character:GetAttribute("CanJump") then
      LocalPlayer.Character:SetAttribute("CanJump",true)
    end
    
  end
  
  if Toggles.EnableSlide.Value then
    if not LocalPlayer.Character:GetAttribute("Sliding") then
      LocalPlayer.Character:SetAttribute("Sliding",true)
    end
    
    
  end
  
  
  
  
  
  
  
  if Toggles.AutoInteract.Value then
    if AutoInteract > Options.AutoInteractDelay.Value then
      AutoInteract = 0
      
      if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
      
      for i,  prompt in Interactions do
        if not prompt.Parent then continue end
        
        if (prompt.Parent.Name == "GoldPile" and Floor.Value == "Fools") or prompt.Parent.Name == "KeyObtainFake" then
          continue
        end
        
        if prompt.Parent.Parent and prompt.Parent.Parent.Parent and prompt.Parent.Parent.Parent.Name == "ItemSpawns" then
          continue
        end
        if prompt:GetAttribute("InfItems")  and prompt.Name ~= "InfPrompt" then continue end
        if prompt.Parent.Name == "Mandrake" then continue end
        if  prompt:GetAttribute("Interactions") and prompt:GetAttribute("Interactions") > 0 then
          
          table.remove(Interactions, i)
        end
        if prompt.Parent:IsA("BasePart") or prompt.Parent:IsA("Model") then
          
          local TargetPart = prompt.Parent:IsA("BasePart") and prompt.Parent or (prompt.Parent.PrimaryPart or prompt.Parent:FindFirstChildWhichIsA("BasePart"))
          
          if TargetPart then
            if (LocalPlayer.Character.HumanoidRootPart.Position - TargetPart.Position).Magnitude <= Options.AutoInteractreach.Value then
              if not prompt.Enabled then
                prompt.Enabled = true
              end
              if Firepp then
                fireproximityprompt(prompt)
              else
                prompt:InputHoldBegin()
                prompt:InputHoldEnd(prompt.HoldDuration or 0)
              end
              
            end
          end
        end
      end
    end
  end
  
  
  
  
  
  if Toggles.NoFog.Value then
    
    if Lighting.FogEnd < 100000 then
      Lighting.FogEnd = 100000
    end
    
    
    for _, v in pairs(Lighting:GetChildren()) do
      if v:IsA("Atmosphere") and v.Density > 0 then
        v.Density = 0
      end
    end
    
  end
  
  if Toggles.NoCamShake.Value then
    if RequiredMainGame then
      RequiredMainGame.csgo = CFrame.new(0,0,0)
    end
  end
  
  
  
  
  if Toggles.Player.Value and PlayerESP > 1 then
    PlayerESP = 0
    for _, v in pairs(Players:GetPlayers()) do
      if v ~= LocalPlayer and v.Character then
        local hum = v.Character:FindFirstChildOfClass("Humanoid")
        if hum then
          if hum.Health > 0 then
            AddESP(v.Character, v.Name .. " [" .. math.floor((hum.Health / hum.MaxHealth) * 100) .. "%]", PlayerColor)
            
          else
            ESPLibrary:RemoveESP(v.Character)
          end
        end
      end
    end
  end
  
  
  
  
  if Toggles.LadderBypass.Value then
    if LocalPlayer.Character:GetAttribute("Climbing") then
      LocalPlayer.Character:SetAttribute("Climbing",false)
      Notify("已绕过反作弊 在Halt和追逐战会失效",5)
      
    end
    
  end
  
  
  
  
  if Toggles.EyesDamage.Value then
    if (workspace:FindFirstChild("Eyes") or workspace:FindFirstChild("Lookman")) and not LocalPlayer.Character:GetAttribute("Hiding") then
      if RemotesFolder.Name ~= "RemotesFolder" then
        MotorReplication:FireServer(0, -650, 0, false)
      else
        MotorReplication:FireServer(-650)
      end
    end
  end
  
  if Toggles.LookmanDamage.Value then
    if workspace:FindFirstChild("BackdoorLookman") then
      if not LocalPlayer.Character:GetAttribute("Hiding") then
        MotorReplication:FireServer(-650)
      end
    end
  end
  
  if Toggles.FullBright.Value then
    if Lighting.Ambient ~= Color3.new(1, 1, 1) then
      Lighting.Ambient = Color3.new(1, 1, 1)
    end
    
    if not workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:GetAttribute("OldAmbient") then
      workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:SetAttribute("OldAmbient", workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:GetAttribute("Ambient"))
    end
    
    if workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:GetAttribute("Ambient") ~= Color3.new(1, 1, 1) then
      workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]:SetAttribute("Ambient", Color3.new(1, 1, 1))
      
      
    end
    
    if LatestRoom.Value < 100 then
      if not workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") + 1]:GetAttribute("OldAmbient") then
        workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") + 1]:SetAttribute("OldAmbient", workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") + 1]:GetAttribute("Ambient"))
      end
      
      if workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") + 1]:GetAttribute("Ambient") ~= Color3.new(1, 1, 1) then
        workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom") + 1]:SetAttribute("Ambient", Color3.new(1, 1, 1))
      end
    end
  end
  
  
  if Toggles.AntiCheatMani.Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
    
    
    if Options.AntiCheatManiMethod.Value == "平移" then
      if not Toggles.NoClip.Value then
        Toggles.NoClip:SetValue(true)
      end
      
      local BodyVelocity = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityMani") or Instance.new("BodyVelocity", LocalPlayer.Character.HumanoidRootPart)
      local LookingVector = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 2
      BodyVelocity.Velocity = Vector3.new(LookingVector.X, LookingVector.Y, LookingVector.Z)
      BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
      BodyVelocity.Name = "VelocityMani"
    else
      
      
      local currentPivot = LocalPlayer.Character:GetPivot()
      LocalPlayer.Character:PivotTo(currentPivot  * CFrame.new(0, 0, 10000))
      
    end
  end
  
  
  if Options.AutoInteractKeybind:GetState() and not Toggles.AutoInteract.Value then
    Toggles.AutoInteract:SetValue(true)
    
  end
  
  
  
  if not Options.AutoInteractKeybind:GetState() and  Toggles.AutoInteract.Value then
    Toggles.AutoInteract:SetValue(false)
    
  end
  
  if Options.NoclipKeybind:GetState() and not Toggles.NoClip.Value then
    Toggles.NoClip:SetValue(true)
    
  end
  
  
  if not Options.NoclipKeybind:GetState() and  Toggles.NoClip.Value then
    Toggles.NoClip:SetValue(false)
    
  end
  
  
  if Options.ThirdpersonKeybind:GetState() and not Toggles.ThirdPerson.Value then
    Toggles.ThirdPerson:SetValue(true)
    
  end
  
  
  if not Options.ThirdpersonKeybind:GetState() and  Toggles.ThirdPerson.Value then
    Toggles.ThirdPerson:SetValue(false)
    
  end
  
  if Options.AutoHideKeybind:GetState() and not Toggles.AutoHiding.Value then
    Toggles.AutoHiding:SetValue(true)
    
  end
  
  
  if not Options.AutoHideKeybind:GetState() and  Toggles.AutoHiding.Value then
    Toggles.AutoHiding:SetValue(false)
    
  end
  
  
  if Options.AntiCheatMan:GetState() and not Toggles.AntiCheatMani.Value then
    Toggles.AntiCheatMani:SetValue(true)
    
  end
  
  
  if not Options.AntiCheatMan:GetState() and  Toggles.AntiCheatMani.Value then
    Toggles.AntiCheatMani:SetValue(false)
    
  end
  
  
  
  if Toggles.NoClip.Value then
    for _, v in ipairs(LocalPlayer.Character:GetChildren()) do
      if v:IsA("BasePart") and v.Name ~= "CollisionClone" and v.CanCollide then
        v.CanCollide = false
      end
    end
    if LocalPlayer.Character:FindFirstChild("Collision") then
      LocalPlayer.Character.Collision.CanCollide = false
      if LocalPlayer.Character.Collision:FindFirstChild("CollisionCrouch") then
        LocalPlayer.Character.Collision.CollisionCrouch.CanCollide = false
      end
    end
  end
  
  if not Toggles.NoClip.Value then
    for _, v in pairs(LocalPlayer.Character:GetChildren()) do
      if v.Name ~= "CollisionClone" and v.Name ~= "Collision" then
        if v:IsA("BasePart") and not v.CanCollide then
          v.CanCollide = true
        end
      end
    end
    
    if LocalPlayer.Character:FindFirstChild("Collision") then
      LocalPlayer.Character.Collision.CanCollide = (LocalPlayer.Character.Collision.CollisionGroup == "PlayerCrouching" and false or LocalPlayer.Character.Collision.CollisionGroup ~= "PlayerCrouching" and true)
      
      if LocalPlayer.Character.Collision:FindFirstChild("CollisionCrouch") then
        LocalPlayer.Character.Collision.CollisionCrouch.CanCollide = LocalPlayer.Character.Collision.CanCollide
      end
    end
  end
  
  
  
  
  
  
  if Toggles.FastClosetExit.Value then
    if LocalPlayer.Character:GetAttribute("Hiding") and LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0.45 then
      CamLock:FireServer()
    end
  end
  
end))




table.insert(Connections, RunService.RenderStepped:Connect(function()

if Toggles.AutoRooms.Value then
  if IsMoving then return end
  if Toggles.IgnoreA60.Value and not Toggles.Godmode.Value then
    Toggles.Godmode:SetValue(true)
    Notify("使用自动无敌模式防A-60", 5)
  end
  
  LocalPlayer.Character.Collision.Size = Vector3.new(1, 1, 3)
  
  local DangerousEntity = workspace:FindFirstChild("A120") or workspace:FindFirstChild("GlitchRush") or workspace:FindFirstChild("GlitchAmbush")
  local A60 = workspace:FindFirstChild("A60")
  
  local ShouldHide = false
  
  if DangerousEntity and DangerousEntity.PrimaryPart and DangerousEntity.PrimaryPart.Position.Y > -4 then
    ShouldHide = true
  elseif A60 and A60.PrimaryPart and A60.PrimaryPart.Position.Y > -4 then
    if not Toggles.IgnoreA60.Value then
      ShouldHide = true
    end
  end
  
  if ShouldHide then
    local Closet = GetNearestHidingSpot()
    if Closet then
      Closet.Base.CanCollide = false
      PathTo(Closet.Base.Position)
      if not LocalPlayer.Character.CollisionPart.Anchored then
        fireproximityprompt(Closet.HidePrompt)
      end
    end
  else
    LocalPlayer.Character:SetAttribute("Hiding", false)
    local CurrentRoom = workspace.CurrentRooms:FindFirstChild(tostring(LatestRoom.Value))
    if CurrentRoom then
      local TargetDoor = CurrentRoom:FindFirstChild("Door")
      if TargetDoor and TargetDoor:FindFirstChild("Door") then
        PathTo(TargetDoor.Door.Position)
      end
    end
  end
end

end))

table.insert(Connections, LatestRoom:GetPropertyChangedSignal("Value"):Connect(function()
if LocalPlayer.Character:GetAttribute("FakeRevived") then
  task.wait(0.3)
  
  LocalPlayer:SetAttribute("CurrentRoom", tonumber(LatestRoom.Value))
  
end

IsMoving = false

end))

if HookMeta then
  local Old
  Old = hookmetamethod(game, "__namecall", function(Self, ...)
  if Library.Unloaded then
    return Old(Self, ...)
  end
  
  local Method = getnamecallmethod()
  if Method == "FireServer" or Method == "InvokeServer" then
    if Toggles.AutoHeartbeat.Value and Self.Name == "ClutchHeartbeat" then
      return Old(Self, true)
    end
    if Method == "FireServer" and Toggles.FigureHearing.Value and Self.Name == "Crouch" then
      return Old(Self, true,true)
    end
  end
  return Old(Self, ...)
end)
end



















table.insert(Connections,workspace.DescendantAdded:Connect(function(v)

local timeout = 0
repeat task.wait(0.03) timeout += 0.03 until v.Parent or timeout > 0.5
  if v.Parent then
    
    if v.Parent:FindFirstChildOfClass("Humanoid") then return end
    if (v.Name == "Candle" and v.Parent.Name == "Candle" or v.Parent.Parent and v.Parent.Parent.Name == "Candle") then return end
    if  HidingPlaces[v.Name] then
      table.insert(Closets, v)
    end
    
    
    if Toggles.Ladder.Value then
      
      if v.Name == "Ladder" then
        AddESP(v, "梯子",LadderColor)
      end
      
    end
    if Toggles.Fuse.Value then
      
      if v.Name == "FuseObtain" then
        AddESP(v, "保险丝",FuseColor)
      end
      
      
    end
    if Toggles.AntiLag.Value then
      if v:IsA("BasePart") then
        v:SetAttribute("Mat", v.Material)
        v.Material = "Plastic"
      end
    end
    
    if Toggles.InfItems.Value then
      
      if v:IsA("ProximityPrompt") then
        if Names[v.Parent.Name] or v.Name == "FusesPrompt" or v.Parent.Parent.Name == "Locker_Small_Locked" then
          table.insert(Stored, v)
          
        end
      end
      
      
    end
    
    
    if Toggles.DeleteSeekFE.Value then
      if v.Name == "TriggerEventCollision" then
        Notify("正在删除 Seek", 3)
        local Part = v:FindFirstChild("Collision") or v.ChildAdded:Wait()
        if Part then
          Notify("先不要打开下一扇门", 1)
          task.wait(0.1)
          for _, Item in pairs(v:GetChildren()) do
            if Item.Name == "Collision" then
              if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if FireTouch then
                  firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Item, 0)
                  task.wait()
                  firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Item, 1)
                end
              end
            end
          end
          
          task.wait(0.5)
          
          local Success = true
          for _, Item in pairs(v:GetChildren()) do
            if Item.Name == "Collision" then
              Success = false
              break
            end
          end
          
          if Success then
            Notify("删除成功可开门", 3)
          else
            Notify("删除失败可开门", 3)
          end
        end
      end
    end
    
    
    
    if Toggles.SeekObf.Value then
      
      
      if v.Name == "Seek_Arm" or v.Name == "ChandelierObstruction" then
        for _, i in pairs(v:GetChildren()) do
          if i:IsA("BasePart") then
            i.CanTouch = false
          end
        end
        
      end
    end
    if Toggles.Breakers.Value then
      if v.Name == "LiveBreakerPolePickup" then
        AddESP(v, "电闸",BreakerColor)
        
      end
      
    end
    
    if Toggles.AutoMinecart.Value then
      
      
      
      
      if v.Name == "DuckBoard" then
        table.insert(DuckBoards, v)
      end
      
      
      if string.find(v.Name, "MinecartNode") then
        table.insert(Nodes, v)
      end
      
      
    end
    
    if Toggles.AntiSeekFlood.Value then
      
      if v.Name == "SeekFloodline" then
        v.CanCollide = true
      end
      
    end
    
    if Toggles.ShowPath.Value then
      
      if v.Name == "SeekGuidingLight" then
        ShowSeekPath(v)
      end
      
    end
    
    
    if Toggles.DeleteFigureFE.Value then
      
      if v.Name == "FigureRig" or v.Name == "FigureRagdoll" then
        table.insert(Figures,v)
      end
    end
    
    
    if Toggles.PromptClip.Value then
      
      if v:IsA("ProximityPrompt") then
        v:SetAttribute("Clip", v.RequiresLineOfSight)
        v.RequiresLineOfSight = false
      end
      
    end
    
    
    
    
    
    
    
    if Toggles.Gold.Value then
      
      
      if v.Name == "GoldPile" then
        
        AddESP(v, "金币 " .. v:GetAttribute("GoldValue"), GoldColor)
        
      end
      
    end
    if Toggles.AutoBreaker.Value then
      if v.Name == "ElevatorBreaker" then
        Breaker(v)
      end
    end
    if Toggles.PromptReach.Value then
      
      if v:IsA("ProximityPrompt") then
        v:SetAttribute("Range", v.MaxActivationDistance)
        v.MaxActivationDistance = v.MaxActivationDistance * 2
      end
      
    end
    if Toggles.Books.Value then
      
      if v.Name == "LiveHintBook" then
        AddESP(v, "书",BookColor)
        
      end
      
    end
    
    
    if Toggles.Snare.Value then
      
      if  v.Name == "Snare" then
        local wait = 0
        repeat task.wait(0.01) wait = wait  + 0.01 until wait > 1 or v:FindFirstChild("Hitbox")
          if v:FindFirstChild("Hitbox") then
            v.Hitbox.CanTouch = false
          end
        end
      end
      if Toggles.Objective.Value then
        local Bro = Items[v.Name]
        if Bro then
          AddESP(v, Bro, ItemsColor)
          
        end
        if v.Name == "MinesAnchor" then
          AddESP(v, "锚点 " .. v:WaitForChild("Sign").TextLabel.Text, ItemsColor)
        end
        
      end
      
      if Toggles.AntiLava.Value then
        if v.Name == "Lava" then
          v.CanTouch = false
        end
      end
      
      if Toggles.AntiWall.Value then
        if v.Name == "ScaryWall" then
          for _, i in pairs(v:GetChildren()) do
            if i:IsA("BasePart") then
              i.CanTouch = false
            end
            
          end
        end
        
        
      end
      if Toggles.RealBridge.Value then
        if v.Name == "Bridge" then
          if v.CanCollide == false then
            v.Transparency = Value and 0 or not Value and 1
          end
          
        end
      end
      if Toggles.Entity.Value  then
        if  v.Name == "Snare" and v:FindFirstChild("Hitbox") then
          AddEntityESP(v, "藤蔓", EntityColor)
          
        end
        
      end
      
      if Toggles.Entity.Value  then
        if v.Name == "DoorFake"  and v.Parent.Name == "SideroomDupe" then
          
          AddEntityESP(v.Door, "假门", EntityColor)
        end
        if v.Name == "GrumbleRig" then
          AddEntityESP(v, "Grumble", EntityColor)
        end
        if v.Name == "Groundskeeper" then
          AddEntityESP(v, "Ground Keeper", EntityColor)
        end
        if v.Name == "MandrakeLive" then
          AddEntityESP(v, "Man Drake", EntityColor)
        end
        if v.Name == "LiveEntityBramble" then
          AddEntityESP(v, "地刺", EntityColor)
        end
        if   v.Name == "GiggleCeiling" then
          
          local wait = 0
          repeat task.wait(0.01) wait = wait  + 0.01 until wait > 2 or v:FindFirstChild("Hitbox")
            if v:FindFirstChild("Hitbox") then
              
              AddEntityESP(v, "Giggle", EntityColor)
            end
          end
          
        end
        if Toggles.Entity.Value then
          if (v.Name == "FigureRig" or v.Name == "FigureRagdoll") then
            
            AddEntityESP(v, "Figure", EntityColor)
          end
        end
        
        
        if Toggles.Dupe.Value then
          if v.Name == "DoorFake"  and v.Parent.Name == "SideroomDupe" then
            
            v:WaitForChild("Hidden",9e9).CanTouch = false
          end
          
        end
        
        if Toggles.FixBrokenBridge.Value then
          
          if v.Name == "Bridge" then
            FixBridge(v)
          end
          
        end
        
        if Toggles.AutoAnchorSolver.Value then
          if v.Name == "MinesAnchor" then
            table.insert(Anchors,v)
          end
          
        end
        
        
        if Toggles.GloomEggDamage.Value then
          
          if v.Name == "GloomEgg" then
            repeat task.wait() until v:FindFirstChildWhichIsA("BasePart")
              for _, i in pairs(v:GetChildren()) do
                if i:IsA("BasePart")  then
                  
                  i.CanTouch = false
                end
              end
            end
          end
          
          
          
          if v:IsA("ProximityPrompt") then
            if not (PromptIgnore[v.Name] or  v.Parent.Name == "Padlock" or  v.Parent:GetAttribute("JeffShop"))  or v.Parent.Parent.Name == "RetroWardrobe" then
              table.insert(Interactions, v)
            end
            
          end
          if Toggles.Giggle.Value then
            
            if   v.Name == "GiggleCeiling" then
              
              repeat task.wait() until v:FindFirstChild("Hitbox")
                v.Hitbox.CanTouch = false
              end
            end
            
            if v:IsA("ProximityPrompt") then
              
              if Toggles.InstaInteract.Value then
                v:SetAttribute("Duration",v.HoldDuration)
                v.HoldDuration = 0
              end
            end
            
            
          end
        end))
        
        
        
        
        
        
        
        
        
        
        
        
        
        table.insert(Connections,workspace.DescendantRemoving:Connect(function(v)
        if Toggles.AutoInteract.Value then
          for i, g in pairs(Interactions) do
            
            if g ==  v then
              table.remove(Interactions, i)
              break
            end
          end
        end
        for i, g in pairs(Closets) do
          if v == g then
            table.remove(Closets, i)
          end
          
        end
        
        for i, k in pairs(Stored) do
          if v == k then
            table.remove(Stored, i)
          end
        end
        
      end))
      
      
      local MenuGroup = Tabs.Settings:AddLeftGroupbox('界面设置')
      local UtilityBox = Tabs.Settings:AddRightGroupbox('脚本作者')
      
      MenuGroup:AddLabel("菜单快捷键"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "菜单快捷键" })
      Library.ToggleKeybind = Options.MenuKeybind
      
      MenuGroup:AddToggle("ShowKeybinds", { Text = "显示快捷键列表", Default = false }):OnChanged(function()
      Library.KeybindFrame.Visible = Toggles.ShowKeybinds.Value
    end)
    MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "自定义鼠标",
    Default = true,
    Callback = function(Value)
    Library.ShowCustomCursor = Value
  end,
})
MenuGroup:AddDivider()
MenuGroup:AddToggle('PlayNotifySound',{
Text = "播放提示音效",
Default = true,
Callback = function(Value)
PlaySound = Value
end
})




MenuGroup:AddDropdown("NotificationSide", {
Values = { "左侧", "右侧" },
Default = "右侧",

Text = "提示位置",

Callback = function(Value)
Library:SetNotifySide(Value)
end,
})

MenuGroup:AddDropdown("NotifyWay", {
Values = { "Doors", "Library", "Supreme"},
Default = Notifying,

Text = "提示样式库",

Callback = function(Value)
Notifying = Value
end,
})

MenuGroup:AddButton('测试提示',function()
Notify("你好世界",2)

end)

MenuGroup:AddDropdown("Library", {
Values = { "Obsidian", "Linoria" },
Default = getgenv().ScriptLibrary,

Text = "界面库",

Callback = function(Value)
getgenv().ScriptLibrary = tostring(Value)
Notify('请卸载脚本后重新执行以生效',4)
end,
})


MenuGroup:AddDropdown("RenderESPSpeed", {
Values = { "10", "30", "60", "90", "120","144", "240"},
Default = Library.IsMobile and 2 or 6,

Text = "ESP渲染帧率",

Callback = function(Value)
ESPLibrary:SetRenderingSpeed(Value)
end,
})

MenuGroup:AddDivider()
MenuGroup:AddDropdown("DPIDropdown", {
Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
Default = "100%",

Text = "界面缩放",

Callback = function(Value)
Value = Value:gsub("%%", "")
local DPI = tonumber(Value)

Library:SetDPIScale(DPI)
end,
})
UtilityBox:AddLabel('TheHunterSolo1 - 作者与主程序员',true)

UtilityBox:AddLabel('nahhthatscrazy - 模式1移速绕过作者',true)


-- Sets the draggable label visibility

UtilityBox:AddLabel('rhyan57 - Doors提示框作者',true)
UtilityBox:AddLabel('FireBacon - ESP库作者',true)
UtilityBox:AddButton({
Text = "卸载脚本",
Func = function()
LocalPlayer:SetAttribute("SupremeLoaded", nil)
for _, con in pairs(Connections) do con:Disconnect() end

local Dread = LocalPlayer:FindFirstChild("Dread",true) or LocalPlayer:FindFirstChild("_Dread",true)

if Dread then
  Dread.Name = "Dread"
end

local Dread = ClientModules.EntityModules:FindFirstChild("Shade",true) or ClientModules.EntityModules:FindFirstChild("_Shade",true)

if Dread then
  Dread.Name = "Shade"
end

FakeA90:Destroy()
FakeScreech:Destroy()


if ReplicatedStorage:FindFirstChild("Screech") then
  ReplicatedStorage:FindFirstChild("Screech").Parent = RemotesFolder
end


local getcons = getconnections or get_signal_cons or get_relative_connections

if getcons then
  for _, con in pairs(getcons(LocalPlayer.Idled)) do
    if con.Enable then
      con:Enable()
    end
  end
end




local fcPart = workspace:FindFirstChild("FreecamPart")

if fcPart then
  
  
  
  fcPart:Destroy()
  
  local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if root then root.Anchored = false end
  
  LocalPlayer.CameraMinZoomDistance = LocalPlayer:GetAttribute("fc_om") or 0.5
  LocalPlayer.CameraMaxZoomDistance = LocalPlayer:GetAttribute("fc_ox") or 128
end




if ReplicatedStorage:FindFirstChild("A90") then
  ReplicatedStorage:FindFirstChild("A90").Parent = RemotesFolder
end


for _, v in pairs(workspace:GetDescendants()) do
  
  if v:IsA("BasePart") then
    v.CanTouch = true
  end
  if v.Name == "BridgeBarrier" then
    v:Destroy()
  end
  
end

if LocalPlayer.Character then
  LocalPlayer.Character.Humanoid.WalkSpeed = 16
  LocalPlayer.Character:SetAttribute("CanJump",false)
  for _, v in pairs(LocalPlayer.Character:GetChildren()) do
    if not (v.Name == "CollisionClone") and v:IsA("BasePart") then
      
      v.CanCollide  = true
    end
  end
  
  
  if OldAccel then
    LocalPlayer.Character.HumanoidRootPart.CustomPhysicalProperties = OldAccel
    OldAccel = nil
  end
  
  LocalPlayer.Character:SetAttribute("Sliding",false)
  
end
for _, v in ipairs(workspace:GetDescendants()) do
  if v:IsA("ProximityPrompt") then
    
    v.HoldDuration = v:GetAttribute("Duration") or
    v.HoldDuration
  end
end
if OldFogEnd then
  Lighting.FogEnd = OldFogEnd
  OldFogEnd = nil
end
for _, v in pairs(Lighting:GetChildren()) do
  if v:IsA("Atmosphere") then
    v.Density = 0.94
  end
end


if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityMani") then
  LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityMani"):Destroy()
end



Lighting.Ambient = Color3.fromRGB(0, 0, 0)
Lighting.GlobalShadows = true
for _, v in pairs(workspace.CurrentRooms:GetChildren()) do
  v:SetAttribute("Ambient", v:GetAttribute("OldAmbient") and v:GetAttribute("OldAmbient") or Color3.new(0, 0, 0))
end
FakeScreech:Destroy()
FakeA90:Destroy()

task.wait()
if RemotesFolder:FindFirstChild("A90_") then
  RemotesFolder:FindFirstChild("A90_").Name = "A90"
  
end
if RemotesFolder:FindFirstChild("Screech_") then
  local Cutscene = RemoteListener:FindFirstChild("Cutscenes") or RemoteListener:FindFirstChild("Cutscenes_")
  Cutscene.Name = "Cutscenes"
  
  
  
  RemotesFolder:FindFirstChild("Screech_").Name = "Screech"
  
end



for _, v in pairs(workspace:GetDescendants()) do
  if v:IsA("ProximityPrompt") then
    v.MaxActivationDistance = v:GetAttribute("Range") or v.MaxActivationDistance
  end
  if v.Name == "SeekFloodline" then
    v.CanCollide = false
  end
  
end

for _, Prompt in pairs(workspace.CurrentRooms:GetDescendants()) do
  if Prompt:IsA("ProximityPrompt") then
    if Prompt.Parent then
      if Names[Prompt.Parent.Name] then
        if Prompt:GetAttribute("InfItems") then
          
          local Fake = Prompt.Parent:FindFirstChild("InfPrompt")
          if Fake then
            Fake:Destroy()
          end
          
          Prompt:SetAttribute("InfItems", nil)
          Prompt.Enabled = true
          Prompt.ClickablePrompt = true
        end
        
      end
    end
  end
end


for _, v in workspace.CurrentRooms:GetDescendants() do
  if v:IsA("BasePart") then
    if v:GetAttribute("Mat") then
      v.Material = v:GetAttribute("Mat") or "Plastic"
    end
  end
end

if CollisionClone then
  CollisionClone:Destroy()
  CollisionClone = nil
end



for _, v in pairs(workspace:GetDescendants()) do
  if v:IsA("ProximityPrompt") then
    v.RequiresLineOfSight = v:GetAttribute("Clip") or true
  end
end


if PathFolder then
  PathFolder:Destroy()
  
end
if LocalPlayer.Character then
  LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position)
  LocalPlayer.Character.LowerTorso.Root.C1 = CFrame.new(Vector3.new(0, 0, 0))
end

if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlightVelocity") then
  LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlightVelocity"):Destroy()
end

if RemotesFolder:FindFirstChild("Crouch") then
  RemotesFolder.Crouch:FireServer(false)
end
if LocalPlayer.Character then
  LocalPlayer.Character.Collision.Position = LocalPlayer.Character.HumanoidRootPart.Position
  LocalPlayer.Character.Humanoid.HipHeight =2.4
  if RemotesFolder.Name ~= "RemotesFolder" then
    LocalPlayer.Character.Collision.Position = LocalPlayer.Character.HumanoidRootPart.Position
  end
end
if GodmodeFolder then Folder:Destroy()
end
if LocalPlayer.Character then
  for _, v in pairs(LocalPlayer.Character:GetChildren()) do
    if v.Name ~= "CollisionClone"  and v.Name ~= "Collision" and v.Name ~= "HumanoidRootPart" and v.Name ~= "CollisionPart" then
      if v:IsA("BasePart") then
        v.Transparency = 0
      end
    end
  end
end

if  ReplicatedStorage:FindFirstChild("LiveModifiers") and ReplicatedStorage:FindFirstChild("LiveModifiers"):FindFirstChild("Jammin") then
  
  local Jam = LocalPlayer.PlayerGui.MainUI.Initiator:FindFirstChild("Main_Game").Health.Jam
  Jam.Playing = true
  local Jamming = game:GetService("SoundService").Main.Jamming
  Jamming.Enabled =  true
end

Library:Unload()
ESPLibrary:Unload()
ShouldStop = true
end
})

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder("SupremeHub")
SaveManager:SetFolder("SupremeHub/DOORS")
SaveManager:BuildConfigSection(Tabs['Settings'])
ThemeManager:ApplyToTab(Tabs['Settings'])
SaveManager:LoadAutoloadConfig()

Notify("加载完成 |  DOORS ",4)


end

end