local repo = 'https://raw.githubusercontent.com/KingScriptAE/No-sirve-nada./refs/heads/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles
Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true
Library.NotifySide = "Right"
local Services = {
Players = game:GetService("Players"),
RunService = game:GetService("RunService"),
Workspace = game:GetService("Workspace"),
}
local LocalPlayer = Services.Players.LocalPlayer
local Camera = Services.Workspace.CurrentCamera
local ESPSettings = {
killerESP = false,
playerESP = false,
generatorESP = false,
itemESP = false,
pizzaEsp = false,
pizzaDeliveryEsp = false,
zombieEsp = false,
taphTripwireEsp = false,
tripMineEsp = false,
twoTimeRespawnEsp = false,
killerTracers = false,
survivorTracers = false,
generatorTracers = false,
itemTracers = false,
pizzaTracers = false,
pizzaDeliveryTracers = false,
zombieTracers = false,
killerSkinESP = false,
survivorSkinESP = false,
killerFillTransparency = 0.7,
killerOutlineTransparency = 0.3,
survivorFillTransparency = 0.7,
survivorOutlineTransparency = 0.3,
killerColor = Color3.fromRGB(255, 100, 100),
survivorColor = Color3.fromRGB(100, 255, 100),
generatorColor = Color3.fromRGB(255, 100, 255),
itemColor = Color3.fromRGB(100, 200, 255),
pizzaColor = Color3.fromRGB(255, 200, 0),
pizzaDeliveryColor = Color3.fromRGB(255, 150, 0),
zombieColor = Color3.fromRGB(0, 255, 0),
tripwireColor = Color3.fromRGB(255, 0, 0),
tripMineColor = Color3.fromRGB(255, 50, 50),
respawnColor = Color3.fromRGB(0, 255, 255),
}
local DummyNames = {
"PizzaDeliveryRig", "Mafiaso1", "Mafiaso2", "Builderman", "Elliot",
"ShedletskyCORRUPT", "ChancecORRUPT", "ChanceCORRUPT", "Mafia1", "Mafia2",
}
local PlayerESPData = {}
local ObjectESPData = {}
local TracerData = {}
local function IsRagdoll(model)
local ragdolls = Services.Workspace:FindFirstChild("Ragdolls")
if not ragdolls then return false end
return model:IsDescendantOf(ragdolls) or (model.Parent == ragdolls)
end
local function IsSpectating(player)
if not player then return false end
local playersFolder = Services.Workspace:FindFirstChild("Players")
if not playersFolder then return false end
local spectating = playersFolder:FindFirstChild("Spectating")
if not spectating then return false end
return spectating:FindFirstChild(player.Name) ~= nil
end
local function GetGeneratorPart(model)
if not model then return nil end
local instances = model:FindFirstChild("Instances")
if instances then
local generator = instances:FindFirstChild("Generator")
if generator then
local cube = generator:FindFirstChild("Cube.003")
if cube and cube:IsA("BasePart") then return cube end
for _, v in ipairs(generator:GetDescendants()) do
if v:IsA("BasePart") then return v end
end
end
end
for _, v in ipairs(model:GetDescendants()) do
if v:IsA("BasePart") then return v end
end
return nil
end
local function UpdatePlayerBillboardText(data)
if not data or not data.model or not data.nameLabel then return end
local model = data.model
local isKiller = data.isKiller
local actorText = model:GetAttribute("ActorDisplayName") or (isKiller and "杀手" or "幸存者")
local skinText = model:GetAttribute("SkinNameDisplay")
if actorText == "Noli" and model:GetAttribute("IsFakeNoli") == true then
actorText = actorText .. " (Fake)"
end
local displayText = actorText
local showSkin = (isKiller and ESPSettings.killerSkinESP) or (not isKiller and ESPSettings.survivorSkinESP)
if showSkin and skinText and tostring(skinText) ~= "" then
displayText = displayText .. " | " .. skinText
end
data.nameLabel.Text = displayText
if data.hpLabel then
local humanoid = model:FindFirstChild("Humanoid")
if humanoid then
local hp = math.floor(humanoid.Health)
local maxhp = math.floor(humanoid.MaxHealth)
data.hpLabel.Text = string.format("HP: %d/%d", hp, maxhp)
end
end
local highlight = model:FindFirstChild("TAOWARE_Highlight")
if highlight then
if isKiller then
highlight.FillTransparency = ESPSettings.killerFillTransparency
highlight.OutlineTransparency = ESPSettings.killerOutlineTransparency
else
highlight.FillTransparency = ESPSettings.survivorFillTransparency
highlight.OutlineTransparency = ESPSettings.survivorOutlineTransparency
end
end
end
local function UpdateGeneratorProgress(data)
if not data or not data.model or not data.progressLabel then return end
local model = data.model
local progress = model:FindFirstChild("Progress")
if progress then
local progressValue = math.floor(progress.Value)
data.progressLabel.Text = string.format("进度: %d%%", progressValue)
end
end
local function CreateESP(model, color, isGenerator, isItem, isPizza, isPizzaDelivery, isZombie, isTripwire, isTripMine, isRespawn, isKiller)
if not model then return end
if model:FindFirstChild("TAOWARE_Highlight") then return end
if isGenerator and model:FindFirstChild("Progress") and model.Progress.Value == 100 then return end
if IsRagdoll(model) then return end
local targetPart
if isGenerator then
targetPart = GetGeneratorPart(model)
elseif isItem then
targetPart = model:FindFirstChild("ItemRoot")
elseif isPizza or isPizzaDelivery or isZombie or isTripwire or isTripMine or isRespawn then
targetPart = model:IsA("BasePart") and model or model:FindFirstChildWhichIsA("BasePart", true)
else
targetPart = model:FindFirstChild("HumanoidRootPart")
end
if not targetPart then return end
local highlight = Instance.new("Highlight")
highlight.Name = "TAOWARE_Highlight"
highlight.Adornee = model
highlight.FillColor = color
highlight.OutlineColor = color
if isKiller then
highlight.FillTransparency = ESPSettings.killerFillTransparency
highlight.OutlineTransparency = ESPSettings.killerOutlineTransparency
elseif not isGenerator and not isItem and not isPizza and not isPizzaDelivery and not isZombie and not isTripwire and not isTripMine and not isRespawn then
highlight.FillTransparency = ESPSettings.survivorFillTransparency
highlight.OutlineTransparency = ESPSettings.survivorOutlineTransparency
else
highlight.FillTransparency = 0.7
highlight.OutlineTransparency = 0.3
end
highlight.Parent = model
local billboard = Instance.new("BillboardGui")
billboard.Name = "TAOWARE_Billboard"
billboard.Adornee = targetPart
billboard.Size = UDim2.new(0, 100, 0, 30)
billboard.StudsOffset = Vector3.new(0, 4, 0)
billboard.AlwaysOnTop = true
billboard.Parent = model
if not isGenerator and not isItem and not isPizza and not isPizzaDelivery and not isZombie and not isTripwire and not isTripMine and not isRespawn then
local humanoid = model:FindFirstChild("Humanoid")
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0.33, 0)
nameLabel.Position = UDim2.new(0, 0, 0, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = "Loading..."
nameLabel.Font = Enum.Font.GothamBlack
nameLabel.TextColor3 = color
nameLabel.TextSize = 8
nameLabel.TextStrokeTransparency = 0.6
nameLabel.Parent = billboard
local hpLabel = Instance.new("TextLabel")
hpLabel.Size = UDim2.new(1, 0, 0.33, 0)
hpLabel.Position = UDim2.new(0, 0, 0.3, 0)
hpLabel.BackgroundTransparency = 1
hpLabel.Text = "HP: " .. (humanoid and string.format("%.0f", humanoid.Health) or "N/A")
hpLabel.Font = Enum.Font.GothamBlack
hpLabel.TextColor3 = color
hpLabel.TextSize = 8
hpLabel.TextStrokeTransparency = 0.6
hpLabel.Parent = billboard
local espData = {
model = model,
nameLabel = nameLabel,
hpLabel = hpLabel,
color = color,
isKiller = isKiller
}
table.insert(PlayerESPData, espData)
UpdatePlayerBillboardText(espData)
model:GetAttributeChangedSignal("ActorDisplayName"):Connect(function()
UpdatePlayerBillboardText(espData)
end)
model:GetAttributeChangedSignal("SkinNameDisplay"):Connect(function()
UpdatePlayerBillboardText(espData)
end)
model:GetAttributeChangedSignal("IsFakeNoli"):Connect(function()
UpdatePlayerBillboardText(espData)
end)
if humanoid then
humanoid:GetPropertyChangedSignal("Health"):Connect(function()
UpdatePlayerBillboardText(espData)
end)
humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
UpdatePlayerBillboardText(espData)
end)
end
elseif isGenerator then
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
nameLabel.Position = UDim2.new(0, 0, 0, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = "generator"
nameLabel.Font = Enum.Font.GothamBlack
nameLabel.TextColor3 = color
nameLabel.TextSize = 8
nameLabel.TextStrokeTransparency = 0.6
nameLabel.Parent = billboard
local progressLabel = Instance.new("TextLabel")
progressLabel.Size = UDim2.new(1, 0, 0.5, 0)
progressLabel.Position = UDim2.new(0, 0, 0.5, 0)
progressLabel.BackgroundTransparency = 1
progressLabel.Text = "Progress: 0%"
progressLabel.Font = Enum.Font.GothamBlack
progressLabel.TextColor3 = color
progressLabel.TextSize = 8
progressLabel.TextStrokeTransparency = 0.6
progressLabel.Parent = billboard
local espData = {
model = model,
nameLabel = nameLabel,
progressLabel = progressLabel,
highlight = highlight,
billboard = billboard
}
table.insert(ObjectESPData, espData)
UpdateGeneratorProgress(espData)
local progress = model:FindFirstChild("Progress")
if progress then
progress:GetPropertyChangedSignal("Value"):Connect(function()
UpdateGeneratorProgress(espData)
end)
end
else
local displayName = model.Name
if isPizzaDelivery then displayName = "Pizza Delivery" end
if isZombie then displayName = "Zombie" end
if isTripwire then displayName = "Tripwire" end
if isTripMine then displayName = "Trip Mine" end
if isRespawn then displayName = "Respawn" end
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = displayName
textLabel.Font = Enum.Font.GothamBlack
textLabel.TextColor3 = color
textLabel.TextSize = 8
textLabel.TextStrokeTransparency = 0.6
textLabel.Parent = billboard
table.insert(ObjectESPData, {model = model, highlight = highlight, billboard = billboard})
end
end
local function RemoveESP(model)
if not model then return end
for i = #PlayerESPData, 1, -1 do
if PlayerESPData[i].model == model then
table.remove(PlayerESPData, i)
end
end
for i = #ObjectESPData, 1, -1 do
if ObjectESPData[i].model == model then
table.remove(ObjectESPData, i)
end
end
pcall(function()
if model:FindFirstChild("TAOWARE_Highlight") then
model.TAOWARE_Highlight:Destroy()
end
if model:FindFirstChild("TAOWARE_Billboard") then
model.TAOWARE_Billboard:Destroy()
end
end)
end
local function CreateTracer(model, part, color)
if not model or not part or not part:IsA("BasePart") then return end
if TracerData[model] then return end
local line = Drawing.new("Line")
line.Visible = true
line.Color = color or Color3.fromRGB(255, 255, 255)
line.Thickness = 2
line.Transparency = 1
TracerData[model] = {line = line, part = part}
end
local function RemoveTracer(model)
if TracerData[model] then
pcall(function()
TracerData[model].line.Visible = false
TracerData[model].line:Remove()
end)
TracerData[model] = nil
end
end
local function UpdateTracers()
for model, data in pairs(TracerData) do
local line = data.line
local part = data.part
if line and part and part.Parent then
local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
if onScreen then
line.Visible = true
line.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
line.To = Vector2.new(pos.X, pos.Y)
else
line.Visible = false
end
else
RemoveTracer(model)
end
end
end
local noliByUsername = {}
local function clearFakeTags()
local playersFolder = Services.Workspace:FindFirstChild("Players")
if not playersFolder then return end
local killers = playersFolder:FindFirstChild("Killers")
if not killers then return end
for _, killer in ipairs(killers:GetChildren()) do
if killer:GetAttribute("ActorDisplayName") == "Noli" then
killer:SetAttribute("IsFakeNoli", false)
end
end
end
local function scanNolis()
local playersFolder = Services.Workspace:FindFirstChild("Players")
if not playersFolder then return end
local killers = playersFolder:FindFirstChild("Killers")
if not killers then return end
noliByUsername = {}
for _, killer in ipairs(killers:GetChildren()) do
if killer:GetAttribute("ActorDisplayName") == "Noli" then
local username = killer:GetAttribute("Username")
if username then
if not noliByUsername[username] then
noliByUsername[username] = {}
end
table.insert(noliByUsername[username], killer)
end
end
end
for username, models in pairs(noliByUsername) do
if #models > 1 then
for i = 2, #models do
models[i]:SetAttribute("IsFakeNoli", true)
end
models[1]:SetAttribute("IsFakeNoli", false)
else
models[1]:SetAttribute("IsFakeNoli", false)
end
end
end
local function updateFakeNolis()
clearFakeTags()
scanNolis()
end
local function UpdateAllPlayerESPText()
for _, data in ipairs(PlayerESPData) do
UpdatePlayerBillboardText(data)
end
end
local function UpdateESP()
local mapFolder = Services.Workspace:FindFirstChild("Map")
if not mapFolder or not mapFolder:FindFirstChild("Ingame") then
for i = #PlayerESPData, 1, -1 do
RemoveESP(PlayerESPData[i].model)
end
for i = #ObjectESPData, 1, -1 do
RemoveESP(ObjectESPData[i].model)
end
for model in pairs(TracerData) do
RemoveTracer(model)
end
return
end
local ingame = mapFolder.Ingame
local playersFolder = Services.Workspace:FindFirstChild("Players")
if playersFolder then
local killers = playersFolder:FindFirstChild("Killers")
if killers then
for _, killer in ipairs(killers:GetChildren()) do
if killer == LocalPlayer.Character then continue end
if IsRagdoll(killer) then
RemoveESP(killer)
RemoveTracer(killer)
continue
end
local player = Services.Players:GetPlayerFromCharacter(killer)
if not player or IsSpectating(player) then
RemoveESP(killer)
RemoveTracer(killer)
continue
end
if ESPSettings.killerESP and not killer:FindFirstChild("TAOWARE_Highlight") and killer:FindFirstChild("HumanoidRootPart") then
CreateESP(killer, ESPSettings.killerColor, false, false, false, false, false, false, false, false, true)
elseif not ESPSettings.killerESP then
RemoveESP(killer)
end
if ESPSettings.killerTracers and killer:FindFirstChild("HumanoidRootPart") then
CreateTracer(killer, killer.HumanoidRootPart, ESPSettings.killerColor)
else
RemoveTracer(killer)
end
end
end
local survivors = playersFolder:FindFirstChild("Survivors")
if survivors then
for _, survivor in ipairs(survivors:GetChildren()) do
if survivor == LocalPlayer.Character then continue end
if IsRagdoll(survivor) then
RemoveESP(survivor)
RemoveTracer(survivor)
continue
end
local player = Services.Players:GetPlayerFromCharacter(survivor)
if not player or IsSpectating(player) then
RemoveESP(survivor)
RemoveTracer(survivor)
continue
end
if ESPSettings.playerESP and not survivor:FindFirstChild("TAOWARE_Highlight") and survivor:FindFirstChild("HumanoidRootPart") then
CreateESP(survivor, ESPSettings.survivorColor, false, false, false, false, false, false, false, false, false)
elseif not ESPSettings.playerESP then
RemoveESP(survivor)
end
if ESPSettings.survivorTracers and survivor:FindFirstChild("HumanoidRootPart") then
CreateTracer(survivor, survivor.HumanoidRootPart, ESPSettings.survivorColor)
else
RemoveTracer(survivor)
end
end
end
end
if ingame:FindFirstChild("Map") then
for _, gen in ipairs(ingame.Map:GetChildren()) do
if gen:IsA("Model") and gen.Name:lower():find("generator") and gen.Name ~= "FakeGenerator" then
if IsRagdoll(gen) then
RemoveESP(gen)
RemoveTracer(gen)
continue
end
local progress = gen:FindFirstChild("Progress")
if ESPSettings.generatorESP and progress and progress.Value < 100 and not gen:FindFirstChild("TAOWARE_Highlight") then
CreateESP(gen, ESPSettings.generatorColor, true, false, false, false, false, false, false, false)
elseif (not ESPSettings.generatorESP or (progress and progress.Value >= 100)) then
RemoveESP(gen)
end
if ESPSettings.generatorTracers and progress and progress.Value < 100 then
local part = GetGeneratorPart(gen)
if part then
CreateTracer(gen, part, ESPSettings.generatorColor)
end
else
RemoveTracer(gen)
end
end
end
for _, item in ipairs(ingame.Map:GetDescendants()) do
if item.Name == "ItemRoot" and item.Parent and item.Parent:IsA("Model") then
local itemModel = item.Parent
if ESPSettings.itemESP and not itemModel:FindFirstChild("TAOWARE_Highlight") then
CreateESP(itemModel, ESPSettings.itemColor, false, true, false, false, false, false, false, false)
elseif not ESPSettings.itemESP then
RemoveESP(itemModel)
end
if ESPSettings.itemTracers and item:IsA("BasePart") then
CreateTracer(itemModel, item, ESPSettings.itemColor)
else
RemoveTracer(itemModel)
end
end
end
end
for _, pizza in ipairs(ingame:GetChildren()) do
if pizza.Name == "Pizza" and pizza:IsA("BasePart") then
if ESPSettings.pizzaEsp and not pizza:FindFirstChild("TAOWARE_Highlight") then
CreateESP(pizza, ESPSettings.pizzaColor, false, false, true, false, false, false, false, false)
elseif not ESPSettings.pizzaEsp then
RemoveESP(pizza)
end
if ESPSettings.pizzaTracers then
CreateTracer(pizza, pizza, ESPSettings.pizzaColor)
else
RemoveTracer(pizza)
end
end
end
for _, delivery in ipairs(ingame:GetChildren()) do
if delivery:IsA("Model") and table.find(DummyNames, delivery.Name) then
if ESPSettings.pizzaDeliveryEsp and not delivery:FindFirstChild("TAOWARE_Highlight") then
local hrp = delivery:FindFirstChild("HumanoidRootPart")
if hrp then
CreateESP(delivery, ESPSettings.pizzaDeliveryColor, false, false, false, true, false, false, false, false)
end
elseif not ESPSettings.pizzaDeliveryEsp then
RemoveESP(delivery)
end
if ESPSettings.pizzaDeliveryTracers then
local hrp = delivery:FindFirstChild("HumanoidRootPart")
if hrp then
CreateTracer(delivery, hrp, ESPSettings.pizzaDeliveryColor)
end
else
RemoveTracer(delivery)
end
end
end
for _, zombie in ipairs(ingame:GetChildren()) do
if zombie.Name == "Zombie" and zombie:IsA("Model") then
if ESPSettings.zombieEsp and not zombie:FindFirstChild("TAOWARE_Highlight") then
local hrp = zombie:FindFirstChild("HumanoidRootPart")
if hrp then
CreateESP(zombie, ESPSettings.zombieColor, false, false, false, false, true, false, false, false)
end
elseif not ESPSettings.zombieEsp then
RemoveESP(zombie)
end
if ESPSettings.zombieTracers then
local hrp = zombie:FindFirstChild("HumanoidRootPart")
if hrp then
CreateTracer(zombie, hrp, ESPSettings.zombieColor)
end
else
RemoveTracer(zombie)
end
end
end
for _, tripwire in ipairs(ingame:GetChildren()) do
if tripwire.Name == "TaphTripwire" and tripwire:IsA("BasePart") then
if ESPSettings.taphTripwireEsp and not tripwire:FindFirstChild("TAOWARE_Highlight") then
CreateESP(tripwire, ESPSettings.tripwireColor, false, false, false, false, false, true, false, false)
elseif not ESPSettings.taphTripwireEsp then
RemoveESP(tripwire)
end
end
end
for _, mine in ipairs(ingame:GetChildren()) do
if mine.Name == "TripMine" and mine:IsA("Model") then
if ESPSettings.tripMineEsp and not mine:FindFirstChild("TAOWARE_Highlight") then
CreateESP(mine, ESPSettings.tripMineColor, false, false, false, false, false, false, true, false)
elseif not ESPSettings.tripMineEsp then
RemoveESP(mine)
end
end
end
for _, respawn in ipairs(ingame:GetChildren()) do
if respawn.Name == "TwoTimeRespawn" and respawn:IsA("BasePart") then
if ESPSettings.twoTimeRespawnEsp and not respawn:FindFirstChild("TAOWARE_Highlight") then
CreateESP(respawn, ESPSettings.respawnColor, false, false, false, false, false, false, false, true)
elseif not ESPSettings.twoTimeRespawnEsp then
RemoveESP(respawn)
end
end
end
end
task.spawn(function()
while true do
UpdateESP()
updateFakeNolis()
task.wait(0.5)
end
end)
Services.RunService.RenderStepped:Connect(function()
UpdateTracers()
end)
local Window = Library:CreateWindow({
Title = ' NOLSAKEN',
Footer = 'ZeroX NOL Team / Xi Team',
Icon = "rbxassetid://4483362748",
Center = true,
AutoShow = true,
Resizable = true,
ShowCustomCursor = true,
NotifySide = "Right",
TabPadding = 8,
MenuFadeTime = 0
})
local Tabs = {
new = Window:AddTab('information', 'person-standing'),
Esp = Window:AddTab('esp','eye'),
ani = Window:AddTab('Adverse effect','cpu'),
Main = Window:AddTab('Miscellaneous','house'),
Bro = Window:AddTab('Fight','biohazard'),
zdx = Window:AddTab('Motor','printer'),
Sat = Window:AddTab('Physical strength','zap'),
["UI Settings"] = Window:AddTab('UI Commissioning', 'settings')
}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _env = getgenv and getgenv() or {}
local _hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
local information = Tabs.new:AddRightGroupbox('Player','info')
information:AddLabel("Actuator : " ..identifyexecutor())
information:AddLabel("User name : " ..game.Players.LocalPlayer.Name)
information:AddLabel("UserId : "..game.Players.LocalPlayer.UserId)
information:AddLabel("Nickname : "..game.Players.LocalPlayer.DisplayName)
information:AddLabel("User age : "..game.Players.LocalPlayer.AccountAge.." 天")
local new = Tabs.new:AddLeftGroupbox('News🚀')
new:AddButton({
Text = "Load Secondary Script",
Func = function()
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
getgenv().TransparencyEnabled = getgenv().TransparencyEnabled or false
local function gradient(text, startColor, endColor)
local result, chars = "", {}
for uchar in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
chars[#chars + 1] = uchar
end
for i = 1, #chars do
local t = (i - 1) / math.max(#chars - 1, 1)
result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>',
math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255),
math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255),
math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255),
chars[i])
end
return result
end
local themes = {"Dark", "Light", "Mocha", "Aqua"}
local currentThemeIndex = 1
local Window = WindUI:CreateWindow({
Title = gradient("NOLSAKEN ", Color3.fromRGB(139, 0, 255), Color3.fromRGB(255, 0, 0)),
Author = gradient("Abandoned", Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)),
IconThemed = true,
Folder = "NOL",
Size = UDim2.fromOffset(150, 100),
Transparent = getgenv().TransparencyEnabled,
Theme = "Dark",
Resizable = true,
SideBarWidth = 150,
BackgroundImageTransparency = 0.5,
HideSearchBar = true,
ScrollBarEnabled = true,
User = {
Enabled = true,
Anonymous = false,
Callback = function()
currentThemeIndex = currentThemeIndex + 1
if currentThemeIndex > #themes then
currentThemeIndex = 1
end
local newTheme = themes[currentThemeIndex]
WindUI:SetTheme(newTheme)
WindUI:Notify({
Title = "Theme Changed",
Content = "Switched to " .. newTheme .. " theme!",
Duration = 2,
Icon = "palette"
})
print("Switched to " .. newTheme .. " theme")
end
}
})
Window:EditOpenButton({
Title = "NOLSAKEN",
CornerRadius = UDim.new(16,16),
StrokeThickness = 2,
Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 0, 255)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
}),
Draggable = true,
})
Window:Tag({
Title = "Misc",
Radius = 5,
Color = Color3.fromRGB(255, 255, 255),
})
Window:SetToggleKey(Enum.KeyCode.F, true)
local Tabs = {
XiProInfo = Window:Tab({ Title = "Announcement", Icon = "info" }),
Player = Window:Tab({ Title = "Player", Icon = "bird" }),
Misc = Window:Tab({ Title = "Ability", Icon = "gift" }),
Auto_Stun = Window:Tab({ Title = "survivor", Icon = "spline-pointer" }),
kill = Window:Tab({ Title = "Killer", Icon = "skull" }),
Random = Window:Tab({ Title = "Universal aiming", Icon = "crosshair" }),
Anti = Window:Tab({ Title = "Adverse effect", Icon = "cpu" }),
Teleport = Window:Tab({ Title = "Transmit", Icon = "cable" }),
Actions = Window:Tab({ Title = "Animation", Icon = "activity" }),
SilentAim = Window:Tab({ Title = "Silent aiming", Icon = "target" })
}
Window:SelectTab(1)
Tabs.XiProInfo:Paragraph({
Title = "UseNOL",
Desc = "Scripted games you use: Forsaken",
ImageSize = 30,
Thumbnail = "rbxassetid://110237166940650",
ThumbnailSize = 170
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local ragingPaceSavedRange = LocalPlayer:FindFirstChild("RagingPaceRange")
if not ragingPaceSavedRange then
ragingPaceSavedRange = Instance.new("NumberValue")
ragingPaceSavedRange.Name = "RagingPaceRange"
ragingPaceSavedRange.Value = 19
ragingPaceSavedRange.Parent = LocalPlayer
end
local ragingPaceSavedEnabled = LocalPlayer:FindFirstChild("RagingPaceEnabled")
if not ragingPaceSavedEnabled then
ragingPaceSavedEnabled = Instance.new("BoolValue")
ragingPaceSavedEnabled.Name = "RagingPaceEnabled"
ragingPaceSavedEnabled.Value = false
ragingPaceSavedEnabled.Parent = LocalPlayer
end
local ragingPaceRange = ragingPaceSavedRange.Value
local ragingPaceSpamDuration = 3
local ragingPaceCooldownTime = 5
local ragingPaceActiveCooldowns = {}
local ragingPaceEnabled = ragingPaceSavedEnabled.Value
local ragingPaceAnimsToDetect = {
["116618003477002"] = true,
["119462383658044"] = true,
["131696603025265"] = true,
["121255898612475"] = true,
["133491532453922"] = true,
["103601716322988"] = true,
["86371356500204"] = true,
["72722244508749"] = true,
["87259391926321"] = true,
["96959123077498"] = true,
}
local function fireRagingPace()
local args = {
"UseActorAbility",
{
buffer.fromstring("\"RagingPace\"")
}
}
ReplicatedStorage:WaitForChild("Modules")
:WaitForChild("Network")
:WaitForChild("RemoteEvent")
:FireServer(unpack(args))
end
local function isRagingPaceAnimationMatching(anim)
local id = tostring(anim.Animation and anim.Animation.AnimationId or "")
local numId = id:match("%d+")
return ragingPaceAnimsToDetect[numId] or false
end
RunService.Heartbeat:Connect(function()
if not ragingPaceEnabled then return end
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
local targetHRP = player.Character.HumanoidRootPart
local myChar = LocalPlayer.Character
if myChar and myChar:FindFirstChild("HumanoidRootPart") then
local dist = (targetHRP.Position - myChar.HumanoidRootPart.Position).Magnitude
if dist <= ragingPaceRange and (not ragingPaceActiveCooldowns[player] or tick() - ragingPaceActiveCooldowns[player] >= ragingPaceCooldownTime) then
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
if humanoid then
for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
if isRagingPaceAnimationMatching(track) then
ragingPaceActiveCooldowns[player] = tick()
task.spawn(function()
local startTime = tick()
while tick() - startTime < ragingPaceSpamDuration do
fireRagingPace()
task.wait(0.05)
end
end)
break
end
end
end
end
end
end
end
end)
Tabs.Misc:Section({Title = "Automatic Fury"})
Tabs.Misc:Toggle({
Title = "Automatic Fury(Slasher)",
Default = ragingPaceEnabled,
Callback = function(state)
ragingPaceEnabled = state
ragingPaceSavedEnabled.Value = state
end
})
Tabs.Misc:Slider({
Title = "Distance range",
Step = 1,
Value = {Min = 1, Max = 50, Default = ragingPaceRange},
Suffix = "studs",
Callback = function(val)
ragingPaceRange = val
ragingPaceSavedRange.Value = val
end
})
Tabs.Misc:Section({Title = "Auto 404 Error"})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local antiAnimSavedEnabled = LocalPlayer:FindFirstChild("AntiAnimEnabled")
if not antiAnimSavedEnabled then
antiAnimSavedEnabled = Instance.new("BoolValue")
antiAnimSavedEnabled.Name = "AntiAnimEnabled"
antiAnimSavedEnabled.Value = false
antiAnimSavedEnabled.Parent = LocalPlayer
end
local antiAnimSavedRange = LocalPlayer:FindFirstChild("AntiAnimRange")
if not antiAnimSavedRange then
antiAnimSavedRange = Instance.new("NumberValue")
antiAnimSavedRange.Name = "AntiAnimRange"
antiAnimSavedRange.Value = 19
antiAnimSavedRange.Parent = LocalPlayer
end
local antiAnimRange = antiAnimSavedRange.Value
local antiAnimSpamDuration = 3
local antiAnimCooldownTime = 5
local antiAnimActiveCooldowns = {}
local antiAnimEnabled = antiAnimSavedEnabled.Value
local antiAnimAnimsToDetect = {
["116618003477002"] = true,
["119462383658044"] = true,
["131696603025265"] = true,
["121255898612475"] = true,
["133491532453922"] = true,
["103601716322988"] = true,
["86371356500204"] = true,
["72722244508749"] = false,
["87259391926321"] = true,
["96959123077498"] = false,
["86709774283672"] = true,
["77448521277146"] = true,
}
local function fire404Error()
local args = {
"UseActorAbility",
{
buffer.fromstring("\"404Error\"")
}
}
ReplicatedStorage:WaitForChild("Modules")
:WaitForChild("Network")
:WaitForChild("RemoteEvent")
:FireServer(unpack(args))
end
local function isAntiAnimAnimationMatching(anim)
local id = tostring(anim.Animation and anim.Animation.AnimationId or "")
local numId = id:match("%d+")
return antiAnimAnimsToDetect[numId] or false
end
RunService.Heartbeat:Connect(function()
if not antiAnimEnabled then return end
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
local targetHRP = player.Character.HumanoidRootPart
local myChar = LocalPlayer.Character
if myChar and myChar:FindFirstChild("HumanoidRootPart") then
local dist = (targetHRP.Position - myChar.HumanoidRootPart.Position).Magnitude
if dist <= antiAnimRange and (not antiAnimActiveCooldowns[player] or tick() - antiAnimActiveCooldowns[player] >= antiAnimCooldownTime) then
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
if humanoid then
for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
if isAntiAnimAnimationMatching(track) then
antiAnimActiveCooldowns[player] = tick()
task.spawn(function()
local startTime = tick()
while tick() - startTime < antiAnimSpamDuration do
fire404Error()
task.wait(0.05)
end
end)
break
end
end
end
end
end
end
end
end)
Tabs.Misc:Toggle({
Title = "Auto 404 error [unstoppable]",
Default = antiAnimEnabled,
Callback = function(state)
antiAnimEnabled = state
antiAnimSavedEnabled.Value = state
end
})
Tabs.Misc:Slider({
Title = "Distance range",
Step = 1,
Value = {Min = 1, Max = 50, Default = antiAnimRange},
Suffix = "studs",
Callback = function(val)
antiAnimRange = val
antiAnimSavedRange.Value = val
end
})
local chanceAim = {
active = false,
duration = 1.7,
prediction = 4,
targets = {"Slasher", "c00lkidd", "JohnDoe", "1x1x1x1", "Noli", "Sixer", "Nosferatu"},
animations = {["103601716322988"] = true, ["133491532453922"] = true, ["86371356500204"] = true, ["76649505662612"] = true, ["81698196845041"] = true},
humanoid = nil,
hrp = nil,
lastTrigger = 0,
aiming = false,
original = {}
}
local function setupChanceAimChar(char)
chanceAim.humanoid = char:WaitForChild("Humanoid")
chanceAim.hrp = char:WaitForChild("HumanoidRootPart")
end
local function getValidTarget()
local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
if killersFolder then
local targets = chanceAim.targets
for i = 1, #targets do
local target = killersFolder:FindFirstChild(targets[i])
if target and target:FindFirstChild("HumanoidRootPart") then
return target.HumanoidRootPart
end
end
end
return nil
end
local function getPlayingAnimationIds()
local ids = {}
if chanceAim.humanoid then
local tracks = chanceAim.humanoid:GetPlayingAnimationTracks()
for i = 1, #tracks do
local track = tracks[i]
local anim = track.Animation
if anim and anim.AnimationId then
local id = anim.AnimationId:match("%d+")
if id then ids[id] = true end
end
end
end
return ids
end
if LocalPlayer.Character then setupChanceAimChar(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(setupChanceAimChar)
Tabs.Auto_Stun:Section({Title = "ChanceSelf-aiming"})
RunService.RenderStepped:Connect(function()
if not chanceAim.active or not chanceAim.humanoid or not chanceAim.hrp then return end
local currentTime = tick()
local playing = getPlayingAnimationIds()
local triggered = false
for id in pairs(chanceAim.animations) do
if playing[id] then
triggered = true
break
end
end
if triggered then
chanceAim.lastTrigger = currentTime
chanceAim.aiming = true
end
if chanceAim.aiming and currentTime - chanceAim.lastTrigger <= chanceAim.duration then
if not chanceAim.original.ws then
chanceAim.original = {
ws = chanceAim.humanoid.WalkSpeed,
jp = chanceAim.humanoid.JumpPower,
ar = chanceAim.humanoid.AutoRotate
}
chanceAim.humanoid.AutoRotate = false
chanceAim.hrp.AssemblyAngularVelocity = Vector3.zero
end
local targetHRP = getValidTarget()
if targetHRP then
local predictedPos = targetHRP.Position + (targetHRP.CFrame.LookVector * chanceAim.prediction)
local direction = (predictedPos - chanceAim.hrp.Position).Unit
local yRot = math.atan2(-direction.X, -direction.Z)
chanceAim.hrp.CFrame = CFrame.new(chanceAim.hrp.Position) * CFrame.Angles(0, yRot, 0)
end
elseif chanceAim.aiming then
chanceAim.aiming = false
if chanceAim.original.ws then
chanceAim.humanoid.WalkSpeed = chanceAim.original.ws
chanceAim.humanoid.JumpPower = chanceAim.original.jp
chanceAim.humanoid.AutoRotate = chanceAim.original.ar
chanceAim.original = {}
end
end
end)
local function OnRemoteEvent(eventName, eventArg)
if not chanceAim.active then return end
if eventName == "UseActorAbility" and type(eventArg) == "table" and eventArg[1] and tostring(eventArg[1]) == buffer.fromstring("\"Shoot\"") then
chanceAim.lastTrigger = tick()
chanceAim.aiming = true
end
end
Tabs.Auto_Stun:Toggle({
Title = "Automatic aiming",
Default = false,
Callback = function(v) chanceAim.active = v end
})
Tabs.Auto_Stun:Slider({
Title = "Predictive factor (high delay = > 4)",
Step = 1,
Value = {Min = 1, Max = 10, Default = chanceAim.prediction},
Suffix = "studs",
Callback = function(val) chanceAim.prediction = val end
})
RunService.RenderStepped:Connect(OnRenderStep)
local AutoFlipCoins = false
local flipCoinsThread = nil
Tabs.Auto_Stun:Toggle({
Title = "Auto Flip Coins (3)",
Default = false,
Callback = function(state)
AutoFlipCoins = state
if AutoFlipCoins then
flipCoinsThread = task.spawn(function()
while AutoFlipCoins and task.wait() do
local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
local chargesText = playerGui:FindFirstChild("MainUI") and
playerGui.MainUI:FindFirstChild("AbilityContainer") and
playerGui.MainUI.AbilityContainer:FindFirstChild("Shoot") and
playerGui.MainUI.AbilityContainer.Shoot:FindFirstChild("Charges")
if chargesText and chargesText:IsA("TextLabel") and chargesText.Text == "3" then
break
else
local args = {
"UseActorAbility",
{
buffer.fromstring("\"CoinFlip\"")
}
}
game:GetService("ReplicatedStorage"):WaitForChild("Modules")
:WaitForChild("Network")
:WaitForChild("RemoteEvent")
:FireServer(unpack(args))
end
end
end)
elseif flipCoinsThread then
task.cancel(flipCoinsThread)
flipCoinsThread = nil
end
end
})
Tabs.Auto_Stun:Toggle({
Title = "Auto Flip Coins (1)",
Default = false,
Callback = function(state)
AutoFlipCoins = state
if AutoFlipCoins then
flipCoinsThread = task.spawn(function()
while AutoFlipCoins and task.wait() do
local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
local chargesText = playerGui:FindFirstChild("MainUI") and
playerGui.MainUI:FindFirstChild("AbilityContainer") and
playerGui.MainUI.AbilityContainer:FindFirstChild("Shoot") and
playerGui.MainUI.AbilityContainer.Shoot:FindFirstChild("Charges")
if chargesText and chargesText:IsA("TextLabel") and chargesText.Text == "1" then
break
else
local args = {
"UseActorAbility",
{
buffer.fromstring("\"CoinFlip\"")
}
}
game:GetService("ReplicatedStorage"):WaitForChild("Modules")
:WaitForChild("Network")
:WaitForChild("RemoteEvent")
:FireServer(unpack(args))
end
end
end)
elseif flipCoinsThread then
task.cancel(flipCoinsThread)
flipCoinsThread = nil
end
end
})
game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent.OnClientEvent:Connect(OnRemoteEvent)
Tabs.Random:Section({Title = "Universal aiming"})
Tabs.Random:Toggle({
Title = "Self-aiming",
Default = false,
Callback = function(state) aimbot.enabled = state end
})
local faceEnemy = {
enabled = false,
targetType = "Killer",
autoAim = false
}
local faceEnemyConnection
Tabs.Random:Toggle({
Title = "Automatic towards enemy",
Default = false,
Callback = function(state)
faceEnemy.enabled = state
if state then
faceEnemyConnection = RunService.RenderStepped:Connect(function()
if not faceEnemy.enabled then return end
local char = LocalPlayer.Character
if not char or not char:FindFirstChild("HumanoidRootPart") then return end
local myRoot = char.HumanoidRootPart
local targetFolder = faceEnemy.targetType == "Killer"
and (Workspace:FindFirstChild("Players") and Workspace.Players:FindFirstChild("Killers"))
or (Workspace:FindFirstChild("Players") and Workspace.Players:FindFirstChild("Survivors"))
if not targetFolder then return end
local closest, minDist = nil, math.huge
for _, target in ipairs(targetFolder:GetChildren()) do
if target:IsA("Model") and target:FindFirstChild("HumanoidRootPart") then
local dist = (target.HumanoidRootPart.Position - myRoot.Position).Magnitude
if dist < minDist then
closest, minDist = target, dist
end
end
end
if closest and closest:FindFirstChild("HumanoidRootPart") then
local targetPos = closest.HumanoidRootPart.Position
local lookPos = Vector3.new(targetPos.X, myRoot.Position.Y, targetPos.Z)
myRoot.CFrame = CFrame.new(myRoot.Position, lookPos)
end
end)
else
if faceEnemyConnection then
faceEnemyConnection:Disconnect()
faceEnemyConnection = nil
end
end
end
})
Tabs.Random:Dropdown({
Title = "Orientation Target Type",
Values = {"Killer", "survivor"},
Multi = false,
AllowNone = false,
Callback = function(choice) faceEnemy.targetType = choice end
})
local orbit = {
active = false,
distance = 10,
speed = 5,
angle = 0,
targetPlayer = nil,
heightOffset = 0
}
RunService.RenderStepped:Connect(function(dt)
if not orbit.active or not orbit.targetPlayer then return end
local targetChar = orbit.targetPlayer.Character
local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
local myChar = LocalPlayer.Character
local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
if not myRoot or not targetRoot then return end
orbit.angle = orbit.angle + orbit.speed * dt
local offset = Vector3.new(
math.cos(orbit.angle) * orbit.distance,
orbit.heightOffset,
math.sin(orbit.angle) * orbit.distance
)
myRoot.CFrame = CFrame.new(targetRoot.Position + offset, targetRoot.Position)
end)
Tabs.Random:Toggle({
Title = "Surround player",
Default = false,
Callback = function(state) orbit.active = state end
})
Tabs.Random:Dropdown({
Title = "Select Target",
Values = (function()
local names = {}
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer then names[#names + 1] = player.Name end
end
return names
end)(),
Multi = false,
AllowNone = true,
Callback = function(choice)
orbit.targetPlayer = Players:FindFirstChild(choice)
end
})
Tabs.Random:Slider({
Title = "Rotational speed",
Step = 0.5,
Value = {Min = 1, Max = 50, Default = orbit.speed},
Suffix = " /second",
Callback = function(val) orbit.speed = val end
})
Tabs.Random:Slider({
Title = "Surrounding distance",
Step = 1,
Value = {Min = 1, Max = 20, Default = orbit.distance},
Suffix = " studs",
Callback = function(val) orbit.distance = val end
})
Tabs.Random:Slider({
Title = "Height Offset",
Step = 0.5,
Value = {Min = -10, Max = 10, Default = orbit.heightOffset},
Suffix = " studs",
Callback = function(val) orbit.heightOffset = val end
})
Tabs.Teleport:Section({Title = "Transmit"})
Tabs.Teleport:Button({
Title = "Send to Killer",
Callback = function()
local folder = Workspace:FindFirstChild("Players") and Workspace.Players:FindFirstChild("Killers")
local killer = folder and folder:FindFirstChildWhichIsA("Model")
if killer and killer.PrimaryPart then
local char = LocalPlayer.Character
if char and char:FindFirstChild("HumanoidRootPart") then
char.HumanoidRootPart.CFrame = killer.PrimaryPart.CFrame
end
end
end
})
Tabs.Teleport:Button({
Title = "Send to Nearest Survivor",
Callback = function()
local char = LocalPlayer.Character
if not char or not char:FindFirstChild("HumanoidRootPart") then return end
local folder = Workspace:FindFirstChild("Players") and Workspace.Players:FindFirstChild("Survivors")
if not folder then return end
local myPos = char.HumanoidRootPart.Position
local nearest, minDist = nil, math.huge
for _, survivor in ipairs(folder:GetChildren()) do
if survivor:IsA("Model") and survivor:FindFirstChild("HumanoidRootPart") then
local dist = (survivor.HumanoidRootPart.Position - myPos).Magnitude
if dist < minDist then
nearest, minDist = survivor, dist
end
end
end
if nearest and nearest:FindFirstChild("HumanoidRootPart") then
char.HumanoidRootPart.CFrame = nearest.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
end
end
})
Tabs.Teleport:Button({
Title = "To generator",
Callback = function()
local char = LocalPlayer.Character
if not char or not char:FindFirstChild("HumanoidRootPart") then return end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == "Generator" then
local target = obj:IsA("BasePart") and obj or (obj:IsA("Model") and obj.PrimaryPart)
if target then
char.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
return
end
end
end
end
})
Tabs.Teleport:Button({
Title = "Transfer to medical package",
Callback = function()
local char = LocalPlayer.Character
if not char or not char:FindFirstChild("HumanoidRootPart") then return end
for _, v in ipairs(Workspace:GetDescendants()) do
if v:IsA("BasePart") and v.Name == "ItemRoot" and v.Parent and v.Parent.Name == "Medkit" then
char.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 3, 0)
break
end
end
end
})
Tabs.Teleport:Button({
Title = "Send to BLOXY COLA",
Callback = function()
local char = LocalPlayer.Character
if not char or not char:FindFirstChild("HumanoidRootPart") then return end
for _, v in ipairs(Workspace:GetDescendants()) do
if v:IsA("BasePart") and v.Name == "ItemRoot" and v.Parent and v.Parent.Name == "BloxyCola" then
char.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 3, 0)
break
end
end
end
})
local emoteSystem = {
active = false,
currentEmote = "Silly Billy",
currentTrack = nil,
currentSound = nil,
bodyVel = nil,
emotes = {
["Silly Billy"] = {
animId = "rbxassetid://107464355830477",
soundId = "rbxassetid://77601084987544",
volume = 0.5,
looped = false,
remoteName = nil,
cleanAssets = {"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}
},
["Silly of it"] = {
animId = "rbxassetid://107464355830477",
soundId = "rbxassetid://120176009143091",
volume = 0.5,
looped = false,
remoteName = nil,
cleanAssets = {"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}
},
["Subterfuge"] = {
animId = "rbxassetid://87482480949358",
soundId = "rbxassetid://132297506693854",
volume = 2,
looped = false,
remoteName = "_Subterfuge",
cleanAssets = {},
hasEffect = false
},
["VIP Dance"] = {
animId = "rbxassetid://138019937280193",
soundId = "rbxassetid://109474987384441",
volume = 0.5,
looped = true,
remoteName = "HakariDance",
cleanAssets = {},
hasEffect = true
},
["江南风"] = {
animId = "rbxassetid://108308837970067",
soundId = "rbxassetid://86963552203595",
volume = 0.5,
looped = true,
remoteName = nil,
cleanAssets = {"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}
}
}
}
local function stopEmote()
local char = LocalPlayer.Character
if not char then return end
local humanoid = char:FindFirstChildOfClass("Humanoid")
local rootPart = char:FindFirstChild("HumanoidRootPart")
if humanoid then
humanoid.PlatformStand = false
humanoid.JumpPower = 50
for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
track:Stop()
end
end
if rootPart then
local bodyVel = rootPart:FindFirstChildOfClass("BodyVelocity")
if bodyVel then bodyVel:Destroy() end
for _, sound in ipairs(rootPart:GetChildren()) do
if sound:IsA("Sound") then
sound:Stop()
sound:Destroy()
end
end
end
for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand", "PlayerEmoteVFX"}) do
local asset = char:FindFirstChild(assetName)
if asset then asset:Destroy() end
end
emoteSystem.currentTrack = nil
emoteSystem.currentSound = nil
emoteSystem.bodyVel = nil
end
local function playEmote()
stopEmote()
local char = LocalPlayer.Character
if not char then return end
local humanoid = char:FindFirstChildOfClass("Humanoid")
local rootPart = char:FindFirstChild("HumanoidRootPart")
if not humanoid or not rootPart then return end
local emoteData = emoteSystem.emotes[emoteSystem.currentEmote]
if not emoteData then return end
humanoid.PlatformStand = true
humanoid.JumpPower = 0
local bodyVel = Instance.new("BodyVelocity")
bodyVel.MaxForce = Vector3.new(100000, 100000, 100000)
bodyVel.Velocity = Vector3.zero
bodyVel.Parent = rootPart
emoteSystem.bodyVel = bodyVel
local anim = Instance.new("Animation")
anim.AnimationId = emoteData.animId
local track = humanoid:LoadAnimation(anim)
track:Play()
emoteSystem.currentTrack = track
local sound = Instance.new("Sound")
sound.SoundId = emoteData.soundId
sound.Volume = emoteData.volume
sound.Looped = emoteData.looped
sound.Parent = rootPart
sound:Play()
emoteSystem.currentSound = sound
if emoteData.hasEffect then
pcall(function()
local effect = ReplicatedStorage.Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
effect.Name = "PlayerEmoteVFX"
effect.CFrame = rootPart.CFrame * CFrame.new(0, -1, -0.3)
effect.WeldConstraint.Part0 = rootPart
effect.WeldConstraint.Part1 = effect
effect.CanCollide = false
effect.Parent = char
end)
end
if emoteData.remoteName then
pcall(function()
remoteEvent:FireServer("PlayEmote", "Animations", emoteData.remoteName)
end)
end
track.Stopped:Connect(function()
if not emoteSystem.active then
humanoid.PlatformStand = false
if bodyVel and bodyVel.Parent then bodyVel:Destroy() end
for _, assetName in ipairs(emoteData.cleanAssets) do
local asset = char:FindFirstChild(assetName)
if asset then asset:Destroy() end
end
end
end)
end
Tabs.Actions:Section({Title = "Action expression"})
Tabs.Actions:Dropdown({
Title = "Select Action",
Values = {"Silly Billy", "Silly of it", "Subterfuge", "VIP Dance", "Jiang Nanfeng"},
Multi = false,
AllowNone = false,
Callback = function(selected)
emoteSystem.currentEmote = selected
if emoteSystem.active then
playEmote()
end
end
})
Tabs.Actions:Toggle({
Title = "Start Action",
Default = false,
Callback = function(state)
emoteSystem.active = state
if state then
playEmote()
else
stopEmote()
end
end
})
local fakeDieEnabled = false
local fakeDieTrack = nil
local fakeDieConnection = nil
Tabs.Actions:Toggle({
Title = "Suspended animation",
Default = false,
Callback = function(state)
fakeDieEnabled = state
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer
local char = plr.Character
if not char then return end
local hum = char:WaitForChild("Humanoid")
if state then
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://118795597134269"
fakeDieTrack = hum:LoadAnimation(anim)
fakeDieTrack:Play()
if fakeDieTrack.Length > 0 then
fakeDieTrack.TimePosition = fakeDieTrack.Length * 0.5
end
local stopped = false
fakeDieConnection = RunService.Heartbeat:Connect(function()
if fakeDieTrack.IsPlaying and not stopped and fakeDieTrack.Length > 0 then
local percent = fakeDieTrack.TimePosition / fakeDieTrack.Length
if percent >= 0.9 then
fakeDieTrack:AdjustSpeed(0)
stopped = true
end
end
end)
else
if fakeDieTrack then
fakeDieTrack:Stop()
fakeDieTrack = nil
end
if fakeDieConnection then
fakeDieConnection:Disconnect()
fakeDieConnection = nil
end
pcall(function()
hum:PlayEmote("idle")
end)
end
end
})
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local invisAnimationId = "75804462760596"
local invisLoopRunning = false
local invisLoopThread
local invisCurrentAnim = nil
local function startInvisibility()
invisLoopRunning = true
local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R6 then return end
invisLoopThread = task.spawn(function()
while invisLoopRunning do
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://" .. invisAnimationId
local loadedAnim = humanoid:LoadAnimation(anim)
invisCurrentAnim = loadedAnim
loadedAnim.Looped = false
loadedAnim:Play()
loadedAnim:AdjustSpeed(0)
task.wait(0.000001)
end
end)
end
local function stopInvisibility()
invisLoopRunning = false
if invisLoopThread then
task.cancel(invisLoopThread)
invisLoopThread = nil
end
if invisCurrentAnim then
invisCurrentAnim:Stop()
invisCurrentAnim = nil
end
local humanoid = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or LocalPlayer.Character:FindFirstChildOfClass("AnimationController"))
if humanoid then
for _, v in pairs(humanoid:GetPlayingAnimationTracks()) do
v:AdjustSpeed(100000)
end
end
local animateScript = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Animate")
if animateScript then
animateScript.Disabled = true
animateScript.Disabled = false
end
end
Tabs.Actions:Toggle({
Title = "Stealth",
Value = false,
Tooltip = "Dog Crawling Stealth",
Callback = function(Value)
if Value then
startInvisibility()
else
stopInvisibility()
end
end
})
local v1 = game:GetService("ReplicatedStorage")
local v2 = LocalPlayer
local v3 = v2.Character or v2.CharacterAdded:Wait()
local v4 = v3:WaitForChild("HumanoidRootPart")
v2.CharacterAdded:Connect(function(newChar)
v3 = newChar
v4 = v3:WaitForChild("HumanoidRootPart")
end)
local SilentAimEnabled = false
local WallCheckEnabled = false
local FilterKillersEnabled = false
local FilterSurvivorsEnabled = false
local function v5()
if not SilentAimEnabled then return nil end
local v6, v7 = nil, 100
local function checkTarget(v8, v10)
if WallCheckEnabled then
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Blacklist
rayParams.FilterDescendantsInstances = {v3, v8}
rayParams.IgnoreWater = true
local rayResult = workspace:Raycast(
v4.Position,
(v10.Position - v4.Position).Unit * (v10.Position - v4.Position).Magnitude,
rayParams
)
if rayResult then
local hitPart = rayResult.Instance
if not hitPart:IsDescendantOf(v8) then
return false
end
end
end
if FilterKillersEnabled then
local killersFolder = workspace.Players:FindFirstChild("Killers")
if killersFolder and v8:IsDescendantOf(killersFolder) then
return false
end
end
if FilterSurvivorsEnabled then
local survivorsFolder = workspace.Players:FindFirstChild("Survivors")
if survivorsFolder and v8:IsDescendantOf(survivorsFolder) then
return false
end
end
return true
end
for _, v8 in workspace:GetDescendants() do
if v8:IsA("Model") and v8 ~= v3 then
local v9 = v8:FindFirstChild("Humanoid")
local v10 = v8:FindFirstChild("HumanoidRootPart")
if v9 and v10 and v9.Health > 0 then
if checkTarget(v8, v10) then
local v11 = (v4.Position - v10.Position).Magnitude
if v11 < v7 then
v6, v7 = v10.Position, v11
end
end
end
end
end
return v6
end
Tabs.SilentAim:Section({Title = "Silent Aim Settings"})
Tabs.SilentAim:Toggle({
Title = "Silent aiming",
Default = false,
Callback = function(state)
SilentAimEnabled = state
end
})
Tabs.SilentAim:Toggle({
Title = "Wall detection",
Default = false,
Callback = function(state)
WallCheckEnabled = state
end
})
Tabs.SilentAim:Toggle({
Title = "Eliminate Killer",
Default = false,
Callback = function(state)
FilterKillersEnabled = state
end
})
Tabs.SilentAim:Toggle({
Title = "Exclude survivors",
Default = false,
Callback = function(state)
FilterSurvivorsEnabled = state
end
})
Tabs.SilentAim:Button({
Title = "Silent aiming",
Callback = function()
task.wait(1)
local v12, v13 = pcall(require, v1.Systems.Player.Miscellaneous.GetPlayerMousePosition)
if v12 then
if typeof(v13) == "function" then
local v14 = v13
v1.Systems.Player.Miscellaneous.GetPlayerMousePosition = function(...)
return v5() or v14(...)
end
elseif typeof(v13) == "table" then
for v15, v16 in pairs(v13) do
if typeof(v16) == "function" then
local v17 = v16
v13[v15] = function(...)
return v5() or v17(...)
end
end
end
end
end
WindUI:Notify({
Title = "Silent aiming",
Content = "Support roles: dusek, Coolkkid, Noli Remote Skills",
Duration = 3
})
end
})
local ff_connection = nil
local ff_enabled = false
local ff_cd = false
local jumpHeight = 72
local jumpDistance = 35
local function Flip()
if ff_cd then
return
end
ff_cd = true
local character = game.Players.LocalPlayer.Character
if not character then
ff_cd = false
return
end
local hrp = character:FindFirstChild("HumanoidRootPart")
local Humanoid = character:FindFirstChildOfClass("Humanoid")
local animator = Humanoid and Humanoid:FindFirstChildOfClass("Animator")
if not hrp or not Humanoid then
ff_cd = false
return
end
local savedTracks = {}
if animator then
for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
savedTracks[#savedTracks + 1] = { track = track, time = track.TimePosition }
track:Stop(0)
end
end
Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
local duration = 0.45
local steps = 120
local startCFrame = hrp.CFrame
local forwardVector = startCFrame.LookVector
local upVector = Vector3.new(0, 1, 0)
task.spawn(function()
local startTime = tick()
for i = 1, steps do
local t = i / steps
local height = jumpHeight * (t - t ^ 2)
local nextPos = startCFrame.Position + forwardVector * (jumpDistance * t) + upVector * height
local rotation = startCFrame.Rotation * CFrame.Angles(-math.rad(i * (360 / steps)), 0, 0)
hrp.CFrame = CFrame.new(nextPos) * rotation
local elapsedTime = tick() - startTime
local expectedTime = (duration / steps) * i
local waitTime = expectedTime - elapsedTime
if waitTime > 0 then
task.wait(waitTime)
end
end
hrp.CFrame = CFrame.new(startCFrame.Position + forwardVector * jumpDistance) * startCFrame.Rotation
Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
Humanoid:ChangeState(Enum.HumanoidStateType.Running)
if animator then
for _, data in ipairs(savedTracks) do
local track = data.track
track:Play()
track.TimePosition = data.time
end
end
task.wait(0.25)
ff_cd = false
end)
end
local sausageHolder = nil
local originalSize = nil
local ff_button = nil
local function SetFrontFlip(bool)
ff_enabled = bool
if ff_enabled == true then
pcall(function()
sausageHolder = game.CoreGui.TopBarApp.TopBarApp.UnibarLeftFrame.UnibarMenu["2"]
originalSize = sausageHolder.Size.X.Offset
ff_button = Instance.new("Frame", sausageHolder)
ff_button.Size = UDim2.new(0, 48, 0, 44)
ff_button.BackgroundTransparency = 1
ff_button.BorderSizePixel = 0
ff_button.Position = UDim2.new(0, sausageHolder.Size.X.Offset - 48, 0, 0)
local imageButton = Instance.new("ImageButton", ff_button)
imageButton.BackgroundTransparency = 1
imageButton.BorderSizePixel = 0
imageButton.Size = UDim2.new(0, 36, 0, 36)
imageButton.AnchorPoint = Vector2.new(0.5, 0.5)
imageButton.Position = UDim2.new(0.5, 0, 0.5, 0)
imageButton.Image = "rbxthumb://type=Asset&id=2714338264&w=150&h=150"
ff_connection = imageButton.Activated:Connect(Flip)
sausageHolder.Size = UDim2.new(0, originalSize + 48, 0, sausageHolder.Size.Y.Offset)
task.wait()
ff_button.Position = UDim2.new(0, sausageHolder.Size.X.Offset - 48, 0, 0)
task.spawn(function()
pcall(function()
repeat
sausageHolder.Size = UDim2.new(0, originalSize + 48, 0, sausageHolder.Size.Y.Offset)
task.wait()
ff_button.Position = UDim2.new(0, sausageHolder.Size.X.Offset - 48, 0, 0)
until ff_enabled == false
end)
end)
end)
elseif ff_enabled == false then
if ff_connection then
ff_connection:Disconnect()
ff_connection = nil
end
if ff_button then
ff_button:Destroy()
ff_button = nil
end
if sausageHolder then
sausageHolder.Size = UDim2.new(0, originalSize, 0, sausageHolder.Size.Y.Offset)
end
end
end
Tabs.Player:Section({Title = "Forward somersault"})
Tabs.Player:Toggle({
Title = "Show front somersault button",
Default = false,
Callback = function(state)
SetFrontFlip(state)
end
})
Tabs.Player:Slider({
Title = "Jump height",
Step = 1,
Value = {Min = 20, Max = 200, Default = jumpHeight},
Suffix = "Unit",
Callback = function(val)
jumpHeight = val
end
})
Tabs.Player:Slider({
Title = "Jump distance",
Step = 1,
Value = {Min = 10, Max = 100, Default = jumpDistance},
Suffix = "Unit",
Callback = function(val)
jumpDistance = val
end
})
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local voidrushcontrol = false
local DASH_SPEED = 80
local ATTACK_RANGE = 6
local ATTACK_INTERVAL = 0.2
local aimDistance = 50
local isOverrideActive = false
local connection
local Humanoid, RootPart
local lastState = nil
local attackingLoop = nil
local survivorsFolder = workspace:WaitForChild("Players"):WaitForChild("Survivors")
local function isPriorityTarget(p)
if not p or not p.Character then return false end
return survivorsFolder:FindFirstChild(p.Name) ~= nil
end
local function setupCharacter(character)
Humanoid = character:WaitForChild("Humanoid")
RootPart = character:WaitForChild("HumanoidRootPart")
Humanoid.Died:Connect(function()
isOverrideActive = false
if connection then
connection:Disconnect()
connection = nil
end
if attackingLoop then
task.cancel(attackingLoop)
attackingLoop = nil
end
if RootPart then
RootPart.AssemblyLinearVelocity = Vector3.zero
end
end)
end
if LocalPlayer.Character then
setupCharacter(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(setupCharacter)
local function validTarget(p)
if p == LocalPlayer then return false end
local c = p.Character
if not c then return false end
local hrp = c:FindFirstChild("HumanoidRootPart")
local hum = c:FindFirstChild("Humanoid")
return hrp and hum and hum.Health > 0
end
local function getClosestTarget()
if not RootPart then return nil end
local closestW, distW = nil, math.huge
local closestA, distA = nil, math.huge
for _, p in ipairs(Players:GetPlayers()) do
if validTarget(p) then
local c = p.Character
local hrp = c and c:FindFirstChild("HumanoidRootPart")
if hrp then
local d = (hrp.Position - RootPart.Position).Magnitude
if d <= aimDistance then
if isPriorityTarget(p) and d < distW then
distW = d
closestW = p
end
if d < distA then
distA = d
closestA = p
end
end
end
end
end
return closestW or closestA, distW < math.huge and distW or distA
end
local function attemptAttack()
local char = LocalPlayer.Character
if not char then return end
local tool = char:FindFirstChildOfClass("Tool")
if tool and tool.Parent == char then
pcall(function() tool:Activate() end)
end
end
local function startOverride()
if isOverrideActive or not Humanoid or not RootPart then return end
isOverrideActive = true
connection = RunService.RenderStepped:Connect(function()
if not Humanoid or not RootPart or Humanoid.Health <= 0 then return end
local target, dist = getClosestTarget()
if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
local hrp = target.Character.HumanoidRootPart
local dir = hrp.Position - RootPart.Position
local horizontal = Vector3.new(dir.X, 0, dir.Z)
if horizontal.Magnitude > 0.1 then
RootPart.CFrame = CFrame.new(RootPart.Position, Vector3.new(hrp.Position.X, RootPart.Position.Y, hrp.Position.Z))
RootPart.AssemblyLinearVelocity = horizontal.Unit * DASH_SPEED
else
RootPart.AssemblyLinearVelocity = Vector3.zero
end
else
RootPart.AssemblyLinearVelocity = Vector3.zero
end
end)
attackingLoop = task.spawn(function()
while isOverrideActive do
local target, dist = getClosestTarget()
if target and dist and dist <= ATTACK_RANGE then
attemptAttack()
end
task.wait(ATTACK_INTERVAL)
end
end)
end
local function stopOverride()
if not isOverrideActive then return end
isOverrideActive = false
if connection then
connection:Disconnect()
connection = nil
end
if attackingLoop then
task.cancel(attackingLoop)
attackingLoop = nil
end
if RootPart then
RootPart.AssemblyLinearVelocity = Vector3.zero
end
end
RunService.RenderStepped:Connect(function()
if not voidrushcontrol or not Humanoid then return end
local state = Humanoid.Parent and Humanoid.Parent:GetAttribute("VoidRushState")
if state ~= lastState then
lastState = state
if state == "Dashing" then
startOverride()
else
stopOverride()
end
end
end)
Tabs.kill:Section({Title = "Noli"})
Tabs.kill:Toggle({
Title = "Void sprint aim",
Default = false,
Callback = function(state)
voidrushcontrol = state
if not state then
stopOverride()
end
end
})
Tabs.kill:Slider({
Title = "Self-aiming range",
Step = 5,
Value = {Min = 10, Max = 100, Default = aimDistance},
Suffix = "studs",
Callback = function(val)
aimDistance = val
end
})
local toggleOn = false
local toggleFlag = Instance.new("BoolValue")
toggleFlag.Name = "1x1x1x1AutoAim_ToggleFlag"
toggleFlag.Value = false
local aimMode = "Single target"
local predictMovement = false
local predictFactor = 3
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local workspacePlayers = workspace:WaitForChild("Players")
local survivorsFolder = workspacePlayers:WaitForChild("Survivors")
local dangerousAnimations = {
["131430497821198"] = true,
["100592913030351"] = true,
["70447634862911"] = true,
["83685305553364"] = true
}
local killerModels = {["1x1x1x1"] = true}
local autoRotateDisabledByScript = false
local currentTarget, isLockedOn, wasPlayingAnimation = nil, false, false
local function isKiller()
local char = localPlayer.Character
return char and killerModels[char.Name] or false
end
local function getMyHumanoid()
local char = localPlayer.Character
return char and char:FindFirstChildWhichIsA("Humanoid")
end
local function restoreAutoRotate()
local hum = getMyHumanoid()
if hum and autoRotateDisabledByScript then
hum.AutoRotate = true
autoRotateDisabledByScript = false
end
end
local function isPlayingDangerousAnimation()
local humanoid = getMyHumanoid()
if not humanoid then return false end
local animator = humanoid:FindFirstChildOfClass("Animator")
if not animator then return false end
for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
local animId = tostring(track.Animation.AnimationId):match("%d+")
if animId and dangerousAnimations[animId] then
return true
end
end
return false
end
local function getClosestSurvivor()
local myHumanoid = getMyHumanoid()
if not myHumanoid then return nil end
local myRoot = myHumanoid.Parent and myHumanoid.Parent:FindFirstChild("HumanoidRootPart")
if not myRoot then return nil end
local closest, closestDist = nil, math.huge
for _, obj in ipairs(survivorsFolder:GetChildren()) do
if obj:IsA("Model") then
local hrp = obj:FindFirstChild("HumanoidRootPart")
local hum = obj:FindFirstChildWhichIsA("Humanoid")
if hrp and hum and hum.Health > 0 then
local dist = (hrp.Position - myRoot.Position).Magnitude
if dist < closestDist then
closest = obj
closestDist = dist
end
end
end
end
return closest
end
localPlayer.CharacterAdded:Connect(function()
task.delay(0.1, function()
autoRotateDisabledByScript = false
end)
end)
RunService.RenderStepped:Connect(function()
if not toggleFlag.Value then
restoreAutoRotate()
currentTarget, isLockedOn, wasPlayingAnimation = nil, false, false
return
end
if not isKiller() then
restoreAutoRotate()
currentTarget, isLockedOn, wasPlayingAnimation = nil, false, false
return
end
local myHumanoid = getMyHumanoid()
if not myHumanoid then return end
local myRoot = myHumanoid.Parent and myHumanoid.Parent:FindFirstChild("HumanoidRootPart")
if not myRoot then return end
local isPlaying = isPlayingDangerousAnimation()
if isPlaying and not isLockedOn then
currentTarget = getClosestSurvivor()
if currentTarget then isLockedOn = true end
end
if isLockedOn and currentTarget then
local tHum = currentTarget:FindFirstChildWhichIsA("Humanoid")
local tHrp = currentTarget:FindFirstChild("HumanoidRootPart")
if (not tHum) or (tHum and tHum.Health <= 0) or (not tHrp) then
currentTarget, isLockedOn = nil, false
end
end
if (not isPlaying) and wasPlayingAnimation then
currentTarget, isLockedOn = nil, false
restoreAutoRotate()
end
wasPlayingAnimation = isPlaying
if isPlaying and isLockedOn and currentTarget and currentTarget:FindFirstChild("HumanoidRootPart") then
local hrp = currentTarget.HumanoidRootPart
local targetPos = hrp.Position
if not autoRotateDisabledByScript then
myHumanoid.AutoRotate = false
autoRotateDisabledByScript = true
end
if predictMovement then
local vel = hrp.Velocity
if vel.Magnitude > 2 then
targetPos = targetPos + hrp.CFrame.LookVector * predictFactor
end
end
local lookAt = Vector3.new(targetPos.X, myRoot.Position.Y, targetPos.Z)
if aimMode == "Single target" then
myRoot.CFrame = myRoot.CFrame:Lerp(CFrame.lookAt(myRoot.Position, lookAt), 0.99)
elseif aimMode == "Multiple targets" then
local newTarget = getClosestSurvivor()
if newTarget then currentTarget = newTarget end
myRoot.CFrame = myRoot.CFrame:Lerp(CFrame.lookAt(myRoot.Position, lookAt), 0.99)
elseif aimMode == "Transmit" then
local behindPos = hrp.Position - hrp.CFrame.LookVector * 3
myRoot.CFrame = CFrame.new(behindPos, targetPos)
end
end
end)
Tabs.kill:Section({Title = "1x1x1x1"})
Tabs.kill:Dropdown({
Title = "Aiming mode",
Values = {"Single target", "Multiple targets", "Transmit"},
Multi = false,
AllowNone = false,
Callback = function(selected)
aimMode = selected
end
})
Tabs.kill:Toggle({
Title = "Mass infection targeting",
Default = false,
Callback = function(state)
toggleOn = state
toggleFlag.Value = state
end
})
Tabs.kill:Toggle({
Title = "Forecast movement",
Default = false,
Callback = function(state)
predictMovement = state
end
})
Tabs.kill:Slider({
Title = "Prediction coefficient",
Step = 0.5,
Value = {Min = 1, Max = 10, Default = predictFactor},
Suffix = "Factor",
Callback = function(val)
predictFactor = val
end
})
Tabs.Anti:Section({Title = "Universal counter effect"})
local antiFeatures = {
no1x = false,
healthGlitch = false,
stun = false,
slow = false,
blindness = false,
subspace = false,
footsteps = false,
hiddenStats = false
}
Tabs.Anti:Toggle({
Title = "Reverse 1x1x1x 1 pop-up window",
Default = false,
Callback = function(state)
antiFeatures.no1x = state
if state then
task.spawn(function()
while antiFeatures.no1x do
task.wait(0.5)
local temp = LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
if temp and temp:FindFirstChild("1x1x1x1Popup") then
pcall(function()
if firesignal then
firesignal(temp["1x1x1x1Popup"].MouseButton1Click)
end
end)
end
end
end)
end
end
})
Tabs.Anti:Toggle({
Title = "Anti-life value error",
Default = false,
Callback = function(state)
antiFeatures.healthGlitch = state
if state then
task.spawn(function()
while antiFeatures.healthGlitch do
task.wait(1)
local tempUI = LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
if tempUI then
for _, v in pairs(tempUI:GetChildren()) do
if v.Name == "Frame" and v:FindFirstChild("Glitched") then
v:Destroy()
end
end
end
end
end)
end
end
})
Tabs.Anti:Toggle({
Title = "Anti-vertigo",
Default = false,
Callback = function(state)
antiFeatures.stun = state
if state then
task.spawn(function()
while antiFeatures.stun do
task.wait(0.1)
local char = LocalPlayer.Character
if char and char:FindFirstChild("SpeedMultipliers") then
local stunned = char.SpeedMultipliers:FindFirstChild("Stunned")
if stunned and stunned.Value ~= 1 then
stunned.Value = 1
end
end
end
end)
end
end
})
Tabs.Anti:Toggle({
Title = "Counter deceleration",
Default = false,
Callback = function(state)
antiFeatures.slow = state
if state then
task.spawn(function()
while antiFeatures.slow do
task.wait(0.1)
local char = LocalPlayer.Character
if char and char:FindFirstChild("SpeedMultipliers") then
for _, v in pairs(char.SpeedMultipliers:GetChildren()) do
if v:IsA("NumberValue") and v.Value < 1 then
v.Value = 1
end
end
end
end
end)
end
end
})
Tabs.Anti:Toggle({
Title = "Anti-blinding",
Default = false,
Callback = function(state)
antiFeatures.blindness = state
if state then
task.spawn(function()
while antiFeatures.blindness do
task.wait(0.5)
if Lighting:FindFirstChild("BlindnessBlur") then
Lighting.BlindnessBlur:Destroy()
end
end
end)
end
end
})
Tabs.Anti:Toggle({
Title = "Anti-subspace",
Default = false,
Callback = function(state)
antiFeatures.subspace = state
if state then
task.spawn(function()
while antiFeatures.subspace do
task.wait(0.5)
local subspaceEffects = {"SubspaceVFXBlur", "SubspaceVFXColorCorrection"}
for _, effectName in ipairs(subspaceEffects) do
if Lighting:FindFirstChild(effectName) then
Lighting[effectName]:Destroy()
end
end
end
end)
end
end
})
Tabs.Anti:Toggle({
Title = "Countertramp",
Default = false,
Callback = function(state)
antiFeatures.footsteps = state
if state then
task.spawn(function()
while antiFeatures.footsteps do
task.wait(0.5)
for _, sound in ipairs(Workspace:GetDescendants()) do
if sound:IsA("Sound") and sound.Name:find("Footstep") then
sound.Volume = 0
end
end
end
end)
end
end
})
local originalPlayerValues = {}
Tabs.Anti:Toggle({
Title = "Anti-hide data",
Default = false,
Callback = function(state)
antiFeatures.hiddenStats = state
for _, player in ipairs(Players:GetPlayers()) do
pcall(function()
if not player.PlayerData or not player.PlayerData.Settings or not player.PlayerData.Settings.Privacy then return end
if state then
if not originalPlayerValues[player.UserId] then
originalPlayerValues[player.UserId] = {}
end
local privacy = player.PlayerData.Settings.Privacy
for _, key in ipairs({"HideKillerWins", "HidePlaytime", "HideSurvivorWins"}) do
local value = privacy:FindFirstChild(key)
if value then
originalPlayerValues[player.UserId][key] = value.Value
value.Value = false
end
end
else
if originalPlayerValues[player.UserId] then
local privacy = player.PlayerData.Settings.Privacy
for key, val in pairs(originalPlayerValues[player.UserId]) do
local value = privacy:FindFirstChild(key)
if value then value.Value = val end
end
end
end
end)
end
if state then
Players.PlayerAdded:Connect(function(player)
if antiFeatures.hiddenStats then
task.wait(1)
pcall(function()
if player.PlayerData and player.PlayerData.Settings and player.PlayerData.Settings.Privacy then
local privacy = player.PlayerData.Settings.Privacy
for _, key in ipairs({"HideKillerWins", "HidePlaytime", "HideSurvivorWins"}) do
local value = privacy:FindFirstChild(key)
if value then value.Value = false end
end
end
end)
end
end)
end
end
})
end,
DoubleClick = true,
Tooltip = "Load",
DisabledTooltip = "I disabled！",
Disabled = false,
Visible = true,
Risky = false,
})
new:AddLabel("Double click to load")
new:AddLabel("[+]Dev Yuxingchen")
local MainTabbox = Tabs.Main:AddLeftTabbox()
local Lighting = MainTabbox:AddTab("Luminance control")
local Camera = MainTabbox:AddTab("Field of vision")
local lightingConnection
local cameraConnection
Lighting:AddSlider("B", {
Text = "Luminance value",
Min = 0,
Default = 0,
Max = 3,
Rounding = 1,
Compact = true,
Callback = function(v)
_env.Brightness = v
end
})
Lighting:AddCheckbox("No Shadows", {
Text = "No Shadows",
Default = false,
Callback = function(v)
_env.GlobalShadows = v
end
})
Lighting:AddCheckbox("Demisting", {
Text = "Demisting",
Default = false,
Callback = function(v)
_env.NoFog = v
end
})
Lighting:AddDivider()
Lighting:AddCheckbox("Enable Features", {
Text = "Enable",
Default = false,
Callback = function(v)
_env.Fullbright = v
if lightingConnection then
lightingConnection:Disconnect()
lightingConnection = nil
end
if v then
lightingConnection = game:GetService("RunService").RenderStepped:Connect(function()
if not game.Lighting:GetAttribute("FogStart") then
game.Lighting:SetAttribute("FogStart", game.Lighting.FogStart)
end
if not game.Lighting:GetAttribute("FogEnd") then
game.Lighting:SetAttribute("FogEnd", game.Lighting.FogEnd)
end
game.Lighting.FogStart = _env.NoFog and 0 or game.Lighting:GetAttribute("FogStart")
game.Lighting.FogEnd = _env.NoFog and math.huge or game.Lighting:GetAttribute("FogEnd")
local fog = game.Lighting:FindFirstChildOfClass("Atmosphere")
if fog then
if not fog:GetAttribute("Density") then
fog:SetAttribute("Density", fog.Density)
end
fog.Density = _env.NoFog and 0 or fog:GetAttribute("Density")
end
game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
game.Lighting.Brightness = _env.Brightness or 0
game.Lighting.GlobalShadows = not _env.GlobalShadows
end)
else
game.Lighting.OutdoorAmbient = Color3.fromRGB(55,55,55)
game.Lighting.Brightness = 0
game.Lighting.GlobalShadows = true
end
end
})
Camera:AddSlider("FieldOfView", {
Text = "Field of vision (FOV)",
Default = 80,
Min = 0,
Max = 120,
Rounding = 1,
Callback = function(Value)
_G.CurrentFOV = Value
local Camera = workspace.CurrentCamera
if Camera then
Camera.FieldOfView = Value
end
end,
})
Camera:AddToggle("CustomFOVToggle", {
Text = "Enable Field of View",
Default = false,
Callback = function(Value)
_G.CustomFOVEnabled = Value
if Value then
local Camera = workspace.CurrentCamera
if Camera then
Camera.FieldOfView = Options.FieldOfView.Value
end
end
end,
})
local V = Tabs.Main:AddLeftGroupbox('Christmas 🎄 (gingerbread)')
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local autoCandyConnection = nil
local lastTeleportTime = 0
local function teleportToRandomCandy()
local character = player.Character
if not character then return end
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
if not humanoidRootPart then return end
local targetFolder = Workspace:FindFirstChild("Map")
if targetFolder then
targetFolder = targetFolder:FindFirstChild("Ingame")
if targetFolder then
targetFolder = targetFolder:FindFirstChild("CurrencyLocations")
end
end
if not targetFolder then return end
local candyModels = {}
for _, child in ipairs(targetFolder:GetChildren()) do
if child:IsA("Model") or child:IsA("Part") or child:IsA("MeshPart") then
table.insert(candyModels, child)
end
end
if #candyModels > 0 then
local randomCandy = candyModels[math.random(1, #candyModels)]
local targetPosition
if randomCandy:IsA("Model") then
local primaryPart = randomCandy.PrimaryPart
if primaryPart then
targetPosition = primaryPart.Position
else
for _, part in ipairs(randomCandy:GetChildren()) do
if part:IsA("BasePart") then
targetPosition = part.Position
break
end
end
end
else
targetPosition = randomCandy.Position
end
if targetPosition then
humanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))
end
end
end
V:AddToggle('AutoCandyToggle', {
Text = 'Gingerbread Farm',
Default = false,
Callback = function(value)
if value then
autoCandyConnection = RunService.Heartbeat:Connect(function()
if tick() - lastTeleportTime >= 2 then
lastTeleportTime = tick()
teleportToRandomCandy()
end
end)
else
if autoCandyConnection then
autoCandyConnection:Disconnect()
autoCandyConnection = nil
end
end
end
})
V:AddToggle('CandyToggle', {
Text = 'esp gingerbread',
Default = false,
Callback = function(state)
if state then
CandyConnection = workspace.DescendantAdded:Connect(function(v)
local currencyFolder = workspace:FindFirstChild("Map")
if currencyFolder then
currencyFolder = currencyFolder:FindFirstChild("Ingame")
if currencyFolder then
currencyFolder = currencyFolder:FindFirstChild("CurrencyLocations")
if currencyFolder and v:IsDescendantOf(currencyFolder) and v:IsA("Model") then
local adornee = v
if v.PrimaryPart then
adornee = v.PrimaryPart
elseif v:FindFirstChildOfClass("Part") then
adornee = v:FindFirstChildOfClass("Part")
end
local billboard = Instance.new("BillboardGui")
billboard.Name = "CandyBillboard"
billboard.Parent = v
billboard.Adornee = adornee
billboard.Size = UDim2.new(0, 80, 0, 30)
billboard.StudsOffset = Vector3.new(0, 3, 0)
billboard.AlwaysOnTop = true
local nameLabel = Instance.new("TextLabel")
nameLabel.Parent = billboard
nameLabel.Size = UDim2.new(1, 0, 1, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = "Gingerbread"
nameLabel.TextColor3 = _G.CandyTextColor or Color3.new(0, 0.5, 1)
nameLabel.TextStrokeTransparency = 0.2
nameLabel.TextScaled = false
nameLabel.TextSize = 16
nameLabel.Font = Enum.Font.Oswald
nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
local cleanupConnection
cleanupConnection = v.AncestryChanged:Connect(function()
if not v.Parent then
if cleanupConnection then
cleanupConnection:Disconnect()
end
if billboard and billboard.Parent then
billboard:Destroy()
end
end
end)
local removalConnection
removalConnection = v.Destroying:Connect(function()
if removalConnection then
removalConnection:Disconnect()
end
if cleanupConnection then
cleanupConnection:Disconnect()
end
if billboard and billboard.Parent then
billboard:Destroy()
end
end)
end
end
end
end)
local currencyFolder = workspace:FindFirstChild("Map")
if currencyFolder then
currencyFolder = currencyFolder:FindFirstChild("Ingame")
if currencyFolder then
currencyFolder = currencyFolder:FindFirstChild("CurrencyLocations")
if currencyFolder then
for i, v in pairs(currencyFolder:GetDescendants()) do
if v:IsA("Model") then
local adornee = v
if v.PrimaryPart then
adornee = v.PrimaryPart
elseif v:FindFirstChildOfClass("Part") then
adornee = v:FindFirstChildOfClass("Part")
end
local billboard = Instance.new("BillboardGui")
billboard.Name = "CandyBillboard"
billboard.Parent = v
billboard.Adornee = adornee
billboard.Size = UDim2.new(0, 80, 0, 30)
billboard.StudsOffset = Vector3.new(0, 3, 0)
billboard.AlwaysOnTop = true
local nameLabel = Instance.new("TextLabel")
nameLabel.Parent = billboard
nameLabel.Size = UDim2.new(1, 0, 1, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = "Cookies [Christmas 🎄]"
nameLabel.TextColor3 = _G.CandyTextColor or Color3.new(0, 0.5, 1)
nameLabel.TextStrokeTransparency = 0.2
nameLabel.TextScaled = false
nameLabel.TextSize = 16
nameLabel.Font = Enum.Font.Oswald
nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
local cleanupConnection
cleanupConnection = v.AncestryChanged:Connect(function()
if not v.Parent then
if cleanupConnection then
cleanupConnection:Disconnect()
end
if billboard and billboard.Parent then
billboard:Destroy()
end
end
end)
local removalConnection
removalConnection = v.Destroying:Connect(function()
if removalConnection then
removalConnection:Disconnect()
end
if cleanupConnection then
cleanupConnection:Disconnect()
end
if billboard and billboard.Parent then
billboard:Destroy()
end
end)
end
end
end
end
end
else
if CandyConnection then
CandyConnection:Disconnect()
end
for i, v in pairs(workspace:GetDescendants()) do
if v:IsA("Model") and v:FindFirstChild("CandyBillboard") then
v.CandyBillboard:Destroy()
end
end
end
end
}):AddColorPicker("CandyColorPicker", {
Default = Color3.new(0, 0.5, 1),
Title = "Biscuit Marking Color",
Transparency = 0,
Callback = function(Value)
_G.CandyTextColor = Value
if Toggles.CandyToggle.Value then
for i, v in pairs(workspace:GetDescendants()) do
if v:IsA("Model") and v:FindFirstChild("CandyBillboard") then
local billboard = v.CandyBillboard
if billboard:FindFirstChildOfClass("TextLabel") then
billboard:FindFirstChildOfClass("TextLabel").TextColor3 = Value
end
end
end
end
end
})
local KillerSurvival = Tabs.Main:AddLeftGroupbox('Chat box visible')
KillerSurvival:AddCheckbox('AlwaysShowChat', {
Text = "Show chat box",
Callback = function(state)
if state then
_G.showChat = true
task.spawn(function()
while _G.showChat and task.wait() do
game:GetService("TextChatService"):FindFirstChildOfClass("ChatWindowConfiguration").Enabled = true
end
end)
else
_G.showChat = false
if playingState ~= "Spectating" then
game:GetService("TextChatService"):FindFirstChildOfClass("ChatWindowConfiguration").Enabled = false
end
end
end
})
function panic()
for i, v in pairs(Toggles) do
pcall(function()
if v.Value == false then return end
v:SetValue(false)
end)
end
end
Library:OnUnload(function()
_G.VoidsakenExecuted = false
panic()
getgenv().FlipUI:Destroy()
getgenv().AimbotUI:Destroy()
getgenv().BlockUI:Destroy()
end)
local ZZ = Tabs.Main:AddLeftGroupbox('Automatic pick up of items')
ZZ:AddCheckbox('Medical PACKAGE TRANSFER AND PICK UP', {
Text = 'Medical PACKAGE TRANSFER AND PICK UP',
Default = false,
Tooltip = 'Automatically transfer medical packages to your location and interact',
Callback = function(state)
autoTeleportMedkitEnabled = state
if autoTeleportMedkitEnabled then
teleportMedkitThread = task.spawn(function()
while autoTeleportMedkitEnabled and task.wait(0.5) do
local character = game.Players.LocalPlayer.Character
if character and character:FindFirstChild("HumanoidRootPart") then
local humanoidRootPart = character.HumanoidRootPart
local medkit = workspace:FindFirstChild("Map", true)
if medkit then
medkit = medkit:FindFirstChild("Ingame", true)
if medkit then
medkit = medkit:FindFirstChild("Medkit", true)
if medkit then
local itemRoot = medkit:FindFirstChild("ItemRoot", true)
if itemRoot then
itemRoot.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * 1
local prompt = itemRoot:FindFirstChild("ProximityPrompt", true)
if prompt then
fireproximityprompt(prompt)
end
end
end
end
end
end
end
end)
elseif teleportMedkitThread then
task.cancel(teleportMedkitThread)
teleportMedkitThread = nil
end
end
})
ZZ:AddCheckbox('Coke transfer and pick up', {
Text = 'Coke transfer and pick up',
Default = false,
Tooltip = 'Automatically transfer Coke to your location and interact',
Callback = function(state)
autoTeleportColaEnabled = state
if autoTeleportColaEnabled then
teleportColaThread = task.spawn(function()
while autoTeleportColaEnabled and task.wait(0.5) do
local character = game.Players.LocalPlayer.Character
if character and character:FindFirstChild("HumanoidRootPart") then
local humanoidRootPart = character.HumanoidRootPart
local cola = workspace:FindFirstChild("Map", true)
if cola then
cola = cola:FindFirstChild("Ingame", true)
if cola then
cola = cola:FindFirstChild("BloxyCola", true)
if cola then
local itemRoot = cola:FindFirstChild("ItemRoot", true)
if itemRoot then
itemRoot.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * 1
local prompt = itemRoot:FindFirstChild("ProximityPrompt", true)
if prompt then
fireproximityprompt(prompt)
end
end
end
end
end
end
end
end)
elseif teleportColaThread then
task.cancel(teleportColaThread)
teleportColaThread = nil
end
end
})
if getgenv().ExistingConnections then
for _, conn in ipairs(getgenv().ExistingConnections) do
if conn then
pcall(function() conn:Disconnect() end)
end
end
end
getgenv().ExistingConnections = {}
getgenv().Players = game:GetService("Players")
getgenv().RunService = game:GetService("RunService")
getgenv().LocalPlayer = getgenv().Players.LocalPlayer
getgenv().ReplicatedStorage = game:GetService("ReplicatedStorage")
getgenv().buffer = buffer or require(getgenv().ReplicatedStorage.Buffer)
getgenv().RemoteEvent = getgenv().ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")
local Plrs = getgenv().Players
local RSvc = getgenv().RunService
local LocalP = getgenv().LocalPlayer
local RS = getgenv().ReplicatedStorage
getgenv().AutoBlockSounds = {
["102228729296384"]=true,["140242176732868"]=true,["112809109188560"]=true,
["136323728355613"]=true,["115026634746636"]=true,["84116622032112"]=true,
["108907358619313"]=true,["127793641088496"]=true,["86174610237192"]=true,
["95079963655241"]=true,["101199185291628"]=true,["119942598489800"]=true,
["84307400688050"]=true,["113037804008732"]=true,["105200830849301"]=true,
["75330693422988"]=true,["82221759983649"]=true,["81702359653578"]=true,
["108610718831698"]=true,["112395455254818"]=true,["109431876587852"]=true,
["109348678063422"]=true,["85853080745515"]=true,["12222216"]=true,
["105840448036441"]=true,["114742322778642"]=true,["119583605486352"]=true,
["79980897195554"]=true,["71805956520207"]=true,["79391273191671"]=true,
["89004992452376"]=true,["101553872555606"]=true,["101698569375359"]=true,
["106300477136129"]=true,["116581754553533"]=true,["117231507259853"]=true,
["119089145505438"]=true,["121954639447247"]=true,["125213046326879"]=true,
["131406927389838"]=true,["117173212095661"]=true,["104910828105172"]=true,
["128856426573270"]=true,["131123355704017"]=true,["80516583309685"]=true,
["99829427721752"]=true,["71834552297085"]=true,["75467546215199"]=true,
["121369993837377"]=true,["89315669689903"]=true,
["79222929114377"]=true,["70845653728841"]=true,["107444859834748"]=true,
["110372418055226"]=true,["86833981571073"]=true,["86494585504534"]=true,
["76959687420003"]=true,["90878551190839"]=true,["77245770579014"]=true,
["85810983952228"]=true,["110115912768379"]=true,["94043596324983"]=true
}
getgenv().AutoBlockAnims = {
["126830014841198"]=true,["126355327951215"]=true,["121086746534252"]=true,
["18885909645"]=true,["98456918873918"]=true,["105458270463374"]=true,
["83829782357897"]=true,["125403313786645"]=true,["118298475669935"]=true,
["82113744478546"]=true,["70371667919898"]=true,["99135633258223"]=true,
["97167027849946"]=true,["109230267448394"]=true,["139835501033932"]=true,
["126896426760253"]=true,["109667959938617"]=true,["126681776859538"]=true,
["129976080405072"]=true,["121293883585738"]=true,["81639435858902"]=true,
["137314737492715"]=true,["92173139187970"]=true,["114506382930939"]=true,
["94162446513587"]=true,["93069721274110"]=true,["97433060861952"]=true,
["106847695270773"]=true,["120112897026015"]=true,["74707328554358"]=true,
["133336594357903"]=true,["86204001129974"]=true,["131543461321709"]=true,
["106776364623742"]=true,["114356208094580"]=true,["106538427162796"]=true,
["131430497821198"]=true,["100592913030351"]=true,["70447634862911"]=true,
["83685305553364"]=true,["126171487400618"]=true,["83251433279852"]=true,
["122709416391891"]=true,["87989533095285"]=true,["139309647473555"]=true,
["133363345661032"]=true,["128414736976503"]=true,["88451353906104"]=true,
["81299297965542"]=true,["99829427721752"]=true,["101031946095087"]=true,
["96571077893813"]=true,["138938529389204"]=true,["92645737884601"]=true,["124705663396411"]=true,["88451353906104"]=true
}
getgenv().PunchAnims = {
["108911997126897"]=true,["82137285150006"]=true,["129843313690921"]=true,
["140703210927645"]=true,["136007065400978"]=true,["86096387000557"]=true,
["87259391926321"]=true,["86709774283672"]=true,["108807732150251"]=true,
["138040001965654"]=true
}
getgenv().AutoBlockEnabled = false
getgenv().LooseFacingCheck = false
getgenv().SenseRange = 18
getgenv().PlayerFacingAngle = 90
getgenv().KillerFacingAngle = 90
getgenv().KillerFacingCheckEnabled = false
getgenv().KillersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")
getgenv().SenseRangeSq = getgenv().SenseRange * getgenv().SenseRange
getgenv().FacingCheckEnabled = false
getgenv().InnerCircleVisible = false
getgenv().OuterCircleVisible = false
getgenv().KillerCircles = {}
getgenv().SoundHooks = {}
getgenv().AnimHooks = {}
getgenv().SoundBlockedUntil = {}
getgenv().AnimBlockedUntil = {}
getgenv().autoPunchOn = false
getgenv().aimbotPunchOn = false
getgenv().punchRange = 50
getgenv().aimbotDelay = 0.1
getgenv().lastAimbotTime = 0
getgenv().KnownKillers = {"c00lkidd","Jason","JohnDoe","1x1x1x1","Noli","Slasher","Sixer","Nosferatu"}
getgenv().CachedGui = getgenv().LocalPlayer:WaitForChild("PlayerGui")
getgenv().CachedPunchBtn = nil
getgenv().CachedCharges = nil
getgenv().CachedBlockBtn = nil
getgenv().CachedCooldown = nil
getgenv().HDPullEnabled = false
getgenv().HDSpeed = 12
getgenv().pulling = false
getgenv().wallCheckEnabled = false
getgenv().visualizationParts = {}
getgenv().lastVisUpdate = 0
getgenv().visUpdateInterval = 0.033
getgenv().VisualizationMode = "指南针"
getgenv().BoxLength = 15
getgenv().BoxWidth = 6
getgenv().BoxColor = Color3.fromRGB(255, 0, 255)
getgenv().BoxTransparency = 0.7
getgenv().BoxSafeColor = Color3.fromRGB(0, 255, 0)
getgenv().BoxDangerColor = Color3.fromRGB(255, 0, 0)
getgenv().FireBlockRemote = function()
local args = {"UseActorAbility", {buffer.fromstring("\3\5\0\0\0Block")}}
game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent:FireServer(unpack(args))
end
getgenv().fireRemotePunch = function()
local args = {"UseActorAbility", {buffer.fromstring("\3\5\0\0\0Punch")}}
game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent:FireServer(unpack(args))
end
getgenv().IsPlayerFacingKiller = function(myRoot,killerRoot)
if not getgenv().FacingCheckEnabled then return true end
if not myRoot or not killerRoot then return false end
local dirToKiller = (killerRoot.Position - myRoot.Position).Unit
local playerLookDir = myRoot.CFrame.LookVector
local dotProduct = playerLookDir:Dot(dirToKiller)
local angleInDegrees = math.deg(math.acos(math.clamp(dotProduct,-1,1)))
return angleInDegrees <= getgenv().PlayerFacingAngle
end
getgenv().IsKillerFacingPlayer = function(myRoot,killerRoot)
if not getgenv().KillerFacingCheckEnabled then return true end
if not myRoot or not killerRoot then return false end
local dirToPlayer = (myRoot.Position - killerRoot.Position).Unit
local killerLookDir = killerRoot.CFrame.LookVector
local dotProduct = killerLookDir:Dot(dirToPlayer)
local angleInDegrees = math.deg(math.acos(math.clamp(dotProduct,-1,1)))
return angleInDegrees <= getgenv().KillerFacingAngle
end
getgenv().HasLineOfSight = function(targetRoot)
if not getgenv().wallCheckEnabled then return true end
local myRoot = LocalP.Character and LocalP.Character:FindFirstChild("HumanoidRootPart")
if not myRoot then return false end
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.IgnoreWater = true
rayParams.FilterDescendantsInstances = {LocalP.Character}
local origin = myRoot.Position
local direction = targetRoot.Position - origin
local result = workspace:Raycast(origin,direction,rayParams)
return not result or result.Instance:IsDescendantOf(targetRoot.Parent)
end
getgenv().IsPlayerInBox = function(myRoot, killerRoot)
if not myRoot or not killerRoot then return false end
local forward = killerRoot.CFrame.LookVector * (getgenv().BoxLength/2 + 3 - 4)
local boxPos = killerRoot.Position + forward
local boxCFrame = CFrame.lookAt(boxPos, boxPos + killerRoot.CFrame.LookVector * 100)
local relative = myRoot.Position - boxPos
local localSpace = boxCFrame:VectorToObjectSpace(relative)
local half = Vector3.new(getgenv().BoxWidth, 3, getgenv().BoxLength) / 2
return math.abs(localSpace.X) <= half.X and math.abs(localSpace.Y) <= half.Y and math.abs(localSpace.Z) <= half.Z
end
getgenv().CheckAllBlockConditions = function(myRoot,killerRoot)
if not myRoot or not killerRoot then return false end
if getgenv().VisualizationMode == "Box" then
if not getgenv().IsPlayerInBox(myRoot, killerRoot) then return false end
elseif getgenv().VisualizationMode == "球体" then
local dvec = killerRoot.Position - myRoot.Position
local distSq = dvec.X^2 + dvec.Y^2 + dvec.Z^2
if distSq > getgenv().SenseRangeSq then return false end
else
local dvec = killerRoot.Position - myRoot.Position
local distSq = dvec.X^2 + dvec.Y^2 + dvec.Z^2
if distSq > getgenv().SenseRangeSq then return false end
end
if not getgenv().HasLineOfSight(killerRoot) then return false end
if not getgenv().IsPlayerFacingKiller(myRoot,killerRoot) then return false end
if not getgenv().IsKillerFacingPlayer(myRoot,killerRoot) then return false end
return true
end
getgenv().GetSoundIdNumeric = function(snd)
if not snd or not snd.SoundId then return nil end
local sid = tostring(snd.SoundId)
return sid:match("%d+")
end
getgenv().GetAnimIdNumeric = function(anim)
if not anim or not anim.AnimationId then return nil end
local aid = tostring(anim.AnimationId)
return aid:match("%d+")
end
getgenv().GetSoundPosition = function(snd)
if not snd then return nil end
if snd.Parent and snd.Parent:IsA("BasePart") then
return snd.Parent.Position,snd.Parent
end
if snd.Parent and snd.Parent:IsA("Attachment") and snd.Parent.Parent and snd.Parent.Parent:IsA("BasePart") then
return snd.Parent.Parent.Position,snd.Parent.Parent
end
local found = snd.Parent and snd.Parent:FindFirstChildWhichIsA("BasePart",true)
return found and found.Position,found or nil,nil
end
getgenv().GetCharFromDescendant = function(inst)
if not inst then return nil end
local mdl = inst:FindFirstAncestorOfClass("Model")
return mdl and mdl:FindFirstChildOfClass("Humanoid") and mdl or nil
end
getgenv().CanUseBlock = function()
if getgenv().CachedCooldown and getgenv().CachedCooldown.Text ~= "" then return false end
return true
end
getgenv().DoHDPull = function(targetPos)
if getgenv().pulling or not getgenv().CanUseBlock() then return end
getgenv().pulling = true
local hrp = LocalP.Character and LocalP.Character:FindFirstChild("HumanoidRootPart")
if not hrp then getgenv().pulling = false return end
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(40000,0,40000)
bv.Velocity = Vector3.zero
bv.Parent = hrp
local conn = RSvc.Heartbeat:Connect(function()
if not bv.Parent then conn:Disconnect() getgenv().pulling = false return end
local vec = targetPos - hrp.Position
if vec.Magnitude < 5 then bv:Destroy() conn:Disconnect() getgenv().pulling = false return end
bv.Velocity = vec.Unit * (getgenv().HDSpeed * 20)
end)
task.delay(0.5,function()
if bv and bv.Parent then bv:Destroy() end
if conn then conn:Disconnect() end
getgenv().pulling = false
end)
end
getgenv().AttemptBlockSound = function(snd)
if not getgenv().AutoBlockEnabled then return end
if not snd or not snd:IsA("Sound") then return end
if not snd.IsPlaying then return end
local id = getgenv().GetSoundIdNumeric(snd)
if not id or not getgenv().AutoBlockSounds[id] then return end
local now = tick()
if getgenv().SoundBlockedUntil[snd] and now < getgenv().SoundBlockedUntil[snd] then return end
local myRoot = LocalP.Character and LocalP.Character:FindFirstChild("HumanoidRootPart")
if not myRoot then return end
local pos,part = getgenv().GetSoundPosition(snd)
if not pos or not part then return end
local char = getgenv().GetCharFromDescendant(part)
local plr = char and Plrs:GetPlayerFromCharacter(char)
if not plr or plr == LocalP then return end
local hrp = char:FindFirstChild("HumanoidRootPart")
if not hrp then return end
if not getgenv().CheckAllBlockConditions(myRoot,hrp) then return end
getgenv().FireBlockRemote()
if getgenv().HDPullEnabled then
getgenv().DoHDPull(hrp.Position)
end
getgenv().SoundBlockedUntil[snd] = now + 1.2
end
getgenv().AttemptBlockAnim = function(animTrack)
if not getgenv().AutoBlockEnabled then return end
if not animTrack or not animTrack.Animation then return end
if not animTrack.IsPlaying then return end
local id = getgenv().GetAnimIdNumeric(animTrack.Animation)
if not id or not getgenv().AutoBlockAnims[id] then return end
local now = tick()
if getgenv().AnimBlockedUntil[animTrack] and now < getgenv().AnimBlockedUntil[animTrack] then return end
local myRoot = LocalP.Character and LocalP.Character:FindFirstChild("HumanoidRootPart")
if not myRoot then return end
local animator = animTrack.Parent
if not animator or not animator:IsA("Animator") then return end
local char = getgenv().GetCharFromDescendant(animator)
if not char then return end
local plr = Plrs:GetPlayerFromCharacter(char)
if not plr or plr == LocalP then return end
local hrp = char:FindFirstChild("HumanoidRootPart")
if not hrp then return end
if not getgenv().CheckAllBlockConditions(myRoot,hrp) then return end
getgenv().FireBlockRemote()
if getgenv().HDPullEnabled then
getgenv().DoHDPull(hrp.Position)
end
getgenv().AnimBlockedUntil[animTrack] = now + 1.2
end
getgenv().HookSound = function(snd)
if not snd or not snd:IsA("Sound") then return end
if getgenv().SoundHooks[snd] then return end
local playConn = snd.Played:Connect(function()
pcall(getgenv().AttemptBlockSound,snd)
end)
local propConn = snd:GetPropertyChangedSignal("IsPlaying"):Connect(function()
if snd.IsPlaying then pcall(getgenv().AttemptBlockSound,snd) end
end)
local destroyConn
destroyConn = snd.Destroying:Connect(function()
if playConn.Connected then playConn:Disconnect() end
if propConn.Connected then propConn:Disconnect() end
if destroyConn.Connected then destroyConn:Disconnect() end
getgenv().SoundHooks[snd] = nil
getgenv().SoundBlockedUntil[snd] = nil
end)
getgenv().SoundHooks[snd] = {playConn,propConn,destroyConn}
if snd.IsPlaying then
task.spawn(function() pcall(getgenv().AttemptBlockSound,snd) end)
end
end
getgenv().HookAnimator = function(animator)
if not animator or not animator:IsA("Animator") then return end
animator.AnimationPlayed:Connect(function(animTrack)
pcall(function()
local playConn = animTrack:GetPropertyChangedSignal("IsPlaying"):Connect(function()
if animTrack.IsPlaying then
pcall(getgenv().AttemptBlockAnim,animTrack)
end
end)
animTrack.Stopped:Connect(function()
if playConn.Connected then playConn:Disconnect() end
getgenv().AnimBlockedUntil[animTrack] = nil
end)
if animTrack.IsPlaying then
pcall(getgenv().AttemptBlockAnim,animTrack)
end
end)
end)
end
for _,d in ipairs(game:GetDescendants()) do
if d:IsA("Sound") then pcall(getgenv().HookSound,d) end
if d:IsA("Animator") then pcall(getgenv().HookAnimator,d) end
end
game.DescendantAdded:Connect(function(d)
if d:IsA("Sound") then pcall(getgenv().HookSound,d) end
if d:IsA("Animator") then pcall(getgenv().HookAnimator,d) end
end)
getgenv().CreateCompassVisualization = function(killer, myRoot)
if not killer or not killer:FindFirstChild("HumanoidRootPart") or not myRoot then return nil end
local killerRoot = killer.HumanoidRootPart
local folder = Instance.new("Folder")
folder.Name = "CompassVisualization"
folder.Parent = killerRoot
local dirToPlayer = (myRoot.Position - killerRoot.Position).Unit
local forward = Vector3.new(dirToPlayer.X, 0, dirToPlayer.Z).Unit
local right = Vector3.new(-forward.Z, 0, forward.X)
local angle = getgenv().KillerFacingCheckEnabled and getgenv().KillerFacingAngle or 360
local angleRad = math.rad(angle)
local distance = getgenv().SenseRange
local segments = 24
local centerPart = Instance.new("Part")
centerPart.Name = "Center"
centerPart.Size = Vector3.new(0.5,0.1,0.5)
centerPart.Anchored = true
centerPart.CanCollide = false
centerPart.Transparency = 0.5
centerPart.Material = Enum.Material.Neon
centerPart.Color = Color3.fromRGB(255,255,0)
centerPart.Position = killerRoot.Position + Vector3.new(0, 0.1, 0)
centerPart.Parent = folder
local parts = {centerPart}
for i = 1, segments do
local part = Instance.new("Part")
part.Name = "ArcPoint"..i
part.Size = Vector3.new(0.3,0.1,0.3)
part.Anchored = true
part.CanCollide = false
part.Transparency = 0.6
part.Material = Enum.Material.Neon
part.Color = Color3.fromRGB(255,100,100)
part.Parent = folder
table.insert(parts, part)
end
return {folder = folder, parts = parts, killer = killer, mode = "指南针"}
end
getgenv().CreateFixedVisualization = function(killer)
if not killer or not killer:FindFirstChild("HumanoidRootPart") then return nil end
local killerRoot = killer.HumanoidRootPart
local folder = Instance.new("Folder")
folder.Name = "FixedVisualization"
folder.Parent = killerRoot
local segments = 24
local parts = {}
local centerPart = Instance.new("Part")
centerPart.Name = "Center"
centerPart.Size = Vector3.new(0.5,0.1,0.5)
centerPart.Anchored = true
centerPart.CanCollide = false
centerPart.Transparency = 0.5
centerPart.Material = Enum.Material.Neon
centerPart.Color = Color3.fromRGB(255,255,0)
centerPart.Position = killerRoot.Position + Vector3.new(0, 0.1, 0)
centerPart.Parent = folder
table.insert(parts, centerPart)
for i = 1, segments do
local part = Instance.new("Part")
part.Name = "ArcPoint"..i
part.Size = Vector3.new(0.3,0.1,0.3)
part.Anchored = true
part.CanCollide = false
part.Transparency = 0.6
part.Material = Enum.Material.Neon
part.Color = Color3.fromRGB(100,100,255)
part.Parent = folder
table.insert(parts, part)
end
return {folder = folder, parts = parts, killer = killer, mode = "固定"}
end
getgenv().CreateBoxVisualization = function(killer)
if not killer or not killer:FindFirstChild("HumanoidRootPart") then return nil end
local killerRoot = killer.HumanoidRootPart
local folder = Instance.new("Folder")
folder.Name = "BoxVisualization"
folder.Parent = killerRoot
local box = Instance.new("Part")
box.Name = "DetectionBox"
box.Material = Enum.Material.Neon
box.Anchored = true
box.CanCollide = false
box.Transparency = getgenv().BoxTransparency
box.Color = getgenv().BoxColor
box.Size = Vector3.new(getgenv().BoxWidth, 3, getgenv().BoxLength)
box.Parent = folder
return {folder = folder, box = box, killer = killer, mode = "Box"}
end
getgenv().CreateSphereVisualization = function(killer)
if not killer or not killer:FindFirstChild("HumanoidRootPart") then return nil end
local killerRoot = killer.HumanoidRootPart
local folder = Instance.new("Folder")
folder.Name = "SphereVisualization"
folder.Parent = killerRoot
local sphere = Instance.new("Part")
sphere.Name = "DetectionSphere"
sphere.Shape = Enum.PartType.Ball
sphere.Material = Enum.Material.Neon
sphere.Anchored = true
sphere.CanCollide = false
sphere.Transparency = 0.85
sphere.Color = Color3.fromRGB(255, 0, 0)
sphere.Size = Vector3.new(getgenv().SenseRange * 2, getgenv().SenseRange * 2, getgenv().SenseRange * 2)
sphere.Parent = folder
return {folder = folder, sphere = sphere, killer = killer, mode = "球体"}
end
getgenv().UpdateCompassVisualization = function(visData, myRoot)
if not visData or not visData.folder or not visData.folder.Parent then return end
if not myRoot or not visData.killer or not visData.killer:FindFirstChild("HumanoidRootPart") then return end
local killerRoot = visData.killer.HumanoidRootPart
local dirToPlayer = (myRoot.Position - killerRoot.Position).Unit
local forward = Vector3.new(dirToPlayer.X, 0, dirToPlayer.Z).Unit
local right = Vector3.new(-forward.Z, 0, forward.X)
local angle = getgenv().KillerFacingCheckEnabled and getgenv().KillerFacingAngle or 360
local angleRad = math.rad(angle)
local distance = getgenv().SenseRange
visData.parts[1].Position = killerRoot.Position + Vector3.new(0, 0.1, 0)
for i = 2, #visData.parts do
local part = visData.parts[i]
local t = (i - 2) / (#visData.parts - 2)
local currentAngle = -angleRad/2 + angleRad * t
local direction = forward * math.cos(currentAngle) + right * math.sin(currentAngle)
part.Position = killerRoot.Position + Vector3.new(0, 0.1, 0) + direction * distance
end
local shouldBlock = getgenv().CheckAllBlockConditions(myRoot, killerRoot)
local color = shouldBlock and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
for _, part in ipairs(visData.parts) do
part.Color = color
end
end
getgenv().UpdateFixedVisualization = function(visData, myRoot)
if not visData or not visData.folder or not visData.folder.Parent then return end
if not myRoot or not visData.killer or not visData.killer:FindFirstChild("HumanoidRootPart") then return end
local killerRoot = visData.killer.HumanoidRootPart
local forward = killerRoot.CFrame.LookVector
local right = Vector3.new(-forward.Z, 0, forward.X)
local angle = getgenv().KillerFacingCheckEnabled and getgenv().KillerFacingAngle or 360
local angleRad = math.rad(angle)
local distance = getgenv().SenseRange
visData.parts[1].Position = killerRoot.Position + Vector3.new(0, 0.1, 0)
for i = 2, #visData.parts do
local part = visData.parts[i]
local t = (i - 2) / (#visData.parts - 2)
local currentAngle = -angleRad/2 + angleRad * t
local direction = forward * math.cos(currentAngle) + right * math.sin(currentAngle)
direction = Vector3.new(direction.X, 0, direction.Z).Unit
part.Position = killerRoot.Position + Vector3.new(0, 0.1, 0) + direction * distance
end
local shouldBlock = getgenv().CheckAllBlockConditions(myRoot, killerRoot)
local color = shouldBlock and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 255)
for _, part in ipairs(visData.parts) do
part.Color = color
end
end
getgenv().UpdateBoxVisualization = function(visData, myRoot)
if not visData or not visData.folder or not visData.folder.Parent then return end
if not myRoot or not visData.killer or not visData.killer:FindFirstChild("HumanoidRootPart") then return end
local killerRoot = visData.killer.HumanoidRootPart
local forward = killerRoot.CFrame.LookVector * (getgenv().BoxLength/2 + 3 - 4)
local boxPos = killerRoot.Position + forward + Vector3.new(0, 0, 0)
visData.box.Size = Vector3.new(getgenv().BoxWidth, 3, getgenv().BoxLength)
visData.box.CFrame = CFrame.lookAt(boxPos, boxPos + killerRoot.CFrame.LookVector * 100)
visData.box.Transparency = getgenv().BoxTransparency
local shouldBlock = getgenv().IsPlayerInBox(myRoot, killerRoot) and getgenv().CheckAllBlockConditions(myRoot, killerRoot)
visData.box.Color = shouldBlock and getgenv().BoxSafeColor or getgenv().BoxDangerColor
end
getgenv().UpdateSphereVisualization = function(visData, myRoot)
if not visData or not visData.folder or not visData.folder.Parent then return end
if not myRoot or not visData.killer or not visData.killer:FindFirstChild("HumanoidRootPart") then return end
local killerRoot = visData.killer.HumanoidRootPart
visData.sphere.Size = Vector3.new(getgenv().SenseRange * 2, getgenv().SenseRange * 2, getgenv().SenseRange * 2)
visData.sphere.CFrame = killerRoot.CFrame
local distance = (myRoot.Position - killerRoot.Position).Magnitude
local shouldBlock = distance <= getgenv().SenseRange and getgenv().CheckAllBlockConditions(myRoot, killerRoot)
visData.sphere.Color = shouldBlock and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end
getgenv().CreateVisualizationForKiller = function(killer)
if not killer or not killer:FindFirstChild("HumanoidRootPart") then return nil end
if getgenv().VisualizationMode == "指南针" then
local myRoot = LocalP.Character and LocalP.Character:FindFirstChild("HumanoidRootPart")
return getgenv().CreateCompassVisualization(killer, myRoot)
elseif getgenv().VisualizationMode == "固定" then
return getgenv().CreateFixedVisualization(killer)
elseif getgenv().VisualizationMode == "Box" then
return getgenv().CreateBoxVisualization(killer)
elseif getgenv().VisualizationMode == "球体" then
return getgenv().CreateSphereVisualization(killer)
end
return nil
end
getgenv().UpdateVisualization = function(visData, myRoot)
if not visData then return end
if visData.mode == "指南针" then
getgenv().UpdateCompassVisualization(visData, myRoot)
elseif visData.mode == "固定" then
getgenv().UpdateFixedVisualization(visData, myRoot)
elseif visData.mode == "Box" then
getgenv().UpdateBoxVisualization(visData, myRoot)
elseif visData.mode == "球体" then
getgenv().UpdateSphereVisualization(visData, myRoot)
end
end
getgenv().AddKillerCircle = function(killer)
if not killer:FindFirstChild("HumanoidRootPart") then return end
if getgenv().KillerCircles[killer] then return end
local innerCirc, outerCirc
if getgenv().InnerCircleVisible then
innerCirc = Instance.new("CylinderHandleAdornment")
innerCirc.Name = "KillerInnerCircle"
innerCirc.Adornee = killer.HumanoidRootPart
innerCirc.Color3 = Color3.fromRGB(255,0,0)
innerCirc.AlwaysOnTop = true
innerCirc.ZIndex = 1
innerCirc.Transparency = 0.7
innerCirc.Radius = getgenv().SenseRange
innerCirc.Height = 0.1
innerCirc.CFrame = CFrame.Angles(math.rad(90),0,0)
innerCirc.Parent = killer.HumanoidRootPart
end
if getgenv().OuterCircleVisible then
outerCirc = Instance.new("CylinderHandleAdornment")
outerCirc.Name = "KillerOuterCircle"
outerCirc.Adornee = killer.HumanoidRootPart
outerCirc.Color3 = Color3.fromRGB(0,255,255)
outerCirc.AlwaysOnTop = true
outerCirc.ZIndex = 0
outerCirc.Transparency = 0.3
outerCirc.Radius = getgenv().punchRange
outerCirc.Height = 0.1
outerCirc.CFrame = CFrame.Angles(math.rad(90),0,0)
outerCirc.Parent = killer.HumanoidRootPart
end
local visData = getgenv().CreateVisualizationForKiller(killer)
getgenv().KillerCircles[killer] = {innerCircle = innerCirc, outerCircle = outerCirc, visualization = visData}
end
getgenv().RemoveKillerCircle = function(killer)
if getgenv().KillerCircles[killer] then
if getgenv().KillerCircles[killer].innerCircle then
getgenv().KillerCircles[killer].innerCircle:Destroy()
end
if getgenv().KillerCircles[killer].outerCircle then
getgenv().KillerCircles[killer].outerCircle:Destroy()
end
if getgenv().KillerCircles[killer].visualization and getgenv().KillerCircles[killer].visualization.folder then
getgenv().KillerCircles[killer].visualization.folder:Destroy()
end
getgenv().KillerCircles[killer] = nil
end
end
getgenv().RefreshKillerCircles = function()
for _,killer in ipairs(getgenv().KillersFolder:GetChildren()) do
if getgenv().InnerCircleVisible or getgenv().OuterCircleVisible then
getgenv().AddKillerCircle(killer)
else
getgenv().RemoveKillerCircle(killer)
end
end
end
getgenv().UpdateVisualizationMode = function(newMode)
getgenv().VisualizationMode = newMode
for killer, data in pairs(getgenv().KillerCircles) do
if data.visualization and data.visualization.folder then
data.visualization.folder:Destroy()
end
local newVisData = getgenv().CreateVisualizationForKiller(killer)
data.visualization = newVisData
end
end
getgenv().UpdateBoxColors = function()
for killer, data in pairs(getgenv().KillerCircles) do
if data.visualization and data.visualization.mode == "Box" and data.visualization.box then
data.visualization.box.Transparency = getgenv().BoxTransparency
end
end
end
RSvc.Heartbeat:Connect(function()
if not (getgenv().InnerCircleVisible or getgenv().OuterCircleVisible) then return end
local now = tick()
if now - getgenv().lastVisUpdate < getgenv().visUpdateInterval then return end
getgenv().lastVisUpdate = now
local myRoot = LocalP.Character and LocalP.Character:FindFirstChild("HumanoidRootPart")
if not myRoot then return end
for killer, data in pairs(getgenv().KillerCircles) do
if killer:FindFirstChild("HumanoidRootPart") then
local killerRoot = killer.HumanoidRootPart
if data.innerCircle and data.innerCircle.Parent then
data.innerCircle.Radius = getgenv().SenseRange
local shouldBlock = getgenv().CheckAllBlockConditions(myRoot, killerRoot)
data.innerCircle.Color3 = shouldBlock and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end
if data.outerCircle and data.outerCircle.Parent then
data.outerCircle.Radius = getgenv().punchRange
local dist = (killerRoot.Position - myRoot.Position).Magnitude
data.outerCircle.Color3 = dist <= getgenv().punchRange and Color3.fromRGB(0, 150, 150) or Color3.fromRGB(0, 100, 100)
end
if data.visualization then
pcall(getgenv().UpdateVisualization, data.visualization, myRoot)
end
end
end
end)
getgenv().KillersFolder.ChildAdded:Connect(function(killer)
if getgenv().InnerCircleVisible or getgenv().OuterCircleVisible then
task.spawn(function()
local hrp = killer:WaitForChild("HumanoidRootPart",5)
if hrp then getgenv().AddKillerCircle(killer) end
end)
end
end)
getgenv().KillersFolder.ChildRemoved:Connect(function(killer)
getgenv().RemoveKillerCircle(killer)
end)
getgenv().RefreshUI = function()
getgenv().CachedGui = getgenv().LocalPlayer:FindFirstChild("PlayerGui") or getgenv().CachedGui
local mainUI = getgenv().CachedGui and getgenv().CachedGui:FindFirstChild("MainUI")
if mainUI then
local abilityContainer = mainUI:FindFirstChild("AbilityContainer")
getgenv().CachedPunchBtn = abilityContainer and abilityContainer:FindFirstChild("Punch")
getgenv().CachedBlockBtn = abilityContainer and abilityContainer:FindFirstChild("Block")
getgenv().CachedCharges = getgenv().CachedPunchBtn and getgenv().CachedPunchBtn:FindFirstChild("Charges")
getgenv().CachedCooldown = getgenv().CachedBlockBtn and getgenv().CachedBlockBtn:FindFirstChild("CooldownTime")
else
getgenv().CachedPunchBtn,getgenv().CachedBlockBtn,getgenv().CachedCharges,getgenv().CachedCooldown = nil,nil,nil,nil
end
end
getgenv().RefreshUI()
if getgenv().CachedGui then
getgenv().CachedGui.ChildAdded:Connect(function(child)
if child.Name == "MainUI" then
task.delay(0.02,getgenv().RefreshUI)
end
end)
end
getgenv().LocalPlayer.CharacterAdded:Connect(function()
task.delay(0.5,getgenv().RefreshUI)
end)
getgenv().getClosestKiller = function()
local myChar = getgenv().LocalPlayer.Character
local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
if not myRoot then return nil end
local closest,closestDist = nil,math.huge
local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
if killersFolder then
for _,name in ipairs(getgenv().KnownKillers) do
local killer = killersFolder:FindFirstChild(name)
if killer and killer:FindFirstChild("HumanoidRootPart") then
local root = killer.HumanoidRootPart
local dist = (root.Position - myRoot.Position).Magnitude
if dist < closestDist and dist <= getgenv().punchRange then
closest = killer
closestDist = dist
end
end
end
end
return closest
end
getgenv().RunService.RenderStepped:Connect(function()
if not getgenv().autoPunchOn and not getgenv().aimbotPunchOn then return end
local myChar = getgenv().LocalPlayer.Character
local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
local gui = getgenv().CachedGui:FindFirstChild("MainUI")
local punchBtn = gui and gui:FindFirstChild("AbilityContainer") and gui.AbilityContainer:FindFirstChild("Punch")
local charges = punchBtn and punchBtn:FindFirstChild("Charges")
if punchBtn and charges and myRoot then
local chargeCount = tonumber(charges.Text) or 0
if chargeCount >= 1 then
local killer = getgenv().getClosestKiller()
if killer and killer:FindFirstChild("HumanoidRootPart") then
if getgenv().aimbotPunchOn then
local currentTime = tick()
if currentTime - getgenv().lastAimbotTime >= getgenv().aimbotDelay then
local killerRoot = killer.HumanoidRootPart
local camera = workspace.CurrentCamera
camera.CFrame = CFrame.new(camera.CFrame.Position,killerRoot.Position)
getgenv().fireRemotePunch()
getgenv().lastAimbotTime = currentTime
end
elseif getgenv().autoPunchOn then
getgenv().fireRemotePunch()
end
end
end
end
end)
getgenv().punchAnimIds = {
"108911997126897","82137285150006","129843313690921",
"140703210927645","136007065400978","86096387000557",
"87259391926321","86709774283672","108807732150251",
"138040001965654"
}
getgenv().killerNames = {"c00lkidd","Jason","JohnDoe","1x1x1x1","Noli","Slasher"}
getgenv().autoFallPunchOn = false
getgenv().autoDashEnabled = false
getgenv().DASH_SPEED = 100
getgenv().MIN_TARGET_MAXHP = 300
if not getgenv().originalNamecall then
getgenv().HookRules = {}
getgenv().originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
local method = getnamecallmethod()
local args = {...}
if method == "FireServer" then
for _, rule in ipairs(getgenv().HookRules) do
if (not rule.remoteName or self.Name == rule.remoteName) then
if not rule.blockedFirstArg or args[1] == rule.blockedFirstArg then
if rule.block then
return
end
end
end
end
end
return getgenv().originalNamecall(self, ...)
end)
end
getgenv().activateRemoteHook = function(remoteName, blockedFirstArg)
for _, rule in ipairs(getgenv().HookRules) do
if rule.remoteName == remoteName and rule.blockedFirstArg == blockedFirstArg then
return
end
end
table.insert(getgenv().HookRules, {
remoteName = remoteName,
blockedFirstArg = blockedFirstArg,
block = true
})
end
getgenv().deactivateRemoteHook = function(remoteName, blockedFirstArg)
for i, rule in ipairs(getgenv().HookRules) do
if rule.remoteName == remoteName and rule.blockedFirstArg == blockedFirstArg then
table.remove(getgenv().HookRules, i)
break
end
end
end
getgenv().EnableC00lkidd = function()
getgenv().activateRemoteHook("RemoteEvent", game.Players.LocalPlayer.Name .. "C00lkiddCollision")
end
getgenv().DisableC00lkidd = function()
getgenv().deactivateRemoteHook("RemoteEvent", game.Players.LocalPlayer.Name .. "C00lkiddCollision")
end
local globalEnv = getgenv()
globalEnv.walkSpeed = 100
globalEnv.toggle = false
globalEnv.connection = nil
function globalEnv.getCharacter()
return globalEnv.LocalPlayer.Character or globalEnv.LocalPlayer.CharacterAdded:Wait()
end
function globalEnv.onHeartbeat()
local player = globalEnv.LocalPlayer
local character = globalEnv.getCharacter()
if character.Name ~= "c00lkidd" then return end
local char = globalEnv.getCharacter()
local rootPart = char:FindFirstChild("HumanoidRootPart")
local humanoid = char:FindFirstChildOfClass("Humanoid")
local lv = rootPart and rootPart:FindFirstChild("LinearVelocity")
if not rootPart or not humanoid or not lv then return end
if lv then
lv.VectorVelocity = Vector3.new(math.huge, math.huge, math.huge)
lv.Enabled = false
end
local stopMovement = false
local validValues = {
Timeout = true,
Collide = true,
Hit = true
}
if not stopMovement then
local lookVector = workspace.CurrentCamera.CFrame.LookVector
local moveDir = Vector3.new(lookVector.X, 0, lookVector.Z)
if moveDir.Magnitude > 0 then
moveDir = moveDir.Unit
rootPart.Velocity = Vector3.new(moveDir.X * globalEnv.walkSpeed, rootPart.Velocity.Y, moveDir.Z * globalEnv.walkSpeed)
rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + moveDir)
end
end
end
local function validTarget(player)
if not player or player == getgenv().LocalPlayer then return false end
local char = player.Character
if not char then return false end
local humanoid = char:FindFirstChildOfClass("Humanoid")
local hrp = char:FindFirstChild("HumanoidRootPart")
if not humanoid or not hrp then return false end
if humanoid.Health <= 0 then return false end
if humanoid.MaxHealth < getgenv().MIN_TARGET_MAXHP then return false end
local myChar = getgenv().LocalPlayer.Character
if not myChar then return false end
local myHrp = myChar:FindFirstChild("HumanoidRootPart")
if not myHrp then return false end
if (hrp.Position - myHrp.Position).Magnitude > getgenv().punchRange then return false end
return true
end
local function findClosestValidTarget()
local best, bestDist = nil, math.huge
local myChar = getgenv().LocalPlayer.Character
if not myChar then return nil end
local myHrp = myChar:FindFirstChild("HumanoidRootPart")
if not myHrp then return nil end
for _, p in pairs(getgenv().Players:GetPlayers()) do
if validTarget(p) then
local targetHrp = p.Character:FindFirstChild("HumanoidRootPart")
local d = (targetHrp.Position - myHrp.Position).Magnitude
if d < bestDist then
bestDist = d
best = p
end
end
end
return best
end
local function isPunchAnimationPlaying()
local char = getgenv().LocalPlayer.Character
if not char then return false end
local humanoid = char:FindFirstChildOfClass("Humanoid")
if not humanoid then return false end
local trackList = humanoid:GetPlayingAnimationTracks()
for _, track in ipairs(trackList) do
local animId = tostring(track.Animation.AnimationId)
for _, id in ipairs(getgenv().punchAnimIds) do
if animId == "rbxassetid://" .. id then
return true
end
end
end
return false
end
getgenv().RunService.Heartbeat:Connect(function()
local myChar = getgenv().LocalPlayer.Character
local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
local gui = getgenv().LocalPlayer.PlayerGui:FindFirstChild("MainUI")
local punchBtn = gui and gui:FindFirstChild("AbilityContainer") and gui.AbilityContainer:FindFirstChild("Punch")
local charges = punchBtn and punchBtn:FindFirstChild("Charges")
if getgenv().autoFallPunchOn and punchBtn and charges and myRoot then
local chargeCount = tonumber(charges.Text) or 0
if chargeCount >= 1 then
local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
if killersFolder then
for _, name in ipairs(getgenv().killerNames) do
local killer = killersFolder:FindFirstChild(name)
if killer and killer:FindFirstChild("HumanoidRootPart") then
local root = killer.HumanoidRootPart
if (root.Position - myRoot.Position).Magnitude <= getgenv().punchRange then
myRoot.CFrame = myRoot.CFrame + Vector3.new(0, 8, 0)
getgenv().fireRemotePunch()
task.wait(0.01)
end
end
end
end
end
end
if not getgenv().autoDashEnabled then return end
local char = getgenv().LocalPlayer.Character
if not char or char.Name ~= "Guest1337" then return end
if not isPunchAnimationPlaying() then return end
local rootPart = char:FindFirstChild("HumanoidRootPart")
if not rootPart then return end
local target = findClosestValidTarget()
if target and target.Character then
local tgtHrp = target.Character:FindFirstChild("HumanoidRootPart")
if tgtHrp then
local dir = (tgtHrp.Position - rootPart.Position)
local horiz = Vector3.new(dir.X, 0, dir.Z)
local dist = horiz.Magnitude
if dist > 3 then
local unit = horiz.Unit
local vel = unit * getgenv().DASH_SPEED
local currentY = rootPart.AssemblyLinearVelocity.Y
rootPart.AssemblyLinearVelocity = Vector3.new(vel.X, currentY, vel.Z)
end
end
end
end)
local MainBlockTab = Tabs.Bro:AddRightTabbox()
local MainGroup = MainBlockTab:AddTab("Guest Block")
local CombatGroup = MainBlockTab:AddTab("Punch")
local AdvancedGroup = MainBlockTab:AddTab("Misc")
MainGroup:AddToggle("AutoBlockToggle",{
Text = "Auto Block",
Default = false,
Tooltip = "Enable/Disable Auto Block",
Callback = function(Value)
getgenv().AutoBlockEnabled = Value
end,
})
MainGroup:AddToggle("InnerCircleToggle",{
Text = "Show Inner Circle (Block Range)",
Default = false,
Tooltip = "Display the killer's inner circle block detection range",
Callback = function(Value)
getgenv().InnerCircleVisible = Value
getgenv().RefreshKillerCircles()
end,
})
MainGroup:AddToggle("OuterCircleToggle",{
Text = "Show Outer Circle (Punch Range)",
Default = false,
Tooltip = "Display the killer's outer circle punch detection range",
Callback = function(Value)
getgenv().OuterCircleVisible = Value
getgenv().RefreshKillerCircles()
end,
})
MainGroup:AddDropdown("VisualizationModeDropdown",{
Values = {"Compass", "Fixed", "Box", "Sphere"},
Default = 1,
Multi = false,
Text = "Visualization Mode",
Tooltip = "Select visualization display mode\nCompass: Range faces player\nFixed: Range follows killer's facing\nBox: Rectangle detection range\nSphere: Spherical detection range",
Callback = function(Value)
getgenv().UpdateVisualizationMode(Value)
end
})
MainGroup:AddToggle("FacingCheck",{
Text = "Player Facing Check",
Default = false,
Tooltip = "Only block when facing the killer",
Callback = function(Value)
getgenv().FacingCheckEnabled = Value
end,
})
MainGroup:AddToggle("KillerFacingCheck",{
Text = "Killer Facing Check",
Default = false,
Tooltip = "Only block when the killer is facing the player",
Callback = function(Value)
getgenv().KillerFacingCheckEnabled = Value
end,
})
MainGroup:AddToggle("WallCheck",{
Text = "Wall Check",
Default = false,
Tooltip = "Check for wall obstructions",
Callback = function(Value)
getgenv().wallCheckEnabled = Value
end,
})
MainGroup:AddSlider("SenseRange",{
Text = "Block Range",
Default = 18,
Min = 5,
Max = 50,
Rounding = 1,
Tooltip = "Block detection distance range",
Callback = function(Value)
getgenv().SenseRange = Value
getgenv().SenseRangeSq = Value * Value
end,
})
MainGroup:AddSlider("PlayerFacingAngle",{
Text = "Player Facing Angle",
Default = 90,
Min = 30,
Max = 180,
Rounding = 1,
Tooltip = "Player's facing angle check towards killer",
Callback = function(Value)
getgenv().PlayerFacingAngle = Value
end,
})
MainGroup:AddSlider("KillerFacingAngle",{
Text = "Killer Facing Angle",
Default = 90,
Min = 30,
Max = 180,
Rounding = 1,
Tooltip = "Killer's facing angle check towards player",
Callback = function(Value)
getgenv().KillerFacingAngle = Value
end,
})
MainGroup:AddDivider()
MainGroup:AddLabel("Box Mode Settings:")
MainGroup:AddSlider("BoxLength",{
Text = "Box Length",
Default = 15,
Min = 5,
Max = 50,
Rounding = 1,
Tooltip = "Box mode length (only for Box mode)",
Callback = function(Value)
getgenv().BoxLength = Value
end,
})
MainGroup:AddSlider("BoxWidth",{
Text = "Box Width",
Default = 6,
Min = 2,
Max = 30,
Rounding = 1,
Tooltip = "Box mode width (only for Box mode)",
Callback = function(Value)
getgenv().BoxWidth = Value
end,
})
MainGroup:AddSlider("BoxTransparency",{
Text = "Box Transparency",
Default = 0.7,
Min = 0,
Max = 1,
Rounding = 2,
Tooltip = "Box transparency (0=Opaque, 1=Transparent)",
Callback = function(Value)
getgenv().BoxTransparency = Value
getgenv().UpdateBoxColors()
end,
})
MainGroup:AddLabel("Box Safe Color (Player in Range):")
MainGroup:AddSlider("BoxSafeColorR",{
Text = "Red (R)",
Default = 0,
Min = 0,
Max = 255,
Rounding = 0,
Tooltip = "Box safe state red value",
Callback = function(Value)
local current = getgenv().BoxSafeColor
getgenv().BoxSafeColor = Color3.fromRGB(Value, current.G * 255, current.B * 255)
end,
})
MainGroup:AddSlider("BoxSafeColorG",{
Text = "Green (G)",
Default = 255,
Min = 0,
Max = 255,
Rounding = 0,
Tooltip = "Box safe state green value",
Callback = function(Value)
local current = getgenv().BoxSafeColor
getgenv().BoxSafeColor = Color3.fromRGB(current.R * 255, Value, current.B * 255)
end,
})
MainGroup:AddSlider("BoxSafeColorB",{
Text = "Blue (B)",
Default = 0,
Min = 0,
Max = 255,
Rounding = 0,
Tooltip = "Box safe state blue value",
Callback = function(Value)
local current = getgenv().BoxSafeColor
getgenv().BoxSafeColor = Color3.fromRGB(current.R * 255, current.G * 255, Value)
end,
})
MainGroup:AddLabel("Box Danger Color (Player not in Range):")
MainGroup:AddSlider("BoxDangerColorR",{
Text = "Red (R)",
Default = 255,
Min = 0,
Max = 255,
Rounding = 0,
Tooltip = "Box danger state red value",
Callback = function(Value)
local current = getgenv().BoxDangerColor
getgenv().BoxDangerColor = Color3.fromRGB(Value, current.G * 255, current.B * 255)
end,
})
MainGroup:AddSlider("BoxDangerColorG",{
Text = "Green (G)",
Default = 0,
Min = 0,
Max = 255,
Rounding = 0,
Tooltip = "Box danger state green value",
Callback = function(Value)
local current = getgenv().BoxDangerColor
getgenv().BoxDangerColor = Color3.fromRGB(current.R * 255, Value, current.B * 255)
end,
})
MainGroup:AddSlider("BoxDangerColorB",{
Text = "Blue (B)",
Default = 0,
Min = 0,
Max = 255,
Rounding = 0,
Tooltip = "Box danger state blue value",
Callback = function(Value)
local current = getgenv().BoxDangerColor
getgenv().BoxDangerColor = Color3.fromRGB(current.R * 255, current.G * 255, Value)
end,
})
CombatGroup:AddToggle("AutoPunch", {
Text = "Auto Punch",
Default = false,
Tooltip = "Automatically detect enemies within range and punch",
Callback = function(Value)
getgenv().autoPunchOn = Value
end
})
CombatGroup:AddToggle("AimbotPunch", {
Text = "Aimbot Punch",
Default = false,
Tooltip = "Automatically aim at target for punching",
Callback = function(Value)
getgenv().aimbotPunchOn = Value
end
})
CombatGroup:AddSlider("PunchRange", {
Text = "Punch Range",
Default = 50,
Min = 10,
Max = 100,
Rounding = 1,
Tooltip = "Punch detection distance",
Callback = function(Value)
getgenv().punchRange = Value
end
})
CombatGroup:AddSlider("AimbotDelay", {
Text = "Aimbot Punch Delay",
Default = 0.1,
Min = 0.01,
Max = 1,
Rounding = 2,
Tooltip = "Delay time between aimbot punches (seconds)",
Callback = function(Value)
getgenv().aimbotDelay = Value
end
})
CombatGroup:AddToggle("AutoFallPunch", {
Text = "Air Combo Punch",
Default = false,
Tooltip = "Automatically trigger punches while in the air",
Callback = function(Value)
getgenv().autoFallPunchOn = Value
end
})
AdvancedGroup:AddToggle("HDPullToggle", {
Text = "Block Pull (HDPull)",
Default = false,
Tooltip = "Automatically pull closer to enemy when blocking",
Callback = function(Value)
getgenv().HDPullEnabled = Value
end
})
AdvancedGroup:AddSlider("HDSpeed", {
Text = "Pull Speed",
Default = 12,
Min = 5,
Max = 50,
Rounding = 1,
Tooltip = "Movement speed towards enemy when blocking",
Callback = function(Value)
getgenv().HDSpeed = Value
end
})
AdvancedGroup:AddToggle("AutoDash", {
Text = "Auto Dash",
Default = false,
Tooltip = "Automatically dash towards enemy when punching",
Callback = function(Value)
getgenv().autoDashEnabled = Value
end
})
AdvancedGroup:AddSlider("DashSpeed", {
Text = "Dash Speed",
Default = 100,
Min = 50,
Max = 500,
Rounding = 1,
Tooltip = "Speed for auto dash",
Callback = function(Value)
getgenv().DASH_SPEED = Value
end
})
local LOL = Tabs.Bro:AddLeftTabbox()
local SM = LOL:AddTab("HitBox trace ")
local HitboxTrackingEnabled = false
local HeartbeatConnection = nil
local MaxDistance = 120
local FilterSurvivors = false
local FilterKillers = false
local WallCheckEnabled = false
local Killers = {
["Slasher"] = true, ["1x1x1x1"] = true, ["c00lkidd"] = true,
["Noli"] = true, ["JohnDoe"] = true, ["Guest 666"] = true,
["Sixer"] = true
}
local Survivors = {
["Noob"] = true, ["Guest1337"] = true, ["Elliot"] = true,
["Shedletsky"] = true, ["TwoTime"] = true, ["007n7"] = true,
["Chance"] = true, ["Builderman"] = true, ["Taph"] = true,
["Dusekkar"] = true, ["Veeronica"] = true
}
local AttackAnimations = {
'rbxassetid://131430497821198',
'rbxassetid://83829782357897',
'rbxassetid://126830014841198',
'rbxassetid://126355327951215',
'rbxassetid://121086746534252',
'rbxassetid://105458270463374',
'rbxassetid://127172483138092',
'rbxassetid://18885919947',
'rbxassetid://18885909645',
'rbxassetid://87259391926321',
'rbxassetid://106014898528300',
'rbxassetid://86545133269813',
'rbxassetid://89448354637442',
'rbxassetid://90499469533503',
'rbxassetid://116618003477002',
'rbxassetid://106086955212611',
'rbxassetid://107640065977686',
'rbxassetid://77124578197357',
'rbxassetid://101771617803133',
'rbxassetid://134958187822107',
'rbxassetid://111313169447787',
'rbxassetid://71685573690338',
'rbxassetid://129843313690921',
'rbxassetid://97623143664485',
'rbxassetid://136007065400978',
'rbxassetid://86096387000557',
'rbxassetid://108807732150251',
'rbxassetid://138040001965654',
'rbxassetid://73502073176819',
'rbxassetid://86709774283672',
'rbxassetid://140703210927645',
'rbxassetid://96173857867228',
'rbxassetid://121255898612475',
'rbxassetid://98031287364865',
'rbxassetid://119462383658044',
'rbxassetid://77448521277146',
'rbxassetid://103741352379819',
'rbxassetid://131696603025265',
'rbxassetid://122503338277352',
'rbxassetid://97648548303678',
'rbxassetid://94162446513587',
'rbxassetid://84426150435898',
'rbxassetid://93069721274110',
'rbxassetid://114620047310688',
'rbxassetid://97433060861952',
'rbxassetid://82183356141401',
'rbxassetid://100592913030351',
'rbxassetid://121293883585738',
'rbxassetid://70447634862911',
'rbxassetid://92173139187970',
'rbxassetid://106847695270773',
'rbxassetid://125403313786645',
'rbxassetid://81639435858902',
'rbxassetid://137314737492715',
'rbxassetid://120112897026015',
'rbxassetid://82113744478546',
'rbxassetid://118298475669935',
'rbxassetid://126681776859538',
'rbxassetid://129976080405072',
'rbxassetid://109667959938617',
'rbxassetid://74707328554358',
'rbxassetid://133336594357903',
'rbxassetid://86204001129974',
'rbxassetid://124243639579224',
'rbxassetid://70371667919898',
'rbxassetid://131543461321709',
'rbxassetid://136323728355613',
'rbxassetid://109230267448394',
'rbxassetid://139835501033932',
'rbxassetid://106538427162796',
'rbxassetid://110400453990786',
'rbxassetid://83685305553364',
'rbxassetid://126171487400618',
'rbxassetid://122709416391891',
'rbxassetid://87989533095285',
'rbxassetid://119326397274934',
'rbxassetid://140365014326125',
'rbxassetid://139309647473555',
'rbxassetid://133363345661032',
'rbxassetid://128414736976503',
'rbxassetid://121808371053483',
'rbxassetid://88451353906104',
'rbxassetid://81299297965542',
'rbxassetid://99829427721752',
'rbxassetid://126896426760253',
'rbxassetid://77375846492436',
'rbxassetid://94634594529334',
'rbxassetid://101031946095087'
}
SM:AddSlider("DistanceSlider", {
Text = "Trace range",
Default = 120,
Min = 1,
Max = 300,
Rounding = 0,
Callback = function(value)
MaxDistance = value
end
})
SM:AddCheckbox("FilterSurvivorsToggle", {
Text = "Filter [do not track] survivors",
Default = false,
Callback = function(state)
FilterSurvivors = state
end
})
SM:AddCheckbox("FilterKillersToggle", {
Text = "Filter [Do Not Track] Killer",
Default = false,
Callback = function(state)
FilterKillers = state
end
})
SM:AddCheckbox("WallCheckToggle", {
Text = "Wallcheck",
Default = false,
Callback = function(state)
WallCheckEnabled = state
end
})
SM:AddCheckbox("HitboxTrackingToggle", {
Text = "Hitbox tracking ",
Default = false,
Callback = function(state)
HitboxTrackingEnabled = state
if HeartbeatConnection then
HeartbeatConnection:Disconnect()
HeartbeatConnection = nil
end
if not state then return end
repeat task.wait() until game:IsLoaded();
local Players = game:GetService('Players');
local Player = Players.LocalPlayer;
local Character = Player.Character or Player.CharacterAdded:Wait();
local Humanoid = Character:WaitForChild("Humanoid");
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
Player.CharacterAdded:Connect(function(NewCharacter)
Character = NewCharacter;
Humanoid = Character:WaitForChild("Humanoid");
HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
end);
local RNG = Random.new();
local RaycastParams = RaycastParams.new()
RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
RaycastParams.IgnoreWater = true
local function isTargetVisible(targetCharacter)
if not WallCheckEnabled or not targetCharacter or not targetCharacter:FindFirstChild("HumanoidRootPart") then
return true
end
local targetHRP = targetCharacter.HumanoidRootPart
local origin = HumanoidRootPart.Position
local direction = (targetHRP.Position - origin).Unit
local distance = (targetHRP.Position - origin).Magnitude
local filterList = {Character, targetCharacter}
RaycastParams.FilterDescendantsInstances = filterList
local rayResult = workspace:Raycast(origin, direction * distance, RaycastParams)
if not rayResult then
return true
end
local hitInstance = rayResult.Instance
if hitInstance and hitInstance:IsDescendantOf(targetCharacter) then
return true
end
return false
end
local function getCharacterRole(character)
local modelName = character.Name
if Killers[modelName] then
return "Killer"
elseif Survivors[modelName] then
return "Survivor"
end
return "Unknown"
end
HeartbeatConnection = game:GetService('RunService').Heartbeat:Connect(function()
if not HitboxTrackingEnabled or not HumanoidRootPart then
return;
end
local Playing = false;
for _,v in Humanoid:GetPlayingAnimationTracks() do
if table.find(AttackAnimations, v.Animation.AnimationId) and (v.TimePosition / v.Length < 0.75) then
Playing = true;
end
end
if not Playing then
return;
end
local PlayerRole = getCharacterRole(Character)
local OppositeTable = nil
if PlayerRole == "Killer" then
OppositeTable = Survivors
elseif PlayerRole == "Survivor" then
OppositeTable = Killers
end
local Target = nil
local CurrentNearestDist = MaxDistance
local OppTarget = nil
local OppNearestDist = MaxDistance
local function loopForOpp(t)
for _,v in pairs(t) do
if v == Character or not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid") then
continue
end
if WallCheckEnabled and not isTargetVisible(v) then
continue
end
local modelName = v.Name
if OppositeTable and OppositeTable[modelName] then
local Dist = (v.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
if Dist < OppNearestDist then
OppNearestDist = Dist
OppTarget = v
end
end
end
end
if OppositeTable then
loopForOpp(workspace.Players:GetDescendants())
local npcsFolder = workspace.Map:FindFirstChild("NPCs", true)
if npcsFolder then
loopForOpp(npcsFolder:GetChildren())
end
end
local function loopAll(t)
for _,v in pairs(t) do
if v == Character or not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid") then
continue
end
if WallCheckEnabled and not isTargetVisible(v) then
continue
end
local characterRole = getCharacterRole(v)
if FilterSurvivors and characterRole == "Survivor" then
continue
end
if FilterKillers and characterRole == "Killer" then
continue
end
if PlayerRole == "Killer" and characterRole == "Killer" then
continue
end
if PlayerRole == "Survivor" and characterRole == "Survivor" then
continue
end
local Dist = (v.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
if Dist < CurrentNearestDist then
CurrentNearestDist = Dist
Target = v
end
end
end
local FinalTarget = nil
if OppTarget then
FinalTarget = OppTarget
else
loopAll(workspace.Players:GetDescendants())
local npcsFolder2 = workspace.Map:FindFirstChild("NPCs", true)
if npcsFolder2 then
loopAll(npcsFolder2:GetChildren())
end
FinalTarget = Target
end
if not FinalTarget then
return;
end
local OldVelocity = HumanoidRootPart.Velocity;
local NeededVelocity =
(FinalTarget.HumanoidRootPart.Position + Vector3.new(
RNG:NextNumber(-1.5, 1.5),
0,
RNG:NextNumber(-1.5, 1.5)
) + (FinalTarget.HumanoidRootPart.Velocity * (Player:GetNetworkPing() * 1.25))
- HumanoidRootPart.Position
) / (Player:GetNetworkPing() * 2);
HumanoidRootPart.Velocity = NeededVelocity;
game:GetService('RunService').RenderStepped:Wait();
HumanoidRootPart.Velocity = OldVelocity;
end);
end,
})
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MVP = Tabs.Sat:AddLeftGroupbox("Physical Strength Settings")
local StaminaSettings = {
MaxStamina = 100,
StaminaGain = 25,
StaminaLoss = 10,
SprintSpeed = 28,
InfiniteGain = 9999
}
local SettingToggles = {
MaxStamina = false,
StaminaGain = false,
StaminaLoss = false,
SprintSpeed = false
}
local SprintingModule = ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Character"):WaitForChild("Game"):WaitForChild("Sprinting")
local GetModule = function() return require(SprintingModule) end
task.spawn(function()
while true do
local m = GetModule()
for key, value in pairs(StaminaSettings) do
if SettingToggles[key] then
m[key] = value
end
end
task.wait(0.5)
end
end)
local bai = {Spr = false}
local connection
MVP:AddCheckbox('MyToggle', {
Text = 'Infinite physical force',
Default = false,
Tooltip = 'Infinite physical strength ',
Callback = function(state)
bai.Spr = state
local Sprinting = GetModule()
if state then
Sprinting.StaminaLoss = 0
Sprinting.StaminaGain = StaminaSettings.InfiniteGain
if connection then connection:Disconnect() end
connection = RunService.Heartbeat:Connect(function()
if not bai.Spr then return end
Sprinting.StaminaLoss = 0
Sprinting.StaminaGain = StaminaSettings.InfiniteGain
end)
else
Sprinting.StaminaLoss = 10
Sprinting.StaminaGain = 25
if connection then
connection:Disconnect()
connection = nil
end
end
end
})
MVP:AddCheckbox('MaxStaminaToggle', {
Text = 'Enable Strength Adjustment',
Default = false,
Callback = function(Value)
SettingToggles.MaxStamina = Value
end
})
MVP:AddCheckbox('StaminaGainToggle', {
Text = 'Enable strength recovery adjustment ',
Default = false,
Callback = function(Value)
SettingToggles.StaminaGain = Value
end
})
MVP:AddCheckbox('StaminaLossToggle', {
Text = 'Enable physical exertion adjustment ',
Default = false,
Callback = function(Value)
SettingToggles.StaminaLoss = Value
end
})
MVP:AddCheckbox('SprintSpeedToggle', {
Text = 'Enable running speed adjustment',
Default = false,
Callback = function(Value)
SettingToggles.SprintSpeed = Value
end
})
local MVP2 = Tabs.Sat:AddRightGroupbox("Debug Settings ")
MVP2:AddSlider('InfStaminaGainSlider', {
Text = 'Infinite physical recovery speed ',
Default = 9999,
Min = 0,
Max = 10000,
Rounding = 0,
Callback = function(Value)
StaminaSettings.InfiniteGain = Value
if bai.Spr then
local Sprinting = GetModule()
Sprinting.StaminaGain = Value
end
end
})
MVP2:AddSlider('MySlider1', {
Text = 'Maximum physical strength value ',
Default = 100,
Min = 0,
Max = 9999,
Rounding = 0,
Callback = function(Value)
StaminaSettings.MaxStamina = Value
if SettingToggles.MaxStamina then
local Sprinting = GetModule()
Sprinting.MaxStamina = Value
end
end
})
MVP2:AddSlider('MySlider2', {
Text = 'Speed of physical recovery ',
Default = 25,
Min = 0,
Max = 500,
Rounding = 0,
Callback = function(Value)
StaminaSettings.StaminaGain = Value
if SettingToggles.StaminaGain and not bai.Spr then
local Sprinting = GetModule()
Sprinting.StaminaGain = Value
end
end
})
MVP2:AddSlider('MySlider3', {
Text = 'Physical exertion speed ',
Default = 10,
Min = 0,
Max = 800,
Rounding = 0,
Callback = function(Value)
StaminaSettings.StaminaLoss = Value
if SettingToggles.StaminaLoss and not bai.Spr then
local Sprinting = GetModule()
Sprinting.StaminaLoss = Value
end
end
})
MVP2:AddSlider('MySlider4', {
Text = 'Running speed ',
Default = 28,
Min = 0,
Max = 200,
Rounding = 0,
Callback = function(Value)
StaminaSettings.SprintSpeed = Value
if SettingToggles.SprintSpeed then
local Sprinting = GetModule()
Sprinting.SprintSpeed = Value
end
end
})
local RunService = game:GetService("RunService")
local function getDirection(currentRow, currentCol, otherRow, otherCol)
if otherRow < currentRow then return "up" end
if otherRow > currentRow then return "down" end
if otherCol < currentCol then return "left" end
if otherCol > currentCol then return "right" end
end
local function getConnections(prev, curr, nextnode)
local connections = {}
if prev and curr then
local dir = getDirection(curr.row, curr.col, prev.row, prev.col)
if dir == "up" then dir = "down"
elseif dir == "down" then dir = "up"
elseif dir == "left" then dir = "right"
elseif dir == "right" then dir = "left" end
if dir then connections[dir] = true end
end
if nextnode and curr then
local dir = getDirection(curr.row, curr.col, nextnode.row, nextnode.col)
if dir then connections[dir] = true end
end
return connections
end
local function isNeighbourLocal(r1, c1, r2, c2)
if r2 == r1 - 1 and c2 == c1 then return "up" end
if r2 == r1 + 1 and c2 == c1 then return "down" end
if r2 == r1 and c2 == c1 - 1 then return "left" end
if r2 == r1 and c2 == c1 + 1 then return "right" end
return false
end
local function coordKey(node)
return `{node.row}-{node.col}`
end
local function orderPathFromEndpoints(path, endpoints)
if not path or #path == 0 then return path end
local startEndpoint
for _, ep in endpoints or {} do
for _, n in path do
if n.row == ep.row and n.col == ep.col then
startEndpoint = { row = ep.row, col = ep.col }
break
end
end
if startEndpoint then break end
end
if not startEndpoint then
local inPath = {}
for _, n in path do inPath[coordKey(n)] = n end
for _, n in path do
local neighbours = 0
local dirs = { { n.row - 1, n.col }, { n.row + 1, n.col }, { n.row, n.col - 1 }, { n.row, n.col + 1 } }
for _, dir in dirs do
local r, c = dir[1], dir[2]
if inPath[`{r}-{c}`] then neighbours += 1 end
end
if neighbours == 1 then
startEndpoint = { row = n.row, col = n.col }
break
end
end
end
if not startEndpoint then
startEndpoint = { row = path[1].row, col = path[1].col }
end
local remaining = {}
for _, n in path do remaining[coordKey(n)] = { row = n.row, col = n.col } end
local ordered = {}
local current = { row = startEndpoint.row, col = startEndpoint.col }
table.insert(ordered, table.clone(current))
remaining[coordKey(current)] = nil
while true do
local _size = 0
for _ in remaining do _size += 1 end
if not (_size > 0) then break end
local foundNext = false
for key, node in remaining do
local _value = isNeighbourLocal(current.row, current.col, node.row, node.col)
if _value then
table.insert(ordered, table.clone(node))
remaining[key] = nil
current = node
foundNext = true
break
end
end
if not foundNext then return path end
end
return ordered
end
local HintSystem = {}
do
function HintSystem:DrawSolutionOneByOne(puzzle, delayTime)
delayTime = delayTime or 0.05
if not puzzle or not puzzle.Solution then return end
local totalPaths = #puzzle.Solution
local indices = {}
for i = 1, totalPaths do table.insert(indices, i) end
for i = totalPaths, 2, -1 do
local j = math.random(i)
indices[i], indices[j] = indices[j], indices[i]
end
for _, colorIndex in indices do
local path = puzzle.Solution[colorIndex]
local endpoints = puzzle.targetPairs[colorIndex]
local orderedPath = orderPathFromEndpoints(path, endpoints)
puzzle.paths[colorIndex] = {}
puzzle.gridConnections = puzzle.gridConnections or {}
for i = 1, #orderedPath do
local node = orderedPath[i]
table.insert(puzzle.paths[colorIndex], { row = node.row, col = node.col })
local prev = orderedPath[i - 1]
local nextNode = orderedPath[i + 1]
local conn = getConnections(prev, node, nextNode)
puzzle.gridConnections[`{node.row}-{node.col}`] = conn
if i % 5 == 0 or i == #orderedPath then
puzzle:updateGui()
task.wait(delayTime)
end
end
puzzle:checkForWin()
task.wait(delayTime * 0.5)
end
puzzle:updateGui()
puzzle:checkForWin()
end
end
local Generator = Tabs.zdx:AddLeftGroupbox("Automatic repair/acting (event) ")
Generator:AddSlider("RepairSpeed", {
Text = "Repair speed (s)",
Default = 4,
Min = 1,
Max = 5,
Rounding = 1,
Compact = false,
Callback = function(v)
_G.CustomSpeed = v
end
})
Generator:AddToggle("AutoGenerator",{
Text = "Automatic machine repair",
Default = false,
Callback = function(v)
_G.AutoGen = v
task.spawn(function()
while _G.AutoGen do
if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PuzzleUI") then
local delayTime = _G.CustomSpeed or 4
wait(delayTime)
for _,v in ipairs(workspace["Map"]["Ingame"]["Map"]:GetChildren()) do
if v.Name == "Generator" then
v["Remotes"]["RE"]:FireServer()
end
end
end
wait()
end
end)
end
})
local LeftGroupBox = Tabs.zdx:AddLeftGroupbox("Automatic machine repair (connection) ")
local AutoConnectEnabled = false
local ConnectionSpeed = 0.05
LeftGroupBox:AddCheckbox("AutoConnectToggle", {
Text = "Enable Auto Connect ",
Default = false,
Callback = function(Value)
AutoConnectEnabled = Value
print("Auto Connect:", Value)
end,
})
LeftGroupBox:AddSlider("ConnectionSpeed", {
Text = "Connection Speed ",
Default = 0.05,
Min = 0.001,
Max = 0.2,
Rounding = 3,
Compact = false,
Callback = function(Value)
ConnectionSpeed = Value
print("Connection speed:", Value)
end,
Tooltip = "The smaller the value, the faster ",
})
local _result = ReplicatedStorage:WaitForChild("Modules"):FindFirstChild("Misc")
if _result then
_result = _result:FindFirstChild("FlowGameManager")
if _result then
_result = _result:FindFirstChild("FlowGame")
end
end
local bb = _result
if bb then
local FlowGameModule = require(bb)
local old = FlowGameModule.new
FlowGameModule.new = function(...)
local args = { ... }
local output = { old(unpack(args)) }
local puzzle = output[1]
task.spawn(function()
if puzzle and puzzle.Solution and AutoConnectEnabled then
local startTime = tick()
while AutoConnectEnabled and tick() - startTime < 3 do
if Players.LocalPlayer.PlayerGui:FindFirstChild("PuzzleUI") then
HintSystem:DrawSolutionOneByOne(puzzle, ConnectionSpeed)
break
end
task.wait(0.3)
end
end
end)
return puzzle
end
end
local KillerSurvival = Tabs.zdx:AddRightGroupbox('Transport repair [danger] ')
KillerSurvival:AddButton({
Text = 'To generator',
Func = function()
local player = game.Players.LocalPlayer
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local generators = workspace.Map.Ingame.Map:GetChildren()
for _, generator in ipairs(generators) do
if generator.Name == "Generator" and
generator:FindFirstChild("Progress") and
generator.Progress.Value < 100 then
local generatorPart = generator:FindFirstChild("Main") or
generator:FindFirstChild("Model") or
generator:FindFirstChild("Base")
if generatorPart then
character.HumanoidRootPart.CFrame = generatorPart.CFrame + Vector3.new(0, 3, 0)
return
end
end
end
warn("No serviceable generator found ")
end
})
local ZZ = Tabs.zdx:AddRightGroupbox('Switch servers')
ZZ:AddButton({
Text = "Switching server",
Func = function()
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local requestFunc = http_request or syn.request or request
if not requestFunc then return end
local url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
local response = requestFunc({Url = url, Method = "GET"})
if response.StatusCode == 200 then
local data = HttpService:JSONDecode(response.Body)
if data and data.data and #data.data > 0 then
TeleportService:TeleportToPlaceInstance(game.PlaceId, data.data[math.random(1, #data.data)].id, Players.LocalPlayer)
end
end
end
})
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local MapFolder = Workspace:WaitForChild("Map"):WaitForChild("Ingame")
local Settings = {
Advanced = { Enabled = false, OutlineOnly = true, ShowNametag = false, Color = Color3.fromRGB(0, 255, 255) }
}
local Highlights = {}
local Nametags = {}
local AdvancedNames = {"BuildermanDispenser","BuildermanSentry","HumanoidRootProjectile","Swords","shockwave","Voidstar"}
local function CreateNametag(adornee, text, color)
if Nametags[adornee] then Nametags[adornee]:Destroy() end
local billboard = Instance.new("BillboardGui")
billboard.Adornee = adornee
billboard.Size = UDim2.new(0, 200, 0, 50)
billboard.StudsOffset = Vector3.new(0, 3, 0)
billboard.AlwaysOnTop = true
billboard.Enabled = true
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = text
textLabel.TextColor3 = color
textLabel.TextStrokeTransparency = 0
textLabel.TextStrokeColor3 = Color3.new(0,0,0)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 6
textLabel.Parent = billboard
billboard.Parent = adornee
Nametags[adornee] = textLabel
end
local function AddHighlight(Obj, Config)
if Highlights[Obj] then Highlights[Obj]:Destroy() end
local hl = Instance.new("Highlight")
hl.Adornee = Obj
hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
hl.Enabled = Config.Enabled
hl.OutlineColor = Config.Color
hl.FillColor = Config.Color
hl.OutlineTransparency = 0
local alwaysFill = table.find({"BuildermanDispenser","BuildermanSentry","PizzaDeliveryRig","HumanoidRootProjectile","Swords","shockwave","Voidstar","Shadow"}, Obj.Name)
hl.FillTransparency = Config.OutlineOnly and 1 or (alwaysFill and 0.65 or 1)
hl.Parent = Obj
Highlights[Obj] = hl
Obj.AncestryChanged:Connect(function(_, parent)
if not parent then
if Highlights[Obj] then Highlights[Obj]:Destroy() Highlights[Obj] = nil end
if Nametags[Obj] then Nametags[Obj].Parent:Destroy() Nametags[Obj] = nil end
end
end)
end
local function ApplyToTarget(target, Config)
if not target or not target.Parent then return end
AddHighlight(target, Config)
end
local function HandleAdvanced(obj)
if table.find(AdvancedNames, obj.Name) or (obj.Name == "Shadow" and obj.Parent and obj.Parent.Name == "Shadows") then
ApplyToTarget(obj, Settings.Advanced)
end
end
for _, v in ipairs(MapFolder:GetDescendants()) do HandleAdvanced(v) end
MapFolder.DescendantAdded:Connect(HandleAdvanced)
task.spawn(function()
while task.wait(0.3) do
for obj, hl in pairs(Highlights) do
if not hl or not hl.Parent then continue end
local config = Settings.Advanced
hl.Enabled = config.Enabled
hl.OutlineColor = config.Color
hl.FillColor = config.Color
hl.OutlineTransparency = 0
hl.FillTransparency = config.OutlineOnly and 1 or 0.65
if config.ShowNametag then
local baseName = obj.Name
local nameText = baseName
if Nametags[obj] then
Nametags[obj].Text = nameText
Nametags[obj].TextColor3 = config.Color
else
CreateNametag(obj, nameText, config.Color)
end
else
if Nametags[obj] then
Nametags[obj].Parent:Destroy()
Nametags[obj] = nil
end
end
end
end
end)
local AdvancedGroup = Tabs.Esp:AddRightGroupbox("Skills Esp", "boxes")
AdvancedGroup:AddCheckbox("AdvancedESP", {
Text = "ESP Skill",
Default = false,
Callback = function(Value)
Settings.Advanced.Enabled = Value
end,
})
AdvancedGroup:AddCheckbox("AdvancedOutline", {
Text = "Contour",
Default = true,
Callback = function(Value)
Settings.Advanced.OutlineOnly = Value
end,
})
AdvancedGroup:AddCheckbox("AdvancedNametag", {
Text = "Display name",
Default = false,
Callback = function(Value)
Settings.Advanced.ShowNametag = Value
end,
})
AdvancedGroup:AddLabel("Advanced Color"):AddColorPicker("AdvancedColor", {
Default = Color3.fromRGB(0, 255, 255),
Title = "Color",
Transparency = 0,
Callback = function(Value)
Settings.Advanced.Color = Value
end,
})
local PlayerESPBox = Tabs.Esp:AddLeftGroupbox("Player ESP", "users")
PlayerESPBox:AddCheckbox("KillerESP", {
Text = "Killer ESP",
Default = false,
Callback = function(value)
ESPSettings.killerESP = value
end,
}):AddColorPicker("KillerColor", {
Default = ESPSettings.killerColor,
Title = "Killer Color. ",
Callback = function(value)
ESPSettings.killerColor = value
end,
})
PlayerESPBox:AddCheckbox("KillerSkinESP", {
Text = "Show killer skin name ",
Default = false,
Tooltip = "Display skin name after killer name",
Callback = function(value)
ESPSettings.killerSkinESP = value
UpdateAllPlayerESPText()
end,
})
PlayerESPBox:AddSlider("KillerFillTransparency", {
Text = "Killer Fill Transparency ",
Default = 0.7,
Min = 0,
Max = 1,
Rounding = 2,
Compact = true,
Callback = function(value)
ESPSettings.killerFillTransparency = value
UpdateAllPlayerESPText()
end,
})
PlayerESPBox:AddSlider("KillerOutlineTransparency", {
Text = "Killer profile transparency ",
Default = 0.3,
Min = 0,
Max = 1,
Rounding = 2,
Compact = true,
Callback = function(value)
ESPSettings.killerOutlineTransparency = value
UpdateAllPlayerESPText()
end,
})
PlayerESPBox:AddDivider()
PlayerESPBox:AddCheckbox("SurvivorESP", {
Text = "Survivor esp",
Default = false,
Callback = function(value)
ESPSettings.playerESP = value
end,
}):AddColorPicker("SurvivorColor", {
Default = ESPSettings.survivorColor,
Title = "Survivor color, ",
Callback = function(value)
ESPSettings.survivorColor = value
end,
})
PlayerESPBox:AddCheckbox("SurvivorSkinESP", {
Text = "Display survivor skin name ",
Default = false,
Tooltip ="Display skin name after survivor name",
Callback = function(value)
ESPSettings.survivorSkinESP = value
UpdateAllPlayerESPText()
end,
})
PlayerESPBox:AddSlider("SurvivorFillTransparency", {
Text = "Survivor Fill Transparency ",
Default = 0.7,
Min = 0,
Max = 1,
Rounding = 2,
Compact = true,
Callback = function(value)
ESPSettings.survivorFillTransparency = value
UpdateAllPlayerESPText()
end,
})
PlayerESPBox:AddSlider("SurvivorOutlineTransparency", {
Text = "Survivor profile transparency ",
Default = 0.3,
Min = 0,
Max = 1,
Rounding = 2,
Compact = true,
Callback = function(value)
ESPSettings.survivorOutlineTransparency = value
UpdateAllPlayerESPText()
end,
})
local ObjectESPBox = Tabs.Esp:AddRightGroupbox("Item eSP", "box")
ObjectESPBox:AddCheckbox("GeneratorESP", {
Text = "generator ESP",
Default = false,
Callback = function(value)
ESPSettings.generatorESP = value
end,
}):AddColorPicker("GeneratorColor", {
Default = ESPSettings.generatorColor,
Title = "Generator color ",
Callback = function(value)
ESPSettings.generatorColor = value
end,
})
ObjectESPBox:AddCheckbox("ItemESP", {
Text = "items ESP",
Default = false,
Callback = function(value)
ESPSettings.itemESP = value
end,
}):AddColorPicker("ItemColor", {
Default = ESPSettings.itemColor,
Title = "Article color ",
Callback = function(value)
ESPSettings.itemColor = value
end,
})
ObjectESPBox:AddCheckbox("PizzaESP", {
Text = "Pizza esp ",
Default = false,
Callback = function(value)
ESPSettings.pizzaEsp = value
end,
}):AddColorPicker("PizzaColor", {
Default = ESPSettings.pizzaColor,
Title = "Pizza color ",
Callback = function(value)
ESPSettings.pizzaColor = value
end,
})
local SpecialESPBox = Tabs.Esp:AddRightGroupbox("Special esp ","zap")
SpecialESPBox:AddCheckbox("PizzaDeliveryESP", {
Text = "Pizza delivery guy [coolkid] ESP",
Default = false,
Callback = function(value)
ESPSettings.pizzaDeliveryEsp = value
end,
}):AddColorPicker("PizzaDeliveryColor", {
Default = ESPSettings.pizzaDeliveryColor,
Title = "Pizza delivery color ",
Callback = function(value)
ESPSettings.pizzaDeliveryColor = value
end,
})
SpecialESPBox:AddCheckbox("ZombieESP", {
Text = "zombie[1x4] ESP",
Default = false,
Callback = function(value)
ESPSettings.zombieEsp = value
end,
}):AddColorPicker("ZombieColor", {
Default = ESPSettings.zombieColor,
Title = "Zombie Color ",
Callback = function(value)
ESPSettings.zombieColor = value
end,
})
SpecialESPBox:AddCheckbox("TripwireESP", {
Text = "Trip wire esp ",
Default = false,
Callback = function(value)
ESPSettings.taphTripwireEsp = value
end,
}):AddColorPicker("TripwireColor", {
Default = ESPSettings.tripwireColor,
Title = "Trip Wire Color ",
Callback = function(value)
ESPSettings.tripwireColor = value
end,
})
SpecialESPBox:AddCheckbox("TripMineESP", {
Text = "Underground space bomb esp ",
Default = false,
Callback = function(value)
ESPSettings.tripMineEsp = value
end,
}):AddColorPicker("TripMineColor", {
Default = ESPSettings.tripMineColor,
Title = "Booby color ",
Callback = function(value)
ESPSettings.tripMineColor = value
end,
})
SpecialESPBox:AddCheckbox("RespawnESP", {
Text = "Twice regenerate point esp ",
Default = false,
Callback = function(value)
ESPSettings.twoTimeRespawnEsp = value
end,
}):AddColorPicker("RespawnColor", {
Default = ESPSettings.respawnColor,
Title = "Regenerate dot color twice",
Callback = function(value)
ESPSettings.respawnColor = value
end,
})
local TracerBox = Tabs.Esp:AddRightGroupbox("Trace Line", "spline")
TracerBox:AddCheckbox("KillerTracers", {
Text = "Killer tracking line ",
Default = false,
Callback = function(value)
ESPSettings.killerTracers = value
end,
})
TracerBox:AddCheckbox("SurvivorTracers", {
Text = "Survivor tracking line ",
Default = false,
Callback = function(value)
ESPSettings.survivorTracers = value
end,
})
TracerBox:AddCheckbox("GeneratorTracers", {
Text = "Generator tracking line",
Default = false,
Callback = function(value)
ESPSettings.generatorTracers = value
end,
})
TracerBox:AddCheckbox("ItemTracers", {
Text = "Item Tracking Line ",
Default = false,
Callback = function(value)
ESPSettings.itemTracers = value
end,
})
TracerBox:AddCheckbox("PizzaTracers", {
Text = "Pizza tracking line",
Default = false,
Callback = function(value)
ESPSettings.pizzaTracers = value
end,
})
TracerBox:AddCheckbox("PizzaDeliveryTracers", {
Text = "Pizza delivery tracking line",
Default = false,
Callback = function(value)
ESPSettings.pizzaDeliveryTracers = value
end,
})
TracerBox:AddCheckbox("ZombieTracers", {
Text = "Zombie Tracking Line ",
Default = false,
Callback = function(value)
ESPSettings.zombieTracers = value
end,
})
local v437 = Tabs.ani:AddLeftGroupbox("Universal counter effect", "shield")
v437:AddToggle("AntiBlindness", {
Text = "Anti-blinding ",
Default = false,
Callback = function()
task.spawn(function()
while Toggles.AntiBlindness.Value and task.wait() do
if game.Lighting:FindFirstChild("BlindnessBlur") then
game.Lighting.BlindnessBlur:Destroy()
end
end
end)
end
})
v437:AddToggle("AntiSubspace", {
Text = "Antisubspace explosion",
Default = false,
Callback = function()
task.spawn(function()
while Toggles.AntiSubspace.Value and task.wait() do
for _, v447 in pairs({"SubspaceVFXBlur", "SubspaceVFXColorCorrection"}) do
if game.Lighting:FindFirstChild(v447) then
game.Lighting[v447]:Destroy()
end
end
end
end)
end
})
getgenv().activateRemoteHook = function(remoteName, blockedFirstArg)
for _, rule in ipairs(getgenv().HookRules) do
if rule.remoteName == remoteName and rule.blockedFirstArg == blockedFirstArg then
return
end
end
table.insert(getgenv().HookRules, {
remoteName = remoteName,
blockedFirstArg = blockedFirstArg,
block = true
})
end
getgenv().deactivateRemoteHook = function(remoteName, blockedFirstArg)
for i, rule in ipairs(getgenv().HookRules) do
if rule.remoteName == remoteName and rule.blockedFirstArg == blockedFirstArg then
table.remove(getgenv().HookRules, i)
break
end
end
end
getgenv().isFiringDusekkar = false
getgenv().EnableProtection = function()
getgenv().activateRemoteHook("RemoteEvent", game.Players.LocalPlayer.Name .. "DusekkarCancel")
if not getgenv().isFiringDusekkar then
getgenv().isFiringDusekkar = true
task.spawn(function()
task.wait(4)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvent = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")
RemoteEvent:FireServer({game.Players.LocalPlayer.Name .. "DusekkarCancel"})
getgenv().isFiringDusekkar = false
end)
end
end
getgenv().DisableProtection = function()
getgenv().deactivateRemoteHook("RemoteEvent", game.Players.LocalPlayer.Name .. "DusekkarCancel")
end
local DusekkarGroup = Tabs.ani:AddLeftGroupbox("Dusekkar", "user")
DusekkarGroup:AddCheckbox("ProtectionDusekkar", {
Text = "De-protection",
Default = false,
Tooltip = "To prevent the shield from being removed",
Callback = function(Value)
if Value then
getgenv().EnableProtection()
else
getgenv().DisableProtection()
end
end
})
local ZZ2 = Tabs.ani:AddRightGroupbox('NOOB Adverse effect ')
ZZ2:AddToggle("RemoveSlateskin", {
Text = "Inverse noob slab speed ",
Default = false,
Callback = function(v)
if not _G.SlateskinCleanup then _G.SlateskinCleanup = {} end
local connections = _G.SlateskinCleanup
for _, conn in pairs(connections) do
if typeof(conn) == "RBXScriptConnection" then
conn:Disconnect()
end
end
_G.SlateskinCleanup = {}
if not v then return end
local function CleanSlateskins()
local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
if not survivorsFolder then return end
local survivorList = survivorsFolder:GetChildren()
for i = 1, #survivorList, 5 do
task.spawn(function()
for j = i, math.min(i + 4, #survivorList) do
local survivor = survivorList[j]
local slateskin = survivor:FindFirstChild("SlateskinStatus")
if slateskin then
slateskin:Destroy()
end
end
end)
end
end
task.spawn(CleanSlateskins)
connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
task.wait(2)
CleanSlateskins()
end)
local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
if survivorsFolder then
connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
if descendant.Name == "SlateskinStatus" then
descendant:Destroy()
end
end)
end
end
})
local Disabled = Tabs.ani:AddLeftGroupbox('Visitor Converse ')
Disabled:AddToggle("RemoveSlowed", {
Text = "Anti-slowness",
Default = false,
Callback = function(v)
if not _G.SlowedCleanup then _G.SlowedCleanup = {} end
local connections = _G.SlowedCleanup
for _, conn in pairs(connections) do
if typeof(conn) == "RBXScriptConnection" then
conn:Disconnect()
end
end
_G.SlowedCleanup = {}
if not v then return end
local function CleanSlowedStatuses()
local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
if not survivorsFolder then return end
for _, survivor in ipairs(survivorsFolder:GetDescendants()) do
if survivor.Name == "SlowedStatus" then
survivor:Destroy()
end
end
end
task.spawn(CleanSlowedStatuses)
connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
task.wait(1.5)
CleanSlowedStatuses()
end)
local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
if survivorsFolder then
connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
if descendant.Name == "SlowedStatus" then
descendant:Destroy()
end
end)
end
end
})
Disabled:AddToggle("RemoveBlockingSlow", {
Text = "Reverse blocking speed",
Default = false,
Callback = function(v)
if not _G.BlockingCleanup then _G.BlockingCleanup = {} end
local connections = _G.BlockingCleanup
for _, conn in pairs(connections) do
if typeof(conn) == "RBXScriptConnection" then
conn:Disconnect()
end
end
_G.BlockingCleanup = {}
if not v then return end
local function CleanStatuses()
local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
if not survivorsFolder then return end
for _, survivor in ipairs(survivorsFolder:GetDescendants()) do
if survivor.Name == "ResistanceStatus" or survivor.Name == "GuestBlocking" then
survivor:Destroy()
end
end
end
task.spawn(CleanStatuses)
connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
task.wait(1.5)
CleanStatuses()
end)
local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
if survivorsFolder then
connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
if descendant.Name == "ResistanceStatus" or descendant.Name == "GuestBlocking" then
descendant:Destroy()
end
end)
end
end
})
Disabled:AddToggle("RemovePunchSlow", {
Text = "Anti-boxing speed",
Default = false,
Callback = function(v)
if not _G.PunchCleanup then _G.PunchCleanup = {} end
local connections = _G.PunchCleanup
for _, conn in pairs(connections) do
if typeof(conn) == "RBXScriptConnection" then
conn:Disconnect()
end
end
_G.PunchCleanup = {}
if not v then return end
local function CleanStatuses()
local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
if not survivorsFolder then return end
for _, survivor in ipairs(survivorsFolder:GetDescendants()) do
if survivor.Name == "ResistanceStatus" or survivor.Name == "PunchAbility" then
survivor:Destroy()
end
end
end
task.spawn(CleanStatuses)
connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
task.wait(1.5)
CleanStatuses()
end)
local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
if survivorsFolder then
connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
if descendant.Name == "ResistanceStatus" or descendant.Name == "PunchAbility" then
descendant:Destroy()
end
end)
end
end
})
Disabled:AddToggle("RemoveChargeEnded", {
Text = "Effect after reverse sprint",
Default = false,
Callback = function(v)
if not _G.ChargeEndedCleanup then _G.ChargeEndedCleanup = {} end
local connections = _G.ChargeEndedCleanup
for _, conn in pairs(connections) do
if typeof(conn) == "RBXScriptConnection" then
conn:Disconnect()
end
end
_G.ChargeEndedCleanup = {}
if not v then return end
local function CleanChargeEndedEffects()
local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
if not survivorsFolder then return end
for _, survivor in ipairs(survivorsFolder:GetDescendants()) do
if survivor.Name == "GuestChargeEnded" then
survivor:Destroy()
end
end
end
task.spawn(CleanChargeEndedEffects)
connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
task.wait(1.5)
CleanChargeEndedEffects()
end)
local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
if survivorsFolder then
connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
if descendant.Name == "GuestChargeEnded" then
descendant:Destroy()
end
end)
end
end
})
local LeftGroupBox = Tabs.ani:AddRightGroupbox("c00lkidd", "user")
if not getgenv().originalNamecall then
getgenv().HookRules = {}
getgenv().originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
local method = getnamecallmethod()
local args = {...}
if method == "FireServer" then
for _, rule in ipairs(getgenv().HookRules) do
if (not rule.remoteName or self.Name == rule.remoteName) then
if not rule.blockedFirstArg or args[1] == rule.blockedFirstArg then
if rule.block then
return
end
end
end
end
end
return getgenv().originalNamecall(self, ...)
end)
end
getgenv().activateRemoteHook = function(remoteName, blockedFirstArg)
for _, rule in ipairs(getgenv().HookRules) do
if rule.remoteName == remoteName and rule.blockedFirstArg == blockedFirstArg then
return
end
end
table.insert(getgenv().HookRules, {
remoteName = remoteName,
blockedFirstArg = blockedFirstArg,
block = true
})
end
getgenv().deactivateRemoteHook = function(remoteName, blockedFirstArg)
for i, rule in ipairs(getgenv().HookRules) do
if rule.remoteName == remoteName and rule.blockedFirstArg == blockedFirstArg then
table.remove(getgenv().HookRules, i)
break
end
end
end
getgenv().EnableC00lkidd = function()
getgenv().activateRemoteHook("RemoteEvent", game.Players.LocalPlayer.Name .. "C00lkiddCollision")
end
getgenv().DisableC00lkidd = function()
getgenv().deactivateRemoteHook("RemoteEvent", game.Players.LocalPlayer.Name .. "C00lkiddCollision")
end
local globalEnv = getgenv()
globalEnv.Players = game:GetService("Players")
globalEnv.RunService = game:GetService("RunService")
globalEnv.Camera = workspace.CurrentCamera
globalEnv.Player = globalEnv.Players.LocalPlayer
globalEnv.walkSpeed = 100
globalEnv.toggle = false
globalEnv.connection = nil
function globalEnv.getCharacter()
return globalEnv.Player.Character or globalEnv.Player.CharacterAdded:Wait()
end
function globalEnv.onHeartbeat()
local player = globalEnv.Player
local character = globalEnv.getCharacter()
if character.Name ~= "c00lkidd" then return end
local char = globalEnv.getCharacter()
local rootPart = char:FindFirstChild("HumanoidRootPart")
local humanoid = char:FindFirstChildOfClass("Humanoid")
local lv = rootPart and rootPart:FindFirstChild("LinearVelocity")
if not rootPart or not humanoid or not lv then return end
if lv then
lv.VectorVelocity = Vector3.new(math.huge, math.huge, math.huge)
lv.Enabled = false
end
local stopMovement = false
local validValues = {
Timeout = true,
Collide = true,
Hit = true
}
local function watchResult(result)
local function checkValue()
if validValues[result.Value] then
stopMovement = true
end
end
checkValue()
result:GetPropertyChangedSignal("Value"):Connect(checkValue)
end
local function onCharacterAdded(character)
local result = character:FindFirstChild("Result")
if result and result:IsA("StringValue") then
watchResult(result)
end
character.ChildAdded:Connect(function(child)
if child.Name == "Result" and child:IsA("StringValue") then
watchResult(child)
end
end)
end
player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
onCharacterAdded(player.Character)
end
if not stopMovement then
local lookVector = globalEnv.Camera.CFrame.LookVector
local moveDir = Vector3.new(lookVector.X, 0, lookVector.Z)
if moveDir.Magnitude > 0 then
moveDir = moveDir.Unit
rootPart.Velocity = Vector3.new(moveDir.X * globalEnv.walkSpeed, rootPart.Velocity.Y, moveDir.Z * globalEnv.walkSpeed)
rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + moveDir)
end
end
end
LeftGroupBox:AddToggle("WalkspeedOverrideController", {
Text = "Free movement (locked viewing angle) ",
Tooltip = "Enable Speed Override Controller ",
Default = false,
Callback = function(value)
if value then
globalEnv.connection = globalEnv.RunService.Heartbeat:Connect(globalEnv.onHeartbeat)
else
if globalEnv.connection then
globalEnv.connection:Disconnect()
end
end
end,
})
LeftGroupBox:AddToggle("IgnoreObjectables", {
Text = "Ignoring colliding objects ",
Tooltip = "Enable Ignore Collisions ",
Default = false,
Callback = function(Value)
if Value then
getgenv().EnableC00lkidd()
else
getgenv().DisableC00lkidd()
end
end
})
local ZZ = Tabs.ani:AddRightGroupbox('1x4')local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local AutoPopup = {
Enabled = false,
Task = nil,
Connections = {},
Interval = 0.5
}
local function deletePopups()
if not LocalPlayer or not LocalPlayer:FindFirstChild("PlayerGui") then
return false
end
local tempUI = LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
if not tempUI then
return false
end
local deleted = false
for _, popup in ipairs(tempUI:GetChildren()) do
if popup.Name == "1x1x1x1Popup" then
popup:Destroy()
deleted = true
end
end
return deleted
end
local function triggerEntangled()
pcall(function()
ReplicatedStorage.Modules.Network.RemoteEvent:FireServer("Entangled", {})
end)
end
local function setupPopupListener()
if not LocalPlayer or not LocalPlayer:FindFirstChild("PlayerGui") then return end
local tempUI = LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
if not tempUI then
tempUI = Instance.new("Folder")
tempUI.Name = "TemporaryUI"
tempUI.Parent = LocalPlayer.PlayerGui
end
if AutoPopup.Connections.ChildAdded then
AutoPopup.Connections.ChildAdded:Disconnect()
end
AutoPopup.Connections.ChildAdded = tempUI.ChildAdded:Connect(function(child)
if AutoPopup.Enabled and child.Name == "1x1x1x1Popup" then
task.defer(function()
child:Destroy()
triggerEntangled()
end)
end
end)
end
local function runMainTask()
while AutoPopup.Enabled do
deletePopups()
task.wait(AutoPopup.Interval)
end
end
local function startAutoPopup()
if AutoPopup.Enabled then return end
AutoPopup.Enabled = true
setupPopupListener()
if AutoPopup.Task then
task.cancel(AutoPopup.Task)
end
AutoPopup.Task = task.spawn(runMainTask)
end
local function stopAutoPopup()
if not AutoPopup.Enabled then return end
AutoPopup.Enabled = false
if AutoPopup.Task then
task.cancel(AutoPopup.Task)
AutoPopup.Task = nil
end
for _, connection in pairs(AutoPopup.Connections) do
connection:Disconnect()
end
AutoPopup.Connections = {}
end
ZZ:AddSlider('AutoPopupInterval', {
Text = 'Execution interval ',
Default = 0.5,
Min = 0.5,
Max = 2,
Rounding = 0,
Tooltip = 'Set the automatic execution interval (1-5 seconds)',
Callback = function(value)
AutoPopup.Interval = value
end
})
ZZ:AddCheckbox('AutoPopupToggle', {
Text = 'Bounce window ',
Default = false,
Tooltip = 'Remove pop-ups and lazy effects',
Callback = function(state)
if state then
startAutoPopup()
else
stopAutoPopup()
end
end
})
if LocalPlayer then
LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
if not LocalPlayer.Parent then
stopAutoPopup()
end
end)
end
local NoliGroup = Tabs.ani:AddLeftGroupbox("Noli", "user")
local RunService = game:GetService("RunService")
local player = game:GetService("Players").LocalPlayer
local noliDeleterActive = false
local deletionConnection = nil
local allowedNoli = nil
local isVoidRushCrashed = false
local characterCheckLoop = nil
local function deleteNewNoli()
local killers = workspace:WaitForChild("Players"):WaitForChild("Killers")
allowedNoli = killers:FindFirstChild("Noli")
if not allowedNoli then
return
end
if deletionConnection then
deletionConnection:Disconnect()
deletionConnection = nil
end
deletionConnection = RunService.Heartbeat:Connect(function()
allowedNoli = killers:FindFirstChild("Noli")
if not allowedNoli then
if deletionConnection then
deletionConnection:Disconnect()
deletionConnection = nil
end
return
end
for _, child in killers:GetChildren() do
if child.Name == "Noli" and child ~= allowedNoli then
child:Destroy()
end
end
end)
end
local function manageVoidRushState(character)
while isVoidRushCrashed and character and character.Parent do
character:SetAttribute("VoidRushState", "Crashed")
task.wait(0.5)
end
end
NoliGroup:AddCheckbox("NoliDeleter", {
Text = "Anti-false Noli",
Default = false,
Callback = function(enabled)
noliDeleterActive = enabled
if enabled then
if deletionConnection then
deletionConnection:Disconnect()
deletionConnection = nil
end
local success = pcall(deleteNewNoli)
if not success then
noliDeleterActive = false
end
else
if deletionConnection then
deletionConnection:Disconnect()
deletionConnection = nil
end
allowedNoli = nil
end
end
})
NoliGroup:AddCheckbox("Ignore obstacles[Noli]", {
Text = "NoliIgnore obstacles. ",
Default = false,
Callback = function(enabled)
isVoidRushCrashed = enabled
local character = player.Character
if characterCheckLoop then
task.cancel(characterCheckLoop)
characterCheckLoop = nil
end
if enabled then
if character then
characterCheckLoop = task.spawn(function()
manageVoidRushState(character)
end)
end
else
if character then
character:SetAttribute("VoidRushState", nil)
end
end
end
})
local killers = workspace:WaitForChild("Players"):WaitForChild("Killers")
killers.ChildAdded:Connect(function(child)
if noliDeleterActive and child.Name == "Noli" and not deletionConnection then
task.wait(0.5)
if noliDeleterActive and not deletionConnection then
deleteNewNoli()
end
end
end)
player.CharacterAdded:Connect(function(newCharacter)
if isVoidRushCrashed then
if characterCheckLoop then
task.cancel(characterCheckLoop)
end
characterCheckLoop = task.spawn(function()
manageVoidRushState(newCharacter)
end)
end
end)
local ZZ = Tabs.Main:AddRightGroupbox('Player Move')
local CFSpeed = 50
local CFLoop = nil
local RunService = game:GetService("RunService")
local speedValue = 0
_G.SpeedToggle = false
ZZ:AddSlider("SpeedBypass", {
Text = "Speed regulation ",
Default = 16,
Min = 1,
Max = 500,
Rounding = 0,
Callback = function(value)
speedValue = value
end
})
ZZ:AddToggle("SpeedToggle", {
Text = "Speed hacker ",
Default = false,
Callback = function(state)
_G.SpeedToggle = state
task.spawn(function()
local LocalPlayer = game.Players.LocalPlayer
while task.wait() and _G.SpeedToggle do
local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
if humanoid and humanoid.MoveDirection ~= Vector3.zero then
LocalPlayer.Character:TranslateBy(humanoid.MoveDirection * speedValue * game:GetService("RunService").RenderStepped:Wait())
end
end
end)
end
})
local noclipParts = {}
_G.noclipState = false
local function enableNoclip()
local LocalPlayer = game.Players.LocalPlayer
if LocalPlayer.Character then
for _, part in pairs(LocalPlayer.Character:GetChildren()) do
if part:IsA("BasePart") then
noclipParts[part] = part
part.CanCollide = false
end
end
end
end
local function disableNoclip()
for _, part in pairs(noclipParts) do
part.CanCollide = true
end
end
ZZ:AddToggle("EnableNoclip", {
Text = "Through-wall",
Default = false,
Callback = function(state)
_G.noclipState = state
task.spawn(function()
while task.wait() do
if _G.noclipState then
enableNoclip()
else
disableNoclip()
break
end
end
end)
end
})
local function StartCFly()
local speaker = game.Players.LocalPlayer
local character = speaker.Character
if not character or not character.Parent then return end
local humanoid = character:FindFirstChildOfClass('Humanoid')
local head = character:FindFirstChild("Head")
if not humanoid or not head then return end
humanoid.PlatformStand = true
head.Anchored = true
if CFLoop then
CFLoop:Disconnect()
CFLoop = nil
end
local function isCharacterValid()
if not character or not character.Parent then return false end
if not humanoid or humanoid.Parent ~= character then return false end
if not head or head.Parent ~= character then return false end
return true
end
CFLoop = RunService.Heartbeat:Connect(function(deltaTime)
if not isCharacterValid() then
if CFLoop then
CFLoop:Disconnect()
CFLoop = nil
end
return
end
local moveDirection = humanoid.MoveDirection
local headCFrame = head.CFrame
local camera = workspace.CurrentCamera
if not camera then return end
local cameraCFrame = camera.CFrame
local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
local cameraPosition = cameraCFrame.Position
local headPosition = headCFrame.Position
local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection * (CFSpeed * deltaTime))
if isCharacterValid() then
head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
end
end)
end
local function StopCFly()
local speaker = game.Players.LocalPlayer
local character = speaker.Character
if CFLoop then
CFLoop:Disconnect()
CFLoop = nil
end
if character and character.Parent then
local humanoid = character:FindFirstChildOfClass('Humanoid')
local head = character:FindFirstChild("Head")
if humanoid then
humanoid.PlatformStand = false
end
if head then
head.Anchored = false
end
end
end
game.Players.LocalPlayer.CharacterAdded:Connect(function()
StopCFly()
end)
ZZ:AddToggle("CFlyToggle", {
Text = "Flight",
Default = false,
Callback = function(Value)
if Value then
task.wait(0.1)
StartCFly()
else
StopCFly()
end
end
})
ZZ:AddSlider("CFlySpeed", {
Text = "Flying speed ",
Default = 50,
Min = 1,
Max = 200,
Rounding = 1,
Callback = function(Value)
CFSpeed = Value
end
})
ZZ:AddLabel("All of the above bypassed/used with violence")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local SpoofActive = false
local TargetCFrame = nil
local OriginalCallback = nil
local HookInstalled = false
local function formatCFrame(cf)
if not cf then return nil end
local pos, look = cf.Position, cf.LookVector
return string.format("%0.3f/%0.3f/%0.3f/%0.3f/%0.3f/%0.3f",
pos.X, pos.Y, pos.Z, look.X, look.Y, look.Z)
end
local function installHook()
if HookInstalled then return end
local success, networkModule = pcall(require, ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"))
if not success or not networkModule then return end
if networkModule.SetConnection then
local originalSetConnection = networkModule.SetConnection
networkModule.SetConnection = function(self, key, connType, callback)
if key == "GetLocalPosData" and connType == "REMOTE_FUNCTION" then
OriginalCallback = callback
local wrappedCallback = function(...)
if SpoofActive and TargetCFrame then
return formatCFrame(TargetCFrame)
end
if OriginalCallback then
return OriginalCallback(...)
end
local char = LocalPlayer.Character
if char and char.PrimaryPart then
return formatCFrame(char.PrimaryPart.CFrame)
end
return nil
end
return originalSetConnection(self, key, connType, wrappedCallback)
end
return originalSetConnection(self, key, connType, callback)
end
HookInstalled = true
end
end
local function setupSpoof()
installHook()
local char = LocalPlayer.Character
if char and char.PrimaryPart then
TargetCFrame = char.PrimaryPart.CFrame
SpoofActive = true
end
LocalPlayer.CharacterAdded:Connect(function(newChar)
newChar:WaitForChild("HumanoidRootPart")
if SpoofActive then
TargetCFrame = newChar.HumanoidRootPart.CFrame
end
end)
end
task.spawn(function()
task.wait(1)
setupSpoof()
end)
local SpoofTab = Tabs.Main:AddLeftGroupbox("Server Bypass [Speed] ")
SpoofTab:AddToggle("SpoofToggle", {
Text = "Location spoofing ",
Default = false,
Callback = function(state)
SpoofActive = state
if state then
local char = LocalPlayer.Character
if char and char.PrimaryPart then
TargetCFrame = char.PrimaryPart.CFrame
end
end
end
})
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Commissioning")
MenuGroup:AddToggle("KeybindMenuOpen", {
Default = Library.KeybindFrame.Visible,
Text = "Shortcut Menu ",
Callback = function(value)
Library.KeybindFrame.Visible = value
end,
})
MenuGroup:AddToggle("ShowCustomCursor", {
Text = "Mouse cursor ",
Default = true,
Callback = function(Value)
Library.ShowCustomCursor = Value
end,
})
MenuGroup:AddDropdown("NotificationSide", {
Values = { "Left", "Right" },
Default = "Right",
Text = "Notification location ",
Callback = function(Value)
Library:SetNotifySide(Value)
end,
})
MenuGroup:AddDropdown("DPIDropdown", {
Values = { "25%", "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
Default = "75%",
Text = "UI Size ",
Callback = function(Value)
Value = Value:gsub("%%", "")
local DPI = tonumber(Value)
Library:SetDPIScale(DPI)
end,
})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind")
:AddKeyPicker("MenuKeybind", {
Default = "RightShift",
NoUI = true,
Text = "Menu keybind"
})
MenuGroup:AddButton("DestructionUI", function()
Library:Unload()
end)
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("MyScriptHub")
SaveManager:SetFolder("MyScriptHub/specific-game")
SaveManager:SetSubFolder("specific-place")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()
Library:SetWatermarkVisibility(true)
local function updateWatermark()
local fps = 60
local frameTimer = tick()
local frameCounter = 0
game:GetService('RunService').RenderStepped:Connect(function()
frameCounter = frameCounter + 1
if ((tick() - frameTimer) >= 1) then
fps = frameCounter
frameTimer = tick()
frameCounter = 0
end
Library:SetWatermark(string.format('NOL | %d FPS | Yuxingchen | %d ping ', math.floor(fps), math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())))
end)
end
updateWatermark()