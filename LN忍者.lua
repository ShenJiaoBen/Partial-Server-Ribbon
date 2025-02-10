if "By LN" == KingScript and "霖溺Script" == Roblox and "Legend of Ninja" == KingTeam then
setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")
wait(0.1)
local Interstellar = {
    Teleporting = false,
    swing = false,
    sell = false,
    buy = false,
    hoops = false,
    opencrystal = false,
    petshop = false,
    evolvepet = false
}

local CoreGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local crystalshow = {}
local OpenCrystal = ""

for i, crystal in pairs(game:GetService("Workspace").mapCrystalsFolder:GetChildren()) do
    crystalshow[i] = crystal.Name
end

local petshow = {}
local BuyPetShop = ""
local EvolvePet = ""

for i, pet in pairs(game:GetService("ReplicatedStorage").cPetShopFolder:GetChildren()) do
    petshow[i] = pet.Name
end

local dropdown = {}
local playernamedied = ""

for i, player in pairs(game.Players:GetPlayers()) do
    dropdown[i] = player.Name
end

local function Refresh()
    dropdown = {}
    for i, player in ipairs(Players:GetPlayers()) do
        dropdown[i] = player.Name
    end
end

local function isNumber(str)
  if tonumber(str) ~= nil or str == 'inf' then
    return true
  end
end

getgenv().TPSpeed = 3
getgenv().TPWalk = false

local success, library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/KingScriptAE/No-sirve-nada./main/%E9%9C%96%E6%BA%BA%E8%84%9A%E6%9C%ACUI.lua"))()
end)

if not success then
    warn("UI库加载失败")
    return
end

local window = library:new("霖溺 | 忍者传奇")
--
local LSS = window:Tab("主页",'16060333448')
local info = LSS:section("作者信息",true)

local LM = window:Tab("主要功能",'16060333448')
local Main = LM:section("主要",true)

local LMAO = window:Tab("购买",'16060333448')
local Buys = LMAO:section("自动购买",true)

local LS = window:Tab("其他",'16060333448')
local Crystal = LS:section("水晶",true)
local PetShop = LS:section("商店",true)
local Evolve = LS:section("进化",true)

local LA = window:Tab("业报",'16060333448')
local Karmasteps2 = LA:section("Karma",true)

local PM = window:Tab("传送",'16060333448')
local teleport = PM:section("tp",true)

local LST = window:Tab("查看和复制玩家",'16060333448')
local Look = LST:section("查看",true)
local Copy = LST:section("复制",true)
--
info:Label("作者:月星 续作:霖溺")
info:Label("完全免费请勿倒卖")
info:Label("本服务器忍者传奇")
info:Button("点击复制群聊",function()
setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")
end)

Main:Toggle("自动挥舞", "swing", false, function(state)
    Interstellar.swing = state
    if Interstellar.swing then
        for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v:FindFirstChild("attackKatanaScript") then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    while Interstellar.swing do
                    game.Players.LocalPlayer.ninjaEvent:FireServer("swingKatana")
                    task.wait()
                end
            end
        end
    end
end)

Main:Toggle("自动售卖", "Sell", false, function(state)
    Interstellar.sell = state
    if Interstellar.sell then
        while Interstellar.sell do
        game.workspace.sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        task.wait()
        end
    end
end)

Main:Toggle("吸所有环", "Hoops", false, function(state)
    Interstellar.hoops = state
    if Interstellar.hoops then
        while Interstellar.hoops do
            for i, v in ipairs(workspace.Hoops:GetChildren()) do
                if v.Name == "Hoop" then
                    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
            wait()
            for i, v in ipairs(workspace.Hoops.Hoop:GetChildren()) do
                if v.Name == "touchPart" then
                    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end
end)

Main:Toggle("收集气", "Suction all", false, function(state)
    Interstellar.spawnedCoins = state
    if Interstellar.spawnedCoins then
        while Interstellar.spawnedCoins do
            for i, v in pairs(game.Workspace.spawnedCoins.Valley:GetChildren()) do
                if v.Name == "Blue Chi Crate" then 
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
                wait(2)
                end
            end
        end
    end
end)

Main:Toggle("收集金币", "Suction all", false, function(state)
    Interstellar.spawnedCoins = state
    if Interstellar.spawnedCoins then
        while Interstellar.spawnedCoins do
            for i, v in pairs(game.Workspace.spawnedCoins.Valley:GetChildren()) do
                if v.Name == "Blue Coin" then 
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
                wait(2)
                end
            end
        end
    end
end)

Main:Button("最大跳跃次数", function()
    game.Players.LocalPlayer.multiJumpCount.Value = "50"
end)

local addedPasses = {}

local function getAllPasses()
    local passes = {}
    local success, err = pcall(function()
        for i, v in ipairs(game:GetService("ReplicatedStorage").gamepassIds:GetChildren()) do
            table.insert(passes, v)
        end
    end)
    if not success then
        warn("获取通行证失败: " .. err)
    end
    return passes
end

local function isPassAdded(pass)
    for i, v in ipairs(addedPasses) do
        if v == pass then
            return true
        end
    end
    return false
end

local function addAllPasses()
    local passes = getAllPasses()
    for i, v in ipairs(passes) do
        if not isPassAdded(v) then
            local success, err = pcall(function()
                v.Parent = game.Players.LocalPlayer.ownedGamepasses
                table.insert(addedPasses, v)
            end)
            if not success then
                warn("添加通行证失败: " .. err)
            end
        end
    end
    warn("已获取全部通行证")
end

local function removeAllPasses()
    for i, v in ipairs(addedPasses) do
        local success, err = pcall(function()
            v.Parent = game:GetService("ReplicatedStorage").gamepassIds
        end)
        if not success then
            warn("移除通行证失败: " .. err)
        end
    end
    addedPasses = {}
    warn("已移除全部通行证")
end

local function addPass(pass)
    if not isPassAdded(pass) then
        local success, err = pcall(function()
            pass.Parent = game.Players.LocalPlayer.ownedGamepasses
            table.insert(addedPasses, pass)
        end)
        if success then
            warn("已获取通行证: " .. pass.Name)
        else
            warn("添加通行证失败: " .. err)
        end
    else
        warn("通行证已存在: " .. pass.Name)
    end
end

local function removePass(pass)
    for i, v in ipairs(addedPasses) do
        if v == pass then
            local success, err = pcall(function()
                v.Parent = game:GetService("ReplicatedStorage").gamepassIds
            end)
            if success then
                table.remove(addedPasses, i)
                warn("已移除通行证: " .. pass.Name)
            else
                warn("移除通行证失败: " .. err)
            end
            return
        end
    end
    warn("通行证未找到: " .. pass.Name)
end

Main:Toggle("通用获取全部通行证", "获取全部通行证", false, function(state)
    if state then
        addAllPasses()
    else
        removeAllPasses()
    end
end)

Main:Button("重置所有通行证", function()
    removeAllPasses()
end)

Main:Button("解锁忍者传奇全部通行证",function()
game:GetService("ReplicatedStorage").gamepassIds["+2 Pet Slots"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["+3 Pet Slots"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["+4 Pet Slots"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["+100 Capacity"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["+200 Capacity"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["+20 Capacity"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["+60 Capacity"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["Infinite Ammo"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["Infinite Ninjitsu"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["Permanent Islands Unlock"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["x2 Coins"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["x2 Damage"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["x2 Health"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["x2 Ninjitsu"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["x2 Speed"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["Faster Sword"].Parent = game.Players.LocalPlayer.ownedGamepasses
game:GetService("ReplicatedStorage").gamepassIds["x3 Pet Clones"].Parent = game.Players.LocalPlayer.ownedGamepasses
end)

Main:Button("收集所有宝箱",function()
    game:GetService("Workspace").mythicalChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace").goldenChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace").enchantedChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace").magmaChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace").legendsChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace").eternalChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace").saharaChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace").thunderChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace").ancientChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace").midnightShadowChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace").groupRewardsCircle["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace")["Daily Chest"].circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace")["wonderChest"].circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		wait(3.5)
		game:GetService("Workspace").wonderChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game:GetService("Workspace").midnightShadowChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game:GetService("Workspace").ancientChest["circleInner"].CFrame = game.Workspace.Part.CFrame
		game:GetService("Workspace").midnightShadowChest["circleInner"].CFrame = game.Workspace.Part.CFrame
		game:GetService("Workspace").thunderChest["circleInner"].CFrame = game.Workspace.Part.CFrame
		game:GetService("Workspace").saharaChest["circleInner"].CFrame = game.Workspace.Part.CFrame
		game:GetService("Workspace").eternalChest["circleInner"].CFrame = game.Workspace.Part.CFrame
		game:GetService("Workspace").legendsChest["circleInner"].CFrame = game.Workspace.Part.CFrame
		game:GetService("Workspace").magmaChest["circleInner"].CFrame = game.Workspace.Part.CFrame
		game:GetService("Workspace").enchantedChest["circleInner"].CFrame = game.Workspace.Part.CFrame
		game:GetService("Workspace").goldenChest["circleInner"].CFrame = game.Workspace.Part.CFrame
		game:GetService("Workspace").mythicalChest["circleInner"].CFrame = game.Workspace.Part.CFrame
		game:GetService("Workspace").groupRewardsCircle["circleInner"].CFrame = game.Workspace.Part.CFrame
		game:GetService("Workspace")["Daily Chest"].circleInner.CFrame = game.Workspace.Part.CFrame
end)

Main:Button("收集光明业报", function()
        game:GetService("Workspace").lightKarmaChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        wait(5)
        game:GetService("Workspace").lightKarmaChest["circleInner"].CFrame = game.Workspace.Part.CFrame
end)

Main:Button("收集邪恶业报", function()
        game:GetService("Workspace").evilKarmaChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        wait(5)
        game:GetService("Workspace").evilKarmaChest["circleInner"].CFrame = game.Workspace.Part.CFrame
end)

Main:Button("服务器跳转", function()
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

Teleport() 
end)

Buys:Toggle("自动买剑", "Auto Buy", false, function(state)
    Interstellar.buy = state
    if state then
        while Interstellar.buy do
            local oh1 = "buyAllSwords"
            local oh2 = {"Ground", "Astral Island", "Space Island", "Tundra Island", "Eternal Island", "Sandstorm", "Thunderstorm", "Ancient Inferno Island", "Midnight Shadow Island", "Mythical Souls Island", "Winter Wonder Island"}
            for i = 1, #oh2 do
                game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
                wait()
            end
        end
    end
end)

Buys:Toggle("自动买背包", "Auto Buy", false, function(state)
    Interstellar.buy = state
        if Interstellar.buy then
            while Interstellar.buy do
            local oh1 = "buyAllBelts"
            local oh2 = {"Ground", "Astral Island", "Space Island","Tundra Island", "Eternal Island", "Sandstorm", "Thunderstorm", "Ancient Inferno Island", "Midnight Shadow Island", "Mythical Souls Island", "Winter Wonder Island"}
            for i = 1, #oh2 do
                game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
                wait()
            end
        end
    end
end)

Buys:Toggle("自动买技能", "Auto Buy", false, function(state)
    Interstellar.buy = state
        if Interstellar.buy then
            while Interstellar.buy do
            local oh1 = "buyAllSkills"
            local oh2 = {"Ground", "Astral Island", "Space Island","Tundra Island", "Eternal Island", "Sandstorm", "Thunderstorm", "Ancient Inferno Island", "Midnight Shadow Island", "Mythical Souls Island", "Winter Wonder Island"}
            for i = 1, #oh2 do
                game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
                wait()
            end
        end
    end
end)

Buys:Toggle("自动买阶级", "Auto Buy", false, function(state)
    Interstellar.buy = state
        if Interstellar.buy then
            while Interstellar.buy do
            local oh1 = "buyRank"
            local oh2 = game:GetService("ReplicatedStorage").Ranks.Ground:GetChildren()
            for i = 1, #oh2 do
                game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
                wait()
            end
        end
    end
end)

Crystal:Dropdown("选择水晶", "Choose Crystal", crystalshow, function(Value)
    OpenCrystal = Value
end)

Crystal:Button("购买水晶", function()
game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", OpenCrystal)
end)

Crystal:Toggle("自动购买水晶", "Auto Buy", false, function(state)
    Interstellar.opencrystal = state
        if Interstellar.opencrystal then
            while Interstellar.opencrystal do
            game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", OpenCrystal)
            wait()
        end
    end
end)

PetShop:Dropdown("选择宠物", "Choose Pet", petshow, function(Value)
    BuyPetShop = Value
end)

PetShop:Button("购买宠物", function()
game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild(BuyPetShop))
end)

PetShop:Toggle("自动购买宠物", "Auto buy", false, function(state)
    Interstellar.petshop = state
    if Interstellar.petshop then
        while Interstellar.petshop do
            game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild(BuyPetShop))
            wait()
        end
    end
end)

Evolve:Toggle("自动进化","LS", false, function(state)
    Interstellar.petshop = state
    if Interstellar.evolvepet then
        while Interstellar.evolvepet do
            game:GetService("ReplicatedStorage").rEvents.autoEvolveRemote:InvokeServer("autoEvolvePets")
            wait()
        end
    end
end)

local toggleEnabled = false  
local selectedPlayer = "All" 
local dropdownOptions = {"All", "只吸敌人", "只吸队友"}  
local originalPositions = {}
local restoringPlayers = {}

for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        table.insert(dropdownOptions, player.Name)  
        originalPositions[player.Name] = player.Character and player.Character.HumanoidRootPart.Position or nil
    end
end

local attractSpeed = 1
local attractEffect = true
local attractMode = "Continuous"

Karmasteps2:Label("第一个All是吸所有人")
Karmasteps2:Label("取消，后只有被吸的玩家动才会复原")
Karmasteps2:Label("其他选项是选择目标单独吸，只吸敌人'和'只吸队友'是特殊选项")

local drop = Karmasteps2:Dropdown("选择目标", "Dropdown", dropdownOptions, function(selected)
    selectedPlayer = selected  
end)

local toggle = Karmasteps2:Toggle("开启吸人功能", "Tool", false, function(state)
    toggleEnabled = state 
    if not state then
        restoreOriginalPositions()
    end
end)

Karmasteps2:Slider("吸人速度", "Speed", 1, 1e9, 1, function(value)
    attractSpeed = value
end)

Karmasteps2:Toggle("启用吸人效果", "Effect", true, function(state)
    attractEffect = state
end)
Karmasteps2:Label("顺序:持续吸-吸一次")
Karmasteps2:Dropdown("吸人模式", "Mode", {"Continuous", "Instant"}, function(selected)
    attractMode = selected
end)

local function isEnemy(player)
    if game.Players.LocalPlayer.Team and player.Team then
        return game.Players.LocalPlayer.Team ~= player.Team
    else
        return true
    end
end

local function isTeammate(player)
    if game.Players.LocalPlayer.Team and player.Team then
        return game.Players.LocalPlayer.Team == player.Team
    else
        return false
    end
end

local function restoreOriginalPositions()
    for playerName, position in pairs(originalPositions) do
        local player = game.Players:FindFirstChild(playerName)
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            restoringPlayers[playerName] = true
            local startTime = tick()
            local startPosition = player.Character.HumanoidRootPart.Position
            local endPosition = position

            local connection
            connection = game:GetService('RunService').RenderStepped:Connect(function()
                local alpha = (tick() - startTime) * 5
                if alpha >= 1 then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(endPosition)
                    restoringPlayers[playerName] = nil
                    connection:Disconnect()
                else
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(startPosition:Lerp(endPosition, alpha))
                end
            end)
        end
    end
end

local function attractPlayers()
    for _, player in pairs(game.Players:GetPlayers()) do
        if toggleEnabled and not restoringPlayers[player.Name] then
            local shouldAttract = false

            if selectedPlayer == "All" then
                shouldAttract = true
            elseif selectedPlayer == "只吸敌人" then
                shouldAttract = isEnemy(player)
            elseif selectedPlayer == "只吸队友" then
                shouldAttract = isTeammate(player)
            else
                shouldAttract = (player.Name == selectedPlayer)
            end

            if player ~= game.Players.LocalPlayer and shouldAttract then
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    if not originalPositions[player.Name] then
                        originalPositions[player.Name] = character.HumanoidRootPart.Position
                    end

                    local targetPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 5

                    if attractMode == "Continuous" then
                        character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
                    elseif attractMode == "Instant" then
                        character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
                    end

                    if attractEffect then
                        local effect = Instance.new("Part")
                        effect.Size = Vector3.new(1, 1, 1)
                        effect.Position = character.HumanoidRootPart.Position
                        effect.Anchored = true
                        effect.CanCollide = false
                        effect.Transparency = 0.5
                        effect.BrickColor = BrickColor.new("Bright red")
                        effect.Parent = workspace
                        game:GetService("Debris"):AddItem(effect, 1)
                    end
                end
            end
        end
    end
end

game:GetService('RunService').RenderStepped:Connect(function()
    attractPlayers()
end)

game.Players.PlayerAdded:Connect(function(player)
    table.insert(dropdownOptions, player.Name)  
    drop:Refresh(dropdownOptions)  
    originalPositions[player.Name] = player.Character and player.Character.HumanoidRootPart.Position or nil
end)

Karmasteps2:Toggle("靠近自动攻击(必开)", "Toggle", false, function(state)
    if state then
        local connections = getgenv().configs and getgenv().configs.connections
        if connections then
            local Disable = getgenv().configs.Disable
            for _, v in pairs(connections) do
                v:Disconnect()
            end
            Disable:Fire()
            Disable:Destroy()
            table.clear(getgenv().configs)
        end

        local Disable = Instance.new("BindableEvent")
        getgenv().configs = {
            connections = {},
            Disable = Disable,
            Size = Vector3.new(10, 10, 10),
            DeathCheck = true
        }

        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local lp = Players.LocalPlayer
        local Run = true
        local Ignorelist = OverlapParams.new()
        Ignorelist.FilterType = Enum.RaycastFilterType.Include

        local function getchar(plr)
            plr = plr or lp
            return plr.Character
        end

        local function gethumanoid(plr)
            local char = plr:IsA("Model") and plr or getchar(plr)
            if char then
                return char:FindFirstChildWhichIsA("Humanoid")
            end
        end

        local function IsAlive(Humanoid)
            return Humanoid and Humanoid.Health > 0
        end

        local function GetTouchInterest(Tool)
            return Tool and Tool:FindFirstChildWhichIsA("TouchTransmitter", true)
        end

        local function GetCharacters(LocalPlayerChar)
            local Characters = {}
            for _, v in pairs(Players:GetPlayers()) do
                table.insert(Characters, getchar(v))
            end
            for i, char in pairs(Characters) do
                if char == LocalPlayerChar then
                    table.remove(Characters, i)
                    break
                end
            end
            return Characters
        end

        local function Attack(Tool, TouchPart, ToTouch)
            if Tool:IsDescendantOf(workspace) then
                Tool:Activate()
                firetouchinterest(TouchPart, ToTouch, 1)
                firetouchinterest(TouchPart, ToTouch, 0)
            end
        end

        table.insert(getgenv().configs.connections, Disable.Event:Connect(function()
            Run = false
        end))

        while Run do
            local char = getchar()
            if IsAlive(gethumanoid(char)) then
                local Tool = char and char:FindFirstChildWhichIsA("Tool")
                local TouchInterest = Tool and GetTouchInterest(Tool)

                if TouchInterest then
                    local TouchPart = TouchInterest.Parent
                    local Characters = GetCharacters(char)
                    Ignorelist.FilterDescendantsInstances = Characters
                    local InstancesInBox = workspace:GetPartBoundsInBox(TouchPart.CFrame, TouchPart.Size + getgenv().configs.Size, Ignorelist)

                    for _, v in pairs(InstancesInBox) do
                        local Character = v:FindFirstAncestorWhichIsA("Model")
                        if table.find(Characters, Character) then
                            if getgenv().configs.DeathCheck and IsAlive(gethumanoid(Character)) then
                                Attack(Tool, TouchPart, v)
                            elseif not getgenv().configs.DeathCheck then
                                Attack(Tool, TouchPart, v)
                            end
                        end
                    end
                end
            end
            RunService.Heartbeat:Wait()
        end
    else
        local Disable = getgenv().configs.Disable
        if Disable then
            Disable:Fire()
            Disable:Destroy()
        end

        for _, connection in pairs(getgenv().configs.connections) do
            connection:Disconnect()
        end
        table.clear(getgenv().configs.connections)
        Run = false
    end
end)

teleport:Button("传送到出生点", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(25.665502548217773, 3.4228405952453613, 29.919952392578125)
end)

teleport:Button("传送到附魔岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(51.17238235473633, 766.1807861328125, -138.44842529296875)
end)

teleport:Button("传送到星界岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(207.2932891845703, 2013.88037109375, 237.36672973632812)
end)

teleport:Button("传送到神秘岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(171.97178649902344, 4047.380859375, 42.0699577331543)
end)

teleport:Button("传送到太空岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.83824157714844, 5657.18505859375, 73.5014877319336)
end)

teleport:Button("传送到冻土岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139.28330993652344, 9285.18359375, 77.36406707763672)
end)

teleport:Button("传送到永恒岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(149.34817504882812, 13680.037109375, 73.3861312866211)
end)

teleport:Button("传送到沙暴岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(133.37144470214844, 17686.328125, 72.00334167480469)
end)

teleport:Button("传送到雷暴岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(143.19349670410156, 24070.021484375, 78.05432891845703)
end)

teleport:Button("传送到远古炼狱岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.27163696289062, 28256.294921875, 69.3790283203125)
end)

teleport:Button("传送到午夜暗影岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(132.74267578125, 33206.98046875, 57.495574951171875)
end)

teleport:Button("传送到神秘灵魂岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.76148986816406, 39317.5703125, 61.06639862060547)
end)

teleport:Button("传送到冬季奇迹岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.2720184326172, 46010.5546875, 55.941951751708984)
end)

teleport:Button("传送到黄金大师岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(128.32339477539062, 52607.765625, 56.69411849975586)
end)

teleport:Button("传送到龙传奇岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(146.35226440429688, 59594.6796875, 77.53300476074219)
end)

teleport:Button("传送到赛博传奇岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.3321075439453, 66669.1640625, 72.21722412109375)
end)

teleport:Button("传送到天岚超能岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.48077392578125, 70271.15625, 57.02311325073242)
end)

teleport:Button("传送到混沌传奇岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.58590698242188, 74442.8515625, 69.3177719116211)
end)

teleport:Button("传送到灵魂融合岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(136.9700927734375, 79746.984375, 58.54051971435547)
end)

teleport:Button("传送到黑暗元素岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.697265625, 83198.984375, 72.73107147216797)
end)

teleport:Button("传送到内心和平岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.3157501220703, 87051.0625, 66.78429412841797)
end)

teleport:Button("传送到炽烈漩涡岛", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.08216857910156, 91246.0703125, 69.56692504882812)
end)

teleport:Button("传送到35倍金币区域", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(86.2938232421875, 91245.765625, 120.54232788085938)
end)

teleport:Button("传送到复制宠物", function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4593.21337890625, 130.87181091308594, 1430.2239990234375)
end)

local Ninjitsu = Look:Label("忍术:"..game:GetService("Players").LocalPlayer.leaderstats.Ninjitsu.Value)
spawn(function()
    while wait() do
        pcall(function()
            Ninjitsu.Text = "忍术: " .. game:GetService("Players").LocalPlayer.leaderstats.Ninjitsu.Value
        end)
    end
end)

local Kills = Look:Label("杀戮:"..game:GetService("Players").LocalPlayer.leaderstats.Kills.Value)
spawn(function()
    while wait() do
        pcall(function()
            Kills.Text = "杀戮: " .. game:GetService("Players").LocalPlayer.leaderstats.Kills.Value
        end)
    end
end)

local Rank = Look:Label("阶级:"..game:GetService("Players").LocalPlayer.leaderstats.Rank.Value)
spawn(function()
    while wait() do
        pcall(function()
            Rank.Text = "阶级: " .. game:GetService("Players").LocalPlayer.leaderstats.Rank.Value
        end)
    end
end)

local Streak = Look:Label("条纹:"..game:GetService("Players").LocalPlayer.leaderstats.Streak.Value)
spawn(function()
    while wait() do
        pcall(function()
            Streak.Text = "条纹: " .. game:GetService("Players").LocalPlayer.leaderstats.Streak.Value
        end)
    end
end)

local Chi = Look:Label("气:"..game:GetService("Players").LocalPlayer.Chi.Value)
spawn(function()
    while wait() do
        pcall(function()
            Chi.Text = "气: " .. game:GetService("Players").LocalPlayer.Chi.Value
        end)
    end
end)

local Coins = Look:Label("硬币:"..game:GetService("Players").LocalPlayer.Coins.Value)
spawn(function()
    while wait() do
        pcall(function()
            Coins.Text = "硬币: " .. game:GetService("Players").LocalPlayer.Coins.Value
        end)
    end
end)

local Duels = Look:Label("决斗:"..game:GetService("Players").LocalPlayer.Duels.Value)
spawn(function()
    while wait() do
        pcall(function()
            Duels.Text = "决斗: " .. game:GetService("Players").LocalPlayer.Duels.Value
        end)
    end
end)

local Gems = Look:Label("宝石:"..game:GetService("Players").LocalPlayer.Gems.Value)
spawn(function()
    while wait() do
        pcall(function()
            Gems.Text = "宝石: " .. game:GetService("Players").LocalPlayer.Gems.Value
        end)
    end
end)

local Souls = Look:Label("灵魂:"..game:GetService("Players").LocalPlayer.Souls.Value)
spawn(function()
    while wait() do
        pcall(function()
            Souls.Text = "灵魂: " .. game:GetService("Players").LocalPlayer.Souls.Value
        end)
    end
end)

local Karma = Look:Label("业报:"..game:GetService("Players").LocalPlayer.Karma.Value)
spawn(function()
    while wait() do
        pcall(function()
            Karma.Text = "业报: " .. game:GetService("Players").LocalPlayer.Karma.Value
        end)
    end
end)

local Players = Copy:Dropdown("选择玩家", 'Dropdown', dropdown, function(v)
    playernamedied = v
end)

Copy:Button("重置", function()
    Refresh()
    Players:SetOptions(dropdown)
end)

Copy:Button("复制他/她的信息", function()
    local player = game:GetService("Players"):FindFirstChild(playernamedied)
    if player then
        local info = "名字: " .. player.Name .. "\n" ..
                     "忍术: " .. player.leaderstats.Ninjitsu.Value .. "\n" ..
                     "杀戮: " .. player.leaderstats.Kills.Value .. "\n" ..
                     "阶级: " .. player.leaderstats.Rank.Value .. "\n" ..
                     "条纹: " .. player.leaderstats.Streak.Value .. "\n" ..
                     "气: " .. player.Chi.Value .. "\n" ..
                     "硬币: " .. player.Coins.Value .. "\n" ..
                     "决斗: " .. player.Duels.Value .. "\n" ..
                     "宝石: " .. player.Gems.Value .. "\n" ..
                     "灵魂" .. player.Souls.Value .. "\n" ..
                     "业报" .. player.Karma.Value
        setclipboard(info)
    end
end)

------分割----------分割----
wait(1)
else
setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")
game.Players.LocalPlayer:Kick("煞笔你没进群吧❌")
end