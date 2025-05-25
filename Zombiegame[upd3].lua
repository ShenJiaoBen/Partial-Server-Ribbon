if "霖溺-僵尸游戏[更新3]" == LnScript then
-------------分割线------------------------分割线---------

---by霖溺

--开源上传 热度低的游戏不需要加密
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/KingScriptAE/No-sirve-nada./refs/heads/main/redz%20ui.lua"))()

local Window = redzlib:MakeWindow({
    Title = "僵尸游戏[更新3]",
    SubTitle = "by Linni666666",
    SaveFolder = "ZombieInfectionScript | redz lib v5.lua",
})

Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://109324145118343", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(35, 1) },
})

local Dialog = Window:Dialog({
    Title = "作者提示",
    Text = "账号封禁自己承担责任,请文明游戏",
    Options = {
        {"确定", function() end}
    }
})

local plrs = game:GetService("Players")
local Teams = game:GetService("Teams")
local TeleportService = game:GetService("TeleportService")
local rStor = game:GetService("ReplicatedStorage")
local living = workspace.LivingThings
local RunService = game:GetService("RunService")

local lplr = plrs.LocalPlayer
local char = lplr.Character or lplr.CharacterAdded:Wait()

local function GetHumRootPart(char)
    if char and char:FindFirstChild("HumanoidRootPart") then
        return char:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

local ChangelogTab = Window:MakeTab({"公告"})
local TeamsTab = Window:MakeTab({"队伍"})
local ItemsTab = Window:MakeTab({"物品"})
local WeaponsTab = Window:MakeTab({"武器"})
local ClientTab = Window:MakeTab({"本地功能"})
local ServerTab = Window:MakeTab({"服务器功能"})

ChangelogTab:AddDiscordInvite({
    Name = "霖溺脚本",
    Description = "加入QQ群",
    Logo = "rbxassetid://99599917888886",
    Invite = "http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231",
})

ChangelogTab:AddParagraph({"功能列表", [[
    + 击杀光环
    + 召唤僵尸
    + 解锁经典剑
    + 解锁消防斧
    + 获取铁剑
    + 变成僵尸
    + 变成人类
    + 服务器延迟
    + 生成地雷
    + 移除障碍物
    + 获取所有标志
    + 获取解毒剂
    + 获取彩虹药水
    + 让附近僵尸坐下
]]})
ChangelogTab:AddParagraph({"修复问题", [[
    + 修复让附近僵尸坐下功能的循环问题
    + 优化击杀光环的性能
    + 修复获取所有标志的逻辑错误
]]})

TeamsTab:AddButton({"变成人类", function()
    if lplr.Team == Teams.Human then
        print("提示, 你已经是人类了")
    else
        if lplr.Character and lplr.Character:FindFirstChildOfClass("Humanoid") then
            lplr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
        end
    end
end})

TeamsTab:AddButton({"变成僵尸", function()
    if lplr.Team == Teams.Zombie then
        print("提示, 你已经是僵尸了")
    else
        plrs:Chat(";zombie") 
    end
end})

ItemsTab:AddButton({"获取解毒剂", function()
    if not lplr:FindFirstChild("Antidote", true) and not char:FindFirstChild("Antidote", true) then 
        if workspace.Interaction.ToolGivers:FindFirstChild("Antidote") then
            fireclickdetector(workspace.Interaction.ToolGivers.Antidote.ClickDetector, 0)
        end
    else
        print("提示, 你已经有解毒剂了")
    end
end})

ItemsTab:AddButton({"获取彩虹药水", function()
    if not lplr:FindFirstChild("Rainbow Potion", true) and not char:FindFirstChild("Rainbow Potion", true) then
        if workspace.Interaction.ToolGivers:FindFirstChild("Rainbow Potion") then
            fireclickdetector(workspace.Interaction.ToolGivers["Rainbow Potion"].ClickDetector, 0)
        end
    else
        print("提示, 你已经有彩虹药水了")
    end
end})

ItemsTab:AddButton({"获取所有标志", function()
    local hasAllSigns = true
    
    if lplr.Team == Teams.Human then
        local signs = {"AntiZombieSign", "AntiZombieSign2", "AntiZombieSign3"}
        for _, sign in ipairs(signs) do
            if not lplr:FindFirstChild(sign, true) and not char:FindFirstChild(sign, true) then
                hasAllSigns = false
                break
            end
        end
    else
        local signs = {"AntiZombieSign", "AntiZombieSign2", "AntiZombieSign3", "ZombieSign", "ZombieSign2"}
        for _, sign in ipairs(signs) do
            if not lplr:FindFirstChild(sign, true) and not char:FindFirstChild(sign, true) then
                hasAllSigns = false
                break
            end
        end
    end

    if not hasAllSigns then
        local detectors = {
            workspace.Interaction.ToolGivers.AntiZombieSign.ClickDetector,
            workspace.Interaction.ToolGivers.AntiZombieSign2.ClickDetector,
            workspace.Interaction.ToolGivers.AntiZombieSign3.ClickDetector,
            workspace.Interaction.ZombieSign.ClickDetector
        }
        
        for _, detector in ipairs(detectors) do
            if detector then
                fireclickdetector(detector, 0)
                task.wait(0.1)
            end
        end
        print("成功", "已获取所有标志")
    else
        print("提示, 你已经有所有标志了")
    end
end})

WeaponsTab:AddButton({"解锁消防斧", function()
    if workspace.Interaction.UnlockedWeapons:FindFirstChild("Fire Axe") and 
       workspace.Interaction.UnlockedWeapons["Fire Axe"].head.Color ~= Color3.fromRGB(163,54,54) then
        if workspace.Interaction.Weapons:FindFirstChild("Fire Axe") then
            fireclickdetector(workspace.Interaction.Weapons["Fire Axe"].ClickDetector)
        end
    else
        print("提示, 你已解锁消防斧，可以在军械库找到")
    end
end})

WeaponsTab:AddButton({"解锁经典剑", function()
    if not workspace.Interaction.UnlockedWeapons:FindFirstChild("Classic Sword") then return end
    
    local checkPath = workspace.Interaction.UnlockedWeapons["Classic Sword"].ProximityPrompt
    
    if workspace.Interaction.Grave:FindFirstChild("Part") then
        workspace.Interaction.Grave.Part:Destroy()
    end

    if checkPath.ActionText ~= "Classic Sword" then
        local root = GetHumRootPart(lplr.Character)
        if root then
            root.CFrame = CFrame.new(-168.574799, 44.0623779, 88.8942108, -0.00475128274, -6.16009355e-10, 0.999988735, 1.60659113e-08, 1, 6.92350899e-10, -0.999988735, 1.60690181e-08, -0.00475128274)
            
            local startTime = tick()
            repeat
                if workspace.Interaction:FindFirstChild("SwordTouch") then
                    fireproximityprompt(workspace.Interaction.SwordTouch.ProximityPrompt)
                end
                task.wait()
            until checkPath.ActionText == "Classic Sword" or (tick() - startTime) > 10
            
            if root then
                root.CFrame = CFrame.new(-81.5, 22.5, 66, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            end
            print("成功, 已解锁经典剑")
        end
    else 
        print("提示, 你已解锁经典剑，可以在军械库找到")
    end
end})

WeaponsTab:AddButton({"获取铁剑", function()
    if not workspace.Interaction:FindFirstChild("Ironsword") then return end
    
    local CheckPath = workspace.Interaction.Ironsword.SwordCollectPieces
    local hasAllParts = CheckPath:FindFirstChild("StickCollect") and 
                       CheckPath:FindFirstChild("IronOre1") and 
                       CheckPath:FindFirstChild("IronOre2")

    if hasAllParts then
        fireclickdetector(CheckPath:WaitForChild("StickCollect"):WaitForChild("ClickDetector"))
        task.wait(0.1)
        fireclickdetector(CheckPath:WaitForChild("IronOre1"):WaitForChild("ClickDetector"))
        task.wait(0.1)
        fireclickdetector(CheckPath:WaitForChild("IronOre2"):WaitForChild("ClickDetector"))
        task.wait(0.1)
    end
    
    if workspace.Interaction.Ironsword:FindFirstChild("IronSword") then
        fireclickdetector(workspace.Interaction.Ironsword.IronSword:WaitForChild("ClickDetector"))
        print(hasAllParts and "成功" or "提示", hasAllParts and "已获取铁剑" or "你已经有铁剑了")
    end
end})

ClientTab:AddButton({"移除障碍物", function()
    local obstacles = {
        workspace.Interaction.ZombieDoor,
        workspace.Interaction.ZombieDoor2,
        workspace.Interaction.ZombieDoor3,
        workspace.Scripted.NoZombie.DisplayedBarrier,
        workspace.Scripted.NoZombie.ActualBarrier
    }
    
    local removed = 0
    for _, obstacle in ipairs(obstacles) do
        if obstacle then
            obstacle:Destroy()
            removed += 1
        end
    end
    
    print("成功", string.format("已移除%d个障碍物", removed))
end})

local lagging = false
local lagThreads = {}

local function stopLagging()
    lagging = false
    for _, thread in ipairs(lagThreads) do
        coroutine.close(thread)
    end
    table.clear(lagThreads)
end

local function lagServer(event, ...)
    if not event then return end
    
    lagging = true
    local args = {...}
    
    for i = 1, 8 do 
        local thread = coroutine.create(function()
            while lagging do
                pcall(function()
                    event:FireServer(unpack(args))
                end)
                task.wait()
            end
        end)
        table.insert(lagThreads, thread)
        coroutine.resume(thread)
    end
end

ServerTab:AddToggle({"服务器延迟", false, function(c)
    if c then
        if workspace.Interaction:FindFirstChild("PlayerPlaced") then
            workspace.Interaction.PlayerPlaced.Parent = nil
        end
        lagServer(rStor.NetworkEvents.RemoteEvent, "PLACE_LANDMINE")
    else
        stopLagging()
    end
end})

ServerTab:AddToggle({"服务器延迟(Necro版)", false, function(c)
    if c then
        lagServer(rStor.Remotes.ZombieRelated.Necro.AbilityPlayer)
    else
        stopLagging()
    end
end})

ServerTab:AddButton({"召唤僵尸", function()
    if rStor.Remotes.ZombieRelated.Necro:FindFirstChild("AbilityPlayer") then
        rStor.Remotes.ZombieRelated.Necro.AbilityPlayer:FireServer()
        print("成功, 已召唤僵尸")
    end
end})

ServerTab:AddButton({"生成地雷", function()
    if rStor.NetworkEvents:FindFirstChild("RemoteEvent") then
        rStor.NetworkEvents.RemoteEvent:FireServer("PLACE_LANDMINE")
        print("成功, 已生成地雷")
    end
end})

ServerTab:AddToggle({"卸载实体", false, function(c)
    if lplr.Character then
        lplr.Character.Parent = c and workspace or living
    end
    
    if c then
        living.Parent = nil
    else
        living.Parent = workspace
    end
end})

local sitZombies = false
local sitZombiesConnection = nil

ServerTab:AddToggle({"让附近僵尸坐下", false, function(v)
    sitZombies = v
    
    if sitZombiesConnection then
        sitZombiesConnection:Disconnect()
        sitZombiesConnection = nil
    end
    
    if sitZombies then
        sitZombiesConnection = RunService.Heartbeat:Connect(function()
            for _, zombie in ipairs(living:GetChildren()) do
                if zombie:FindFirstChild("Humanoid") and 
                   (zombie.Humanoid.DisplayName == "Npc" or zombie.Humanoid.DisplayName == "Summoned Zombie") then
                    zombie.Humanoid.Sit = true
                end
            end
        end)
    end
end})

local killAura = false
local killAuraConnection = nil

ServerTab:AddToggle({"杀戮光环", false, function(c)
    killAura = c
    
    if killAuraConnection then
        killAuraConnection:Disconnect()
        killAuraConnection = nil
    end
    
    if killAura then
        killAuraConnection = RunService.Heartbeat:Connect(function()
            if not lplr.Character or not lplr.Character:FindFirstChildWhichIsA("Tool") then return end
            
            local event = lplr.Team == Teams.Zombie and rStor.Remotes.ZombieRelated.PlayerAttack or rStor.Remotes.Melee.Damage
            local characterRoot = lplr.Character:FindFirstChild("HumanoidRootPart")
            if not characterRoot then return end
            
            local characterPos = characterRoot.Position
            local eventC = 0
            
            for _, target in ipairs(living:GetChildren()) do
                if target:GetAttribute("Team") and target:GetAttribute("Team") ~= lplr.Character:GetAttribute("Team") then
                    local hum = target:FindFirstChildWhichIsA("Humanoid")
                    local rootPart = hum and hum:FindFirstChild("RootPart")
                    
                    if hum and hum.Health > 0 and rootPart then
    
                        if (rootPart.Position - characterPos).Magnitude <= 10 and eventC < 100 then
                            eventC = eventC + 1
                            event:InvokeServer(rootPart)
                            eventC = eventC - 1
                        end
                    end
                end
            end
        end)
    end
end})

wait(1)
else
setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")
game.Players.LocalPlayer:Kick("你没进群/没复制全吧❌")
end