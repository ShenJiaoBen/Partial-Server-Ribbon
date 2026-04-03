if "霖溺-被遗弃" == LnScript then
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()


local Options = Library.Options
local Toggles = Library.Toggles

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")


if not table.clone then
    table.clone = function(t)
        local nt = {}
        for k,v in pairs(t) do nt[k] = v end
        return nt
    end
end

Library.ShowToggleFrameInKeybinds = true 
Library.ShowCustomCursor = true
Library.NotifySide = "Right"

local Window = Library:CreateWindow({
    Title = 'LinniScript | 被遗弃',
    Footer = "作者[霖溺] / 免费",
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    NotifySide = "Right",
    TabPadding = 8,
    MenuFadeTime = 0
})

local Tabs = {
    new = Window:AddTab('公告', 'user'),
    Main = Window:AddTab('快捷功能区','house'),
    Aimbot = Window:AddTab('自瞄区','earth'),
    Esp = Window:AddTab('绘制区','eye'),
    tzq = Window:AddTab('通知提示','eye'),
    ani = Window:AddTab('反效果区','earth'),
    Max = Window:AddTab('误乐区','file'),
    mh = Window:AddTab('美化区','earth'),
    Sat = Window:AddTab('体力区','moon'),
    zdg = Window:AddTab('自动格挡','file'),    
    zdx = Window:AddTab('自动修机','file'),
    lol = Window:AddTab('技能区','earth'),
    Teleport = Window:AddTab("TP", "sticker"),    
    ["UI Settings"] = Window:AddTab('UI设置', 'settings')
}
local JHh = Tabs.mh:AddLeftGroupbox('杀手')
local JHp = Tabs.mh:AddLeftGroupbox('幸存者')

JHp:AddButton({
	Text = '谢德-美化1',
	Func = function()
local player = game.Players.LocalPlayer  
local character = player.Character or player.CharacterAdded:Wait()

local shirt = character:FindFirstChildOfClass("Shirt") or Instance.new("Shirt", character)
shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=14248399102"

local pants = character:FindFirstChildOfClass("Pants") or Instance.new("Pants", character)
pants.PantsTemplate = "http://www.roblox.com/asset/?id=14248410313"

local head = character:FindFirstChild("Head")
if head then
    local face = head:FindFirstChild("face")
    if face then
        face:Destroy()
    end
    local function addAccessory(name, meshId, textureId, parentPartName, handleSize, position, rotation, customWeldC0, customWeldC1, meshScale, meshOffset)
        local accessory = Instance.new("Accessory")
        accessory.Name = name
        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(unpack(handleSize))
        handle.CanCollide = false
        handle.Anchored = false
        handle.Parent = accessory
        local mesh = Instance.new("SpecialMesh", handle)
        mesh.MeshId = meshId
        if textureId ~= "" then
            mesh.TextureId = textureId
        end
        if meshScale then
            mesh.Scale = Vector3.new(unpack(meshScale))
        else
            mesh.Scale = Vector3.new(0.65, 0.65, 0.65)
        end
        if meshOffset then
            mesh.Offset = Vector3.new(unpack(meshOffset))
        else
            mesh.Offset = Vector3.new(0, -0.55, 0)
        end
        local targetPart = character:FindFirstChild(parentPartName)
        if not targetPart then
            warn("Target part '" .. parentPartName .. "' not found in character!")
            return
        end
        local weld = Instance.new("Weld")
        weld.Part0 = targetPart
        weld.Part1 = handle
        if customWeldC0 and customWeldC1 then
            weld.C0 = CFrame.new(unpack(customWeldC0))
            weld.C1 = CFrame.new(unpack(customWeldC1))
        else
            weld.C0 = CFrame.new(unpack(position)) * CFrame.Angles(math.rad(rotation[1]), math.rad(rotation[2]), math.rad(rotation[3]))
        end
        weld.Parent = handle
        accessory.Parent = character
    end
    addAccessory("Face", "rbxassetid://110562243236643", "rbxassetid://92220809340639", "Head", {1,1,1}, {0,0.55,0}, {0,180,0}, nil, nil, {1,1,1}, nil)
end

local function addAccessory(name, meshId, textureId, parentPartName, handleSize, position, rotation, customWeldC0, customWeldC1, meshScale, meshOffset)
    local accessory = Instance.new("Accessory")
    accessory.Name = name
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(unpack(handleSize))
    handle.CanCollide = false
    handle.Anchored = false
    handle.Parent = accessory
    local mesh = Instance.new("SpecialMesh", handle)
    mesh.MeshId = meshId
    if textureId ~= "" then
        mesh.TextureId = textureId
    end
    if meshScale then
        mesh.Scale = Vector3.new(unpack(meshScale))
    else
        mesh.Scale = Vector3.new(0.65, 0.65, 0.65)
    end
    if meshOffset then
        mesh.Offset = Vector3.new(unpack(meshOffset))
    else
        mesh.Offset = Vector3.new(0, -0.55, 0)
    end
    local targetPart = character:FindFirstChild(parentPartName)
    if not targetPart then
        warn("Target part '" .. parentPartName .. "' not found in character!")
        return
    end
    local weld = Instance.new("Weld")
    weld.Part0 = targetPart
    weld.Part1 = handle
    if customWeldC0 and customWeldC1 then
        weld.C0 = CFrame.new(unpack(customWeldC0))
        weld.C1 = CFrame.new(unpack(customWeldC1))
    else
        weld.C0 = CFrame.new(unpack(position)) * CFrame.Angles(math.rad(rotation[1]), math.rad(rotation[2]), math.rad(rotation[3]))
    end
    weld.Parent = handle
    accessory.Parent = character
end

addAccessory(
    "Blade",
    "rbxassetid://18116147526",
    "rbxassetid://18955600612",
    "Right Arm",
    {1, 1, 1},
    {-0.5, -1.1, -3.3},
    {180, -100, 0},
    nil, nil,
    {1, 1, 1},
    nil
)

addAccessory(
    "Helmet",
    "rbxassetid://13252936277",
    "rbxassetid://13252949489",
    "Head",
    {1, 1, 1},
    {0, 0.8, 0},
    {0, 0, 0},
    nil, nil,
    {1.1, 1, 1},
    nil
)

addAccessory(
    "Scarf",
    "rbxassetid://7459110498",
    "rbxassetid://7543326394",
    "Torso",
    {1, 1, 1},
    {0, 1.4, 0},
    {0, 0, 0},
    nil, nil,
    {1, 1, 1},
    nil
)

addAccessory(
    "LeftSleeve",
    "rbxassetid://14886992040",
    "rbxassetid://14887049482",
    "Left Arm",
    {1, 1, 1},
    {0, 1.2, 0},
    {0, 0, 0},
    nil, nil,
    {0.15, 0.15, 0.15},
    nil
)

addAccessory(
    "Hair",
    "rbxassetid://7666931987",
    "rbxassetid://7066058408",
    "Head",
    {1, 1, 1},
    {0, -1.3, 1.3},
    {0, 0, 0},
    nil, nil,
    {1, 1, 1},
    nil
)

addAccessory(
    "RightSleeve",
    "rbxassetid://7265541707",
    "rbxassetid://7265983163",
    "Right Arm",
    {1, 1, 1},
    {0.25, 1.5, 0},
    {0, 0, 0},
    nil, nil,
    {1, 1, 1},
    nil
)

local shedletsky = workspace.Players.Survivors:FindFirstChild("Shedletsky")
if shedletsky then
    local expressionHolder = shedletsky:FindFirstChild("ExpressionHolder")
    if expressionHolder then
        expressionHolder:Destroy()
    end
    local shedHair = shedletsky:FindFirstChild("ShedHair")
    if shedHair then
        shedHair:Destroy()
    end
    local sword = shedletsky:FindFirstChild("Sword")
    if sword then
        sword:Destroy()
    end
end
end
})



JHh:AddButton({
	Text = 'CoII-黑手党',
	Func = function()
local oldassets = require(game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiasoC00l.Config)
game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiasoC00l.Config:Destroy() game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd["#MafiosoC00l"].Config:Clone().Parent = game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiasoC00l
game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiasoC00l.Behavior:Destroy() game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd["#MafiosoC00l"].Behavior:Clone().Parent = game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiasoC00l
game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd["#MafiosoC00l"].CameraRig:Clone().Parent = game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiasoC00l
game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd["#MafiosoC00l"].Behavior2:Clone().Parent = game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiasoC00l
local rigsource = game:GetObjects("rbxassetid://100745570500653")[1]
rigsource.Parent = game.ReplicatedStorage
local emoteTrack
local emoteSound1
local emoting = false
local assets = require(game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd["#MafiosoC00l"].Config)
local minions = assets.Mafiasos
local emoteButton
local fakeEmoteButton

function GetDescendants(tbl)
    local currentTbl = {}
    for i, v in pairs(tbl) do
        if type(v) == "table" then
            for ind, val in pairs(GetDescendants(v)) do
                table.insert(currentTbl, val)
            end
        else
            table.insert(currentTbl, v)
        end
    end
    return currentTbl
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.G then
		emoting = false
		if emoteTrack then
			emoteTrack:Stop()
			emoteSound1:Stop()
		end
	end
end)

function setup()
	local rig = rigsource:Clone()
	rig.Parent = game.Players.LocalPlayer.Character
	local parttable = {}
	for i, v in ipairs(rig:GetChildren()) do
		if v:IsA("BasePart") then
			if v.Name ~= "HumanoidRootPart" then
				table.insert(parttable, {["Original"] = game.Players.LocalPlayer.Character:FindFirstChild(v.Name), ["new"] = v})
			end
		end
	end
	game.Players.LocalPlayer.Character["Left Arm"].WalkieTalkie.Part0 = game.Players.LocalPlayer.Character["Right Arm"]
	for i, v in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if v:IsA("BasePart") and not v:FindFirstAncestor("Mafioso") then
			if v.Name ~= "firebrand" and v.Name ~= "WalkieTalkie" then
					v.Transparency = 1
					v.Changed:Connect(function(str)
						if str == "Transparency" then
							v.Transparency = 1
						end
					end)
				end
		end
	end
	for i, v in ipairs(parttable) do
		local weld = Instance.new("Weld")
		weld.Parent = v["new"]
		weld.Part0 = v["new"]
		weld.Part1 = v["Original"]
	end
	connection = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(v)
		if active then
			if v:IsA("Sound") and table.find(GetDescendants(assets.Voicelines), v.SoundId)  then
				v:Destroy()
			end
		else
			connection:Disconnect()
		end
	end)
	game.Players.LocalPlayer.Character.Changed:Connect(function(str)
		if str == "Parent" then
			rig:Destroy()
		end
	end)
	game.Players.LocalPlayer.Character.Humanoid.AnimationPlayed:Connect(function(track)
		if track.Animation.AnimationId == "rbxassetid://80139543732416" then
			local anim = Instance.new("Animation") anim.AnimationId = "rbxassetid://117334224937914"
			local Track = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(anim)
			Track.Priority = Enum.AnimationPriority.Action4
			Track:Play()
			Track:AdjustSpeed(Track.Length/3.875)
		end
	end)
end

function playSound(SoundId, Volume, Parent, Loop)
	local sound = Instance.new("Sound", Parent)
	sound.SoundId = SoundId
	sound.Volume = Volume
	sound.Looped = Loop
	sound:Play()
	return sound
end

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
	if char.Name == "c00lkidd" and game.Players.LocalPlayer.PlayerData.Equipped.Skins.c00lkidd.Value == "MafiasoC00l" then
		print("activated")
		active = true
--		task.wait(0.25)
		task.spawn(setup)
	else
		print("unactivated")
		active = false
	end
	wait(0.1)
	for i, v in ipairs(game.Players.LocalPlayer.PlayerGui.TopbarStandard.Holders.Left:GetChildren()) do
		if v.Name == "Widget" then
			if v.IconButton.Menu.IconSpot.Contents.IconLabelContainer.IconLabel.Text == "Emote" then
				emoteButton = v
				fakeEmoteButton = emoteButton:Clone()
				fakeEmoteButton.Name = 'fake'
				print(v.IconButton.Menu.IconSpot.Contents.IconLabelContainer.IconLabel.Text)
			else
				print(v.IconButton.Menu.IconSpot.Contents.IconLabelContainer.IconLabel.Text)
			end
		else
			print(v.Name)
		end
	end

	if fakeEmoteButton then
		fakeEmoteButton.IconButton.Menu.IconSpot.ClickRegion.MouseButton1Down:Connect(function()
			emoting = false
			if emoteTrack then
				emoteTrack:Stop(0)
				emoteSound1:Stop()
			end
		end)
	end
end)

local hook;
hook = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
       local args = {...}
       if self == game.ReplicatedStorage.Modules.Network.RemoteEvent then
       	if not checkcaller() and getnamecallmethod() == "FireServer" or getnamecallmethod() == "InvokeServer"  then
            	if args[3] == "Snap" then
            		if args[1] == "PlayEmote" then
            			emoting = true
            			local anim = Instance.new("Animation") anim.AnimationId = assets.Emotes.Animations.Snap.AssetID
            			emoteTrack = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(anim)
            			emoteTrack.Looped = true
            			emoteTrack.Priority = Enum.AnimationPriority.Action4
            			emoteTrack:Play(0)
            			emoteSound1 = playSound(assets.Emotes.Animations.Snap.SFX, 0.5, game.Players.LocalPlayer.Character.PrimaryPart, true)
						if emoteButton then
							emoteButton.Parent = game.ReplicatedStorage
						end
						if fakeEmoteButton then
							fakeEmoteButton.Parent = game.Players.LocalPlayer.PlayerGui.TopbarStandard.Holders.Left
						end
						local char = game.Players.LocalPlayer.Character
            			repeat
            				task.wait()
            				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 6
            			until emoting == false or char.Parent == nil
            			print("stopped")
            			emoting = false
            			fakeEmoteButton.Parent = game.ReplicatedStorage
            			if emoteButton then
							emoteButton.Parent = game.Players.LocalPlayer.PlayerGui.TopbarStandard.Holders.Left
						end
            		end
            	end
       	end
       end
       return hook(self, ...)
end))

game:GetService("UserInputService").InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.G then
		emoting = false
		if emoteTrack then
			emoteTrack:Stop()
			emoteSound1:Stop()
		end
	end
end)

workspace.Map.Ingame.ChildAdded:Connect(function(v)
	if active then
		if string.find(v.Name, "Mafiaso") then
			local died = false
			local minion = minions[math.random(1, 4)]
			minion = minion:Clone()
			minion.Parent = workspace
			for i, val in ipairs(v:GetDescendants()) do
				if val:IsA("BasePart") then
					val.Transparency = 1
					val.Changed:Connect(function(str)
						if str == "Transparency" then
							local trans = val.Transparency
							val.Transparency = 1
						end
					end)
				elseif val:IsA("Decal") then
					val.Transparency = 1
				elseif val:IsA("SelectionBox") then
					if minion:FindFirstChild(val.Parent.Name) then
						val.Adornee = minion:FindFirstChild(val.Parent.Name)
					end
				end
			end
			v.DescendantAdded:Connect(function(val)
				if val:IsA("BasePart") then
					val.Transparency = 1
					val.Changed:Connect(function(str)
						if str == "Transparency" then
							local trans = val.Transparency
							val.Transparency = 1
						end
					end)
				elseif val:IsA("Decal") then
					val.Transparency = 1
				elseif val:IsA("SelectionBox") then
					if minion:FindFirstChild(val.Parent.Name) then
						val.Adornee = minion:FindFirstChild(val.Parent.Name)
					end
				end
			end)
			task.spawn(function()
				repeat
					task.wait()
					if v.Parent ~= nil then
						minion.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
					end
				until v.Parent == nil
				minion:Destroy()
			end)
			v:WaitForChild("Humanoid")
			local idleanim = Instance.new("Animation")
			idleanim.AnimationId = assets.PizzaDeliveryAnimations.Idle
			idleanim = minion.Humanoid.Animator:LoadAnimation(idleanim)
			idleanim.Looped = true
			local runanim = Instance.new("Animation")
			runanim.AnimationId = assets.PizzaDeliveryAnimations.Walk
			runanim = minion.Humanoid.Animator:LoadAnimation(runanim)
			runanim.Looped = true
			v:FindFirstChildOfClass("Humanoid").AnimationPlayed:Connect(function(track)
				if track.Animation.AnimationId == oldassets.PizzaDeliveryAnimations.Hit then
					local anim = Instance.new("Animation")
					anim.AnimationId = assets.PizzaDeliveryAnimations.Hit
					anim = minion.Humanoid.Animator:LoadAnimation(anim)
					runanim:Stop()
					anim:Play()
				end
			end)
			local introanim = Instance.new("Animation")
			introanim.AnimationId = assets.PizzaDeliveryAnimations.Summoned
			introanim = minion.Humanoid.Animator:LoadAnimation(introanim)
			introanim:Play()
			introanim.Stopped:Wait()
			idleanim:Play()
			v:FindFirstChildOfClass("Humanoid").AnimationPlayed:Wait()
			idleanim:Stop()
			runanim:Play()			
		elseif v.Name == "Bunny" then
			v:WaitForChild("Head").Transparency = 1
			v.Head:WaitForChild("Classic Default Face").Transparency = 1
			v:WaitForChild("Torso").Transparency = 1
			v:WaitForChild("Wedge").Transparency =1
			local suitcase = game.ReplicatedStorage.Assets.Instances.SuitcaseBase:Clone()
			suitcase.Anchored = false
			suitcase.Massless = true
			suitcase.Parent = v
			local weld = Instance.new("Weld")
			weld.Parent = suitcase
			weld.Part0 = suitcase
			weld.Part1 = v.Torso
		end
	end
end)
end
})
local jjl = Tabs.mh:AddLeftGroupbox('关于')
jjl:AddLabel("弄美化很浪费时间，所以就出了这两个")

local bbpv = Tabs.Teleport:AddRightGroupbox("屠服")
local LocalPlayer = game.Players.LocalPlayer
local teleporting = false 

local whitelist = {}

bbpv:AddDropdown("WhitelistDropdown", {
    Values = {}, 
    Multi = true, 
    Text = "白名单玩家",
    Tooltip = "选择不传送的玩家",
    Callback = function(selectedPlayers)
        whitelist = selectedPlayers 
    end
})

local function updateWhitelistOptions()
    local playerNames = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(playerNames, player.Name)
        end
    end
    Options.WhitelistDropdown:SetValues(playerNames)
end

game.Players.PlayerAdded:Connect(updateWhitelistOptions)
game.Players.PlayerRemoving:Connect(updateWhitelistOptions)
updateWhitelistOptions() 

local function teleportLoop()
    while teleporting do
        local survivors = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivors then
            local playerList = {}

            for _, obj in ipairs(survivors:GetChildren()) do
                if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
                    local player = game.Players:GetPlayerFromCharacter(obj)
                    if player and not whitelist[player.Name] then
                        table.insert(playerList, obj.HumanoidRootPart)
                    end
                end
            end

            if #playerList > 0 then
                local targetHRP = playerList[math.random(1, #playerList)]
                local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                if myHRP and targetHRP then
                    myHRP.CFrame = targetHRP.CFrame
                end
            end
        end

        task.wait(0) 
    end
end

bbpv:AddToggle("AutoPickupToggle", {
    Text = "启动",
    Tooltip = "自动传送到最近的玩家（白名单除外）",
    Default = false,  
    Disabled = false,
    Visible = true,
    Risky = false,

    Callback = function(state)
        teleporting = state
        if state then
            task.spawn(teleportLoop) 
        end
    end
})

local _env = getgenv and getgenv() or {}
local _hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

local newTab = Tabs.new
local rightBox = newTab:AddRightGroupbox('最新公告')
local leftBox = newTab:AddLeftGroupbox('')

leftBox:AddLabel("  霖溺脚本 ")
leftBox:AddLabel("----------------------------------")
leftBox:AddLabel("   状态:永久免费  ")
leftBox:AddLabel("   更新:2026.2.4  ")
leftBox:AddLabel("     ")
leftBox:AddLabel("----------------------------------")
leftBox:AddLabel("   大群:744830231  ")
leftBox:AddLabel("   二群:443185741  ")
leftBox:AddLabel("   四群:763298019  ")
leftBox:AddLabel("----------------------------------")


rightBox:AddLabel("  高级功能说明:")
rightBox:AddLabel("----------------------------------")
rightBox:AddLabel("  智能自瞄系统:")
rightBox:AddLabel("   - 自动锁定最近目标")
rightBox:AddLabel("   - 可调节FOV范围")
rightBox:AddLabel("   - 支持掩体检测")
rightBox:AddLabel("----------------------------------")
rightBox:AddLabel("  透视穿墙:")
rightBox:AddLabel("   - 显示敌人骨骼")
rightBox:AddLabel("   - 显示物品位置")
rightBox:AddLabel("   - 自定义透视颜色")
rightBox:AddLabel("----------------------------------")
rightBox:AddLabel("  性能优化:")
rightBox:AddLabel("   - 低资源占用")
rightBox:AddLabel("   - 防检测机制")
rightBox:AddLabel("   - 自动更新系统")
rightBox:AddLabel("----------------------------------")

local infoBox = newTab:AddLeftGroupbox('使用说明')
infoBox:AddLabel(" 使用前请阅读:")
infoBox:AddLabel("1. 按INSERT键显示/隐藏菜单")
infoBox:AddLabel("2. 按DELETE键紧急关闭脚本")
infoBox:AddLabel("3. 建议在窗口模式下使用")
infoBox:AddLabel("4. 遇到问题请反馈给开发者")

local bottomBorder = newTab:AddRightGroupbox('')
bottomBorder:AddLabel("═════════════════════════════════")
bottomBorder:AddLabel("感谢使用霖溺脚本 - 祝您游戏愉快！")
bottomBorder:AddLabel("═════════════════════════════════")

local KillerSurvival = Tabs.Main:AddLeftGroupbox("调节功能")

game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if _env.NoStun == true and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed < 16 then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if _env.NoStun == true and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed < 16 then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end)
end)

KillerSurvival:AddToggle("NS",{
    Text = "去除前摇 后摇 缓慢动作",
    Callback = function(v)
        _env.NoStun = v
    end
})

KillerSurvival:AddDivider()

KillerSurvival:AddSlider("SB",{
    Text = "速度调节",
    Min = 0, Max = 3,
    Default = 1, Compact = true,
    Rounding = 1,
    Callback = function(v)
        _env.SpeedBoostValue = v
    end
})

_env.SpeedBoostValue = 1

KillerSurvival:AddToggle("SB",{
    Text = "启用速度",
    Callback = function(v)
        _env.SpeedBoost = v
        while _env.SpeedBoost do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame += game.Players.LocalPlayer.Character.Humanoid.MoveDirection * _env.SpeedBoostValue
            game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = true
            task.wait()
        end
    end
})

KillerSurvival:AddToggle('MyToggle', {
    Text = '显示聊天框丨需要每局开一次',
    Default = false,
    Tooltip = '显示聊天框',
    Callback = function(state)
    if state then
    game.TextChatService.ChatWindowConfiguration.Enabled = true
    else
    game.TextChatService.ChatWindowConfiguration.Enabled = false    
    end
    end
})


local MainTabbox = Tabs.Main:AddRightTabbox()
local Lighting = MainTabbox:AddTab("亮度调节")

Lighting:AddSlider("B",{
    Text = "亮度数值",
    Min = 0,
    Default = 0,
    Max = 3,
    Rounding = 1,
    Compact = true,
    Callback = function(v)
        _env.Brightness = v
    end
})

Lighting:AddToggle("无阴影",{
    Text = "无阴影",
    Default = false,
    Callback = function(v)
        _env.GlobalShadows = v
    end
})

Lighting:AddToggle("除雾",{
    Text = "除雾",
    Default = false,
    Callback = function(v)
        _env.NoFog = v
    end
})

Lighting:AddDivider()

Lighting:AddToggle("启用功能",{
    Text = "启用",
    Default = false,
    Callback = function(v)
        _env.Fullbright = v
        game:GetService("RunService").RenderStepped:Connect(function()
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
            
            if _env.Fullbright then
                game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
                game.Lighting.Brightness = _env.Brightness or 0
                game.Lighting.GlobalShadows = not _env.GlobalShadows
            else
                game.Lighting.OutdoorAmbient = Color3.fromRGB(55,55,55)
                game.Lighting.Brightness = 0
                game.Lighting.GlobalShadows = true
            end
        end)
    end
    
})



local ZZ = Tabs.Main:AddRightGroupbox('自动拾取物品')


ZZ:AddToggle('医疗包传送并拾取', {
    Text = '医疗包传送并互动',
    Default = false,
    Tooltip = '自动将医疗包传送到自己位置并互动',
    
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
                                       
                                        itemRoot.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * 3
                                        
                                       
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


ZZ:AddToggle('可乐传送并拾取', {
    Text = '可乐传送并互动',
    Default = false,
    Tooltip = '自动将可乐传送到自己位置并互动',
    
    Callback = function(state)
        autoTeleportColaEnabled = state
        
        if autoTeleportColaEnabled then
            teleportColaThread = task.spawn(function()
                while autoTeleportColaEnabled and task.wait(0.5) do
                    -- 获取玩家角色
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local humanoidRootPart = character.HumanoidRootPart
                        
                        -- 查找可乐
                        local cola = workspace:FindFirstChild("Map", true)
                        if cola then
                            cola = cola:FindFirstChild("Ingame", true)
                            if cola then
                                cola = cola:FindFirstChild("BloxyCola", true)
                                if cola then
                                    local itemRoot = cola:FindFirstChild("ItemRoot", true)
                                    if itemRoot then
                                        -- 将可乐传送到玩家前方3个单位的位置
                                        itemRoot.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * 3
                                        
                                        -- 查找互动提示并触发
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



ZZ:AddToggle('自动拾取医疗包', {
    Text = '自动互动医疗包',
    Default = false,
    Tooltip = '自动与医疗包互动',
    
    Callback = function(state)
        autoMedkitEnabled = state
        
        if autoMedkitEnabled then
            medkitThread = task.spawn(function()
                while autoMedkitEnabled and task.wait(0.5) do
                    local medkit = workspace:FindFirstChild("Map", true)
                    if medkit then
                        medkit = medkit:FindFirstChild("Ingame", true)
                        if medkit then
                            medkit = medkit:FindFirstChild("Medkit", true)
                            if medkit then
                                local itemRoot = medkit:FindFirstChild("ItemRoot", true)
                                if itemRoot then
                                    local prompt = itemRoot:FindFirstChild("ProximityPrompt", true)
                                    if prompt then
                                        fireproximityprompt(prompt)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        elseif medkitThread then
            task.cancel(medkitThread)
            medkitThread = nil
        end
    end
})


ZZ:AddToggle('自动拾取可乐', {
    Text = '自动互动可乐',
    Default = false,
    Tooltip = '自动与可乐互动',
    
    Callback = function(state)
        autoColaEnabled = state
        
        if autoColaEnabled then
            colaThread = task.spawn(function()
                while autoColaEnabled and task.wait(0.5) do
                    local cola = workspace:FindFirstChild("Map", true)
                    if cola then
                        cola = cola:FindFirstChild("Ingame", true)
                        if cola then
                            cola = cola:FindFirstChild("BloxyCola", true)
                            if cola then
                                local itemRoot = cola:FindFirstChild("ItemRoot", true)
                                if itemRoot then
                                    local prompt = itemRoot:FindFirstChild("ProximityPrompt", true)
                                    if prompt then
                                        fireproximityprompt(prompt)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        elseif colaThread then
            task.cancel(colaThread)
            colaThread = nil
        end
    end
})


local Camera = MainTabbox:AddTab("视野")
Camera:AddSlider("视野范围",{
    Text = "调节范围",
    Min = 70,Default = 70,
    Max = 120,Rounding = 1,
    Compact = true,
    Callback = function(v)
        _env.FovValue = v
    end
})

_G.FovValue = 70

Camera:AddToggle("应用范围",{
    Text = "应用",
    Callback = function(v)
        _env.FOV = v
        game:GetService("RunService").RenderStepped:Connect(function()
            if _env.FOV then
                workspace.Camera.FieldOfView = _env.FovValue
            end
        end)
    end
})


local Size = 5
local speed = 1
local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local rootPart = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")


local function aimbot1x1x1x1(state)
    local aimbot1x1sounds = {
        "rbxassetid://79782181585087",
        "rbxassetid://128711903717226"
    }
    
    aimbot1x1 = state
    
    if game:GetService("Players").LocalPlayer.Character.Name ~= "1x1x1x1" and state then
        Library:Notify("你的角色不是1x4，无法生效", nil, 4590657391)
        return 
    end

    if state then
        aimbot1x1loop = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
            if not aimbot1x1 then return end
            for _, v in pairs(aimbot1x1sounds) do
                if child.Name == v then
                    local survivors = {}
                    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= game:GetService("Players").LocalPlayer then
                            local character = player.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                table.insert(survivors, character)
                            end
                        end
                    end

                    local nearestSurvivor = nil
                    local shortestDistance = math.huge  
                    
                    for _, survivor in pairs(survivors) do
                        local survivorHRP = survivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestSurvivor = survivor
                            end
                        end
                    end
                    
                    if nearestSurvivor then
                        local nearestHRP = nearestSurvivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local direction = (nearestHRP.Position - playerHRP.Position).Unit
                            local num = 1
                            local maxIterations = 100 
                            
                            while num <= maxIterations do
                                task.wait(0.01)
                                num = num + 1
                                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                                playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                            end
                        end
                    end
                end
            end
        end)
    else
        if aimbot1x1loop then
            aimbot1x1loop:Disconnect()
            aimbot1x1loop = nil
        end
    end
end

-- 酷小孩角色自瞄
local function cool(state)
    local coolsounds = {
        "rbxassetid://111033845010938",
        "rbxassetid://106484876889079"
    }
    
    cool = state

    if game:GetService("Players").LocalPlayer.Character.Name ~= "c00lkidd" and state then
        Library:Notify("你的角色不是c00lkidd，无法生效", nil, 4590657391)
        return 
    end

    if state then
        coolloop = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
            if not cool then return end
            for _, v in pairs(coolsounds) do
                if child.Name == v then
                    local survivors = {}
                    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= game:GetService("Players").LocalPlayer then
                            local character = player.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                table.insert(survivors, character)
                            end
                        end
                    end

                    local nearestSurvivor = nil
                    local shortestDistance = math.huge  
                    
                    for _, survivor in pairs(survivors) do
                        local survivorHRP = survivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestSurvivor = survivor
                            end
                        end
                    end
                    
                    if nearestSurvivor then
                        local nearestHRP = nearestSurvivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local direction = (nearestHRP.Position - playerHRP.Position).Unit
                            local num = 1
                            local maxIterations = 100 
                            
                            if child.Name == "rbxassetid://79782181585087" then
                                maxIterations = 220  
                            end

                            while num <= maxIterations do
                                task.wait(0.01)
                                num = num + 1
                                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                            end
                        end
                    end
                end
            end
        end)
    else
        if coolloop then
            coolloop:Disconnect()
            coolloop = nil
        end
    end
end

-- 两次角色自瞄
local function TWO(state)
    local TWOsounds = {
        "rbxassetid://86710781315432",
        "rbxassetid://99820161736138"
    }
    
    TWOTIME = state

    if game:GetService("Players").LocalPlayer.Character.Name ~= "TwoTime" and state then
        Library:Notify("你的角色不是Two Time，无法生效", nil, 4590657391)
        return 
    end

    if state then
        TWOloop = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
            if not TWOTIME then return end
            for _, v in pairs(TWOsounds) do
                if child.Name == v then
                    local survivors = {}
                    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= game:GetService("Players").LocalPlayer then
                            local character = player.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                table.insert(survivors, character)
                            end
                        end
                    end

                    local nearestSurvivor = nil
                    local shortestDistance = math.huge  
                    
                    for _, survivor in pairs(survivors) do
                        local survivorHRP = survivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestSurvivor = survivor
                            end
                        end
                    end
                    
                    if nearestSurvivor then
                        local nearestHRP = nearestSurvivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local direction = (nearestHRP.Position - playerHRP.Position).Unit
                            local num = 1
                            local maxIterations = 100 
                            
                            if child.Name == "rbxassetid://79782181585087" then
                                maxIterations = 220  
                            end

                            while num <= maxIterations do
                                task.wait(0.01)
                                num = num + 1
                                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                                playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))  
                            end
                        end
                    end
                end
            end
        end)
    else
        if TWOloop then
            TWOloop:Disconnect()
            TWOloop = nil
        end
    end
end

-- 约翰角色自瞄
local function johnaimbot(state)
    local johnaimbotsounds = {
        "rbxassetid://109525294317144"
    }
    
    johnaim = state
    if game:GetService("Players").LocalPlayer.Character.Name ~= "JohnDoe" and state then
        Library:Notify("角色不对，无法生效", nil, 4590657391)
        return 
    end
    
    if state then
        johnloop = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
            if not johnaim then return end
            for _, v in pairs(johnaimbotsounds) do
                if child.Name == v then
                    local survivors = {}
                    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= game:GetService("Players").LocalPlayer then
                            local character = player.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                table.insert(survivors, character)
                            end
                        end
                    end

                    local nearestSurvivor = nil
                    local shortestDistance = math.huge  
                    
                    for _, survivor in pairs(survivors) do
                        local survivorHRP = survivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestSurvivor = survivor
                            end
                        end
                    end
                    
                    if nearestSurvivor then
                        local nearestHRP = nearestSurvivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local maxIterations = 330
                        if playerHRP then
                            local direction = (nearestHRP.Position - playerHRP.Position).Unit
                            local num = 1
                            
                            while num <= maxIterations do
                                task.wait(0.01)
                                num = num + 1
                                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                                playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                            end
                        end
                    end
                end
            end
        end)
    else
        if johnloop then
            johnloop:Disconnect()
            johnloop = nil
        end
    end
end

-- 杰森角色自瞄
local function jasonaimbot(state)
    local jasonaimbotsounds = {
        "rbxassetid://112809109188560",
        "rbxassetid://102228729296384"
    }
    
    jasonaim = state
    if game:GetService("Players").LocalPlayer.Character.Name ~= "Jason" and state then
        Library:Notify("角色不对，无法生效", nil, 4590657391)
        return 
    end
    
    if state then
        jasonaimbotloop = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
            if not jasonaim then return end
            for _, v in pairs(jasonaimbotsounds) do
                if child.Name == v then
                    local survivors = {}
                    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= game:GetService("Players").LocalPlayer then
                            local character = player.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                table.insert(survivors, character)
                            end
                        end
                    end

                    local nearestSurvivor = nil
                    local shortestDistance = math.huge  
                    
                    for _, survivor in pairs(survivors) do
                        local survivorHRP = survivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestSurvivor = survivor
                            end
                        end
                    end
                    
                    if nearestSurvivor then
                        local nearestHRP = nearestSurvivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local maxIterations = 70
                        if playerHRP then
                            local direction = (nearestHRP.Position - playerHRP.Position).Unit
                            local num = 1
                            
                            while num <= maxIterations do
                                task.wait(0.01)
                                num = num + 1
                                playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                            end
                        end
                    end
                end
            end
        end)
    else
        if jasonaimbotloop then
            jasonaimbotloop:Disconnect()
            jasonaimbotloop = nil
        end
    end
end

-- 机会角色自瞄
local function chanceAimbot(state)
    CA = state
    if state then
        if game.Players.LocalPlayer.Character.Name ~= "Chance" then
            Library:Notify("你用的角色好像不是机会,无法生效", nil, 4590657391)
            return
        end
        
        local RemoteEvent = game:GetService("ReplicatedStorage")
            :WaitForChild("Modules")
            :WaitForChild("Network")
            :WaitForChild("RemoteEvent")
            
        CAbotConnection = RemoteEvent.OnClientEvent:Connect(function(...)
            local args = {...}
            if args[1] == "UseActorAbility" and args[2] == "Shoot" then 
                local killerContainer = game.Workspace.Players:FindFirstChild("Killers")
                if killerContainer then 
                    local killer = killerContainer:FindFirstChildOfClass("Model")
                    if killer and killer:FindFirstChild("HumanoidRootPart") then 
                        local killerHRP = killer.HumanoidRootPart
                        local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if playerHRP then 
                            local TMP = 0.35
                            local AMD = 2
                            local endTime = tick() + AMD
                            while tick() < endTime do
                                RunService.RenderStepped:Wait()
                                local predictedTarget = killerHRP.Position + (killerHRP.Velocity * TMP)
                                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = killerHRP.CFrame + Vector3.new(0, 0, -2)
                            end
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = PICF
                        end
                    end
                end
            end
        end)
    else
        if CAbotConnection then
            CAbotConnection:Disconnect()
            CAbotConnection = nil
        end
    end
end

-- 谢德利茨基角色自瞄
local function shedletskyAimbot(state)
    shedaim = state
    if state then
        if game:GetService("Players").LocalPlayer.Character.Name ~= "Shedletsky" then
            Library:Notify("你用的角色好像不是谢德利茨基,无法生效", nil, 4590657391)
            return
        end
        
        shedloop = game:GetService("Players").LocalPlayer.Character.Sword.ChildAdded:Connect(function(child)
            if not shedaim then return end
            if child:IsA("Sound") then 
                local FAN = child.Name
                if FAN == "rbxassetid://12222225" or FAN == "83851356262523" then 
                    local killersFolder = game.Workspace.Players:FindFirstChild("Killers")
                    if killersFolder then 
                        local killer = killersFolder:FindFirstChildOfClass("Model")
                        if killer and killer:FindFirstChild("HumanoidRootPart") then 
                            local killerHRP = killer.HumanoidRootPart
                            local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if playerHRP then 
                                local num = 1
                                local maxIterations = 100
                                while num <= maxIterations do
                                    task.wait(0.01)
                                    num = num + 1
                                    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, killerHRP.Position)
                                    playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, killerHRP.Position)
                                end
                            end
                        end
                    end
                end
            end
        end)
    else
        if shedloop then 
            shedloop:Disconnect()
            shedloop = nil
        end
    end
end

-- 将自瞄功能添加到UI中
local SB = Tabs.Aimbot:AddLeftGroupbox('幸存者')

SB:AddToggle('MyToggle', {
    Text = '机会 自瞄 ',
    Default = false,
    Tooltip = '自瞄',
    Callback = chanceAimbot
})

SB:AddToggle('MyToggle', {
    Text = '两次 自瞄',
    Default = false,
    Tooltip = '自瞄',
    Callback = TWO
})

SB:AddToggle('MyToggle', {
    Text = '谢德利茨基 自瞄',
    Default = false,
    Tooltip = '自瞄',
    Callback = shedletskyAimbot
})

local SC = Tabs.Aimbot:AddRightGroupbox('杀手')


SC:AddToggle('MyToggle', {
    Text = '1x4自瞄',
    Default = false,
    Tooltip = '自瞄',
    Callback = aimbot1x1x1x1
})

SC:AddToggle('MyToggle', {
    Text = '酷小孩自瞄',
    Default = false,
    Tooltip = '自瞄',
    Callback = cool
})

SC:AddToggle('MyToggle', {
    Text = '约翰自瞄',
    Default = false,
    Tooltip = '自瞄',
    Callback = johnaimbot
})

SC:AddToggle('MyToggle', {
    Text = '杰森自瞄',
    Default = false,
    Tooltip = '自瞄',
    Callback = jasonaimbot
})

local ZM = Tabs.Aimbot:AddLeftGroupbox("玩家自瞄(XuanC)")
local aimSettings = {
    distance = 100,
    fov = 100,
    size = 10,
    noWall = false,
    rainbowMode = true 
}

local aimbotData = {
    FOVring = nil,
    connections = {}
}

ZM:AddSlider('AimDistance', {
    Text = '自瞄距离',
    Default = 100,
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
        aimSettings.distance = Value
    end
})

ZM:AddSlider('FOVSize', {
    Text = '圈圈大小',
    Default = 100,
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
        aimSettings.fov = Value
    end
})

ZM:AddSlider('TargetSize', {
    Text = '自瞄大小',
    Default = 10,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
        aimSettings.size = Value
    end
})

ZM:AddToggle('NoWallToggle', {
    Text = '掩体检测',
    Default = false,
    Tooltip = '自瞄',
    Callback = function(state)
        aimSettings.noWall = state
    end
})

ZM:AddDropdown('ColorSelector', {
    Values = {
        'Red',
        'Green',
        'Blue',
        'White',
        'Yellow',
        'Cyan',
        'Magenta',
        'Rainbow'
    },
    Default = 8,
    Multi = false,
    Text = '选择颜色',
    Tooltip = '用于自瞄圈圈的颜色',
    Callback = function(Value)
        local colorMap = {
            Red = Color3.fromRGB(255, 0, 0),
            Green = Color3.fromRGB(0, 255, 0),
            Blue = Color3.fromRGB(0, 0, 255),
            White = Color3.fromRGB(255, 255, 255),
            Yellow = Color3.fromRGB(255, 255, 0),
            Cyan = Color3.fromRGB(0, 255, 255),
            Magenta = Color3.fromRGB(255, 0, 255)
        }

        if Value == 'Rainbow' then
            aimSettings.rainbowMode = true
        else
            aimSettings.rainbowMode = false
            local selectedColor = colorMap[Value] or Color3.fromRGB(231, 231, 236)
            if aimbotData.FOVring then
                aimbotData.FOVring.Color = selectedColor
            end
        end
    end
})

local bai = {}
bai.Aim = false
local aimConnection

Spy = ZM:AddToggle("AimbotToggle", {
    Text = "自瞄玩家",
    Default = false,
    Callback = function(state)
        bai.Aim = state
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local Cam = workspace.CurrentCamera
        local UserInputService = game:GetService("UserInputService")
        local RaycastParams = RaycastParams.new()
        RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist

        local function cleanup()
            if aimbotData.FOVring then
                aimbotData.FOVring:Remove()
                aimbotData.FOVring = nil
            end
            if aimConnection then
                aimConnection:Disconnect()
                aimConnection = nil
            end
        end

        if state then
            if not aimbotData.FOVring then
                aimbotData.FOVring = Drawing.new("Circle")
                aimbotData.FOVring.Visible = true
                aimbotData.FOVring.Thickness = 2
                aimbotData.FOVring.Filled = false
                aimbotData.FOVring.Color = Color3.fromHSV(0, 1, 1)
            end

            aimConnection = RunService.RenderStepped:Connect(function()
                aimbotData.FOVring.Radius = aimSettings.fov
                aimbotData.FOVring.Position = Cam.ViewportSize / 2

                local survivorsFolder = workspace.Players:FindFirstChild("Survivors")
                local target = nil
                local closestDist = math.huge
                local mousePos = Cam.ViewportSize / 2

                if survivorsFolder then
                    for _, survivorModel in pairs(survivorsFolder:GetChildren()) do
                        if survivorModel == Players.LocalPlayer.Character then
                            break
                        end

                        local hrp = survivorModel:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local screenPos, onScreen = Cam:WorldToViewportPoint(hrp.Position)
                            local distance = (Cam.CFrame.Position - hrp.Position).Magnitude
                            if onScreen and distance <= aimSettings.distance then
                                if aimSettings.noWall then
                                    RaycastParams.FilterDescendantsInstances = {
                                        Players.LocalPlayer.Character,
                                        workspace.Players
                                    }
                                    local result = workspace:Raycast(Cam.CFrame.Position, hrp.Position - Cam.CFrame.Position, RaycastParams)
                                    if result and not result.Instance:IsDescendantOf(survivorModel) then
                                        break
                                    end
                                end
                                local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                                if screenDist < closestDist and screenDist <= aimSettings.fov then
                                    closestDist = screenDist
                                    target = hrp
                                end
                            end
                        end
                    end
                end

                if target then
                    local lookVector = (target.Position - Cam.CFrame.Position).Unit
                    Cam.CFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
                end

                if aimSettings.rainbowMode and aimbotData.FOVring then
                    local hue = (tick() * 0.2) % 1
                    aimbotData.FOVring.Color = Color3.fromHSV(hue, 1, 1)
                end
            end)

            aimbotData.connections.keyEvent = UserInputService.InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.Delete then
                    bai.Aim = false
                    Spy:SetValue(false)
                    cleanup()
                end
            end)
        else
            cleanup()
        end
    end
}):AddKeyPicker("AimKeyPicker", {
    Text = "自瞄幸存者",
    Default = "E",
    Mode = "Toggle",
    SyncToggleState = true,
})

-- 杀手自瞄
local HH = Tabs.Aimbot:AddRightGroupbox("自瞄杀手(XuanC)")

local aimSettings = {
    distance = 100,
    fov = 100,
    size = 10,
    noWall = false,
    rainbowMode = true 
}

local aimbotData = {
    FOVring = nil,
    connections = {}
}

HH:AddSlider('AimDistance', {
    Text = '自瞄距离',
    Default = 100,
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        aimSettings.distance = Value
    end
})

HH:AddSlider('FOVSize', {
    Text = '圈圈大小',
    Default = 100,
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        aimSettings.fov = Value
    end
})

HH:AddSlider('TargetSize', {
    Text = '自瞄大小',
    Default = 10,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        aimSettings.size = Value
    end
})

HH:AddToggle('NoWallToggle', {
    Text = '掩体检测',
    Default = false,
    Tooltip = '自瞄',
    Callback = function(state)
        aimSettings.noWall = state
    end
})

HH:AddDropdown('ColorSelector', {
    Values = {
        'Red',
        'Green',
        'Blue',
        'White',
        'Yellow',
        'Cyan',
        'Magenta',
        'Rainbow'
    },
    Default = 8,
    Multi = false,
    Text = '选择颜色',
    Tooltip = '用于自瞄圈圈的颜色',
    Callback = function(Value)
        local colorMap = {
            Red = Color3.fromRGB(255, 0, 0),
            Green = Color3.fromRGB(0, 255, 0),
            Blue = Color3.fromRGB(0, 0, 255),
            White = Color3.fromRGB(255, 255, 255),
            Yellow = Color3.fromRGB(255, 255, 0),
            Cyan = Color3.fromRGB(0, 255, 255),
            Magenta = Color3.fromRGB(255, 0, 255)
        }

        if Value == 'Rainbow' then
            aimSettings.rainbowMode = true
        else
            aimSettings.rainbowMode = false
            local selectedColor = colorMap[Value] or Color3.fromRGB(231, 231, 236)
            if aimbotData.FOVring then
                aimbotData.FOVring.Color = selectedColor
            end
        end
    end
})

local bai = {}
bai.Aim = false
local aimConnection

Spy = HH:AddToggle("AimbotToggle", {
    Text = "自瞄杀手",
    Default = false,
    Callback = function(state)
        bai.Aim = state
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local Cam = workspace.CurrentCamera
        local UserInputService = game:GetService("UserInputService")
        local RaycastParams = RaycastParams.new()
        RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist

        local function cleanup()
            if aimbotData.FOVring then
                aimbotData.FOVring:Remove()
                aimbotData.FOVring = nil
            end
            if aimConnection then
                aimConnection:Disconnect()
                aimConnection = nil
            end
        end

        if state then
            if not aimbotData.FOVring then
                aimbotData.FOVring = Drawing.new("Circle")
                aimbotData.FOVring.Visible = true
                aimbotData.FOVring.Thickness = 2
                aimbotData.FOVring.Filled = false
                aimbotData.FOVring.Color = Color3.fromHSV(0, 1, 1)
            end

            aimConnection = RunService.RenderStepped:Connect(function()
                aimbotData.FOVring.Radius = aimSettings.fov
                aimbotData.FOVring.Position = Cam.ViewportSize / 2

                local killersFolder = workspace.Players:FindFirstChild("Killers")
                local target = nil
                local closestDist = math.huge
                local mousePos = Cam.ViewportSize / 2

                if killersFolder then
                    for _, killerModel in pairs(killersFolder:GetChildren()) do
                        local hrp = killerModel:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local screenPos, onScreen = Cam:WorldToViewportPoint(hrp.Position)
                            local distance = (Cam.CFrame.Position - hrp.Position).Magnitude
                            if onScreen and distance <= aimSettings.distance then
                                if aimSettings.noWall then
                                    RaycastParams.FilterDescendantsInstances = {
                                        Players.LocalPlayer.Character,
                                        workspace.Players
                                    }
                                    local result = workspace:Raycast(Cam.CFrame.Position, hrp.Position - Cam.CFrame.Position, RaycastParams)
                                    if result and not result.Instance:IsDescendantOf(killerModel) then
                                        break
                                    end
                                end
                                local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                                if screenDist < closestDist and screenDist <= aimSettings.fov then
                                    closestDist = screenDist
                                    target = hrp
                                end
                            end
                        end
                    end
                end

                if target then
                    local lookVector = (target.Position - Cam.CFrame.Position).Unit
                    Cam.CFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
                end

                if aimSettings.rainbowMode and aimbotData.FOVring then
                    local hue = (tick() * 0.2) % 1
                    aimbotData.FOVring.Color = Color3.fromHSV(hue, 1, 1)
                end
            end)

            aimbotData.connections.keyEvent = UserInputService.InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.Delete then
                    bai.Aim = false
                    Spy:SetValue(false)
                    cleanup()
                end
            end)
        else
            cleanup()
        end
    end
}):AddKeyPicker("AimKeyPicker", {
    Text = "自瞄开关",
    Default = "E",
    Mode = "Toggle",
    SyncToggleState = true,
})

-- 特殊自瞄功能
local SpecialAimbot = Tabs.Aimbot:AddLeftGroupbox("角色自瞄")

function AimShootChance(value)
    local aimshootchance = value
    if value then
        local chanceaimbotsounds = {
            "rbxassetid://201858045",
            "rbxassetid://139012439429121"
        }
        aimshootchance = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
            if not aimshootchance then return end
            for _, v in ipairs(chanceaimbotsounds) do
                if child.Name == v then
                    local targetkiller = game.Workspace.Players:FindFirstChild("Killers"):FindFirstChildOfClass("Model")
                    if targetkiller and targetkiller:FindFirstChild("HumanoidRootPart") then
                        if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local direction = (targetkiller.HumanoidRootPart.Position - game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Unit
                            local number = 1
                            game:GetService("RunService").RenderStepped:Connect(function()
                                if number <= 100 then
                                    task.wait(0.01)
                                    number = number + 1
                                    game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position, Vector3.new(targetkiller.HumanoidRootPart.Position.X, targetkiller.HumanoidRootPart.Position.Y, targetkiller.HumanoidRootPart.Position.Z))
                                end
                            end)
                        end
                    end
                end
            end
        end)
    else
        aimshootchance:Disconnect()
    end
end

function AimSlashShedletsky(value)
    local aimslashsword = value
    if value then
        local shedaimbotsounds = {
            "rbxassetid://106397684977541",
            "rbxassetid://106397684977541"
        }
        aimslash = game.Players.LocalPlayer.Character.Sword.ChildAdded:Connect(function(child)
            if not aimslashsword then return end
            for _, v in ipairs(shedaimbotsounds) do
                if child.Name == v then
                    local targetkiller = game.Workspace.Players:FindFirstChild("Killers"):FindFirstChildOfClass("Model")
                    if targetkiller and targetkiller:FindFirstChild("HumanoidRootPart") then
                        if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local direction = (targetkiller.HumanoidRootPart.Position - game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Unit
                            local number = 1
                            game:GetService("RunService").RenderStepped:Connect(function()
                                if number <= 100 then
                                    task.wait(0.01)
                                    number = number + 1
                                    game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position, Vector3.new(targetkiller.HumanoidRootPart.Position.X, targetkiller.HumanoidRootPart.Position.Y, targetkiller.HumanoidRootPart.Position.Z))
                                end
                            end)
                        end
                    end
                end
            end
        end)
    else
        aimslash:Disconnect()
    end
end

function AimAttackGuest(value)
    local aimattackguest = value
    if value then
        local guestaimbotsounds = {
            "rbxassetid://106397684977541"
        }
        aimguest = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
            if not aimattackguest then return end
            for _, v in ipairs(guestaimbotsounds) do
                if child.Name == v then
                    local targetkiller = game.Workspace.Players:FindFirstChild("Killers"):FindFirstChildOfClass("Model")
                    if targetkiller and targetkiller:FindFirstChild("HumanoidRootPart") then
                        if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local direction = (targetkiller.HumanoidRootPart.Position - game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Unit
                            local number = 1
                            game:GetService("RunService").RenderStepped:Connect(function()
                                if number <= 100 then
                                    task.wait(0.01)
                                    number = number + 1
                                    game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position, Vector3.new(targetkiller.HumanoidRootPart.Position.X, targetkiller.HumanoidRootPart.Position.Y, targetkiller.HumanoidRootPart.Position.Z))
                                end
                            end)
                        end
                    end
                end
            end
        end)
    else
        aimguest:Disconnect()
    end
end

SpecialAimbot:AddToggle("CSA",{
    Text = "机会自瞄",
    Callback = function(v)
        AimShootChance(v)
    end
})

SpecialAimbot:AddToggle("SSA",{
    Text = "谢德自瞄",
    Callback = function(v)
        AimSlashShedletsky(v)
    end
})

SpecialAimbot:AddToggle("GAA",{
    Text = "访客自瞄",
    Callback = function(v)
        AimAttackGuest(v)
    end
})

local Visual = Tabs.Esp:AddRightGroupbox("距离显示")

-- 初始化设置
local DistanceSettings = {
    ShowSurvivors = true,
    ShowKillers = true,
    SurvivorColor = Color3.fromRGB(0, 191, 255), -- 默认幸存者蓝色
    KillerColor = Color3.fromRGB(255, 0, 0),     -- 默认杀手红色
    TextSize = 14
}

-- 距离显示功能
local function updateDistanceDisplay()
    -- 先关闭现有连接
    if getgenv().distanceUnderFeetConnection then
        getgenv().distanceUnderFeetConnection:Disconnect()
    end
    
    if getgenv().characterRemovedConnection then
        getgenv().characterRemovedConnection:Disconnect()
    end
    
    -- 如果两个都关闭则完全禁用
    if not DistanceSettings.ShowSurvivors and not DistanceSettings.ShowKillers then
        if getgenv().distanceUnderFeetLabels then
            for _, data in pairs(getgenv().distanceUnderFeetLabels) do
                pcall(function() data.label:Remove() end)
            end
            getgenv().distanceUnderFeetLabels = nil
        end
        return
    end
    
    -- 初始化变量
    local players = game:GetService("Players")
    local runService = game:GetService("RunService")
    local localPlayer = players.LocalPlayer
    local camera = workspace.CurrentCamera
    
    -- 存储所有距离标签
    getgenv().distanceUnderFeetLabels = getgenv().distanceUnderFeetLabels or {}
    
    -- 主循环
    getgenv().distanceUnderFeetConnection = runService.RenderStepped:Connect(function()
        local localChar = localPlayer.Character
        if not localChar or not localChar:FindFirstChild("HumanoidRootPart") then return end
        
        local localPos = localChar.HumanoidRootPart.Position
        
        -- 处理幸存者
        if DistanceSettings.ShowSurvivors then
            local survivors = workspace.Players:FindFirstChild("Survivors")
            if survivors then
                for _, survivor in ipairs(survivors:GetChildren()) do
                    if survivor:IsA("Model") and survivor ~= localChar then
                        local hrp = survivor:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            if not getgenv().distanceUnderFeetLabels[survivor] then
                                getgenv().distanceUnderFeetLabels[survivor] = {
                                    label = Drawing.new("Text"),
                                    type = "Survivor"
                                }
                                local label = getgenv().distanceUnderFeetLabels[survivor].label
                                label.Size = DistanceSettings.TextSize
                                label.Center = true
                                label.Outline = true
                                label.Font = 2
                            end
                            
                            local data = getgenv().distanceUnderFeetLabels[survivor]
                            local distance = math.floor((hrp.Position - localPos).Magnitude)
                            local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                            
                            if onScreen then
                                data.label.Position = Vector2.new(screenPos.X, screenPos.Y)
                                data.label.Text = tostring(distance) .. "m"
                                data.label.Color = DistanceSettings.SurvivorColor
                                data.label.Visible = true
                            else
                                data.label.Visible = false
                            end
                        end
                    end
                end
            end
        else
            -- 隐藏所有幸存者标签
            for model, data in pairs(getgenv().distanceUnderFeetLabels or {}) do
                if data.type == "Survivor" then
                    data.label.Visible = false
                end
            end
        end
        
        -- 处理杀手
        if DistanceSettings.ShowKillers then
            local killers = workspace.Players:FindFirstChild("Killers")
            if killers then
                for _, killer in ipairs(killers:GetChildren()) do
                    if killer:IsA("Model") then
                        local hrp = killer:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            if not getgenv().distanceUnderFeetLabels[killer] then
                                getgenv().distanceUnderFeetLabels[killer] = {
                                    label = Drawing.new("Text"),
                                    type = "Killer"
                                }
                                local label = getgenv().distanceUnderFeetLabels[killer].label
                                label.Size = DistanceSettings.TextSize
                                label.Center = true
                                label.Outline = true
                                label.Font = 2
                            end
                            
                            local data = getgenv().distanceUnderFeetLabels[killer]
                            local distance = math.floor((hrp.Position - localPos).Magnitude)
                            local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                            
                            if onScreen then
                                data.label.Position = Vector2.new(screenPos.X, screenPos.Y)
                                data.label.Text = tostring(distance) .. "m"
                                data.label.Color = DistanceSettings.KillerColor
                                data.label.Visible = true
                            else
                                data.label.Visible = false
                            end
                        end
                    end
                end
            end
        else
            -- 隐藏所有杀手标签
            for model, data in pairs(getgenv().distanceUnderFeetLabels or {}) do
                if data.type == "Killer" then
                    data.label.Visible = false
                end
            end
        end
    end)
    
    -- 监听角色移除
    getgenv().characterRemovedConnection = workspace.Players.DescendantRemoving:Connect(function(descendant)
        if descendant:IsA("Model") and getgenv().distanceUnderFeetLabels and getgenv().distanceUnderFeetLabels[descendant] then
            getgenv().distanceUnderFeetLabels[descendant].label:Remove()
            getgenv().distanceUnderFeetLabels[descendant] = nil
        end
    end)
end

-- 主开关
Visual:AddToggle("DistanceUnderFeet", {
    Text = "绘制距离总开关",
    Default = false,
    Callback = function(enabled)
        if enabled then
            updateDistanceDisplay()
        else
            -- 完全关闭
            if getgenv().distanceUnderFeetConnection then
                getgenv().distanceUnderFeetConnection:Disconnect()
            end
            
            if getgenv().characterRemovedConnection then
                getgenv().characterRemovedConnection:Disconnect()
            end
            
            if getgenv().distanceUnderFeetLabels then
                for _, data in pairs(getgenv().distanceUnderFeetLabels) do
                    pcall(function() data.label:Remove() end)
                end
                getgenv().distanceUnderFeetLabels = nil
            end
        end
    end
})
Visual:AddDivider()  
-- 幸存者开关
Visual:AddToggle("ShowSurvivors", {
    Text = "绘制幸存者距离",
    Default = true,
    Callback = function(enabled)
        DistanceSettings.ShowSurvivors = enabled
        if getgenv().distanceUnderFeetConnection then
            updateDistanceDisplay()
        end
    end
})

-- 杀手开关
Visual:AddToggle("ShowKillers", {
    Text = "绘制杀手距离",
    Default = true,
    Callback = function(enabled)
        DistanceSettings.ShowKillers = enabled
        if getgenv().distanceUnderFeetConnection then
            updateDistanceDisplay()
        end
    end
})

-- 颜色设置
Visual:AddDropdown("SurvivorColor", {
    Values = {"蓝色", "绿色", "黄色", "紫色", "青色"},
    Default = 1,
    Text = "幸存者颜色",
    Callback = function(value)
        local colorMap = {
            ["蓝色"] = Color3.fromRGB(0, 191, 255),
            ["绿色"] = Color3.fromRGB(0, 255, 0),
            ["黄色"] = Color3.fromRGB(255, 255, 0),
            ["紫色"] = Color3.fromRGB(128, 0, 128),
            ["青色"] = Color3.fromRGB(0, 255, 255)
        }
        
        DistanceSettings.SurvivorColor = colorMap[value] or Color3.fromRGB(0, 191, 255)
        if getgenv().distanceUnderFeetLabels then
            for _, data in pairs(getgenv().distanceUnderFeetLabels) do
                if data.type == "Survivor" then
                    data.label.Color = DistanceSettings.SurvivorColor
                end
            end
        end
    end
})

Visual:AddDropdown("KillerColor", {
    Values = {"红色", "橙色", "粉色", "白色", "黑色"},
    Default = 1,
    Text = "杀手颜色",
    Callback = function(value)
        local colorMap = {
            ["红色"] = Color3.fromRGB(255, 0, 0),
            ["橙色"] = Color3.fromRGB(255, 165, 0),
            ["粉色"] = Color3.fromRGB(255, 192, 203),
            ["白色"] = Color3.fromRGB(255, 255, 255),
            ["黑色"] = Color3.fromRGB(0, 0, 0)
        }
        
        DistanceSettings.KillerColor = colorMap[value] or Color3.fromRGB(255, 0, 0)
        if getgenv().distanceUnderFeetLabels then
            for _, data in pairs(getgenv().distanceUnderFeetLabels) do
                if data.type == "Killer" then
                    data.label.Color = DistanceSettings.KillerColor
                end
            end
        end
    end
})

-- 文字大小设置
Visual:AddSlider("DistanceTextSize", {
    Text = "文字大小",
    Min = 8,
    Max = 24,
    Default = 14,
    Rounding = 0,
    Callback = function(value)
        DistanceSettings.TextSize = value
        if getgenv().distanceUnderFeetLabels then
            for _, data in pairs(getgenv().distanceUnderFeetLabels) do
                data.label.Size = value
            end
        end
    end
})

Visual:AddDivider()  


local Visual = Tabs.Esp:AddRightGroupbox("高亮绘制")

-- 高亮绘制设置
local HighlightSettings = {
    ShowSurvivorHighlights = true,
    ShowKillerHighlights = true,
    FillTransparency = 0.5,
    OutlineTransparency = 0,
    connection = nil,
    highlights = {}  -- 存储所有高亮对象
}

-- 更新颜色预设
HighlightSettings.SurvivorColors = {
    ["绿色"] = Color3.fromRGB(0, 255, 0),
    ["白色"] = Color3.fromRGB(255, 255, 255),
    ["紫色"] = Color3.fromRGB(128, 0, 128),
    ["青色"] = Color3.fromRGB(0, 255, 255),
    ["橙色"] = Color3.fromRGB(255, 165, 0),
    ["柠檬绿"] = Color3.fromRGB(173, 255, 47)  -- 新增柠檬绿
}

HighlightSettings.KillerColors = {
    ["红色"] = Color3.fromRGB(255, 0, 0),
    ["粉色"] = Color3.fromRGB(255, 105, 180),
    ["黑色"] = Color3.fromRGB(0, 0, 0),
    ["蓝色"] = Color3.fromRGB(0, 0, 255),
    ["猩红色"] = Color3.fromRGB(220, 20, 60),  -- 新增猩红色
    ["杏色"] = Color3.fromRGB(251, 206, 177)   -- 新增杏色
}

-- 边缘颜色使用与填充颜色相同的选项
HighlightSettings.SurvivorOutlineColors = table.clone(HighlightSettings.SurvivorColors)
HighlightSettings.KillerOutlineColors = table.clone(HighlightSettings.KillerColors)

-- 默认颜色
HighlightSettings.SelectedSurvivorColor = "青色"
HighlightSettings.SelectedKillerColor = "红色"
HighlightSettings.SelectedSurvivorOutlineColor = "青色"
HighlightSettings.SelectedKillerOutlineColor = "红色"

-- 清理高亮对象
local function cleanupHighlights()
    for _, highlight in pairs(HighlightSettings.highlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    HighlightSettings.highlights = {}
end

-- 更新高亮显示
local function updateHighlights()
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    
    -- 获取幸存者和杀手文件夹
    local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    
    -- 只处理幸存者和杀手
    local function processFolder(folder, isKiller)
        if not folder then return end
        
        for _, model in ipairs(folder:GetChildren()) do
            if model:IsA("Model") then
                -- 确定颜色
                local fillColor = isKiller and HighlightSettings.KillerColors[HighlightSettings.SelectedKillerColor] 
                                          or HighlightSettings.SurvivorColors[HighlightSettings.SelectedSurvivorColor]
                
                local outlineColor = isKiller and HighlightSettings.KillerOutlineColors[HighlightSettings.SelectedKillerOutlineColor] 
                                              or HighlightSettings.SurvivorOutlineColors[HighlightSettings.SelectedSurvivorOutlineColor]
                
                -- 根据设置决定是否显示
                if (isKiller and HighlightSettings.ShowKillerHighlights) or 
                   (not isKiller and HighlightSettings.ShowSurvivorHighlights) then
                    
                    if not HighlightSettings.highlights[model] then
                        local highlight = Instance.new("Highlight")
                        highlight.Parent = game.CoreGui
                        HighlightSettings.highlights[model] = highlight
                    end
                    
                    local highlight = HighlightSettings.highlights[model]
                    highlight.Adornee = model
                    highlight.FillColor = fillColor
                    highlight.OutlineColor = outlineColor
                    highlight.FillTransparency = HighlightSettings.FillTransparency
                    highlight.OutlineTransparency = HighlightSettings.OutlineTransparency
                elseif HighlightSettings.highlights[model] then
                    HighlightSettings.highlights[model].Adornee = nil
                end
            end
        end
    end
    
    -- 处理幸存者
    processFolder(survivorsFolder, false)
    
    -- 处理杀手
    processFolder(killersFolder, true)
    
    -- 清理不再存在的模型的高亮
    for model, highlight in pairs(HighlightSettings.highlights) do
        if not model or not model.Parent then
            highlight:Destroy()
            HighlightSettings.highlights[model] = nil
        end
    end
end

-- 主开关
Visual:AddToggle("HighlightToggle", {
    Text = "启用高亮绘制",
    Default = false,
    Callback = function(enabled)
        if enabled then
            -- 初始化连接
            if not HighlightSettings.connection then
                HighlightSettings.connection = game:GetService("RunService").RenderStepped:Connect(updateHighlights)
            end
        else
            -- 关闭连接
            if HighlightSettings.connection then
                HighlightSettings.connection:Disconnect()
                HighlightSettings.connection = nil
            end
            -- 清理高亮对象
            cleanupHighlights()
        end
    end
})

-- 幸存者开关
Visual:AddToggle("ShowSurvivorHighlights", {
    Text = "绘制幸存者高亮",
    Default = true,
    Callback = function(enabled)
        HighlightSettings.ShowSurvivorHighlights = enabled
    end
})

-- 杀手开关
Visual:AddToggle("ShowKillerHighlights", {
    Text = "绘制杀手高亮",
    Default = true,
    Callback = function(enabled)
        HighlightSettings.ShowKillerHighlights = enabled
    end
})

-- 幸存者填充颜色选择
Visual:AddDropdown("SurvivorFillColor", {
    Values = {"绿色", "白色", "紫色", "青色", "橙色", "柠檬绿"},
    Default = "青色",
    Text = "幸存者填充颜色",
    Callback = function(value)
        HighlightSettings.SelectedSurvivorColor = value
    end
})

-- 杀手填充颜色选择
Visual:AddDropdown("KillerFillColor", {
    Values = {"红色", "粉色", "黑色", "蓝色", "猩红色", "杏色"},
    Default = "红色",
    Text = "杀手填充颜色",
    Callback = function(value)
        HighlightSettings.SelectedKillerColor = value
    end
})

-- 幸存者边缘颜色选择
Visual:AddDropdown("SurvivorOutlineColor", {
    Values = {"绿色", "白色", "紫色", "青色", "橙色", "柠檬绿"},
    Default = "青色",
    Text = "幸存者边缘颜色",
    Callback = function(value)
        HighlightSettings.SelectedSurvivorOutlineColor = value
    end
})

-- 杀手边缘颜色选择
Visual:AddDropdown("KillerOutlineColor", {
    Values = {"红色", "粉色", "黑色", "蓝色", "猩红色", "杏色"},
    Default = "黑色",
    Text = "杀手边缘颜色",
    Callback = function(value)
        HighlightSettings.SelectedKillerOutlineColor = value
    end
})

-- 填充透明度调节滑块
Visual:AddSlider("FillTransparency", {
    Text = "填充透明度",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Rounding = 1,
    Compact = false,
    Callback = function(value)
        HighlightSettings.FillTransparency = value
    end
})

-- 边缘透明度调节滑块
Visual:AddSlider("OutlineTransparency", {
    Text = "边缘透明度",
    Min = 0,
    Max = 1,
    Default = 0,
    Rounding = 1,
    Compact = false,
    Callback = function(value)
        HighlightSettings.OutlineTransparency = value
    end
})


local Visual = Tabs.Esp:AddLeftGroupbox("血量条绘制")

-- 血量条设置
local HealthBarSettings = {
    ShowSurvivorBars = true,
    ShowKillerBars = true,
    BarWidth = 100,      -- 固定宽度
    BarHeight = 5,       -- 固定高度
    TextSize = 14,       -- 固定文字大小
    BarOffset = Vector2.new(0, -30), -- 基础偏移
    TextOffset = Vector2.new(0, -40)  -- 文字偏移
}

-- 预设颜色方案（修改后的幸存者颜色）
local ColorPresets = {
    Survivor = {
        FullHealth = Color3.fromRGB(0, 255, 255),    -- 青色(满血)
        HalfHealth = Color3.fromRGB(0, 255, 0),      -- 绿色(半血)
        LowHealth = Color3.fromRGB(255, 165, 0)      -- 橙色(低血)
    },
    Killer = {
        FullHealth = Color3.fromRGB(255, 0, 0),      -- 红色(满血)
        HalfHealth = Color3.fromRGB(255, 165, 0),    -- 橙色(半血)
        LowHealth = Color3.fromRGB(255, 255, 0)      -- 黄色(低血)
    },
    Common = {
        Background = Color3.fromRGB(50, 50, 50),
        Outline = Color3.fromRGB(0, 0, 0),
        Text = Color3.fromRGB(255, 255, 255)        -- 白色文字
    }
}

-- 存储所有绘制对象
local HealthBarDrawings = {}

-- 创建血量条绘制对象
local function createHealthBarDrawing()
    local drawing = {
        background = Drawing.new("Square"),
        bar = Drawing.new("Square"),
        outline = Drawing.new("Square"),
        text = Drawing.new("Text")
    }
    
    -- 背景设置
    drawing.background.Thickness = 1
    drawing.background.Filled = true
    drawing.background.Color = ColorPresets.Common.Background
    
    -- 血量条设置
    drawing.bar.Thickness = 1
    drawing.bar.Filled = true
    
    -- 边框设置
    drawing.outline.Thickness = 2
    drawing.outline.Filled = false
    drawing.outline.Color = ColorPresets.Common.Outline
    
    -- 文字设置
    drawing.text.Center = true
    drawing.text.Outline = true
    drawing.text.Font = 2
    drawing.text.Color = ColorPresets.Common.Text
    
    return drawing
end

-- 根据血量获取颜色（修改后的阈值）
local function getHealthColor(humanoid, isKiller)
    local healthPercent = (humanoid.Health / humanoid.MaxHealth) * 100
    
    if isKiller then
        if healthPercent > 50 then
            return ColorPresets.Killer.FullHealth
        elseif healthPercent > 25 then
            return ColorPresets.Killer.HalfHealth
        else
            return ColorPresets.Killer.LowHealth
        end
    else
        -- 幸存者新颜色阈值
        if healthPercent > 75 then
            return ColorPresets.Survivor.FullHealth    -- 满血(75%以上): 青色
        elseif healthPercent > 35 then
            return ColorPresets.Survivor.HalfHealth    -- 半血(35%-75%): 绿色
        else
            return ColorPresets.Survivor.LowHealth     -- 低血(35%以下): 橙色
        end
    end
end

-- 更新血量条（优化后不显示自身血条）
local function updateHealthBars()
    local camera = workspace.CurrentCamera
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    
    -- 处理幸存者
    if HealthBarSettings.ShowSurvivorBars then
        local survivors = workspace.Players:FindFirstChild("Survivors")
        if survivors then
            for _, survivor in ipairs(survivors:GetChildren()) do
                if survivor:IsA("Model") and survivor ~= localPlayer.Character then  -- 不显示自身血条
                    local humanoid = survivor:FindFirstChildOfClass("Humanoid")
                    local head = survivor:FindFirstChild("Head")
                    
                    if humanoid and head then
                        -- 获取或创建绘制对象
                        if not HealthBarDrawings[survivor] then
                            HealthBarDrawings[survivor] = createHealthBarDrawing()
                        end
                        
                        local drawing = HealthBarDrawings[survivor]
                        local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
                        
                        if onScreen then
                            -- 计算血量百分比
                            local healthPercent = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
                            local healthBarWidth = HealthBarSettings.BarWidth * (healthPercent / 100)
                            
                            -- 设置位置
                            local barPos = Vector2.new(
                                screenPos.X + HealthBarSettings.BarOffset.X - (HealthBarSettings.BarWidth / 2),
                                screenPos.Y + HealthBarSettings.BarOffset.Y
                            )
                            
                            -- 背景和边框
                            drawing.background.Size = Vector2.new(HealthBarSettings.BarWidth, HealthBarSettings.BarHeight)
                            drawing.background.Position = barPos
                            drawing.background.Visible = true
                            
                            drawing.outline.Size = Vector2.new(HealthBarSettings.BarWidth, HealthBarSettings.BarHeight)
                            drawing.outline.Position = barPos
                            drawing.outline.Visible = true
                            
                            -- 血量条（使用新颜色方案）
                            drawing.bar.Color = getHealthColor(humanoid, false)
                            drawing.bar.Size = Vector2.new(healthBarWidth, HealthBarSettings.BarHeight)
                            drawing.bar.Position = barPos
                            drawing.bar.Visible = true
                            
                            -- 文字
                            drawing.text.Text = tostring(healthPercent) .. "%"
                            drawing.text.Size = HealthBarSettings.TextSize
                            drawing.text.Position = Vector2.new(
                                screenPos.X + HealthBarSettings.TextOffset.X,
                                screenPos.Y + HealthBarSettings.TextOffset.Y
                            )
                            drawing.text.Visible = true
                        else
                            -- 不在屏幕内则隐藏
                            for _, obj in pairs(drawing) do
                                obj.Visible = false
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- 处理杀手
    if HealthBarSettings.ShowKillerBars then
        local killers = workspace.Players:FindFirstChild("Killers")
        if killers then
            for _, killer in ipairs(killers:GetChildren()) do
                if killer:IsA("Model") then
                    local humanoid = killer:FindFirstChildOfClass("Humanoid")
                    local head = killer:FindFirstChild("Head")
                    
                    if humanoid and head then
                        -- 获取或创建绘制对象
                        if not HealthBarDrawings[killer] then
                            HealthBarDrawings[killer] = createHealthBarDrawing()
                        end
                        
                        local drawing = HealthBarDrawings[killer]
                        local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
                        
                        if onScreen then
                            -- 计算血量百分比
                            local healthPercent = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
                            local healthBarWidth = HealthBarSettings.BarWidth * (healthPercent / 100)
                            
                            -- 设置位置
                            local barPos = Vector2.new(
                                screenPos.X + HealthBarSettings.BarOffset.X - (HealthBarSettings.BarWidth / 2),
                                screenPos.Y + HealthBarSettings.BarOffset.Y
                            )
                            
                            -- 背景和边框
                            drawing.background.Size = Vector2.new(HealthBarSettings.BarWidth, HealthBarSettings.BarHeight)
                            drawing.background.Position = barPos
                            drawing.background.Visible = true
                            
                            drawing.outline.Size = Vector2.new(HealthBarSettings.BarWidth, HealthBarSettings.BarHeight)
                            drawing.outline.Position = barPos
                            drawing.outline.Visible = true
                            
                            -- 血量条
                            drawing.bar.Color = getHealthColor(humanoid, true)
                            drawing.bar.Size = Vector2.new(healthBarWidth, HealthBarSettings.BarHeight)
                            drawing.bar.Position = barPos
                            drawing.bar.Visible = true
                            
                            -- 文字
                            drawing.text.Text = tostring(healthPercent) .. "%"
                            drawing.text.Size = HealthBarSettings.TextSize
                            drawing.text.Position = Vector2.new(
                                screenPos.X + HealthBarSettings.TextOffset.X,
                                screenPos.Y + HealthBarSettings.TextOffset.Y
                            )
                            drawing.text.Visible = true
                        else
                            -- 不在屏幕内则隐藏
                            for _, obj in pairs(drawing) do
                                obj.Visible = false
                            end
                        end
                    end
                end
            end
        end
    end
end

-- 清理血量条
local function cleanupHealthBars()
    for _, drawing in pairs(HealthBarDrawings) do
        for _, obj in pairs(drawing) do
            if obj then
                obj:Remove()
            end
        end
    end
    HealthBarDrawings = {}
end

-- 主开关
Visual:AddToggle("HealthBarsToggle", {
    Text = "启用血量条",
    Default = false,
    Callback = function(enabled)
        if enabled then
            -- 初始化连接
            if not HealthBarSettings.connection then
                HealthBarSettings.connection = game:GetService("RunService").RenderStepped:Connect(updateHealthBars)
            end
            
            -- 监听角色移除
            if not HealthBarSettings.removedConnection then
                HealthBarSettings.removedConnection = workspace.DescendantRemoving:Connect(function(descendant)
                    if HealthBarDrawings[descendant] then
                        for _, obj in pairs(HealthBarDrawings[descendant]) do
                            obj:Remove()
                        end
                        HealthBarDrawings[descendant] = nil
                    end
                end)
            end
        else
            -- 关闭连接
            if HealthBarSettings.connection then
                HealthBarSettings.connection:Disconnect()
                HealthBarSettings.connection = nil
            end
            
            if HealthBarSettings.removedConnection then
                HealthBarSettings.removedConnection:Disconnect()
                HealthBarSettings.removedConnection = nil
            end
            
            -- 清理绘制对象
            cleanupHealthBars()
        end
    end
})

-- 幸存者开关
Visual:AddToggle("ShowSurvivorBars", {
    Text = "显示幸存者血量条",
    Default = true,
    Callback = function(enabled)
        HealthBarSettings.ShowSurvivorBars = enabled
    end
})

-- 杀手开关
Visual:AddToggle("ShowKillerBars", {
    Text = "显示杀手血量条",
    Default = true,
    Callback = function(enabled)
        HealthBarSettings.ShowKillerBars = enabled
    end
})

-- 大小设置
Visual:AddSlider("BarWidth", {
    Text = "血量条宽度",
    Min = 50,
    Max = 200,
    Default = 100,
    Rounding = 0,
    Callback = function(value)
        HealthBarSettings.BarWidth = value
    end
})

Visual:AddSlider("BarHeight", {
    Text = "血量条高度",
    Min = 3,
    Max = 15,
    Default = 5,
    Rounding = 0,
    Callback = function(value)
        HealthBarSettings.BarHeight = value
    end
})

Visual:AddSlider("TextSize", {
    Text = "文字大小",
    Min = 10,
    Max = 20,
    Default = 14,
    Rounding = 0,
    Callback = function(value)
        HealthBarSettings.TextSize = value
    end
})

-- 位置调整
Visual:AddSlider("BarOffsetY", {
    Text = "垂直偏移",
    Min = -50,
    Max = 50,
    Default = -30,
    Rounding = 0,
    Callback = function(value)
        HealthBarSettings.BarOffset = Vector2.new(HealthBarSettings.BarOffset.X, value)
        HealthBarSettings.TextOffset = Vector2.new(HealthBarSettings.TextOffset.X, value - 10)
    end
})



local Visual = Tabs.Esp:AddRightGroupbox("3D方框绘制")

-- 3D方框绘制设置
local Box3DSettings = {
    -- 基本设置
    Enabled = false,
    ShowSurvivorBoxes = true,
    ShowKillerBoxes = true,
    
    -- 颜色设置
    SurvivorColor = Color3.fromRGB(0, 255, 255), -- 青色
    KillerColor = Color3.fromRGB(255, 0, 0),     -- 红色
    UseTeamColor = true,
    
    -- 样式设置
    Thickness = 1,
    Transparency = 0.7,
    BoxHeightOffset = 0.5,
    
    -- 比例设置
    SurvivorBoxScale = 1.0,
    KillerBoxScale = 1.2,
    
    -- 宽度调节
    LeftWidthScale = 1.0,
    RightWidthScale = 1.0,
    
    -- 深度调节 (加强版)
    FrontExtend = 1.0,
    BackExtend = 1.0,
    FrontExtendMultiplier = 1.0,  -- 前延伸倍数
    BackExtendMultiplier = 1.0,   -- 后延伸倍数
    
    -- 高度调节
    HeadOffset = 1.5,
    FootOffset = 0.2,
    BoxHeightScale = 1.0,         -- 方框高度比例
    VerticalOffset = 0,           -- 垂直偏移
    
    -- 连接线
    connection = nil,
    removedConnection = nil
}

-- 存储所有3D方框绘制对象
local Box3DDrawings = {}

-- 创建3D方框绘制对象
local function create3DBoxDrawing()
    local drawing = {
        lines = {},
        visible = false
    }
    
    for i = 1, 12 do
        drawing.lines[i] = Drawing.new("Line")
        drawing.lines[i].Thickness = Box3DSettings.Thickness
        drawing.lines[i].Transparency = Box3DSettings.Transparency
        drawing.lines[i].Visible = false
    end
    
    return drawing
end

-- 计算模型的3D边界框（全方位调节）
local function calculateModelBoundingBox(model, isKiller)
    local rootPart = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso")
    local head = model:FindFirstChild("Head")
    
    if rootPart then
        local size = rootPart.Size
        local cframe = rootPart.CFrame
        
        -- 应用比例调整
        local scale = isKiller and Box3DSettings.KillerBoxScale or Box3DSettings.SurvivorBoxScale
        size = size * scale
        
        -- 计算基础高度并应用高度比例
        local baseHeight = 5
        if head then
            baseHeight = (head.Position.Y - rootPart.Position.Y) * 2
        end
        local height = (baseHeight + Box3DSettings.HeadOffset + Box3DSettings.FootOffset) * Box3DSettings.BoxHeightScale
        
        -- 调整左右宽度
        local leftOffset = (size.X/2) * Box3DSettings.LeftWidthScale
        local rightOffset = (size.X/2) * Box3DSettings.RightWidthScale
        
        -- 调整前后延伸 (加强版)
        local frontOffset = (size.Z/2) * Box3DSettings.FrontExtend * Box3DSettings.FrontExtendMultiplier
        local backOffset = (size.Z/2) * Box3DSettings.BackExtend * Box3DSettings.BackExtendMultiplier
        
        -- 计算最小和最大点
        local min = Vector3.new(
            cframe.Position.X - leftOffset,
            cframe.Position.Y - height/2 + Box3DSettings.FootOffset,
            cframe.Position.Z - backOffset
        )
        
        local max = Vector3.new(
            cframe.Position.X + rightOffset,
            cframe.Position.Y + height/2 + Box3DSettings.HeadOffset,
            cframe.Position.Z + frontOffset
        )
        
        -- 应用高度偏移和垂直偏移
        min = Vector3.new(min.X, min.Y + Box3DSettings.BoxHeightOffset + Box3DSettings.VerticalOffset, min.Z)
        max = Vector3.new(max.X, max.Y + Box3DSettings.BoxHeightOffset + Box3DSettings.VerticalOffset, max.Z)
        
        return min, max
    else
        -- 回退到遍历所有部件的方法
        local min = Vector3.new(math.huge, math.huge, math.huge)
        local max = Vector3.new(-math.huge, -math.huge, -math.huge)
        
        for _, part in ipairs(model:GetDescendants()) do
            if part:IsA("BasePart") then
                local cframe = part.CFrame
                local size = part.Size
                
                local scale = isKiller and Box3DSettings.KillerBoxScale or Box3DSettings.SurvivorBoxScale
                size = size * scale
                
                -- 调整左右宽度
                local leftOffset = (size.X/2) * Box3DSettings.LeftWidthScale
                local rightOffset = (size.X/2) * Box3DSettings.RightWidthScale
                
                -- 调整前后延伸 (加强版)
                local frontOffset = (size.Z/2) * Box3DSettings.FrontExtend * Box3DSettings.FrontExtendMultiplier
                local backOffset = (size.Z/2) * Box3DSettings.BackExtend * Box3DSettings.BackExtendMultiplier
                
                -- 计算顶点（考虑前后延伸）
                local vertices = {
                    cframe * Vector3.new(rightOffset, (size.Y/2) * Box3DSettings.BoxHeightScale, frontOffset),
                    cframe * Vector3.new(-leftOffset, (size.Y/2) * Box3DSettings.BoxHeightScale, frontOffset),
                    cframe * Vector3.new(rightOffset, (-size.Y/2) * Box3DSettings.BoxHeightScale, frontOffset),
                    cframe * Vector3.new(-leftOffset, (-size.Y/2) * Box3DSettings.BoxHeightScale, frontOffset),
                    cframe * Vector3.new(rightOffset, (size.Y/2) * Box3DSettings.BoxHeightScale, -backOffset),
                    cframe * Vector3.new(-leftOffset, (size.Y/2) * Box3DSettings.BoxHeightScale, -backOffset),
                    cframe * Vector3.new(rightOffset, (-size.Y/2) * Box3DSettings.BoxHeightScale, -backOffset),
                    cframe * Vector3.new(-leftOffset, (-size.Y/2) * Box3DSettings.BoxHeightScale, -backOffset)
                }
                
                -- 更新最小和最大点
                for _, vertex in ipairs(vertices) do
                    min = Vector3.new(
                        math.min(min.X, vertex.X),
                        math.min(min.Y, vertex.Y),
                        math.min(min.Z, vertex.Z)
                    )
                    max = Vector3.new(
                        math.max(max.X, vertex.X),
                        math.max(max.Y, vertex.Y),
                        math.max(max.Z, vertex.Z)
                    )
                end
            end
        end
        
        -- 应用高度偏移和垂直偏移
        min = Vector3.new(min.X, min.Y + Box3DSettings.BoxHeightOffset + Box3DSettings.VerticalOffset, min.Z)
        max = Vector3.new(max.X, max.Y + Box3DSettings.BoxHeightOffset + Box3DSettings.VerticalOffset, max.Z)
        
        return min, max
    end
end

-- 更新单个3D方框
local function updateSingle3DBox(model, drawing, color, isKiller)
    local camera = workspace.CurrentCamera
    local min, max = calculateModelBoundingBox(model, isKiller)
    
    -- 计算立方体的8个顶点
    local vertices = {
        Vector3.new(max.X, max.Y, max.Z), -- 右上后
        Vector3.new(min.X, max.Y, max.Z), -- 左上后
        Vector3.new(max.X, min.Y, max.Z), -- 右下后
        Vector3.new(min.X, min.Y, max.Z), -- 左下后
        Vector3.new(max.X, max.Y, min.Z), -- 右上前
        Vector3.new(min.X, max.Y, min.Z), -- 左上前
        Vector3.new(max.X, min.Y, min.Z), -- 右下前
        Vector3.new(min.X, min.Y, min.Z)  -- 左下前
    }
    
    -- 转换顶点到屏幕空间
    local screenVertices = {}
    local anyVisible = false
    
    for i, vertex in ipairs(vertices) do
        local screenPos, onScreen = camera:WorldToViewportPoint(vertex)
        screenVertices[i] = Vector2.new(screenPos.X, screenPos.Y)
        if onScreen then anyVisible = true end
    end
    
    -- 设置线条属性
    for _, line in pairs(drawing.lines) do
        line.Color = color
        line.Thickness = Box3DSettings.Thickness
        line.Transparency = Box3DSettings.Transparency
    end
    
    -- 绘制立方体边线
    if anyVisible then
        -- 前面4条边
        drawing.lines[1].From = screenVertices[5] drawing.lines[1].To = screenVertices[6] -- 上面前
        drawing.lines[2].From = screenVertices[6] drawing.lines[2].To = screenVertices[8] -- 左边前
        drawing.lines[3].From = screenVertices[8] drawing.lines[3].To = screenVertices[7] -- 下面前
        drawing.lines[4].From = screenVertices[7] drawing.lines[4].To = screenVertices[5] -- 右边前
        
        -- 后面4条边
        drawing.lines[5].From = screenVertices[1] drawing.lines[5].To = screenVertices[2] -- 上面后
        drawing.lines[6].From = screenVertices[2] drawing.lines[6].To = screenVertices[4] -- 左边后
        drawing.lines[7].From = screenVertices[4] drawing.lines[7].To = screenVertices[3] -- 下面后
        drawing.lines[8].From = screenVertices[3] drawing.lines[8].To = screenVertices[1] -- 右边后
        
        -- 连接前后面的4条边
        drawing.lines[9].From = screenVertices[1] drawing.lines[9].To = screenVertices[5] -- 右上
        drawing.lines[10].From = screenVertices[2] drawing.lines[10].To = screenVertices[6] -- 左上
        drawing.lines[11].From = screenVertices[3] drawing.lines[11].To = screenVertices[7] -- 右下
        drawing.lines[12].From = screenVertices[4] drawing.lines[12].To = screenVertices[8] -- 左下
        
        -- 显示所有线条
        for _, line in pairs(drawing.lines) do
            line.Visible = true
        end
        
        drawing.visible = true
    else
        if drawing.visible then
            for _, line in pairs(drawing.lines) do
                line.Visible = false
            end
            drawing.visible = false
        end
    end
end

-- 更新所有3D方框
local function update3DBoxes()
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    local camera = workspace.CurrentCamera
    
    -- 先隐藏所有现有的方框
    for model, drawing in pairs(Box3DDrawings) do
        if not model or not model.Parent then
            -- 模型已不存在，清理绘制对象
            for _, line in pairs(drawing.lines) do
                line:Remove()
            end
            Box3DDrawings[model] = nil
        else
            -- 暂时隐藏
            for _, line in pairs(drawing.lines) do
                line.Visible = false
            end
            drawing.visible = false
        end
    end
    
    -- 处理幸存者方框
    if Box3DSettings.ShowSurvivorBoxes then
        local survivors = workspace:FindFirstChild("Survivors") or workspace.Players:FindFirstChild("Survivors")
        if survivors then
            for _, survivor in ipairs(survivors:GetChildren()) do
                if survivor:IsA("Model") and survivor ~= localPlayer.Character then
                    -- 获取或创建绘制对象
                    if not Box3DDrawings[survivor] then
                        Box3DDrawings[survivor] = create3DBoxDrawing()
                    end
                    
                    updateSingle3DBox(survivor, Box3DDrawings[survivor], Box3DSettings.SurvivorColor, false)
                end
            end
        end
        
        -- 额外检查玩家列表中的幸存者
        for _, player in ipairs(players:GetPlayers()) do
            if player ~= localPlayer and player.Character and not player.Character:FindFirstChild("IsKiller") then
                if not Box3DDrawings[player.Character] then
                    Box3DDrawings[player.Character] = create3DBoxDrawing()
                end
                
                updateSingle3DBox(player.Character, Box3DDrawings[player.Character], Box3DSettings.SurvivorColor, false)
            end
        end
    end
    
    -- 处理杀手方框
    if Box3DSettings.ShowKillerBoxes then
        local killers = workspace:FindFirstChild("Killers") or workspace.Players:FindFirstChild("Killers")
        if killers then
            for _, killer in ipairs(killers:GetChildren()) do
                if killer:IsA("Model") and killer ~= localPlayer.Character then
                    -- 获取或创建绘制对象
                    if not Box3DDrawings[killer] then
                        Box3DDrawings[killer] = create3DBoxDrawing()
                    end
                    
                    updateSingle3DBox(killer, Box3DDrawings[killer], Box3DSettings.KillerColor, true)
                end
            end
        end
        
        -- 额外检查玩家列表中的杀手
        for _, player in ipairs(players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("IsKiller") then
                if not Box3DDrawings[player.Character] then
                    Box3DDrawings[player.Character] = create3DBoxDrawing()
                end
                
                updateSingle3DBox(player.Character, Box3DDrawings[player.Character], Box3DSettings.KillerColor, true)
            end
        end
    end
end

-- 清理3D方框
local function cleanup3DBoxes()
    for _, drawing in pairs(Box3DDrawings) do
        if drawing then
            for _, line in pairs(drawing.lines) do
                line:Remove()
            end
        end
    end
    Box3DDrawings = {}
end

-- 主开关
Visual:AddToggle("Box3DToggle", {
    Text = "启用3D方框",
    Default = false,
    Callback = function(enabled)
        Box3DSettings.Enabled = enabled
        if enabled then
            -- 初始化连接
            if not Box3DSettings.connection then
                Box3DSettings.connection = game:GetService("RunService").RenderStepped:Connect(update3DBoxes)
            end
            
            -- 监听角色移除
            if not Box3DSettings.removedConnection then
                Box3DSettings.removedConnection = workspace.DescendantRemoving:Connect(function(descendant)
                    if Box3DDrawings[descendant] then
                        for _, line in pairs(Box3DDrawings[descendant].lines) do
                            line:Remove()
                        end
                        Box3DDrawings[descendant] = nil
                    end
                end)
            end
        else
            -- 关闭连接
            if Box3DSettings.connection then
                Box3DSettings.connection:Disconnect()
                Box3DSettings.connection = nil
            end
            
            if Box3DSettings.removedConnection then
                Box3DSettings.removedConnection:Disconnect()
                Box3DSettings.removedConnection = nil
            end
            
            -- 清理绘制对象
            cleanup3DBoxes()
        end
    end
})

-- 幸存者开关
Visual:AddToggle("ShowSurvivorBoxes", {
    Text = "显示幸存者方框",
    Default = true,
    Callback = function(enabled)
        Box3DSettings.ShowSurvivorBoxes = enabled
    end
})

-- 杀手开关
Visual:AddToggle("ShowKillerBoxes", {
    Text = "显示杀手方框",
    Default = true,
    Callback = function(enabled)
        Box3DSettings.ShowKillerBoxes = enabled
    end
})

-- 样式设置
Visual:AddSlider("BoxThickness", {
    Text = "线条粗细",
    Min = 1,
    Max = 5,
    Default = 1,
    Rounding = 0,
    Callback = function(value)
        Box3DSettings.Thickness = value
    end
})

Visual:AddSlider("BoxTransparency", {
    Text = "透明度",
    Min = 0,
    Max = 1,
    Default = 0.7,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.Transparency = value
    end
})

Visual:AddSlider("BoxHeightOffset", {
    Text = "高度偏移",
    Min = 0,
    Max = 2,
    Default = 0.5,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.BoxHeightOffset = value
    end
})


Visual:AddSlider("BoxHeightScale", {
    Text = "方框高度比例",
    Min = 0.5,
    Max = 2.5,
    Default = 1.2,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.BoxHeightScale = value
    end
})


Visual:AddSlider("VerticalOffset", {
    Text = "垂直偏移",
    Min = -5,
    Max = 5,
    Default = -0.5,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.VerticalOffset = value
    end
})


Visual:AddSlider("SurvivorBoxScale", {
    Text = "幸存者方框比例",
    Min = 1.7,
    Max = 2,
    Default = 1.7,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.SurvivorBoxScale = value
    end
})

Visual:AddSlider("KillerBoxScale", {
    Text = "杀手方框比例",
    Min = 1.7,
    Max = 2,
    Default = 1.7,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.KillerBoxScale = value
    end
})

Visual:AddSlider("LeftWidthScale", {
    Text = "左侧宽度比例",
    Min = 1.0,
    Max = 2,
    Default = 1.0,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.LeftWidthScale = value
    end
})

Visual:AddSlider("RightWidthScale", {
    Text = "右侧宽度比例",
    Min = 0.9,
    Max = 2,
    Default = 0.9,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.RightWidthScale = value
    end
})


Visual:AddSlider("FrontExtend", {
    Text = "前延伸基础值",
    Min = 1.9,
    Max = 2,
    Default = 1.9,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.FrontExtend = value
    end
})

Visual:AddSlider("BackExtend", {
    Text = "后延伸基础值",
    Min = 1.8,
    Max = 2,
    Default = 1.8,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.BackExtend = value
    end
})

Visual:AddSlider("FrontExtendMultiplier", {
    Text = "前延伸倍数",
    Min = 1.0,
    Max = 3.0,
    Default = 1.0,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.FrontExtendMultiplier = value
    end
})

Visual:AddSlider("BackExtendMultiplier", {
    Text = "后延伸倍数",
    Min = 1.0,
    Max = 3.0,
    Default = 1.0,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.BackExtendMultiplier = value
    end
})

-- 高度调节
Visual:AddSlider("HeadOffset", {
    Text = "头部偏移",
    Min = 1.5,
    Max = 3,
    Default = 1.5,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.HeadOffset = value
    end
})

Visual:AddSlider("FootOffset", {
    Text = "脚部偏移",
    Min = 0.2,
    Max = 1,
    Default = 0.2,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.FootOffset = value
    end
})

local Visual = Tabs.Esp:AddLeftGroupbox("玩家名称绘制")

-- 名称绘制设置
local NameTagSettings = {
    ShowSurvivorNames = true,
    ShowKillerNames = true,
    BaseTextSize = 14,
    MinTextSize = 10,
    MaxTextSize = 20,
    TextOffset = Vector3.new(0, 3, 0), -- 头顶上方偏移
    DistanceScale = {
        MinDistance = 10,
        MaxDistance = 50
    },
    SurvivorColor = Color3.fromRGB(0, 191, 255), -- 幸存者蓝色
    KillerColor = Color3.fromRGB(255, 0, 0),     -- 杀手红色
    OutlineColor = Color3.fromRGB(0, 0, 0),       -- 文字描边颜色
    ShowDistance = true                          -- 是否显示距离
}

-- 存储所有名称绘制对象
local NameTagDrawings = {}

-- 创建名称绘制对象
local function createNameTagDrawing()
    local drawing = Drawing.new("Text")
    drawing.Size = NameTagSettings.BaseTextSize
    drawing.Center = true
    drawing.Outline = true
    drawing.OutlineColor = NameTagSettings.OutlineColor
    drawing.Font = 2  -- 使用更清晰的字体
    return drawing
end

-- 计算头顶位置
local function getHeadPosition(character)
    local head = character:FindFirstChild("Head")
    if head then
        local headHeight = head.Size.Y
        return head.Position + Vector3.new(0, headHeight + 0.5, 0)  -- 头顶上方0.5单位
    end
    return character:GetPivot().Position
end

-- 更新名称标签
local function updateNameTags()
    local camera = workspace.CurrentCamera
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    local localCharacter = localPlayer.Character
    local localRoot = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")

    if not localRoot then return end

    -- 处理幸存者名称
    if NameTagSettings.ShowSurvivorNames then
        local survivors = workspace.Players:FindFirstChild("Survivors")
        if survivors then
            for _, survivor in ipairs(survivors:GetChildren()) do
                if survivor:IsA("Model") and survivor ~= localCharacter then
                    local humanoid = survivor:FindFirstChildOfClass("Humanoid")
                    
                    if humanoid and humanoid.Health > 0 then  -- 只显示活着的玩家
                        -- 获取或创建绘制对象
                        if not NameTagDrawings[survivor] then
                            NameTagDrawings[survivor] = createNameTagDrawing()
                        end
                        
                        local drawing = NameTagDrawings[survivor]
                        local headPos = getHeadPosition(survivor)
                        local screenPos, onScreen = camera:WorldToViewportPoint(headPos + NameTagSettings.TextOffset)
                        
                        if onScreen then
                            -- 计算距离和缩放比例
                            local distance = (headPos - localRoot.Position).Magnitude
                            local scale = math.clamp(
                                1 - (distance - NameTagSettings.DistanceScale.MinDistance) / 
                                (NameTagSettings.DistanceScale.MaxDistance - NameTagSettings.DistanceScale.MinDistance), 
                                0.3, 1  -- 最小缩放0.3倍
                            )
                            
                            -- 动态调整文字大小
                            local textSize = math.floor(NameTagSettings.BaseTextSize * scale)
                            textSize = math.clamp(textSize, NameTagSettings.MinTextSize, NameTagSettings.MaxTextSize)
                            
                            -- 设置显示文本
                            local displayText = survivor.Name
                            if NameTagSettings.ShowDistance then
                                displayText = string.format("%s [%d]", survivor.Name, math.floor(distance))
                            end
                            
                            -- 设置绘制属性
                            drawing.Text = displayText
                            drawing.Color = NameTagSettings.SurvivorColor
                            drawing.Size = textSize
                            drawing.Position = Vector2.new(screenPos.X, screenPos.Y)
                            drawing.Visible = true
                        else
                            drawing.Visible = false
                        end
                    end
                end
            end
        end
    end

    -- 处理杀手名称
    if NameTagSettings.ShowKillerNames then
        local killers = workspace.Players:FindFirstChild("Killers")
        if killers then
            for _, killer in ipairs(killers:GetChildren()) do
                if killer:IsA("Model") then
                    local humanoid = killer:FindFirstChildOfClass("Humanoid")
                    
                    if humanoid and humanoid.Health > 0 then  -- 只显示活着的杀手
                        -- 获取或创建绘制对象
                        if not NameTagDrawings[killer] then
                            NameTagDrawings[killer] = createNameTagDrawing()
                        end
                        
                        local drawing = NameTagDrawings[killer]
                        local headPos = getHeadPosition(killer)
                        local screenPos, onScreen = camera:WorldToViewportPoint(headPos + NameTagSettings.TextOffset)
                        
                        if onScreen then
                            -- 计算距离和缩放比例
                            local distance = (headPos - localRoot.Position).Magnitude
                            local scale = math.clamp(
                                1 - (distance - NameTagSettings.DistanceScale.MinDistance) / 
                                (NameTagSettings.DistanceScale.MaxDistance - NameTagSettings.DistanceScale.MinDistance), 
                                0.3, 1  -- 最小缩放0.3倍
                            )
                            
                            -- 动态调整文字大小
                            local textSize = math.floor(NameTagSettings.BaseTextSize * scale)
                            textSize = math.clamp(textSize, NameTagSettings.MinTextSize, NameTagSettings.MaxTextSize)
                            
                            -- 设置显示文本
                            local displayText = killer.Name
                            if NameTagSettings.ShowDistance then
                                displayText = string.format("%s [%d]", killer.Name, math.floor(distance))
                            end
                            
                            -- 设置绘制属性
                            drawing.Text = displayText
                            drawing.Color = NameTagSettings.KillerColor
                            drawing.Size = textSize
                            drawing.Position = Vector2.new(screenPos.X, screenPos.Y)
                            drawing.Visible = true
                        else
                            drawing.Visible = false
                        end
                    end
                end
            end
        end
    end
end

-- 清理名称标签
local function cleanupNameTags()
    for _, drawing in pairs(NameTagDrawings) do
        if drawing then
            drawing:Remove()
        end
    end
    NameTagDrawings = {}
end

-- 主开关
Visual:AddToggle("NameTagsToggle", {
    Text = "启用名称绘制",
    Default = false,
    Callback = function(enabled)
        if enabled then
            -- 初始化连接
            if not NameTagSettings.connection then
                NameTagSettings.connection = game:GetService("RunService").RenderStepped:Connect(updateNameTags)
            end
            
            -- 监听角色移除
            if not NameTagSettings.removedConnection then
                NameTagSettings.removedConnection = game:GetService("Players").PlayerRemoving:Connect(function(player)
                    for model, drawing in pairs(NameTagDrawings) do
                        if model.Name == player.Name then
                            drawing:Remove()
                            NameTagDrawings[model] = nil
                        end
                    end
                end)
            end
        else
            -- 关闭连接
            if NameTagSettings.connection then
                NameTagSettings.connection:Disconnect()
                NameTagSettings.connection = nil
            end
            
            if NameTagSettings.removedConnection then
                NameTagSettings.removedConnection:Disconnect()
                NameTagSettings.removedConnection = nil
            end
            
            -- 清理绘制对象
            cleanupNameTags()
        end
    end
})

-- 幸存者开关
Visual:AddToggle("ShowSurvivorNames", {
    Text = "显示幸存者名称",
    Default = true,
    Callback = function(enabled)
        NameTagSettings.ShowSurvivorNames = enabled
    end
})

-- 杀手开关
Visual:AddToggle("ShowKillerNames", {
    Text = "显示杀手名称",
    Default = true,
    Callback = function(enabled)
        NameTagSettings.ShowKillerNames = enabled
    end
})

-- 距离显示开关
Visual:AddToggle("ShowDistance", {
    Text = "显示距离",
    Default = true,
    Callback = function(enabled)
        NameTagSettings.ShowDistance = enabled
    end
})

-- 大小设置
Visual:AddSlider("BaseTextSize", {
    Text = "基础文字大小",
    Min = 10,
    Max = 20,
    Default = 14,
    Rounding = 0,
    Callback = function(value)
        NameTagSettings.BaseTextSize = value
    end
})

-- 距离设置
Visual:AddSlider("MinDistance", {
    Text = "最小距离",
    Min = 5,
    Max = 200,
    Default = 10,
    Rounding = 0,
    Callback = function(value)
        NameTagSettings.DistanceScale.MinDistance = value
    end
})

Visual:AddSlider("MaxDistance", {
    Text = "最大距离",
    Min = 30,
    Max = 500,
    Default = 50,
    Rounding = 0,
    Callback = function(value)
        NameTagSettings.DistanceScale.MaxDistance = value
    end
})


 Visual = Tabs.Esp:AddLeftGroupbox("绘制功能")
local LibESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImamGV/Script/main/ESP"))()




local camera = workspace.CurrentCamera
local localPlayer = game:GetService("Players").LocalPlayer

Visual:AddToggle("SurvivorHealth", {
    Text = "绘制幸存者血量(文字)",
    Default = false,
    Callback = function(v)
        if v then
            local sur = workspace.Players.Survivors
            
            local function survivoresp(char)
                local billboard = Instance.new("BillboardGui")
                billboard.Size = UDim2.new(3, 0, 1, 0)
                billboard.StudsOffset = Vector3.new(0, 1.5, 0)
                billboard.Adornee = char.Head
                billboard.Parent = char.Head
                billboard.AlwaysOnTop = true
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Position = UDim2.new(0, 0, 0, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextScaled = false
                textLabel.Text = "血量: "..char.Humanoid.Health.."/"..char.Humanoid.MaxHealth
                textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                textLabel.Font = Enum.Font.Arcade
                textLabel.Parent = billboard

              
                local distanceUpdate
                distanceUpdate = game:GetService("RunService").RenderStepped:Connect(function()
                    if char:FindFirstChild("Head") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (char.Head.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                        
                        local textSize = math.clamp(30 - (distance / 2), 12, 20)
                        textLabel.TextSize = textSize
                    end
                end)

                local healthUpdate = char:FindFirstChild("Humanoid").HealthChanged:Connect(function()
                    textLabel.Text = "血量: "..char:FindFirstChild("Humanoid").Health.."/"..char:FindFirstChild("Humanoid").MaxHealth
                end)

                char:FindFirstChild("Humanoid").Died:Connect(function()
                    distanceUpdate:Disconnect()
                    healthUpdate:Disconnect()
                    textLabel.Text = ""
                end)

                return {billboard = billboard, connections = {distanceUpdate, healthUpdate}}
            end

            getgenv().SurvivorHealthConnections = {
                Added = sur.DescendantAdded:Connect(function(v)
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                        repeat wait() until v:FindFirstChild("Humanoid")
                        survivoresp(v)
                    end
                end)
            }

            for _,v in pairs(sur:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                    repeat wait() until v:FindFirstChild("Humanoid")
                    survivoresp(v)
                end
            end
        else
            if getgenv().SurvivorHealthConnections then
                getgenv().SurvivorHealthConnections.Added:Disconnect()
            end
            
            for _,v in pairs(workspace.Players.Survivors:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Head") then
                    for _,child in pairs(v.Head:GetChildren()) do
                        if child:IsA("BillboardGui") then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    end
})

Visual:AddToggle("KillerHealth", {
    Text = "绘制杀手血量(文字)",
    Default = false,
    Callback = function(v)
        if v then
            local kil = workspace.Players.Killers
            
            local function killeresp(char)
                local billboard = Instance.new("BillboardGui")
                billboard.Size = UDim2.new(3, 0, 1, 0)
                billboard.StudsOffset = Vector3.new(0, 1.5, 0)
                billboard.Adornee = char.Head
                billboard.Parent = char.Head
                billboard.AlwaysOnTop = true
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Position = UDim2.new(0, 0, 0, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextScaled = false
                textLabel.Text = "血量: "..char.Humanoid.Health.."/"..char.Humanoid.MaxHealth
                textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                textLabel.Font = Enum.Font.Arcade
                textLabel.Parent = billboard

                -- 添加距离检测更新
                local distanceUpdate
                distanceUpdate = game:GetService("RunService").RenderStepped:Connect(function()
                    if char:FindFirstChild("Head") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (char.Head.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                        -- 根据距离动态调整文字大小 (10-30米范围内变化)
                        local textSize = math.clamp(30 - (distance / 2), 12, 20)
                        textLabel.TextSize = textSize
                    end
                end)

                local healthUpdate = char:FindFirstChild("Humanoid").HealthChanged:Connect(function()
                    textLabel.Text = "血量: "..char:FindFirstChild("Humanoid").Health.."/"..char:FindFirstChild("Humanoid").MaxHealth
                end)

                char:FindFirstChild("Humanoid").Died:Connect(function()
                    distanceUpdate:Disconnect()
                    healthUpdate:Disconnect()
                    textLabel.Text = ""
                end)

                return {billboard = billboard, connections = {distanceUpdate, healthUpdate}}
            end

            getgenv().KillerHealthConnections = {
                Added = kil.DescendantAdded:Connect(function(v)
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                        repeat wait() until v:FindFirstChild("Humanoid")
                        killeresp(v)
                    end
                end)
            }

            for _,v in pairs(kil:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                    repeat wait() until v:FindFirstChild("Humanoid")
                    killeresp(v)
                end
            end
        else
            if getgenv().KillerHealthConnections then
                getgenv().KillerHealthConnections.Added:Disconnect()
            end
            
            for _,v in pairs(workspace.Players.Killers:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Head") then
                    for _,child in pairs(v.Head:GetChildren()) do
                        if child:IsA("BillboardGui") then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    end
})

Visual:AddToggle("EKE",{
    Text = "杀手机器人绘制",
    Callback = function(v)
        if v then
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Name == "PizzaDeliveryRig" or v.Name == "Bunny" or v.Name == "Mafiaso1" or v.Name == "Mafiaso2" or v.Name == "Mafiaso3" then
                    LibESP:AddESP(v, "披萨送货员", Color3.fromRGB(255, 52, 179), 14, "Other_ESP")
                elseif v:IsA("Model") and v.Name == "1x1x1x1Zombie" then
                    LibESP:AddESP(v, "1x1x1x1 (僵尸)", Color3.fromRGB(224, 102, 255), 14, "Other_ESP")
                end
            end
            OtherESP = workspace.DescendantAdded:Connect(function(v)
                if v:IsA("Model") and v.Name == "PizzaDeliveryRig" or v.Name == "Bunny" or v.Name == "Mafiaso1" or v.Name == "Mafiaso2" or v.Name == "Mafiaso3" then
                    LibESP:AddESP(v, "披萨送货员", Color3.fromRGB(255, 52, 179), 14, "Other_ESP")
                elseif v:IsA("Model") and v.Name == "1x1x1x1Zombie" then
                    LibESP:AddESP(v, "1x1x1x1 (僵尸)", Color3.fromRGB(224, 102, 255), 14, "Other_ESP")
                end
            end)
        else
            OtherESP:Disconnect()
            LibESP:Delete("Other_ESP")
        end
    end
})

Visual:AddToggle("GeneratorESP", {
    Text = "绘制电机",
    Default = false,
    Callback = function(enabled)
        -- 将 generatorData 移到回调函数内部，确保每次开启都是独立的作用域
        local generatorData = {}
        
        if enabled then
            local scanInterval = 0.5 
            local lastScanTime = 0
            
            local distanceSettings = {
                MinDistance = 5,
                MaxDistance = 100,
                MinScale = 0.8,
                MaxScale = 1.5,
                MinTextSize = 8,
                MaxTextSize = 10
            }
            
            local function updateGeneratorESP(gen, data)
                if not gen or not gen:FindFirstChild("Main") then return end
                
                local character = game:GetService("Players").LocalPlayer.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                
                if gen:FindFirstChild("Progress") then
                    local progress = gen.Progress.Value
                    if progress >= 99 then
                        if data.billboard then data.billboard:Destroy() end
                        if data.distanceBillboard then data.distanceBillboard:Destroy() end
                        if data.highlight then data.highlight:Destroy() end
                        generatorData[gen] = nil
                        return
                    end
                    
                    if data.textLabel then
                        data.textLabel.Text = string.format("电机进度: %d%%", progress)
                    end
                    
                    if humanoidRootPart and data.distanceLabel then
                        local distance = (gen.Main.Position - humanoidRootPart.Position).Magnitude
                        data.distanceLabel.Text = string.format("距离: %d米", math.floor(distance))
                        
                        local distanceRatio = math.clamp(
                            (distance - distanceSettings.MinDistance) / 
                            (distanceSettings.MaxDistance - distanceSettings.MinDistance),
                            0, 1
                        )
                        
                        local scale = distanceSettings.MinScale + 
                            distanceRatio * (distanceSettings.MaxScale - distanceSettings.MinScale)
                        
                        local textSize = distanceSettings.MinTextSize + 
                            distanceRatio * (distanceSettings.MaxTextSize - distanceSettings.MinTextSize)
                        
                        if data.billboard then data.billboard.Size = UDim2.new(4 * scale, 0, 1 * scale, 0) end
                        if data.distanceBillboard then data.distanceBillboard.Size = UDim2.new(4 * scale, 0, 1 * scale, 0) end
                        if data.textLabel then data.textLabel.TextSize = textSize end
                        if data.distanceLabel then data.distanceLabel.TextSize = textSize end
                        
                        local transparency = math.clamp((distance - 50) / 100, 0, 0.4)
                        if data.textLabel then data.textLabel.TextTransparency = transparency end
                        if data.distanceLabel then data.distanceLabel.TextTransparency = transparency end
                        if data.highlight then data.highlight.FillTransparency = 0.85 + (transparency * 0.5) end
                    end
                end
            end
            
            local function createGeneratorESP(gen)
                if not gen or not gen:FindFirstChild("Main") or generatorData[gen] then return end
                
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "GeneratorESP"
                billboard.Size = UDim2.new(4, 0, 1, 0)
                billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                billboard.Adornee = gen.Main
                billboard.Parent = gen.Main
                billboard.AlwaysOnTop = true
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 0.5, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextScaled = false
                textLabel.Text = "电机加载中..."
                textLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
                textLabel.Font = Enum.Font.Arcade
                textLabel.TextStrokeTransparency = 0
                textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                textLabel.TextSize = 8
                textLabel.Parent = billboard
                
                local distanceBillboard = Instance.new("BillboardGui")
                distanceBillboard.Name = "GeneratorDistanceESP"
                distanceBillboard.Size = UDim2.new(4, 0, 1, 0)
                distanceBillboard.StudsOffset = Vector3.new(0, 3.5, 0)
                distanceBillboard.Adornee = gen.Main
                distanceBillboard.Parent = gen.Main
                distanceBillboard.AlwaysOnTop = true
                
                local distanceLabel = Instance.new("TextLabel")
                distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
                distanceLabel.BackgroundTransparency = 1
                distanceLabel.TextScaled = false
                distanceLabel.Text = "计算距离中..."
                distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                distanceLabel.Font = Enum.Font.Arcade
                distanceLabel.TextStrokeTransparency = 0
                distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                distanceLabel.TextSize = 8
                distanceLabel.Parent = distanceBillboard
                
                local highlight = Instance.new("Highlight")
                highlight.Name = "GeneratorHighlight"
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.Enabled = true
                highlight.OutlineColor = Color3.fromRGB(0, 255, 255)
                highlight.FillColor = Color3.fromRGB(0, 255, 255)
                highlight.FillTransparency = 0.9
                highlight.OutlineTransparency = 0
                highlight.Parent = gen
                
                generatorData[gen] = {
                    billboard = billboard,
                    distanceBillboard = distanceBillboard,
                    textLabel = textLabel,
                    distanceLabel = distanceLabel,
                    highlight = highlight
                }
                
                gen.Destroying:Connect(function()
                    if generatorData[gen] then
                        if generatorData[gen].billboard then generatorData[gen].billboard:Destroy() end
                        if generatorData[gen].distanceBillboard then generatorData[gen].distanceBillboard:Destroy() end
                        if generatorData[gen].highlight then generatorData[gen].highlight:Destroy() end
                        generatorData[gen] = nil
                    end
                end)
            end
            
            local function scanGenerators()
                for _, gen in pairs(workspace:GetDescendants()) do
                    if gen:IsA("Model") and gen:FindFirstChild("Main") and gen.Name == "Generator" then
                        createGeneratorESP(gen)
                    end
                end
            end
            
            local mainConnection = workspace.DescendantAdded:Connect(function(v)
                if v:IsA("Model") and v:FindFirstChild("Main") and v.Name == "Generator" then
                    createGeneratorESP(v)
                end
            end)
            
            local heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
                lastScanTime = lastScanTime + deltaTime
                if lastScanTime >= scanInterval then
                    lastScanTime = 0
                    scanGenerators()
                end
                
                for gen, data in pairs(generatorData) do
                    if gen and gen.Parent then
                        updateGeneratorESP(gen, data)
                    else
                        if data.billboard then data.billboard:Destroy() end
                        if data.distanceBillboard then data.distanceBillboard:Destroy() end
                        if data.highlight then data.highlight:Destroy() end
                        generatorData[gen] = nil
                    end
                end
            end)
            
            -- 存储连接以便之后断开
            generatorData.connections = {
                main = mainConnection,
                heartbeat = heartbeatConnection
            }
        else
            -- 关闭功能时的清理逻辑
            if generatorData.connections then
                for _, connection in pairs(generatorData.connections) do
                    if connection then
                        connection:Disconnect()
                    end
                end
            end
            
            for gen, data in pairs(generatorData) do
                if type(data) == "table" then
                    if data.billboard then data.billboard:Destroy() end
                    if data.distanceBillboard then data.distanceBillboard:Destroy() end
                    if data.highlight then data.highlight:Destroy() end
                end
            end
        end
    end
})

Visual:AddToggle("ST",{
Text = "三角炸弹绘制",
Callback = function(v)
if v then
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Name == "SubspaceTripmine" and not v:FindFirstChild("SubspaceTripmine_ESP") then
LibESP:AddESP(v, "", Color3.fromRGB(255, 0, 255), 14, "SubspaceTripmine_ESP")
end
end
SubspaceTripmineESP = workspace.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Name == "SubspaceTripmine" and not v:FindFirstChild("SubspaceTripmine_ESP") then
LibESP:AddESP(v, "", Color3.fromRGB(255, 0, 255), 14, "SubspaceTripmine_ESP")
end
end)
else
SubspaceTripmineESP:Disconnect()
LibESP:Delete("SubspaceTripmine_ESP")
end
end})
Visual:AddToggle("ME",{
Text = "医疗箱绘制",
Callback = function(v)
if v then
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Name == "Medkit" and not v:FindFirstChild("Medkit_ESP") then
LibESP:AddESP(v, "Medkit", Color3.fromRGB(187, 255, 255), 14, "Medkit_ESP")
end
end
MedkitESP = workspace.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Name == "Medkit" and not v:FindFirstChild("Medkit_ESP") then
LibESP:AddESP(v, "Medkit", Color3.fromRGB(187, 255, 255), 14, "Medkit_ESP")
end
end)
else
Medkit:Disconnect()
LibESP:Delete("Medkit_ESP")
end
end})
Visual:AddToggle("BCE",{
Text = "可乐绘制",
Callback = function(v)
if v then
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Name == "BloxyCola" and not v:FindFirstChild("BloxyCola_ESP") then
LibESP:AddESP(v, "Bloxy Cola", Color3.fromRGB(131, 111, 255), 14, "BloxyCola_ESP")
end
end
ColaESP = workspace.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Name == "BloxyCola" and not v:FindFirstChild("BloxyCola_ESP") then
LibESP:AddESP(v, "Bloxy Cola", Color3.fromRGB(131, 111, 255), 14, "BloxyCola_ESP")
end
end)
else
ColaESP:Disconnect()
LibESP:Delete("BloxyCola_ESP")
end
end})

local Visual = Tabs.Esp:AddRightGroupbox("高亮绘制")
local LibESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImamGV/Script/main/ESP"))()

Visual:AddToggle("SE",{
Text = "幸存者绘制",
Callback = function(v)
if v then
for _, v in ipairs(workspace.Players:GetDescendants()) do
if v:IsA("Model") and v.Parent.Name == "Survivors" and not v:FindFirstChild("Survival_ESP") then
LibESP:AddESP(v, "", Color3.fromRGB(0, 191, 255), 14, "Survival_ESP")
end
end
SurvivalESP = workspace.Players.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Parent.Name == "Survivors" and not v:FindFirstChild("Survival_ESP") then
LibESP:AddESP(v, "", Color3.fromRGB(0, 191, 255), 14, "Survival_ESP")
end
end)
else
SurvivalESP:Disconnect()
LibESP:Delete("Survival_ESP")
end
end})
Visual:AddToggle("KE",{
Text = "杀手绘制",
Callback = function(v)
if v then
for _, v in ipairs(workspace.Players:GetDescendants()) do
if v:IsA("Model") and v.Parent.Name == "Killers" and not v:FindFirstChild("Killer_ESP") then
LibESP:AddESP(v, "", Color3.fromRGB(255, 0, 0), 14, "Killers_ESP")
elseif v:IsA("Model") and v.Parent.Name == "Killers" and not v:FindFirstChild("Killer_ESP") then
LibESP:AddESP(v.HumanoidRootPart, "Killer", Color3.fromRGB(255, 0, 0), 14, "Killers_ESP")
end
end
KillersESP = workspace.Players.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Parent.Name == "Killers" and not v:FindFirstChild("Killers_ESP") then
LibESP:AddESP(v, "", Color3.fromRGB(255, 0, 0), 14, "Killers_ESP")
elseif v:IsA("Model") and v.Parent.Name == "Killers" and not v:FindFirstChild("Killer_ESP") then
LibESP:AddESP(v.HumanoidRootPart, "Killer", Color3.fromRGB(255, 0, 0), 14, "Killers_ESP")
end
end)
else
KillersESP:Disconnect()
LibESP:Delete("Killers_ESP")
end
end})

local Visual = Tabs.Esp:AddRightGroupbox("2D方框")


Visual:AddToggle("SE", {
    Text = "绘制幸存者方框",
    Default = false,
    Callback = function(v)
        if v then
            local a = workspace:WaitForChild("Players")
            local c = a:WaitForChild("Survivors")
            local d = game:GetService("RunService")
            local e = game:GetService("Players").LocalPlayer
            
            local function f(g, h)
                if not g:IsA("Model") then return end
                if g == e.Character then return end
                local i = g:FindFirstChild("HumanoidRootPart")
                if not i then return end
                if i:FindFirstChild("playeresp") then return end
                
                local j = Instance.new("BillboardGui")
                j.Name = "playeresp"
                j.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                j.Active = true
                j.AlwaysOnTop = true
                j.LightInfluence = 1.000
                j.Size = UDim2.new(3, 0, 5, 0)
                j.Adornee = i
                j.Parent = i
                
                local k = Instance.new("Frame")
                k.Name = "playershow"
                k.BackgroundColor3 = Color3.fromRGB(255, 25, 25)
                k.BackgroundTransparency = 1
                k.Size = UDim2.new(1, 0, 1, 0)
                k.Parent = j
                
                local l = Instance.new("UIStroke")
                l.Color = h
                l.Thickness = 2
                l.Transparency = 0.2
                l.Parent = k
            end
            
            SurvivorESPConnection = d.RenderStepped:Connect(function()
                for m, o in ipairs(c:GetChildren()) do
                    f(o, Color3.fromRGB(0, 255, 0))
                end
            end)
            
            -- 添加新加入的幸存者
            SurvivorAddedConnection = c.ChildAdded:Connect(function(o)
                f(o, Color3.fromRGB(0, 255, 0))
            end)
        else
            if SurvivorESPConnection then
                SurvivorESPConnection:Disconnect()
            end
            if SurvivorAddedConnection then
                SurvivorAddedConnection:Disconnect()
            end
            
            -- 清除所有幸存者ESP
            local a = workspace:WaitForChild("Players")
            local c = a:WaitForChild("Survivors")
            for _, o in ipairs(c:GetChildren()) do
                if o:IsA("Model") then
                    local i = o:FindFirstChild("HumanoidRootPart")
                    if i and i:FindFirstChild("playeresp") then
                        i.playeresp:Destroy()
                    end
                end
            end
        end
    end
})

Visual:AddToggle("KE", {
    Text = "绘制杀手方框",
    Default = false,
    Callback = function(v)
        if v then
            local a = workspace:WaitForChild("Players")
            local b = a:WaitForChild("Killers")
            local d = game:GetService("RunService")
            local e = game:GetService("Players").LocalPlayer
            
            local function f(g, h)
                if not g:IsA("Model") then return end
                if g == e.Character then return end
                local i = g:FindFirstChild("HumanoidRootPart")
                if not i then return end
                if i:FindFirstChild("playeresp") then return end
                
                local j = Instance.new("BillboardGui")
                j.Name = "playeresp"
                j.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                j.Active = true
                j.AlwaysOnTop = true
                j.LightInfluence = 1.000
                j.Size = UDim2.new(3, 0, 5, 0)
                j.Adornee = i
                j.Parent = i
                
                local k = Instance.new("Frame")
                k.Name = "playershow"
                k.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                k.BackgroundTransparency = 1
                k.Size = UDim2.new(1, 0, 1, 0)
                k.Parent = j
                
                local l = Instance.new("UIStroke")
                l.Color = h
                l.Thickness = 2
                l.Transparency = 0.2
                l.Parent = k
            end
            
            KillerESPConnection = d.RenderStepped:Connect(function()
                for m, o in ipairs(b:GetChildren()) do
                    f(o, Color3.fromRGB(255, 0, 0))
                end
            end)
            
            -- 添加新加入的杀手
            KillerAddedConnection = b.ChildAdded:Connect(function(o)
                f(o, Color3.fromRGB(255, 0, 0))
            end)
        else
            if KillerESPConnection then
                KillerESPConnection:Disconnect()
            end
            if KillerAddedConnection then
                KillerAddedConnection:Disconnect()
            end
            
            -- 清除所有杀手ESP
            local a = workspace:WaitForChild("Players")
            local b = a:WaitForChild("Killers")
            for _, o in ipairs(b:GetChildren()) do
                if o:IsA("Model") then
                    local i = o:FindFirstChild("HumanoidRootPart")
                    if i and i:FindFirstChild("playeresp") then
                        i.playeresp:Destroy()
                    end
                end
            end
        end
    end
})

local Visual = Tabs.Esp:AddRightGroupbox("渲染绘制")

Visual:AddToggle("DistanceESP", {
    Text = "距离绘制",
    Default = false,
    Callback = function(v)
        if v then
            -- 初始化变量
            local players = game:GetService("Players")
            local run_service = game:GetService("RunService")
            local local_player = players.LocalPlayer
            local camera = workspace.CurrentCamera

            -- 清理旧的ESP
            if getgenv().cyberline_distance_esp then
                for _, text in pairs(getgenv().cyberline_distance_esp) do
                    pcall(function() text:Remove() end)
                end
            end

            getgenv().cyberline_distance_esp = {}

            -- 创建距离标签函数
            local function create_distance_label()
                local text = Drawing.new("Text")
                text.Size = 12
                text.Center = true
                text.Outline = true
                text.Font = 2
                text.Color = Color3.fromRGB(255, 255, 255)
                text.Visible = false
                return text
            end

            -- 主循环
            getgenv().distanceESPConnection = run_service.RenderStepped:Connect(function()
                for _, player in ipairs(players:GetPlayers()) do
                    if player ~= local_player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local root = player.Character.HumanoidRootPart
                        local screen_pos, on_screen = camera:WorldToViewportPoint(root.Position - Vector3.new(0, 2.8, 0))

                        if not getgenv().cyberline_distance_esp[player] then
                            getgenv().cyberline_distance_esp[player] = create_distance_label()
                        end

                        local text = getgenv().cyberline_distance_esp[player]

                        if on_screen then
                            local distance = math.floor((root.Position - camera.CFrame.Position).Magnitude)
                            text.Position = Vector2.new(screen_pos.X, screen_pos.Y)
                            text.Text = tostring(distance) .. "m"
                            text.Visible = true
                        else
                            text.Visible = false
                        end
                    elseif getgenv().cyberline_distance_esp[player] then
                        getgenv().cyberline_distance_esp[player].Visible = false
                    end
                end
            end)
        else
            -- 关闭ESP
            if getgenv().distanceESPConnection then
                getgenv().distanceESPConnection:Disconnect()
            end

            -- 清除所有距离标签
            if getgenv().cyberline_distance_esp then
                for _, text in pairs(getgenv().cyberline_distance_esp) do
                    pcall(function() text:Remove() end)
                end
                getgenv().cyberline_distance_esp = nil
            end
        end
    end
})


Visual:AddToggle("TopTracers", {
    Text = "天线绘制",
    Default = false,
    Callback = function(v)
        if v then
            -- 初始化变量
            local players = game:GetService("Players")
            local run_service = game:GetService("RunService")
            local local_player = players.LocalPlayer
            local camera = workspace.CurrentCamera

            -- 清理旧的追踪线
            if getgenv().cyberline_tracers then
                for _, line in pairs(getgenv().cyberline_tracers) do
                    pcall(function() line:Remove() end)
                end
            end

            getgenv().cyberline_tracers = {}

            -- 创建追踪线函数
            local function create_tracer()
                local line = Drawing.new("Line")
                line.Color = Color3.fromRGB(255, 255, 255)
                line.Thickness = 1
                line.Transparency = 1
                line.Visible = false
                return line
            end

            -- 主循环
            getgenv().tracerConnection = run_service.RenderStepped:Connect(function()
                for _, player in ipairs(players:GetPlayers()) do
                    if player ~= local_player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local root_part = player.Character.HumanoidRootPart
                        local screen_pos, on_screen = camera:WorldToViewportPoint(root_part.Position)

                        if not getgenv().cyberline_tracers[player] then
                            getgenv().cyberline_tracers[player] = create_tracer()
                        end

                        local tracer = getgenv().cyberline_tracers[player]

                        if on_screen then
                            -- 修改为从屏幕顶部中心向下绘制
                            tracer.From = Vector2.new(camera.ViewportSize.X / 2, 0)  -- 顶部中心
                            tracer.To = Vector2.new(screen_pos.X, screen_pos.Y)
                            tracer.Visible = true
                        else
                            tracer.Visible = false
                        end
                    elseif getgenv().cyberline_tracers[player] then
                        getgenv().cyberline_tracers[player].Visible = false
                    end
                end
            end)
        else
            -- 关闭追踪
            if getgenv().tracerConnection then
                getgenv().tracerConnection:Disconnect()
            end

            -- 清除所有追踪线
            if getgenv().cyberline_tracers then
                for _, line in pairs(getgenv().cyberline_tracers) do
                    pcall(function() line:Remove() end)
                end
                getgenv().cyberline_tracers = nil
            end
        end
    end
})


Visual:AddToggle("HealthBars", {
    Text = "血量绘制",
    Default = false,
    Callback = function(v)
        if v then
            -- 初始化变量
            local players = game:GetService("Players")
            local run_service = game:GetService("RunService")
            local local_player = players.LocalPlayer
            local camera = workspace.CurrentCamera

            -- 清理旧的血条
            if getgenv().cyberline_health_bars then
                for _, data in pairs(getgenv().cyberline_health_bars) do
                    pcall(function() data.bar:Remove() end)
                    pcall(function() data.outline:Remove() end)
                end
            end

            getgenv().cyberline_health_bars = {}

            -- 创建血条函数
            local function create_bar()
                local outline = Drawing.new("Square")
                outline.Color = Color3.new(0, 0, 0)
                outline.Filled = true
                outline.Transparency = 1
                outline.Visible = false

                local bar = Drawing.new("Square")
                bar.Color = Color3.fromRGB(0, 255, 0)
                bar.Filled = true
                bar.Transparency = 1
                bar.Visible = false

                return { bar = bar, outline = outline }
            end

            -- 获取角色边界函数
            local function get_bounds(character)
                local min = Vector3.new(math.huge, math.huge, math.huge)
                local max = Vector3.new(-math.huge, -math.huge, -math.huge)
                for _, part in character:GetChildren() do
                    if part:IsA("BasePart") then
                        local pos = part.Position
                        min = Vector3.new(math.min(min.X, pos.X), math.min(min.Y, pos.Y), math.min(min.Z, pos.Z))
                        max = Vector3.new(math.max(max.X, pos.X), math.max(max.Y, pos.Y), math.max(max.Z, pos.Z))
                    end
                end
                return min, max
            end

            -- 主循环
            getgenv().healthBarConnection = run_service.RenderStepped:Connect(function()
                for _, player in ipairs(players:GetPlayers()) do
                    if player ~= local_player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
                        if humanoid then
                            local min, max = get_bounds(player.Character)
                            local points = {
                                Vector3.new(min.X, min.Y, min.Z),
                                Vector3.new(min.X, max.Y, min.Z),
                                Vector3.new(max.X, min.Y, min.Z),
                                Vector3.new(max.X, max.Y, min.Z),
                                Vector3.new(min.X, min.Y, max.Z),
                                Vector3.new(min.X, max.Y, max.Z),
                                Vector3.new(max.X, min.Y, max.Z),
                                Vector3.new(max.X, max.Y, max.Z),
                            }

                            local min2d = Vector2.new(math.huge, math.huge)
                            local max2d = Vector2.new(-math.huge, -math.huge)
                            local visible = false

                            for _, point in ipairs(points) do
                                local screen, on_screen = camera:WorldToViewportPoint(point)
                                if on_screen then
                                    visible = true
                                    local pos2d = Vector2.new(screen.X, screen.Y)
                                    min2d = Vector2.new(math.min(min2d.X, pos2d.X), math.min(min2d.Y, pos2d.Y))
                                    max2d = Vector2.new(math.max(max2d.X, pos2d.X), math.max(max2d.Y, pos2d.Y))
                                end
                            end

                            if not getgenv().cyberline_health_bars[player] then
                                getgenv().cyberline_health_bars[player] = create_bar()
                            end

                            local bar = getgenv().cyberline_health_bars[player].bar
                            local outline = getgenv().cyberline_health_bars[player].outline

                            if visible then
                                local height = max2d.Y - min2d.Y
                                local ratio = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                                local bar_height = height * ratio

                                bar.Size = Vector2.new(2, bar_height)
                                bar.Position = Vector2.new(min2d.X - 5, max2d.Y - bar_height)
                                bar.Visible = true
                                bar.Color = Color3.fromRGB(255 * (1 - ratio), 255 * ratio, 0)  -- 根据血量变色

                                outline.Size = Vector2.new(4, height + 2)
                                outline.Position = Vector2.new(min2d.X - 6, min2d.Y - 1)
                                outline.Visible = true
                            else
                                bar.Visible = false
                                outline.Visible = false
                            end
                        end
                    elseif getgenv().cyberline_health_bars[player] then
                        getgenv().cyberline_health_bars[player].bar.Visible = false
                        getgenv().cyberline_health_bars[player].outline.Visible = false
                    end
                end
            end)
        else
            -- 关闭血条显示
            if getgenv().healthBarConnection then
                getgenv().healthBarConnection:Disconnect()
            end

            -- 清除所有血条
            if getgenv().cyberline_health_bars then
                for _, data in pairs(getgenv().cyberline_health_bars) do
                    pcall(function() data.bar:Remove() end)
                    pcall(function() data.outline:Remove() end)
                end
                getgenv().cyberline_health_bars = nil
            end
        end
    end
})

Visual:AddToggle("SkeletonESP", {
    Text = "骨骼绘制",
    Default = false,
    Callback = function(v)
        if v then
            -- 初始化变量
            local players = game:GetService("Players")
            local run_service = game:GetService("RunService")
            local camera = workspace.CurrentCamera
            local local_player = players.LocalPlayer

            -- 清理旧的骨骼线
            if getgenv().cyberline_skeleton then
                for _, parts in pairs(getgenv().cyberline_skeleton) do
                    for _, line in pairs(parts) do
                        pcall(function() line:Remove() end)
                    end
                end
            end

            getgenv().cyberline_skeleton = {}

            -- 创建单条骨骼线函数
            local function create_line()
                local line = Drawing.new("Line")
                line.Color = Color3.new(1, 1, 1)
                line.Thickness = 1
                line.Transparency = 1
                line.Visible = false
                return line
            end

            -- 创建完整骨骼函数
            local function create_skeleton()
                return {
                    head = create_line(),
                    torso = create_line(),
                    left_arm = create_line(),
                    right_arm = create_line(),
                    left_leg = create_line(),
                    right_leg = create_line()
                }
            end

            -- 主循环
            getgenv().skeletonConnection = run_service.RenderStepped:Connect(function()
                for _, player in ipairs(players:GetPlayers()) do
                    if player ~= local_player and player.Character then
                        local char = player.Character
                        local parts = {
                            head = char:FindFirstChild("Head"),
                            upper = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"),
                            lower = char:FindFirstChild("LowerTorso") or char:FindFirstChild("HumanoidRootPart"),
                            left_arm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm"),
                            right_arm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm"),
                            left_leg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg"),
                            right_leg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg"),
                        }

                        if not getgenv().cyberline_skeleton[player] then
                            getgenv().cyberline_skeleton[player] = create_skeleton()
                        end

                        local skeleton = getgenv().cyberline_skeleton[player]

                        local function to_screen(part)
                            local pos, on_screen = camera:WorldToViewportPoint(part.Position)
                            return Vector2.new(pos.X, pos.Y), on_screen
                        end

                        local all_visible = true
                        for _, part in pairs(parts) do
                            if not part then
                                all_visible = false
                            end
                        end

                        if all_visible then
                            local head_pos, head_on = to_screen(parts.head)
                            local upper_pos, upper_on = to_screen(parts.upper)
                            local lower_pos, lower_on = to_screen(parts.lower)
                            local larm_pos, larm_on = to_screen(parts.left_arm)
                            local rarm_pos, rarm_on = to_screen(parts.right_arm)
                            local lleg_pos, lleg_on = to_screen(parts.left_leg)
                            local rleg_pos, rleg_on = to_screen(parts.right_leg)

                            skeleton.head.From = head_pos
                            skeleton.head.To = upper_pos

                            skeleton.torso.From = upper_pos
                            skeleton.torso.To = lower_pos

                            skeleton.left_arm.From = upper_pos
                            skeleton.left_arm.To = larm_pos

                            skeleton.right_arm.From = upper_pos
                            skeleton.right_arm.To = rarm_pos

                            skeleton.left_leg.From = lower_pos
                            skeleton.left_leg.To = lleg_pos

                            skeleton.right_leg.From = lower_pos
                            skeleton.right_leg.To = rleg_pos

                            for _, line in pairs(skeleton) do
                                line.Visible = true
                            end
                        else
                            for _, line in pairs(skeleton) do
                                line.Visible = false
                            end
                        end
                    elseif getgenv().cyberline_skeleton[player] then
                        for _, line in pairs(getgenv().cyberline_skeleton[player]) do
                            line.Visible = false
                        end
                    end
                end
            end)
        else
            -- 关闭骨骼显示
            if getgenv().skeletonConnection then
                getgenv().skeletonConnection:Disconnect()
            end

            -- 清除所有骨骼线
            if getgenv().cyberline_skeleton then
                for _, parts in pairs(getgenv().cyberline_skeleton) do
                    for _, line in pairs(parts) do
                        pcall(function() line:Remove() end)
                    end
                end
                getgenv().cyberline_skeleton = nil
            end
        end
    end
})

Visual:AddToggle("BoxESP", {
    Text = "方框绘制",
    Default = false,
    Callback = function(v)
        if v then
            -- 初始化变量
            local players = game:GetService("Players")
            local run_service = game:GetService("RunService")
            local local_player = players.LocalPlayer
            local camera = workspace.CurrentCamera

            -- 清理旧的方框
            if getgenv().cyberline_esp_boxes then
                for _, data in pairs(getgenv().cyberline_esp_boxes) do
                    pcall(function() data.box:Remove() end)
                    pcall(function() data.outline:Remove() end)
                end
            end

            getgenv().cyberline_esp_boxes = {}

            -- 创建方框函数
            local function create_box()
                local outline = Drawing.new("Square")
                outline.Color = Color3.new(0, 0, 0)
                outline.Thickness = 1
                outline.Filled = false
                outline.Transparency = 1
                outline.Visible = false

                local box = Drawing.new("Square")
                box.Color = Color3.fromRGB(255, 255, 255)
                box.Thickness = 1
                box.Filled = false
                box.Transparency = 1
                box.Visible = false

                return { box = box, outline = outline }
            end

            -- 获取角色边界函数
            local function get_bounds(character)
                local min = Vector3.new(math.huge, math.huge, math.huge)
                local max = Vector3.new(-math.huge, -math.huge, -math.huge)
                for _, part in character:GetChildren() do
                    if part:IsA("BasePart") then
                        local pos = part.Position
                        min = Vector3.new(math.min(min.X, pos.X), math.min(min.Y, pos.Y), math.min(min.Z, pos.Z))
                        max = Vector3.new(math.max(max.X, pos.X), math.max(max.Y, pos.Y), math.max(max.Z, pos.Z))
                    end
                end
                return min, max
            end

            -- 主循环
            getgenv().boxESPConnection = run_service.RenderStepped:Connect(function()
                for _, player in ipairs(players:GetPlayers()) do
                    if player ~= local_player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local min, max = get_bounds(player.Character)
                        local points = {
                            Vector3.new(min.X, min.Y, min.Z),
                            Vector3.new(min.X, max.Y, min.Z),
                            Vector3.new(max.X, min.Y, min.Z),
                            Vector3.new(max.X, max.Y, min.Z),
                            Vector3.new(min.X, min.Y, max.Z),
                            Vector3.new(min.X, max.Y, max.Z),
                            Vector3.new(max.X, min.Y, max.Z),
                            Vector3.new(max.X, max.Y, max.Z),
                        }

                        local min2d = Vector2.new(math.huge, math.huge)
                        local max2d = Vector2.new(-math.huge, -math.huge)
                        local visible = false

                        for _, point in ipairs(points) do
                            local screen, on_screen = camera:WorldToViewportPoint(point)
                            if on_screen then
                                visible = true
                                local pos2d = Vector2.new(screen.X, screen.Y)
                                min2d = Vector2.new(math.min(min2d.X, pos2d.X), math.min(min2d.Y, pos2d.Y))
                                max2d = Vector2.new(math.max(max2d.X, pos2d.X), math.max(max2d.Y, pos2d.Y))
                            end
                        end

                        if not getgenv().cyberline_esp_boxes[player] then
                            getgenv().cyberline_esp_boxes[player] = create_box()
                        end

                        local box = getgenv().cyberline_esp_boxes[player].box
                        local outline = getgenv().cyberline_esp_boxes[player].outline

                        if visible then
                            local size = max2d - min2d
                            box.Position = min2d
                            box.Size = size
                            box.Visible = true

                            outline.Position = min2d - Vector2.new(1, 1)
                            outline.Size = size + Vector2.new(2, 2)
                            outline.Visible = true
                        else
                            box.Visible = false
                            outline.Visible = false
                        end
                    elseif getgenv().cyberline_esp_boxes[player] then
                        getgenv().cyberline_esp_boxes[player].box.Visible = false
                        getgenv().cyberline_esp_boxes[player].outline.Visible = false
                    end
                end
            end)
        else
            -- 关闭方框显示
            if getgenv().boxESPConnection then
                getgenv().boxESPConnection:Disconnect()
            end

            -- 清除所有方框
            if getgenv().cyberline_esp_boxes then
                for _, data in pairs(getgenv().cyberline_esp_boxes) do
                    pcall(function() data.box:Remove() end)
                    pcall(function() data.outline:Remove() end)
                end
                getgenv().cyberline_esp_boxes = nil
            end
        end
    end
})

local Warning = Tabs.tzq:AddLeftGroupbox("杀手靠近提示")

local KillerWarningSettings = {
    Enabled = false,
    WarningDistance = 100, 
    WarningColor = Color3.fromRGB(255, 0, 0), 
    TextSize = 20, 
    BlinkInterval = 0.5, 
    LastWarningTime = 0, 
    WarningCooldown = 5, 
    WarningSoundId = "rbxassetid://6545327576", 
    SoundVolume = 0.5 
}


local warningLabel = Drawing.new("Text")
warningLabel.Visible = false
warningLabel.Center = true
warningLabel.Outline = true
warningLabel.Font = 2 -- 粗体字体
warningLabel.Color = KillerWarningSettings.WarningColor
warningLabel.Size = KillerWarningSettings.TextSize

-- 存储音效对象
local warningSound = Instance.new("Sound")
warningSound.SoundId = KillerWarningSettings.WarningSoundId
warningSound.Volume = KillerWarningSettings.SoundVolume
warningSound.Parent = game:GetService("SoundService")

-- 更新警告显示
local function updateKillerWarning()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local killersFolder = workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end
    
    local closestDistance = math.huge
    local closestKiller = nil
    
    -- 寻找最近的杀手
    for _, killer in ipairs(killersFolder:GetChildren()) do
        if killer:IsA("Model") and killer:FindFirstChild("HumanoidRootPart") then
            local distance = (character.HumanoidRootPart.Position - killer.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestKiller = killer
            end
        end
    end
    
    -- 检查距离并显示警告
    if closestKiller and closestDistance <= KillerWarningSettings.WarningDistance then
        local currentTime = tick()
        
        -- 闪烁效果
        if currentTime - KillerWarningSettings.LastWarningTime >= KillerWarningSettings.BlinkInterval then
            warningLabel.Visible = not warningLabel.Visible
            KillerWarningSettings.LastWarningTime = currentTime
        end
        
        -- 设置警告文本
        warningLabel.Text = string.format("警告! 杀手 %s 在 %d 米内!", closestKiller.Name, math.floor(closestDistance))
        warningLabel.Position = Vector2.new(
            workspace.CurrentCamera.ViewportSize.X / 2,
            workspace.CurrentCamera.ViewportSize.Y * 0.2
        )
        
        -- 播放警告音效(冷却时间内只播放一次)
        if currentTime - KillerWarningSettings.LastWarningTime >= KillerWarningSettings.WarningCooldown then
            warningSound:Play()
            KillerWarningSettings.LastWarningTime = currentTime
        end
    else
        warningLabel.Visible = false
    end
end

-- 主开关
Warning:AddToggle("KillerWarningToggle", {
    Text = "杀手靠近提示",
    Default = false,
    Callback = function(enabled)
        KillerWarningSettings.Enabled = enabled
        if enabled then
            -- 初始化连接
            if not KillerWarningSettings.connection then
                KillerWarningSettings.connection = game:GetService("RunService").RenderStepped:Connect(updateKillerWarning)
            end
        else
            -- 关闭连接
            if KillerWarningSettings.connection then
                KillerWarningSettings.connection:Disconnect()
                KillerWarningSettings.connection = nil
            end
            warningLabel.Visible = false
            warningSound:Stop()
        end
    end
})

-- 距离设置
Warning:AddSlider("WarningDistance", {
    Text = "警告距离(米)",
    Min = 10,
    Max = 200,
    Default = 100,
    Rounding = 0,
    Callback = function(value)
        KillerWarningSettings.WarningDistance = value
    end
})

-- 文字大小设置
Warning:AddSlider("WarningTextSize", {
    Text = "文字大小",
    Min = 10,
    Max = 30,
    Default = 20,
    Rounding = 0,
    Callback = function(value)
        KillerWarningSettings.TextSize = value
        warningLabel.Size = value
    end
})

-- 闪烁速度设置
Warning:AddSlider("BlinkSpeed", {
    Text = "闪烁速度",
    Min = 0.1,
    Max = 1,
    Default = 0.5,
    Rounding = 1,
    Callback = function(value)
        KillerWarningSettings.BlinkInterval = value
    end
})

-- 警告颜色选择
Warning:AddDropdown("WarningColor", {
    Values = {"红色", "橙色", "黄色", "粉色", "紫色"},
    Default = "红色",
    Text = "警告颜色",
    Callback = function(value)
        local colorMap = {
            ["红色"] = Color3.fromRGB(255, 0, 0),
            ["橙色"] = Color3.fromRGB(255, 165, 0),
            ["黄色"] = Color3.fromRGB(255, 255, 0),
            ["粉色"] = Color3.fromRGB(255, 192, 203),
            ["紫色"] = Color3.fromRGB(128, 0, 128)
        }
        KillerWarningSettings.WarningColor = colorMap[value] or Color3.fromRGB(255, 0, 0)
        warningLabel.Color = KillerWarningSettings.WarningColor
    end
})

-- 音效音量设置
Warning:AddSlider("SoundVolume", {
    Text = "音效音量",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Rounding = 1,
    Callback = function(value)
        KillerWarningSettings.SoundVolume = value
        warningSound.Volume = value
    end
})


local Visual = Tabs.tzq:AddLeftGroupbox("通知提示")

Visual:AddToggle("NST",{
Text = "三角炸弹生成提示",
Default = false,
Callback = function(v)
if v then
NotifySubspaceTripmine = workspace.Map.Ingame.DescendantAdded:Connect(function(v)
if v.Name == "塔夫三角炸弹" then
Library:Notify("BETA TEST | Warning\nBlock '三角炸弹已生成！")
end
end)
else
NotifySubspaceTripmine:Disconnect()
end
end})
Visual:AddToggle("NEK",{
Text = "实体生成提示",
Default = false,
Callback = function(v)
if v then
NotifyEntityKillers = workspace.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Name == "PizzaDeliveryRig" or v.Name == "Bunny" or v.Name == "Mafiaso1" or v.Name == "Mafiaso2" or v.Name == "Mafiaso3" then
Library:Notify("BETA TEST | Warning\nEntity '" .. v.Name .. "' 生成了！")
elseif v:IsA("Model") and v.Name == "1x1x1x1Zombie" then
Library:Notify("BETA TEST | Warning\nEntity '1x1x1x1 (僵尸)' 生成了！")
end
end)
else
NotifyEntityKillers:Disconnect()
end
end})

local Player = Tabs.Max:AddLeftGroupbox("动作功能")



-- Silly Billy 动作按钮
Player:AddToggle("SillyBillyToggle", {
    Text = "Silly Billy",
    Default = false,
    Tooltip = "播放Silly Billy表情动作",
    Callback = function(state)
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
        
        if state then
            -- 激活状态
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
            
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://107464355830477"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
            
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://77601084987544"
            sound.Parent = rootPart
            sound.Volume = 0.5
            sound.Looped = false
            sound:Play()
            
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
                
                for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
                    local asset = char:FindFirstChild(assetName)
                    if asset then asset:Destroy() end
                end
            end)
        else
            -- 关闭状态
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0
            
            for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
                local asset = char:FindFirstChild(assetName)
                if asset then asset:Destroy() end
            end
            
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then bodyVelocity:Destroy() end
            
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
            
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://107464355830477" then
                    track:Stop()
                end
            end
        end
    end
})

-- Silly of it 动作按钮
Player:AddToggle("SillyOfItToggle", {
    Text = "Silly of it",
    Default = false,
    Tooltip = "播放Silly of it表情动作",
    Callback = function(state)
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
        
        if state then
            -- 激活状态（完整实现，与原始函数相同）
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
            
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://107464355830477"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
            
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://120176009143091"
            sound.Parent = rootPart
            sound.Volume = 0.5
            sound.Looped = false
            sound:Play()
            
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
                
                for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
                    local asset = char:FindFirstChild(assetName)
                    if asset then asset:Destroy() end
                end
            end)
        else
            -- 关闭状态（完整实现）
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0
            
            for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
                local asset = char:FindFirstChild(assetName)
                if asset then asset:Destroy() end
            end
            
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then bodyVelocity:Destroy() end
            
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
            
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://107464355830477" then
                    track:Stop()
                end
            end
        end
    end
})

-- Subterfuge 动作按钮
Player:AddToggle("SubterfugeToggle", {
    Text = "Subterfuge",
    Default = false,
    Tooltip = "播放Subterfuge表情动作",
    Callback = function(state)
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
        
        if state then
            -- 激活状态（完整实现）
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
            
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://87482480949358"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
            
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://132297506693854"
            sound.Parent = rootPart
            sound.Volume = 2
            sound.Looped = false
            sound:Play()
            
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "_Subterfuge"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
            
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            -- 关闭状态（完整实现）
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0
            
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then bodyVelocity:Destroy() end
            
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
            
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://87482480949358" then
                    track:Stop()
                end
            end
        end
    end
})

-- Aw Shucks 动作按钮
Player:AddToggle("AwShucksToggle", {
    Text = "Aw Shucks",
    Default = false,
    Tooltip = "播放Aw Shucks表情动作",
    Callback = function(state)
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
        
        if state then
            -- 激活状态（完整实现）
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
            
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://74238051754912"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
            
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://123236721947419"
            sound.Parent = rootPart
            sound.Volume = 0.5
            sound.Looped = false
            sound:Play()
            
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Shucks"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
            
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            -- 关闭状态（完整实现）
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0
            
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then bodyVelocity:Destroy() end
            
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
            
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://74238051754912" then
                    track:Stop()
                end
            end
        end
    end
})

-- Miss The Quiet 动作按钮
Player:AddToggle("MissTheQuietToggle", {
    Text = "Miss The Quiet",
    Default = false,
    Tooltip = "播放Miss The Quiet表情动作",
    Callback = function(state)
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
        
        if state then
            -- 激活状态（完整实现）
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
            
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://100986631322204"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
            
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://131936418953291"
            sound.Parent = rootPart
            sound.Volume = 0.5
            sound.Looped = false
            sound:Play()
            
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
                
                for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
                    local asset = char:FindFirstChild(assetName)
                    if asset then asset:Destroy() end
                end
            end)
        else
            -- 关闭状态（完整实现）
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0
            
            for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
                local asset = char:FindFirstChild(assetName)
                if asset then asset:Destroy() end
            end
            
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then bodyVelocity:Destroy() end
            
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
            
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://100986631322204" then
                    track:Stop()
                end
            end
        end
    end
})

-- VIP动作（新音频）按钮
Player:AddToggle("VIPToggleNew", {
    Text = "VIP (新音频)",
    Default = false,
    Tooltip = "播放VIP表情动作（新版音频）",
    Callback = function(state)
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
        
        if state then
            -- 激活状态（完整实现）
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
            
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://138019937280193"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
            
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://109474987384441"
            sound.Parent = rootPart
            sound.Volume = 0.5
            sound.Looped = true
            sound:Play()
            
            local effect = game:GetService("ReplicatedStorage").Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
            effect.Name = "PlayerEmoteVFX"
            effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
            effect.WeldConstraint.Part0 = char.PrimaryPart
            effect.WeldConstraint.Part1 = effect
            effect.Parent = char
            effect.CanCollide = false
            
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "HakariDance"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
            
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            -- 关闭状态（完整实现）
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0
            
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then bodyVelocity:Destroy() end
            
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
            
            local effect = char:FindFirstChild("PlayerEmoteVFX")
            if effect then effect:Destroy() end
            
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://138019937280193" then
                    track:Stop()
                end
            end
        end
    end
})

-- VIP动作（旧音频）按钮
Player:AddToggle("VIPToggleOld", {
    Text = "VIP (旧音频)",
    Default = false,
    Tooltip = "播放VIP表情动作（旧版音频）",
    Callback = function(state)
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
        
        if state then
            -- 激活状态（完整实现）
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
            
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://138019937280193"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
            
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://87166578676888"
            sound.Parent = rootPart
            sound.Volume = 0.5
            sound.Looped = true
            sound:Play()
            
            local effect = game:GetService("ReplicatedStorage").Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
            effect.Name = "PlayerEmoteVFX"
            effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
            effect.WeldConstraint.Part0 = char.PrimaryPart
            effect.WeldConstraint.Part1 = effect
            effect.Parent = char
            effect.CanCollide = false
            
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "HakariDance"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
            
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            -- 关闭状态（完整实现）
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0
            
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then bodyVelocity:Destroy() end
            
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
            
            local effect = char:FindFirstChild("PlayerEmoteVFX")
            if effect then effect:Destroy() end
            
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://138019937280193" then
                    track:Stop()
                end
            end
        end
    end
})




local Disabled = Tabs.ani:AddLeftGroupbox("John Doe反效果")

-- Helper function to safely destroy objects
local function safeDestroy(obj)
    if obj and obj.Parent then
        obj:Destroy()
    end
end

-- Helper function to remove touch interests
local function removeTouchInterests(object)
    for _, child in ipairs(object:GetDescendants()) do
        if child:IsA("TouchTransmitter") or child.Name == "TouchInterest" then
            safeDestroy(child)
        end
    end
end

-- Anti John Doe Trail
Disabled:AddToggle("AJDT", {
    Text = "去除约翰多乱码路径", 
    Default = false,
    Callback = function(v)
        if DisabledJohnDoeTrail then
            DisabledJohnDoeTrail:Disconnect()
            DisabledJohnDoeTrail = nil
        end

        if v then
            local function RemoveTouchInterests()
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                
                local killers = playersFolder:FindFirstChild("Killers")
                if not killers then return end

                for _, killer in ipairs(killers:GetChildren()) do
                    if killer:FindFirstChild("JohnDoeTrail") then
                        for _, trail in ipairs(killer.JohnDoeTrail:GetDescendants()) do
                            if trail.Name == "Trail" then
                                removeTouchInterests(trail)
                            end
                        end
                    end
                end
            end

            RemoveTouchInterests()

            DisabledJohnDoeTrail = game:GetService("RunService").Heartbeat:Connect(function()
                RemoveTouchInterests()
            end)

            -- Setup descendant added listeners
            local killers = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
            if killers then
                for _, killer in ipairs(killers:GetChildren()) do
                    if killer:FindFirstChild("JohnDoeTrail") then
                        killer.JohnDoeTrail.DescendantAdded:Connect(function(newObj)
                            if newObj.Name == "Trail" then
                                removeTouchInterests(newObj)
                            end
                        end)
                    end
                end
            end
        end
    end
})

-- Anti John Doe Spikes
Disabled:AddToggle("AJDSp", {
    Text = "反约翰多尖刺",
    Default = false,
    Callback = function(v)
        if AntiJohnDoeSpike then
            AntiJohnDoeSpike:Disconnect()
            AntiJohnDoeSpike = nil
        end

        if v then
            local function RemoveSpikes()
                local map = workspace:FindFirstChild("Map")
                if not map then return end
                
                for _, spike in ipairs(map:GetDescendants()) do
                    if spike.Name == "Spike" then
                        safeDestroy(spike)
                    end
                end
            end

            RemoveSpikes()

            AntiJohnDoeSpike = game:GetService("RunService").Heartbeat:Connect(RemoveSpikes)

            local map = workspace:FindFirstChild("Map")
            if map then
                map.DescendantAdded:Connect(function(obj)
                    if obj.Name == "Spike" then
                        safeDestroy(obj)
                    end
                end)
            end
        end
    end
})

-- Anti John Doe Stomp
Disabled:AddToggle("AJDS", {
    Text = "去除约翰多陷阱",
    Default = false,
    Callback = function(v)
        if AntiJohnDoeStomp then
            AntiJohnDoeStomp:Disconnect()
            AntiJohnDoeStomp = nil
        end

        if v then
            local function CleanShadows()
                local map = workspace:FindFirstChild("Map")
                if not map then return end
                
                local ingame = map:FindFirstChild("Ingame")
                if not ingame then return end
                
                for _, shadow in ipairs(ingame:GetDescendants()) do
                    if shadow.Name == "Shadow" then
                        removeTouchInterests(shadow)
                        safeDestroy(shadow)
                    end
                end
            end

            CleanShadows()

            AntiJohnDoeStomp = game:GetService("RunService").Heartbeat:Connect(function()
                CleanShadows()
            end)

            local map = workspace:FindFirstChild("Map")
            if map then
                local ingame = map:FindFirstChild("Ingame")
                if ingame then
                    ingame.DescendantAdded:Connect(function(obj)
                        if obj.Name == "Shadow" then
                            removeTouchInterests(obj)
                            safeDestroy(obj)
                        end
                    end)
                end
            end
        end
    end
})

local GJ = Tabs.ani:AddRightGroupbox('负面效果')
GJ:AddButton("禁用负面效果", function()
    local rs = game:GetService("ReplicatedStorage")

    local m = {
        rs.Modules.StatusEffects.Slowness,
        rs.Modules.StatusEffects.SurvivorExclusive.Subspaced,
        rs.Modules.StatusEffects.KillerExclusive.Glitched,
        rs.Modules.StatusEffects.Blindness,
        rs.Modules.StatusEffects.Confusion,
        rs.Modules.StatusEffects.KillerExclusive.Corrupted,
        rs.Modules.StatusEffects.KillerExclusive.Hallucination,
        rs.Modules.StatusEffects.Nausea,
        rs.Modules.StatusEffects.Oblivious
    }

    for _, mod in ipairs(m) do
        local ok, req = pcall(require, mod)
        if ok and typeof(req) == "table" then
            req.Applied = function(_) end
        end
    end
end)
    
local ZZ = Tabs.ani:AddRightGroupbox('1x4反效果')
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local RemoteEvent = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")

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
    local args = { [1] = "Entangled" }
    pcall(function()
        RemoteEvent:FireServer(unpack(args))
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
            end)
        end
    end)
end

local function runMainTask()
    while AutoPopup.Enabled do
        deletePopups()
        triggerEntangled()
        task.wait(AutoPopup.Interval) -- 使用设置的间隔时间
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

-- 添加间隔时间调整滑块
ZZ:AddSlider('AutoPopupInterval', {
    Text = '执行间隔(秒)',
    Default = 0.5,
    Min = 0.5,
    Max = 3.5,
    Rounding = 0,
    Tooltip = '设置自动执行的间隔时间(1-5秒)',
    Callback = function(value)
        AutoPopup.Interval = value
    end
})

ZZ:AddToggle('AutoPopupToggle', {
    Text = '反1x4弹窗(反懒惰效果)',
    Default = false,
    Tooltip = '去除弹窗和懒惰效果',
    Callback = function(state)
        if state then
            startAutoPopup()
        else
            stopAutoPopup()
        end
    end
})

-- 玩家离开处理
if LocalPlayer then
    LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
        if not LocalPlayer.Parent then
            stopAutoPopup()
        end
    end)
end



local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 创建一个体力功能组
local MVP = Tabs.Sat:AddLeftGroupbox("体力功能")

-- 体力系统设置
local StaminaSettings = {
    MaxStamina = 100,      -- 最大体力值
    StaminaGain = 25,      -- 体力恢复速度
    StaminaLoss = 10,      -- 体力消耗速度
    SprintSpeed = 28,      -- 奔跑速度
    InfiniteGain = 9999    -- 无限体力恢复速度
}

-- 体力控制开关
local SettingToggles = {
    MaxStamina = true,
    StaminaGain = true,
    StaminaLoss = true,
    SprintSpeed = true
}

-- 获取游戏体力模块
local SprintingModule = ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Character"):WaitForChild("Game"):WaitForChild("Sprinting")
local GetModule = function() return require(SprintingModule) end

-- 实时更新体力设置
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

-- 无限体力功能
local bai = {Spr = false}
local connection

MVP:AddToggle('MyToggle', {
    Text = '无限体力',
    Default = false,
    Tooltip = '体力',
    Callback = function(state)
        bai.Spr = state
        local Sprinting = GetModule()

        if state then
            Sprinting.StaminaLoss = 0
            Sprinting.StaminaGain = StaminaSettings.InfiniteGain or 9999

            if connection then connection:Disconnect() end
            connection = RunService.Heartbeat:Connect(function()
                if not bai.Spr then return end
                Sprinting.StaminaLoss = 0
                Sprinting.StaminaGain = StaminaSettings.InfiniteGain or 9999
            end)
        else
            Sprinting.StaminaLoss = StaminaSettings.StaminaLoss or 10
            Sprinting.StaminaGain = StaminaSettings.StaminaGain or 25

            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end
})

MVP:AddToggle('MaxStaminaToggle', {
    Text = '启用体力大小调节',
    Default = true,
    Callback = function(Value)
        SettingToggles.MaxStamina = Value
    end
})


MVP:AddToggle('StaminaGainToggle', {
    Text = '启用体力恢复调节',
    Default = true,
    Callback = function(Value)
        SettingToggles.StaminaGain = Value
    end
})

MVP:AddToggle('StaminaLossToggle', {
    Text = '启用体力消耗调节',
    Default = true,
    Callback = function(Value)
        SettingToggles.StaminaLoss = Value
    end
})

MVP:AddToggle('SprintSpeedToggle', {
    Text = '启用奔跑速度调节',
    Default = true,
    Callback = function(Value)
        SettingToggles.SprintSpeed = Value
    end
})







local MVP = Tabs.Sat:AddLeftGroupbox("调试区")



MVP:AddSlider('InfStaminaGainSlider', {
    Text = '无限体力恢复速度',
    Default = 9999,
    Min = 0,
    Max = 50000,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.InfiniteGain = Value
    end
})


MVP:AddSlider('MySlider1', {
    Text = '体力大小',
    Default = 100,
    Min = 0,
    Max = 99999,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.MaxStamina = Value
    end
})


MVP:AddSlider('MySlider2', {
    Text = '体力恢复',
    Default = 25,
    Min = 0,
    Max = 250,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.StaminaGain = Value
    end
})


MVP:AddSlider('MySlider3', {
    Text = '体力消耗',
    Default = 10,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.StaminaLoss = Value
    end
})


MVP:AddSlider('MySlider4', {
    Text = '奔跑速度',
    Default = 28,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.SprintSpeed = Value
    end
})




local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local PZ = Tabs.lol:AddLeftGroupbox("披萨功能")

local pizzaConnection = nil
local pizzaTPConnection = nil
local pizzaAttractionActive = false

PZ:AddToggle("AEP", {
    Text = "自动吃披萨(追踪传送)",
    Default = false,
    Tooltip = "当生命值低于设定值时自动吸引附近的披萨",
    
    Callback = function(enabled)
        _G.AutoEatPizza = enabled
        pizzaAttractionActive = enabled
        
        if pizzaConnection then
            pizzaConnection:Disconnect()
            pizzaConnection = nil
        end
        
        if enabled then
            local lastCheck = 0
            pizzaConnection = RunService.Stepped:Connect(function(_, deltaTime)
                lastCheck += deltaTime
                
                if lastCheck < 0.3 then return end
                lastCheck = 0
                
                local player = Players.LocalPlayer
                local character = player.Character
                
                if not character or not character:FindFirstChild("Humanoid") or not character:FindFirstChild("HumanoidRootPart") then
                    return
                end
                
                local humanoid = character.Humanoid
                local rootPart = character.HumanoidRootPart
                
                if _G.HealthEatPizza and humanoid.Health >= _G.HealthEatPizza then
                    return
                end
                
                local pizzaFolder = workspace:FindFirstChild("Pizzas") or workspace.Map
                if not pizzaFolder then return end
                
                local closestPizza, closestDistance = nil, math.huge
                for _, pizza in ipairs(pizzaFolder:GetDescendants()) do
                    if pizza:IsA("BasePart") and pizza.Name == "Pizza" then
                        local distance = (rootPart.Position - pizza.Position).Magnitude
                        if distance < closestDistance then
                            closestPizza = pizza
                            closestDistance = distance
                        end
                    end
                end
                
                if closestPizza then
                    closestPizza.CFrame = closestPizza.CFrame:Lerp(
                        rootPart.CFrame * CFrame.new(0, 0, -2),
                        0.5
                    )
                    
                    if not closestPizza:FindFirstChild("AttractEffect") then
                        local effect = Instance.new("ParticleEmitter")
                        effect.Name = "AttractEffect"
                        effect.Texture = "rbxassetid://242487987"
                        effect.LightEmission = 0.8
                        effect.Size = NumberSequence.new(0.5)
                        effect.Parent = closestPizza
                    end
                end
            end)
        end
    end
})

PZ:AddToggle("ATP", {
    Text = "自动吃披萨(传送)",
    Default = false,
    Tooltip = "当生命值低于设定值时自动将最近的披萨传送到玩家",
    
    Callback = function(enabled)
        _G.AutoTeleportPizza = enabled
        
        if pizzaTPConnection then
            pizzaTPConnection:Disconnect()
            pizzaTPConnection = nil
        end
        
        if enabled then
            local lastCheck = 0
            pizzaTPConnection = RunService.Stepped:Connect(function(_, deltaTime)
                lastCheck += deltaTime
                
                if lastCheck < 0.3 then return end
                lastCheck = 0
                
                local player = Players.LocalPlayer
                local character = player.Character
                
                if not character or not character:FindFirstChild("Humanoid") or not character:FindFirstChild("HumanoidRootPart") then
                    return
                end
                
                local humanoid = character.Humanoid
                local rootPart = character.HumanoidRootPart
                
                if _G.HealthEatPizza and humanoid.Health >= _G.HealthEatPizza then
                    return
                end
                
                local pizzaFolder = workspace:FindFirstChild("Pizzas") or workspace.Map
                if not pizzaFolder then return end
                
                local closestPizza, closestDistance = nil, math.huge
                for _, pizza in ipairs(pizzaFolder:GetDescendants()) do
                    if pizza:IsA("BasePart") and pizza.Name == "Pizza" then
                        local distance = (rootPart.Position - pizza.Position).Magnitude
                        if distance < closestDistance then
                            closestPizza = pizza
                            closestDistance = distance
                        end
                    end
                end
                
                if closestPizza then
                    closestPizza.CFrame = rootPart.CFrame * CFrame.new(0, 0, -2)
                    
                    if not closestPizza:FindFirstChild("TeleportEffect") then
                        local effect = Instance.new("ParticleEmitter")
                        effect.Name = "TeleportEffect"
                        effect.Texture = "rbxassetid://242487987"
                        effect.LightEmission = 0.8
                        effect.Size = NumberSequence.new(0.5)
                        effect.Lifetime = NumberRange.new(0.5)
                        effect.Parent = closestPizza
                        
                        delay(1, function()
                            if effect and effect.Parent then
                                effect:Destroy()
                            end
                        end)
                    end
                end
            end)
        end
    end
})

PZ:AddDivider()  

PZ:AddSlider("HealthThreshold", {
    Text = "生命值设置",
    Default = 50,
    Min = 10,
    Max = 130,
    Rounding = 0,
    Tooltip = "当生命值低于设置生命值吃披萨",
    
    Callback = function(value)
        _G.HealthEatPizza = value
    end
})

PZ:AddDivider()  

PZ:AddButton("InstantAttract", {
    Text = "将披萨TP在脚下",
    Func = function()
        local player = Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local rootPart = character.HumanoidRootPart
            for _, pizza in ipairs(workspace:GetDescendants()) do
                if pizza:IsA("BasePart") and pizza.Name == "Pizza" then
                    pizza.CFrame = rootPart.CFrame
                    break
                end
            end
        end
    end
})

local tripmineData = {
    active = false,
    killerParts = {},  
    tripmineParts = {},
    connections = {},
    speed = 20, 
    survivorNames = {} 
}


local function updateSurvivors()
    tripmineData.survivorNames = {}
    local survivorsFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Players") and workspace.Map.Players:FindFirstChild("Survivors")
    if survivorsFolder then
        for _, survivor in ipairs(survivorsFolder:GetChildren()) do
            if survivor:IsA("Model") then
                table.insert(tripmineData.survivorNames, survivor.Name)
                print("[DEBUG] 排除幸存者:", survivor.Name)
            end
        end
    else
        warn("[WARNING] 未找到 Survivors 文件夹，可能无法排除Taph！")
    end
end

-- 更新杀手位置（自动排除幸存者）
local function updateKillers()
    tripmineData.killerParts = {}
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if killersFolder then
        for _, killer in ipairs(killersFolder:GetChildren()) do
            if killer:IsA("Model") and not table.find(tripmineData.survivorNames, killer.Name) then
                local rootPart = killer:FindFirstChild("HumanoidRootPart") or killer:FindFirstChildWhichIsA("BasePart")
                if rootPart then
                    table.insert(tripmineData.killerParts, rootPart)
                    print("[DEBUG] 有效杀手:", killer.Name, "位置:", rootPart.Position)
                end
            end
        end
    else
        warn("[ERROR] 未找到 Killers 文件夹！")
    end
end

-- 更新三角炸弹
local function updateTripmines()
    tripmineData.tripmineParts = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "SubspaceTripmine" then
            local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if part then
                table.insert(tripmineData.tripmineParts, part)
            end
        end
    end
end

-- 平滑移动炸弹（速度控制）
local function moveTripmines(deltaTime)
    if #tripmineData.killerParts == 0 then return end

    for _, tripmine in ipairs(tripmineData.tripmineParts) do
        if tripmine and tripmine.Parent then
            -- 找到最近的杀手（已自动排除幸存者）
            local nearestKiller, minDist = nil, math.huge
            for _, killerPart in ipairs(tripmineData.killerParts) do
                if killerPart and killerPart.Parent then
                    local dist = (tripmine.Position - killerPart.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        nearestKiller = killerPart
                    end
                end
            end

            -- 移动逻辑
            if nearestKiller then
                local direction = (nearestKiller.Position - tripmine.Position).Unit
                local moveDistance = math.min(tripmineData.speed * deltaTime, minDist)
                tripmine.CFrame = CFrame.new(tripmine.Position + direction * moveDistance)
            end
        end
    end
end

local DF = Tabs.lol:AddRightGroupbox('Dusekkar')
DF:AddButton("Dusekkar穿墙保护", function()
hookfunction(require(game:GetService("ReplicatedStorage").Modules.Util).IsOnScreen, function(...) return true end)
    end)
    
local ZZ = Tabs.lol:AddRightGroupbox('塔夫追踪')

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game.Workspace

ZZ:AddToggle("TripmineTracker", {
    Text = "三角炸弹自动追踪",
    Default = false,
    Callback = function(enabled)
        if enabled then
            -- 原脚本的所有变量和函数
            local TRPSP = 80 -- 炸弹速度
            local UPDAT = 0.1
            local For = 16000  -- 推的力
            local KILLNAMEE = "Jason" -- 默认杀手名
            local activeConnections = {}

            local function GetKIPOs()
                local killerPositions = {}

                local KILlEF = Workspace:FindFirstChild("Players")
                if KILlEF then
                    KILlEF = KILlEF:FindFirstChild("Killers")
                end

                if not KILlEF then
                    local jasonModel = Workspace:FindFirstChild(KILLNAMEE, true)
                    if jasonModel and jasonModel:IsA("Model") then
                        local primaryPart = jasonModel.PrimaryPart
                            or jasonModel:FindFirstChild("HumanoidRootPart")
                            or jasonModel:FindFirstChild("Torso")
                            or jasonModel:FindFirstChild("UpperTorso")
                            or jasonModel:FindFirstChild("LowerTorso")
                            or jasonModel:FindFirstChildOfClass("Part")

                        if primaryPart then
                            table.insert(killerPositions, {
                                position = primaryPart.Position,
                                model = jasonModel,
                                name = jasonModel.Name,
                                partName = primaryPart.Name,
                            })
                        end
                    end

                    return killerPositions
                end

                local children = KILlEF:GetChildren()

                for _, obj in pairs(children) do
                    if obj:IsA("Model") then
                        local primaryPart = obj.PrimaryPart
                            or obj:FindFirstChild("HumanoidRootPart")
                            or obj:FindFirstChild("Torso")
                            or obj:FindFirstChild("UpperTorso")
                            or obj:FindFirstChild("LowerTorso")
                            or obj:FindFirstChildOfClass("Part")

                        if primaryPart then
                            table.insert(killerPositions, {
                                position = primaryPart.Position,
                                model = obj,
                                name = obj.Name,
                                partName = primaryPart.Name,
                            })
                        end
                    end
                end

                return killerPositions
            end

            local function ALTRP()
                local tripmines = {}

                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("Model") and string.find(obj.Name, "SubspaceTripmine") then
                        local primaryPart = obj.PrimaryPart
                            or obj:FindFirstChild("HumanoidRootPart")
                            or obj:FindFirstChildOfClass("Part")

                        if primaryPart then
                            table.insert(tripmines, {
                                model = obj,
                                part = primaryPart,
                                name = obj.Name,
                            })
                        end
                    end
                end

                return tripmines
            end

            local function FiNdNIGGDAR(TRPOs, TAGA)
                local NEARTarget = nil
                local NEARDistance = math.huge

                for _, target in pairs(TAGA) do
                    local distance = (target.position - TRPOs).Magnitude
                    if distance < NEARDistance then
                        NEARDistance = distance
                        NEARTarget = target
                    end
                end

                return NEARTarget
            end

            local function CaTrFc(tripminePart)
                for _, child in pairs(tripminePart:GetChildren()) do
                    if child:IsA("BodyVelocity") or child:IsA("BodyPosition") or child:IsA("BodyAngularVelocity") then
                        child:Destroy()
                    end
                end

                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(For, For, For)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.Parent = tripminePart

                local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
                bodyAngularVelocity.MaxTorque = Vector3.new(4000, 4000, 4000)
                bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
                bodyAngularVelocity.Parent = tripminePart

                return bodyVelocity
            end

            local function UPTAR()
                local killerPositions = GetKIPOs()
                local tripmines = ALTRP()

                if #killerPositions == 0 then
                    return
                end

                if #tripmines == 0 then
                    return
                end

                for _, tripmine in pairs(tripmines) do
                    local currentPos = tripmine.part.Position
                    local NEARTarget = FiNdNIGGDAR(currentPos, killerPositions)

                    if NEARTarget then
                        local direction = (NEARTarget.position - currentPos).Unit
                        local distance = (NEARTarget.position - currentPos).Magnitude

                        local adjustedSpeed = math.min(TRPSP, distance * 2)
                        local KILLVETOR = direction * adjustedSpeed

                        local bodyVelocity = tripmine.part:FindFirstChild("BodyVelocity")
                        if not bodyVelocity then
                            bodyVelocity = CaTrFc(tripmine.part)
                        end

                        if bodyVelocity then
                            local currentVel = bodyVelocity.Velocity
                            local smoothVel = currentVel:lerp(KILLVETOR, 0.3)
                            bodyVelocity.Velocity = smoothVel
                        end
                    end
                end
            end

            local function cleanup()
                for _, connection in pairs(activeConnections) do
                    if connection then
                        connection:Disconnect()
                    end
                end
                activeConnections = {}
            end

            local function STTark()
                cleanup()

                local lastUpdate = 0
                local connection = RunService.Heartbeat:Connect(function()
                    local currentTime = tick()
                    if currentTime - lastUpdate >= UPDAT then
                        lastUpdate = currentTime
                        UPTAR()
                    end
                end)

                table.insert(activeConnections, connection)
            end

            -- 玩家离开时清理
            local playerRemovingConnection = Players.PlayerRemoving:Connect(function()
                cleanup()
            end)
            table.insert(activeConnections, playerRemovingConnection)

            -- 启动追踪
            STTark()
            print("[SUCCESS] 三角炸弹追踪已启用")
        else
            -- 清理所有连接
            for _, connection in pairs(activeConnections) do
                if connection then
                    connection:Disconnect()
                end
            end
            activeConnections = {}
            print("[INFO] 三角炸弹追踪已禁用")
        end
    end
})


local ZZ = Tabs.lol:AddRightGroupbox('防炸弹')
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

ZZ:AddToggle("TripmineTracker", {
    Text = "弹飞炸弹",
    Default = false,
    Callback = function(enabled)
        local TRPSP = 3000
        local UPDATE_INTERVAL = 0.2
        local DETECTION_RANGE = 30
        local KILLER_NAME = "Jason"
        
        local systemActive = false
        local heartbeatConnection = nil
        local lastUpdate = 0
        
        local FindFirstChild = game.FindFirstChild
        local GetChildren = game.GetChildren
        local FindFirstChildWhichIsA = game.FindFirstChildWhichIsA
        local GetDescendants = Workspace.GetDescendants
        local wait = task.wait
        
        local function GetKillerPositions()
            local killerPositions = {}
            local killersFolder = FindFirstChild(Workspace, "Players") and FindFirstChild(Workspace.Players, "Killers")
            
            if killersFolder then
                for _, model in ipairs(GetChildren(killersFolder)) do
                    if model:IsA("Model") then
                        local primaryPart = model.PrimaryPart or FindFirstChildWhichIsA(model, "BasePart")
                        if primaryPart then
                            table.insert(killerPositions, primaryPart)
                        end
                    end
                end
            else
                local killerModel = FindFirstChild(Workspace, KILLER_NAME, true)
                if killerModel and killerModel:IsA("Model") then
                    local primaryPart = killerModel.PrimaryPart or FindFirstChildWhichIsA(killerModel, "BasePart")
                    if primaryPart then
                        table.insert(killerPositions, primaryPart)
                    end
                end
            end
            
            return killerPositions
        end

        local lastTripmineCheck = 0
        local tripmineCache = {}
        local CACHE_DURATION = 2
        
        local function FindTripmines()
            local now = tick()
            
            if now - lastTripmineCheck < CACHE_DURATION then
                return tripmineCache
            end
            
            table.clear(tripmineCache)
            
            for _, obj in ipairs(GetDescendants(Workspace)) do
                if obj:IsA("Model") and obj.Name:find("SubspaceTripmine") then
                    local primaryPart = obj.PrimaryPart or FindFirstChildWhichIsA(obj, "BasePart")
                    if primaryPart then
                        table.insert(tripmineCache, primaryPart)
                    end
                end
            end
            
            lastTripmineCheck = now
            return tripmineCache
        end

        local function LaunchTripmine(tripminePart, direction)
            for _, child in ipairs(GetChildren(tripminePart)) do
                if child:IsA("BodyMover") then
                    child:Destroy()
                end
            end
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Velocity = direction * TRPSP
            bodyVelocity.P = 1000
            bodyVelocity.Parent = tripminePart
            
            tripminePart.CanCollide = false
            
            delay(5, function()
                if tripminePart and tripminePart.Parent then
                    tripminePart:Destroy()
                end
            end)
        end

        local function UpdateBombs()
            local now = tick()
            if now - lastUpdate < UPDATE_INTERVAL then return end
            lastUpdate = now
            
            local killers = GetKillerPositions()
            if #killers == 0 then return end
            
            local tripmines = FindTripmines()
            if #tripmines == 0 then return end
            
            for _, tripmine in ipairs(tripmines) do
                local minePos = tripmine.Position
                local nearestKiller, minDist = nil, DETECTION_RANGE
                
                for _, killer in ipairs(killers) do
                    local dist = (killer.Position - minePos).Magnitude
                    if dist < minDist then
                        minDist = dist
                        nearestKiller = killer
                    end
                end
                
                if nearestKiller then
                    local dir = (minePos - nearestKiller.Position).Unit
                    dir = dir + Vector3.new(0, 0.8, 0)
                    
                    LaunchTripmine(tripmine, dir)
                end
            end
        end

        if enabled then
            if systemActive then return end
            systemActive = true
            
            heartbeatConnection = RunService.Stepped:Connect(function()
                if systemActive then
                    UpdateBombs()
                end
            end)
        else
            systemActive = false
            if heartbeatConnection then
                heartbeatConnection:Disconnect()
                heartbeatConnection = nil
            end
            
            table.clear(tripmineCache)
        end
    end
})

local ZZ = Tabs.zdg:AddRightGroupbox('访客自动格挡')

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local config = {
    BlockDistance = 15,
    ScanInterval = 0.05,
    BlockCooldown = 0.5,
    DebugMode = true,
    AutoAdjustDistance = true,
    PredictEnabled = true, 
    PredictDistance = 17,   
    BasePredictAmount = 2,  
    TargetSoundIds = {
        "rbxassetid://102228729296384",
        "rbxassetid://140242176732868",
        "rbxassetid://12222216",
        "rbxassetid://86174610237192",
        "rbxassetid://101199185291628",
        "rbxassetid://95079963655241",
        "rbxassetid://112809109188560"
    }
}

local LocalPlayer = Players.LocalPlayer
local RemoteEvent = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")
local lastBlockTime = 0
local combatConnection = nil

local function HasTargetSound(character)
    if not character then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        for _, child in ipairs(humanoidRootPart:GetDescendants()) do
            if child:IsA("Sound") then
                for _, targetId in ipairs(config.TargetSoundIds) do
                    if child.SoundId == targetId then
                        if config.DebugMode then
                            print("Audio detected:", humanoidRootPart:GetFullName(), "ID:", child.SoundId)
                        end
                        return true
                    end
                end
            end
        end
    end
    
    for _, sound in ipairs(character:GetDescendants()) do
        if sound:IsA("Sound") then
            for _, targetId in ipairs(config.TargetSoundIds) do
                if sound.SoundId == targetId then
                    if config.DebugMode then
                        print("Audio detected:", sound:GetFullName(), "ID:", sound.SoundId)
                    end
                    return true
                end
            end
        end
    end
    
    return false
end

local function GetKillersInRange()
    local killers = {}
    local killersFolder = workspace:FindFirstChild("Killers") or workspace:FindFirstChild("Players"):FindFirstChild("Killers")
    if not killersFolder then return killers end
    
    local myCharacter = LocalPlayer.Character
    if not myCharacter or not myCharacter:FindFirstChild("HumanoidRootPart") then return killers end
    
    local myPos = myCharacter.HumanoidRootPart.Position
    
    for _, killer in ipairs(killersFolder:GetChildren()) do
        if killer:FindFirstChild("HumanoidRootPart") then
            local distance = (killer.HumanoidRootPart.Position - myPos).Magnitude
            local checkDistance = config.BlockDistance
            if config.PredictEnabled then
                checkDistance = checkDistance + config.BasePredictAmount
            end
            if distance <= checkDistance then
                table.insert(killers, killer)
            end
        end
    end
    
    return killers
end

local function PerformBlock()
    if os.clock() - lastBlockTime >= config.BlockCooldown then
        RemoteEvent:FireServer("UseActorAbility", "Block")
        lastBlockTime = os.clock()
        if config.DebugMode then
            print("Block performed at:", os.clock())
        end
    end
end

local function CombatLoop()
    local killers = GetKillersInRange()
    
    for _, killer in ipairs(killers) do
        if HasTargetSound(killer) then
            PerformBlock()
            break
        end
    end
end

local function Initialize()
    if not LocalPlayer.Character then
        LocalPlayer.CharacterAdded:Wait()
    end

    print("Block system initialized")
    print(string.format("当前设置: 基础距离 %.1fm | 预判距离 %.1fm | 总距离 %.1fm", 
        config.BlockDistance, config.BasePredictAmount, config.BlockDistance + config.BasePredictAmount))
end

ZZ:AddToggle("AutoBlock", {
    Text = "自动格挡",
    Default = false,
    Callback = function(enabled)
        if enabled then
            Initialize()
            combatConnection = RunService.Stepped:Connect(CombatLoop)
            print(string.format("[Auto Block] OK | 当前距离:%.1fm (总距离:%.1fm)", 
                config.BlockDistance, config.BlockDistance + (config.PredictEnabled and config.BasePredictAmount or 0)))
        else
            if combatConnection then
                combatConnection:Disconnect()
                combatConnection = nil
            end
            print("[智能格挡] 已停用")
        end
    end
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local config = {
    BlockDistance = 15,
    ScanInterval = 0.05,
    BlockCooldown = 0.5,
    DebugMode = true,
    TargetSoundIds = {
        "rbxassetid://102228729296384",
        "rbxassetid://140242176732868",
        "rbxassetid://12222216",
        "rbxassetid://86174610237192",
        "rbxassetid://101199185291628",
        "rbxassetid://95079963655241",
        "rbxassetid://112809109188560"
    }
}

local LocalPlayer = Players.LocalPlayer
local RemoteEvent = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")
local lastBlockTime = 0

local function HasTargetSound(character)
    if not character then return false end

    local function checkSoundFolder(folder)
        for _, sound in ipairs(folder:GetDescendants()) do
            if sound:IsA("Sound") then
                for _, targetId in ipairs(config.TargetSoundIds) do
                    if sound.SoundId == targetId then
                        if config.DebugMode then
                            print("Audio detected:", sound:GetFullName(), "ID:", sound.SoundId)
                        end
                        return true
                    end
                end
            end
        end
        return false
    end

    return checkSoundFolder(character:FindFirstChild("HumanoidRootPart") or character) or checkSoundFolder(character)
end

local function GetKillersInRange()
    local killers = {}
    local killersFolder = workspace:FindFirstChild("Killers") or workspace:FindFirstChild("Players"):FindFirstChild("Killers")
    if not killersFolder then return killers end

    local myCharacter = LocalPlayer.Character
    if not myCharacter or not myCharacter:FindFirstChild("HumanoidRootPart") then return killers end

    local myPos = myCharacter.HumanoidRootPart.Position

    for _, killer in ipairs(killersFolder:GetChildren()) do
        if killer:FindFirstChild("HumanoidRootPart") then
            local distance = (killer.HumanoidRootPart.Position - myPos).Magnitude
            if distance <= config.BlockDistance then
                table.insert(killers, killer)
            end
        end
    end

    return killers
end

local function PerformBlock()
    if os.clock() - lastBlockTime >= config.BlockCooldown then
        RemoteEvent:FireServer("UseActorAbility", "Block")
        lastBlockTime = os.clock()
        if config.DebugMode then
            print("Block performed at:", os.clock())
        end
    end
end

local function CheckConditions()
    local killers = GetKillersInRange()
    for _, killer in ipairs(killers) do
        if HasTargetSound(killer) then
            PerformBlock()
            break
        end
    end
end

local autoBlockEnabled = false

RunService.Stepped:Connect(function()
    if autoBlockEnabled then
        pcall(CheckConditions)
    end
end)
ZZ:AddToggle("AutoBlockToggle", {
    Text = "自动格挡2",
    Default = false,
    Callback = function(enabled)
        autoBlockEnabled = enabled
        print("", enabled and "？" or "？")
    end
})

ZZ:AddToggle("PredictEnabled", {
    Text = "预判系统开关",
    Default = true,
    Callback = function(enabled)
        config.PredictEnabled = enabled
        print(enabled and "[预判系统] 已启用" or "[预判系统] 已禁用")
        print(string.format("当前总距离: %.1fm", config.BlockDistance + (enabled and config.BasePredictAmount or 0)))
    end
})

ZZ:AddSlider("BaseDistance", {
    Text = "基础格挡距离",
    Default = 10,
    Min = 0,
    Max = 20,
    Rounding = 1,
    Callback = function(value)
        config.BlockDistance = value
        print(string.format("[基础距离] 已更新: %.1fm (总距离: %.1fm)", 
            value, value + (config.PredictEnabled and config.BasePredictAmount or 0)))
    end
})

ZZ:AddSlider("PredictAmount", {
    Text = "预判距离调节",
    Default = 2,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Callback = function(value)
        config.BasePredictAmount = value
        print(string.format("[预判距离] 已更新: %.1fm (总距离: %.1fm)", 
            value, config.BlockDistance + (config.PredictEnabled and value or 0)))
    end
})

local KillerSurvival = Tabs.zdx:AddLeftGroupbox("自动修机")

KillerSurvival:AddSlider("GeneratorDelay", {
    Text = "修机间隔",
    Min = 1.5,
    Max = 12,
    Default = 1.5,
    Compact = true,
    Rounding = 1,
    Callback = function(v)
        _G.AutoGeneratorDelay = v
    end
})

_G.AutoGeneratorDelay = 1.5

KillerSurvival:AddToggle("AutoFix", {
    Text = "自动修发电机",
    Callback = function(enabled)
        local debounce = {}
        local generatorFolder = game.Workspace.Map.Ingame.Map
        
        while enabled do
            task.wait()
            
            for _, generator in pairs(generatorFolder:GetChildren()) do
                if generator.Name == "Generator" then
                    if not debounce[generator] then
                        local remotes = generator:FindFirstChild("Remotes")
                        local re = remotes and remotes:FindFirstChild("RE")
                        
                        if re then
                            debounce[generator] = true
                            re:FireServer()
                            
                            task.delay(_G.AutoGeneratorDelay or 1.5, function()
                                debounce[generator] = nil
                            end)
                        end
                    end
                end
            end
        end
    end
})

local autoRepairConnection
KillerSurvival:AddToggle("AutoRepairAndNoClip", {
    Text = "单次传送修机",
    Default = false,
    Tooltip = "传送到最近未完成的发电机",
    Callback = function(state)
        local player = game.Players.LocalPlayer
        
        if state then
            local function getValidGenerators()
                local validGenerators = {}
                local mapParent = workspace:FindFirstChild("Map")
                if mapParent then
                    local ingame = mapParent:FindFirstChild("Ingame")
                    if ingame then
                        local generatorFolder = ingame:FindFirstChild("Map")
                        if generatorFolder then
                            for _, g in ipairs(generatorFolder:GetChildren()) do
                                if g.Name == "Generator" and g:FindFirstChild("Progress") and g.Progress.Value < 100 then
                                    table.insert(validGenerators, g)
                                end
                            end
                        end
                    end
                end
                return validGenerators
            end

            local function getNearestGenerator()
                local validGenerators = getValidGenerators()
                local closest, shortest = nil, math.huge
                if player and player.Character and player.Character.PrimaryPart then
                    local pos = player.Character.PrimaryPart.Position
                    for _, g in ipairs(validGenerators) do
                        local part = g.PrimaryPart or g:FindFirstChildWhichIsA("BasePart")
                        if part then
                            local dist = (part.Position - pos).Magnitude
                            if dist < shortest then
                                shortest = dist
                                closest = g
                            end
                        end
                    end
                end
                return closest
            end

            local function getGeneratorCFrame(generator)
                local TC = nil
                if generator:IsA("Model") then
                    if generator.PrimaryPart then
                        TC = generator.PrimaryPart.CFrame
                    else
                        for _, part in ipairs(generator:GetDescendants()) do
                            if part:IsA("BasePart") then
                                TC = part.CFrame
                                break
                            end
                        end
                    end
                elseif generator:IsA("BasePart") then
                    TC = generator.CFrame
                end
                return TC and (TC * CFrame.new(0, 3, 0)) or nil
            end

            autoRepairConnection = task.spawn(function()
                local target = getNearestGenerator()
                if not target then
                    Library:Notify("没有可用的发电机", nil, 4590657391)
                    if zhuy.SetToggle then zhuy:SetToggle("AutoRepairAndNoClip", false) end
                    return
                end
                local cf = getGeneratorCFrame(target)
                if cf and player.Character and player.Character.PrimaryPart then
                    player.Character:SetPrimaryPartCFrame(cf)
                end
                if zhuy.SetToggle then zhuy:SetToggle("AutoRepairAndNoClip", false) end
            end)
        else
            if autoRepairConnection then
                task.cancel(autoRepairConnection)
                autoRepairConnection = nil
            end
        end
    end
})

local autoRepairConnection
KillerSurvival:AddToggle("AutoRepairAndNoClip", {
    Text = "传送修机（每15秒传送一次）",
    Default = false,
    Tooltip = "每15秒传送到最近未完成的发电机并穿墙",
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local char = player.Character
        local runService = game:GetService("RunService")

        if state then
            _G.GA = true

            
            _G.NoClip = runService.Stepped:Connect(function()
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)

            
            local function getValidGenerators()
                local validGenerators = {}
                local mapParent = workspace:FindFirstChild("Map")
                if mapParent then
                    local ingame = mapParent:FindFirstChild("Ingame")
                    if ingame then
                        local generatorFolder = ingame:FindFirstChild("Map")
                        if generatorFolder then
                            for _, g in ipairs(generatorFolder:GetChildren()) do
                                if g.Name == "Generator" and g:FindFirstChild("Progress") and g.Progress.Value < 100 then
                                    table.insert(validGenerators, g)
                                end
                            end
                        end
                    end
                end
                return validGenerators
            end

            
            local function getNearestGenerator()
                local validGenerators = getValidGenerators()
                local closest, shortest = nil, math.huge
                if player and player.Character and player.Character.PrimaryPart then
                    local pos = player.Character.PrimaryPart.Position
                    for _, g in ipairs(validGenerators) do
                        local part = g.PrimaryPart or g:FindFirstChildWhichIsA("BasePart")
                        if part then
                            local dist = (part.Position - pos).Magnitude
                            if dist < shortest then
                                shortest = dist
                                closest = g
                            end
                        end
                    end
                end
                return closest
            end

          
            local function getGeneratorCFrame(generator)
                local TC = nil
                if generator:IsA("Model") then
                    if generator.PrimaryPart then
                        TC = generator.PrimaryPart.CFrame
                    else
                        for _, part in ipairs(generator:GetDescendants()) do
                            if part:IsA("BasePart") then
                                TC = part.CFrame
                                break
                            end
                        end
                    end
                elseif generator:IsA("BasePart") then
                    TC = generator.CFrame
                end
                return TC and (TC * CFrame.new(0, 3, 0)) or nil
            end

          
            autoRepairConnection = task.spawn(function()
                while _G.GA do
                    local target = getNearestGenerator()
                    if not target then
                        Library:Notify("没有可用的发电机", nil, 4590657391)
                        if zhuy.SetToggle then zhuy:SetToggle("AutoRepairAndNoClip", false) end
                        break
                    end
                    local cf = getGeneratorCFrame(target)
                    if cf and player.Character and player.Character.PrimaryPart then
                        player.Character:SetPrimaryPartCFrame(cf)
                    end
                    task.wait(15)
                end
            end)

        else
            _G.GA = false
            if _G.NoClip then
                _G.NoClip:Disconnect()
                _G.NoClip = nil
            end
            if autoRepairConnection then
                task.cancel(autoRepairConnection)
                autoRepairConnection = nil
            end
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end
})

KillerSurvival:AddLabel("自定义")

local teleportInterval = 15

KillerSurvival:AddToggle("AutoRepairAndNoClip", {
    Text = "传送修机",
    Default = false,
    Tooltip = "传送到最近未完成的发电机并穿墙",
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local char = player.Character
        local runService = game:GetService("RunService")

        if state then
            _G.GA = true

            _G.NoClip = runService.Stepped:Connect(function()
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)

            local function getValidGenerators()
                local validGenerators = {}
                local mapParent = workspace:FindFirstChild("Map")
                if mapParent then
                    local ingame = mapParent:FindFirstChild("Ingame")
                    if ingame then
                        local generatorFolder = ingame:FindFirstChild("Map")
                        if generatorFolder then
                            for _, g in ipairs(generatorFolder:GetChildren()) do
                                if g.Name == "Generator" and g:FindFirstChild("Progress") and g.Progress.Value < 100 then
                                    table.insert(validGenerators, g)
                                end
                            end
                        end
                    end
                end
                return validGenerators
            end

            local function getNearestGenerator()
                local validGenerators = getValidGenerators()
                local closest, shortest = nil, math.huge
                if player and player.Character and player.Character.PrimaryPart then
                    local pos = player.Character.PrimaryPart.Position
                    for _, g in ipairs(validGenerators) do
                        local part = g.PrimaryPart or g:FindFirstChildWhichIsA("BasePart")
                        if part then
                            local dist = (part.Position - pos).Magnitude
                            if dist < shortest then
                                shortest = dist
                                closest = g
                            end
                        end
                    end
                end
                return closest
            end

            local function getGeneratorCFrame(generator)
                local TC = nil
                if generator:IsA("Model") then
                    if generator.PrimaryPart then
                        TC = generator.PrimaryPart.CFrame
                    else
                        for _, part in ipairs(generator:GetDescendants()) do
                            if part:IsA("BasePart") then
                                TC = part.CFrame
                                break
                            end
                        end
                    end
                elseif generator:IsA("BasePart") then
                    TC = generator.CFrame
                end
                return TC and (TC * CFrame.new(0, 3, 0)) or nil
            end

            local function teleportToOne()
                local target = getNearestGenerator()
                if not target then
                    Library:Notify("没有可用的发电机", nil, 4590657391)
                    if zhuy.SetToggle then zhuy:SetToggle("AutoRepairAndNoClip", false) end
                    return
                end
                local cf = getGeneratorCFrame(target)
                if cf and player.Character and player.Character.PrimaryPart then
                    player.Character:SetPrimaryPartCFrame(cf)
                end
            end

            task.spawn(function()
                while _G.GA do
                    teleportToOne()
                    task.wait(teleportInterval)
                end
            end)

        else
            _G.GA = false
            if _G.NoClip then
                _G.NoClip:Disconnect()
                _G.NoClip = nil
            end
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end
})

KillerSurvival:AddSlider("TeleportIntervalSlider", {
    Text = "传送间隔(秒)",
    Min = 1,
    Max = 30,
    Default = 15,
    Tooltip = "调整每次传送的间隔时间",
    Callback = function(value)
        teleportInterval = value
        Library:Notify("传送间隔已设置为 " .. value .. " 秒", nil, 4590657391)
    end
})

local zhuy = Tabs.zdx:AddRightGroupbox("修机")
zhuy:AddLabel("暴力版")
_G.REP = 2

zhuy:AddSlider('MySlider', {
    Text     = '修理发电机时间(秒）',
    Default  = _G.REP,
    Min      = 2,
    Max      = 30,
    Rounding = 0,
    Compact  = false,
    Callback = function(value)
        _G.REP = value
    end
})

zhuy:AddToggle('MyToggle', {
    Text = '修理暴力发电机',
    Default = false,
    Tooltip = 'King',
    Callback = function(state)
        _G.BTE = state

        local function RepairGenerators()
            local map = workspace:FindFirstChild("Map")
            local ingame = map and map:FindFirstChild("Ingame")
            local currentMap = ingame and ingame:FindFirstChild("Map")

            if currentMap then
                for _, obj in ipairs(currentMap:GetChildren()) do
                    if obj.Name == "Generator" and obj:FindFirstChild("Progress") and obj.Progress.Value < 100 then
                        local remote = obj:FindFirstChild("Remotes") and obj.Remotes:FindFirstChild("RE")
                        if remote then
                            remote:FireServer()
                        end
                    end
                end
            end
        end

        if state then
            task.spawn(function()
                while _G.BTE do
                    RepairGenerators()
                    task.wait(_G.REP or 2)
                end
            end)
        else
            Library:Notify("已关闭暴力修理发电机", nil, 4590657391)
        end
    end
})

zhuy:AddLabel("正常版")


zhuy:AddToggle('MyToggle', {
    Text = '自动修理发电机',
    Default = false,
    Tooltip = 'fix',
    Callback = function(state)
        autoGR = state

        if state then
            Library:Notify("自动修理发电机已开启", nil, 4590657391)
            spawn(function()
                local player = Players.LocalPlayer
                
                while autoGR do
                    task.wait(REP)
                    if not autoGR then break end
                    
                  
                    if not player.Character then break end
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if not hrp then break end
                    
                   
                    local map = workspace:FindFirstChild("Map")
                    local mapRoot = map and map:FindFirstChild("Ingame") and map.Ingame:FindFirstChild("Map")
                    if not mapRoot then break end
                    
                 
                    local playerPos = hrp.Position
                    local closest, minDist = nil, math.huge
                    
                    for _, g in ipairs(mapRoot:GetChildren()) do
                        if g.Name == "Generator" 
                        and g:FindFirstChild("Progress") 
                        and g.Progress.Value < 100
                        and g:FindFirstChild("Main")
                        then
                            local distance = (g.Main.Position - playerPos).Magnitude
                            if distance < minDist then
                                minDist, closest = distance, g
                            end
                        end
                    end
                    
                   
                    if closest then
                        local remotes = closest:FindFirstChild("Remotes")
                        local re = remotes and remotes:FindFirstChild("RE")
                        if re then
                            re:FireServer()
                            Library:Notify("修理", nil, 4590657391)
                        end
                    end
                end
            end)
        else
            Library:Notify("自动修理已关闭", nil, 4590657391)
        end
    end
})

local mxj = false

zhuy:AddToggle('MyToggle', {
    Text = '一键修理',
    Default = false,
    Tooltip = '自动寻找最近的发电机进行修理',
    Callback = function(state)
        mxj = state

        if state then
            task.spawn(function()
                while mxj do
                    task.wait(6.5)

                    local map = workspace:FindFirstChild("Map")
                    local ingame = map and map:FindFirstChild("Ingame")
                    local currentMap = ingame and ingame:FindFirstChild("Map")

                    if currentMap then
                        local closestGenerator, closestDistance = nil, math.huge
                        local player = game:GetService("Players").LocalPlayer
                        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

                        if root then
                            local playerPos = root.Position
                            for _, g in ipairs(currentMap:GetChildren()) do
                                if g.Name == "Generator" and g:FindFirstChild("Progress") and g.Progress.Value < 100 then
                                    local mainPart = g:FindFirstChild("Main")
                                    if mainPart then
                                        local distance = (mainPart.Position - playerPos).Magnitude
                                        if distance < closestDistance then
                                            closestDistance = distance
                                            closestGenerator = g
                                        end
                                    end
                                end
                            end

                            if closestGenerator and closestGenerator:FindFirstChild("Remotes") and closestGenerator.Remotes:FindFirstChild("RE") then
                                closestGenerator.Remotes.RE:FireServer()
                            end
                        end
                    end
                end
            end)
        else
            Library:Notify("已关闭一键修理功能", nil, 4590657391)
        end
    end
})


local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
    MenuGroup:AddToggle("KeybindMenuOpen", {
        Default = Library.KeybindFrame.Visible,
        Text = "打开键绑定菜单",
        Callback = function(value)
            Library.KeybindFrame.Visible = value
        end,
    })
    MenuGroup:AddToggle("ShowCustomCursor", {
        Text = "自定义光标",
        Default = true,
        Callback = function(Value)
            Library.ShowCustomCursor = Value
        end,
    })
    MenuGroup:AddDropdown("NotificationSide", {
        Values = { "左", "右" },
        Default = "Right",
        Text = "通知端",
        Callback = function(Value)
            Library:SetNotifySide(Value)
        end,
    })
    MenuGroup:AddDropdown("DPIDropdown", {
        Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
        Default = "100%",
        Text = "DPI刻度",
        Callback = function(Value)
            Value = Value:gsub("%%", "")
            local DPI = tonumber(Value)
            Library:SetDPIScale(DPI)
        end,
    })
    MenuGroup:AddDivider()
    MenuGroup:AddLabel("Menu bind")
        :AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "菜单键绑定" })

    MenuGroup:AddButton("Unload", function()
        Library:Unload()
    end)
    
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
    ThemeManager:SetFolder("Linni Hub") 
SaveManager:SetFolder("Linni Hub/specific-game") 
SaveManager:SetSubFolder("specific-place") 
SaveManager:BuildConfigSection(Tabs["UI Settings"])

ThemeManager:ApplyToTab(Tabs["UI Settings"])
    SaveManager:LoadAutoloadConfig()
wait(0.1)
else
setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")
game.Players.LocalPlayer:Kick("你没复制全，中文也是的❌")
end