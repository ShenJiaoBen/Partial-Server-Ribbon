local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/eeeiqjjj/WindUI/main/dist/main.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Window = WindUI:CreateWindow({
    Folder = "linni",
    Title = "LinniScript｜被遗弃",
    Author = "作者[霖溺]",
    Theme = "Light",
    HasOutline = true,
    Resizable = true,
    SideBarWidth = 120,
    HideSearchBar = true,
    ScrollBarEnabled = true,
})
Window:EditOpenButton({
    Title = "[打开霖溺]",
    CornerRadius = UDim.new(0, 6),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromRGB(200, 0, 255), Color3.fromRGB(0, 200, 255)),
    Draggable = true,
    OnlyMobile = false,
})

local Sections = {
    Home = Window:Section({
        Title = "主页",
        Icon = "star",
        Opened = true,
    }),
    Features = Window:Section({
        Title = "功能",
        Icon = "package",
        Opened = true,
    }),
}

local Tabs = {
    Home = Sections.Home:Tab({
        Title = "脚本简介",
        Icon = "star",
        ShowTabTitle = true
    }),
    Stamina_Settings = Sections.Features:Tab({
        Title = "耐力设置",
        Icon = "footprints",
        ShowTabTitle = true
    }),
    Esp = Sections.Features:Tab({
        Title = "Esp",
        Icon = "eye",
        ShowTabTitle = true
    }),
    AutoBlock = Sections.Features:Tab({
        Title = "自动格挡",
        Icon = "shield",
        ShowTabTitle = true
    }),
    Misc = Sections.Features:Tab({
        Title = "主要",
        Icon = "gift",
        ShowTabTitle = true
    }),
    Auto_Stun = Sections.Features:Tab({
        Title = "自动击晕",
        Icon = "spline-pointer",
        ShowTabTitle = true
    }),
    Random = Sections.Features:Tab({
        Title = "随机的",
        Icon = "crosshair",
        ShowTabTitle = true
    }),
    Hitbox_expander = Sections.Features:Tab({
        Title = "范围",
        Icon = "target",
        ShowTabTitle = true
    }),
    Generator = Sections.Features:Tab({
        Title = "发电机",
        Icon = "battery-charging",
        ShowTabTitle = true
    }),
    Teleport = Sections.Features:Tab({
        Title = "传送",
        Icon = "cable",
        ShowTabTitle = true
    }),
    AI = Sections.Features:Tab({
        Title = "AI功能",
        Icon = "brain-circuit",
        ShowTabTitle = true
    }),
    Settings = Sections.Features:Tab({
        Title = "配置",
        Icon = "bolt",
        ShowTabTitle = true
    }),
    Premium = Sections.Features:Tab({
    Title = "高级功能",
    Icon = "circle-dollar-sign",
    ShowTabTitle = true
})
}

getgenv().__Linni_PREMIUM = true
Tabs.Home:Button({
    Title = "点击复制霖溺qq群链接",
    Callback = function()
        setclipboard("https://qm.qq.com/q/1IKMOFnazm")
        WindUI:Notify({
            Title = "已复制",
            Content = "请查看剪贴板",
            Duration = 3,
        })
    end,
})
Tabs.Home:Section({
    Title = "UI设置",
    TextXAlignment = "Left",
    TextSize = 17,
    Icon = "app-window-mac"
})

local Themes = {}

for Name, _ in pairs(WindUI:GetThemes()) do
    table.insert(Themes, Name)
end

Tabs.Home:Dropdown({
    Title = "主题选择",
    Multi = false,
    AllowNone = false,
    Value = "Light",
    Values = Themes,
    Callback = function(v)
        WindUI:SetTheme(v)
    end
})

Tabs.Home:Toggle({
    Title = "透明度",
    Icon = "palette",
    Value = WindUI:GetTransparency(),
    Callback = function(v)
        Window:ToggleTransparency(v)
    end
})

Tabs.Home:Paragraph({
    Title = "哈喽喽各位",
    Desc = "感谢各位使用我的脚本 祝你们玩得开心 玩的快乐",
    Locked = false,
})

Window:SetToggleKey(Enum.KeyCode.P)

local MainTab = Tabs.Random


local HttpService = game:GetService("HttpService")
local configsFolder = "LinniScript_Configs"
if not isfolder(configsFolder) then
    makefolder(configsFolder)
end
local ConfigValues = {}
local UIElements = {}
local selectedConfig = nil
local configName = "Default"


do

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local sprintModule = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)

local defaultValues = {
    MaxStamina = sprintModule.DefaultConfig.MaxStamina or 100,
    MinStamina = sprintModule.DefaultConfig.MinStamina or 0,
    SprintSpeed = sprintModule.DefaultConfig.SprintSpeed or 26,
    StaminaGain = sprintModule.DefaultConfig.StaminaGain or 20,
    StaminaLoss = sprintModule.DefaultConfig.StaminaLoss or 10,
    StaminaLossDisabled = sprintModule.DefaultConfig.StaminaLossDisabled or false,
    BindsEnabled = sprintModule.DefaultConfig.BindsEnabled or true,
    CanSprint = true,
    FOVMultiplier = 1.125,
    SpeedMultiplier = 1
}

local customValues = {
    MaxStamina = defaultValues.MaxStamina,
    MinStamina = defaultValues.MinStamina,
    SprintSpeed = defaultValues.SprintSpeed,
    StaminaGain = defaultValues.StaminaGain,
    StaminaLoss = defaultValues.StaminaLoss,
    FOVMultiplier = defaultValues.FOVMultiplier,
    SpeedMultiplier = defaultValues.SpeedMultiplier
}

local toggleStates = {
    InfiniteStamina = false,
    MaxStamina = false,
    MinStamina = false,
    SprintSpeed = false,
    StaminaGain = false,
    StaminaLoss = false,
    StaminaLossDisabled = false,
    CanSprint = false,
    BindsEnabled = false,
    FOVMultiplier = false,
    SpeedMultiplier = false,
    AlwaysSprint = false
}

RunService.Heartbeat:Connect(function()
    if toggleStates.InfiniteStamina then
        sprintModule.Stamina = customValues.MaxStamina
    end

    if toggleStates.MaxStamina then
        sprintModule.MaxStamina = customValues.MaxStamina
        sprintModule.DefaultConfig.MaxStamina = customValues.MaxStamina
    end

    if toggleStates.MinStamina then
        sprintModule.MinStamina = customValues.MinStamina
        sprintModule.DefaultConfig.MinStamina = customValues.MinStamina
        if sprintModule.Stamina < customValues.MinStamina then
            sprintModule.Stamina = customValues.MinStamina
        end
    end

    if toggleStates.SprintSpeed then
        sprintModule.SprintSpeed = customValues.SprintSpeed
        sprintModule.DefaultConfig.SprintSpeed = customValues.SprintSpeed
    end

    if toggleStates.StaminaGain then
        sprintModule.StaminaGain = customValues.StaminaGain
        sprintModule.DefaultConfig.StaminaGain = customValues.StaminaGain
    end

    if toggleStates.StaminaLoss then
        sprintModule.StaminaLoss = customValues.StaminaLoss
        sprintModule.DefaultConfig.StaminaLoss = customValues.StaminaLoss
    end

    if toggleStates.StaminaLossDisabled then
        sprintModule.StaminaLossDisabled = true
        sprintModule.DefaultConfig.StaminaLossDisabled = true
    end

    if toggleStates.CanSprint then
        sprintModule.CanSprint = true
    end

    if toggleStates.BindsEnabled then
        sprintModule.BindsEnabled = true
        sprintModule.DefaultConfig.BindsEnabled = true
    end

    if toggleStates.FOVMultiplier then
        if sprintModule.__FOVMultiplier then
            sprintModule.__FOVMultiplier.Value = customValues.FOVMultiplier
        end
    end

    if toggleStates.SpeedMultiplier then
        if sprintModule.__speedMultiplier then
            sprintModule.__speedMultiplier.Value = customValues.SpeedMultiplier
        end
    end

    if toggleStates.AlwaysSprint then
        sprintModule.IsSprinting = true
        if sprintModule.__sprintedEvent then
            sprintModule.__sprintedEvent:Fire(true)
        end
    end
end)

local function ResetAllSettings()
    for key, _ in pairs(toggleStates) do
        toggleStates[key] = false
    end

    sprintModule.MaxStamina = defaultValues.MaxStamina
    sprintModule.MinStamina = defaultValues.MinStamina
    sprintModule.SprintSpeed = defaultValues.SprintSpeed
    sprintModule.StaminaGain = defaultValues.StaminaGain
    sprintModule.StaminaLoss = defaultValues.StaminaLoss
    sprintModule.StaminaLossDisabled = defaultValues.StaminaLossDisabled
    sprintModule.BindsEnabled = defaultValues.BindsEnabled
    sprintModule.CanSprint = defaultValues.CanSprint

    sprintModule.DefaultConfig.MaxStamina = defaultValues.MaxStamina
    sprintModule.DefaultConfig.MinStamina = defaultValues.MinStamina
    sprintModule.DefaultConfig.SprintSpeed = defaultValues.SprintSpeed
    sprintModule.DefaultConfig.StaminaGain = defaultValues.StaminaGain
    sprintModule.DefaultConfig.StaminaLoss = defaultValues.StaminaLoss
    sprintModule.DefaultConfig.StaminaLossDisabled = defaultValues.StaminaLossDisabled
    sprintModule.DefaultConfig.BindsEnabled = defaultValues.BindsEnabled

    if sprintModule.__FOVMultiplier then
        sprintModule.__FOVMultiplier.Value = 1
    end
    if sprintModule.__speedMultiplier then
        sprintModule.__speedMultiplier.Value = 1
    end

    customValues.MaxStamina = defaultValues.MaxStamina
    customValues.MinStamina = defaultValues.MinStamina
    customValues.SprintSpeed = defaultValues.SprintSpeed
    customValues.StaminaGain = defaultValues.StaminaGain
    customValues.StaminaLoss = defaultValues.StaminaLoss
    customValues.FOVMultiplier = defaultValues.FOVMultiplier
    customValues.SpeedMultiplier = defaultValues.SpeedMultiplier
end

local staminaSection = Tabs.Stamina_Settings:Section({
    Title = "耐力设置",
    Icon = "zap",
    Opened = false
})

staminaSection:Toggle({
    Flag = "InfiniteStamina",
    Title = "无限耐力",
    Default = false,
    Callback = function(state)
        toggleStates.InfiniteStamina = state
    end
})

staminaSection:Toggle({
    Flag = "CustomMaxStamina",
    Title = "启用自定义的最大耐力",
    Default = false,
    Callback = function(state)
        toggleStates.MaxStamina = state
        if not state then
            sprintModule.MaxStamina = defaultValues.MaxStamina
            sprintModule.DefaultConfig.MaxStamina = defaultValues.MaxStamina
        end
    end
})

staminaSection:Slider({
    Flag = "MaxStaminaValue",
    Title = "最大耐力值",
    Step = 1,
    Value = {Min = 1, Max = 2000, Default = defaultValues.MaxStamina},
    Suffix = " stamina",
    Callback = function(val)
        customValues.MaxStamina = tonumber(val) or defaultValues.MaxStamina
    end
})

staminaSection:Toggle({
    Flag = "CustomMinStamina",
    Title = "启用自定义的最小耐力",
    Default = false,
    Callback = function(state)
        toggleStates.MinStamina = state
        if not state then
            sprintModule.MinStamina = defaultValues.MinStamina
            sprintModule.DefaultConfig.MinStamina = defaultValues.MinStamina
        end
    end
})

staminaSection:Slider({
    Flag = "MinStaminaValue",
    Title = "最小耐力值",
    Step = 1,
    Value = {Min = 0, Max = 1000, Default = defaultValues.MinStamina},
    Suffix = " stamina",
    Callback = function(val)
        customValues.MinStamina = tonumber(val) or defaultValues.MinStamina
    end
})

staminaSection:Toggle({
    Flag = "CustomSprintSpeed",
    Title = "启用自定义的冲刺速度",
    Default = false,
    Callback = function(state)
        toggleStates.SprintSpeed = state
        if not state then
            sprintModule.SprintSpeed = defaultValues.SprintSpeed
            sprintModule.DefaultConfig.SprintSpeed = defaultValues.SprintSpeed
        end
    end
})

staminaSection:Slider({
    Flag = "SprintSpeedValue",
    Title = "冲刺速度值",
    Step = 1,
    Value = {Min = 1, Max = 100, Default = defaultValues.SprintSpeed},
    Suffix = " speed",
    Callback = function(val)
        customValues.SprintSpeed = tonumber(val) or defaultValues.SprintSpeed
    end
})

staminaSection:Toggle({
    Flag = "CustomStaminaGain",
    Title = "启用自定义的体力恢复速度",
    Default = false,
    Callback = function(state)
        toggleStates.StaminaGain = state
        if not state then
            sprintModule.StaminaGain = defaultValues.StaminaGain
            sprintModule.DefaultConfig.StaminaGain = defaultValues.StaminaGain
        end
    end
})

staminaSection:Slider({
    Flag = "StaminaGainValue",
    Title = "耐力恢复速度值",
    Step = 1,
    Value = {Min = 1, Max = 500, Default = defaultValues.StaminaGain},
    Suffix = " per sec",
    Callback = function(val)
        customValues.StaminaGain = tonumber(val) or defaultValues.StaminaGain
    end
})

staminaSection:Toggle({
    Flag = "CustomStaminaLoss",
    Title = "启用自定义消耗",
    Default = false,
    Callback = function(state)
        toggleStates.StaminaLoss = state
        if not state then
            sprintModule.StaminaLoss = defaultValues.StaminaLoss
            sprintModule.DefaultConfig.StaminaLoss = defaultValues.StaminaLoss
        end
    end
})

staminaSection:Slider({
    Flag = "StaminaLossValue",
    Title = "耐力消耗速度",
    Step = 1,
    Value = {Min = 0, Max = 100, Default = defaultValues.StaminaLoss},
    Suffix = " per sec",
    Callback = function(val)
        customValues.StaminaLoss = tonumber(val) or defaultValues.StaminaLoss
    end
})

staminaSection:Toggle({
    Flag = "DisableStaminaLoss",
    Title = "关闭耐力消耗",
    Default = false,
    Callback = function(state)
        toggleStates.StaminaLossDisabled = state
        if not state then
            sprintModule.StaminaLossDisabled = false
            sprintModule.DefaultConfig.StaminaLossDisabled = false
        end
    end
})

staminaSection:Toggle({
    Flag = "AlwaysCanSprint",
    Title = "让人物一直可以冲刺",
    Default = false,
    Callback = function(state)
        toggleStates.CanSprint = state
        if not state then
            sprintModule.CanSprint = true
        end
    end
})

staminaSection:Toggle({
    Flag = "AlwaysBindsEnabled",
    Title = "始终启用按键绑定",
    Default = false,
    Callback = function(state)
        toggleStates.BindsEnabled = state
        if not state then
            sprintModule.BindsEnabled = true
            sprintModule.DefaultConfig.BindsEnabled = true
        end
    end
})

staminaSection:Toggle({
    Flag = "AlwaysSprint",
    Title = "自动持续冲刺 / 永久奔跑",
    Default = false,
    Callback = function(state)
        toggleStates.AlwaysSprint = state
        if not state then
            sprintModule.IsSprinting = false
        end
    end
})

staminaSection:Toggle({
    Flag = "CustomFOVMultiplier",
    Title = "开启FOV",
    Default = false,
    Callback = function(state)
        toggleStates.FOVMultiplier = state
        if not state and sprintModule.__FOVMultiplier then
            sprintModule.__FOVMultiplier.Value = 1
        end
    end
})

staminaSection:Slider({
    Flag = "FOVMultiplierValue",
    Title = "FOV大小",
    Step = 0.01,
    Value = {Min = 0.5, Max = 2, Default = defaultValues.FOVMultiplier},
    Suffix = "x",
    Callback = function(val)
        customValues.FOVMultiplier = tonumber(val) or defaultValues.FOVMultiplier
    end
})

staminaSection:Toggle({
    Flag = "CustomSpeedMultiplier",
    Title = "开启移速",
    Default = false,
    Callback = function(state)
        toggleStates.SpeedMultiplier = state
        if not state and sprintModule.__speedMultiplier then
            sprintModule.__speedMultiplier.Value = 1
        end
    end
})

staminaSection:Slider({
    Flag = "SpeedMultiplierValue",
    Title = "速度值",
    Step = 0.1,
    Value = {Min = 0.5, Max = 5, Default = defaultValues.SpeedMultiplier},
    Suffix = "x",
    Callback = function(val)
        customValues.SpeedMultiplier = tonumber(val) or defaultValues.SpeedMultiplier
    end
})

staminaSection:Button({
    Title = "重置所有设置",
    Callback = function()
        ResetAllSettings()
    end
})

local staminaSection = Tabs.Stamina_Settings:Section({
    Title = "显示玩家耐力",
    Icon = "battery-charging",
    Opened = false,
})

local staminaEnabled = false
local staminaConnections = {}
local speedTrackingData = {}
local billboardSize = 4

staminaSection:Toggle({
    Title = "头顶耐力和速度显示",
    Default = false,
    Callback = function(state)
        staminaEnabled = state

        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local LocalPlayer = Players.LocalPlayer

        if not state then
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    local billboard = player.Character:FindFirstChild("StaminaBillboard")
                    if billboard then
                        billboard:Destroy()
                    end
                    player.Character:SetAttribute("StaminaActive", nil)
                end
            end

            for _, connection in pairs(staminaConnections) do
                if connection and connection.Connected then
                    connection:Disconnect()
                end
            end
            staminaConnections = {}
            speedTrackingData = {}
            return
        end

        local STAMINA_CHANGE_INTERVAL = 0.1
        local EXHAUSTED_COOLDOWN = 3
        local DEFAULT_STATS = {
            MaxStamina = 100,
            StaminaLossPerSec = 7,
            StaminaGainPerSec = 10
        }
        local speedHistorySize = 5
        local RUN_SPEED_THRESHOLD = 20
        local WALK_SPEED_THRESHOLD = 1

        local function getPlayerSpeed(character)
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp then return 0 end
            local currentTime = tick()
            local currentPos = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
            if not speedTrackingData[character] then
                speedTrackingData[character] = {
                    lastPosition = currentPos,
                    lastTime = currentTime,
                    speedHistory = {},
                    smoothedSpeed = 0
                }
                return 0
            end
            local data = speedTrackingData[character]
            local deltaTime = currentTime - data.lastTime
            if deltaTime > 0.01 then
                local deltaPos = (currentPos - data.lastPosition).Magnitude
                local instantSpeed = deltaPos / deltaTime
                table.insert(data.speedHistory, instantSpeed)
                while #data.speedHistory > speedHistorySize do
                    table.remove(data.speedHistory, 1)
                end
                local sum = 0
                for _, s in ipairs(data.speedHistory) do
                    sum = sum + s
                end
                data.smoothedSpeed = sum / #data.speedHistory
                data.lastPosition = currentPos
                data.lastTime = currentTime
            end
            return data.smoothedSpeed
        end

        local function getMovementState(character)
            local speed = getPlayerSpeed(character)
            if speed >= RUN_SPEED_THRESHOLD then
                return "Running", speed
            elseif speed >= WALK_SPEED_THRESHOLD then
                return "Walking", speed
            else
                return "Standing", speed
            end
        end

        local function cleanupSpeedData()
            for character, _ in pairs(speedTrackingData) do
                if not character.Parent then
                    speedTrackingData[character] = nil
                end
            end
        end

        task.spawn(function()
            while staminaEnabled do
                task.wait(10)
                cleanupSpeedData()
            end
        end)

        local sprintModule = nil
        local sprintModuleSuccess = pcall(function()
            sprintModule = require(ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Character"):WaitForChild("Game"):WaitForChild("Sprinting"))
        end)

        local function createStaminaBar(character, isLocal)
            local head = nil
            repeat
                head = character:FindFirstChild("Head")
                task.wait(0.1)
            until head or not character.Parent or not staminaEnabled
            if not head or not staminaEnabled then return nil end
            if character:FindFirstChild("StaminaBillboard") then
                return character.StaminaBillboard:FindFirstChild("StaminaText")
            end
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "StaminaBillboard"
            billboard.Adornee = head
            billboard.Size = UDim2.new(billboardSize, 0, billboardSize / 4, 0)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = character
            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "StaminaText"
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
            textLabel.TextScaled = true
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.Text = "[100/100]"
            textLabel.TextStrokeTransparency = 0.5
            textLabel.Parent = billboard
            return textLabel
        end

        local function getCharacterStats(character)
            local stats = {}
            local assetsFolder = ReplicatedStorage:WaitForChild("Assets")
            local killersFolder = assetsFolder:WaitForChild("Killers")
            local survivorsFolder = assetsFolder:WaitForChild("Survivors")
            local charFolder = killersFolder:FindFirstChild(character.Name)
            if not charFolder then
                charFolder = survivorsFolder:FindFirstChild(character.Name)
            end
            local configModule
            if charFolder then
                configModule = charFolder:FindFirstChild("Config")
            end
            local success, configData = pcall(function()
                if configModule then
                    return require(configModule)
                end
                return nil
            end)
            if success and configData then
                stats.MaxStamina = configData.MaxStamina or DEFAULT_STATS.MaxStamina
                stats.StaminaLossPerSec = configData.StaminaLoss or configData.StaminaDrain or DEFAULT_STATS.StaminaLossPerSec
                stats.StaminaGainPerSec = configData.StaminaGain or DEFAULT_STATS.StaminaGainPerSec
            else
                stats.MaxStamina = DEFAULT_STATS.MaxStamina
                stats.StaminaLossPerSec = DEFAULT_STATS.StaminaLossPerSec
                stats.StaminaGainPerSec = DEFAULT_STATS.StaminaGainPerSec
            end
            stats.StaminaLossPerTick = stats.StaminaLossPerSec * STAMINA_CHANGE_INTERVAL
            stats.StaminaGainPerTick = stats.StaminaGainPerSec * STAMINA_CHANGE_INTERVAL
            return stats
        end

        local function handleLocalPlayer(character)
            if not sprintModule then

                return
            end
            if character:GetAttribute("StaminaActive") then return end
            character:SetAttribute("StaminaActive", true)
            local humanoid = character:WaitForChild("Humanoid", 10)
            local rootPart = character:WaitForChild("HumanoidRootPart", 10)
            local textLabel = createStaminaBar(character, true)
            if not (humanoid and rootPart and textLabel) then
                character:SetAttribute("StaminaActive", nil)
                return
            end
            task.spawn(function()
                while character.Parent and humanoid.Health > 0 and staminaEnabled do
                    task.wait(STAMINA_CHANGE_INTERVAL)
                    if not textLabel.Parent then break end
                    local currentStamina = sprintModule.Stamina or 0
                    local maxStamina = sprintModule.MaxStamina or 100
                    local state, speed = getMovementState(character)
                    local stateIcon = "..."
                    if state == "Running" then
                        stateIcon = "Run"
                    elseif state == "Standing" then
                        stateIcon = "Stand"
                    elseif state == "Walking" then
                        stateIcon = "Walk"
                    end
                    textLabel.Text = string.format("[%d/%d] %s %.1f",
                        math.floor(currentStamina),
                        math.floor(maxStamina),
                        stateIcon,
                        speed
                    )
                    local staminaPercent = currentStamina / maxStamina
                    if staminaPercent > 0.63 then
                        textLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
                    elseif staminaPercent > 0.27 then
                        textLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
                    else
                        textLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
                    end
                end
                character:SetAttribute("StaminaActive", nil)
                if textLabel and textLabel.Parent and textLabel.Parent.Parent then
                    textLabel.Parent:Destroy()
                end
                speedTrackingData[character] = nil
            end)
        end

        local function handleOtherPlayer(character)
            if character:GetAttribute("StaminaActive") then return end
            character:SetAttribute("StaminaActive", true)
            local humanoid = character:WaitForChild("Humanoid", 10)
            local rootPart = character:WaitForChild("HumanoidRootPart", 10)
            local stats = getCharacterStats(character)
            local MAX_STAMINA = stats.MaxStamina
            local STAMINA_LOSS_PER_TICK = stats.StaminaLossPerTick
            local STAMINA_GAIN_PER_TICK = stats.StaminaGainPerTick
            local textLabel = createStaminaBar(character, false)
            if not (humanoid and rootPart and textLabel) then
                character:SetAttribute("StaminaActive", nil)
                return
            end
            local stamina = MAX_STAMINA
            local isExhausted = false
            local exhaustedTimer = 0
            task.spawn(function()
                while character.Parent and humanoid.Health > 0 and staminaEnabled do
                    task.wait(STAMINA_CHANGE_INTERVAL)
                    local state, speed = getMovementState(character)
                    local isRunning = (state == "Running")
                    if isRunning then
                        stamina -= STAMINA_LOSS_PER_TICK
                        if stamina <= 0 then
                            stamina = 0
                            isExhausted = true
                            exhaustedTimer = EXHAUSTED_COOLDOWN
                        end
                    else
                        if isExhausted then
                            exhaustedTimer -= STAMINA_CHANGE_INTERVAL
                            if exhaustedTimer <= 0 then
                                exhaustedTimer = 0
                                isExhausted = false
                            end
                        else
                            stamina += STAMINA_GAIN_PER_TICK
                        end
                    end
                    stamina = math.clamp(stamina, 0, MAX_STAMINA)
                    if not textLabel.Parent then break end
                    local stateIcon = "..."
                    if isExhausted then
                        stateIcon = "EXHAUSTED"
                    elseif state == "Running" then
                        stateIcon = "Running"
                    elseif state == "Standing" then
                        stateIcon = "Standing"
                    elseif state == "Walking" then
                        stateIcon = "Walking"
                    end
                    local cooldownText = ""
                    if isExhausted and exhaustedTimer > 0 then
                        cooldownText = string.format(" [%.1fs]", exhaustedTimer)
                    end
                    textLabel.Text = string.format("[%d/%d] %s %.1f%s",
                        math.floor(stamina),
                        MAX_STAMINA,
                        stateIcon,
                        speed,
                        cooldownText
                    )
                    if isExhausted then
                        local blink = math.sin(tick() * 10) > 0
                        if blink then
                            textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                        else
                            textLabel.TextColor3 = Color3.fromRGB(150, 0, 0)
                        end
                    else
                        local staminaPercent = stamina / MAX_STAMINA
                        if staminaPercent > 0.63 then
                            textLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
                        elseif staminaPercent > 0.27 then
                            textLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
                        else
                            textLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                        end
                    end
                end
                character:SetAttribute("StaminaActive", nil)
                if textLabel and textLabel.Parent and textLabel.Parent.Parent then
                    textLabel.Parent:Destroy()
                end
                speedTrackingData[character] = nil
            end)
        end

        local function setupPlayer(player)
            local function onCharacterAdded(character)
                task.spawn(function()
                    task.wait(0.5)
                    if not staminaEnabled then return end
                    if player == LocalPlayer then
                        handleLocalPlayer(character)
                    else
                        handleOtherPlayer(character)
                    end
                end)
            end
            local conn = player.CharacterAdded:Connect(onCharacterAdded)
            table.insert(staminaConnections, conn)
            if player.Character then
                onCharacterAdded(player.Character)
            end
        end

        local playerAddedConn = Players.PlayerAdded:Connect(setupPlayer)
        table.insert(staminaConnections, playerAddedConn)

        for _, plr in pairs(Players:GetPlayers()) do
            setupPlayer(plr)
        end
    end
})

staminaSection:Slider({
    Flag = "BillboardSizeSlider",
    Title = "ui显示大小",
    Step = 0.5,
    Value = {Min = 1, Max = 10, Default = 4},
    Suffix = " studs",
    Callback = function(value)
        billboardSize = value

        local Players = game:GetService("Players")
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local billboard = player.Character:FindFirstChild("StaminaBillboard")
                if billboard then
                    billboard.Size = UDim2.new(value, 0, value / 4, 0)
                end
            end
        end
    end
})


end


do

    do

    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local PathfindingService = game:GetService("PathfindingService")
    local Camera = workspace.CurrentCamera
    local LocalPlayer = Players.LocalPlayer

    local espModes = {"Highlight", "Billboard"}
    local showRole, showUsername, showCharacterName, showPlayerHP = true, false, true, true
    local refreshRate = 0.5
    local minimalistESP = false

    local espSettings = {
        SnapCornersSize = 10,
        SnapCornersThickness = 2,
        TracersWidth = 1,
        BillboardSize = 10,
        BillboardOffset = 2.5,
        HighlightFillTransparency = 0.7,
        HighlightOutlineTransparency = 0,
        ArrowSize = 10,
        ArrowTextSize = 12
    }

    local espColors = {
        Killer = Color3.fromRGB(255, 0, 0),
        Survivor = Color3.fromRGB(0, 255, 0),
        Medkit = Color3.fromRGB(255, 105, 180),
        BloxyCola = Color3.fromRGB(0, 150, 255),
        Generator = Color3.fromRGB(255, 255, 255),
        Sentry = Color3.fromRGB(255, 165, 0),
        Graffiti = Color3.fromRGB(128, 0, 128),
        JohnDoe = Color3.fromRGB(0, 255, 255),
        Ritual = Color3.fromRGB(150, 0, 0),
        Minion1x1 = Color3.fromRGB(139, 0, 0),
        FakeGenerator = Color3.fromRGB(128, 128, 128),
        FakeNoli = Color3.fromRGB(255, 0, 255),
        CoolKidMinion = Color3.fromRGB(255, 192, 203),
        Trapwire = Color3.fromRGB(255, 140, 0),
        SubspaceTripmine = Color3.fromRGB(0, 255, 127),
        Documents = Color3.fromRGB(255, 220, 50),
        Ring = Color3.fromRGB(255, 215, 0),
        LinniScriptUser = Color3.fromRGB(170, 0, 255),
    }

    local function isValidObject(obj)
        if not obj then return false end
        local s, r = pcall(function() return obj.Parent and obj:IsDescendantOf(workspace) end)
        return s and r
    end

    local function isAlive(m)
        if not isValidObject(m) then return false end
        local h = m:FindFirstChildOfClass("Humanoid")
        return h and h.Health > 0
    end

    local function getPlayerFromCharacter(c)
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character == c then return p end
        end
    end

    local isPlayerCharacter = function(m) return getPlayerFromCharacter(m) ~= nil end

    local function getHealth(m)
        local h = m:FindFirstChildOfClass("Humanoid")
        return h and math.floor(h.Health) or nil, h and math.floor(h.MaxHealth) or nil
    end

    local function formatPlayerText(m, r)
        local p = getPlayerFromCharacter(m)
        local t = {}
        if showRole then t[#t+1] = r end
        if showCharacterName then t[#t+1] = m.Name end
        if showUsername and p then t[#t+1] = "(" .. p.Name .. ")" end
        if showPlayerHP then
            local hp, mh = getHealth(m)
            if hp then t[#t+1] = hp .. "/" .. mh end
        end
        return table.concat(t, " ")
    end

    local function createSnapCorners()
        local c = {}
        local names = {"TL1", "TL2", "TR1", "TR2", "BL1", "BL2", "BR1", "BR2"}
        for i = 1, 8 do
            local l = Drawing.new("Line")
            l.Thickness = tonumber(espSettings.SnapCornersThickness) or 2
            l.Transparency = 1
            l.Visible = false
            c[names[i]] = l
        end
        return c
    end

    local function updateSnapCorners(c, p, s, col, v)
        if not v then
            for _, l in pairs(c) do l.Visible = false end
            return
        end
        local sp, o = Camera:WorldToViewportPoint(p)
        if not o then
            for _, l in pairs(c) do l.Visible = false end
            return
        end
        local f = 1000 / math.max((Camera.CFrame.Position - p).Magnitude, 1)
        local w, h = math.clamp(s.X * f, 20, 200), math.clamp(s.Y * f, 20, 200)
        local cLen = tonumber(espSettings.SnapCornersSize) or 10
        local hw, hh = w/2, h/2
        local corners = {
            TL = Vector2.new(sp.X - hw, sp.Y - hh),
            TR = Vector2.new(sp.X + hw, sp.Y - hh),
            BL = Vector2.new(sp.X - hw, sp.Y + hh),
            BR = Vector2.new(sp.X + hw, sp.Y + hh)
        }
        c.TL1.From, c.TL1.To = corners.TL, Vector2.new(corners.TL.X + cLen, corners.TL.Y)
        c.TL2.From, c.TL2.To = corners.TL, Vector2.new(corners.TL.X, corners.TL.Y + cLen)
        c.TR1.From, c.TR1.To = corners.TR, Vector2.new(corners.TR.X - cLen, corners.TR.Y)
        c.TR2.From, c.TR2.To = corners.TR, Vector2.new(corners.TR.X, corners.TR.Y + cLen)
        c.BL1.From, c.BL1.To = corners.BL, Vector2.new(corners.BL.X + cLen, corners.BL.Y)
        c.BL2.From, c.BL2.To = corners.BL, Vector2.new(corners.BL.X, corners.BL.Y - cLen)
        c.BR1.From, c.BR1.To = corners.BR, Vector2.new(corners.BR.X - cLen, corners.BR.Y)
        c.BR2.From, c.BR2.To = corners.BR, Vector2.new(corners.BR.X, corners.BR.Y - cLen)
        local thickness = tonumber(espSettings.SnapCornersThickness) or 2
        for _, l in pairs(c) do
            l.Color = col
            l.Thickness = thickness
            l.Visible = true
        end
    end

    local function createArrow()
        local a = {}
        for i = 1, 3 do
            a["L"..i] = Drawing.new("Line")
            a["L"..i].Thickness = 2
        end
        a.Txt = Drawing.new("Text")
        a.Txt.Size = tonumber(espSettings.ArrowTextSize) or 12
        a.Txt.Center = true
        a.Txt.Outline = true
        a.Txt.Font = 2
        return a
    end

    local function updateArrow(a, p, col, t, v)
        if not v then
            for i = 1, 3 do a["L"..i].Visible = false end
            a.Txt.Visible = false
            return
        end
        local sp, o = Camera:WorldToViewportPoint(p)
        if o and sp.Z > 0 then
            for i = 1, 3 do a["L"..i].Visible = false end
            a.Txt.Visible = false
            return
        end
        local vs = Camera.ViewportSize
        local c = Vector2.new(vs.X / 2, vs.Y / 2)
        local d = (Vector2.new(sp.X, sp.Y) - c).Unit
        if sp.Z < 0 then d = -d end
        local m, ap = 50, nil
        if math.abs(d.X) > math.abs(d.Y) then
            local x = d.X > 0 and vs.X - m or m
            ap = Vector2.new(x, math.clamp(c.Y + d.Y * ((x - c.X) / d.X), m, vs.Y - m))
        else
            local y = d.Y > 0 and vs.Y - m or m
            ap = Vector2.new(math.clamp(c.X + d.X * ((y - c.Y) / d.Y), m, vs.X - m), y)
        end
        local as = tonumber(espSettings.ArrowSize) or 10
        local angle = math.atan2(d.Y, d.X)
        local cos_a, sin_a = math.cos(angle), math.sin(angle)
        local cos_a2, sin_a2 = math.cos(angle + math.pi/2), math.sin(angle + math.pi/2)
        local b1 = Vector2.new(ap.X - as*cos_a + as/2*cos_a2, ap.Y - as*sin_a + as/2*sin_a2)
        local b2 = Vector2.new(ap.X - as*cos_a - as/2*cos_a2, ap.Y - as*sin_a - as/2*sin_a2)
        a.L1.From, a.L1.To = ap, b1
        a.L2.From, a.L2.To = ap, b2
        a.L3.From, a.L3.To = b1, b2
        for i = 1, 3 do
            a["L"..i].Color = col
            a["L"..i].Visible = true
        end
        a.Txt.Position = Vector2.new(ap.X, ap.Y - 18)
        a.Txt.Text = t
        a.Txt.Color = col
        a.Txt.Size = tonumber(espSettings.ArrowTextSize) or 12
        a.Txt.Visible = true
    end

    local function createDot()
        local d = Drawing.new("Circle")
        d.Radius = 4
        d.Thickness = 1
        d.Filled = true
        d.Visible = false
        return d
    end

    local function updateDot(dot, pos, col, visible)
        if not dot then return end
        if not visible then dot.Visible = false; return end
        local sp, on = Camera:WorldToViewportPoint(pos)
        if on and sp.Z > 0 then
            dot.Position = Vector2.new(sp.X, sp.Y)
            dot.Color = col
            dot.Visible = true
        else
            dot.Visible = false
        end
    end

    local function createBillboard(p, t, col)
        local bb = Instance.new("BillboardGui")
        bb.Name, bb.Adornee, bb.AlwaysOnTop = "ESP", p, true
        bb.Size = UDim2.new(0, 100, 0, 20)
        bb.StudsOffset = Vector3.new(0, tonumber(espSettings.BillboardOffset) or 2.5, 0)
        bb.Parent = p
        local lbl = Instance.new("TextLabel", bb)
        lbl.Name, lbl.Size, lbl.BackgroundTransparency = "T", UDim2.new(1, 0, 1, 0), 1
        lbl.Text, lbl.TextColor3, lbl.TextStrokeTransparency = t, col, 0.5
        lbl.Font, lbl.TextSize, lbl.TextScaled = Enum.Font.GothamBold, tonumber(espSettings.BillboardSize) or 10, false
        return bb
    end

    local function updateBillboard(bb, t, col)
        if not bb or not bb.Parent then return end
        local lbl = bb:FindFirstChild("T")
        if lbl then
            lbl.Text = t
            lbl.TextColor3 = col
            lbl.TextSize = tonumber(espSettings.BillboardSize) or 10
        end
        bb.StudsOffset = Vector3.new(0, tonumber(espSettings.BillboardOffset) or 2.5, 0)
    end

    local function safeRemove(obj, method)
        if obj then pcall(function() obj[method](obj) end) end
    end

    local function cleanupData(d)
        safeRemove(d.highlight, "Destroy")
        safeRemove(d.line, "Remove")
        safeRemove(d.billboard, "Destroy")
        safeRemove(d.conn, "Disconnect")
        safeRemove(d.dot, "Remove")
        if d.corners then for _, l in pairs(d.corners) do safeRemove(l, "Remove") end end
        if d.arrow then
            for i = 1, 3 do safeRemove(d.arrow["L"..i], "Remove") end
            safeRemove(d.arrow.Txt, "Remove")
        end
    end

    local ESPRegistry = {}
    local ESPActive = {}
    local ESPData = {}

    local function registerESP(config)
        ESPRegistry[config.name] = config
        ESPActive[config.name] = false
        ESPData[config.name] = {}
    end

    local function createESPFor(typeName, obj, part, adornee, displayName, getText)
        local data = ESPData[typeName]
        if data[obj] or not isValidObject(obj) then return end

        local config = ESPRegistry[typeName]
        local c = espColors[config.colorKey]
        data[obj] = {part = part, adornee = adornee or obj, displayName = displayName}

        data[obj].conn = obj.AncestryChanged:Connect(function(_, p)
            if not p and data[obj] then cleanupData(data[obj]); data[obj] = nil end
        end)

        for _, mode in ipairs(espModes) do
            if mode == "Highlight" then
                local h = Instance.new("Highlight")
                h.Adornee, h.FillColor, h.OutlineColor = data[obj].adornee, c, c
                h.FillTransparency = tonumber(espSettings.HighlightFillTransparency) or 0.7
                h.OutlineTransparency = tonumber(espSettings.HighlightOutlineTransparency) or 0
                h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                h.Parent = data[obj].adornee
                data[obj].highlight = h
            elseif mode == "Tracers" then
                local l = Drawing.new("Line")
                l.Color, l.Thickness, l.Transparency = c, tonumber(espSettings.TracersWidth) or 1, 1
                data[obj].line = l
            elseif mode == "Snap Corners" then
                data[obj].corners = createSnapCorners()
            elseif mode == "Arrows" then
                data[obj].arrow = createArrow()
            elseif mode == "Billboard" and part then
                local txt = getText and getText(obj) or displayName
                data[obj].billboard = createBillboard(part, txt, c)
            end
        end
        data[obj].dot = createDot()
        if config.getText then data[obj].getText = config.getText end
    end

    local function clearESP(typeName)
        for obj, d in pairs(ESPData[typeName]) do cleanupData(d) end
        ESPData[typeName] = {}
    end

    local function updateESPRender(typeName)
        if not ESPActive[typeName] then return end
        local config = ESPRegistry[typeName]
        local data = ESPData[typeName]
        local c = espColors[config.colorKey]
        local vs = Camera.ViewportSize
        local screenBottom = Vector2.new(vs.X/2, vs.Y)

        for obj, d in pairs(data) do
            if not isValidObject(obj) or (d.part and not isValidObject(d.part)) then
                cleanupData(d); data[obj] = nil
            elseif d.part then
                local pos = d.part.Position
                local alive = not config.checkAlive or isAlive(obj)

                if not alive then
                    cleanupData(d); data[obj] = nil
                else
                    local sp, on = Camera:WorldToViewportPoint(pos)

                    if minimalistESP then
                        if d.line then d.line.Visible = false end
                        if d.corners then for _, l in pairs(d.corners) do l.Visible = false end end
                        if d.arrow then for i = 1, 3 do d.arrow["L"..i].Visible = false end; d.arrow.Txt.Visible = false end
                        if d.billboard then d.billboard.Enabled = false end
                        if d.highlight then d.highlight.Enabled = false end
                        updateDot(d.dot, pos, c, true)
                    else
                        if d.dot then d.dot.Visible = false end

                        if d.line then
                            d.line.Thickness = tonumber(espSettings.TracersWidth) or 1
                            if on then
                                d.line.From, d.line.To = screenBottom, Vector2.new(sp.X, sp.Y)
                                d.line.Color, d.line.Visible = c, true
                            else d.line.Visible = false end
                        end

                        if d.corners then
                            local sz = obj:IsA("Model") and obj:GetExtentsSize() or d.part.Size
                            updateSnapCorners(d.corners, pos, sz or Vector3.new(4,6,4), c, on)
                        end

                        if d.arrow then
                            updateArrow(d.arrow, pos, c, config.arrowText or d.displayName, true)
                        end

                        if d.billboard then
                            d.billboard.Enabled = true
                            local txt = d.getText and d.getText(obj) or d.displayName
                            updateBillboard(d.billboard, txt, c)
                        end

                        if d.highlight then
                            d.highlight.Enabled = true
                            d.highlight.FillTransparency = tonumber(espSettings.HighlightFillTransparency) or 0.7
                            d.highlight.OutlineTransparency = tonumber(espSettings.HighlightOutlineTransparency) or 0
                        end
                    end
                end
            end
        end
    end

    local function getKillersFolder() return workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers") end
    local function getSurvivorsFolder() return workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors") end
    local function getIngame() return workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") end

    local espConfigs = {
        {name = "Killer", colorKey = "Killer", checkAlive = true, arrowText = "Killer",
            getText = function(m) return formatPlayerText(m, "Killer") end,
            getTargets = function()
                local t = {}
                local kf = getKillersFolder()
                if kf then
                    for _, k in ipairs(kf:GetChildren()) do
                        if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") and isPlayerCharacter(k) and k ~= LocalPlayer.Character then
                            t[#t+1] = {obj = k, part = k.HumanoidRootPart, name = "Killer"}
                        end
                    end
                end
                return t
            end},
        {name = "Survivor", colorKey = "Survivor", checkAlive = true, arrowText = "Survivor",
            getText = function(m) return formatPlayerText(m, "Survivor") end,
            getTargets = function()
                local t = {}
                local sf = getSurvivorsFolder()
                if sf then
                    for _, s in ipairs(sf:GetChildren()) do
                        if s:IsA("Model") and s:FindFirstChild("HumanoidRootPart") and s ~= LocalPlayer.Character then
                            t[#t+1] = {obj = s, part = s.HumanoidRootPart, name = "Survivor"}
                        end
                    end
                end
                return t
            end},
        {name = "FakeNoli", colorKey = "FakeNoli", arrowText = "Fake Killer",
            getTargets = function()
                local t = {}
                local kf = getKillersFolder()
                if kf then
                    for _, k in ipairs(kf:GetChildren()) do
                        if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") and not isPlayerCharacter(k) then
                            t[#t+1] = {obj = k, part = k.HumanoidRootPart, name = "Fake Killer"}
                        end
                    end
                end
                return t
            end},
        {name = "Minion1x1", colorKey = "Minion1x1", arrowText = "1x1 Minion",
            getTargets = function()
                local t = {}
                local kf = getKillersFolder()
                if kf then
                    for _, k in ipairs(kf:GetChildren()) do
                        if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") and not isPlayerCharacter(k) then
                            t[#t+1] = {obj = k, part = k.HumanoidRootPart, name = "1x1 Minion"}
                        end
                    end
                end
                return t
            end},
        {name = "CoolKidMinion", colorKey = "CoolKidMinion", arrowText = "Coolkid Minion",
            getTargets = function()
                local t = {}
                local kf = getKillersFolder()
                if kf then
                    for _, k in ipairs(kf:GetChildren()) do
                        if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") and not isPlayerCharacter(k) then
                            t[#t+1] = {obj = k, part = k.HumanoidRootPart, name = "Coolkid Minion"}
                        end
                    end
                end
                return t
            end},
        {name = "Medkit", colorKey = "Medkit", arrowText = "Medkit",
            getTargets = function()
                local t = {}
                for _, item in ipairs(workspace:GetDescendants()) do
                    if item.Name == "Medkit" and isValidObject(item) then
                        if item:IsA("Model") then
                            local root = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
                            if root then t[#t+1] = {obj = item, part = root, name = "Medkit"} end
                        elseif item:IsA("BasePart") then
                            t[#t+1] = {obj = item, part = item, name = "Medkit"}
                        end
                    end
                end
                return t
            end},
        {name = "BloxyCola", colorKey = "BloxyCola", arrowText = "Bloxy Cola",
            getTargets = function()
                local t = {}
                for _, item in ipairs(workspace:GetDescendants()) do
                    if item.Name == "BloxyCola" and isValidObject(item) then
                        if item:IsA("Model") then
                            local root = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
                            if root then t[#t+1] = {obj = item, part = root, name = "Bloxy Cola"} end
                        elseif item:IsA("BasePart") then
                            t[#t+1] = {obj = item, part = item, name = "Bloxy Cola"}
                        end
                    end
                end
                return t
            end},
        {name = "Generator", colorKey = "Generator", arrowText = "Generator",
            getTargets = function()
                local t = {}
                for _, gen in ipairs(workspace:GetDescendants()) do
                    if gen.Name == "Generator" and isValidObject(gen) then
                        local part = gen:IsA("Model") and (gen.PrimaryPart or gen:FindFirstChildWhichIsA("BasePart"))
                                  or gen:IsA("BasePart") and gen
                        if part then t[#t+1] = {obj = gen, part = part, name = "Generator"} end
                    end
                end
                return t
            end},
        {name = "FakeGenerator", colorKey = "FakeGenerator", arrowText = "Fake Gen",
            getTargets = function()
                local t = {}
                for _, item in ipairs(workspace:GetDescendants()) do
                    if item.Name == "FakeGenerator" then
                        local part = item:IsA("Model") and item.PrimaryPart or item:IsA("BasePart") and item
                        if part then t[#t+1] = {obj = item, part = part, name = "Fake Generator"} end
                    end
                end
                return t
            end},
        {name = "Sentry", colorKey = "Sentry",
            getTargets = function()
                local t = {}
                local ig = getIngame()
                if ig then
                    for _, obj in ipairs(ig:GetChildren()) do
                        if obj:IsA("Model") and (obj.Name == "BuildermanSentry" or obj.Name == "BuildermanDispenser") and obj.PrimaryPart then
                            local dn = obj.Name == "BuildermanSentry" and "Sentry" or "Dispenser"
                            t[#t+1] = {obj = obj, part = obj.PrimaryPart, name = dn}
                        end
                    end
                end
                return t
            end},
        {name = "Graffiti", colorKey = "Graffiti", arrowText = "Graffiti",
            getTargets = function()
                local t = {}
                local ig = getIngame()
                if ig then
                    for _, spray in ipairs(ig:GetChildren()) do
                        local hb = spray:FindFirstChild("Hitbox")
                        if hb and hb:IsA("BasePart") and isValidObject(hb) then
                            t[#t+1] = {obj = hb, part = hb, name = "Graffiti"}
                        end
                    end
                end
                return t
            end},
        {name = "JohnDoe", colorKey = "JohnDoe", arrowText = "Footprint",
            getTargets = function()
                local t = {}
                local ig = getIngame()
                if ig then
                    for _, obj in ipairs(ig:GetChildren()) do
                        local sh = obj:FindFirstChild("Shadow")
                        if sh and sh:IsA("BasePart") and isValidObject(sh) then
                            t[#t+1] = {obj = sh, part = sh, name = "Footprint"}
                        end
                    end
                end
                return t
            end},
        {name = "Ritual", colorKey = "Ritual", arrowText = "Ritual",
            getTargets = function()
                local t = {}
                local ig = getIngame()
                if ig then
                    for _, child in ipairs(ig:GetChildren()) do
                        if (child.Name:find("Respawn") or child.Name:find("respawn")) and child:FindFirstChild("EnabledFloor") and child:IsA("BasePart") then
                            t[#t+1] = {obj = child, part = child, name = "Ritual"}
                        end
                    end
                end
                return t
            end},
        {name = "Trapwire", colorKey = "Trapwire", arrowText = "Trapwire",
            getTargets = function()
                local t = {}
                local ig = getIngame()
                if ig then
                    for _, obj in ipairs(ig:GetDescendants()) do
                        if obj.Name:find("TaphTripwire") and obj:IsA("Model") then
                            local wire = obj:FindFirstChild("Wire")
                            if wire and wire:IsA("BasePart") then
                                t[#t+1] = {obj = obj, part = wire, adornee = wire, name = "Trapwire"}
                            end
                        end
                    end
                end
                return t
            end},
        {name = "SubspaceTripmine", colorKey = "SubspaceTripmine", arrowText = "Tripmine",
            getTargets = function()
                local t = {}
                local ig = getIngame()
                if ig then
                    for _, obj in ipairs(ig:GetDescendants()) do
                        if obj.Name == "SubspaceTripmine" and obj:IsA("Model") then
                            local box = obj:FindFirstChild("SubspaceBox")
                            if box and box:IsA("BasePart") then
                                t[#t+1] = {obj = obj, part = box, adornee = box, name = "Subspace Tripmine"}
                            end
                        end
                    end
                end
                return t
            end},
        {name = "Documents", colorKey = "Documents", arrowText = "Document",
            getTargets = function()
                local t = {}
                local ig = getIngame()
                local detail = ig and ig:FindFirstChild("Map") and ig.Map:FindFirstChild("Detail")
                if detail then
                    for _, item in ipairs(detail:GetDescendants()) do
                        if item.Name == "Part" and item:IsA("BasePart") and isValidObject(item)
                            and math.abs(item.Size.X - 9) < 0.5
                            and math.abs(item.Size.Y - 33) < 0.5
                            and math.abs(item.Size.Z - 8) < 0.5 then
                            t[#t+1] = {obj = item, part = item, name = "Document"}
                        end
                    end
                end
                return t
            end},
        {name = "Ring", colorKey = "Ring", arrowText = "Ring",
            getTargets = function()
                local t = {}
                local ig = getIngame()
                local detail = ig and ig:FindFirstChild("Map") and ig.Map:FindFirstChild("Detail")
                if detail then
                    for _, item in ipairs(detail:GetDescendants()) do
                        if (item.Name == "Ring" or item.Name == "Rings") and item:IsA("BasePart") and isValidObject(item) then
                            t[#t+1] = {obj = item, part = item, name = item.Name}
                        end
                    end
                end
                return t
            end}
    }

    for _, cfg in ipairs(espConfigs) do registerESP(cfg) end

    local function updateESPList(typeName)
        clearESP(typeName)
        local config = ESPRegistry[typeName]
        for _, target in ipairs(config.getTargets()) do
            createESPFor(typeName, target.obj, target.part, target.adornee, target.name, config.getText)
        end
    end

    RunService.RenderStepped:Connect(function()
        for typeName in pairs(ESPRegistry) do
            updateESPRender(typeName)
        end
    end)

    local pathVisualizerEnabled = false
    local pathCharacter, pathRootPart, currentKiller

    local function findKiller()
        local kf = getKillersFolder()
        if kf then
            for _, c in ipairs(kf:GetChildren()) do
                if c:IsA("Model") and c:FindFirstChild("Humanoid") then
                    currentKiller = c; return
                end
            end
        end
        currentKiller = nil
    end

    local function visualizePath(w)
        local f = workspace:FindFirstChild("PathVisualization") or Instance.new("Folder", workspace)
        f.Name = "PathVisualization"
        f:ClearAllChildren()
        for i = 1, #w - 1 do
            local s, e = w[i].Position, w[i+1].Position
            local d = (s - e).Magnitude
            local p = Instance.new("Part", f)
            p.Anchored, p.CanCollide, p.Transparency = true, false, 0.5
            p.CFrame = CFrame.new(s, e) * CFrame.new(0, 0, -d / 2)
            p.Size = Vector3.new(0.3, 0.3, d)
            p.Color = Color3.fromRGB(138, 43, 226)
        end
    end

    local function updatePath()
        if not pathVisualizerEnabled then
            local f = workspace:FindFirstChild("PathVisualization")
            if f then f:ClearAllChildren() end
            return
        end
        findKiller()
        local kr = currentKiller and (currentKiller:FindFirstChild("HumanoidRootPart") or currentKiller.PrimaryPart)
        if not kr or not pathRootPart then return end
        local path = PathfindingService:CreatePath({AgentRadius = 3, AgentHeight = 6, AgentCanJump = true})
        if pcall(function() path:ComputeAsync(kr.Position, pathRootPart.Position) end) and path.Status == Enum.PathStatus.Success then
            visualizePath(path:GetWaypoints())
        end
    end

    if LocalPlayer.Character then
        pathCharacter = LocalPlayer.Character
        pathRootPart = pathCharacter:WaitForChild("HumanoidRootPart")
    end
    LocalPlayer.CharacterAdded:Connect(function(nc)
        pathCharacter = nc
        pathRootPart = nc:WaitForChild("HumanoidRootPart")
    end)

    local function refreshAllActiveESP()
        for typeName in pairs(ESPRegistry) do
            if ESPActive[typeName] then updateESPList(typeName) end
        end
    end

    task.spawn(function() while true do task.wait(1); updatePath() end end)
    task.spawn(function() while true do task.wait(refreshRate); refreshAllActiveESP() end end)

    workspace.DescendantAdded:Connect(function(inst)
        pcall(function()
            if inst.Name == "Medkit" and ESPActive["Medkit"] and isValidObject(inst) then
                local root = inst:IsA("Model") and (inst.PrimaryPart or inst:FindFirstChildWhichIsA("BasePart"))
                          or inst:IsA("BasePart") and inst
                if root then createESPFor("Medkit", inst, root, inst, "Medkit", ESPRegistry["Medkit"] and ESPRegistry["Medkit"].getText) end
            elseif inst.Name == "BloxyCola" and ESPActive["BloxyCola"] and isValidObject(inst) then
                local root = inst:IsA("Model") and (inst.PrimaryPart or inst:FindFirstChildWhichIsA("BasePart"))
                          or inst:IsA("BasePart") and inst
                if root then createESPFor("BloxyCola", inst, root, inst, "Bloxy Cola", ESPRegistry["BloxyCola"] and ESPRegistry["BloxyCola"].getText) end
            elseif inst.Name == "Generator" and ESPActive["Generator"] and isValidObject(inst) then
                local root = inst:IsA("Model") and (inst.PrimaryPart or inst:FindFirstChildWhichIsA("BasePart"))
                          or inst:IsA("BasePart") and inst
                if root then createESPFor("Generator", inst, root, inst, "Generator", ESPRegistry["Generator"] and ESPRegistry["Generator"].getText) end
            end
        end)
    end)

    local playersFolder = workspace:FindFirstChild("Players")
    if playersFolder then
        local function onKillerChange()
            for _, n in ipairs({"Killer", "FakeNoli", "Minion1x1", "CoolKidMinion"}) do
                if ESPActive[n] then updateESPList(n) end
            end
        end
        local kf = playersFolder:FindFirstChild("Killers")
        if kf then kf.ChildAdded:Connect(onKillerChange); kf.ChildRemoved:Connect(onKillerChange) end
        local sf = playersFolder:FindFirstChild("Survivors")
        if sf then
            sf.ChildAdded:Connect(function() if ESPActive.Survivor then updateESPList("Survivor") end end)
            sf.ChildRemoved:Connect(function() if ESPActive.Survivor then updateESPList("Survivor") end end)
        end
    end

    local ESPSettingsSection = Tabs.Esp:Section({Title = "ESP设置", Icon = "eye", Opened = false})

    ESPSettingsSection:Dropdown({Flag = "ESPMode", Title = "选择模式[ESP]", Values = {"Highlight", "Tracers", "Snap Corners", "Arrows", "Billboard"}, Multi = true, Default = {"Highlight", "Billboard"}, Callback = function(v) espModes = v; refreshAllActiveESP() end})
    ESPSettingsSection:Slider({Flag = "ESPRefreshRate", Title = "ESP刷新率", Step = 0.1, Value = {Min = 0.1, Max = 10, Default = 0.5}, Callback = function(v) refreshRate = v end})
    ESPSettingsSection:Slider({Flag = "BillboardTextSize", Title = "文本显示大小", Step = 1, Value = {Min = 1, Max = 18, Default = 10}, Callback = function(v) espSettings.BillboardSize = v end})
    ESPSettingsSection:Slider({Flag = "BillboardOffset", Title = "文本偏移度", Step = 0.5, Value = {Min = 0.1, Max = 5.0, Default = 2.5}, Callback = function(v) espSettings.BillboardOffset = v end})
    ESPSettingsSection:Slider({Flag = "HighlightFillTransparency", Title = "高光填充透明度", Step = 0.1, Value = {Min = 0.1, Max = 1.0, Default = 0.7}, Callback = function(v) espSettings.HighlightFillTransparency = v end})
    ESPSettingsSection:Slider({Flag = "HighlightOutlineTransparency", Title = "高亮轮廓透明度", Step = 0.1, Value = {Min = 0.1, Max = 1.0, Default = 0.1}, Callback = function(v) espSettings.HighlightOutlineTransparency = v end})
    ESPSettingsSection:Slider({Flag = "TracersWidth", Title = "天线宽度", Step = 1, Value = {Min = 1, Max = 5, Default = 1}, Callback = function(v) espSettings.TracersWidth = v end})
    ESPSettingsSection:Slider({Flag = "SnapCornersSize", Title = "边角大小", Step = 1, Value = {Min = 1, Max = 25, Default = 10}, Callback = function(v) espSettings.SnapCornersSize = v end})
    ESPSettingsSection:Slider({Flag = "SnapCornersThickness", Title = "边角粗细", Step = 1, Value = {Min = 1, Max = 5, Default = 2}, Callback = function(v) espSettings.SnapCornersThickness = v end})
    ESPSettingsSection:Slider({Flag = "ArrowSize", Title = "箭头大小", Step = 1, Value = {Min = 1, Max = 20, Default = 10}, Callback = function(v) espSettings.ArrowSize = v end})
    ESPSettingsSection:Slider({Flag = "ArrowTextSize", Title = "箭头文本大小", Step = 1, Value = {Min = 1, Max = 18, Default = 12}, Callback = function(v) espSettings.ArrowTextSize = v end})
    ESPSettingsSection:Toggle({Flag = "ShowRole", Title = "显示角色", Default = true, Callback = function(s) showRole = s end})
    ESPSettingsSection:Toggle({Flag = "ShowUsername", Title = "显示用户名", Default = false, Callback = function(s) showUsername = s end})
    ESPSettingsSection:Toggle({Flag = "ShowCharacterName", Title = "显示角色名字", Default = true, Callback = function(s) showCharacterName = s end})
    ESPSettingsSection:Toggle({Flag = "ShowHP", Title = "显示血量", Default = true, Callback = function(s) showPlayerHP = s end})
    ESPSettingsSection:Toggle({Flag = "MinimalistESP", Title = "开启极简ESP[手机卡就开]", Default = false, Callback = function(s) minimalistESP = s end})

    local colorConfigs = {
        {"ColorKiller", "Killer", espColors.Killer}, {"ColorSurvivor", "Survivor", espColors.Survivor},
        {"ColorFakeKiller", "FakeNoli", espColors.FakeNoli}, {"ColorMinion1x1", "Minion1x1", espColors.Minion1x1},
        {"ColorCoolKidMinion", "CoolKidMinion", espColors.CoolKidMinion}, {"ColorMedkit", "Medkit", espColors.Medkit},
        {"ColorBloxyCola", "BloxyCola", espColors.BloxyCola}, {"ColorGenerator", "Generator", espColors.Generator},
        {"ColorFakeGenerator", "FakeGenerator", espColors.FakeGenerator}, {"ColorSentry", "Sentry", espColors.Sentry},
        {"ColorGraffiti", "Graffiti", espColors.Graffiti},
        {"ColorJohnDoe", "JohnDoe", espColors.JohnDoe}, {"ColorRitual", "Ritual", espColors.Ritual},
        {"ColorTrapwire", "Trapwire", espColors.Trapwire}, {"ColorSubspaceTripmine", "SubspaceTripmine", espColors.SubspaceTripmine},
        {"ColorDocuments", "Documents", espColors.Documents}, {"ColorRing", "Ring", espColors.Ring}
    }
    for _, cfg in ipairs(colorConfigs) do
        ESPSettingsSection:Colorpicker({Flag = cfg[1], Title = cfg[2]:gsub("(%u)", " %1"):sub(2), Default = cfg[3], Callback = function(c) espColors[cfg[2]] = c end})
    end

    local function createToggle(section, flag, title, typeName)
        section:Toggle({Flag = flag, Title = title, Default = false, Callback = function(s)
            ESPActive[typeName] = s
            if s then updateESPList(typeName) else clearESP(typeName) end
        end})
    end

    local GeneralSection = Tabs.Esp:Section({Title = "身份ESP", Icon = "star", Opened = false})
    createToggle(GeneralSection, "ESPKiller", "屠夫ESP", "Killer")
    createToggle(GeneralSection, "ESPFakeKiller", "假屠夫ESP", "FakeNoli")
    createToggle(GeneralSection, "ESPMinion1x1", "1x1随从ESP", "Minion1x1")
    createToggle(GeneralSection, "ESPCoolKidMinion", "酷小孩随从ESP", "CoolKidMinion")
    createToggle(GeneralSection, "ESPSurvivors", "幸存者ESP", "Survivor")

    local ItemsSection = Tabs.Esp:Section({Title = "物品ESP", Icon = "shopping-cart",Opened = false})
    createToggle(ItemsSection, "ESPMedkit", "医疗包ESP", "Medkit")
    createToggle(ItemsSection, "ESPBloxyCola", "能量可乐ESP", "BloxyCola")

    local MiscSection = Tabs.Esp:Section({Title = "其他ESP", Icon = "gem",Opened = false})
    createToggle(MiscSection, "ESPGenerators", "发电机ESP", "Generator")
    createToggle(MiscSection, "ESPFakeGenerator", "假发电机ESP", "FakeGenerator")
    createToggle(MiscSection, "ESPSentry", "炮塔ESP", "Sentry")
    createToggle(MiscSection, "ESPGraffiti", "涂鸦ESP", "Graffiti")
    createToggle(MiscSection, "ESPJohnDoe", "无名杀手脚印ESP", "JohnDoe")
    createToggle(MiscSection, "ESPRitual", "仪式法阵ESP", "Ritual")
    createToggle(MiscSection, "ESPTrapwire", "陷阱绳索ESP", "Trapwire")
    createToggle(MiscSection, "ESPSubspaceTripmine", "空间地雷ESP", "SubspaceTripmine")
    MiscSection:Toggle({Flag = "PathVisualizer", Title = "路径可视化工具", Default = false, Callback = function(s)
        pathVisualizerEnabled = s
        if not s then local p = workspace:FindFirstChild("PathVisualization"); if p then p:ClearAllChildren() end end
    end})


    do
        local NSK_COLOR = Color3.fromRGB(170, 0, 255)
        local nsk_esp_active = false
        local nsk_esp_data = {}

        local function nsk_clear()
            for _, d in pairs(nsk_esp_data) do
                pcall(function() if d.highlight then d.highlight:Destroy() end end)
                pcall(function() if d.billboard then d.billboard:Destroy() end end)
            end
            nsk_esp_data = {}
        end

        local function nsk_update()
            if not nsk_esp_active then return end

            for p, d in pairs(nsk_esp_data) do
                if not p or not p.Parent or not p.Character or not p.Character:FindFirstChild("__NSK_TAG__") then
                    pcall(function() if d.highlight then d.highlight:Destroy() end end)
                    pcall(function() if d.billboard then d.billboard:Destroy() end end)
                    nsk_esp_data[p] = nil
                end
            end

            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("__NSK_TAG__") then
                    if not nsk_esp_data[p] then
                        local char = p.Character
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        local head = char:FindFirstChild("Head")
                        local entry = {}

                        local h = Instance.new("Highlight")
                        h.Name = "Linni_ESP"
                        h.Adornee = char
                        h.FillColor = NSK_COLOR
                        h.OutlineColor = NSK_COLOR
                        h.FillTransparency = 0.5
                        h.OutlineTransparency = 0
                        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        h.Parent = char
                        entry.highlight = h

                        if head then
                            local bb = Instance.new("BillboardGui")
                            bb.Name = "Linni_ESP_BB"
                            bb.Adornee = head
                            bb.AlwaysOnTop = true
                            bb.Size = UDim2.new(0, 140, 0, 20)
                            bb.StudsOffset = Vector3.new(0, 3.5, 0)
                            bb.Parent = head
                            local lbl = Instance.new("TextLabel", bb)
                            lbl.Size = UDim2.new(1, 0, 1, 0)
                            lbl.BackgroundTransparency = 1
                            lbl.Text = "[LinniScript] " .. p.Name
                            lbl.TextColor3 = NSK_COLOR
                            lbl.TextStrokeTransparency = 0.5
                            lbl.Font = Enum.Font.GothamBold
                            lbl.TextSize = 10
                            entry.billboard = bb
                        end
                        nsk_esp_data[p] = entry
                    end
                end
            end
        end

        local nsk_esp_section = Tabs.Esp:Section({
            Title = "透视同行",
            Icon = "radar",
            Opened = false,
        })

        nsk_esp_section:Toggle({
            Title = "霖溺脚本用户[透视]",
            Locked = (not getgenv().__Linni_PREMIUM),
            LockedTitle = "This element is locked (Buy Premium)",
            Default = false,
            Callback = function(v)
                nsk_esp_active = v
                if v then
                    nsk_update()
                    task.spawn(function()
                        while nsk_esp_active do
                            task.wait(5)
                            nsk_update()
                        end
                    end)
                else
                    nsk_clear()
                end
            end
        })
    end
end

end


local otherSection = Tabs.AutoBlock:Section({
    Title = "其他功能",
    Icon = "wrench",
    Opened = false,
})

do

local teleportEnabled = false
local teleportConnection = nil
local blockAnimations = {
    ["72182155407310"] = true,
    ["72722244508749"] = true,
    ["8028421882"] = true,
    ["95802026624883"] = true,
    ["94215314"] = true,
    ["1956271358"] = true,
    ["115706752305794"] = true,
    ["82605295530067"] = true,
    ["96959123077498"] = true,
    ["105905509045149"] = true,
    ["98105697395689"] = true,
    ["9089408772"] = true
}
local function isBlockAnimationPlaying()
    local character = LocalPlayer.Character
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
    if not animator then return false end
    for _, track in pairs(animator:GetPlayingAnimationTracks()) do
        local animId = string.match(tostring(track.Animation.AnimationId), "%d+")
        if animId and blockAnimations[animId] then
            return true
        end
    end
    return false
end

local function getNearestKiller()
    local character = LocalPlayer.Character
    if not (character and character:FindFirstChild("HumanoidRootPart")) then return nil end
    local myPos = character.HumanoidRootPart.Position
    local nearest, shortestDistance
    shortestDistance = math.huge
    local killersFolder = Workspace:FindFirstChild("Players")
    killersFolder = killersFolder and killersFolder:FindFirstChild("Killers")
    if killersFolder then
        for _, killer in pairs(killersFolder:GetChildren()) do
            if killer:IsA("Model") and killer:FindFirstChild("HumanoidRootPart") then
                local dist = (killer.HumanoidRootPart.Position - myPos).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    nearest = killer
                end
            end
        end
    end
    return nearest
end

local function teleportToKillers()
    if not teleportEnabled then return end
    if isBlockAnimationPlaying() then
        teleportEnabled = false
        if teleportConnection then
            teleportConnection:Disconnect()
            teleportConnection = nil
        end
        return
    end
    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    local killer = getNearestKiller()
    local killerHrp = killer and killer:FindFirstChild("HumanoidRootPart")
    if hrp and killerHrp then
        local direction = (hrp.Position - killerHrp.Position).Unit
        hrp.CFrame = CFrame.new(killerHrp.Position + direction * 1)
    end
end

_G.FreeBlockToggle = function()
    teleportEnabled = not teleportEnabled
    if teleportEnabled then
        teleportConnection = RunService.Heartbeat:Connect(teleportToKillers)
    elseif teleportConnection then
        teleportConnection:Disconnect()
        teleportConnection = nil
    end
end


otherSection:Button({
    Title = "自由格挡(搭配隐身和自动格挡[功能并非100%生效]",
    Callback = function()
        _G.FreeBlockToggle()
    end
})

local autoPunchEnabled = false
local lockDuration = 1.4
local lockMode = "CharterLock"
local punchMode = "Normal"

local aimConnection, punchConnection, animConnection, charAddedConnection
local crosshairGui = nil
local aimEndTime = 0

local cachedTarget = nil
local lastTargetSearch = 0
local TARGET_SEARCH_INTERVAL = 0.05

local lastVisualState = "none"
local currentTween = nil

local cachedPunchBtn = nil
local cachedCharges = nil
local lastUICheck = 0
local UI_CHECK_INTERVAL = 0.2

local targetHistory = {}
local PREDICTION_AMOUNT = 0.08

local punchAnims = {
    ["rbxassetid://122560631718612"] = true,
    ["rbxassetid://87259391926321"] = true,
    ["rbxassetid://129843313690921"] = true,
    ["rbxassetid://138040001965654"] = true,
    ["rbxassetid://73908019523515"] = true,
    ["rbxassetid://136007065400978"] = true,
    ["rbxassetid://83161312898155"] = true,
    ["rbxassetid://108911997126897"] = true
}

local function createCrosshair()
    if crosshairGui then return end
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PunchCrosshairGUI"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    local dot = Instance.new("Frame")
    dot.Name = "CenterDot"
    dot.Size = UDim2.new(0, 2, 0, 2)
    dot.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    dot.BackgroundTransparency = 0.8
    dot.BorderSizePixel = 0
    dot.AnchorPoint = Vector2.new(0.5, 0.5)
    dot.Position = UDim2.new(0.5, 0, 0.5, 0)
    dot.Parent = screenGui

    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local stroke = Instance.new("UIStroke")
    stroke.Name = "DotStroke"
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.8
    stroke.Parent = dot

    local ring = Instance.new("Frame")
    ring.Name = "AimRing"
    ring.Size = UDim2.new(0, 8, 0, 8)
    ring.AnchorPoint = Vector2.new(0.5, 0.5)
    ring.Position = UDim2.new(0.5, 0, 0.5, 0)
    ring.BackgroundTransparency = 1
    ring.Parent = screenGui

    Instance.new("UICorner", ring).CornerRadius = UDim.new(1, 0)

    local ringStroke = Instance.new("UIStroke")
    ringStroke.Name = "RingStroke"
    ringStroke.Color = Color3.fromRGB(255, 50, 50)
    ringStroke.Thickness = 1
    ringStroke.Transparency = 0.8
    ringStroke.Parent = ring

    crosshairGui = screenGui
end

local function destroyCrosshair()
    if crosshairGui then
        crosshairGui:Destroy()
        crosshairGui = nil
    end
end

local function updateCrosshairVisual(hasTarget, isLocking)
    if not crosshairGui then return end

    local newState = isLocking and "locking" or (hasTarget and "target" or "none")

    if newState == lastVisualState then return end
    lastVisualState = newState

    if currentTween then
        currentTween:Cancel()
    end

    local color
    if isLocking then
        color = Color3.fromRGB(0, 255, 100)
    elseif hasTarget then
        color = Color3.fromRGB(255, 200, 0)
    else
        color = Color3.fromRGB(255, 50, 50)
    end

    local dot = crosshairGui:FindFirstChild("CenterDot")
    local ring = crosshairGui:FindFirstChild("AimRing")

    if dot then
        local stroke = dot:FindFirstChild("DotStroke")
        if stroke then
            currentTween = TweenService:Create(stroke, TweenInfo.new(0.15), {Color = color})
            currentTween:Play()
        end
    end

    if ring then
        local ringStroke = ring:FindFirstChild("RingStroke")
        if ringStroke then
            TweenService:Create(ringStroke, TweenInfo.new(0.15), {Color = color}):Play()
        end
    end
end

local function findBestTarget()
    local now = tick()

    if now - lastTargetSearch < TARGET_SEARCH_INTERVAL and cachedTarget then
        if cachedTarget.Parent and cachedTarget:IsDescendantOf(Workspace) then
            return cachedTarget
        end
    end

    lastTargetSearch = now

    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myChar or not myRoot then
        cachedTarget = nil
        return nil
    end

    local bestTarget, minDistance = nil, 20
    local myPos = myRoot.Position

    local killersFolder = Workspace:FindFirstChild("Players")
    killersFolder = killersFolder and killersFolder:FindFirstChild("Killers")

    if killersFolder then
        for _, killer in ipairs(killersFolder:GetChildren()) do
            local root = killer:FindFirstChild("HumanoidRootPart")
            if root then
                local dist = (root.Position - myPos).Magnitude
                if dist < minDistance then
                    minDistance = dist
                    bestTarget = root
                end
            end
        end
    end

    cachedTarget = bestTarget
    return bestTarget
end

local function getPredictedPosition(targetRoot)
    if not targetRoot then return nil end

    local now = tick()
    local currentPos = targetRoot.Position

    table.insert(targetHistory, {pos = currentPos, time = now})

    while #targetHistory > 10 do
        table.remove(targetHistory, 1)
    end

    if #targetHistory >= 2 then
        local oldest = targetHistory[1]
        local newest = targetHistory[#targetHistory]
        local deltaTime = newest.time - oldest.time

        if deltaTime > 0.01 then
            local velocity = (newest.pos - oldest.pos) / deltaTime
            local predictedPos = currentPos + velocity * PREDICTION_AMOUNT
            return predictedPos
        end
    end

    return currentPos
end

local function applyLock(targetPosition)
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    local camera = Workspace.CurrentCamera

    if lockMode == "CharterLock" or lockMode == "CamLock+CharterLock" then
        local targetPosFlat = Vector3.new(targetPosition.X, myRoot.Position.Y, targetPosition.Z)
        local direction = (targetPosFlat - myRoot.Position)
        if direction.Magnitude > 0.01 then
            myRoot.CFrame = CFrame.new(myRoot.Position, myRoot.Position + direction.Unit)
        end
    end

    if lockMode == "CamLock" or lockMode == "CamLock+CharterLock" then
        local camPos = camera.CFrame.Position
        local direction = (targetPosition - camPos)
        if direction.Magnitude > 0.01 then
            camera.CFrame = CFrame.lookAt(camPos, camPos + direction.Unit)
        end
    end
end

local function startLockTimer()
    aimEndTime = tick() + lockDuration
end

local function isLockActive()
    return tick() < aimEndTime
end

local function setupAnimationDetection(char)
    if animConnection then animConnection:Disconnect() end

    local humanoid = char:WaitForChild("Humanoid", 5)
    if not humanoid then return end

    animConnection = humanoid.AnimationPlayed:Connect(function(track)
        if not autoPunchEnabled or punchMode ~= "After u punch" then return end
        if punchAnims[track.Animation.AnimationId] then
            targetHistory = {}
            startLockTimer()
        end
    end)
end

local function getCachedPunchUI()
    local now = tick()

    if now - lastUICheck < UI_CHECK_INTERVAL and cachedPunchBtn and cachedCharges then
        if cachedPunchBtn.Parent and cachedCharges.Parent then
            return cachedPunchBtn, cachedCharges
        end
    end

    lastUICheck = now

    local gui = LocalPlayer:FindFirstChild("PlayerGui")
    local mainUI = gui and gui:FindFirstChild("MainUI")
    local punchBtn = mainUI and mainUI:FindFirstChild("AbilityContainer")
        and mainUI.AbilityContainer:FindFirstChild("Punch")
    local charges = punchBtn and punchBtn:FindFirstChild("Charges")

    cachedPunchBtn = punchBtn
    cachedCharges = charges

    return punchBtn, charges
end

local function startAutoPunch()
    createCrosshair()

    if LocalPlayer.Character then
        setupAnimationDetection(LocalPlayer.Character)
    end

    if charAddedConnection then charAddedConnection:Disconnect() end
    charAddedConnection = LocalPlayer.CharacterAdded:Connect(function(char)
        task.wait(1)
        setupAnimationDetection(char)
        cachedTarget = nil
        cachedPunchBtn = nil
        cachedCharges = nil
        targetHistory = {}
    end)

    aimConnection = RunService.RenderStepped:Connect(function()
        if not autoPunchEnabled then return end

        local targetRoot = findBestTarget()
        local lockActive = isLockActive()

        updateCrosshairVisual(targetRoot ~= nil, lockActive)

        if not lockActive then return end

        if targetRoot then
            local predictedPos = getPredictedPosition(targetRoot)
            if predictedPos then
                applyLock(predictedPos)
            end
        end
    end)

    local lastPunchCheck = 0
    punchConnection = RunService.Heartbeat:Connect(function()
        if not autoPunchEnabled or punchMode ~= "Normal" then return end

        local now = tick()
        if now - lastPunchCheck < 0.05 then return end
        lastPunchCheck = now

        local punchBtn, charges = getCachedPunchUI()
        if not (punchBtn and charges) then return end

        if charges.Text == "1" then
            local target = findBestTarget()
            if target then
                targetHistory = {}
                startLockTimer()
                for _, conn in ipairs(getconnections(punchBtn.MouseButton1Click)) do
                    pcall(function() conn:Fire() end)
                end
            end
        end
    end)
end

local function stopAutoPunch()
    destroyCrosshair()

    if aimConnection then aimConnection:Disconnect(); aimConnection = nil end
    if punchConnection then punchConnection:Disconnect(); punchConnection = nil end
    if animConnection then animConnection:Disconnect(); animConnection = nil end
    if charAddedConnection then charAddedConnection:Disconnect(); charAddedConnection = nil end

    aimEndTime = 0
    lastVisualState = "none"
    cachedTarget = nil
    cachedPunchBtn = nil
    cachedCharges = nil
    targetHistory = {}

    if currentTween then
        currentTween:Cancel()
        currentTween = nil
    end
end

otherSection:Toggle({
    Flag = "AutoPunch",
    Title = "自动出拳",
    Default = false,
    Callback = function(state)
        autoPunchEnabled = state
        if state then
            startAutoPunch()
        else
            stopAutoPunch()
        end
    end
})

otherSection:Dropdown({
    Flag = "AutoPunchLockMode",
    Title = "自动出拳锁定模式",
    Values = {"CharterLock", "CamLock", "CamLock+CharterLock"},
    Multi = false,
    Default = "CharterLock",
    Callback = function(choice)
        lockMode = choice
    end
})

otherSection:Dropdown({
    Flag = "AutoPunchMode",
    Title = "自动出拳模式",
    Values = {"Normal", "After u punch"},
    Multi = false,
    Default = "Normal",
    Callback = function(choice)
        punchMode = choice
    end
})

otherSection:Slider({
    Flag = "PredictionAmount",
    Title = "预测强度",
    Step = 0.01,
    Value = { Min = 0, Max = 0.2, Default = PREDICTION_AMOUNT },
    Callback = function(val)
        PREDICTION_AMOUNT = tonumber(val) or 0.08
    end
})

otherSection:Slider({
    Flag = "LockDuration",
    Title = "锁定持续时间",
    Step = 0.1,
    Value = { Min = 0.5, Max = 3, Default = lockDuration },
    Suffix = "s",
    Callback = function(val)
        lockDuration = tonumber(val) or 1.4
    end
})

local SelectedAttacker = "Noli"
local MultiFrameEnabled = false

local AttackWindows = {
    ["Noli"] = {200, 350},
    ["c00lkid"] = {100, 100},
    ["John Doe"] = {300, 400},
    ["Jason/Slasher"] = {200, 350},
    ["Sixer"] = {150, 300},
    ["Nosferatu"] = {200, 400},
    ["1x1x1x1"] = {200, 400}
}

otherSection:Toggle({
    Flag = "MSChecker",
    Title = "延迟检测面板",
    Default = false,
    Callback = function(value)
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")
        if value then
            local screenGui = Instance.new("ScreenGui")
            screenGui.Name = "RealTimePingGui"
            screenGui.ResetOnSpawn = false
            screenGui.Parent = playerGui
            local label = Instance.new("TextLabel")
            label.Name = "InfoLabel"
            label.Size = UDim2.new(0, 49, 0, 24)
            label.Position = UDim2.new(0, 5, 0, 5)
            label.Text = ""
            label.RichText = true
            label.BackgroundTransparency = 0.2
            label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Font = Enum.Font.Code
            label.TextSize = 7
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextYAlignment = Enum.TextYAlignment.Center
            label.Parent = screenGui
            local padding = Instance.new("UIPadding")
            padding.PaddingLeft = UDim.new(0, 4)
            padding.Parent = label
            local function getPingMs()
                local ok, val = pcall(function()
                    return player:GetNetworkPing() * 1000
                end)
                if ok and type(val) == "number" then
                    return math.floor(val + 0.5)
                end
                return nil
            end
            local function calculateChance(ping)
                local window = AttackWindows[SelectedAttacker]
                if not window then return 0 end
                local minWindow = window[1]
                local maxWindow = window[2]
                local multiFrameDelay = MultiFrameEnabled and 0 or 5
                local totalDelay = ping + 5 + multiFrameDelay
                if totalDelay <= minWindow then
                    return 100
                elseif totalDelay >= maxWindow then
                    return 0
                else
                    return math.floor((maxWindow - totalDelay) / (maxWindow - minWindow) * 100)
                end
            end
            local function getRGB(r, g, b)
                return string.format("rgb(%d,%d,%d)", r, g, b)
            end
            local function getPingColor(ping)
                if ping <= 50 then
                    return getRGB(0, 255, 0)
                elseif ping <= 100 then
                    return getRGB(255, 255, 0)
                else
                    return getRGB(255, 0, 0)
                end
            end
            local function getChanceColor(chance)
                if chance >= 75 then
                    return getRGB(0, 255, 0)
                elseif chance >= 45 then
                    return getRGB(255, 255, 0)
                else
                    return getRGB(255, 0, 0)
                end
            end
            local connection = RunService.RenderStepped:Connect(function()
                local ms = getPingMs()
                if ms then
                    local chance = calculateChance(ms)
                    label.Text = string.format('<font color="%s">延迟: %dms</font>\n<font color="%s">格挡概率: %d%%</font>', getPingColor(ms), ms, getChanceColor(chance), chance)
                else
                    label.Text = "延迟: 未知\n格挡概率: 未知"
                end
            end)
            screenGui.Destroying:Connect(function()
                connection:Disconnect()
            end)
        else
            local existingGui = playerGui:FindFirstChild("RealTimePingGui")
            if existingGui then
                existingGui:Destroy()
            end
        end
    end
})

otherSection:Dropdown({
    Flag = "AttackerSelect",
    Title = "选择攻击者",
    Values = {"Noli", "c00lkid", "John Doe", "Jason/Slasher", "Sixer", "Nosferatu", "1x1x1x1"},
    Multi = false,
    Default = "Noli",
    Callback = function(value)
        SelectedAttacker = value
    end
})

otherSection:Toggle({
    Flag = "MultiFrame",
    Title = "多帧模式",
    Desc = "开启自动格挡音频时，请同时打开此开关",
    Default = false,
    Callback = function(value)
        MultiFrameEnabled = value
    end
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local function playAnimation(animId)
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
            local anim = Instance.new("Animation")
            anim.AnimationId = animId
            local track = animator:LoadAnimation(anim)
            track:Play()
        end
    end
end

otherSection:Button({
    Title = "假延迟身法(奔跑)",
    Callback = function()
        playAnimation("rbxassetid://136252471123500")
    end
})
otherSection:Button({
    Title = "假延迟身法(行走)",
    Callback = function()
        playAnimation("rbxassetid://108018357044094")
    end
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer
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
local function activateRemoteHook(remoteName, blockedFirstArg)
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
local function deactivateRemoteHook(remoteName, blockedFirstArg)
    for i, rule in ipairs(getgenv().HookRules) do
        if rule.remoteName == remoteName and rule.blockedFirstArg == blockedFirstArg then
            table.remove(getgenv().HookRules, i)
            break
        end
    end
end
local function EnableCharge()
    activateRemoteHook("RemoteEvent", player.Name .. "Guest1337Collision")
end
local function DisableCharge()
    deactivateRemoteHook("RemoteEvent", player.Name .. "Guest1337Collision")
end
otherSection:Toggle({
    Flag = "ChargeIgnoreObjectables",
    Title = "冲锋无视障碍物",
    Default = false,
    Callback = function(value)
        if value then
            EnableCharge()
        else
            DisableCharge()
        end
    end
})

end

do

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer
local autoBlockAudioOn = false
local wallCheckEnabled = false
local cachedCooldown = nil
local detectionRange = 20
local detectionRangeSq = detectionRange * detectionRange
local autoBlockTriggerSounds = {
    ["12222216"] = true,
["70845653728841"] = true,
["71310583817000"] = true,
["71805956520207"] = true,
["71834552297085"] = true,
["72425554233832"] = true,
["74842815979546"] = true,
["75330693422988"] = true,
["76959687420003"] = true,
["79391273191671"] = true,
["79980897195554"] = true,
["80516583309685"] = true,
["80587845277702"] = true,
["81702359653578"] = true,
["82221759983649"] = true,
["83336588073857"] = true,
["84116622032112"] = true,
["84307400688050"] = true,
["85853080745515"] = true,
["86174610237192"] = true,
["86494585504534"] = true,
["86833981571073"] = true,
["89004992452376"] = true,
["95079963655241"] = true,
["98111231282218"] = true,
["101199185291628"] = true,
["101553872555606"] = true,
["101698569375359"] = true,
["102228729296384"] = true,
["104910828105172"] = true,
["105840448036441"] = true,
["106300477136129"] = true,
["106368806396221"] = true,
["107444859834748"] = true,
["108610718831698"] = true,
["108651070773439"] = true,
["108907358619313"] = true,
["109348678063422"] = true,
["109431876587852"] = true,
["110126546193799"] = true,
["110372418055226"] = true,
["112395455254818"] = true,
["112809109188560"] = true,
["114742322778642"] = true,
["115026634746636"] = true,
["116581754553533"] = true,
["117173212095661"] = true,
["117231507259853"] = true,
["119089145505438"] = true,
["119583605486352"] = true,
["119942598489800"] = true,
["121293883585738"] = true,
["121369993837377"] = true,
["121954639447247"] = true,
["124903763333174"] = true,
["125213046326879"] = true,
["127557531826290"] = true,
["127793641088496"] = true,
["128195973631079"] = true,
["128367348686124"] = true,
["128856426573270"] = true,
["129697992204296"] = true,
["131123355704017"] = true,
["131406927389838"] = true,
["136323728355613"] = true,
["140242176732868"] = true,
}

local soundHooks = {}
local soundBlockedUntil = {}

local function hasLineOfSight(fromPos, toPos, ignoreList)
    local direction = (toPos - fromPos)
    local distance = direction.Magnitude

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = ignoreList or {}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true

    local result = workspace:Raycast(fromPos, direction, raycastParams)

    if result then
        return false
    end
    return true
end

local function fireRemoteBlock()
    local remote
    pcall(function()
        local m = ReplicatedStorage:WaitForChild("Modules", 5)
        local n = m and m:WaitForChild("Network", 5)
        local n2 = n and n:WaitForChild("Network", 5)
        local r = n2 and n2:WaitForChild("RemoteEvent", 5)
        remote = r
    end)
    if not remote then print("[NSK] Block ~2875 ERROR: RemoteEvent not found") end
    local args = {
        "UseActorAbility",
        {
            buffer.fromstring("\003\005\000\000\000Clone")
        }
    }
    remote:FireServer(unpack(args))
end

local function isFacing(localRoot, targetRoot)
    local dir = (localRoot.Position - targetRoot.Position).Unit
    local dot = targetRoot.CFrame.LookVector:Dot(dir)
    return dot > -0.3
end

local function extractNumericSoundId(sound)
    if not sound or not sound.SoundId then return nil end
    local sid = tostring(sound.SoundId)
    local num = sid:match("%d+")
    if num then return num end
    return nil
end

local function getSoundWorldPosition(sound)
    if not sound then return nil end
    if sound.Parent and sound.Parent:IsA("BasePart") then
        return sound.Parent.Position, sound.Parent
    end
    if sound.Parent and sound.Parent:IsA("Attachment") and sound.Parent.Parent and sound.Parent.Parent:IsA("BasePart") then
        return sound.Parent.Parent.Position, sound.Parent.Parent
    end
    local found = sound.Parent and sound.Parent:FindFirstChildWhichIsA("BasePart", true)
    if found then
        return found.Position, found
    end
    return nil, nil
end

local function getCharacterFromDescendant(inst)
    if not inst then return nil end
    local model = inst:FindFirstAncestorOfClass("Model")
    if model and model:FindFirstChildOfClass("Humanoid") then
        return model
    end
    return nil
end

local function refreshUIRefs()
    local playerGui = lp:FindFirstChild("PlayerGui")
    if not playerGui then return end
    local main = playerGui:FindFirstChild("MainUI")
    if main then
        local ability = main:FindFirstChild("AbilityContainer")
        local blockBtn = ability and ability:FindFirstChild("Block")
        cachedCooldown = blockBtn and blockBtn:FindFirstChild("CooldownTime")
    else
        cachedCooldown = nil
    end
end

local function attemptBlockForSound(sound)
    if not autoBlockAudioOn or not sound or not sound:IsA("Sound") or not sound.IsPlaying then return end
    local id = extractNumericSoundId(sound)
    if not id or not autoBlockTriggerSounds[id] then return end
    local t = tick()
    if soundBlockedUntil[sound] and t < soundBlockedUntil[sound] then return end
    local myChar = lp.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local soundPos, soundPart = getSoundWorldPosition(sound)
    if not soundPos or not soundPart then return end
    local char = getCharacterFromDescendant(soundPart)
    local plr = char and Players:GetPlayerFromCharacter(char)
    if not plr or plr == lp then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dvec = hrp.Position - myRoot.Position
    if dvec:Dot(dvec) > detectionRangeSq then return end
    if cachedCooldown and cachedCooldown.Text ~= "" then return end
    if not isFacing(myRoot, hrp) then return end

    if wallCheckEnabled then
        local ignoreList = {myChar, char}
        if not hasLineOfSight(myRoot.Position, hrp.Position, ignoreList) then
            return
        end
    end

    fireRemoteBlock()
    soundBlockedUntil[sound] = t + 1.2
end

local function hookSound(sound)
    if not sound or not sound:IsA("Sound") or soundHooks[sound] then return end
    local playedConn = sound.Played:Connect(function() pcall(attemptBlockForSound, sound) end)
    local propConn = sound:GetPropertyChangedSignal("IsPlaying"):Connect(function()
        if sound.IsPlaying then pcall(attemptBlockForSound, sound) end
    end)
    local destroyConn
    destroyConn = sound.Destroying:Connect(function()
        if playedConn and playedConn.Connected then playedConn:Disconnect() end
        if propConn and propConn.Connected then propConn:Disconnect() end
        if destroyConn and destroyConn.Connected then destroyConn:Disconnect() end
        soundHooks[sound] = nil
        soundBlockedUntil[sound] = nil
    end)
    soundHooks[sound] = {playedConn, propConn, destroyConn}
    if sound.IsPlaying then
        task.spawn(function() pcall(attemptBlockForSound, sound) end)
    end
end

lp.CharacterAdded:Connect(function()
    task.delay(0.5, refreshUIRefs)
end)
refreshUIRefs()
for _, desc in ipairs(game:GetDescendants()) do
    if desc:IsA("Sound") then pcall(hookSound, desc) end
end
game.DescendantAdded:Connect(function(desc)
    if desc:IsA("Sound") then pcall(hookSound, desc) end
end)

local autoCloneSection = Tabs.AutoBlock:Section({
    Title = "自动克隆",
    Icon = "copy",
    Opened = false,
})

autoCloneSection:Toggle({
    Flag = "AutoClone",
    Title = "自动克隆(007n7)",
    Default = autoBlockAudioOn,
    Callback = function(state)
        autoBlockAudioOn = state
    end
})

autoCloneSection:Slider({
    Flag = "AutoCloneDetectionRange",
    Title = "探测范围",
    Step = 1,
    Value = {Min = 1, Max = 100, Default = detectionRange},
    Suffix = " studs",
    Callback = function(val)
        detectionRange = val
        detectionRangeSq = val * val
    end
})

autoCloneSection:Toggle({
    Flag = "WallCheck",
    Title = "墙壁检测",
    Default = wallCheckEnabled,
    Callback = function(state)
        wallCheckEnabled = state
    end
})

end


Tabs.AutoBlock:Button({
    Title = "加载自动格挡",
    Callback = function()
local idsFilePath = "LinniScript_Audio_Block_IDS.txt"
local animIdsFilePath = "LinniScript_Animation_Block_IDS.txt"
local newSoundIdText = ""
local newAnimIdText = ""

local defaultAutoBlockSounds = {
    		["12222216"] = true,
	["70845653728841"] = true,
	["70948173568515"] = true,
	["71310583817000"] = true,
	["71805956520207"] = true,
	["71834552297085"] = true,
	["72425554233832"] = true,
	["74707328554358"] = true,
	["74842815979546"] = true,
	["75330693422988"] = true,
	["76959687420003"] = true,
	["77375846492436"] = true,
	["79391273191671"] = true,
	["79980897195554"] = true,
	["80516583309685"] = true,
	["80587845277702"] = true,
	["81299297965542"] = true,
	["81702359653578"] = true,
	["82221759983649"] = true,
	["83336588073857"] = true,
	["83829782357897"] = true,
	["84116622032112"] = true,
	["84307400688050"] = true,
	["85853080745515"] = true,
	["86174610237192"] = true,
	["86494585504534"] = true,
	["86833981571073"] = true,
	["88970503168421"] = true,
	["89004992452376"] = true,
	["90620531468240"] = true,
	["91509234639766"] = true,
	["92567970681901"] = true,
	["93069721274110"] = true,
	["93366464803829"] = true,
	["94317217837143"] = true,
	["94958041603347"] = true,
	["95079963655241"] = true,
	["98111231282218"] = true,
	["98675142200448"] = true,
	["99829427721752"] = true,
	["101199185291628"] = true,
	["101553872555606"] = true,
	["101698569375359"] = true,
	["102228729296384"] = true,
	["104910828105172"] = true,
	["105204810054381"] = true,
	["105458270463374"] = true,
	["105840448036441"] = true,
	["106300477136129"] = true,
	["106368806396221"] = true,
	["106860049270347"] = true,
	["107444859834748"] = true,
	["108610718831698"] = true,
	["108651070773439"] = true,
	["108907358619313"] = true,
	["109348678063422"] = true,
	["109431876587852"] = true,
	["109667959938617"] = true,
	["110126546193799"] = true,
	["110372418055226"] = true,
	["112395455254818"] = true,
	["112809109188560"] = true,
	["114506382930939"] = true,
	["114742322778642"] = true,
	["115026634746636"] = true,
	["116581754553533"] = true,
	["117173212095661"] = true,
	["117231507259853"] = true,
	["118298475669935"] = true,
	["119062842291223"] = true,
	["119089145505438"] = true,
	["119583605486352"] = true,
	["119942598489800"] = true,
	["120112897026015"] = true,
	["121293883585738"] = true,
	["121954639447247"] = true,
	["124269076578545"] = true,
	["124705663396411"] = true,
	["124903763333174"] = true,
	["125213046326879"] = true,
	["125403313786645"] = true,
	["126171487400618"] = true,
	["127557531826290"] = true,
	["127793641088496"] = true,
	["128195973631079"] = true,
	["128367348686124"] = true,
	["128856426573270"] = true,
	["129697992204296"] = true,
	["130958529065375"] = true,
	["131123355704017"] = true,
	["131406927389838"] = true,
	["136323728355613"] = true,
	["136728245733659"] = true,
	["138938529389204"] = true,
	["140242176732868"] = true,
}

local defaultAutoBlockAnimations = {
["87989533095285"] = true,
["122709416391891"] = true,
["79980897195554"] = true,
["119583605486352"] = true,
["74842815979546"] = true,
["119583605486352"] = true,
["87989533095285"] = true
}

local customUserIDs = {}
local customUserAnimationIDs = {}
local autoBlockTriggerSounds = {}
local autoBlockTriggerAnimations = {}

local function countSoundIDs()
    local count = 0
    for _ in pairs(autoBlockTriggerSounds) do
        count = count + 1
    end
    return count
end

local function countAnimationIDs()
    local count = 0
    for _ in pairs(autoBlockTriggerAnimations) do
        count = count + 1
    end
    return count
end

local function countDefaultSoundIDs()
    local count = 0
    for _ in pairs(defaultAutoBlockSounds) do
        count = count + 1
    end
    return count
end

local function countDefaultAnimationIDs()
    local count = 0
    for _ in pairs(defaultAutoBlockAnimations) do
        count = count + 1
    end
    return count
end

local function countCustomSoundIDs()
    local count = 0
    for id in pairs(customUserIDs) do
        if not defaultAutoBlockSounds[id] then
            count = count + 1
        end
    end
    return count
end

local function countCustomAnimationIDs()
    local count = 0
    for id in pairs(customUserAnimationIDs) do
        if not defaultAutoBlockAnimations[id] then
            count = count + 1
        end
    end
    return count
end

local function saveSoundIdsToFile()
    if getgenv then
        getgenv().LinniScriptCustomIDs = customUserIDs
    end
    if not writefile then return end
    pcall(function()
        local lines = {}
        for id, _ in pairs(customUserIDs) do
            if not defaultAutoBlockSounds[id] then
                table.insert(lines, id)
            end
        end
        writefile(idsFilePath, table.concat(lines, "\n"))
    end)
end

local function saveAnimationIdsToFile()
    if getgenv then
        getgenv().LinniScriptCustomAnimationIDs = customUserAnimationIDs
    end
    if not writefile then return end
    pcall(function()
        local lines = {}
        for id, _ in pairs(customUserAnimationIDs) do
            if not defaultAutoBlockAnimations[id] then
                table.insert(lines, id)
            end
        end
        writefile(animIdsFilePath, table.concat(lines, "\n"))
    end)
end

local function mergeSoundIDs()
    autoBlockTriggerSounds = {}
    for id, v in pairs(defaultAutoBlockSounds) do
        autoBlockTriggerSounds[id] = v
    end
    for id, v in pairs(customUserIDs) do
        autoBlockTriggerSounds[id] = v
    end
end

local function mergeAnimationIDs()
    autoBlockTriggerAnimations = {}
    for id, v in pairs(defaultAutoBlockAnimations) do
        autoBlockTriggerAnimations[id] = v
    end
    for id, v in pairs(customUserAnimationIDs) do
        autoBlockTriggerAnimations[id] = v
    end
end

local function resetCustomSoundIds()
    customUserIDs = {}
    mergeSoundIDs()
    pcall(saveSoundIdsToFile)
end

local function resetCustomAnimationIds()
    customUserAnimationIDs = {}
    mergeAnimationIDs()
    pcall(saveAnimationIdsToFile)
end

local function loadSoundIdsFromFile()
    if getgenv and getgenv().LinniScriptCustomIDs then
        customUserIDs = getgenv().LinniScriptCustomIDs
        mergeSoundIDs()
        return
    end
    if not (isfile and readfile) then
        mergeSoundIDs()
        return
    end
    if not isfile(idsFilePath) then
        mergeSoundIDs()
        return
    end
    local success, loadedCustom = pcall(function()
        local fileContent = readfile(idsFilePath)
        local ids = {}
        for line in fileContent:gmatch("[^\r\n]+") do
            local id = line:match("%d+")
            if id and id ~= "" then
                ids[id] = true
            end
        end
        return ids
    end)
    if success and loadedCustom then
        customUserIDs = loadedCustom
        if getgenv then
            getgenv().LinniScriptCustomIDs = loadedCustom
        end
    end
    mergeSoundIDs()
end

local function loadAnimationIdsFromFile()
    if getgenv and getgenv().LinniScriptCustomAnimationIDs then
        customUserAnimationIDs = getgenv().LinniScriptCustomAnimationIDs
        mergeAnimationIDs()
        return
    end
    if not (isfile and readfile) then
        mergeAnimationIDs()
        return
    end
    if not isfile(animIdsFilePath) then
        mergeAnimationIDs()
        return
    end
    local success, loadedCustom = pcall(function()
        local fileContent = readfile(animIdsFilePath)
        local ids = {}
        for line in fileContent:gmatch("[^\r\n]+") do
            local id = line:match("%d+")
            if id and id ~= "" then
                ids[id] = true
            end
        end
        return ids
    end)
    if success and loadedCustom then
        customUserAnimationIDs = loadedCustom
        if getgenv then
            getgenv().LinniScriptCustomAnimationIDs = loadedCustom
        end
    end
    mergeAnimationIDs()
end

pcall(loadSoundIdsFromFile)
pcall(loadAnimationIdsFromFile)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer

local Config = {
    autoBlockOn = false,
    currentMode = "Normal",
    detectionRange = 20,
    monitorDuration = 0.6,
    multiFrameEnabled = false,
    blockCooldown = 0.1,
    antiBaitModeStrictness = "Part of body in Zone",
    delayBeforeBlockEnabled = false,
    delayBeforeBlockTime = 0.1,
    autoOffEnabled = true,
    autoOffCheckInterval = 3,
    animationWindupThreshold = 0.75,
    killerModeEnabled = false
}

local ZoneConfig = {
    visualizationEnabled = true,
    visibility = 0.4,
    height = 7,
    centerOffset = 0,
    runLength = 14,
    runWidth = 7,
    walkLength = 12,
    walkWidth = 6,
    standLength = 10,
    standWidth = 5,
    color = Color3.fromRGB(180, 0, 255),
    outlineColor = Color3.fromRGB(255, 255, 255),
    smoothingEnabled = false,
    smoothingStrength = 3
}

local PartsConfig = {
    Width = 10,
    Length = 10,
    Height = 10,
    Transparency = 0.5,
    Color = Color3.fromRGB(180, 0, 255),
    OffsetZ = 0,
    OffsetY = 0,
    PartLifetime = 0.1,
    SpawnInterval = 0.01,
    SpawnDuration = 0.3,
    ShowParts = true
}

local FacingConfig = {
    mode = "Standard",
    angle = 90,
    playerFacingColor = Color3.fromRGB(0, 0, 139),
    killerLookingColor = Color3.fromRGB(255, 0, 0),
    playerFacingVisEnabled = false,
    killerLookingVisEnabled = false,
    playerTracerOffset = Vector3.new(0, 1, 0),
    killerTracerOffset = Vector3.new(0, -1, 0)
}

local WallCheckConfig = {
    enabled = false,
    visualizationEnabled = false,
    color = Color3.fromRGB(255, 100, 100)
}

local AntiWrongBlockConfig = {
    enabled = false,
    tolerance = 0.15,
    range = 15,
    visualizationEnabled = false,
    color = Color3.fromRGB(255, 255, 0)
}

local AntiSpinBaitConfig = {
    enabled = false,
    mode = "Always",
    maxAngularSpeed = 300,
    angularHistoryDuration = 0.1,
    maxAngle = 100,
    checkInterval = 0.05,
    checkDuration = 0.5,
    postAttackEnabled = false,
    postAttackDelay = 0.03,
    visualizationEnabled = false,
    color = Color3.fromRGB(255, 165, 0)
}

local NoCheckZoneConfig = {
    enabled = false,
    visualizationEnabled = true,
    height = 5,
    range = 5,
    color = Color3.fromRGB(0, 255, 0)
}

local FallingConfig = {
    enabled = false,
    yThreshold = 0.5,
    zoneOffsetDown = 3,
    zoneOffsetUp = 0,
    historySize = 5
}

local WaitConfig = {
    enabled = false,
    duration = 0.3,
    checkInterval = 0.05,
    killerDurations = {
        ["Nosferatu"] = 0.3,
        ["Jason"] = 0.3,
        ["Slasher"] = 0.3,
        ["John Doe"] = 0.3,
        ["C00lkid"] = 0.3,
        ["Noli"] = 0.3,
        ["1x1x1x1"] = 0.3,
        ["Sixer"] = 0.3
    }
}

local HitboxDraggingConfig = {
    Enabled = false,
    MovementMode = "BodyVelocity",
    Speed = 35,
    Radius = 20,
    Duration = 1.5,
    ShowRadius = false,
    LockDuration = 0.15,
    radiusColor = Color3.fromRGB(0, 255, 0)
}

local cachedCooldown = nil
local multiFrameConnections = {}
local lastBlockTime = 0

local soundHooks = {}
local activeAttacks = {}
local spawnedParts = {}
local activeSpinChecks = {}
local processedAnimationAttacks = {}

local killerSpeedData = {}
local killerFallingData = {}
local killerRotationData = {}

local speedHistorySize = 5
local runSpeedThreshold = 20
local walkSpeedThreshold = 1

local hitboxDragIsActive = false
local hitboxRadiusVisualization = nil
local hitboxRadiusParts = {}

local wallCheckVisualization = nil
local antiWrongBlockVisualization = nil
local antiSpinBaitVisualization = nil
local playerFacingVisualization = nil
local killerLookingVisualization = nil

local animationBlockConnection = nil

local function isLocalPlayerKiller()
    local char = lp.Character
    if not char then return false end
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return false end
    for _, killer in ipairs(killersFolder:GetChildren()) do
        if killer == char then
            return true
        end
    end
    return false
end

local function extractNumericSoundId(sound)
    return tostring(sound and sound.SoundId):match("%d+")
end

local function extractNumericAnimationId(animationId)
    return tostring(animationId):match("%d+")
end

local function getCharacterFromDescendant(inst)
    local model = inst and inst:FindFirstAncestorOfClass("Model")
    return model and model:FindFirstChildOfClass("Humanoid") and model
end

local function refreshUIRefs()
    local playerGui = lp:FindFirstChild("PlayerGui")
    if not playerGui then return end
    local mainUI = playerGui:FindFirstChild("MainUI")
    if not mainUI then return end
    local abilityContainer = mainUI:FindFirstChild("AbilityContainer")
    if not abilityContainer then return end
    local blockBtn = abilityContainer:FindFirstChild("Block")
    cachedCooldown = blockBtn and blockBtn:FindFirstChild("CooldownTime")
end

local function getKillerSpeed(killer)
    local hrp = killer:FindFirstChild("HumanoidRootPart")
    if not hrp then return 0 end
    local currentTime = tick()
    local currentPos = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
    if not killerSpeedData[killer] then
        killerSpeedData[killer] = {
            lastPosition = currentPos,
            lastTime = currentTime,
            speedHistory = {},
            smoothedSpeed = 0
        }
        return 0
    end
    local data = killerSpeedData[killer]
    local deltaTime = currentTime - data.lastTime
    if deltaTime > 0.01 then
        local deltaPos = (currentPos - data.lastPosition).Magnitude
        local instantSpeed = deltaPos / deltaTime
        table.insert(data.speedHistory, instantSpeed)
        while #data.speedHistory > speedHistorySize do
            table.remove(data.speedHistory, 1)
        end
        local sum = 0
        for _, s in ipairs(data.speedHistory) do
            sum = sum + s
        end
        data.smoothedSpeed = sum / #data.speedHistory
        data.lastPosition = currentPos
        data.lastTime = currentTime
    end
    return data.smoothedSpeed
end

local function getKillerMovementState(killer)
    local speed = getKillerSpeed(killer)
    if speed >= runSpeedThreshold then
        return "Running"
    elseif speed >= walkSpeedThreshold then
        return "Walking"
    else
        return "Standing"
    end
end

local function cleanupKillerSpeedData()
    for killer, _ in pairs(killerSpeedData) do
        if not killer.Parent then
            killerSpeedData[killer] = nil
        end
    end
end

local function updateKillerFallingData(killer)
    local hrp = killer:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local currentTime = tick()
    local currentY = hrp.Position.Y
    if not killerFallingData[killer] then
        killerFallingData[killer] = {
            yHistory = {},
            lastTime = currentTime
        }
    end
    local data = killerFallingData[killer]
    local deltaTime = currentTime - data.lastTime
    if deltaTime > 0.01 then
        table.insert(data.yHistory, {y = currentY, time = currentTime})
        while #data.yHistory > FallingConfig.historySize do
            table.remove(data.yHistory, 1)
        end
        data.lastTime = currentTime
    end
end

local function isKillerFalling(killer)
    if not FallingConfig.enabled then return false end
    local data = killerFallingData[killer]
    if not data or not data.yHistory or #data.yHistory < 2 then
        return false
    end
    local recent = data.yHistory[#data.yHistory]
    local older = data.yHistory[1]
    local yDiff = older.y - recent.y
    return yDiff > FallingConfig.yThreshold
end

local function isKillerRising(killer)
    if not FallingConfig.enabled then return false end
    local data = killerFallingData[killer]
    if not data or not data.yHistory or #data.yHistory < 2 then
        return false
    end
    local recent = data.yHistory[#data.yHistory]
    local older = data.yHistory[1]
    local yDiff = recent.y - older.y
    return yDiff > FallingConfig.yThreshold
end

local function cleanupKillerFallingData()
    for killer, _ in pairs(killerFallingData) do
        if not killer.Parent then
            killerFallingData[killer] = nil
        end
    end
end

local function getKillerYRotation(killer)
    local hrp = killer:FindFirstChild("HumanoidRootPart")
    if not hrp then return 0 end
    local _, y, _ = hrp.CFrame:ToEulerAnglesYXZ()
    return math.deg(y)
end

local function angleDifference(angle1, angle2)
    local diff = angle1 - angle2
    while diff > 180 do diff = diff - 360 end
    while diff < -180 do diff = diff + 360 end
    return diff
end

local function getKillerAngularVelocity(killer)
    local data = killerRotationData[killer]
    if not data or not data.rotationHistory or #data.rotationHistory < 2 then
        return 0
    end
    local recent = data.rotationHistory[#data.rotationHistory]
    local previous = data.rotationHistory[#data.rotationHistory - 1]
    if not recent or not previous then return 0 end
    local timeDiff = recent.time - previous.time
    if timeDiff <= 0 then return 0 end
    local angleDiff = math.abs(angleDifference(recent.angle, previous.angle))
    return angleDiff / timeDiff
end

local function getMaxAngularVelocityInWindow(killer, windowDuration)
    local data = killerRotationData[killer]
    if not data or not data.rotationHistory or #data.rotationHistory < 2 then
        return 0
    end
    local currentTime = tick()
    local maxVelocity = 0
    for i = 2, #data.rotationHistory do
        local current = data.rotationHistory[i]
        local previous = data.rotationHistory[i - 1]
        if currentTime - current.time <= windowDuration then
            local timeDiff = current.time - previous.time
            if timeDiff > 0 then
                local aDiff = math.abs(angleDifference(current.angle, previous.angle))
                local velocity = aDiff / timeDiff
                if velocity > maxVelocity then
                    maxVelocity = velocity
                end
            end
        end
    end
    return maxVelocity
end

local function getZoneSmoothingOffset(killer)
    if not ZoneConfig.smoothingEnabled then return 0 end
    local angularVel = getKillerAngularVelocity(killer)
    local maxAngularVel = 500
    local normalizedVel = math.clamp(angularVel / maxAngularVel, -1, 1)
    return -normalizedVel * ZoneConfig.smoothingStrength
end

local function isKillerSpinning(killer)
    if not AntiSpinBaitConfig.enabled then return false end
    if AntiSpinBaitConfig.mode == "Only when Sound" then
        if not activeSpinChecks[killer] then
            return false
        end
    end
    local currentAngularVelocity = getKillerAngularVelocity(killer)
    if currentAngularVelocity > AntiSpinBaitConfig.maxAngularSpeed then
        return true
    end
    local maxVelocityInWindow = getMaxAngularVelocityInWindow(killer, AntiSpinBaitConfig.angularHistoryDuration)
    if maxVelocityInWindow > AntiSpinBaitConfig.maxAngularSpeed then
        return true
    end
    local data = killerRotationData[killer]
    if not data or not data.rotationHistory or #data.rotationHistory < 2 then
        return false
    end
    local currentTime = tick()
    local validEntries = {}
    for _, entry in ipairs(data.rotationHistory) do
        if currentTime - entry.time <= AntiSpinBaitConfig.checkDuration then
            table.insert(validEntries, entry)
        end
    end
    if #validEntries < 2 then
        return false
    end
    local totalRotation = 0
    for i = 2, #validEntries do
        totalRotation = totalRotation + math.abs(angleDifference(validEntries[i].angle, validEntries[i-1].angle))
    end
    return totalRotation > AntiSpinBaitConfig.maxAngle
end

local function startSpinCheckForKiller(killer)
    if AntiSpinBaitConfig.mode ~= "Only when Sound" then return end
    activeSpinChecks[killer] = tick()
    task.delay(Config.monitorDuration + 0.1, function()
        if activeSpinChecks[killer] then
            activeSpinChecks[killer] = nil
        end
    end)
end

local function checkPostAttackFacing(killerRoot, myRoot)
    if not AntiSpinBaitConfig.postAttackEnabled then return true end
    if not killerRoot or not myRoot then return true end
    task.wait(AntiSpinBaitConfig.postAttackDelay)
    if not killerRoot.Parent or not myRoot.Parent then return true end
    local directionToPlayer = (myRoot.Position - killerRoot.Position).Unit
    local killerLookVector = killerRoot.CFrame.LookVector
    local dotProduct = killerLookVector:Dot(directionToPlayer)
    return dotProduct > 0.3
end

local function updateKillerRotationTracking()
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end
    local currentTime = tick()
    for _, killer in ipairs(killersFolder:GetChildren()) do
        local hrp = killer:FindFirstChild("HumanoidRootPart")
        if hrp then
            if not killerRotationData[killer] then
                killerRotationData[killer] = {
                    rotationHistory = {},
                    lastUpdateTime = currentTime
                }
            end
            local currentRotation = getKillerYRotation(killer)
            local data = killerRotationData[killer]
            table.insert(data.rotationHistory, {
                time = currentTime,
                angle = currentRotation
            })
            local maxAge = math.max(AntiSpinBaitConfig.checkDuration, AntiSpinBaitConfig.angularHistoryDuration) + 0.5
            while #data.rotationHistory > 0 and (currentTime - data.rotationHistory[1].time) > maxAge do
                table.remove(data.rotationHistory, 1)
            end
            data.lastUpdateTime = currentTime
        end
    end
    for killer, _ in pairs(killerRotationData) do
        if not killer.Parent then
            killerRotationData[killer] = nil
        end
    end
end

local function getWaitDurationForKiller(killerChar)
    if not killerChar then return WaitConfig.duration end
    local killerName = killerChar.Name
    if WaitConfig.killerDurations[killerName] then
        return WaitConfig.killerDurations[killerName]
    end
    return WaitConfig.duration
end

local function getNearestKillerForDrag()
    local myChar = lp.Character
    if not myChar then return nil end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return nil end
    local closestEnemy, closestDist = nil, math.huge
    for _, enemy in ipairs(killersFolder:GetChildren()) do
        local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
        if enemyRoot then
            local dist = (myRoot.Position - enemyRoot.Position).Magnitude
            if dist < closestDist and dist <= HitboxDraggingConfig.Radius then
                closestEnemy = enemyRoot
                closestDist = dist
            end
        end
    end
    return closestEnemy
end

local function lookAtTarget(targetHRP)
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetHRP then return end
    local targetPos = Vector3.new(targetHRP.Position.X, hrp.Position.Y, targetHRP.Position.Z)
    hrp.CFrame = CFrame.lookAt(hrp.Position, targetPos)
end

local function moveTowardsEnemy_BodyVelocity(targetHRP)
    if hitboxDragIsActive or not targetHRP then return end
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid then return end
    hitboxDragIsActive = true
    local oldWalkSpeed = humanoid.WalkSpeed
    humanoid.WalkSpeed = 0
    lookAtTarget(targetHRP)
    local bg = Instance.new("BodyGyro")
    bg.Name = "HitboxDragGyro"
    bg.MaxTorque = Vector3.new(0, math.huge, 0)
    bg.P = 50000
    bg.D = 1000
    bg.Parent = hrp
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e5, 0, 1e5)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = hrp
    local startTime = tick()
    local connection
    connection = RunService.Heartbeat:Connect(function()
        local elapsed = tick() - startTime
        if not hitboxDragIsActive or not targetHRP.Parent or (targetHRP.Position - hrp.Position).Magnitude < 4 or elapsed > HitboxDraggingConfig.Duration then
            connection:Disconnect()
            bv:Destroy()
            if bg and bg.Parent then bg:Destroy() end
            humanoid.WalkSpeed = oldWalkSpeed
            hitboxDragIsActive = false
            return
        end
        local targetPos = Vector3.new(targetHRP.Position.X, hrp.Position.Y, targetHRP.Position.Z)
        bg.CFrame = CFrame.lookAt(hrp.Position, targetPos)
        local direction = (targetHRP.Position - hrp.Position).Unit
        bv.Velocity = Vector3.new(direction.X, 0, direction.Z) * HitboxDraggingConfig.Speed
    end)
    task.delay(HitboxDraggingConfig.Duration + 0.1, function()
        hitboxDragIsActive = false
        if bv and bv.Parent then bv:Destroy() end
        if bg and bg.Parent then bg:Destroy() end
        humanoid.WalkSpeed = oldWalkSpeed
    end)
end

local function moveTowardsEnemy_Teleport(targetHRP)
    if hitboxDragIsActive or not targetHRP then return end
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hitboxDragIsActive = true
    lookAtTarget(targetHRP)
    task.wait(0.05)
    local startTime = tick()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not targetHRP.Parent or (tick() - startTime) > 0.5 then
            connection:Disconnect()
            hitboxDragIsActive = false
            return
        end
        local targetCFrame = targetHRP.CFrame
        local positionInFront = targetCFrame.Position + targetCFrame.LookVector * 4
        hrp.CFrame = CFrame.lookAt(positionInFront, targetHRP.Position)
    end)
    task.delay(0.6, function() hitboxDragIsActive = false end)
end

local function executeHitboxDragging()
    if not HitboxDraggingConfig.Enabled or hitboxDragIsActive then return end
    local nearestEnemy = getNearestKillerForDrag()
    if nearestEnemy then
        if HitboxDraggingConfig.MovementMode == "BodyVelocity" then
            moveTowardsEnemy_BodyVelocity(nearestEnemy)
        elseif HitboxDraggingConfig.MovementMode == "Teleport" then
            moveTowardsEnemy_Teleport(nearestEnemy)
        end
    end
end

local _cachedBlockRemote = nil
local _blockRemoteSearching = false

local function _warmBlockRemote()
    if _cachedBlockRemote or _blockRemoteSearching then return end
    _blockRemoteSearching = true
    task.spawn(function()
        local found
        pcall(function()
            local m = ReplicatedStorage:WaitForChild("Modules", 30)
            local n = m and m:WaitForChild("Network", 30)
            local n2 = n and n:WaitForChild("Network", 30)
            local r = n2 and n2:WaitForChild("RemoteEvent", 30)
            found = r
        end)
        if found then
            _cachedBlockRemote = found
        else
            print("[NSK] Block ERROR: RemoteEvent not found after 30s (check path)")
        end
        _blockRemoteSearching = false
    end)
end
_warmBlockRemote()

local function getBlockRemote()
    if _cachedBlockRemote and _cachedBlockRemote.Parent then
        return _cachedBlockRemote
    end
    local found
    pcall(function()
        local m = ReplicatedStorage:FindFirstChild("Modules")
        local n = m and m:FindFirstChild("Network")
        local n2 = n and n:FindFirstChild("Network")
        local r = n2 and n2:FindFirstChild("RemoteEvent")
        found = r
    end)
    if found then
        _cachedBlockRemote = found
    elseif not _blockRemoteSearching then
        print("格挡错误：找不到RemoteEvent（请检查路径）")
        _warmBlockRemote()
    end
    return found
end

local function fireRemoteBlock()
    if tick() - lastBlockTime < Config.blockCooldown then return end
    lastBlockTime = tick()
    if Config.delayBeforeBlockEnabled and Config.delayBeforeBlockTime > 0 then
        task.wait(Config.delayBeforeBlockTime)
    end
    local remoteEvent = getBlockRemote()
    if not remoteEvent then return end
    local args = { "UseActorAbility", { buffer.fromstring("\003\005\000\000\000Block") } }
    pcall(function() remoteEvent:FireServer(unpack(args)) end)
    task.spawn(executeHitboxDragging)
end

local function isFacingStandard(localRoot, targetRoot)
    local dir = (localRoot.Position - targetRoot.Position).Unit
    return targetRoot.CFrame.LookVector:Dot(dir) > -0.3
end

local function isLookingTowards(sourceRoot, targetRoot, angle)
    if not (sourceRoot and targetRoot) then return false end
    local directionToTarget = (targetRoot.Position - sourceRoot.Position).Unit
    local sourceLookVector = sourceRoot.CFrame.LookVector
    local dotProduct = sourceLookVector:Dot(directionToTarget)
    local requiredDot = math.cos(math.rad(angle / 2))
    return dotProduct >= requiredDot
end

local function checkFacingCondition(myRoot, killerRoot)
    local standardCheckPassed = isFacingStandard(myRoot, killerRoot)
    if FacingConfig.mode == "No Check" then
        return true
    elseif FacingConfig.mode == "Standard" then
        return standardCheckPassed
    elseif FacingConfig.mode == "Player Facing Killer" then
        return standardCheckPassed and isLookingTowards(myRoot, killerRoot, FacingConfig.angle)
    elseif FacingConfig.mode == "Killer Facing Player" then
        return isLookingTowards(killerRoot, myRoot, FacingConfig.angle)
    end
    return true
end

local function checkKillerFacingConsistently(killerRoot, myRoot, killerChar)
    if not WaitConfig.enabled then return true end
    if FacingConfig.mode ~= "Killer Facing Player" then return true end
    local duration = getWaitDurationForKiller(killerChar)
    local checkCount = math.floor(duration / WaitConfig.checkInterval)
    if checkCount < 1 then checkCount = 1 end
    for i = 1, checkCount do
        if not isLookingTowards(killerRoot, myRoot, FacingConfig.angle) then
            return false
        end
        if i < checkCount then
            task.wait(WaitConfig.checkInterval)
        end
    end
    return true
end

local function hasWallBetween(killerRoot, myRoot)
    if not WallCheckConfig.enabled then return false end
    if not killerRoot or not myRoot then return false end
    local startPos = killerRoot.Position
    local endPos = myRoot.Position
    local direction = endPos - startPos
    local distance = direction.Magnitude
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {killerRoot.Parent, myRoot.Parent}
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    rayParams.IgnoreWater = true
    local result = workspace:Raycast(startPos, direction.Unit * (distance - 1), rayParams)
    return result ~= nil
end

local function isKillerTargetingOther(killerChar, myRoot)
    if not AntiWrongBlockConfig.enabled then return false end
    local killerRoot = killerChar:FindFirstChild("HumanoidRootPart")
    if not killerRoot then return false end
    local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
    if not survivorsFolder then return false end
    local killerLookVector = killerRoot.CFrame.LookVector
    local killerPos = killerRoot.Position
    local dirToMe = (myRoot.Position - killerPos).Unit
    local myDot = killerLookVector:Dot(dirToMe)
    for _, survivor in ipairs(survivorsFolder:GetChildren()) do
        if survivor ~= lp.Character then
            local survivorRoot = survivor:FindFirstChild("HumanoidRootPart")
            if survivorRoot then
                local theirPos = survivorRoot.Position
                local theirDistance = (theirPos - killerPos).Magnitude
                if theirDistance <= AntiWrongBlockConfig.range then
                    local dirToThem = (theirPos - killerPos).Unit
                    local theirDot = killerLookVector:Dot(dirToThem)
                    if theirDot > (myDot + AntiWrongBlockConfig.tolerance) then
                        return true
                    end
                end
            end
        end
    end
    return false
end

local function getZoneDimensions(killer)
    local zLength, zWidth, zH
    local state = getKillerMovementState(killer)
    if state == "Running" then
        zLength = ZoneConfig.runLength
        zWidth = ZoneConfig.runWidth
        zH = ZoneConfig.height
    elseif state == "Walking" then
        zLength = ZoneConfig.walkLength
        zWidth = ZoneConfig.walkWidth
        zH = ZoneConfig.height
    else
        zLength = ZoneConfig.standLength
        zWidth = ZoneConfig.standWidth
        zH = ZoneConfig.height
    end
    return zLength, zWidth, zH
end

local function getZoneYOffset(killer)
    if not FallingConfig.enabled then return 0 end
    if isKillerFalling(killer) then
        return -FallingConfig.zoneOffsetDown
    elseif isKillerRising(killer) then
        return FallingConfig.zoneOffsetUp
    end
    return 0
end

local function createNoCheckZoneForKiller(killer)
    if killer:FindFirstChild("NoCheckZone") or not killer:FindFirstChild("HumanoidRootPart") then return end
    local hrp = killer.HumanoidRootPart
    local zone = Instance.new("Part", killer)
    zone.Name = "NoCheckZone"
    zone.Shape = Enum.PartType.Cylinder
    zone.Anchored = true
    zone.CanCollide = false
    zone.Size = Vector3.new(NoCheckZoneConfig.height, NoCheckZoneConfig.range * 2, NoCheckZoneConfig.range * 2)
    zone.CFrame = hrp.CFrame * CFrame.Angles(0, 0, math.rad(90))
    zone.Color = NoCheckZoneConfig.color
    zone.Material = Enum.Material.ForceField
    zone.Transparency = NoCheckZoneConfig.visualizationEnabled and 0.6 or 1
    if NoCheckZoneConfig.visualizationEnabled then
        local highlight = Instance.new("Highlight", zone)
        highlight.Name = "NoCheckZoneHighlight"
        highlight.Adornee = zone
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = NoCheckZoneConfig.color
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.FillTransparency = 0.7
    end
end

local function updateNoCheckZonePosition(killer)
    local zone = killer:FindFirstChild("NoCheckZone")
    local hrp = killer:FindFirstChild("HumanoidRootPart")
    if zone and hrp then
        zone.CFrame = hrp.CFrame * CFrame.Angles(0, 0, math.rad(90))
    end
end

local function manageNoCheckZones()
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end
    local zonesShouldExist = Config.autoBlockOn and NoCheckZoneConfig.enabled
    for _, killer in ipairs(killersFolder:GetChildren()) do
        local zone = killer:FindFirstChild("NoCheckZone")
        if zonesShouldExist then
            if not zone then
                createNoCheckZoneForKiller(killer)
                zone = killer:FindFirstChild("NoCheckZone")
            end
            if zone then
                zone.Size = Vector3.new(NoCheckZoneConfig.height, NoCheckZoneConfig.range * 2, NoCheckZoneConfig.range * 2)
                zone.Color = NoCheckZoneConfig.color
                zone.Transparency = NoCheckZoneConfig.visualizationEnabled and 0.6 or 1
                local highlight = zone:FindFirstChild("NoCheckZoneHighlight")
                if NoCheckZoneConfig.visualizationEnabled then
                    if not highlight then
                        highlight = Instance.new("Highlight", zone)
                        highlight.Name = "NoCheckZoneHighlight"
                        highlight.Adornee = zone
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillTransparency = 0.7
                    end
                    highlight.FillColor = NoCheckZoneConfig.color
                    highlight.Enabled = true
                else
                    if highlight then highlight:Destroy() end
                end
            end
        elseif zone then
            zone:Destroy()
        end
    end
end

local function isPlayerInNoCheckZone(killer)
    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    local killerRoot = killer:FindFirstChild("HumanoidRootPart")
    if not myRoot or not killerRoot then return false end
    local horizontalDistance = ((Vector3.new(myRoot.Position.X, 0, myRoot.Position.Z) - Vector3.new(killerRoot.Position.X, 0, killerRoot.Position.Z))).Magnitude
    local verticalDistance = myRoot.Position.Y - killerRoot.Position.Y
    local effectiveHeight = NoCheckZoneConfig.height
    local inHorizontalRange = horizontalDistance <= NoCheckZoneConfig.range
    local inVerticalRange = verticalDistance >= -effectiveHeight and verticalDistance <= effectiveHeight
    return inHorizontalRange and inVerticalRange
end

local function createZoneForKiller(killer)
    if killer:FindFirstChild("BlockZone") or not killer:FindFirstChild("HumanoidRootPart") then return end
    local hrp = killer.HumanoidRootPart
    local zLength, zWidth, zH = getZoneDimensions(killer)
    local smoothingOffset = getZoneSmoothingOffset(killer)
    local yOffset = getZoneYOffset(killer)
    local zone = Instance.new("Part", killer)
    zone.Name = "BlockZone"
    zone.Anchored = true
    zone.CanCollide = false
    zone.Size = Vector3.new(zWidth, zH, zLength)
    zone.CFrame = hrp.CFrame * CFrame.new(smoothingOffset, yOffset, -zLength/2 + 2 - ZoneConfig.centerOffset)
    zone.Color = ZoneConfig.color
    zone.Material = Enum.Material.ForceField
    zone.Transparency = ZoneConfig.visualizationEnabled and ZoneConfig.visibility or 1
    if ZoneConfig.visualizationEnabled then
        local highlight = Instance.new("Highlight", zone)
        highlight.Name = "ZoneHighlight"
        highlight.Adornee = zone
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = ZoneConfig.color
        highlight.OutlineColor = ZoneConfig.outlineColor
    end
end

local function updateZonePositionAndSize(killer)
    local zone = killer:FindFirstChild("BlockZone")
    local hrp = killer:FindFirstChild("HumanoidRootPart")
    if zone and hrp then
        local zLength, zWidth, zH = getZoneDimensions(killer)
        local smoothingOffset = getZoneSmoothingOffset(killer)
        local yOffset = getZoneYOffset(killer)
        zone.Size = Vector3.new(zWidth, zH, zLength)
        zone.CFrame = hrp.CFrame * CFrame.new(smoothingOffset, yOffset, -zLength/2 + 2 - ZoneConfig.centerOffset)
    end
end

local function manageAllZones()
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end
    local zonesShouldExist = Config.autoBlockOn and Config.currentMode == "Anti Bait"
    for _, killer in ipairs(killersFolder:GetChildren()) do
        local zone = killer:FindFirstChild("BlockZone")
        if zonesShouldExist then
            if not zone then
                createZoneForKiller(killer)
                zone = killer:FindFirstChild("BlockZone")
            end
            if zone then
                zone.Color = ZoneConfig.color
                zone.Transparency = ZoneConfig.visualizationEnabled and ZoneConfig.visibility or 1
                local highlight = zone:FindFirstChild("ZoneHighlight")
                if ZoneConfig.visualizationEnabled then
                    if not highlight then
                        highlight = Instance.new("Highlight", zone)
                        highlight.Name = "ZoneHighlight"
                        highlight.Adornee = zone
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    end
                    highlight.FillColor = ZoneConfig.color
                    highlight.OutlineColor = ZoneConfig.outlineColor
                    highlight.Enabled = true
                else
                    if highlight then highlight:Destroy() end
                end
            end
        elseif zone then
            zone:Destroy()
        end
    end
end

local function createHitboxRadiusVisualization()
    if hitboxRadiusVisualization then return end
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hitboxRadiusVisualization = Instance.new("Model", workspace)
    hitboxRadiusVisualization.Name = "HitboxDrag_RadiusVis"
    local segments = 32
    for i = 1, segments do
        local angle = (i / segments) * math.pi * 2
        local nextAngle = ((i + 1) / segments) * math.pi * 2
        local segmentLength = HitboxDraggingConfig.Radius * 2 * math.sin(math.pi / segments)
        local part = Instance.new("Part")
        part.Name = "Segment_" .. i
        part.Size = Vector3.new(0.3, 0.2, segmentLength)
        part.Material = Enum.Material.Neon
        part.Color = HitboxDraggingConfig.radiusColor
        part.Anchored = true
        part.CanCollide = false
        part.CastShadow = false
        part.Transparency = 0.3
        local midAngle = (angle + nextAngle) / 2
        local x = math.cos(midAngle) * HitboxDraggingConfig.Radius
        local z = math.sin(midAngle) * HitboxDraggingConfig.Radius
        part.CFrame = CFrame.new(hrp.Position.X + x, hrp.Position.Y - 2.5, hrp.Position.Z + z) * CFrame.Angles(0, -midAngle + math.pi/2, 0)
        part.Parent = hitboxRadiusVisualization
        table.insert(hitboxRadiusParts, part)
    end
    local centerPart = Instance.new("Part")
    centerPart.Name = "Center"
    centerPart.Shape = Enum.PartType.Cylinder
    centerPart.Size = Vector3.new(0.3, 1, 1)
    centerPart.Material = Enum.Material.Neon
    centerPart.Color = Color3.fromRGB(255, 0, 0)
    centerPart.Anchored = true
    centerPart.CanCollide = false
    centerPart.CastShadow = false
    centerPart.Transparency = 0.2
    centerPart.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 2.5, hrp.Position.Z) * CFrame.Angles(0, 0, math.rad(90))
    centerPart.Parent = hitboxRadiusVisualization
    table.insert(hitboxRadiusParts, centerPart)
end

local function destroyHitboxRadiusVisualization()
    if hitboxRadiusVisualization then
        hitboxRadiusVisualization:Destroy()
        hitboxRadiusVisualization = nil
    end
    hitboxRadiusParts = {}
end

local function updateHitboxRadiusVisualization()
    if not hitboxRadiusVisualization or not hitboxRadiusVisualization.Parent then return end
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local segments = 32
    for i, part in ipairs(hitboxRadiusParts) do
        if part.Name == "Center" then
            part.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 2.5, hrp.Position.Z) * CFrame.Angles(0, 0, math.rad(90))
        else
            local segmentIndex = tonumber(part.Name:match("%d+"))
            if segmentIndex then
                local angle = (segmentIndex / segments) * math.pi * 2
                local nextAngle = ((segmentIndex + 1) / segments) * math.pi * 2
                local segmentLength = HitboxDraggingConfig.Radius * 2 * math.sin(math.pi / segments)
                part.Size = Vector3.new(0.3, 0.2, segmentLength)
                part.Color = HitboxDraggingConfig.radiusColor
                local midAngle = (angle + nextAngle) / 2
                local x = math.cos(midAngle) * HitboxDraggingConfig.Radius
                local z = math.sin(midAngle) * HitboxDraggingConfig.Radius
                part.CFrame = CFrame.new(hrp.Position.X + x, hrp.Position.Y - 2.5, hrp.Position.Z + z) * CFrame.Angles(0, -midAngle + math.pi/2, 0)
            end
        end
    end
end

local function createWallCheckVisualization()
    if wallCheckVisualization then return end
    wallCheckVisualization = Instance.new("Model", workspace)
    wallCheckVisualization.Name = "WallCheck_Visualizer"
end

local function destroyWallCheckVisualization()
    if wallCheckVisualization then
        wallCheckVisualization:Destroy()
        wallCheckVisualization = nil
    end
end

local function updateWallCheckVisualization()
    if not wallCheckVisualization or not wallCheckVisualization.Parent then return end
    for _, child in ipairs(wallCheckVisualization:GetChildren()) do
        child:Destroy()
    end
    if not WallCheckConfig.visualizationEnabled or not Config.autoBlockOn then return end
    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end
    for _, killer in ipairs(killersFolder:GetChildren()) do
        local killerRoot = killer:FindFirstChild("HumanoidRootPart")
        if killerRoot then
            local hasWall = hasWallBetween(killerRoot, myRoot)
            local startPos = killerRoot.Position
            local endPos = myRoot.Position
            local midPoint = (startPos + endPos) / 2
            local distance = (endPos - startPos).Magnitude
            local line = Instance.new("Part", wallCheckVisualization)
            line.Name = "WallCheckLine_" .. killer.Name
            line.Anchored = true
            line.CanCollide = false
            line.CastShadow = false
            line.Material = Enum.Material.Neon
            line.Size = Vector3.new(0.1, 0.1, distance)
            line.CFrame = CFrame.lookAt(midPoint, endPos)
            if hasWall then
                line.Color = WallCheckConfig.color
                line.Transparency = 0.3
            else
                line.Color = Color3.fromRGB(100, 255, 100)
                line.Transparency = 0.7
            end
        end
    end
end

local function createAntiWrongBlockVisualization()
    if antiWrongBlockVisualization then return end
    antiWrongBlockVisualization = Instance.new("Model", workspace)
    antiWrongBlockVisualization.Name = "AntiWrongBlock_Visualizer"
end

local function destroyAntiWrongBlockVisualization()
    if antiWrongBlockVisualization then
        antiWrongBlockVisualization:Destroy()
        antiWrongBlockVisualization = nil
    end
end

local function getKillerTarget(killerChar)
    local killerRoot = killerChar:FindFirstChild("HumanoidRootPart")
    if not killerRoot then return nil end
    local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
    if not survivorsFolder then return nil end
    local killerLookVector = killerRoot.CFrame.LookVector
    local killerPos = killerRoot.Position
    local bestTarget = nil
    local bestScore = -999
    for _, survivor in ipairs(survivorsFolder:GetChildren()) do
        local survivorRoot = survivor:FindFirstChild("HumanoidRootPart")
        if survivorRoot then
            local theirPos = survivorRoot.Position
            local theirDistance = (theirPos - killerPos).Magnitude
            if theirDistance <= AntiWrongBlockConfig.range then
                local dirToThem = (theirPos - killerPos).Unit
                local theirDot = killerLookVector:Dot(dirToThem)
                local score = theirDot - (theirDistance / 100)
                if score > bestScore then
                    bestScore = score
                    bestTarget = survivor
                end
            end
        end
    end
    return bestTarget
end

local function updateAntiWrongBlockVisualization()
    if not antiWrongBlockVisualization or not antiWrongBlockVisualization.Parent then return end
    for _, child in ipairs(antiWrongBlockVisualization:GetChildren()) do
        child:Destroy()
    end
    if not AntiWrongBlockConfig.visualizationEnabled or not Config.autoBlockOn then return end
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end
    for _, killer in ipairs(killersFolder:GetChildren()) do
        local killerRoot = killer:FindFirstChild("HumanoidRootPart")
        if killerRoot then
            local target = getKillerTarget(killer)
            local isTargetingOther = target and target ~= lp.Character
            if target then
                local targetRoot = target:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    local startPos = killerRoot.Position
                    local endPos = targetRoot.Position
                    local midPoint = (startPos + endPos) / 2
                    local distance = (endPos - startPos).Magnitude
                    local line = Instance.new("Part", antiWrongBlockVisualization)
                    line.Name = "TargetLine_" .. killer.Name
                    line.Anchored = true
                    line.CanCollide = false
                    line.CastShadow = false
                    line.Material = Enum.Material.Neon
                    line.Size = Vector3.new(0.15, 0.15, distance)
                    line.CFrame = CFrame.lookAt(midPoint, endPos)
                    if isTargetingOther then
                        line.Color = AntiWrongBlockConfig.color
                        line.Transparency = 0.2
                    else
                        line.Color = Color3.fromRGB(100, 255, 100)
                        line.Transparency = 0.5
                    end
                end
            end
        end
    end
end

local function createAntiSpinBaitVisualization()
    if antiSpinBaitVisualization then return end
    antiSpinBaitVisualization = Instance.new("Model", workspace)
    antiSpinBaitVisualization.Name = "AntiSpinBait_Visualizer"
end

local function destroyAntiSpinBaitVisualization()
    if antiSpinBaitVisualization then
        antiSpinBaitVisualization:Destroy()
        antiSpinBaitVisualization = nil
    end
end

local function updateAntiSpinBaitVisualization()
    if not antiSpinBaitVisualization or not antiSpinBaitVisualization.Parent then return end
    for _, child in ipairs(antiSpinBaitVisualization:GetChildren()) do
        child:Destroy()
    end
    if not AntiSpinBaitConfig.visualizationEnabled then return end
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end
    for _, killer in ipairs(killersFolder:GetChildren()) do
        local hrp = killer:FindFirstChild("HumanoidRootPart")
        if hrp then
            local isSpinning = isKillerSpinning(killer)
            local currentAngularVel = getKillerAngularVelocity(killer)
            local maxAngularVel = getMaxAngularVelocityInWindow(killer, AntiSpinBaitConfig.angularHistoryDuration)
            local indicator = Instance.new("Part", antiSpinBaitVisualization)
            indicator.Name = "SpinIndicator_" .. killer.Name
            indicator.Shape = Enum.PartType.Ball
            indicator.Position = hrp.Position + Vector3.new(0, 4, 0)
            indicator.Material = Enum.Material.Neon
            indicator.Anchored = true
            indicator.CanCollide = false
            indicator.CastShadow = false
            if isSpinning then
                indicator.Size = Vector3.new(2, 2, 2)
                indicator.Color = AntiSpinBaitConfig.color
                indicator.Transparency = 0.3
            else
                indicator.Size = Vector3.new(1, 1, 1)
                indicator.Color = Color3.fromRGB(100, 100, 100)
                indicator.Transparency = 0.7
            end
            local billboard = Instance.new("BillboardGui", indicator)
            billboard.Size = UDim2.new(0, 100, 0, 40)
            billboard.StudsOffset = Vector3.new(0, 1.5, 0)
            billboard.AlwaysOnTop = true
            local label = Instance.new("TextLabel", billboard)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = string.format("%.0fВ°/s\nMax: %.0fВ°/s", currentAngularVel, maxAngularVel)
            label.TextColor3 = isSpinning and AntiSpinBaitConfig.color or Color3.new(0.7, 0.7, 0.7)
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
        end
    end
end

local function createPlayerFacingVisualization()
    if playerFacingVisualization then return end
    playerFacingVisualization = Instance.new("Model", workspace)
    playerFacingVisualization.Name = "PlayerFacing_Visualizer"
end

local function destroyPlayerFacingVisualization()
    if playerFacingVisualization then
        playerFacingVisualization:Destroy()
        playerFacingVisualization = nil
    end
end

local function updatePlayerFacingVisualization()
    if not playerFacingVisualization or not playerFacingVisualization.Parent then return end
    for _, child in ipairs(playerFacingVisualization:GetChildren()) do
        child:Destroy()
    end
    if not FacingConfig.playerFacingVisEnabled or not Config.autoBlockOn then return end
    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end
    for _, killer in ipairs(killersFolder:GetChildren()) do
        local killerRoot = killer:FindFirstChild("HumanoidRootPart")
        if killerRoot then
            local distance = (myRoot.Position - killerRoot.Position).Magnitude
            if distance <= Config.detectionRange then
                local isFacing = isLookingTowards(myRoot, killerRoot, FacingConfig.angle)
                local startPos = myRoot.Position + FacingConfig.playerTracerOffset
                local endPos = killerRoot.Position + FacingConfig.playerTracerOffset
                local midPoint = (startPos + endPos) / 2
                local dist = (endPos - startPos).Magnitude
                local line = Instance.new("Part", playerFacingVisualization)
                line.Name = "PlayerFacingLine_" .. killer.Name
                line.Anchored = true
                line.CanCollide = false
                line.CastShadow = false
                line.Material = Enum.Material.Neon
                line.Size = Vector3.new(0.2, 0.2, dist)
                line.CFrame = CFrame.lookAt(midPoint, endPos)
                line.Color = FacingConfig.playerFacingColor
                line.Transparency = isFacing and 0.2 or 0.7
                local startSphere = Instance.new("Part", playerFacingVisualization)
                startSphere.Name = "PlayerFacingStart_" .. killer.Name
                startSphere.Shape = Enum.PartType.Ball
                startSphere.Size = Vector3.new(0.5, 0.5, 0.5)
                startSphere.Position = startPos
                startSphere.Anchored = true
                startSphere.CanCollide = false
                startSphere.CastShadow = false
                startSphere.Material = Enum.Material.Neon
                startSphere.Color = FacingConfig.playerFacingColor
                startSphere.Transparency = 0.2
            end
        end
    end
end

local function createKillerLookingVisualization()
    if killerLookingVisualization then return end
    killerLookingVisualization = Instance.new("Model", workspace)
    killerLookingVisualization.Name = "KillerLooking_Visualizer"
end

local function destroyKillerLookingVisualization()
    if killerLookingVisualization then
        killerLookingVisualization:Destroy()
        killerLookingVisualization = nil
    end
end

local function updateKillerLookingVisualization()
    if not killerLookingVisualization or not killerLookingVisualization.Parent then return end
    for _, child in ipairs(killerLookingVisualization:GetChildren()) do
        child:Destroy()
    end
    if not FacingConfig.killerLookingVisEnabled or not Config.autoBlockOn then return end
    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end
    for _, killer in ipairs(killersFolder:GetChildren()) do
        local killerRoot = killer:FindFirstChild("HumanoidRootPart")
        if killerRoot then
            local distance = (myRoot.Position - killerRoot.Position).Magnitude
            if distance <= Config.detectionRange then
                local isLooking = isLookingTowards(killerRoot, myRoot, FacingConfig.angle)
                local startPos = killerRoot.Position + FacingConfig.killerTracerOffset
                local endPos = myRoot.Position + FacingConfig.killerTracerOffset
                local midPoint = (startPos + endPos) / 2
                local dist = (endPos - startPos).Magnitude
                local line = Instance.new("Part", killerLookingVisualization)
                line.Name = "KillerLookingLine_" .. killer.Name
                line.Anchored = true
                line.CanCollide = false
                line.CastShadow = false
                line.Material = Enum.Material.Neon
                line.Size = Vector3.new(0.25, 0.25, dist)
                line.CFrame = CFrame.lookAt(midPoint, endPos)
                line.Color = FacingConfig.killerLookingColor
                line.Transparency = isLooking and 0.2 or 0.7
                local startSphere = Instance.new("Part", killerLookingVisualization)
                startSphere.Name = "KillerLookingStart_" .. killer.Name
                startSphere.Shape = Enum.PartType.Ball
                startSphere.Size = Vector3.new(0.6, 0.6, 0.6)
                startSphere.Position = startPos
                startSphere.Anchored = true
                startSphere.CanCollide = false
                startSphere.CastShadow = false
                startSphere.Material = Enum.Material.Neon
                startSphere.Color = FacingConfig.killerLookingColor
                startSphere.Transparency = 0.2
                local endSphere = Instance.new("Part", killerLookingVisualization)
                endSphere.Name = "KillerLookingEnd_" .. killer.Name
                endSphere.Shape = Enum.PartType.Ball
                endSphere.Size = Vector3.new(0.4, 0.4, 0.4)
                endSphere.Position = endPos
                endSphere.Anchored = true
                endSphere.CanCollide = false
                endSphere.CastShadow = false
                endSphere.Material = Enum.Material.Neon
                endSphere.Color = FacingConfig.killerLookingColor
                endSphere.Transparency = 0.3
            end
        end
    end
end

local function cleanupExpiredParts()
    local currentTime = tick()
    for part, data in pairs(spawnedParts) do
        if currentTime - data.spawnTime >= data.lifetime then
            if part and part.Parent then
                part:Destroy()
            end
            spawnedParts[part] = nil
        end
    end
end

local function isPlayerTouchingAnyPart()
    local myChar = lp.Character
    if not myChar then return false end
    for part, _ in pairs(spawnedParts) do
        if part and part.Parent then
            local overlapParams = OverlapParams.new()
            overlapParams.FilterDescendantsInstances = {myChar}
            overlapParams.FilterType = Enum.RaycastFilterType.Include
            local touchingParts = workspace:GetPartsInPart(part, overlapParams)
            if #touchingParts > 0 then
                return true
            end
        end
    end
    return false
end

local function spawnPartInFrontOfKiller(killerRoot, killer, partIndex)
    if not killerRoot then return nil end
    local smoothingOffset = getZoneSmoothingOffset(killer)
    local partSize = Vector3.new(PartsConfig.Width, PartsConfig.Height, PartsConfig.Length)
    local offsetZ = -PartsConfig.Length / 2 - 2 + PartsConfig.OffsetZ
    local offsetY = PartsConfig.OffsetY
    local part = Instance.new("Part")
    part.Name = "BlockDetectionPart_" .. partIndex
    part.Size = partSize
    part.Anchored = true
    part.CanCollide = false
    part.CastShadow = false
    part.Material = Enum.Material.ForceField
    part.Color = PartsConfig.Color
    part.Transparency = PartsConfig.ShowParts and PartsConfig.Transparency or 1
    part.CFrame = killerRoot.CFrame * CFrame.new(smoothingOffset, offsetY, offsetZ)
    part.Parent = workspace
    local staggeredLifetime = PartsConfig.PartLifetime + (partIndex * 0.01)
    spawnedParts[part] = {
        spawnTime = tick(),
        lifetime = staggeredLifetime
    }
    return part
end

local function startPartsSpawning(killerChar)
    local killerRoot = killerChar:FindFirstChild("HumanoidRootPart")
    if not killerRoot then return end
    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local isTestingAsKiller = Config.killerModeEnabled and killerChar == lp.Character
    if isTestingAsKiller then
        local partCount = math.floor(PartsConfig.SpawnDuration / PartsConfig.SpawnInterval)
        task.spawn(function()
            for i = 1, partCount do
                if not Config.autoBlockOn then break end
                local currentRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                if not currentRoot then break end
                spawnPartInFrontOfKiller(currentRoot, killerChar, i)
                task.wait(PartsConfig.SpawnInterval)
            end
        end)
        return
    end

    if WallCheckConfig.enabled and hasWallBetween(killerRoot, myRoot) then
        return
    end
    if AntiSpinBaitConfig.enabled and isKillerSpinning(killerChar) then
        return
    end
    if AntiWrongBlockConfig.enabled and isKillerTargetingOther(killerChar, myRoot) then
        return
    end
    local partCount = math.floor(PartsConfig.SpawnDuration / PartsConfig.SpawnInterval)
    local blocked = false
    task.spawn(function()
        for i = 1, partCount do
            if not Config.autoBlockOn or blocked then break end
            killerRoot = killerChar:FindFirstChild("HumanoidRootPart")
            if not killerRoot then break end
            spawnPartInFrontOfKiller(killerRoot, killerChar, i)
            if isPlayerTouchingAnyPart() then
                myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                if myRoot and checkFacingCondition(myRoot, killerRoot) then
                    if not (cachedCooldown and cachedCooldown.Text ~= "") then
                        if AntiSpinBaitConfig.postAttackEnabled then
                            if checkPostAttackFacing(killerRoot, myRoot) then
                                if WaitConfig.enabled and FacingConfig.mode == "Killer Facing Player" then
                                    if checkKillerFacingConsistently(killerRoot, myRoot, killerChar) then
                                        blocked = true
                                        fireRemoteBlock()
                                    end
                                else
                                    blocked = true
                                    fireRemoteBlock()
                                end
                            end
                        else
                            if WaitConfig.enabled and FacingConfig.mode == "Killer Facing Player" then
                                if checkKillerFacingConsistently(killerRoot, myRoot, killerChar) then
                                    blocked = true
                                    fireRemoteBlock()
                                end
                            else
                                blocked = true
                                fireRemoteBlock()
                            end
                        end
                    end
                end
            end
            task.wait(PartsConfig.SpawnInterval)
        end
    end)
end

local monitorActiveAttacks
local function fastCheckAndBlock()
    if not Config.autoBlockOn then return end
    pcall(monitorActiveAttacks)
end

local function fastUpdateTracking()
    if not Config.autoBlockOn then return end
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if killersFolder then
        for _, killer in ipairs(killersFolder:GetChildren()) do
            pcall(getKillerSpeed, killer)
            pcall(updateKillerFallingData, killer)
            pcall(updateKillerRotationTracking)
            if Config.currentMode == "Anti Bait" then
                pcall(updateZonePositionAndSize, killer)
            end
            pcall(updateNoCheckZonePosition, killer)
        end
    end
end

local function enableMultiFrame()
    if #multiFrameConnections > 0 then return end
    table.insert(multiFrameConnections, RunService.Stepped:Connect(function()
        fastUpdateTracking()
        fastCheckAndBlock()
    end))
    table.insert(multiFrameConnections, RunService:BindToRenderStep("PreRender_BlockCheck", Enum.RenderPriority.First.Value - 1, function()
        fastCheckAndBlock()
    end))
    table.insert(multiFrameConnections, RunService:BindToRenderStep("PostInput_BlockCheck", Enum.RenderPriority.Input.Value + 1, function()
        fastCheckAndBlock()
    end))
end

local function disableMultiFrame()
    for _, conn in ipairs(multiFrameConnections) do
        if typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
        end
    end
    multiFrameConnections = {}
    pcall(function()
        RunService:UnbindFromRenderStep("PreRender_BlockCheck")
    end)
    pcall(function()
        RunService:UnbindFromRenderStep("PostInput_BlockCheck")
    end)
end

monitorActiveAttacks = function()
    if not Config.autoBlockOn or not next(activeAttacks) then return end
    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    if cachedCooldown and cachedCooldown.Text ~= "" then
        activeAttacks = {}
        return
    end
    local t = tick()
    for sound, attackData in pairs(activeAttacks) do
        if not sound or not sound.Parent or t > attackData.endTime then
            activeAttacks[sound] = nil
            continue
        end
        local killerChar = attackData.killer
        local killerRoot = killerChar and killerChar.Parent and killerChar:FindFirstChild("HumanoidRootPart")
        if not killerRoot then
            activeAttacks[sound] = nil
            continue
        end
        if WallCheckConfig.enabled and hasWallBetween(killerRoot, myRoot) then
            continue
        end
        if AntiWrongBlockConfig.enabled and isKillerTargetingOther(killerChar, myRoot) then
            continue
        end
        if AntiSpinBaitConfig.enabled and isKillerSpinning(killerChar) then
            continue
        end
        if not checkFacingCondition(myRoot, killerRoot) then
            continue
        end
        if Config.currentMode == "Anti Bait" then
            local killerZone = killerChar:FindFirstChild("BlockZone")
            local myChar = lp.Character
            if killerZone and myChar then
                local shouldBlock = false
                if Config.antiBaitModeStrictness == "Full Body in Zone" then
                    local myPointInZone = killerZone.CFrame:PointToObjectSpace(myRoot.Position)
                    local halfSize = killerZone.Size / 2
                    if math.abs(myPointInZone.X) <= halfSize.X and math.abs(myPointInZone.Y) <= halfSize.Y and math.abs(myPointInZone.Z) <= halfSize.Z then
                        shouldBlock = true
                    end
                else
                    local overlapParams = OverlapParams.new()
                    overlapParams.FilterDescendantsInstances = {myChar}
                    overlapParams.FilterType = Enum.RaycastFilterType.Include
                    local touchingParts = workspace:GetPartsInPart(killerZone, overlapParams)
                    if #touchingParts > 0 then
                        shouldBlock = true
                    end
                end
                if shouldBlock then
                    if AntiSpinBaitConfig.postAttackEnabled then
                        task.spawn(function()
                            if checkPostAttackFacing(killerRoot, myRoot) then
                                if WaitConfig.enabled and FacingConfig.mode == "Killer Facing Player" then
                                    if checkKillerFacingConsistently(killerRoot, myRoot, killerChar) then
                                        fireRemoteBlock()
                                    end
                                else
                                    fireRemoteBlock()
                                end
                            end
                        end)
                        activeAttacks[sound] = nil
                    else
                        if WaitConfig.enabled and FacingConfig.mode == "Killer Facing Player" then
                            task.spawn(function()
                                if checkKillerFacingConsistently(killerRoot, myRoot, killerChar) then
                                    fireRemoteBlock()
                                end
                            end)
                            activeAttacks[sound] = nil
                        else
                            fireRemoteBlock()
                            activeAttacks = {}
                        end
                    end
                    break
                end
            end
        end
    end
end

local function registerAttackForMonitoring(sound)
    if not Config.autoBlockOn or not (sound and sound:IsA("Sound") and sound.IsPlaying) then return end
    local id = extractNumericSoundId(sound)
    if not id or not autoBlockTriggerSounds[id] then return end
    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local char = getCharacterFromDescendant(sound.Parent)
    local plr = char and Players:GetPlayerFromCharacter(char)
    
    if not plr then return end
    if plr == lp and not Config.killerModeEnabled then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local distance = (hrp.Position - myRoot.Position).Magnitude
    if AntiSpinBaitConfig.mode == "Only when Sound" then
        startSpinCheckForKiller(char)
    end
    if NoCheckZoneConfig.enabled and isPlayerInNoCheckZone(char) then
        if not (cachedCooldown and cachedCooldown.Text ~= "") then
            if not (WallCheckConfig.enabled and hasWallBetween(hrp, myRoot)) then
                fireRemoteBlock()
                return
            end
        end
    end
    if distance > Config.detectionRange then return end
    if Config.currentMode == "Normal" then
        if WallCheckConfig.enabled and hasWallBetween(hrp, myRoot) then return end
        if AntiWrongBlockConfig.enabled and isKillerTargetingOther(char, myRoot) then return end
        if AntiSpinBaitConfig.enabled and isKillerSpinning(char) then return end
        if not checkFacingCondition(myRoot, hrp) then return end
        if not (cachedCooldown and cachedCooldown.Text ~= "") then
            if AntiSpinBaitConfig.postAttackEnabled then
                task.spawn(function()
                    if checkPostAttackFacing(hrp, myRoot) then
                        if WaitConfig.enabled and FacingConfig.mode == "Killer Facing Player" then
                            if checkKillerFacingConsistently(hrp, myRoot, char) then
                                fireRemoteBlock()
                            end
                        else
                            fireRemoteBlock()
                        end
                    end
                end)
            else
                if WaitConfig.enabled and FacingConfig.mode == "Killer Facing Player" then
                    task.spawn(function()
                        if checkKillerFacingConsistently(hrp, myRoot, char) then
                            fireRemoteBlock()
                        end
                    end)
                else
                    fireRemoteBlock()
                end
            end
        end
    elseif Config.currentMode == "Parts" then
        startPartsSpawning(char)
    elseif Config.currentMode == "Anti Bait" then
        if not activeAttacks[sound] then
            activeAttacks[sound] = { killer = char, endTime = tick() + Config.monitorDuration }
        end
    end
end

local function hookSound(sound)
    if not (sound and sound:IsA("Sound") and not soundHooks[sound]) then return end
    local connections = {}
    connections[1] = sound.Played:Connect(function()
        pcall(registerAttackForMonitoring, sound)
    end)
    connections[2] = sound:GetPropertyChangedSignal("IsPlaying"):Connect(function()
        if sound.IsPlaying then
            pcall(registerAttackForMonitoring, sound)
        end
    end)
    connections[3] = sound.Destroying:Connect(function()
        for _, conn in ipairs(connections) do
            if conn.Connected then
                conn:Disconnect()
            end
        end
        soundHooks[sound] = nil
        activeAttacks[sound] = nil
    end)
    soundHooks[sound] = connections
    if sound.IsPlaying then
        task.spawn(registerAttackForMonitoring, sound)
    end
end

local function cleanupProcessedAnimations()
    local currentTime = tick()
    for key, timestamp in pairs(processedAnimationAttacks) do
        if currentTime - timestamp > 0.5 then
            processedAnimationAttacks[key] = nil
        end
    end
end

local function checkAnimationAttacks()
    if not Config.autoBlockOn then return end
    local myChar = lp.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local myHumanoid = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if not (myChar and myRoot and myHumanoid) then return end
    if cachedCooldown and cachedCooldown.Text ~= "" then return end
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end
    for _, killerChar in ipairs(killersFolder:GetChildren()) do
        local hrp = killerChar:FindFirstChild("HumanoidRootPart")
        local hum = killerChar:FindFirstChildOfClass("Humanoid")
        local animator = hum and hum:FindFirstChildOfClass("Animator")
        if hrp and animator then
            local distance = (hrp.Position - myRoot.Position).Magnitude
        local isTestingAsKiller = Config.killerModeEnabled and killerChar == myChar
        if distance <= Config.detectionRange or isTestingAsKiller then
                local animTracks = animator:GetPlayingAnimationTracks()
                for _, track in ipairs(animTracks) do
                    if track and track.Animation then
                        local animId = extractNumericAnimationId(track.Animation.AnimationId)
                        if animId and autoBlockTriggerAnimations[animId] then
                            local progress = track.Length > 0 and (track.TimePosition / track.Length) or 0
                            if progress < Config.animationWindupThreshold then
                                local attackKey = killerChar.Name .. "_" .. animId .. "_" .. math.floor(tick() * 2)
                                if not processedAnimationAttacks[attackKey] then
                                    processedAnimationAttacks[attackKey] = tick()
                                    if AntiSpinBaitConfig.mode == "Only when Sound" then
                                        startSpinCheckForKiller(killerChar)
                                    end
                                    if NoCheckZoneConfig.enabled and isPlayerInNoCheckZone(killerChar) then
                                        if not (WallCheckConfig.enabled and hasWallBetween(hrp, myRoot)) then
                                            fireRemoteBlock()
                                            return
                                        end
                                    end
                                    if Config.currentMode == "Normal" then
                                        if WallCheckConfig.enabled and hasWallBetween(hrp, myRoot) then continue end
                                        if AntiWrongBlockConfig.enabled and isKillerTargetingOther(killerChar, myRoot) then continue end
                                        if AntiSpinBaitConfig.enabled and isKillerSpinning(killerChar) then continue end
                                        if not checkFacingCondition(myRoot, hrp) then continue end
                                        if AntiSpinBaitConfig.postAttackEnabled then
                                            task.spawn(function()
                                                if checkPostAttackFacing(hrp, myRoot) then
                                                    if WaitConfig.enabled and FacingConfig.mode == "Killer Facing Player" then
                                                        if checkKillerFacingConsistently(hrp, myRoot, killerChar) then
                                                            fireRemoteBlock()
                                                        end
                                                    else
                                                        fireRemoteBlock()
                                                    end
                                                end
                                            end)
                                        else
                                            if WaitConfig.enabled and FacingConfig.mode == "Killer Facing Player" then
                                                task.spawn(function()
                                                    if checkKillerFacingConsistently(hrp, myRoot, killerChar) then
                                                        fireRemoteBlock()
                                                    end
                                                end)
                                            else
                                                fireRemoteBlock()
                                            end
                                        end
                                        return
                                    elseif Config.currentMode == "Parts" then
                                        startPartsSpawning(killerChar)
                                        return
                                    elseif Config.currentMode == "Anti Bait" then
                                        local killerZone = killerChar:FindFirstChild("BlockZone")
                                        if killerZone and myChar then
                                            local shouldBlock = false
                                            if Config.antiBaitModeStrictness == "Full Body in Zone" then
                                                local myPointInZone = killerZone.CFrame:PointToObjectSpace(myRoot.Position)
                                                local halfSize = killerZone.Size / 2
                                                if math.abs(myPointInZone.X) <= halfSize.X and math.abs(myPointInZone.Y) <= halfSize.Y and math.abs(myPointInZone.Z) <= halfSize.Z then
                                                    shouldBlock = true
                                                end
                                            else
                                                local overlapParams = OverlapParams.new()
                                                overlapParams.FilterDescendantsInstances = {myChar}
                                                overlapParams.FilterType = Enum.RaycastFilterType.Include
                                                local touchingParts = workspace:GetPartsInPart(killerZone, overlapParams)
                                                if #touchingParts > 0 then
                                                    shouldBlock = true
                                                end
                                            end
                                            if shouldBlock then
                                                if WallCheckConfig.enabled and hasWallBetween(hrp, myRoot) then continue end
                                                if AntiWrongBlockConfig.enabled and isKillerTargetingOther(killerChar, myRoot) then continue end
                                                if AntiSpinBaitConfig.enabled and isKillerSpinning(killerChar) then continue end
                                                if not checkFacingCondition(myRoot, hrp) then continue end
                                                if AntiSpinBaitConfig.postAttackEnabled then
                                                    task.spawn(function()
                                                        if checkPostAttackFacing(hrp, myRoot) then
                                                            if WaitConfig.enabled and FacingConfig.mode == "Killer Facing Player" then
                                                                if checkKillerFacingConsistently(hrp, myRoot, killerChar) then
                                                                    fireRemoteBlock()
                                                                end
                                                            else
                                                                fireRemoteBlock()
                                                            end
                                                        end
                                                    end)
                                                else
                                                    if WaitConfig.enabled and FacingConfig.mode == "Killer Facing Player" then
                                                        task.spawn(function()
                                                            if checkKillerFacingConsistently(hrp, myRoot, killerChar) then
                                                                fireRemoteBlock()
                                                            end
                                                        end)
                                                    else
                                                        fireRemoteBlock()
                                                    end
                                                end
                                                return
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function startAnimationDetection()
    if animationBlockConnection then return end
    animationBlockConnection = RunService.Heartbeat:Connect(function()
        if Config.autoBlockOn then
            pcall(checkAnimationAttacks)
            pcall(cleanupProcessedAnimations)
        end
    end)
end

local function stopAnimationDetection()
    if animationBlockConnection then
        animationBlockConnection:Disconnect()
        animationBlockConnection = nil
    end
    processedAnimationAttacks = {}
end

local function cleanupAllVisualizations()
    destroyPlayerFacingVisualization()
    destroyKillerLookingVisualization()
    destroyAntiSpinBaitVisualization()
    destroyWallCheckVisualization()
    destroyAntiWrongBlockVisualization()
    destroyHitboxRadiusVisualization()
end

local function cleanupAllData()
    killerRotationData = {}
    killerSpeedData = {}
    killerFallingData = {}
    activeAttacks = {}
    activeSpinChecks = {}
    processedAnimationAttacks = {}
    hitboxDragIsActive = false
    for part, _ in pairs(spawnedParts) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    spawnedParts = {}
end

local function createVisualizationsIfNeeded()
    if AntiSpinBaitConfig.visualizationEnabled then createAntiSpinBaitVisualization() end
    if WallCheckConfig.visualizationEnabled then createWallCheckVisualization() end
    if AntiWrongBlockConfig.visualizationEnabled then createAntiWrongBlockVisualization() end
    if HitboxDraggingConfig.ShowRadius then createHitboxRadiusVisualization() end
    if FacingConfig.playerFacingVisEnabled then createPlayerFacingVisualization() end
    if FacingConfig.killerLookingVisEnabled then createKillerLookingVisualization() end
end

task.spawn(function()
    while task.wait(Config.autoOffCheckInterval) do
        if Config.autoOffEnabled and Config.autoBlockOn and not Config.killerModeEnabled then
            if isLocalPlayerKiller() then
                Config.autoBlockOn = false
                cleanupAllVisualizations()
                disableMultiFrame()
                stopAnimationDetection()
                cleanupAllData()
                manageAllZones()
                manageNoCheckZones()

            end
        end
    end
end)

task.spawn(function()
    while task.wait(5) do
        if Config.autoBlockOn then
            pcall(manageAllZones)
            pcall(manageNoCheckZones)
            pcall(cleanupKillerSpeedData)
            pcall(cleanupKillerFallingData)
        end
    end
end)

task.spawn(function()
    while task.wait(AntiSpinBaitConfig.checkInterval) do
        if Config.autoBlockOn then
            pcall(updateKillerRotationTracking)
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not Config.autoBlockOn then return end
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if killersFolder then
        for _, killer in ipairs(killersFolder:GetChildren()) do
            pcall(getKillerSpeed, killer)
            pcall(updateKillerFallingData, killer)
            if Config.currentMode == "Anti Bait" then
                pcall(updateZonePositionAndSize, killer)
            end
            pcall(updateNoCheckZonePosition, killer)
        end
    end
    pcall(cleanupExpiredParts)
    if not Config.multiFrameEnabled then
        pcall(monitorActiveAttacks)
    end
end)

RunService.RenderStepped:Connect(function()
    if playerFacingVisualization and FacingConfig.playerFacingVisEnabled then
        pcall(updatePlayerFacingVisualization)
    end
    if killerLookingVisualization and FacingConfig.killerLookingVisEnabled then
        pcall(updateKillerLookingVisualization)
    end
    if antiSpinBaitVisualization and AntiSpinBaitConfig.visualizationEnabled then
        pcall(updateAntiSpinBaitVisualization)
    end
    if wallCheckVisualization and WallCheckConfig.visualizationEnabled then
        pcall(updateWallCheckVisualization)
    end
    if antiWrongBlockVisualization and AntiWrongBlockConfig.visualizationEnabled then
        pcall(updateAntiWrongBlockVisualization)
    end
    if hitboxRadiusVisualization and HitboxDraggingConfig.ShowRadius then
        pcall(updateHitboxRadiusVisualization)
    end
end)

lp.CharacterAdded:Connect(function(char)
    task.delay(0.5, refreshUIRefs)
    cleanupAllData()
    if Config.autoBlockOn then
        if FacingConfig.playerFacingVisEnabled then
            destroyPlayerFacingVisualization()
            createPlayerFacingVisualization()
        end
        if FacingConfig.killerLookingVisEnabled then
            destroyKillerLookingVisualization()
            createKillerLookingVisualization()
        end
        if HitboxDraggingConfig.ShowRadius then
            task.delay(0.5, function()
                destroyHitboxRadiusVisualization()
                createHitboxRadiusVisualization()
            end)
        end
    end
end)

refreshUIRefs()

for _, desc in ipairs(game:GetDescendants()) do
    if desc:IsA("Sound") then
        pcall(hookSound, desc)
    end
end

game.DescendantAdded:Connect(function(desc)
    if desc:IsA("Sound") then
        pcall(hookSound, desc)
    end
end)

do
    local UserInputService = game:GetService("UserInputService")
    local showToggleButton = false
    local toggleKeybind = Enum.KeyCode.F1

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AutoBlockToggleGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.Enabled = showToggleButton
    screenGui.ResetOnSpawn = false

    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0, 30, 0, 30)
    toggleFrame.Position = UDim2.new(0, 60, 0, 10)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    toggleFrame.BorderSizePixel = 2
    toggleFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = toggleFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, 0, 1, 0)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Text = ""
    toggleButton.Parent = toggleFrame

    local function updateToggleButtonColor()
        if Config.autoBlockOn then
            toggleFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            toggleFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
        else
            toggleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            toggleFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
        end
    end

    local function toggleAutoBlock()
        Config.autoBlockOn = not Config.autoBlockOn
        manageAllZones()
        manageNoCheckZones()
        if Config.autoBlockOn then
            createVisualizationsIfNeeded()
            startAnimationDetection()
            if Config.multiFrameEnabled then enableMultiFrame() end
        else
            cleanupAllVisualizations()
            disableMultiFrame()
            stopAnimationDetection()
            cleanupAllData()
        end
        updateToggleButtonColor()
    end

    toggleButton.MouseButton1Click:Connect(toggleAutoBlock)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == toggleKeybind then
            toggleAutoBlock()
        end
    end)

    Tabs.AutoBlock:Toggle({
        Flag = "AutoBlockToggle",
        Title = "自动格挡[音频+动画]",
        Default = false,
        Callback = function(state)
            Config.autoBlockOn = state
            manageAllZones()
            manageNoCheckZones()
            if state then
                createVisualizationsIfNeeded()
                startAnimationDetection()
                if Config.multiFrameEnabled then enableMultiFrame() end
            else
                cleanupAllVisualizations()
                disableMultiFrame()
                stopAnimationDetection()
                cleanupAllData()
            end
            updateToggleButtonColor()
        end
    })

    Tabs.AutoBlock:Dropdown({
        Flag = "AutoBlockMode",
        Title = "自动格挡模式",
        Values = {"Normal", "Parts", "Anti Bait"},
        Multi = false,
        Default = "Normal",
        Callback = function(choice)
            Config.currentMode = choice
            for part, _ in pairs(spawnedParts) do
                if part and part.Parent then
                    part:Destroy()
                end
            end
            spawnedParts = {}
            manageAllZones()
        end
    })

    Tabs.AutoBlock:Dropdown({
        Flag = "AntiBaitStrictness",
        Title = "防诱饵模式",
        Values = {"Part of body in Zone", "Full Body in Zone"},
        Multi = false,
        Default = "Part of body in Zone",
        Callback = function(choice)
            Config.antiBaitModeStrictness = choice
        end
    })

    local multiFrameSection = Tabs.AutoBlock:Section({
        Title = "多帧模式",
        Icon = "zap",
        Opened = false,
    })

    multiFrameSection:Toggle({
        Flag = "MultiFrameEnabled",
        Title = "启用低消耗高帧",
        Default = false,
        Callback = function(state)
            Config.multiFrameEnabled = state
            if state and Config.autoBlockOn then
                enableMultiFrame()
            else
                disableMultiFrame()
            end
        end
    })

    multiFrameSection:Paragraph({
        Title = "多帧信息",
        Desc = "通过每帧多次检查，使自动阻止速度更快，使用更多CPU/GPU资源，将反应时间从约5毫秒缩短到约0毫秒",
    })

    local autoOffSection = Tabs.AutoBlock:Section({
        Title = "自动关闭[杀手检测]",
        Icon = "power",
        Opened = false,
    })

    autoOffSection:Toggle({
        Flag = "AutoOffEnabled",
        Title = "自动关闭 IF 杀手",
        Default = true,
        Callback = function(state)
            Config.autoOffEnabled = state
        end
    })

    autoOffSection:Slider({
        Flag = "AutoOffCheckInterval",
        Title = "检查间隔",
        Step = 0.5,
        Value = {Min = 1, Max = 10, Default = 3},
        Suffix = " sec",
        Callback = function(val)
            Config.autoOffCheckInterval = tonumber(val) or 3
        end
    })

    local hitboxDragSection = Tabs.AutoBlock:Section({
        Title = "范围拖曳技术",
        Icon = "move",
        Opened = false,
    })

    hitboxDragSection:Toggle({
        Flag = "HitboxDragToggle",
        Title = "启用范围拖动",
        Default = false,
        Callback = function(state)
            HitboxDraggingConfig.Enabled = state
            if not state then
                hitboxDragIsActive = false
            end
        end
    })

    hitboxDragSection:Dropdown({
        Flag = "HitboxDragMode",
        Title = "运动模式",
        Values = {"BodyVelocity", "Teleport"},
        Multi = false,
        Default = "BodyVelocity",
        Callback = function(value)
            HitboxDraggingConfig.MovementMode = value
        end
    })

    hitboxDragSection:Slider({
        Flag = "HitboxDragSpeed",
        Title = "判定框拖动速度",
        Step = 1,
        Value = {Min = 10, Max = 100, Default = 35},
        Suffix = " studs/s",
        Callback = function(val)
            HitboxDraggingConfig.Speed = tonumber(val) or 35
        end
    })

    hitboxDragSection:Slider({
        Flag = "HitboxDragDuration",
        Title = "判定框拖动速度持续时间",
        Step = 0.1,
        Value = {Min = 0.1, Max = 3.0, Default = 1.5},
        Suffix = " sec",
        Callback = function(val)
            HitboxDraggingConfig.Duration = tonumber(val) or 1.5
        end
    })

    hitboxDragSection:Slider({
        Flag = "HitboxDragRadius",
        Title = "激活范围",
        Step = 1,
        Value = {Min = 5, Max = 50, Default = 20},
        Suffix = " studs",
        Callback = function(val)
            HitboxDraggingConfig.Radius = tonumber(val) or 20
            if hitboxRadiusVisualization then
                destroyHitboxRadiusVisualization()
                createHitboxRadiusVisualization()
            end
        end
    })

    hitboxDragSection:Toggle({
        Flag = "HitboxDragShowRadius",
        Title = "显示范围可视化",
        Default = false,
        Callback = function(state)
            HitboxDraggingConfig.ShowRadius = state
            if state and Config.autoBlockOn then
                createHitboxRadiusVisualization()
            else
                destroyHitboxRadiusVisualization()
            end
        end
    })

    hitboxDragSection:Colorpicker({
        Flag = "HitboxDragRadiusColor",
        Title = "范围颜色",
        Default = Color3.fromRGB(0, 255, 0),
        Callback = function(color)
            HitboxDraggingConfig.radiusColor = color
        end
    })

    local generalSection = Tabs.AutoBlock:Section({
        Title = "所有模式的基本设置",
        Icon = "settings",
        Opened = false,
    })

    generalSection:Slider({
        Flag = "AutoBlockDetectionRange",
        Title = "自动格挡探测范围",
        Step = 0.5,
        Value = {Min = 1, Max = 100, Default = 20},
        Suffix = " studs",
        Callback = function(val)
            Config.detectionRange = tonumber(val) or 20
        end
    })

    generalSection:Slider({
        Flag = "AutoBlockVerificationDuration",
        Title = "自动格挡攻击验证持续时间",
        Step = 0.05,
        Value = {Min = 0.1, Max = 2.0, Default = 0.6},
        Suffix = " sec",
        Callback = function(val)
            Config.monitorDuration = tonumber(val) or 0.6
        end
    })

    generalSection:Slider({
        Flag = "AnimationWindupThreshold",
        Title = "动画前摇阈值",
        Step = 0.05,
        Value = {Min = 0.1, Max = 1.0, Default = 0.75},
        Suffix = "",
        Callback = function(val)
            Config.animationWindupThreshold = tonumber(val) or 0.75
        end
    })

    generalSection:Toggle({
        Flag = "DelayBeforeBlockEnabled",
        Title = "格挡前延迟",
        Default = false,
        Callback = function(state)
            Config.delayBeforeBlockEnabled = state
        end
    })

    generalSection:Slider({
        Flag = "DelayBeforeBlockTime",
        Title = "延迟时间",
        Step = 0.01,
        Value = {Min = 0.01, Max = 0.5, Default = 0.1},
        Suffix = " sec",
        Callback = function(val)
            Config.delayBeforeBlockTime = tonumber(val) or 0.1
        end
    })

    local partsSection = Tabs.AutoBlock:Section({
        Title = "Part模式设置",
        Icon = "box",
        Opened = false,
    })

    partsSection:Toggle({
        Flag = "PartsShowVisualization",
        Title = "显示Part[可视化]",
        Default = true,
        Callback = function(state)
            PartsConfig.ShowParts = state
        end
    })

    partsSection:Slider({
        Flag = "PartsWidth",
        Title = "Part宽度",
        Step = 0.5,
        Value = {Min = 1, Max = 30, Default = 10},
        Suffix = " studs",
        Callback = function(val)
            PartsConfig.Width = tonumber(val) or 10
        end
    })

    partsSection:Slider({
        Flag = "PartsLength",
        Title = "Part长度",
        Step = 0.5,
        Value = {Min = 1, Max = 30, Default = 10},
        Suffix = " studs",
        Callback = function(val)
            PartsConfig.Length = tonumber(val) or 10
        end
    })

    partsSection:Slider({
        Flag = "PartsHeight",
        Title = "Part高度",
        Step = 0.5,
        Value = {Min = 1, Max = 30, Default = 10},
        Suffix = " studs",
        Callback = function(val)
            PartsConfig.Height = tonumber(val) or 10
        end
    })

    partsSection:Slider({
        Flag = "PartsTransparency",
        Title = "Part透明度",
        Step = 0.1,
        Value = {Min = 0, Max = 1, Default = 0.5},
        Suffix = "",
        Callback = function(val)
            PartsConfig.Transparency = tonumber(val) or 0.5
        end
    })

    partsSection:Colorpicker({
        Flag = "PartsColor",
        Title = "Part颜色",
        Default = Color3.fromRGB(180, 0, 255),
        Callback = function(color)
            PartsConfig.Color = color
        end
    })

    partsSection:Slider({
        Flag = "PartsOffsetZ",
        Title = "向前/向后偏移",
        Step = 0.5,
        Value = {Min = -15, Max = 15, Default = 0},
        Suffix = " studs",
        Callback = function(val)
            PartsConfig.OffsetZ = tonumber(val) or 0
        end
    })

    partsSection:Slider({
        Flag = "PartsOffsetY",
        Title = "向上/向下偏移",
        Step = 0.5,
        Value = {Min = -10, Max = 10, Default = 0},
        Suffix = " studs",
        Callback = function(val)
            PartsConfig.OffsetY = tonumber(val) or 0
        end
    })

    partsSection:Slider({
        Flag = "PartsLifetime",
        Title = "Part存在时间",
        Step = 0.01,
        Value = {Min = 0.05, Max = 0.5, Default = 0.1},
        Suffix = " sec",
        Callback = function(val)
            PartsConfig.PartLifetime = tonumber(val) or 0.1
        end
    })

    partsSection:Slider({
        Flag = "PartsSpawnInterval",
        Title = "生成间隔",
        Step = 0.005,
        Value = {Min = 0.005, Max = 0.1, Default = 0.01},
        Suffix = " sec",
        Callback = function(val)
            PartsConfig.SpawnInterval = tonumber(val) or 0.01
        end
    })

    partsSection:Slider({
        Flag = "PartsSpawnDuration",
        Title = "Parts生成持续时间",
        Step = 0.05,
        Value = {Min = 0.1, Max = 1.0, Default = 0.3},
        Suffix = " sec",
        Callback = function(val)
            PartsConfig.SpawnDuration = tonumber(val) or 0.3
        end
    })

    local antiBaitZoneSection = Tabs.AutoBlock:Section({
        Title = "反诱饵区域设置",
        Icon = "square",
        Opened = false,
    })

    antiBaitZoneSection:Toggle({
        Flag = "AutoBlockZoneVisualization",
        Title = "显示自动格挡区域边框",
        Default = true,
        Callback = function(state)
            ZoneConfig.visualizationEnabled = state
            manageAllZones()
        end
    })

    antiBaitZoneSection:Slider({
        Flag = "AutoBlockZoneVisibility",
        Title = "显示自动格挡区域透明度",
        Step = 0.05,
        Value = {Min = 0, Max = 1, Default = 0.4},
        Suffix = "",
        Callback = function(val)
            ZoneConfig.visibility = tonumber(val) or 0.4
            manageAllZones()
        end
    })

    antiBaitZoneSection:Slider({
        Flag = "AutoBlockZoneHeight",
        Title = "显示自动格挡区域高度",
        Step = 0.5,
        Value = {Min = 1, Max = 15, Default = 7},
        Suffix = " studs",
        Callback = function(val)
            ZoneConfig.height = tonumber(val) or 7
        end
    })

    antiBaitZoneSection:Slider({
        Flag = "AutoBlockZoneCenterOffset",
        Title = "显示自动格挡区域中心偏移",
        Step = 0.5,
        Value = {Min = -10, Max = 10, Default = 0},
        Suffix = " studs",
        Callback = function(val)
            ZoneConfig.centerOffset = tonumber(val) or 0
        end
    })

    antiBaitZoneSection:Colorpicker({
        Flag = "AutoBlockZoneColor",
        Title = "自动格挡区域颜色",
        Default = Color3.fromRGB(180, 0, 255),
        Callback = function(color)
            ZoneConfig.color = color
            manageAllZones()
        end
    })

    antiBaitZoneSection:Colorpicker({
        Flag = "AutoBlockZoneOutlineColor",
        Title = "自动格挡区域轮廓颜色",
        Default = Color3.fromRGB(255, 255, 255),
        Callback = function(color)
            ZoneConfig.outlineColor = color
            manageAllZones()
        end
    })

local zoneSmoothingSection = Tabs.AutoBlock:Section({
    Title = "区域平滑[防曲线攻击]",
    Icon = "git-branch",
    Desc = "让防护区域更加平滑",
    Opened = false,
})

zoneSmoothingSection:Toggle({
    Flag = "ZoneSmoothingEnabled",
    Title = "开启区域平滑",
    Default = false,
    Callback = function(state)
        ZoneConfig.smoothingEnabled = state
    end
})

zoneSmoothingSection:Slider({
    Flag = "ZoneSmoothingStrength",
    Title = "平滑强度",
    Step = 0.5,
    Value = {Min = 1, Max = 10, Default = 3},
    Suffix = " studs",
    Callback = function(val)
        ZoneConfig.smoothingStrength = tonumber(val) or 3
    end
})

local facingSection = Tabs.AutoBlock:Section({
    Title = "朝向检测",
    Icon = "eye",
    Desc = "玩家朝向相关设置",
    Opened = false,
})

facingSection:Dropdown({
    Flag = "AutoBlockFacingMode",
    Title = "朝向检测模式",
    Values = {"Standard", "No Check", "Player Facing Killer", "Killer Facing Player"},
        Multi = false,
        Default = "Standard",
        Callback = function(choice)
            FacingConfig.mode = choice
        end
    })

facingSection:Slider({
    Flag = "AutoBlockFacingAngle",
    Title = "朝向角度",
    Step = 1,
    Value = {Min = 1, Max = 180, Default = 90},
    Suffix = " deg",
    Callback = function(val)
        FacingConfig.angle = tonumber(val) or 90
    end
})

facingSection:Toggle({
    Flag = "AutoBlockShowPlayerFacing",
    Title = "显示玩家朝向屠夫指示器",
    Default = false,
    Callback = function(state)
        FacingConfig.playerFacingVisEnabled = state
        if state and Config.autoBlockOn then
            createPlayerFacingVisualization()
        else
            destroyPlayerFacingVisualization()
        end
    end
})

facingSection:Colorpicker({
    Flag = "AutoBlockPlayerFacingColor",
    Title = "玩家朝向指示器颜色",
    Default = Color3.fromRGB(0, 0, 139),
    Callback = function(color)
        FacingConfig.playerFacingColor = color
    end
})

facingSection:Slider({
    Flag = "PlayerFacingTracerOffsetY",
    Title = "玩家指示器Y轴偏移",
    Step = 0.5,
    Value = {Min = -5, Max = 5, Default = 1},
    Suffix = " studs",
    Callback = function(val)
        FacingConfig.playerTracerOffset = Vector3.new(0, tonumber(val) or 1, 0)
    end
})

facingSection:Toggle({
    Flag = "AutoBlockShowKillerLooking",
    Title = "显示屠夫看向你的指示器",
    Default = false,
    Callback = function(state)
        FacingConfig.killerLookingVisEnabled = state
        if state and Config.autoBlockOn then
            createKillerLookingVisualization()
        else
            destroyKillerLookingVisualization()
        end
    end
})

facingSection:Colorpicker({
    Flag = "AutoBlockKillerLookingColor",
    Title = "屠夫朝向指示器颜色",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        FacingConfig.killerLookingColor = color
    end
})

facingSection:Slider({
    Flag = "KillerLookingTracerOffsetY",
    Title = "屠夫指示器Y轴偏移",
    Step = 0.5,
    Value = {Min = -5, Max = 5, Default = -1},
    Suffix = " studs",
    Callback = function(val)
        FacingConfig.killerTracerOffset = Vector3.new(0, tonumber(val) or -1, 0)
    end
})

local antiBaitSection = Tabs.AutoBlock:Section({
    Title = "防诱饵保护",
    Icon = "shield-alert",
    Opened = false,
})

antiBaitSection:Toggle({
    Flag = "WallCheck",
    Title = "墙体检测",
    Default = false,
    Callback = function(state)
        WallCheckConfig.enabled = state
        if not state then
            destroyWallCheckVisualization()
        end
    end
})

antiBaitSection:Toggle({
    Flag = "WallCheckVisualization",
    Title = "墙体检测可视化",
    Default = false,
    Callback = function(state)
        WallCheckConfig.visualizationEnabled = state
        if state and Config.autoBlockOn then
            createWallCheckVisualization()
        else
            destroyWallCheckVisualization()
        end
    end
})

antiBaitSection:Colorpicker({
    Flag = "WallCheckColor",
    Title = "墙体检测颜色",
    Default = Color3.fromRGB(255, 100, 100),
    Callback = function(color)
        WallCheckConfig.color = color
    end
})

antiBaitSection:Toggle({
    Flag = "AntiWrongBlock",
    Title = "防错误格挡",
    Default = false,
    Callback = function(state)
        AntiWrongBlockConfig.enabled = state
        if not state then
            destroyAntiWrongBlockVisualization()
        end
    end
})

antiBaitSection:Slider({
    Flag = "AntiWrongBlockTolerance",
    Title = "目标容错值",
    Step = 0.01,
    Value = {Min = 0.01, Max = 0.5, Default = 0.15},
    Suffix = "",
    Callback = function(val)
        AntiWrongBlockConfig.tolerance = tonumber(val) or 0.15
    end
})

antiBaitSection:Slider({
    Flag = "AntiWrongBlockRange",
    Title = "其他玩家检测范围",
    Step = 1,
    Value = {Min = 5, Max = 30, Default = 15},
    Suffix = " studs",
    Callback = function(val)
        AntiWrongBlockConfig.range = tonumber(val) or 15
    end
})

antiBaitSection:Toggle({
    Flag = "AntiWrongBlockVisualization",
    Title = "防错误格挡可视化",
    Default = false,
    Callback = function(state)
        AntiWrongBlockConfig.visualizationEnabled = state
        if state and Config.autoBlockOn then
            createAntiWrongBlockVisualization()
        else
            destroyAntiWrongBlockVisualization()
        end
    end
})

antiBaitSection:Colorpicker({
    Flag = "AntiWrongBlockColor",
    Title = "防错误格挡颜色",
    Default = Color3.fromRGB(255, 255, 0),
    Callback = function(color)
        AntiWrongBlockConfig.color = color
    end
})

antiBaitSection:Toggle({
    Flag = "AntiSpinBait",
    Title = "防旋转诱饵",
    Default = false,
    Callback = function(state)
        AntiSpinBaitConfig.enabled = state
        if not state then
            killerRotationData = {}
            activeSpinChecks = {}
            destroyAntiSpinBaitVisualization()
        end
    end
})

antiBaitSection:Dropdown({
    Flag = "AntiSpinBaitMode",
    Title = "防旋转诱饵模式",
    Values = {"Always", "Only when Sound"},
    Multi = false,
    Default = "Always",
    Callback = function(choice)
        AntiSpinBaitConfig.mode = choice
        activeSpinChecks = {}
    end
})

antiBaitSection:Slider({
    Flag = "AntiSpinBaitMaxAngularSpeed",
    Title = "最大角速度",
    Step = 10,
    Value = {Min = 50, Max = 1000, Default = 300},
    Suffix = " В°/sec",
    Callback = function(val)
        AntiSpinBaitConfig.maxAngularSpeed = tonumber(val) or 300
    end
})

antiBaitSection:Slider({
    Flag = "AntiSpinBaitAngularHistoryDuration",
    Title = "角度记录时长",
    Step = 0.01,
    Value = {Min = 0.01, Max = 0.5, Default = 0.1},
    Suffix = " sec",
    Callback = function(val)
        AntiSpinBaitConfig.angularHistoryDuration = tonumber(val) or 0.1
    end
})

antiBaitSection:Slider({
    Flag = "AntiSpinBaitMaxAngle",
    Title = "最大总旋转角度",
    Step = 1,
    Value = {Min = 1, Max = 360, Default = 100},
    Suffix = " deg",
    Callback = function(val)
        AntiSpinBaitConfig.maxAngle = tonumber(val) or 100
    end
})

antiBaitSection:Slider({
    Flag = "AntiSpinBaitCheckDuration",
    Title = "旋转检测时长",
    Step = 0.01,
    Value = {Min = 0.01, Max = 2.0, Default = 0.5},
    Suffix = " sec",
    Callback = function(val)
        AntiSpinBaitConfig.checkDuration = tonumber(val) or 0.5
    end
})

antiBaitSection:Toggle({
    Flag = "AntiSpinBaitPostAttack",
    Title = "攻击后朝向检测",
    Default = false,
    Callback = function(state)
        AntiSpinBaitConfig.postAttackEnabled = state
    end
})

antiBaitSection:Slider({
    Flag = "AntiSpinBaitPostAttackDelay",
    Title = "攻击后检测延迟",
    Step = 0.005,
    Value = {Min = 0.01, Max = 0.1, Default = 0.03},
    Suffix = " sec",
    Callback = function(val)
        AntiSpinBaitConfig.postAttackDelay = tonumber(val) or 0.03
    end
})

antiBaitSection:Toggle({
    Flag = "AntiSpinBaitVisualization",
    Title = "防旋转诱饵可视化",
    Default = false,
    Callback = function(state)
        AntiSpinBaitConfig.visualizationEnabled = state
        if state and Config.autoBlockOn then
            createAntiSpinBaitVisualization()
        else
            destroyAntiSpinBaitVisualization()
        end
    end
})

antiBaitSection:Colorpicker({
    Flag = "AntiSpinBaitColor",
    Title = "防旋转诱饵颜色",
    Default = Color3.fromRGB(255, 165, 0),
    Callback = function(color)
        AntiSpinBaitConfig.color = color
    end
})

antiBaitSection:Toggle({
    Flag = "FallingDetection",
    Title = "垂直移动检测",
    Default = false,
    Callback = function(state)
        FallingConfig.enabled = state
        if not state then
            killerFallingData = {}
        end
    end
})

antiBaitSection:Slider({
    Flag = "FallingYThreshold",
    Title = "Y轴变化阈值",
    Step = 0.1,
    Value = {Min = 0.1, Max = 5, Default = 0.5},
    Suffix = " studs",
    Callback = function(val)
        FallingConfig.yThreshold = tonumber(val) or 0.5
    end
})

antiBaitSection:Slider({
    Flag = "FallingZoneOffsetDown",
    Title = "下落区域向下偏移",
    Step = 0.5,
    Value = {Min = 0, Max = 15, Default = 3},
    Suffix = " studs",
    Callback = function(val)
        FallingConfig.zoneOffsetDown = tonumber(val) or 3
    end
})

antiBaitSection:Slider({
    Flag = "FallingZoneOffsetUp",
    Title = "上升区域向上偏移",
    Step = 0.5,
    Value = {Min = 0, Max = 15, Default = 0},
    Suffix = " studs",
    Callback = function(val)
        FallingConfig.zoneOffsetUp = tonumber(val) or 0
    end
})

antiBaitSection:Toggle({
    Flag = "NoCheckZone",
    Title = "免检测区域[立即格挡]",
    Default = false,
    Callback = function(state)
        NoCheckZoneConfig.enabled = state
        manageNoCheckZones()
    end
})

antiBaitSection:Toggle({
    Flag = "NoCheckZoneVisualization",
    Title = "免检测区域可视化",
    Default = true,
    Callback = function(state)
        NoCheckZoneConfig.visualizationEnabled = state
        manageNoCheckZones()
    end
})

antiBaitSection:Slider({
    Flag = "NoCheckZoneHeight",
    Title = "免检测区域高度",
    Step = 0.5,
    Value = {Min = 1, Max = 15, Default = 5},
    Suffix = " studs",
    Callback = function(val)
        NoCheckZoneConfig.height = tonumber(val) or 5
        manageNoCheckZones()
    end
})

antiBaitSection:Slider({
    Flag = "NoCheckZoneRange",
    Title = "免检测区域范围",
    Step = 0.5,
    Value = {Min = 1, Max = 20, Default = 5},
    Suffix = " studs",
    Callback = function(val)
        NoCheckZoneConfig.range = tonumber(val) or 5
        manageNoCheckZones()
    end
})

antiBaitSection:Colorpicker({
    Flag = "NoCheckZoneColor",
    Title = "免检测区域颜色",
    Default = Color3.fromRGB(0, 255, 0),
    Callback = function(color)
        NoCheckZoneConfig.color = color
        manageNoCheckZones()
    end
})

antiBaitSection:Toggle({
    Flag = "WaitSomeUntilBlock",
    Title = "延迟格挡",
    Default = false,
    Callback = function(state)
        WaitConfig.enabled = state
    end
})

antiBaitSection:Slider({
    Flag = "WaitSomeUntilBlockDuration",
    Title = "默认延迟时长",
    Step = 0.01,
    Value = {Min = 0.01, Max = 1, Default = 0.3},
    Suffix = " sec",
    Callback = function(val)
        WaitConfig.duration = tonumber(val) or 0.3
    end
})

antiBaitSection:Slider({
    Flag = "WaitSomeCheckInterval",
    Title = "延迟检测间隔",
    Step = 0.01,
    Value = {Min = 0.01, Max = 0.2, Default = 0.05},
    Suffix = " sec",
    Callback = function(val)
        WaitConfig.checkInterval = tonumber(val) or 0.05
    end
})

local killerRunsSection = Tabs.AutoBlock:Section({
    Title = "屠夫奔跑时的防护设置[防诱饵]",
    Icon = "zap",
    Opened = false,
})

killerRunsSection:Slider({
    Flag = "AutoBlockRunZoneLength",
    Title = "区域长度",
    Step = 0.5,
    Value = {Min = 1, Max = 30, Default = 14},
    Suffix = " studs",
    Callback = function(val)
        ZoneConfig.runLength = tonumber(val) or 14
    end
})

killerRunsSection:Slider({
    Flag = "AutoBlockRunZoneWidth",
    Title = "区域宽度",
    Step = 0.5,
    Value = {Min = 1, Max = 15, Default = 7},
    Suffix = " studs",
    Callback = function(val)
        ZoneConfig.runWidth = tonumber(val) or 7
    end
})

local killerWalksSection = Tabs.AutoBlock:Section({
    Title = "屠夫行走设置(防诱饵)",
    Icon = "footprints",
    Desc = "屠夫行走时的防护区域大小",
    Opened = false,
})

killerWalksSection:Slider({
    Flag = "AutoBlockWalkZoneLength",
    Title = "区域长度",
    Step = 0.5,
    Value = {Min = 1, Max = 30, Default = 12},
    Suffix = " studs",
    Callback = function(val)
        ZoneConfig.walkLength = tonumber(val) or 12
    end
})

killerWalksSection:Slider({
    Flag = "AutoBlockWalkZoneWidth",
    Title = "区域宽度",
    Step = 0.5,
    Value = {Min = 1, Max = 15, Default = 6},
    Suffix = " studs",
    Callback = function(val)
        ZoneConfig.walkWidth = tonumber(val) or 6
    end
})

local killerStandsSection = Tabs.AutoBlock:Section({
    Title = "屠夫静止时防护区域设置[防诱饵]",
    Icon = "pause",
    Opened = false,
})

killerStandsSection:Slider({
    Flag = "AutoBlockStandZoneLength",
    Title = "区域长度",
    Step = 0.5,
    Value = {Min = 1, Max = 30, Default = 10},
    Suffix = " studs",
    Callback = function(val)
        ZoneConfig.standLength = tonumber(val) or 10
    end
})

killerStandsSection:Slider({
    Flag = "AutoBlockStandZoneWidth",
    Title = "区域宽度",
    Step = 0.5,
    Value = {Min = 1, Max = 15, Default = 5},
    Suffix = " studs",
    Callback = function(val)
        ZoneConfig.standWidth = tonumber(val) or 5
    end
})

local waitDurationsSection = Tabs.AutoBlock:Section({
    Title = "单独屠夫格挡延迟设置",
    Icon = "clock",
    Opened = false,
})

waitDurationsSection:Slider({
    Flag = "WaitDuration_Nosferatu",
    Title = "吸血鬼",
    Step = 0.01,
    Value = {Min = 0.01, Max = 1, Default = 0.3},
    Suffix = " sec",
    Callback = function(val)
        WaitConfig.killerDurations["Nosferatu"] = tonumber(val) or 0.3
    end
})

waitDurationsSection:Slider({
    Flag = "WaitDuration_Jason",
    Title = "杰森",
    Step = 0.01,
    Value = {Min = 0.01, Max = 1, Default = 0.3},
    Suffix = " sec",
    Callback = function(val)
        WaitConfig.killerDurations["Jason"] = tonumber(val) or 0.3
    end
})

waitDurationsSection:Slider({
    Flag = "WaitDuration_Slasher",
    Title = "屠夫Slasher",
    Step = 0.01,
    Value = {Min = 0.01, Max = 1, Default = 0.3},
    Suffix = " sec",
    Callback = function(val)
        WaitConfig.killerDurations["Slasher"] = tonumber(val) or 0.3
    end
})

waitDurationsSection:Slider({
    Flag = "WaitDuration_JohnDoe",
    Title = "John Doe",
    Step = 0.01,
    Value = {Min = 0.01, Max = 1, Default = 0.3},
    Suffix = " sec",
    Callback = function(val)
        WaitConfig.killerDurations["John Doe"] = tonumber(val) or 0.3
    end
})

waitDurationsSection:Slider({
    Flag = "WaitDuration_C00lkid",
    Title = "C00lkid",
    Step = 0.01,
    Value = {Min = 0.01, Max = 1, Default = 0.3},
    Suffix = " sec",
    Callback = function(val)
        WaitConfig.killerDurations["C00lkid"] = tonumber(val) or 0.3
    end
})

waitDurationsSection:Slider({
    Flag = "WaitDuration_Noli",
    Title = "Noli",
    Step = 0.01,
    Value = {Min = 0.01, Max = 1, Default = 0.3},
    Suffix = " sec",
    Callback = function(val)
        WaitConfig.killerDurations["Noli"] = tonumber(val) or 0.3
    end
})

waitDurationsSection:Slider({
    Flag = "WaitDuration_1x1x1x1",
    Title = "1x1x1x1",
    Step = 0.01,
    Value = {Min = 0.01, Max = 1, Default = 0.3},
    Suffix = " sec",
    Callback = function(val)
        WaitConfig.killerDurations["1x1x1x1"] = tonumber(val) or 0.3
    end
})

waitDurationsSection:Slider({
    Flag = "WaitDuration_Sixer",
    Title = "Sixer",
    Step = 0.01,
    Value = {Min = 0.01, Max = 1, Default = 0.3},
    Suffix = " sec",
    Callback = function(val)
        WaitConfig.killerDurations["Sixer"] = tonumber(val) or 0.3
    end
})

local addSoundIDsSection = Tabs.AutoBlock:Section({
    Title = "添加自定义音效ID用于音频检测",
    Icon = "volume-2",
    Opened = false,
})

addSoundIDsSection:Paragraph({
    Title = "音效ID管理",
    Desc = string.format("默认: %d | 自定义: %d | 总计: %d", countDefaultSoundIDs(), countCustomSoundIDs(), countSoundIDs())
})

addSoundIDsSection:Input({
    Title = "新增音效ID",
    Default = "",
    Placeholder = "输入音效ID(仅数字)",
    Callback = function(text)
        newSoundIdText = text
    end
})

addSoundIDsSection:Button({
    Title = "添加新音效ID",
    Callback = function()
        local id = newSoundIdText:match("%d+")
        if not id then return end
        if defaultAutoBlockSounds[id] or customUserIDs[id] then return end
        customUserIDs[id] = true
        mergeSoundIDs()
        pcall(saveSoundIdsToFile)
    end
})

addSoundIDsSection:Button({
    Title = "清空所有自定义音效ID",
    Callback = function()
        pcall(resetCustomSoundIds)
    end
})

addSoundIDsSection:Button({
    Title = "在控制台显示全部音效ID",
    Callback = function()

        for id in pairs(defaultAutoBlockSounds) do

        end

        for id in pairs(customUserIDs) do
            if not defaultAutoBlockSounds[id] then

            end
        end

    end
})

local addAnimIDsSection = Tabs.AutoBlock:Section({
    Title = "添加自定义动画ID用于动画检测",
    Icon = "activity",
    Opened = false,
})

addAnimIDsSection:Paragraph({
    Title = "动画ID管理",
    Desc = string.format("默认: %d | 自定义: %d | 总计: %d", countDefaultAnimationIDs(), countCustomAnimationIDs(), countAnimationIDs())
})

addAnimIDsSection:Input({
    Title = "新增动画ID",
    Default = "",
    Placeholder = "输入动画ID(仅数字)",
    Callback = function(text)
        newAnimIdText = text
    end
})

addAnimIDsSection:Button({
    Title = "添加新动画ID",
    Callback = function()
        local id = newAnimIdText:match("%d+")
        if not id then return end
        if defaultAutoBlockAnimations[id] or customUserAnimationIDs[id] then return end
        customUserAnimationIDs[id] = true
        mergeAnimationIDs()
        pcall(saveAnimationIdsToFile)
    end
})

addAnimIDsSection:Button({
    Title = "清空所有自定义动画ID",
    Callback = function()
        pcall(resetCustomAnimationIds)
    end
})

addAnimIDsSection:Button({
    Title = "在控制台显示全部动画ID",
    Callback = function()

        for id in pairs(defaultAutoBlockAnimations) do

        end

        for id in pairs(customUserAnimationIDs) do
            if not defaultAutoBlockAnimations[id] then

            end
        end

    end
})

local keybindsSection = Tabs.AutoBlock:Section({
    Title = "自动格挡快捷键设置",
    Icon = "keyboard",
    Opened = false,
})

keybindsSection:Input({
    Flag = "AutoBlockToggleKeybind",
    Title = "开关快捷键",
    Default = "F1",
    Placeholder = "输入按键(例如F1)",
    Callback = function(text)
        local key = Enum.KeyCode[text:upper()]
        if key then
            toggleKeybind = key
        end
    end
})

keybindsSection:Toggle({
    Flag = "ShowToggleButton",
    Title = "显示界面开关按钮",
    Default = false,
    Callback = function(state)
        showToggleButton = state
        screenGui.Enabled = state
    end
})

    local instructionsSection = Tabs.AutoBlock:Section({
        Title = "讲述如何使用自动格挡",
        Icon = "book",
        Desc = "",
        Opened = false,
    })

    instructionsSection:Paragraph({
        Title = "检测方法",
        Desc = [[音频检测:触发杀手攻击声音;动画检测:触发杀手攻击动画，两者同时工作如果一个方法检测到攻击，即使另一个方法没有ID，也会触发阻止]]
    })

    instructionsSection:Paragraph({
        Title = "自动格挡模式",
        Desc = [[普通:当范围内的杀手攻击时，瞬间格挡;零件:在杀手面前产生检测零件，触摸=阻止;反诱饵:当杀手攻击时，只有当你在区域内时才能阻挡]]
    })

    instructionsSection:Paragraph({
        Title = "反诱饵保护",
        Desc = [[墙壁检查:不会阻挡你和杀手之间的墙;反错误阻挡:如果杀手以其他玩家为目标，则不会阻挡;反旋转诱饵:检测快速旋转，使用“ Only When Sound ”模式仅在攻击期间进行检查;无检查区:非常接近时立即阻挡。]]
    })

    instructionsSection:Paragraph({
        Title = "面向可视化",
        Desc = [[玩家面对杀手:显示从你到杀手的线条[向上偏移];杀手看着你:显示从杀手到你的追踪器[向下偏移];不同的Y偏移使它们可以区分]]
    })


end


    end
    })


do


local visualSection = Tabs.Misc:Section({
    Title = "透视设置",
    Icon = "eye",
    Opened = false,
})
local fullbrightActive = false
local originalSettings = {}
local fullbrightLoop = nil
local function applyFullbright()
    if not fullbrightActive then return end
    local Lighting = game:GetService("Lighting")
    Lighting.Ambient = Color3.new(1,1,1)
    Lighting.OutdoorAmbient = Color3.new(1,1,1)
    Lighting.Brightness = 2
    Lighting.ClockTime = 12
end
local function revertFullbright()
    local Lighting = game:GetService("Lighting")
    if originalSettings.Ambient then
        Lighting.Ambient = originalSettings.Ambient
        Lighting.OutdoorAmbient = originalSettings.OutdoorAmbient
        Lighting.Brightness = originalSettings.Brightness
        Lighting.ClockTime = originalSettings.ClockTime
    end
end
visualSection:Toggle({
    Flag = "Fullbright",
    Title = "Fullbright",
    Default = false,
    Callback = function(state)
        fullbrightActive = state
        local Lighting = game:GetService("Lighting")
        if fullbrightActive then
            if not originalSettings.Ambient then
                originalSettings.Ambient = Lighting.Ambient
                originalSettings.OutdoorAmbient = Lighting.OutdoorAmbient
                originalSettings.Brightness = Lighting.Brightness
                originalSettings.ClockTime = Lighting.ClockTime
            end
            if fullbrightLoop then
                task.cancel(fullbrightLoop)
            end
            fullbrightLoop = task.spawn(function()
                while fullbrightActive do
                    applyFullbright()
                    task.wait(5)
                end
            end)
        else
            if fullbrightLoop then
                task.cancel(fullbrightLoop)
                fullbrightLoop = nil
            end
            revertFullbright()
        end
    end
})
local antiFogActive = false
local disabledFogElements = {}
local antiFogLoop = nil
visualSection:Toggle({
    Flag = "AntiFog",
    Title = "防雾",
    Default = false,
    Callback = function(state)
        antiFogActive = state
        local Lighting = game:GetService("Lighting")
        if antiFogActive then
            if antiFogLoop then
                task.cancel(antiFogLoop)
            end
            antiFogLoop = task.spawn(function()
                while antiFogActive do
                    disabledFogElements = {}
                    for _, v in ipairs(Lighting:GetChildren()) do
                        if v:IsA("Atmosphere") or v:IsA("Sky") then
                            table.insert(disabledFogElements, v)
                            v.Parent = nil
                        end
                    end
                    task.wait(5)
                end
            end)
        else
            if antiFogLoop then
                task.cancel(antiFogLoop)
                antiFogLoop = nil
            end
            for _, v in ipairs(disabledFogElements) do
                if v then
                    v.Parent = Lighting
                end
            end
            disabledFogElements = {}
        end
    end
})

end

do

local chatUISection = Tabs.Misc:Section({
    Title = "聊天和用户界面",
    Icon = "message-square",
    Opened = false,
})
chatUISection:Button({
    Title = "聊天可见性",
    Callback = function()
        local TextChatService = game:GetService("TextChatService")
        if TextChatService:FindFirstChild("ChatWindowConfiguration") and TextChatService:FindFirstChild("ChatInputBarConfiguration") then
            TextChatService.ChatWindowConfiguration.Enabled = true
            TextChatService.ChatInputBarConfiguration.Enabled = true
        end
    end
})
local ActiveRemoveEffects = false
local removeEffectsLoop = nil
local effectNames = {
    "BlurEffect", "ColorCorrectionEffect", "BloomEffect", "SunRaysEffect",
    "DepthOfFieldEffect", "ScreenFlash", "HitEffect", "DamageOverlay",
    "BloodEffect", "Vignette", "BlackScreen", "WhiteScreen", "ShockEffect",
    "Darkness", "JumpScare", "LowHealthOverlay", "Flashbang", "FadeEffect"
}
local effectClasses = {
    "BlurEffect",
    "BloomEffect",
    "SunRaysEffect",
    "DepthOfFieldEffect",
    "ColorCorrectionEffect"
}
local function removeEffects()
    local Lighting = game:GetService("Lighting")
    local Players = game:GetService("Players")
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    for _, obj in pairs(Lighting:GetDescendants()) do
        if table.find(effectNames, obj.Name) or table.find(effectClasses, obj.ClassName) then
            obj:Destroy()
        end
    end
    for _, obj in pairs(PlayerGui:GetDescendants()) do
        if table.find(effectNames, obj.Name) then
            obj:Destroy()
        elseif obj:IsA("ScreenGui") or obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
            if obj:FindFirstChildWhichIsA("ImageLabel") or obj:FindFirstChildWhichIsA("Frame") then
                if table.find(effectNames, obj.Name) or obj.Name:lower():find("overlay") or obj.Name:lower():find("effect") then
                    obj:Destroy()
                end
            end
        end
    end
end
chatUISection:Toggle({
    Flag = "RemoveEffects",
    Title = "删除效果",
    Default = true,
    Callback = function(state)
        ActiveRemoveEffects = state
        if state then
            if removeEffectsLoop then
                task.cancel(removeEffectsLoop)
            end
            removeEffectsLoop = task.spawn(function()
                while ActiveRemoveEffects do
                    removeEffects()
                    task.wait(5)
                end
            end)
        else
            if removeEffectsLoop then
                task.cancel(removeEffectsLoop)
                removeEffectsLoop = nil
            end
        end
    end
})

end

do

local antiSection = Tabs.Misc:Section({
    Title = "多种防护",
    Icon = "shield",
    Opened = false,
})
local Survivors = workspace:WaitForChild("Players"):WaitForChild("Survivors")
local RunService = game:GetService("RunService")
local AntiSlowConfigs = {
    Slowness = {Values = {"SlowedStatus"}, Connection = nil, Enabled = false},
    Skills = {Values = {"StunningKiller", "EatFriedChicken", "GuestBlocking", "PunchAbility", "SubspaceTripmine",
                        "TaphTripwire", "PlasmaBeam", "SpawnProtection", "c00lgui", "ShootingGun",
                        "TwoTimeStab", "TwoTimeCrouching", "DrinkingCola", "DrinkingSlateskin",
                        "SlateskinStatus", "EatingGhostburger"}, Connection = nil, Enabled = false},
    Items = {Values = {"BloxyColaItem", "Medkit"}, Connection = nil, Enabled = false},
    Emotes = {Values = {"Emoting"}, Connection = nil, Enabled = false},
    Builderman = {Values = {"DispenserConstruction", "SentryConstruction"}, Connection = nil, Enabled = false}
}
local function hideSlownessUI()
    local mainUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MainUI")
    if mainUI then
        local statusContainer = mainUI:FindFirstChild("StatusContainer")
        if statusContainer then
            local slownessUI = statusContainer:FindFirstChild("Slowness")
            if slownessUI then
                slownessUI.Visible = false
            end
        end
    end
end
local function handleAntiSlow(survivor, config)
    if survivor:GetAttribute("Username") ~= game:GetService("Players").LocalPlayer.Name then return end
    local function onRenderStep()
        if not survivor.Parent or not config.Enabled then return end
        local speedMultipliers = survivor:FindFirstChild("SpeedMultipliers")
        if speedMultipliers then
            for _, valName in ipairs(config.Values) do
                local val = speedMultipliers:FindFirstChild(valName)
                if val and val:IsA("NumberValue") and val.Value ~= 1 then
                    val.Value = 1
                end
            end
        end
        hideSlownessUI()
    end
    config.Connection = RunService.RenderStepped:Connect(onRenderStep)
end
local function startAntiSlow(config)
    config.Enabled = true
    for _, survivor in pairs(Survivors:GetChildren()) do
        handleAntiSlow(survivor, config)
    end
    Survivors.ChildAdded:Connect(function(child)
        task.wait(0.1)
        handleAntiSlow(child, config)
    end)
end
local function stopAntiSlow(config)
    config.Enabled = false
    if config.Connection then
        config.Connection:Disconnect()
        config.Connection = nil
    end
end
antiSection:Toggle({
    Flag = "AntiSlow",
    Title = "反减速",
    Default = false,
    Callback = function(state)
        for _, config in pairs(AntiSlowConfigs) do
            if state then
                startAntiSlow(config)
            else
                stopAntiSlow(config)
            end
        end
    end
})
antiSection:Toggle({
    Flag = "AntiStun",
    Title = "反击晕    ",
    Default = false,
    Callback = function(state)
        local localPlayer = game:GetService("Players").LocalPlayer
        getgenv().Toggles = getgenv().Toggles or {}
        getgenv().Toggles.AntiStun = {Value = state}
        if state then
            task.spawn(function()
                while getgenv().Toggles.AntiStun.Value and task.wait() do
                    if localPlayer.Character and localPlayer.Character:FindFirstChild("SpeedMultipliers") then
                        local stunned = localPlayer.Character.SpeedMultipliers:FindFirstChild("Stunned")
                        if stunned then
                            stunned.Value = 1
                        end
                    end
                end
            end)
        end
    end
})

end

do


local specialAbilitiesSection = Tabs.Misc:Section({
    Title = "特别的",
    Icon = "zap",
    Opened = false,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local animationId = "75804462760596"
local animationSpeed = 0
local loopRunning = false
local loopThread
local currentAnim = nil
function StartInvisibility()
    loopRunning = true
    local speaker = LocalPlayer
    local humanoid = speaker.Character and speaker.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R6 then return end
    loopThread = task.spawn(function()
        while loopRunning do
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://" .. animationId
            local loadedAnim = humanoid:LoadAnimation(anim)
            currentAnim = loadedAnim
            loadedAnim.Looped = false
            loadedAnim:Play()
            loadedAnim:AdjustSpeed(animationSpeed)
            task.wait(0.000001)
        end
    end)
end
function StopInvisibility()
    loopRunning = false
    if loopThread then
        task.cancel(loopThread)
        loopThread = nil
    end
    if currentAnim then
        currentAnim:Stop()
        currentAnim = nil
    end
    local speaker = LocalPlayer
    local humanoid = speaker.Character and (speaker.Character:FindFirstChildOfClass("Humanoid") or speaker.Character:FindFirstChildOfClass("AnimationController"))
    if humanoid then
        for _, v in pairs(humanoid:GetPlayingAnimationTracks()) do
            v:AdjustSpeed(100000)
        end
    end
    local animateScript = speaker.Character and speaker.Character:FindFirstChild("Animate")
    if animateScript then
        animateScript.Disabled = true
        animateScript.Disabled = false
    end
end
specialAbilitiesSection:Toggle({
    Flag = "Invisibility",
    Title = "隐形[仅限R6使用]",
    Default = false,
    Callback = function(state)
        if state then
            StartInvisibility()
        else
            StopInvisibility()
        end
    end
})


end

do


local popupSection = Tabs.Misc:Section({
    Title = "自动关闭弹出窗口",
    Icon = "circle-off",
    Opened = false,
})
local AutoCloseEnabled = false
local AutoCloseInterval = 0.01
local function autoClosePopups()
    task.spawn(function()
        while task.wait(AutoCloseInterval) do
            if AutoCloseEnabled then
                pcall(function()
                    local Players = game:GetService("Players")
                    local player = Players.LocalPlayer
                    local temp = player.PlayerGui:FindFirstChild("TemporaryUI")
                    if temp and temp:FindFirstChild("1x1x1x1Popup") then
                        temp["1x1x1x1Popup"]:Destroy()
                    end
                end)
            end
        end
    end)
end
popupSection:Toggle({
    Flag = "AutoClosePopups",
    Title = "自动关闭1x1x1x1窗口",
    Default = false,
    Callback = function(state)
        AutoCloseEnabled = state
    end
})
popupSection:Slider({
    Flag = "AutoCloseInterval",
    Title = "检查间隔",
    Step = 0.01,
    Value = {Min = 0.01, Max = 1, Default = 0.01},
    Suffix = " sec",
    Callback = function(val)
        AutoCloseInterval = tonumber(val) or 0.01
    end
})
autoClosePopups()


end


do

local noliSection = Tabs.Misc:Section({
    Title = "Noli技能",
    Icon = "ghost",
    Opened = false,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Remote
pcall(function()
    Remote = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
end)
getgenv()._oldFireServer = getgenv()._oldFireServer or nil
getgenv()._VoidRushBypass = getgenv()._VoidRushBypass or false
if Remote and not getgenv()._oldFireServer then
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if self == Remote and method == "FireServer" then
            if args[1] == LocalPlayer.Name .. "VoidRushCollision" then
                if getgenv()._VoidRushBypass then
                    return
                end
            end
        end
        return old(self, ...)
    end)
    getgenv()._oldFireServer = old
end

noliSection:Toggle({
    Flag = "VoidRushNoCrash",
    Title = "虚空疾行不死机",
    Default = false,
    Callback = function(state)
        getgenv()._VoidRushBypass = state
    end
})

local RunService = game:GetService("RunService")
local voidrushcontrol = false
local ORIGINAL_DASH_SPEED = 60
local isOverrideActive = false
local connection
local humanoid, rootPart

local function setupCharacter(character)
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
end
if LocalPlayer.Character then
    setupCharacter(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(setupCharacter)

noliSection:Toggle({
    Flag = "VoidRushFullControl",
    Title = "虚空冲完全控制",
    Default = false,
    Callback = function(state)
        voidrushcontrol = state
    end
})

local function startOverride()
    if isOverrideActive then return end
    isOverrideActive = true
    connection = RunService.RenderStepped:Connect(function()
        if not humanoid or not rootPart then return end
        humanoid.WalkSpeed = ORIGINAL_DASH_SPEED
        humanoid.AutoRotate = false
        local direction = rootPart.CFrame.LookVector
        local horizontal = Vector3.new(direction.X, 0, direction.Z)
        if horizontal.Magnitude > 0 then
            humanoid:Move(horizontal.Unit)
        end
    end)
end

local function stopOverride()
    if not isOverrideActive then return end
    isOverrideActive = false
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.AutoRotate = true
        humanoid:Move(Vector3.new(0, 0, 0))
    end
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

RunService.RenderStepped:Connect(function()
    if not voidrushcontrol then return end
    local char = humanoid and humanoid.Parent
    local voidRushState = char and char:GetAttribute("VoidRushState")
    if voidRushState == "Dashing" then
        startOverride()
    else
        stopOverride()
    end
end)

end


do

local veeronicaSection = Tabs.Misc:Section({
    Title = "Veeronica相关功能",
    Icon = "grid-3x2",
    Opened = false,
})

local player = Players.LocalPlayer
local block
local followConnection
local recreateThread
local recreateLevel = 0
local running = false

local function createBlock()
    local part = Instance.new("Part")
    part.Size = Vector3.new(10, 0.3, 10)
    part.Anchored = true
    part.CanCollide = true
    part.Transparency = 0.6
    part.Material = Enum.Material.SmoothPlastic
    part.Color = Color3.fromRGB(255, 255, 0)
    part.Name = "SidePlatform"
    part.Parent = workspace
    return part
end

local function destroyBlock()
    if block and block.Parent then
        block:Destroy()
    end
    block = nil
end

local function startRecreateLoop(root, offsetCF)
    if recreateThread then
        return
    end
    running = true
    recreateThread = task.spawn(function()
        while running do
            local val = tonumber(recreateLevel) or 0
            if val == 0 then
                if not block then
                    block = createBlock()
                end
                task.wait(0.1)
            else
                local delayTime = val
                local aliveTime = val * 0.5
                destroyBlock()
                block = createBlock()
                local elapsed = 0
                while elapsed < aliveTime and running do
                    task.wait(0.05)
                    elapsed = elapsed + 0.05
                end
                destroyBlock()
                local remaining = delayTime - aliveTime
                if remaining > 0 then
                    local waited = 0
                    while waited < remaining and running do
                        task.wait(0.05)
                        waited = waited + 0.05
                    end
                end
            end
        end
    end)
end

local function stopRecreateLoop()
    running = false
    if recreateThread then
        recreateThread = nil
    end
end

veeronicaSection:Toggle({
    Flag = "TrickHelper",
    Title = "技巧辅助r",
    Default = false,
    Callback = function(state)
        if state then
            local char = player.Character or player.CharacterAdded:Wait()
            local root = char:WaitForChild("HumanoidRootPart")
            local offsetCF = CFrame.new(1, -3, 0)
            if not block then
                block = createBlock()
            end
            if not followConnection then
                followConnection = RunService.RenderStepped:Connect(function()
                    if block and root then
                        local cf = root.CFrame * offsetCF
                        block.CFrame = cf * CFrame.Angles(0, 0, math.rad(90))
                    end
                end)
            end
            startRecreateLoop(root, offsetCF)
        else
            if followConnection then
                followConnection:Disconnect()
                followConnection = nil
            end
            stopRecreateLoop()
            destroyBlock()
        end
    end
})

veeronicaSection:Slider({
    Flag = "HelpEvery",
    Title = "帮助间隔",
    Step = 1,
    Value = {Min = 0, Max = 5, Default = 0},
    Suffix = " Second",
    Callback = function(val)
        recreateLevel = tonumber(val) or 0
    end
})

local ANIM_ID = "117058860640843"
local superFlingEnabled = false
local pitchDegrees = 40
local activationRange = 20
local FORWARD_OFFSET = 0.06
local UP_OFFSET = 0.08

local function findNearestKiller()
    local character = player.Character
    if not character then return nil, math.huge end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil, math.huge end
    local killersFolder = workspace:FindFirstChild("Players")
    if killersFolder then
        killersFolder = killersFolder:FindFirstChild("Killers")
        if killersFolder then
            local nearestKiller = nil
            local shortestDistance = math.huge
            for _, killer in pairs(killersFolder:GetChildren()) do
                if killer:IsA("Model") and killer:FindFirstChild("HumanoidRootPart") then
                    local distance = (killer.HumanoidRootPart.Position - hrp.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestKiller = killer
                    end
                end
            end
            return nearestKiller, shortestDistance
        end
    end
    return nil, math.huge
end

local function isMatchAnimation(anim)
    if not anim or not anim.AnimationId then return false end
    return tostring(anim.AnimationId):find(ANIM_ID, 1, true) ~= nil
end

local function watchCharacter(character)
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 5)
    if not humanoid then return end
    local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator", 2)
    if not animator then return end
    local active = {}
    animator.AnimationPlayed:Connect(function(track)
        local anim = track.Animation
        if not isMatchAnimation(anim) then return end
        if active[track] then return end
        active[track] = true
        local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 2)
        if not hrp or not hrp.Parent then
            active[track] = nil
            return
        end
        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not superFlingEnabled then
                return
            end
            if not hrp or not hrp.Parent then
                if conn then conn:Disconnect() end
                return
            end
            local _, distance = findNearestKiller()
            if distance > activationRange then
                return
            end
            local PITCH_RAD = math.rad(pitchDegrees)
            local lv = hrp.CFrame.LookVector
            local lv_flat = Vector3.new(lv.X, 0, lv.Z)
            if lv_flat.Magnitude == 0 then
                lv_flat = Vector3.new(0, 0, -1)
            else
                lv_flat = lv_flat.Unit
            end
            local targetPos = hrp.Position + (lv_flat * FORWARD_OFFSET) + Vector3.new(0, UP_OFFSET, 0)
            local baseOrient = CFrame.new(targetPos, targetPos + lv_flat)
            local pitched = baseOrient * CFrame.Angles(PITCH_RAD, 0, 0)
            hrp.CFrame = pitched
        end)
        track.Stopped:Connect(function()
            if conn and conn.Connected then conn:Disconnect() end
            active[track] = nil
        end)
    end)
end

if player.Character then watchCharacter(player.Character) end
player.CharacterAdded:Connect(watchCharacter)

veeronicaSection:Toggle({
    Flag = "SuperFlingBumber",
    Title = "超级甩飞撞飞r",
    Default = false,
    Callback = function(state)
        superFlingEnabled = state
    end
})

veeronicaSection:Slider({
    Flag = "PitchDegrees",
    Title = "俯仰角度",
    Step = 1,
    Value = {Min = 0, Max = 90, Default = 40},
    Suffix = "В°",
    Callback = function(val)
        pitchDegrees = tonumber(val) or 40
    end
})


veeronicaSection:Slider({
    Flag = "ActivationRange",
    Title = "激活距离",
    Step = 1,
    Value = {Min = 1, Max = 50, Default = 20},
    Suffix = " studs",
    Callback = function(val)
        activationRange = tonumber(val) or 20
    end
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

local lp = Players.LocalPlayer

local veeronicaEnabled = false
local activeMonitors = {}
local descendantAddedConn = nil

local function getBehaviorFolder()
    return ReplicatedStorage:WaitForChild("Assets")
        :WaitForChild("Survivors")
        :WaitForChild("Veeronica")
        :WaitForChild("Behavior")
end

local function getSprintingButton()
    local ui = lp and lp:FindFirstChild("PlayerGui")
    if ui then
        return ui:FindFirstChild("MainUI", true) and ui.MainUI:FindFirstChild("SprintingButton", true)
    end
end

local behaviorFolder = getBehaviorFolder()

local function safeConnectPropertyChanged(instance, prop, fn)
    local ok, signal = pcall(function() return instance:GetPropertyChangedSignal(prop) end)
    if ok and signal then
        return signal:Connect(fn)
    end
end

local function monitorHighlight(h)
    if not h or activeMonitors[h] then return end
    local connections = {}
    local prevState = false
    local function cleanup()
        for _, conn in ipairs(connections) do
            if conn and conn.Connected then conn:Disconnect() end
        end
        activeMonitors[h] = nil
    end
    local function adorneeIsPlayerCharacter()
        if not lp then return false end
        local adornee = h.Adornee
        local char = lp.Character
        if not adornee or not char then return false end
        return adornee == char or adornee:IsDescendantOf(char)
    end
    local function onChanged()
        if not veeronicaEnabled then return end
        if not h or not h.Parent then cleanup() return end
        local currState = adorneeIsPlayerCharacter()
        if prevState ~= currState and currState then
            local sprintBtn = getSprintingButton()
            if sprintBtn then
                for _, conn in pairs(getconnections(sprintBtn.MouseButton1Down)) do
                    pcall(function() conn.Function() end)
                end
            else
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                task.wait(0.03)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
            end
        end
        prevState = currState
    end
    table.insert(connections, safeConnectPropertyChanged(h, "Adornee", onChanged))
    table.insert(connections, h.AncestryChanged:Connect(function(_, parent)
        if not parent then cleanup() else onChanged() end
    end))
    activeMonitors[h] = cleanup
    task.spawn(onChanged)
end

local function startVeeronica()
    if descendantAddedConn then return end
    for _, obj in ipairs(behaviorFolder:GetDescendants()) do
        if obj:IsA("Highlight") then monitorHighlight(obj) end
    end
    descendantAddedConn = behaviorFolder.DescendantAdded:Connect(function(child)
        if child:IsA("Highlight") then monitorHighlight(child) end
    end)
end

local function stopVeeronica()
    if descendantAddedConn and descendantAddedConn.Connected then
        descendantAddedConn:Disconnect()
    end
    descendantAddedConn = nil
    for _, cleanup in pairs(activeMonitors) do
        if type(cleanup) == "function" then pcall(cleanup) end
    end
    activeMonitors = {}
end

veeronicaSection:Toggle({
    Flag = "AutoTrick",
    Title = "自动技巧",
    Default = false,
    Callback = function(enabled)
        veeronicaEnabled = enabled
        if enabled then
            startVeeronica()
        else
            stopVeeronica()
        end
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local shiftlockEnabled = false
local connection

local function setShiftlock(state)
    shiftlockEnabled = state
    if connection then
        connection:Disconnect()
        connection = nil
    end
    if shiftlockEnabled then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        connection = RunService.RenderStepped:Connect(function()
            local character = lp.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if root then
                local camCF = camera.CFrame
                root.CFrame = CFrame.new(root.Position, Vector3.new(
                    camCF.LookVector.X + root.Position.X,
                    root.Position.Y,
                    camCF.LookVector.Z + root.Position.Z
                ))
            end
        end)
    else
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end
end

local chargeAnimIds = {"117058860640843"}
local ORIGINAL_DASH_SPEED = 60
local controlChargeEnabled = false
local controlChargeActive = false
local overrideConnection = nil
local detectorChargeIds = (type(chargeAnimIds) == "table" and chargeAnimIds) or {}
local savedHumanoidState = {}

local function getHumanoid()
    if not lp or not lp.Character then return nil end
    return lp.Character:FindFirstChildOfClass("Humanoid")
end

local function saveHumState(hum)
    if not hum then return end
    if savedHumanoidState[hum] then return end
    local s = {}
    pcall(function()
        s.WalkSpeed = hum.WalkSpeed
        local ok, _ = pcall(function() s.JumpPower = hum.JumpPower end)
        if not ok then
            pcall(function() s.JumpPower = hum.JumpHeight end)
        end
        local ok2, ar = pcall(function() return hum.AutoRotate end)
        if ok2 then s.AutoRotate = ar end
        s.PlatformStand = hum.PlatformStand
    end)
    savedHumanoidState[hum] = s
end

local function restoreHumState(hum)
    if not hum then return end
    local s = savedHumanoidState[hum]
    if not s then return end
    pcall(function()
        if s.WalkSpeed ~= nil then hum.WalkSpeed = s.WalkSpeed end
        if s.JumpPower ~= nil then
            local ok, _ = pcall(function() hum.JumpPower = s.JumpPower end)
            if not ok then pcall(function() hum.JumpHeight = s.JumpPower end) end
        end
        if s.AutoRotate ~= nil then pcall(function() hum.AutoRotate = s.AutoRotate end) end
        if s.PlatformStand ~= nil then hum.PlatformStand = s.PlatformStand end
    end)
    savedHumanoidState[hum] = nil
end

local function startOverride()
    if controlChargeActive then return end
    local hum = getHumanoid()
    if not hum then return end
    controlChargeActive = true
    saveHumState(hum)
    pcall(function()
        hum.WalkSpeed = ORIGINAL_DASH_SPEED
        hum.AutoRotate = false
    end)
    setShiftlock(true)
    overrideConnection = RunService.RenderStepped:Connect(function()
        local humanoid = getHumanoid()
        local rootPart = humanoid and humanoid.Parent and humanoid.Parent:FindFirstChild("HumanoidRootPart")
        if not humanoid or not rootPart then return end
        pcall(function()
            humanoid.WalkSpeed = ORIGINAL_DASH_SPEED
            humanoid.AutoRotate = false
        end)
        local direction = rootPart.CFrame.LookVector
        local horizontal = Vector3.new(direction.X, 0, direction.Z)
        if horizontal.Magnitude > 0 then
            humanoid:Move(horizontal.Unit)
        else
            humanoid:Move(Vector3.new(0,0,0))
        end
    end)
end

local function stopOverride()
    if not controlChargeActive then return end
    controlChargeActive = false
    if overrideConnection then
        pcall(function() overrideConnection:Disconnect() end)
        overrideConnection = nil
    end
    setShiftlock(false)
    local hum = getHumanoid()
    if hum then
        pcall(function()
            restoreHumState(hum)
            hum:Move(Vector3.new(0,0,0))
        end)
    end
end

local function detectChargeAnimation()
    local hum = getHumanoid()
    if not hum then return false end
    for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
        local ok, animId = pcall(function()
            return tostring(track.Animation and track.Animation.AnimationId or ""):match("%d+")
        end)
        if ok and animId and animId ~= "" then
            if detectorChargeIds and table.find(detectorChargeIds, animId) then
                return true
            end
        end
    end
    return false
end

local function ControlCharge_SetEnabled(val)
    controlChargeEnabled = val and true or false
    if not controlChargeEnabled and controlChargeActive then
        stopOverride()
    end
end

RunService.RenderStepped:Connect(function()
    if not controlChargeEnabled then
        if controlChargeActive then stopOverride() end
        return
    end
    local hum = getHumanoid()
    if not hum then
        if controlChargeActive then stopOverride() end
        return
    end
    local isCharging = detectChargeAnimation()
    if isCharging then
        if not controlChargeActive then
            startOverride()
        end
    else
        if controlChargeActive then
            stopOverride()
        end
    end
end)

lp.CharacterAdded:Connect(function(char)
    task.spawn(function()
        local hum = char:WaitForChild("Humanoid", 2)
    end)
end)
lp.CharacterAdded:Connect(function()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end)

veeronicaSection:Toggle({
    Flag = "Sk8Control",
    Title = "滑板控制",
    Default = false,
    Callback = function(State)
        ControlCharge_SetEnabled(State)
    end
})


local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local username = lp.Name
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "FireServer" then
        if getgenv().BlockSkateRebound and tostring(args[1]) == username.."SkateRebound" then
            return nil
        end
        if getgenv().BlockSkateRebound and tostring(args[1]) == username.."StopSkate" and typeof(args[2]) == "table" then
            for i, v in ipairs(args[2]) do
                if typeof(v) == "Instance" then
                    local args = {
                        username.."StopSkate",
                        {buffer.fromstring("\"Manual\"")}
                    }
                    pcall(function()
                        local m = game:GetService("ReplicatedStorage"):WaitForChild("Modules", 5)
                        local n = m and m:WaitForChild("Network", 5)
                        local n2 = n and n:WaitForChild("Network", 5)
                        local r = n2 and n2:WaitForChild("RemoteEvent", 5)
                        if r then r:FireServer(unpack(args))
                        else print("[NSK] Block ~7699 ERROR: RemoteEvent not found") end
                    end)
                    return nil
                end
            end
        end
    end
    return oldNamecall(self, ...)
end)

veeronicaSection:Toggle({
    Flag = "SkateboardIgnoreObjectables",
    Title = "滑板防物体[防反弹]",
    Default = false,
    Callback = function(value)
        getgenv().BlockSkateRebound = value
    end
})

    local sprintMod = require(ReplicatedStorage
        :WaitForChild("Systems")
        :WaitForChild("Character")
        :WaitForChild("Game")
        :WaitForChild("Sprinting"))

    local enabled = false

    RunService.Heartbeat:Connect(function()
        if not enabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        if root:FindFirstChild("SkatePointer") then
            sprintMod.Stamina = sprintMod.MaxStamina
        end
    end)


        veeronicaSection:Toggle({
        Flag = "UnlimitedDurationSkateboard",
        Title = "无限时间滑板",
        Default = false,
        Callback = function(state) enabled = state end
    })


local function EnableC00lkidd()
    getgenv().activateRemoteHook("RemoteEvent", lp.Name .. "C00lkiddCollision")
end
local function DisableC00lkidd()
    getgenv().deactivateRemoteHook("RemoteEvent", lp.Name .. "C00lkiddCollision")
end


end

local coolKidSection = Tabs.Misc:Section({
    Title = "酷小孩",
    Icon = "zap",
    Opened = false,
})

coolKidSection:Toggle({
    Flag = "WalkspeedOverrideIgnoreObjectables",
    Title = "移速覆盖忽略目标物",
    Default = false,
    Callback = function(value)
        if value then
            EnableC00lkidd()
        else
            DisableC00lkidd()
        end
    end
})

local nosferatuSection = Tabs.Misc:Section({
    Title = "Nosferatu相关功能",
    Icon = "moon",
    Opened = false,
})

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local QTE_CONFIG = {
    Enabled = false,
    CloseSpeed = 0.005,
    FarSpeed = 0.05,
    Radius = 20,
}

local function getDistanceToKiller()
    local character = LocalPlayer.Character
    if not character then return math.huge end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return math.huge end
    local minDistance = math.huge
    local playersFolder = workspace:FindFirstChild("Players")
    if playersFolder then
        local killersFolder = playersFolder:FindFirstChild("Killers")
        if killersFolder then
            for _, killer in ipairs(killersFolder:GetChildren()) do
                local killerRoot = killer:FindFirstChild("HumanoidRootPart")
                if killerRoot then
                    local distance = (rootPart.Position - killerRoot.Position).Magnitude
                    if distance < minDistance then
                        minDistance = distance
                    end
                end
            end
        end
    end
    return minDistance
end

local function getCurrentSpeed()
    local distance = getDistanceToKiller()
    if distance <= QTE_CONFIG.Radius then
        return QTE_CONFIG.CloseSpeed
    else
        return QTE_CONFIG.FarSpeed
    end
end

task.spawn(function()
    while true do
        if QTE_CONFIG.Enabled then
            local distance = getDistanceToKiller()
            if distance <= QTE_CONFIG.Radius then
                pcall(function()
                    local tempUI = PlayerGui:FindFirstChild("TemporaryUI")
                    if tempUI then
                        local qte = tempUI:FindFirstChild("QTE") or tempUI:FindFirstChildWhichIsA("Frame", true)
                        if qte then
                            local button = qte:FindFirstChild("ActiveButton")
                                        or qte:FindFirstChildWhichIsA("TextButton")
                                        or qte:FindFirstChildWhichIsA("ImageButton")
                            if button then
                                local connsActivated = pcall(function()
                                    for _, conn in ipairs(getconnections(button.Activated)) do
                                        pcall(function() conn.Function() end)
                                    end
                                end)
                                if not connsActivated then
                                    for _, conn in ipairs(getconnections(button.MouseButton1Down)) do
                                        pcall(function() conn.Function() end)
                                    end
                                end
                                pcall(function()
                                    for _, conn in ipairs(getconnections(button.MouseButton1Click)) do
                                        pcall(function() conn.Function() end)
                                    end
                                end)
                            end
                        end
                    end
                end)
            end
        end
        task.wait(getCurrentSpeed())
    end
end)

nosferatuSection:Toggle({
    Flag = "NosferatuAutoComplete",
    Title = "自动完成血钩迷你游戏",
    Default = false,
    Callback = function(state)
        QTE_CONFIG.Enabled = state
    end
})
nosferatuSection:Slider({
    Flag = "NosferatuRadius",
    Title = "屠夫判定范围（studs）",
    Step = 1,
    Value = {Min = 5, Max = 100, Default = QTE_CONFIG.Radius},
    Callback = function(value)
        QTE_CONFIG.Radius = tonumber(value)
    end
})
nosferatuSection:Slider({
    Flag = "NosferatuCloseSpeed",
    Title = "近距离检测速度",
    Step = 0.005,
    Value = {Min = 0.005, Max = 0.1, Default = QTE_CONFIG.CloseSpeed},
    Callback = function(value)
        QTE_CONFIG.CloseSpeed = tonumber(value)
    end
})
nosferatuSection:Slider({
    Flag = "NosferatuFarSpeed",
    Title = "远距离检测速度",
    Step = 0.01,
    Value = {Min = 0.01, Max = 0.2, Default = QTE_CONFIG.FarSpeed},
    Callback = function(value)
        QTE_CONFIG.FarSpeed = tonumber(value)
    end
})

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local FLIGHT_CONFIG = {
    Enabled = false,
    FlightSpeed = 60,
    VerticalSpeed = 40,
    AutoRotate = true,
}

local humanoid, rootPart, character
local isOverrideActive = false
local flightConnection

local function setupCharacter(char)
    if not char then return end
    character = char
    humanoid = char:WaitForChild("Humanoid", 5)
    rootPart = char:WaitForChild("HumanoidRootPart", 5)
end

if LocalPlayer.Character then
    setupCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(setupCharacter)

local function isInFlight()
    if not character then return false end
    if character:GetAttribute("InFlight") then return true end
    if character:GetAttribute("Flying") then return true end
    local bat = character:FindFirstChild("Bat")
    if bat and bat:IsA("BasePart") then
        if bat.Transparency < 0.5 then
            return true
        end
    end
    if humanoid then
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            local name = track.Name:lower()
            if name:find("bat") or name:find("fly") or name:find("air") or name:find("flight") then
                return true
            end
        end
    end
    return false
end

local originalWalkSpeed = 16

local function startFlightControl()
    if isOverrideActive then return end
    isOverrideActive = true
    if humanoid then
        originalWalkSpeed = humanoid.WalkSpeed
    end
    flightConnection = RunService.RenderStepped:Connect(function(dt)
        if not humanoid or not rootPart then return end
        if not FLIGHT_CONFIG.Enabled then return end
        humanoid.WalkSpeed = FLIGHT_CONFIG.FlightSpeed
        humanoid.AutoRotate = FLIGHT_CONFIG.AutoRotate
        local camera = workspace.CurrentCamera
        local camCF = camera.CFrame
        local camLook = camCF.LookVector
        local moveDir = humanoid.MoveDirection
        local verticalInput = 0
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            verticalInput = 1
        elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            verticalInput = -1
        end
        pcall(function()
            if UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonA) then
                verticalInput = 1
            elseif UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonB) then
                verticalInput = -1
            end
        end)
        local flyDirection = Vector3.new(0, 0, 0)
        if moveDir.Magnitude > 0.1 then
            local flatLook = Vector3.new(camLook.X, 0, camLook.Z).Unit
            local flatRight = Vector3.new(camCF.RightVector.X, 0, camCF.RightVector.Z).Unit
            flyDirection = (flatLook * moveDir.Z + flatRight * moveDir.X).Unit * FLIGHT_CONFIG.FlightSpeed
        end
        flyDirection = flyDirection + Vector3.new(0, verticalInput * FLIGHT_CONFIG.VerticalSpeed, 0)
        if flyDirection.Magnitude > 0.1 then
            local bodyVel = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVel then
                bodyVel.Velocity = flyDirection
            else
                rootPart.AssemblyLinearVelocity = flyDirection
            end
            if FLIGHT_CONFIG.AutoRotate and flyDirection.Magnitude > 1 then
                local flatDir = Vector3.new(flyDirection.X, 0, flyDirection.Z)
                if flatDir.Magnitude > 0.1 then
                    local targetCF = CFrame.lookAt(rootPart.Position, rootPart.Position + flatDir)
                    rootPart.CFrame = rootPart.CFrame:Lerp(targetCF, 0.2)
                end
            end
        end
    end)
end

local function stopFlightControl()
    if not isOverrideActive then return end
    isOverrideActive = false
    if humanoid then
        humanoid.WalkSpeed = originalWalkSpeed
        humanoid.AutoRotate = true
    end
    if flightConnection then
        flightConnection:Disconnect()
        flightConnection = nil
    end
end

RunService.RenderStepped:Connect(function()
    if not FLIGHT_CONFIG.Enabled then
        if isOverrideActive then
            stopFlightControl()
        end
        return
    end
    if isInFlight() then
        startFlightControl()
    else
        stopFlightControl()
    end
end)

nosferatuSection:Toggle({
    Flag = "NosferatuFlightControl",
    Title = "开启飞行",
    Default = false,
    Callback = function(state)
        FLIGHT_CONFIG.Enabled = state
        if not state then
            stopFlightControl()
        end
    end
})
nosferatuSection:Slider({
    Flag = "NosferatuFlightSpeed",
    Title = "飞行速度",
    Step = 5,
    Value = {Min = 10, Max = 150, Default = FLIGHT_CONFIG.FlightSpeed},
    Callback = function(val)
        FLIGHT_CONFIG.FlightSpeed = tonumber(val)
    end
})
nosferatuSection:Slider({
    Flag = "NosferatuVerticalSpeed",
    Title = "升降速度",
    Step = 5,
    Value = {Min = 10, Max = 100, Default = FLIGHT_CONFIG.VerticalSpeed},
    Callback = function(val)
        FLIGHT_CONFIG.VerticalSpeed = tonumber(val)
    end
})
nosferatuSection:Toggle({
    Flag = "NosferatuAutoRotate",
    Title = "自动转向",
    Default = true,
    Callback = function(state)
        FLIGHT_CONFIG.AutoRotate = state
    end
})

local elliotSection = Tabs.Misc:Section({
    Title = "艾利奥特",
    Icon = "heart",
    Opened = false,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local hpThreshold = 50
local autoPizzaEnabled = false
local healthConnection
local charAddedConnection

local function teleportTo(position)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

local function tryPizzaHeal()
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChild("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return end
    local startPos = root.Position
    local beforeHP = humanoid.Health
    local pizza = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Pizza")
    if not pizza or not pizza:IsA("BasePart") then return end
    teleportTo(pizza.Position)
    task.wait(0.5)
    if humanoid.Health <= beforeHP then
        task.wait(0.5)
    end
    teleportTo(startPos)
end

local function setupHealthMonitor(character)
    if healthConnection then
        healthConnection:Disconnect()
    end
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then
        return
    end
    healthConnection = humanoid.HealthChanged:Connect(function(currentHP)
        if autoPizzaEnabled and currentHP < hpThreshold and currentHP > 0 then
            tryPizzaHeal()
        end
    end)
end

if LocalPlayer.Character then
    setupHealthMonitor(LocalPlayer.Character)
end
charAddedConnection = LocalPlayer.CharacterAdded:Connect(setupHealthMonitor)

elliotSection:Toggle({
    Flag = "AutoEatPizza",
    Title = "自动吃披萨回血",
    Default = false,
    Callback = function(v)
        autoPizzaEnabled = v
    end
})

elliotSection:Slider({
    Flag = "PizzaHPThreshold",
    Title = "血量触发阈值",
    Value = {Min = 1, Max = 100, Default = hpThreshold},
    Step = 1,
    Suffix = "%",
    Callback = function(val)
        hpThreshold = val
    end
})

do

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local cooldown = false
local backOffset = Vector3.new(0, 0, 3)
local teammatesHpThreshold = 50
local featureEnabled = false

elliotSection:Toggle({
    Flag = "AutoHealTeammates",
    Title = "自动治疗队友",
    Default = false,
    Callback = function(value)
        featureEnabled = value
    end
})

elliotSection:Slider({
    Flag = "TeammatesHPThreshold",
    Title = "队友血量触发阈值",
    Step = 1,
    Value = {Min = 1, Max = 100, Default = teammatesHpThreshold},
    Suffix = " HP",
    Callback = function(value)
        teammatesHpThreshold = tonumber(value)
    end
})

local function teleportBehind(targetChar)
    if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then return end
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = character.HumanoidRootPart
    local targetRootPart = targetChar.HumanoidRootPart
    local returnPos = rootPart.CFrame
    local stickConnection
    stickConnection = RunService.Heartbeat:Connect(function()
        if not targetRootPart or not targetRootPart.Parent or not rootPart or not rootPart.Parent then
            stickConnection:Disconnect()
            return
        end
        local backPos = targetRootPart.CFrame * CFrame.new(backOffset)
        rootPart.CFrame = backPos
    end)
    local args = {
        "UseActorAbility",
        {
            buffer.fromstring("\003\n\000\000\000ThrowPizza")
        }
    }
    pcall(function()
        local m = ReplicatedStorage:WaitForChild("Modules", 5)
        local n = m and m:WaitForChild("Network", 5)
        local n2 = n and n:WaitForChild("Network", 5)
        local r = n2 and n2:WaitForChild("RemoteEvent", 5)
        if r then r:FireServer(unpack(args))
        else print("[NSK] Block ~8186 ERROR: RemoteEvent not found") end
    end)
    task.delay(2, function()
        stickConnection:Disconnect()
        if character and rootPart and rootPart.Parent then
            rootPart.CFrame = returnPos
        end
    end)
end

local function monitorPlayerHP(player)
    local function onCharacterAdded(character)
        local humanoid = character:WaitForChild("Humanoid", 5)
        if humanoid then
            humanoid.HealthChanged:Connect(function(currentHP)
                if featureEnabled and not cooldown and currentHP > 0 and currentHP < teammatesHpThreshold then
                    cooldown = true
                    teleportBehind(character)
                    task.delay(46, function()
                        cooldown = false
                    end)
                end
            end)
        end
    end
    if player.Character then
        onCharacterAdded(player.Character)
    end
    player.CharacterAdded:Connect(onCharacterAdded)
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        monitorPlayerHP(player)
    end
end
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        monitorPlayerHP(player)
    end
end)

local hitboxSection = Tabs.Misc:Section({
    Title = "屠夫范围圈",
    Icon = "target",
    Desc = "屠夫范围可视化功能",
    Opened = false,
})

local Workspace = game:GetService("Workspace")
local killerDiameters = {
    ["Jason"] = 15,
    ["John Doe"] = 15,
    ["1x1x1x1"] = 15,
    ["Noli"] = 15,
    ["c00lkidd"] = 15,
    ["Slasher"] = 15,
    ["Sixer"] = 25,
    ["Nosferatu"] = 15
}
local circleColor = Color3.fromRGB(255, 105, 180)
local SEGMENTS = 96
local SEGMENT_HEIGHT = 0.2
local SEGMENT_WIDTH = 0.35
local circles = {}
local enabled = false

local function createRingForKiller(killer, diameter)
    if not killer or not killer.Parent then return end
    local hrp = killer:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if circles[killer] then
        if circles[killer].model then
            pcall(function() circles[killer].model:Destroy() end)
        end
        circles[killer] = nil
    end
    local model = Instance.new("Model")
    model.Name = "HitboxRing_" .. killer.Name
    model.Parent = Workspace
    local radius = diameter / 2
    local circumference = 2 * math.pi * radius
    local segLen = circumference / SEGMENTS
    local segments = {}
    for i = 1, SEGMENTS do
        local angle = (i - 1) * (2 * math.pi / SEGMENTS)
        local offset = Vector3.new(radius * math.cos(angle), 0, radius * math.sin(angle))
        local worldPos = hrp.Position + offset
        local part = Instance.new("Part")
        part.Size = Vector3.new(segLen, SEGMENT_HEIGHT, SEGMENT_WIDTH)
        part.Anchored = false
        part.CanCollide = false
        part.Material = Enum.Material.Neon
        part.Color = circleColor
        part.Transparency = 0.3
        part.CFrame = CFrame.new(worldPos) * CFrame.Angles(0, angle + math.pi/2, 0)
        part.Parent = model
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = part
        weld.Part1 = hrp
        weld.Parent = part
        table.insert(segments, part)
    end
    circles[killer] = { model = model, segments = segments, diameter = diameter }
end

local function updateCircle(killer)
    local hrp = killer:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local diameter = killerDiameters[killer.Name]
    if not diameter then return end
    local info = circles[killer]
    if not info then
        createRingForKiller(killer, diameter)
        return
    end
    if info.diameter ~= diameter then
        createRingForKiller(killer, diameter)
        return
    end
end

local function cleanupCircles()
    for killer, data in pairs(circles) do
        if not killer.Parent then
            if data.model then
                pcall(function() data.model:Destroy() end)
            end
            circles[killer] = nil
        end
    end
end

local function clearAll()
    for killer, data in pairs(circles) do
        if data.model then
            pcall(function() data.model:Destroy() end)
        end
    end
    table.clear(circles)
end

task.spawn(function()
    while true do
        if enabled then
            cleanupCircles()
            if Workspace:FindFirstChild("Players") and Workspace.Players:FindFirstChild("Killers") then
                for _, killer in ipairs(Workspace.Players.Killers:GetChildren()) do
                    pcall(updateCircle, killer)
                end
            end
        end
        task.wait(5)
    end
end)

hitboxSection:Toggle({
    Flag = "HitboxVisualization",
    Title = "显示屠夫攻击范围",
    Default = false,
    Callback = function(state)
        enabled = state
        if not state then
            clearAll()
        end
    end
})

local animationId = "75804462760596"
local loopRunning = false
local loopThread
local currentAnim = nil
local autoInvisClone = false
local autoInvisCrouch = false
local autoInvisGhostburger = false
local animationSpeed = 0
local invisDuration = 5
local firstCooldown = 0
local nextCooldown = 45
local lastUsed = 0
local firstUse = true

local function StartInvisibility()
    if loopRunning then return end
    loopRunning = true
    local speaker = LocalPlayer
    local humanoid = speaker.Character and speaker.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R6 then return end
    loopThread = task.spawn(function()
        while loopRunning do
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://" .. animationId
            local loadedAnim = humanoid:LoadAnimation(anim)
            currentAnim = loadedAnim
            loadedAnim.Looped = false
            loadedAnim:Play()
            loadedAnim:AdjustSpeed(animationSpeed)
            while loadedAnim.IsPlaying and loopRunning do
                loadedAnim:AdjustSpeed(animationSpeed)
                task.wait(0.05)
            end
            task.wait(0.01)
        end
    end)
end

local function StopInvisibility()
    loopRunning = false
    if loopThread then
        task.cancel(loopThread)
        loopThread = nil
    end
    if currentAnim then
        currentAnim:Stop()
        currentAnim = nil
    end
    local speaker = LocalPlayer
    local humanoid = speaker.Character and (speaker.Character:FindFirstChildOfClass("Humanoid") or speaker.Character:FindFirstChildOfClass("AnimationController"))
    if humanoid then
        for _, v in pairs(humanoid:GetPlayingAnimationTracks()) do
            v:AdjustSpeed(100000)
        end
    end
    local animateScript = speaker.Character and speaker.Character:FindFirstChild("Animate")
    if animateScript then
        animateScript.Disabled = true
        animateScript.Disabled = false
    end
end


local autoInvisSection = Tabs.Auto_Stun:Section({
    Title = "自动隐身",
    Icon = "eye-off",
    Desc = "自动隐身相关功能",
    Opened = false,
})

autoInvisSection:Toggle({
    Flag = "AutoInvisClone",
    Title = "分身技能自动隐身(007n7)",
    Default = false,
    Callback = function(value)
        autoInvisClone = value
        if not autoInvisClone then
            StopInvisibility()
        end
    end
})
autoInvisSection:Toggle({
    Flag = "AutoInvisCrouch",
    Title = "潜行技能自动隐身(Two Time)",
    Default = false,
    Callback = function(value)
        autoInvisCrouch = value
        if not autoInvisCrouch then
            StopInvisibility()
        end
    end
})
autoInvisSection:Toggle({
    Flag = "AutoInvisGhostburger",
    Title = "幽灵汉堡自动隐身(Noob)",
    Default = false,
    Callback = function(value)
        autoInvisGhostburger = value
        if not autoInvisGhostburger then
            StopInvisibility()
        end
    end
})
autoInvisSection:Slider({
    Flag = "InvisibilityDuration",
    Title = "隐身持续时间",
    Step = 1,
    Value = {Min = 1, Max = 45, Default = invisDuration},
    Suffix = "s",
    Callback = function(val)
        invisDuration = val
    end
})


task.spawn(function()
    while true do
        task.wait(0.1)
        if autoInvisClone then
            local abilityContainer = LocalPlayer.PlayerGui:FindFirstChild("MainUI") and LocalPlayer.PlayerGui.MainUI:FindFirstChild("AbilityContainer")
            local cloneGui = abilityContainer and abilityContainer:FindFirstChild("Clone")
            if cloneGui then
                local cloneText = cloneGui:FindFirstChildOfClass("TextLabel")
                local cloneValue = cloneText and tonumber(cloneText.Text)
                if cloneValue and cloneValue >= 26 then
                    StartInvisibility()
                    task.delay(invisDuration, StopInvisibility)
                    task.wait(invisDuration + 0.1)
                end
            end
        end
        if autoInvisCrouch then
            local abilityContainer = LocalPlayer.PlayerGui:FindFirstChild("MainUI") and LocalPlayer.PlayerGui.MainUI:FindFirstChild("AbilityContainer")
            local crouchGui = abilityContainer and abilityContainer:FindFirstChild("Crouch")
            if crouchGui then
                local crouchText = crouchGui:FindFirstChildOfClass("TextLabel")
                local crouchValue = crouchText and tonumber(crouchText.Text)
                if crouchValue and crouchValue >= 0.1 then
                    local now = tick()
                    local currentCooldown = firstUse and firstCooldown or nextCooldown
                    if now - lastUsed >= currentCooldown then
                        lastUsed = now
                        StartInvisibility()
                        task.delay(invisDuration, StopInvisibility)
                        if firstUse then
                            firstUse = false
                        end
                    end
                end
            end
        end
        if autoInvisGhostburger then
            local abilityContainer = LocalPlayer.PlayerGui:FindFirstChild("MainUI") and LocalPlayer.PlayerGui.MainUI:FindFirstChild("AbilityContainer")
            local ghostburgerGui = abilityContainer and abilityContainer:FindFirstChild("Ghostburger")
            if ghostburgerGui then
                local ghostText = ghostburgerGui:FindFirstChildOfClass("TextLabel")
                local ghostValue = ghostText and tonumber(ghostText.Text)
                if ghostValue and ghostValue >= 44 then
                    StartInvisibility()
                    task.delay(invisDuration, StopInvisibility)
                    task.wait(invisDuration + 0.1)
                end
            end
        end
    end
end)

local plsSection = Tabs.Auto_Stun:Section({
    Title = "杜塞卡静默瞄准",
    Icon = "spotlight",
    Opened = false,
})
local plasmaBeamEnabled = false
plsSection:Toggle({
    Flag = "PlasmaBeamSilentAim",
    Title = "等离子光束静默瞄准",
    Default = false,
    Callback = function(state)
        plasmaBeamEnabled = state
        plasmabeamaimbot = state
    end
})


local chanceAimbotSection = Tabs.Auto_Stun:Section({
    Title = "Chance技能自瞄",
    Icon = "target",
    Desc = "Chance技能自瞄功能",
    Opened = false,
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local active = false
local aimDuration = 1.7
local prediction = 4
local aimTargets = { "Slasher", "c00lkidd", "JohnDoe", "1x1x1x1", "Noli", "Sixer", "Nosferatu"}
local trackedAnimations = {
    ["103601716322988"] = true,
    ["133491532453922"] = true,
    ["86371356500204"] = true,
    ["76649505662612"] = true,
    ["81698196845041"] = true
}
local Humanoid, HRP = nil, nil
local lastTriggerTime = 0
local aiming = false
local originalWS, originalJP, originalAutoRotate = nil, nil, nil

local function setupCharacter(char)
    Humanoid = char:WaitForChild("Humanoid")
    HRP = char:WaitForChild("HumanoidRootPart")
end
if LocalPlayer.Character then
    setupCharacter(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(setupCharacter)
local function getValidTarget()
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if killersFolder then
        for _, name in ipairs(aimTargets) do
            local target = killersFolder:FindFirstChild(name)
            if target and target:FindFirstChild("HumanoidRootPart") then
                return target.HumanoidRootPart
            end
        end
    end
    return nil
end
local function getPlayingAnimationIds()
    local ids = {}
    if Humanoid then
        for _, track in ipairs(Humanoid:GetPlayingAnimationTracks()) do
            if track.Animation and track.Animation.AnimationId then
                local id = track.Animation.AnimationId:match("%d+")
                if id then
                    ids[id] = true
                end
            end
        end
    end
    return ids
end
RunService.RenderStepped:Connect(function()
    if not active or not Humanoid or not HRP then return end
    local playing = getPlayingAnimationIds()
    local triggered = false
    for id in pairs(trackedAnimations) do
        if playing[id] then
            triggered = true
            break
        end
    end
    if triggered then
        lastTriggerTime = tick()
        aiming = true
    end
    if aiming and tick() - lastTriggerTime <= aimDuration then
        if not originalWS then
            originalWS = Humanoid.WalkSpeed
            originalJP = Humanoid.JumpPower
            originalAutoRotate = Humanoid.AutoRotate
        end
        Humanoid.AutoRotate = false
        HRP.AssemblyAngularVelocity = Vector3.zero
        local targetHRP = getValidTarget()
        if targetHRP then
            local predictedPos = targetHRP.Position + (targetHRP.CFrame.LookVector * prediction)
            local direction = (predictedPos - HRP.Position).Unit
            local yRot = math.atan2(-direction.X, -direction.Z)
            HRP.CFrame = CFrame.new(HRP.Position) * CFrame.Angles(0, yRot, 0)
        end
    elseif aiming then
        aiming = false
        if originalWS and originalJP and originalAutoRotate ~= nil then
            Humanoid.WalkSpeed = originalWS
            Humanoid.JumpPower = originalJP
            Humanoid.AutoRotate = originalAutoRotate
            originalWS, originalJP, originalAutoRotate = nil, nil, nil
        end
    end
end)
chanceAimbotSection:Toggle({
    Flag = "ChanceAimbot",
    Title = "Chance技能自瞄",
    Default = false,
    Callback = function(value)
        active = value
    end
})
chanceAimbotSection:Slider({
    Flag = "ChanceAimbotSharpness",
    Title = "预判偏移值(高ping调大)",
    Step = 1,
    Value = {Min = 1, Max = 10, Default = prediction},
    Suffix = " studs",
    Callback = function(val)
        prediction = val
    end
})


do

local backstabSection = Tabs.Auto_Stun:Section({
    Title = "背刺[传送]",
    Icon = "utensils",
    Opened = false,
})

local predictionSection = Tabs.Auto_Stun:Section({
    Title = "移动预判设置",
    Icon = "target",
    Opened = false,
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local enabled = false
local cooldown = false
local lastTarget = nil
local range = 4
local mode = "Behind"

local daggerRemote
pcall(function()
    local m = ReplicatedStorage:WaitForChild("Modules", 5)
    if not m then print("[NSK] Backstab ERROR: Modules not found in ReplicatedStorage") return end
    local n = m:WaitForChild("Network", 5)
    if not n then print("[NSK] Backstab ERROR: Network not found in Modules") return end
    local n2 = n:WaitForChild("Network", 5)
    if not n2 then print("[NSK] Backstab ERROR: Network.Network not found") return end
    local r = n2:WaitForChild("RemoteEvent", 5)
    if not r then print("[NSK] Backstab ERROR: RemoteEvent not found in Network") return end
    daggerRemote = r
end)

local killersFolder
pcall(function()
    local wp = workspace:WaitForChild("Players", 5)
    if not wp then print("[NSK] Backstab ERROR: Players folder not found in workspace") return end
    local kf = wp:WaitForChild("Killers", 5)
    if not kf then print("[NSK] Backstab ERROR: Killers folder not found in Players") return end
    killersFolder = kf
end)


local predictionMode = "Disabled"
local PREDICTION_STRENGTH = 0.6
local PREDICTION_TIME = 0.12

local killerTrack = {}


RunService.Heartbeat:Connect(function(dt)
    if not killersFolder then return end
    local now = os.clock()
    for _, killer in pairs(killersFolder:GetChildren()) do
        local khrp = killer:FindFirstChild("HumanoidRootPart")
        if khrp then
            local state = killerTrack[khrp]
            local pos = khrp.Position
            local look = khrp.CFrame.LookVector
            if state and state.t and state.pos then
                local dtSample = now - state.t
                if dtSample > 0 then
                    local vel = (pos - state.pos) / dtSample
                    local smoothVel = state.vel and (state.vel:Lerp(vel, math.clamp(dtSample * 10, 0, 1))) or vel
                    killerTrack[khrp] = { pos = pos, look = look, vel = smoothVel, t = now, prevLook = state.look }
                else
                    killerTrack[khrp] = { pos = pos, look = look, vel = Vector3.new(0, 0, 0), t = now, prevLook = state and state.look or look }
                end
            else
                killerTrack[khrp] = { pos = pos, look = look, vel = Vector3.new(0, 0, 0), t = now, prevLook = look }
            end
        end
    end
end)

local function getCharacter()
    return lp.Character or lp.CharacterAdded:Wait()
end


local function getPredictedPosition(khrp)
    if predictionMode == "Disabled" or not khrp then
        return khrp.Position
    end

    local tracked = killerTrack[khrp]
    local vel = Vector3.new(0, 0, 0)

    if tracked and tracked.vel then
        vel = tracked.vel
    else
        pcall(function()
            vel = khrp.Velocity or Vector3.new(0, 0, 0)
        end)
    end

    local horizVel = Vector3.new(vel.X, 0, vel.Z)
    local predictedMove = horizVel * PREDICTION_TIME * PREDICTION_STRENGTH


    local turnComp = Vector3.new(0, 0, 0)
    if predictionMode == "Auto" and tracked and tracked.prevLook then
        local forward = khrp.CFrame.LookVector
        local right = khrp.CFrame.RightVector
        local deltaLook = forward - tracked.prevLook
        local turnAmount = deltaLook:Dot(right)
        local TURN_FACTOR = 3.0

        turnComp = right * (turnAmount * TURN_FACTOR * PREDICTION_STRENGTH)
    end

    return khrp.Position + predictedMove + turnComp
end

local function findClosestKiller(hrp, maxRange)
    local closest = nil
    local closestDist = maxRange or math.huge
    for _, killer in pairs(killersFolder:GetChildren()) do
        if killer:FindFirstChild("HumanoidRootPart") then
            local dist = (killer.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < closestDist then
                closest = killer
                closestDist = dist
            end
        end
    end
    return closest, closestDist
end

local function isBehindTarget(hrp, targetHRP)
    local r = tonumber(range) or 4
    local distance = (hrp.Position - targetHRP.Position).Magnitude
    if distance > r then return false end
    if mode == "Around" then
        return true
    else
        local direction = -targetHRP.CFrame.LookVector
        local toPlayer = (hrp.Position - targetHRP.Position)
        return toPlayer:Dot(direction) > 0.5
    end
end


backstabSection:Toggle({
    Flag = "Backstab",
    Title = "背刺[两次]",
    Default = false,
    Callback = function(state)
        enabled = state
    end
})

backstabSection:Slider({
    Flag = "BackstabRange",
    Title = "背刺范围",
    Step = 0.5,
    Value = { Min = 1, Max = 30, Default = range },
    Suffix = " studs",
    Callback = function(val)
        local n = tonumber(val)
        if n then range = n end
    end
})

backstabSection:Dropdown({
    Flag = "BackstabMode",
    Title = "背刺模式",
    Values = { "Behind", "Around" },
    Multi = false,
    Default = "Behind",
    Callback = function(selected)
        mode = selected
    end
})

predictionSection:Dropdown({
    Flag = "PredictionMode",
    Title = "预测模式",
    Values = { "Disabled", "Normal Prediction", "Auto Prediction" },
    Multi = false,
    Default = "Disabled",
    Callback = function(selected)
        if selected == "Normal Prediction" then
            predictionMode = "Normal"
        elseif selected == "Auto Prediction" then
            predictionMode = "Auto"
        else
            predictionMode = "Disabled"
        end
    end
})

predictionSection:Slider({
    Flag = "PredictionStrength",
    Title = "预测强度",
    Step = 0.1,
    Value = { Min = 0, Max = 2, Default = PREDICTION_STRENGTH },
    Callback = function(val)
        local n = tonumber(val)
        if n then PREDICTION_STRENGTH = n end
    end
})

predictionSection:Slider({
    Flag = "PredictionTime",
    Title = "预测时间",
    Step = 0.05,
    Value = { Min = 0.05, Max = 0.5, Default = PREDICTION_TIME },
    Suffix = " sec",
    Callback = function(val)
        local n = tonumber(val)
        if n then PREDICTION_TIME = n end
    end
})


local daggerCooldownText
local function refreshDaggerRef()
    local mainui = lp:FindFirstChild("PlayerGui") and lp.PlayerGui:FindFirstChild("MainUI")
    if mainui then
        local ability = mainui:FindFirstChild("AbilityContainer")
        if ability then
            local dagger = ability:FindFirstChild("Dagger")
            if dagger then
                local ct = dagger:FindFirstChild("CooldownTime")
                daggerCooldownText = ct
                return
            end
        end
    end
    daggerCooldownText = nil
end

lp.PlayerGui.DescendantAdded:Connect(refreshDaggerRef)
lp.PlayerGui.DescendantRemoving:Connect(function(obj)
    if obj == daggerCooldownText then
        daggerCooldownText = nil
    end
end)
refreshDaggerRef()


RunService.RenderStepped:Connect(function()
    if not enabled then return end

    local char = lp.Character
    if not (char and char:FindFirstChild("HumanoidRootPart")) then return end
    local hrp = char.HumanoidRootPart
    local r = tonumber(range) or 4

    if not daggerCooldownText or not daggerCooldownText.Parent then return end
    if tonumber(daggerCooldownText.Text or "") ~= nil then return end
    if cooldown then return end

    for _, killer in pairs(killersFolder:GetChildren()) do
        if killer:FindFirstChild("HumanoidRootPart") then
            local kHRP = killer.HumanoidRootPart

            if isBehindTarget(hrp, kHRP) and killer ~= lastTarget then
                cooldown = true
                lastTarget = killer
                local start = tick()
                local didDagger = false
                local connection
                connection = RunService.Heartbeat:Connect(function()
                    if not (char and char.Parent and kHRP and kHRP.Parent) then
                        if connection then connection:Disconnect() end
                        return
                    end
                    local elapsed = tick() - start
                    if elapsed >= 0.5 then
                        if connection then connection:Disconnect() end
                        return
                    end

                    local predictedPos = getPredictedPosition(kHRP)
                    local targetPos
                    if mode == "Behind" then
                        targetPos = predictedPos - (kHRP.CFrame.LookVector * 0.3)
                    else
                        local rel = (hrp.Position - kHRP.Position)
                        local baseOffset = (rel.Magnitude > 0.1) and rel.Unit * 0.3 or Vector3.new()
                        targetPos = predictedPos + baseOffset
                    end
                    hrp.CFrame = CFrame.new(targetPos, targetPos + kHRP.CFrame.LookVector)
                    if not didDagger then
                        didDagger = true
                        daggerRemote:FireServer("UseActorAbility", { buffer.fromstring("\003\006\000\000\000Dagger") })
                    end
                end)
                task.delay(2, function()
                    RunService.Heartbeat:Wait()
                    while kHRP and kHRP.Parent and isBehindTarget(hrp, kHRP) do
                        RunService.Heartbeat:Wait()
                    end
                    lastTarget = nil
                    cooldown = false
                end)
                break
            end
        end
    end
end)


end


local hitboxExpanderSection = Tabs.Hitbox_expander:Section({
    Title = "范围",
    Icon = "maximize-2",
    Opened = false,
})
local localPlayer = game.Players.LocalPlayer
local VELOCITY_STRENGTH = 50
local HitboxExpanderActive = false

hitboxExpanderSection:Toggle({
    Flag = "HitboxExpander",
    Title = "攻击距离[新版本]",
    Default = false,
    Callback = function(state)
        HitboxExpanderActive = state
    
    end
})
hitboxExpanderSection:Slider({
    Flag = "HitboxIncrease",
    Title = "范围大小调节",
    Step = 1,
    Value = {Min = 10, Max = 500, Default = VELOCITY_STRENGTH},
    Suffix = " studs",
    Callback = function(val)
        VELOCITY_STRENGTH = tonumber(val)
    end
})

local function getHitboxesFromPlayer()
    local hitboxesFolder = game.Workspace:FindFirstChild("Hitboxes")
    if not hitboxesFolder then return false end
    if not localPlayer then return false end
    for _, v in pairs(hitboxesFolder:GetChildren()) do
        if v and v.Name and string.find(v.Name, localPlayer.Name) then
            return true
        end
    end
    return false
end

task.spawn(function()
    while true do
        if HitboxExpanderActive and getHitboxesFromPlayer() then
            local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local currentVelocity = hrp.Velocity
                hrp.AssemblyLinearVelocity = hrp.CFrame.LookVector * VELOCITY_STRENGTH
                game:GetService("RunService").RenderStepped:Wait()
                hrp.Velocity = currentVelocity
            end
        end
        task.wait()
    end
end)

local punchHitboxSection = Tabs.Hitbox_expander:Section({
    Title = "Punch范围",
    Icon = "hand",
    Opened = false,
})
local runService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local punchAnims = {
    ["rbxassetid://122560631718612"] = true,
    ["rbxassetid://87259391926321"] = true,
    ["rbxassetid://129843313690921"] = true,
    ["rbxassetid://138040001965654"] = true,
    ["rbxassetid://73908019523515"] = true,
    ["rbxassetid://136007065400978"] = true,
    ["rbxassetid://83161312898155"] = true,
    ["rbxassetid://108911997126897"] = true
}
local PunchHitboxConfig = {
    PunchVelocityEnabled = false,
    PunchVelocityPower = 80
}
punchHitboxSection:Toggle({
    Flag = "PunchHitboxIncrease",
    Title = "开启Punch范围",
    Default = false,
    Callback = function(state)
        PunchHitboxConfig.PunchVelocityEnabled = state
        WindUI:Notify({
            Title = "Punch范围",
            Content = state and "开启" or "关闭",
            Duration = 1
        })
    end
})
punchHitboxSection:Slider({
    Flag = "PunchHitboxPower",
    Title = "增加大小[不要太高，45就够了]",
    Step = 1,
    Value = {Min = 10, Max = 100, Default = 80},
    Suffix = " power",
    Callback = function(value)
        PunchHitboxConfig.PunchVelocityPower = value
    end
})

local DURATION = 0.4
local DELAY_BEFORE = 0.3

local function applySmoothVelocity(hrp)
    task.wait(DELAY_BEFORE)
    local start = tick()
    local connection
    connection = runService.RenderStepped:Connect(function()
        local elapsed = tick() - start
        if elapsed > DURATION then
            connection:Disconnect()
            hrp.AssemblyLinearVelocity = Vector3.zero
            return
        end
        local alpha = math.sin((elapsed / DURATION) * math.pi)
        hrp.AssemblyLinearVelocity = hrp.CFrame.LookVector * PunchHitboxConfig.PunchVelocityPower * alpha
    end)
end

local function setup(char)
    task.wait(1)
    local humanoid = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")
    humanoid.AnimationPlayed:Connect(function(track)
        if not PunchHitboxConfig.PunchVelocityEnabled then return end
        local id = track.Animation.AnimationId
        if punchAnims[id] then
            task.spawn(function()
                applySmoothVelocity(hrp)
            end)
        end
    end)
end
player.CharacterAdded:Connect(setup)
if player.Character then
    setup(player.Character)
end


end


do

local GuestBlockSection = Tabs.Hitbox_expander:Section({
    Title = "访客格挡范围",
    Icon = "target",
    Opened = false,
})

local srvPlayers = game:GetService("Players")
local srvRun = game:GetService("RunService")
local client = srvPlayers.LocalPlayer

local function getCharData()
    local char = client.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if humanoid and root then
        return humanoid, root
    end
end

client.CharacterAdded:Connect(function(newChar)
end)

local hitboxEnabled = false
local MAX_TARGET_DISTANCE = 60
local BASE_EXTRA_REACH = 20
local BASE_STRENGTH = 50
local attackIds = {
    ["72182155407310"] = true,
    ["72722244508749"] = true,
    ["8028421882"] = true,
    ["95802026624883"] = true,
    ["94215314"] = true,
    ["1956271358"] = true,
    ["115706752305794"] = true,
    ["82605295530067"] = true,
    ["96959123077498"] = true,
    ["105905509045149"] = true,
    ["98105697395689"] = true,
    ["9089408772"] = true
}

GuestBlockSection:Toggle({
    Flag = "HitboxExpanderV12",
    Title = "范围V12",
    Default = false,
    Callback = function(state)
        hitboxEnabled = state
    end
})
GuestBlockSection:Slider({
    Flag = "HitboxDistanceV12",
    Title = "目标距离",
    Step = 1,
    Value = {Min = 1, Max = 500, Default = MAX_TARGET_DISTANCE},
    Suffix = " studs",
    Callback = function(val)
        MAX_TARGET_DISTANCE = tonumber(val)
    end
})

local function getNearestTarget(maxDistance, root)
    local closest, closestDist
    for _, plr in pairs(srvPlayers:GetPlayers()) do
        if plr ~= client and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local dist = (hrp.Position - root.Position).Magnitude
                if dist <= maxDistance and (not closestDist or dist < closestDist) then
                    closest = plr.Character
                    closestDist = dist
                end
            end
        end
    end
    return closest, closestDist
end

local function normalizeAnimId(id)
    return id and tostring(id):match("%d+") or nil
end

srvRun.Heartbeat:Connect(function()
    if not hitboxEnabled then return end
    local humanoid, root = getCharData()
    if not humanoid or not root then return end
    local isAttacking = false
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        local animId = track.Animation and normalizeAnimId(track.Animation.AnimationId)
        if animId and attackIds[animId] and (track.Length == 0 or (track.TimePosition / track.Length < 0.75)) then
            isAttacking = true
            break
        end
    end
    if not isAttacking then return end
    local target, dist = getNearestTarget(MAX_TARGET_DISTANCE, root)
    local originalVelocity = root.Velocity
    if target and target:FindFirstChild("HumanoidRootPart") then
        local targetRoot = target.HumanoidRootPart
        local dir = (targetRoot.Position - root.Position).Unit
        local newVelocity = dir * math.min(dist + BASE_EXTRA_REACH, MAX_TARGET_DISTANCE) * 2.5
        root.Velocity = newVelocity
    else
        root.Velocity = root.CFrame.LookVector * BASE_STRENGTH
    end
    srvRun.RenderStepped:Wait()
    root.Velocity = originalVelocity
end)


do

local TwoTimeSection = Tabs.Hitbox_expander:Section({
    Title = "Two Time Stab范围",
    Icon = "target",
    Opened = false,
})

local boostEnabled = false
local hitboxPower = 0.2
local reverseDirection = false
local characterAimbotEnabled = false
local cameraAimbotEnabled = false
local aimbotOnlyOnAnim = false

getgenv().emergency_stop = getgenv().emergency_stop or false

TwoTimeSection:Toggle({
    Flag = "EnableBoost",
    Title = "Stab范围",
    Default = false,
    Callback = function(state)
        boostEnabled = state
        if not state then
            getgenv().emergency_stop = true
        end
    end
})

TwoTimeSection:Toggle({
    Flag = "ReverseDirection",
    Title = "反刺方向",
    Default = false,
    Callback = function(state)
        reverseDirection = state
    end
})

TwoTimeSection:Slider({
    Flag = "HitboxPower",
    Title = "范围增加",
    Step = 0.1,
    Value = {Min = 0.1, Max = 10, Default = 0.10},
    Suffix = " studs",
    Callback = function(val)
        hitboxPower = tonumber(val)
    end
})

local killers_folder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
local survivors_folder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
local killer_names_priority = {"Sixer", "Slasher", "Noli", "JohnDoe", "c00lkidd", "1x1x1x1", "Nosferatu"}

local TARGET_ANIM_IDS = {
    "rbxassetid://106086955212611",
    "rbxassetid://86545133269813"
}

local function getKillerHRP()
    if not killers_folder then return nil end
    for _, name in ipairs(killer_names_priority) do
        local killer = killers_folder:FindFirstChild(name)
        if killer and killer:FindFirstChild("HumanoidRootPart") then
            return killer.HumanoidRootPart
        end
    end
    return nil
end

local function isLocalPlayerTwoTime()
    if not survivors_folder then return false end
    local twoTimeModel = survivors_folder:FindFirstChild("TwoTime")
    if not twoTimeModel then return false end
    local twoTimeHRP = twoTimeModel:FindFirstChild("HumanoidRootPart")
    if not twoTimeHRP then return false end
    local localHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localHRP then return false end
    return twoTimeHRP == localHRP
end

local function StudsIntoPower(studs)
    return studs * 6
end

local function ExtendHitbox(studs, duration)
    local power = StudsIntoPower(studs)
    local start = tick()
    getgenv().emergency_stop = false

    repeat
        RunService.Heartbeat:Wait()

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end

        local originalVelocity = hrp.Velocity
        local look = hrp.CFrame.LookVector
        local forward = Vector3.new(look.X, 0, look.Z)
        if forward.Magnitude > 0 then forward = forward.Unit end

        local direction = reverseDirection and -forward or forward

        hrp.Velocity = originalVelocity + (direction * power * 50)

        RunService.RenderStepped:Wait()
        hrp.Velocity = originalVelocity

    until tick() - start > duration or getgenv().emergency_stop

    getgenv().emergency_stop = false
end

local targetAnimPlaying = false

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char or not isLocalPlayerTwoTime() then
        targetAnimPlaying = false
        return
    end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        targetAnimPlaying = false
        return
    end
    local found = false
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        for _, animId in ipairs(TARGET_ANIM_IDS) do
            if track.Animation.AnimationId == animId and track.IsPlaying then
                found = true
                break
            end
        end
        if found then break end
    end
    targetAnimPlaying = found
end)

RunService.RenderStepped:Connect(function()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    if not isLocalPlayerTwoTime() then
        return
    end
    if aimbotOnlyOnAnim and not targetAnimPlaying then
        return
    end
    if not (characterAimbotEnabled or cameraAimbotEnabled) then
        return
    end
    local killerHRP = getKillerHRP()
    if not killerHRP then return end
    local targetPos = killerHRP.Position
    if cameraAimbotEnabled then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPos)
    end
    if characterAimbotEnabled then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        hrp.CFrame = CFrame.new(hrp.Position, targetPos)
    end
end)

local boosting = false

RunService.RenderStepped:Connect(function()
    if not boostEnabled then
        if boosting then
            getgenv().emergency_stop = true
            boosting = false
        end
        return
    end
    if targetAnimPlaying and not boosting then
        boosting = true
        task.spawn(function()
            ExtendHitbox(hitboxPower, 9e9)
        end)
    elseif not targetAnimPlaying and boosting then
        getgenv().emergency_stop = true
        boosting = false
    end
end)

end


do

local axeBoostSection = Tabs.Hitbox_expander:Section({
    Title = "Jane Doe范围",
    Icon = "zap",
    Opened = false,
})

local AxeBoostConfig = {
    Enabled  = false,
    Power    = 80,
    Duration = 0.35,
    Delay    = 0.3,
}


local axeAnims = {
    ["rbxassetid://111918351126361"] = true,
}


axeBoostSection:Toggle({
    Flag = "AxeBoostEnabled",
    Title = "斧头提升",
    Default = false,
    Callback = function(state)
        AxeBoostConfig.Enabled = state
        WindUI:Notify({
            Title = "Axe增幅",
            Content = state and "开启" or "关闭",
            Duration = 1
        })
    end
})

axeBoostSection:Slider({
    Flag  = "AxeBoostPower",
    Title = "提升力度 ",
    Step  = 5,
    Value = { Min = 20, Max = 200, Default = 80 },
    Suffix = " power",
    Callback = function(v)
        AxeBoostConfig.Power = v
    end
})

axeBoostSection:Slider({
    Flag  = "AxeBoostDuration",
    Title = "提升持续时间",
    Step  = 0.1,
    Value = { Min = 0.1, Max = 10, Default = 4 },
    Suffix = "0.1s",
    Callback = function(v)
        AxeBoostConfig.Duration = v * 0.1
    end
})


local function getNearestKillerHRP(myHRP)
    local killersFolder = (
        Workspace:FindFirstChild("Players") and
        Workspace.Players:FindFirstChild("Killers")
    ) or Workspace:FindFirstChild("Killers")

    if not killersFolder then return nil end

    local nearestHRP  = nil
    local nearestDist = math.huge

    for _, killerChar in pairs(killersFolder:GetChildren()) do
        local kHRP = killerChar:FindFirstChild("HumanoidRootPart")
        local hum  = killerChar:FindFirstChildOfClass("Humanoid")
        if kHRP and hum and hum.Health > 0 then
            local dist = (kHRP.Position - myHRP.Position).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearestHRP  = kHRP
            end
        end
    end

    return nearestHRP
end

local function applyAxeBoost(hrp)
    task.wait(AxeBoostConfig.Delay)

    local targetHRP = getNearestKillerHRP(hrp)
    if not targetHRP then return end

    local flat = Vector3.new(
        targetHRP.Position.X - hrp.Position.X,
        0,
        targetHRP.Position.Z - hrp.Position.Z
    ).Unit
    hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + flat)

    local start = tick()
    local conn
    conn = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - start
        if elapsed > AxeBoostConfig.Duration then
            conn:Disconnect()
            hrp.AssemblyLinearVelocity = Vector3.zero
            return
        end
        if targetHRP.Parent then
            local dir   = (targetHRP.Position - hrp.Position).Unit
            local alpha = math.sin((elapsed / AxeBoostConfig.Duration) * math.pi)
            hrp.AssemblyLinearVelocity = dir * AxeBoostConfig.Power * alpha
        end
    end)
end

local function setup(char)
    task.wait(1)
    local humanoid = char:WaitForChild("Humanoid")
    local hrp      = char:WaitForChild("HumanoidRootPart")

    humanoid.AnimationPlayed:Connect(function(track)
        if not AxeBoostConfig.Enabled then return end
        if axeAnims[track.Animation.AnimationId] then
            task.spawn(function()
                applyAxeBoost(hrp)
            end)
        end
    end)
end

Players.LocalPlayer.CharacterAdded:Connect(setup)
if Players.LocalPlayer.Character then
    setup(Players.LocalPlayer.Character)
end

end


do
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local workspace = game:GetService("Workspace")

    local function isValidObject(obj)
        if not obj then return false end
        local s, r = pcall(function() return obj.Parent and obj:IsDescendantOf(workspace) end)
        return s and r
    end

    local function isAlive(m)
        if not isValidObject(m) then return false end
        local h = m:FindFirstChildOfClass("Humanoid")
        return h and h.Health > 0
    end

    local function getPlayerFromCharacter(c)
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character == c then return p end
        end
    end

    local function isPlayerCharacter(m)
        return getPlayerFromCharacter(m) ~= nil
    end

    local function getRootPart()
        local char = LocalPlayer.Character
        return char and char:FindFirstChild("HumanoidRootPart")
    end

    local function teleportTo(targetCFrame)
        local root = getRootPart()
        if not root then

            return false
        end
        root.CFrame = targetCFrame + Vector3.new(0, 3, 0)
        return true
    end

    local function getDistance(part)
        local root = getRootPart()
        if not root or not part then return math.huge end
        return (root.Position - part.Position).Magnitude
    end

    local teleportTargets = {
        Killer = {
            displayName = "Killer",
            getTargets = function()
                local t = {}
                local kf = workspace:FindFirstChild("Players")
                kf = kf and kf:FindFirstChild("Killers")
                if kf then
                    for _, k in ipairs(kf:GetChildren()) do
                        if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") and isPlayerCharacter(k) and k ~= LocalPlayer.Character and isAlive(k) then
                            local player = getPlayerFromCharacter(k)
                            local name = player and player.Name or k.Name
                            t[#t+1] = {part = k.HumanoidRootPart, name = "Killer: " .. name}
                        end
                    end
                end
                return t
            end
        },
        Survivor = {
            displayName = "Survivor",
            getTargets = function()
                local t = {}
                local sf = workspace:FindFirstChild("Players")
                sf = sf and sf:FindFirstChild("Survivors")
                if sf then
                    for _, s in ipairs(sf:GetChildren()) do
                        if s:IsA("Model") and s:FindFirstChild("HumanoidRootPart") and s ~= LocalPlayer.Character and isAlive(s) then
                            local player = getPlayerFromCharacter(s)
                            local name = player and player.Name or s.Name
                            t[#t+1] = {part = s.HumanoidRootPart, name = "Survivor: " .. name}
                        end
                    end
                end
                return t
            end
        },
        NoliClone = {
            displayName = "Noli Clone",
            getTargets = function()
                local t = {}
                local kf = workspace:FindFirstChild("Players")
                kf = kf and kf:FindFirstChild("Killers")
                if kf then
                    for _, k in ipairs(kf:GetChildren()) do
                        if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") and not isPlayerCharacter(k) then
                            t[#t+1] = {part = k.HumanoidRootPart, name = "Noli Clone: " .. k.Name}
                        end
                    end
                end
                return t
            end
        },
        Minion = {
            displayName = "Minion",
            getTargets = function()
                local t = {}
                local kf = workspace:FindFirstChild("Players")
                kf = kf and kf:FindFirstChild("Killers")
                if kf then
                    for _, k in ipairs(kf:GetChildren()) do
                        if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") and not isPlayerCharacter(k) then
                            t[#t+1] = {part = k.HumanoidRootPart, name = "Minion: " .. k.Name}
                        end
                    end
                end
                return t
            end
        },
        Medkit = {
            displayName = "Medkit",
            getTargets = function()
                local t = {}
                local ig = workspace:FindFirstChild("Map")
                ig = ig and ig:FindFirstChild("Ingame")
                if ig then
                    for _, obj in ipairs(ig:GetChildren()) do
                        if obj.Name == "Medkit" and obj:IsA("Model") then
                            local itemRoot = obj:FindFirstChild("ItemRoot")
                            if itemRoot and itemRoot:IsA("BasePart") then
                                t[#t+1] = {part = itemRoot, name = "Medkit"}
                            end
                        end
                    end
                end
                return t
            end
        },
        BloxyCola = {
            displayName = "Bloxy Cola",
            getTargets = function()
                local t = {}
                local ig = workspace:FindFirstChild("Map")
                ig = ig and ig:FindFirstChild("Ingame")
                if ig then
                    for _, obj in ipairs(ig:GetChildren()) do
                        if obj.Name == "BloxyCola" and obj:IsA("Model") then
                            local itemRoot = obj:FindFirstChild("ItemRoot")
                            if itemRoot and itemRoot:IsA("BasePart") then
                                t[#t+1] = {part = itemRoot, name = "Bloxy Cola"}
                            end
                        end
                    end
                end
                return t
            end
        },
        Generator = {
            displayName = "Generator",
            getTargets = function()
                local t = {}
                local ig = workspace:FindFirstChild("Map")
                ig = ig and ig:FindFirstChild("Ingame")
                if ig then
                    for _, obj in ipairs(ig:GetChildren()) do
                        if obj.Name == "Generator" then
                            if obj:IsA("BasePart") then
                                t[#t+1] = {part = obj, name = "Generator #" .. (#t+1)}
                            elseif obj:IsA("Model") and obj.PrimaryPart then
                                t[#t+1] = {part = obj.PrimaryPart, name = "Generator #" .. (#t+1)}
                            end
                        end
                    end
                end
                return t
            end
        },
        FakeGenerator = {
            displayName = "Fake Generator",
            getTargets = function()
                local t = {}
                local ig = workspace:FindFirstChild("Map")
                ig = ig and ig:FindFirstChild("Ingame")
                if ig then
                    for _, obj in ipairs(ig:GetChildren()) do
                        if obj.Name == "FakeGenerator" then
                            if obj:IsA("BasePart") then
                                t[#t+1] = {part = obj, name = "Fake Gen #" .. (#t+1)}
                            elseif obj:IsA("Model") and obj.PrimaryPart then
                                t[#t+1] = {part = obj.PrimaryPart, name = "Fake Gen #" .. (#t+1)}
                            end
                        end
                    end
                end
                return t
            end
        },
        Sentry = {
            displayName = "Sentry/Dispenser",
            getTargets = function()
                local t = {}
                local ig = workspace:FindFirstChild("Map")
                ig = ig and ig:FindFirstChild("Ingame")
                if ig then
                    for _, obj in ipairs(ig:GetChildren()) do
                        if obj:IsA("Model") and obj.PrimaryPart then
                            if obj.Name == "BuildermanSentry" then
                                t[#t+1] = {part = obj.PrimaryPart, name = "Sentry"}
                            elseif obj.Name == "BuildermanDispenser" then
                                t[#t+1] = {part = obj.PrimaryPart, name = "Dispenser"}
                            end
                        end
                    end
                end
                return t
            end
        },
        Gingerbread = {
            displayName = "Gingerbread",
            getTargets = function()
                local t = {}
                local ig = workspace:FindFirstChild("Map")
                ig = ig and ig:FindFirstChild("Ingame")
                local cf = ig and ig:FindFirstChild("CurrencyLocations")
                if cf then
                    for _, item in ipairs(cf:GetDescendants()) do
                        if item:IsA("BasePart") and isValidObject(item) then
                            t[#t+1] = {part = item, name = "Gingerbread"}
                        end
                    end
                end
                return t
            end
        },
        Graffiti = {
            displayName = "Graffiti",
            getTargets = function()
                local t = {}
                local ig = workspace:FindFirstChild("Map")
                ig = ig and ig:FindFirstChild("Ingame")
                if ig then
                    for _, spray in ipairs(ig:GetChildren()) do
                        if spray:IsA("Model") then
                            local hb = spray:FindFirstChild("Hitbox")
                            if hb and hb:IsA("BasePart") then
                                t[#t+1] = {part = hb, name = "Graffiti #" .. (#t+1)}
                            end
                        end
                    end
                end
                return t
            end
        },
        JohnDoeFootprint = {
            displayName = "Footprint",
            getTargets = function()
                local t = {}
                local ig = workspace:FindFirstChild("Map")
                ig = ig and ig:FindFirstChild("Ingame")
                if ig then
                    for _, obj in ipairs(ig:GetChildren()) do
                        if obj:IsA("Model") then
                            local sh = obj:FindFirstChild("Shadow")
                            if sh and sh:IsA("BasePart") then
                                t[#t+1] = {part = sh, name = "Footprint #" .. (#t+1)}
                            end
                        end
                    end
                end
                return t
            end
        },
        Ritual = {
            displayName = "Ritual",
            getTargets = function()
                local t = {}
                local ig = workspace:FindFirstChild("Map")
                ig = ig and ig:FindFirstChild("Ingame")
                if ig then
                    for _, child in ipairs(ig:GetChildren()) do
                        if child:IsA("BasePart") and (child.Name:find("Respawn") or child.Name:find("respawn")) then
                            local ef = child:FindFirstChild("EnabledFloor")
                            if ef then
                                t[#t+1] = {part = child, name = "Ritual #" .. (#t+1)}
                            end
                        end
                    end
                end
                return t
            end
        },
        Trapwire = {
            displayName = "Trapwire",
            getTargets = function()
                local t = {}
                local ig = workspace:FindFirstChild("Map")
                ig = ig and ig:FindFirstChild("Ingame")
                if ig then
                    for _, obj in ipairs(ig:GetChildren()) do
                        if obj:IsA("Model") and obj.Name:find("TaphTripwire") then
                            local wire = obj:FindFirstChild("Wire")
                            if wire and wire:IsA("BasePart") then
                                t[#t+1] = {part = wire, name = "Trapwire #" .. (#t+1)}
                            end
                        end
                    end
                end
                return t
            end
        },
        SubspaceTripmine = {
            displayName = "Tripmine",
            getTargets = function()
                local t = {}
                local ig = workspace:FindFirstChild("Map")
                ig = ig and ig:FindFirstChild("Ingame")
                if ig then
                    for _, obj in ipairs(ig:GetChildren()) do
                        if obj:IsA("Model") and obj.Name == "SubspaceTripmine" then
                            local box = obj:FindFirstChild("SubspaceBox")
                            if box and box:IsA("BasePart") then
                                t[#t+1] = {part = box, name = "Tripmine #" .. (#t+1)}
                            end
                        end
                    end
                end
                return t
            end
        }
    }

    local function teleportToNearest(targetType)
        local config = teleportTargets[targetType]
        if not config then

            return false
        end

        local targets = config.getTargets()

        if #targets == 0 then

            return false
        end

        local nearest, nearestDist = nil, math.huge
        for _, target in ipairs(targets) do
            if isValidObject(target.part) then
                local dist = getDistance(target.part)
                if dist < nearestDist then
                    nearest = target
                    nearestDist = dist
                end
            end
        end

        if nearest and isValidObject(nearest.part) then
            local success = teleportTo(nearest.part.CFrame)
            if success then
            end
            return success
        end


        return false
    end


    local PlayersSection = Tabs.Teleport:Section({
        Title = "传送玩家",
        Icon = "users",
        Opened = false
    })

    PlayersSection:Button({
        Title = "传送到 Killer",
        Callback = function() teleportToNearest("Killer") end
    })

    PlayersSection:Button({
        Title = "传送到 Survivor",
        Callback = function() teleportToNearest("Survivor") end
    })

    PlayersSection:Button({
        Title = "传送到 Noli Clone",
        Callback = function() teleportToNearest("NoliClone") end
    })

    PlayersSection:Button({
        Title = "传送到 Minion",
        Callback = function() teleportToNearest("Minion") end
    })

    local ItemsSection = Tabs.Teleport:Section({
        Title = "传送物品",
        Icon = "package",
        Opened = false
    })

    ItemsSection:Button({
        Title = "传送到 Medkit",
        Callback = function() teleportToNearest("Medkit") end
    })

    ItemsSection:Button({
        Title = "传送到 BloxyCola",
        Callback = function() teleportToNearest("BloxyCola") end
    })

    local MapSection = Tabs.Teleport:Section({
        Title = "传送到地图对象",
        Icon = "map",
        Desc = "",
        Opened = false
    })

    MapSection:Button({
        Title = "传送到 Generator",
        Callback = function() teleportToNearest("Generator") end
    })

    MapSection:Button({
        Title = "传送到 Fake Generator",
        Callback = function() teleportToNearest("FakeGenerator") end
    })

    MapSection:Button({
        Title = "传送到 Sentry/Dispenser",
        Callback = function() teleportToNearest("Sentry") end
    })

    local MiscSection = Tabs.Teleport:Section({
        Title = "其他传送点",
        Icon = "star",
        Opened = false
    })

    MiscSection:Button({
        Title = "传送到 Gingerbread",
        Callback = function() teleportToNearest("Gingerbread") end
    })

    MiscSection:Button({
        Title = "传送到 Graffiti",
        Callback = function() teleportToNearest("Graffiti") end
    })

    MiscSection:Button({
        Title = "传送到 Footprint",
        Callback = function() teleportToNearest("JohnDoeFootprint") end
    })

    MiscSection:Button({
        Title = "传送到 Ritual",
        Callback = function() teleportToNearest("Ritual") end
    })

    MiscSection:Button({
        Title = "传送到 Trapwire",
        Callback = function() teleportToNearest("Trapwire") end
    })

    MiscSection:Button({
        Title = "传送到 Tripmine",
        Callback = function() teleportToNearest("SubspaceTripmine") end
    })
end


do
    local autoPickupEnabled = false
    local droppedTools      = {}
    local pickUpNear        = false
    local pickUpAll         = false
    local trackedItems      = {}

    local function isAlive(char)
        return char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0
    end

    local function dropAllTools(char)
        table.clear(droppedTools)
        for _, v in ipairs(LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") then table.insert(droppedTools, v.Name); v.Parent = workspace end
        end
        for _, v in ipairs(char:GetChildren()) do
            if v:IsA("Tool") then table.insert(droppedTools, v.Name); v.Parent = workspace end
        end
    end

    LocalPlayer.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid").Died:Connect(function()
            if autoPickupEnabled then dropAllTools(char) end
        end)
    end)

    task.spawn(function()
        while task.wait() do
            local char = LocalPlayer.Character
            if autoPickupEnabled and isAlive(char) then
                local mapIngame = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
                if mapIngame then
                    for _, tool in ipairs(mapIngame:GetChildren()) do
                        if tool:IsA("Tool") then char.Humanoid:EquipTool(tool) end
                    end
                end
                for _, name in ipairs(droppedTools) do
                    local found = workspace:FindFirstChild(name, true)
                    if found and found:IsA("Tool") then char.Humanoid:EquipTool(found) end
                end
            end
        end
    end)

    local function trackTool(tool)
        if tool:IsA("Tool") and tool:FindFirstChild("ItemRoot") then
            table.insert(trackedItems, tool.ItemRoot)
        end
    end

    local function untrackTool(tool)
        if tool:IsA("Tool") and tool:FindFirstChild("ItemRoot") then
            for i, v in ipairs(trackedItems) do
                if v == tool.ItemRoot then table.remove(trackedItems, i); break end
            end
        end
    end

    local function initTrack()
        trackedItems = {}
        local map = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
        if map then
            for _, v in ipairs(map:GetDescendants()) do trackTool(v) end
            map.DescendantAdded:Connect(trackTool)
            map.DescendantRemoving:Connect(untrackTool)
        end
    end
    initTrack()

    local function pickupLoop()
        while task.wait() do
            if not pickUpNear and not pickUpAll then break end
            pcall(function()
                local char = LocalPlayer.Character
                local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                if not char or not hrp then return end
                for _, v in ipairs(trackedItems) do
                    if v and v.Parent then
                        if pickUpNear and (hrp.Position - v.Position).Magnitude <= 10 then
                            if fireproximityprompt then
                                fireproximityprompt(v.ProximityPrompt)
                            elseif v.ProximityPrompt then
                                v.ProximityPrompt.HoldDuration = 0
                                v.ProximityPrompt.Enabled = true
                                v.ProximityPrompt:InputHoldBegin()
                                task.wait()
                                v.ProximityPrompt:InputHoldEnd()
                            end
                        end
                        if pickUpAll and not LocalPlayer.Backpack:FindFirstChild(v.Parent.Name) then
                            hrp.CFrame = v.CFrame
                            task.wait()
                            if fireproximityprompt then
                                fireproximityprompt(v.ProximityPrompt)
                            elseif v.ProximityPrompt then
                                v.ProximityPrompt.HoldDuration = 0
                                v.ProximityPrompt.Enabled = true
                                v.ProximityPrompt:InputHoldBegin()
                                task.wait()
                                v.ProximityPrompt:InputHoldEnd()
                            end
                        end
                    end
                end
            end)
        end
    end

    local autoPickupSection = Tabs.Teleport:Section({
        Title = "自动拾取物品",
        Icon = "package",
        Opened = false,
    })

    autoPickupSection:Toggle({
        Flag = "AutoPickupDropItems",
        Title = "自动拾取+放下物品[死亡时]",
        Default = false,
        Callback = function(state) autoPickupEnabled = state end
    })

    autoPickupSection:Toggle({
        Flag = "AutoPickUpNear",
        Title = "自动拾取附近的项目[距离10]",
        Default = false,
        Callback = function(state)
            pickUpNear = state
            if state then task.spawn(pickupLoop) end
        end
    })

    autoPickupSection:Toggle({
        Flag = "AutoPickUpAll",
        Title = "自动拾取所有物品[传送]",
        Default = false,
        Callback = function(state)
            pickUpAll = state
            if state then task.spawn(pickupLoop) end
        end
    })
end


do

local Players             = game:GetService("Players")
local RunService          = game:GetService("RunService")
local Workspace           = game:GetService("Workspace")
local PathfindingService  = game:GetService("PathfindingService")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")

local localPlayer  = Players.LocalPlayer
local PlayerModule = require(localPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
local Controls     = PlayerModule:GetControls()
local sprintModule = nil
pcall(function() sprintModule = require(ReplicatedStorage.Systems.Character.Game.Sprinting) end)

local CHASE_DISTANCE         = 100
local PATH_REFRESH_COOLDOWN  = 0.3
local SPRINT_SPEED           = 40
local PREDICTION_TIME        = 1.5
local TARGET_SWITCH_COOLDOWN = 2
local PREDICTION_PATHS       = 1
local TARGET_MODE            = "Closest"
local DEVIATION_THRESHOLD    = 12

local STUCK_TIME_THRESHOLD   = 2
local STUCK_DIST_THRESHOLD   = 3
local STUCK_ESCAPE_DURATION  = 5
local STUCK_AGENT_RADIUS     = 4

local PHANTOM_SCAN_INTERVAL  = 3
local PHANTOM_SCAN_RADIUS    = 150

local character, humanoid, rootPart, humanoidDiedConnection
local scriptEnabled        = false
local isStopping           = false

local currentTarget        = nil
local manualTarget         = nil
local lastPathTime         = 0
local lastTargetSwitchTime = 0
local currentPath          = nil
local currentPathObject    = nil
local pathBlockedConn      = nil
local currentWaypointIndex = 1
local isMovementLocked     = false
local pathTargetPos        = nil

local raycastParams        = RaycastParams.new()

local survivorPositionHistory = {}
local myPositionHistory       = {}
local lastStuckCheck          = 0
local isStuck                 = false
local stuckEscapeUntil        = 0
local posHistoryTimer         = 0

local phantomFolder  = nil
local phantomCount   = 0

local VIZ_COLORS = {
    movement   = Color3.fromRGB(210, 40,  40),
    prediction = Color3.fromRGB(50,  215, 75),
    stuck      = Color3.fromRGB(255, 150,  0),
}

local vizFolders     = {}
local vizRedrawTimer = 0
local VIZ_REDRAW_INTERVAL = 0.25

local function getVizFolder(name)
    if not vizFolders[name] or not vizFolders[name].Parent then
        local f  = Instance.new("Folder")
        f.Name   = "AIViz_" .. name
        f.Parent = Workspace
        vizFolders[name] = f
    end
    return vizFolders[name]
end

local function clearAllViz()
    for _, folder in pairs(vizFolders) do
        if folder and folder.Parent then folder:ClearAllChildren() end
    end
end

local function makeSeg(p1, p2, color, folder)
    local dist = (p1 - p2).Magnitude
    if dist < 0.1 then return end
    local mid  = (p1 + p2) / 2
    local seg        = Instance.new("Part")
    seg.Anchored     = true
    seg.CanCollide   = false
    seg.CanQuery     = false
    seg.CastShadow   = false
    seg.Material     = Enum.Material.Neon
    seg.Color        = color
    seg.Transparency = 0.15
    seg.Size         = Vector3.new(0.1, 0.1, dist)
    seg.CFrame       = CFrame.new(mid, p2)
    seg.Parent       = folder
end

local function makeNode(pos, color, folder, size)
    local dot        = Instance.new("Part")
    dot.Anchored     = true
    dot.CanCollide   = false
    dot.CanQuery     = false
    dot.CastShadow   = false
    dot.Shape        = Enum.PartType.Ball
    dot.Material     = Enum.Material.Neon
    dot.Color        = color
    dot.Transparency = 0.0
    dot.Size         = Vector3.new(size, size, size)
    dot.Position     = pos
    dot.Parent       = folder
end

local function drawMovementPath(waypoints, colorKey)
    local color  = VIZ_COLORS[colorKey]
    local folder = getVizFolder(colorKey)
    folder:ClearAllChildren()
    for i = 1, #waypoints - 1 do
        local p1 = (waypoints[i].Position   or waypoints[i])   + Vector3.new(0, 0.15, 0)
        local p2 = (waypoints[i+1].Position or waypoints[i+1]) + Vector3.new(0, 0.15, 0)
        makeSeg(p1, p2, color, folder)
    end
    for i, wp in ipairs(waypoints) do
        local pos  = (wp.Position or wp) + Vector3.new(0, 0.15, 0)
        local size = (i == 1 or i == #waypoints) and 0.35 or 0.22
        makeNode(pos, color, folder, size)
    end
end

local function drawPredictionLine(fromPos, toPos)
    local color  = VIZ_COLORS.prediction
    local folder = getVizFolder("prediction")
    folder:ClearAllChildren()
    local f = fromPos + Vector3.new(0, 0.2, 0)
    local t = toPos   + Vector3.new(0, 0.2, 0)
    makeSeg(f, t, color, folder)
    makeNode(t, color, folder, 0.55)
end

local function getOrCreatePhantomFolder()
    if phantomFolder and phantomFolder.Parent then return phantomFolder end
    local existing = Workspace:FindFirstChild("PhantomWalls")
    if existing then existing:Destroy() end
    local f    = Instance.new("Folder")
    f.Name     = "PhantomWalls"
    f.Parent   = Workspace
    phantomFolder = f
    return f
end

local function scanPhantomWalls()
    if not rootPart then return end
    local folder = getOrCreatePhantomFolder()
    folder:ClearAllChildren()
    phantomCount = 0
    local origin = rootPart.Position
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart")
            and not part.CanQuery
            and part.Size.Magnitude > 1
            and (part.Position - origin).Magnitude <= PHANTOM_SCAN_RADIUS
        then
            local phantom            = Instance.new("Part")
            phantom.Name             = "Phantom_" .. part.Name
            phantom.Size             = part.Size
            phantom.CFrame           = part.CFrame
            phantom.Anchored         = true
            phantom.CanCollide       = false
            phantom.CanQuery         = true
            phantom.CanTouch         = false
            phantom.Massless         = true
            phantom.Transparency     = 1
            phantom.CastShadow       = false
            phantom.Parent           = folder
            phantomCount             = phantomCount + 1
        end
    end
    raycastParams.FilterDescendantsInstances = character
        and { character, folder } or { folder }
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
end

task.spawn(function()
    while task.wait(PHANTOM_SCAN_INTERVAL) do
        if scriptEnabled then scanPhantomWalls() end
    end
end)

local function disablePlayerMovement()
    if not isMovementLocked then
        Controls:Disable()
        isMovementLocked = true
    end
end

local function enablePlayerMovement()
    if isMovementLocked then
        Controls:Enable()
        isMovementLocked = false
    end
end

local function disconnectPathBlocked()
    if pathBlockedConn then
        pathBlockedConn:Disconnect()
        pathBlockedConn = nil
    end
end

local function invalidatePath()
    currentPath       = nil
    currentPathObject = nil
    pathTargetPos     = nil
    disconnectPathBlocked()
    clearAllViz()
end

local function fullStop()
    invalidatePath()
    currentTarget = nil
    manualTarget  = nil
    isStuck       = false
    if not isMovementLocked then return end
    isStopping = true
    task.spawn(function()
        if humanoid then humanoid:Move(Vector3.zero) end
        local timeout = tick() + 3
        while tick() < timeout do
            if not humanoid or not rootPart then break end
            local vel = rootPart.AssemblyLinearVelocity
            if vel and Vector3.new(vel.X, 0, vel.Z).Magnitude < 1.5 then break end
            task.wait(0.1)
        end
        isStopping = false
        enablePlayerMovement()
        if sprintModule then sprintModule.SprintSpeed = 16
        elseif humanoid  then humanoid.WalkSpeed = 16 end
    end)
end

local function getSurvivorRootPart(model)
    return model and (
        model:FindFirstChild("HumanoidRootPart") or
        model.PrimaryPart or
        model:FindFirstChild("Torso")
    )
end

local function getSurvivorHumanoid(model)
    return model and model:FindFirstChild("Humanoid")
end

local function isTargetAlive(target)
    if not target or not target.Parent then return false end
    local hum  = getSurvivorHumanoid(target)
    local root = getSurvivorRootPart(target)
    return hum ~= nil and root ~= nil and hum.Health > 0
end

local function getAllSurvivors()
    local list   = {}
    local folder = Workspace:FindFirstChild("Players")
                   and Workspace.Players:FindFirstChild("Survivors")
    if not folder then return list end
    for _, child in pairs(folder:GetChildren()) do
        if child:IsA("Model") and isTargetAlive(child) then
            table.insert(list, child)
        end
    end
    return list
end

local function updateSurvivorHistory(survivor)
    local root = getSurvivorRootPart(survivor)
    if not root then return end
    local name = survivor.Name
    if not survivorPositionHistory[name] then survivorPositionHistory[name] = {} end
    local hist = survivorPositionHistory[name]
    table.insert(hist, { position = root.Position, time = tick() })
    while #hist > 20 do table.remove(hist, 1) end
end

task.spawn(function()
    while task.wait(0.1) do
        if scriptEnabled then
            for _, s in ipairs(getAllSurvivors()) do updateSurvivorHistory(s) end
        end
    end
end)

local function getSurvivorVelocity(survivor)
    local hist = survivorPositionHistory[survivor.Name]
    if not hist or #hist < 2 then return Vector3.zero end
    local a, b = hist[#hist], hist[#hist - 1]
    local dt   = a.time - b.time
    return dt > 0 and (a.position - b.position) / dt or Vector3.zero
end

local function predictSurvivorPosition(survivor, timeAhead)
    local root = getSurvivorRootPart(survivor)
    if not root then return nil end
    return root.Position + getSurvivorVelocity(survivor) * timeAhead
end

local function findBestTarget()
    if not rootPart then return nil end
    if TARGET_MODE == "Manual" then
        if isTargetAlive(manualTarget) then return manualTarget end
        manualTarget = nil
    end
    local survivors       = getAllSurvivors()
    local best, bestScore = nil, math.huge
    for _, s in ipairs(survivors) do
        local root = getSurvivorRootPart(s)
        if root then
            local dist = (rootPart.Position - root.Position).Magnitude
            if dist <= CHASE_DISTANCE then
                local score
                if TARGET_MODE == "LowHP" then
                    local hum     = getSurvivorHumanoid(s)
                    local hpRatio = (hum and hum.MaxHealth > 0)
                                    and (hum.Health / hum.MaxHealth) or 1
                    score = dist * hpRatio
                else
                    score = dist
                end
                if s == currentTarget then score = score * 0.65 end
                if score < bestScore then bestScore = score; best = s end
            end
        end
    end
    return best
end

local function calculatePath(fromPos, toPos, agentRadius)
    agentRadius = agentRadius or 3
    local path  = PathfindingService:CreatePath({
        AgentRadius   = agentRadius,
        AgentHeight   = 6,
        AgentCanJump  = false,
        AgentCanClimb = false,
        Costs         = { Water = 100 }
    })
    local ok = pcall(function() path:ComputeAsync(fromPos, toPos) end)
    if ok and path.Status == Enum.PathStatus.Success then return path end
    return nil
end

local function getWaypointPathLength(waypoints)
    local len = 0
    for i = 1, #waypoints - 1 do
        len = len + (waypoints[i].Position - waypoints[i+1].Position).Magnitude
    end
    return len
end

local function connectPathBlocked(pathObj)
    disconnectPathBlocked()
    pathBlockedConn = pathObj.Blocked:Connect(function(blockedIdx)
        if blockedIdx >= currentWaypointIndex then
            invalidatePath()
            lastPathTime = 0
        end
    end)
end

local lastPredPos     = nil
local lastTargetRoot  = nil

local function applyPath(pathObj, predPos, targetRootPos)
    local waypoints = pathObj:GetWaypoints()
    if not waypoints or #waypoints <= 1 then return false end
    currentPath          = waypoints
    currentPathObject    = pathObj
    currentWaypointIndex = 2
    pathTargetPos        = predPos or targetRootPos
    lastPredPos          = predPos
    lastTargetRoot       = targetRootPos
    connectPathBlocked(pathObj)
    drawMovementPath(currentPath, isStuck and "stuck" or "movement")
    if predPos and targetRootPos then
        drawPredictionLine(targetRootPos, predPos)
    end
    return true
end

local function buildPath(survivor, agentRadius)
    local root = getSurvivorRootPart(survivor)
    if not root or not rootPart then return false end
    agentRadius = agentRadius or 3

    if PREDICTION_PATHS <= 1 then
        local predPos  = predictSurvivorPosition(survivor, PREDICTION_TIME)
        local chasePos = predPos or root.Position
        local path     = calculatePath(rootPart.Position, chasePos, agentRadius)
        if path then return applyPath(path, predPos, root.Position) end
        local fallback = calculatePath(rootPart.Position, root.Position, agentRadius)
        if fallback then return applyPath(fallback, nil, root.Position) end
        return false
    end

    local tMin     = PREDICTION_TIME * 0.3
    local tMax     = PREDICTION_TIME * 2.0
    local numPaths = math.clamp(PREDICTION_PATHS, 2, 10)
    local bestPath, bestLength, bestPredPos = nil, math.huge, nil

    for i = 1, numPaths do
        local t         = tMin + (tMax - tMin) * ((i - 1) / (numPaths - 1))
        local predicted = predictSurvivorPosition(survivor, t)
        if predicted then
            local path = calculatePath(rootPart.Position, predicted, agentRadius)
            if path then
                local len = getWaypointPathLength(path:GetWaypoints())
                if len < bestLength then
                    bestLength  = len
                    bestPath    = path
                    bestPredPos = predicted
                end
            end
        end
    end

    if bestPath then return applyPath(bestPath, bestPredPos, root.Position) end
    local fallback = calculatePath(rootPart.Position, root.Position, agentRadius)
    if fallback then return applyPath(fallback, nil, root.Position) end
    return false
end

local function updateMyPositionHistory()
    if not rootPart then return end
    table.insert(myPositionHistory, { position = rootPart.Position, time = tick() })
    while #myPositionHistory > 40 do table.remove(myPositionHistory, 1) end
end

local function checkIfStuck()
    if not isMovementLocked or not rootPart then return false end
    if tick() < stuckEscapeUntil then return false end
    local now = tick()
    if now - lastStuckCheck < 0.5 then return false end
    lastStuckCheck = now
    local cutoff   = now - STUCK_TIME_THRESHOLD
    local oldEntry = nil
    for _, e in ipairs(myPositionHistory) do
        if e.time >= cutoff then oldEntry = e; break end
    end
    if not oldEntry then return false end
    return (rootPart.Position - oldEntry.position).Magnitude < STUCK_DIST_THRESHOLD
end

local function directChase(targetPos)
    if not rootPart or not targetPos or not humanoid then return end
    humanoid:Move((targetPos - rootPart.Position).Unit)
end

local function followWaypoint(waypoint)
    if not rootPart or not waypoint or not humanoid then return end
    local targetPos = waypoint.Position
    humanoid:Move((targetPos - rootPart.Position).Unit)
    local flatDist = Vector3.new(
        targetPos.X - rootPart.Position.X, 0,
        targetPos.Z - rootPart.Position.Z
    ).Magnitude
    if flatDist < 3 then
        currentWaypointIndex = currentWaypointIndex + 1
    end
end

local function initializeCharacter(newChar)
    character = newChar
    humanoid  = character:WaitForChild("Humanoid")
    rootPart  = character:WaitForChild("HumanoidRootPart")
    if humanoidDiedConnection then humanoidDiedConnection:Disconnect() end
    humanoidDiedConnection = humanoid.Died:Connect(function()
        fullStop()
        character, humanoid, rootPart = nil, nil, nil
        clearAllViz()
    end)
    raycastParams.FilterDescendantsInstances = { character }
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
end

if localPlayer.Character then initializeCharacter(localPlayer.Character) end
localPlayer.CharacterAdded:Connect(initializeCharacter)

local aiSection = Tabs.AI:Section({
    Title  = "AI模式",
    Icon   = "cpu",
    Opened = false,
})

aiSection:Toggle({
    Flag     = "EnableKillerAI",
    Title    = "杀手自动游玩",
    Default  = false,
    Callback = function(state)
        scriptEnabled = state
        if state then
            isStopping = false
            scanPhantomWalls()
            if sprintModule then sprintModule.SprintSpeed = SPRINT_SPEED
            elseif humanoid  then humanoid.WalkSpeed = SPRINT_SPEED end
      
        else
            fullStop()
        
        end
    end
})

aiSection:Slider({
    Flag     = "ChaseDistance",
    Title    = "追逐距离",
    Step     = 1,
    Value    = { Min = 20, Max = 300, Default = CHASE_DISTANCE },
    Suffix   = " studs",
    Callback = function(v) CHASE_DISTANCE = tonumber(v) end
})

aiSection:Slider({
    Flag     = "PredictionTime",
    Title    = "预测时间",
    Step     = 0.1,
    Value    = { Min = 0.5, Max = 5, Default = PREDICTION_TIME },
    Suffix   = "s",
    Callback = function(v) PREDICTION_TIME = tonumber(v) end
})

aiSection:Slider({
    Flag     = "PathRefreshRate",
    Title    = "路径刷新率",
    Step     = 0.1,
    Value    = { Min = 0.1, Max = 2, Default = PATH_REFRESH_COOLDOWN },
    Suffix   = "s",
    Callback = function(v) PATH_REFRESH_COOLDOWN = tonumber(v) end
})

aiSection:Slider({
    Flag     = "TargetSwitchCooldown",
    Title    = "目标切换冷却",
    Step     = 0.5,
    Value    = { Min = 0.5, Max = 10, Default = TARGET_SWITCH_COOLDOWN },
    Suffix   = "s",
    Callback = function(v) TARGET_SWITCH_COOLDOWN = tonumber(v) end
})

aiSection:Slider({
    Flag     = "DeviationThreshold",
    Title    = "偏差阈值",
    Step     = 1,
    Value    = { Min = 5, Max = 40, Default = DEVIATION_THRESHOLD },
    Suffix   = " studs",
    Callback = function(v) DEVIATION_THRESHOLD = tonumber(v) end
})

aiSection:Slider({
    Flag     = "PredictionPaths",
    Title    = "预测路径",
    Step     = 1,
    Value    = { Min = 1, Max = 10, Default = PREDICTION_PATHS },
    Suffix   = "x",
    Callback = function(v) PREDICTION_PATHS = tonumber(v) end
})

aiSection:Dropdown({
    Flag     = "TargetMode",
    Title    = "目标模式",
    Values   = { "Closest", "LowHP", "Manual" },
    Default  = "Closest",
    Callback = function(v)
        TARGET_MODE = v
        if v ~= "Manual" then manualTarget = nil end
        WindUI:Notify({ Title = "AI", Content = "Target: " .. v, Duration = 1.5 })
    end
})

aiSection:Button({
    Title    = "设置手动目标[最近]",
    Callback = function()
        if not rootPart then return end
        local nearest, nearestDist = nil, math.huge
        for _, s in ipairs(getAllSurvivors()) do
            local r = getSurvivorRootPart(s)
            if r then
                local d = (rootPart.Position - r.Position).Magnitude
                if d < nearestDist then nearestDist = d; nearest = s end
            end
        end
        if nearest then
            manualTarget = nearest
            TARGET_MODE  = "Manual"
            WindUI:Notify({ Title = "AI", Content = "Manual → " .. nearest.Name, Duration = 2 })
        else
            WindUI:Notify({ Title = "AI", Content = "No survivors found", Duration = 2 })
        end
    end
})

RunService.Heartbeat:Connect(function(dt)
    posHistoryTimer  = posHistoryTimer  + dt
    vizRedrawTimer   = vizRedrawTimer   + dt

    if posHistoryTimer >= 0.2 then
        posHistoryTimer = 0
        updateMyPositionHistory()
    end

    if isStopping then
        if humanoid then humanoid:Move(Vector3.zero) end
        return
    end

    if not scriptEnabled
    or not character or not rootPart or not rootPart.Parent
    or not humanoid  or humanoid.Health <= 0 then
        return
    end

    if sprintModule then sprintModule.SprintSpeed = SPRINT_SPEED
    else humanoid.WalkSpeed = SPRINT_SPEED end

    local canSwitch = tick() - lastTargetSwitchTime > TARGET_SWITCH_COOLDOWN
    if canSwitch or currentTarget == nil then
        local newTarget = findBestTarget()
        if newTarget ~= currentTarget then
            currentTarget = newTarget
            invalidatePath()
            if newTarget then lastTargetSwitchTime = tick() end
        end
    end

    if not currentTarget then
        if isMovementLocked then enablePlayerMovement() end
        if humanoid then humanoid:Move(Vector3.zero) end
        return
    end

    if not isTargetAlive(currentTarget) then
        currentTarget = nil
        invalidatePath()
        enablePlayerMovement()
        return
    end

    local targetRoot   = getSurvivorRootPart(currentTarget)
    local distToTarget = (rootPart.Position - targetRoot.Position).Magnitude

    if distToTarget > CHASE_DISTANCE then
        currentTarget = nil
        invalidatePath()
        enablePlayerMovement()
        return
    end

    disablePlayerMovement()

    if checkIfStuck() and not isStuck then
        isStuck          = true
        stuckEscapeUntil = tick() + STUCK_ESCAPE_DURATION
        invalidatePath()
        lastPathTime     = 0
        WindUI:Notify({ Title = "AI", Content = "Stuck — rerouting", Duration = 2 })
    end
    if tick() > stuckEscapeUntil and isStuck then isStuck = false end

    local agentRadius = isStuck and STUCK_AGENT_RADIUS or 3

    if distToTarget < 15 then
        directChase(targetRoot.Position)
        return
    end

    local needRebuild = not currentPath
    if not needRebuild and pathTargetPos then
        if (targetRoot.Position - pathTargetPos).Magnitude > DEVIATION_THRESHOLD then
            needRebuild = true
        end
    end

    if needRebuild and tick() - lastPathTime > PATH_REFRESH_COOLDOWN then
        lastPathTime = tick()
        if not buildPath(currentTarget, agentRadius) then
            invalidatePath()
            directChase(targetRoot.Position)
        end
    end

    if vizRedrawTimer >= VIZ_REDRAW_INTERVAL and currentPath then
        vizRedrawTimer = 0
        drawMovementPath(currentPath, isStuck and "stuck" or "movement")
        if lastPredPos and lastTargetRoot then
            drawPredictionLine(lastTargetRoot, lastPredPos)
        end
    end

    if currentPath then
        if currentWaypointIndex > #currentPath then
            invalidatePath()
            return
        end
        followWaypoint(currentPath[currentWaypointIndex])
    end
end)


end


local flingSection = Tabs.Random:Section({
    Title = "甩飞",
    Icon = "wind",
    Opened = false,
})
local flingGui = nil
local flingActive = false
local function createFlingGui()
    if flingGui then return end
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local ToggleButton = Instance.new("TextButton")
    local TextLabel = Instance.new("TextLabel")
    local HideButton = Instance.new("TextButton")
    local PowerLabel = Instance.new("TextLabel")
    local PowerSlider = Instance.new("TextButton")
    local PowerBar = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TimerLabel = Instance.new("TextLabel")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.Position = UDim2.new(0.35, 0, 0.4, 0)
    Frame.Size = UDim2.new(0, 220, 0, 180)
    Frame.Active = true
    Frame.Draggable = true
    UICorner.Parent = Frame
    TextLabel.Parent = Frame
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 0.2, 0)
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.Text = "甩飞"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 22
    ToggleButton.Parent = Frame
    ToggleButton.Position = UDim2.new(0.1, 0, 0.3, 0)
    ToggleButton.Size = UDim2.new(0.8, 0, 0.2, 0)
    ToggleButton.Font = Enum.Font.SourceSansBold
    ToggleButton.Text = "关"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    ToggleButton.TextSize = 24
    UICorner:Clone().Parent = ToggleButton
    PowerLabel.Parent = Frame
    PowerLabel.BackgroundTransparency = 1
    PowerLabel.Position = UDim2.new(0.1, 0, 0.55, 0)
    PowerLabel.Size = UDim2.new(0.8, 0, 0.15, 0)
    PowerLabel.Font = Enum.Font.SourceSansBold
    PowerLabel.Text = "甩飞力量: 10000"
    PowerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    PowerLabel.TextSize = 18
    PowerBar.Parent = Frame
    PowerBar.Position = UDim2.new(0.1, 0, 0.7, 0)
    PowerBar.Size = UDim2.new(0.8, 0, 0.1, 0)
    PowerBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    UICorner:Clone().Parent = PowerBar
    PowerSlider.Parent = PowerBar
    PowerSlider.Size = UDim2.new(0.1, 0, 1, 0)
    PowerSlider.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    UICorner:Clone().Parent = PowerSlider
    TimerLabel.Parent = Frame
    TimerLabel.BackgroundTransparency = 1
    TimerLabel.Position = UDim2.new(0.1, 0, 0.85, 0)
    TimerLabel.Size = UDim2.new(0.8, 0, 0.15, 0)
    TimerLabel.Font = Enum.Font.SourceSansBold
    TimerLabel.Text = "Timer: 0s"
    TimerLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    TimerLabel.TextSize = 18
    HideButton.Parent = ScreenGui
    HideButton.Position = UDim2.new(0.05, 0, 0.9, 0)
    HideButton.Size = UDim2.new(0, 50, 0, 30)
    HideButton.Font = Enum.Font.SourceSansBold
    HideButton.Text = "Hide"
    HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    HideButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    UICorner:Clone().Parent = HideButton
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local hiddenfling = false
    local flingPower = 10000
    local lp = Players.LocalPlayer
    local dragging = false
    local function fling()
        local hrp, c, vel, movel = nil, nil, nil, 0.1
        while true do
            RunService.Heartbeat:Wait()
            if hiddenfling then
                local start = tick()
                while hiddenfling and tick() - start < 4 do
                    local left = 4 - math.floor(tick() - start)
                    TimerLabel.Text = "Active: " .. left .. "s"
                    RunService.Heartbeat:Wait()
                    c = lp.Character
                    hrp = c and c:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        vel = hrp.Velocity
                        hrp.Velocity = vel * flingPower + Vector3.new(0, flingPower, 0)
                        RunService.RenderStepped:Wait()
                        hrp.Velocity = vel
                        RunService.Stepped:Wait()
                        hrp.Velocity = vel + Vector3.new(0, movel, 0)
                        movel = movel * -1
                    end
                end
                local pauseStart = tick()
                while hiddenfling and tick() - pauseStart < 4 do
                    local left = 4 - math.floor(tick() - pauseStart)
                    TimerLabel.Text = "Pause: " .. left .. "s"
                    RunService.Heartbeat:Wait()
                end
            else
                TimerLabel.Text = "Timer: 0s"
            end
        end
    end
    ToggleButton.MouseButton1Click:Connect(function()
        hiddenfling = not hiddenfling
        if hiddenfling then
            ToggleButton.Text = "开"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            ToggleButton.Text = "关"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            TimerLabel.Text = "Timer: 0s"
        end
    end)
    HideButton.MouseButton1Click:Connect(function()
        Frame.Visible = not Frame.Visible
        if Frame.Visible then
            HideButton.Text = "Hide"
        else
            HideButton.Text = "Show"
        end
    end)
    PowerSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    PowerSlider.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local mousePos = input.Position.X
            local barPos = PowerBar.AbsolutePosition.X
            local barSize = PowerBar.AbsoluteSize.X
            local newPos = math.clamp((mousePos - barPos) / barSize, 0, 1)
            PowerSlider.Position = UDim2.new(newPos, 0, 0, 0)
            flingPower = math.floor(newPos * 50000) + 5000
            PowerLabel.Text = "Fling Power: " .. flingPower
        end
    end)
    task.spawn(fling)
    flingGui = ScreenGui
end
UIElements["ShowFlingUI"] = flingSection:Toggle({
    Title = "打开甩飞UI ",
    Default = false,
    Callback = function(state)
        ConfigValues.ShowFlingUI = state
        if state then
            createFlingGui()
            if flingGui then
                flingGui.Enabled = true
            end
        else
            if flingGui then
                flingGui.Enabled = false
            end
        end
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local ConfigValues = {
    AimbotEnable = false,
    AimbotTarget = "Survivors",
    AimbotMode = "CamLock+CharacterLock",
    Prediction = 0.165,
    Smoothness = 1,
    CheckWalls = false,
    MaxDistance = 500,
    ToggleKey = Enum.KeyCode.L,
    SwitchKey = Enum.KeyCode.T,
}

local aimbotConnection = nil
local guiButton = nil
local currentTarget = nil
local centerDotGui = nil
local isTargetLocked = false
local guiVisible = true

local function createCenterDot()
    if centerDotGui then return end
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CenterDotGUI"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    local dot = Instance.new("Frame")
    dot.Name = "CenterDot"
    dot.Size = UDim2.new(0, 3, 0, 3)
    dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dot.BorderSizePixel = 0
    dot.AnchorPoint = Vector2.new(0.5, 0.5)
    dot.Position = UDim2.new(0.5, 0, 0.5, 0)
    dot.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = dot

    local ring = Instance.new("Frame")
    ring.Name = "AimRing"
    ring.Size = UDim2.new(0, 12, 0, 12)
    ring.AnchorPoint = Vector2.new(0.5, 0.5)
    ring.Position = UDim2.new(0.5, 0, 0.5, 0)
    ring.BackgroundTransparency = 1
    ring.Parent = screenGui

    local ringCorner = Instance.new("UICorner")
    ringCorner.CornerRadius = UDim.new(1, 0)
    ringCorner.Parent = ring

    local ringStroke = Instance.new("UIStroke")
    ringStroke.Name = "RingStroke"
    ringStroke.Color = Color3.fromRGB(255, 50, 50)
    ringStroke.Thickness = 1
    ringStroke.Transparency = 0.3
    ringStroke.Parent = ring

    centerDotGui = screenGui
end

local function destroyCenterDot()
    if centerDotGui then
        centerDotGui:Destroy()
        centerDotGui = nil
    end
end

local function updateCenterDotVisual(hasTarget)
    if not centerDotGui then return end
    local ring = centerDotGui:FindFirstChild("AimRing")
    local color = hasTarget and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
    if ring then
        local ringStroke = ring:FindFirstChild("RingStroke")
        if ringStroke then
            TweenService:Create(ringStroke, TweenInfo.new(0.2), {Color = color}):Play()
        end
    end
end

local function isVisible(targetPart)
    if not ConfigValues.CheckWalls then return true end
    local cam = Workspace.CurrentCamera
    local origin = cam.CFrame.Position
    local direction = targetPart.Position - origin
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.IgnoreWater = true
    local result = Workspace:Raycast(origin, direction, raycastParams)
    if not result or result.Instance:IsDescendantOf(targetPart.Parent) then
        return true
    end
    return false
end

local function getPing()
    return LocalPlayer:GetNetworkPing()
end

local function getPredictedPosition(target)
    if not target or not target:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    local targetHrp = target.HumanoidRootPart
    local targetVelocity = targetHrp.AssemblyLinearVelocity or targetHrp.Velocity
    local ping = getPing()
    local predictionTime = ping + ConfigValues.Prediction
    return targetHrp.Position + (targetVelocity * predictionTime)
end

local function isTargetValid(target)
    if not target or not target.Parent then return false end
    local humanoid = target:FindFirstChild("Humanoid")
    local hrp = target:FindFirstChild("HumanoidRootPart")
    if not humanoid or not hrp then return false end
    if humanoid.Health <= 0 then return false end
    if ConfigValues.CheckWalls and not isVisible(hrp) then
        return false
    end
    return true
end

local function getDistanceToCenter(character)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return math.huge end
    local cam = Workspace.CurrentCamera
    local screenCenter = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    local screenPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
    if not onScreen then return math.huge end
    return (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
end

local function getAllTargets()
    local targets = {}
    local myChar = LocalPlayer.Character
    if not myChar then return targets end
    local playersFolder = Workspace:FindFirstChild("Players")
    if not playersFolder then return targets end
    local targetFolder = playersFolder:FindFirstChild(ConfigValues.AimbotTarget)
    if not targetFolder then return targets end
    for _, target in pairs(targetFolder:GetChildren()) do
        local targetHrp = target:FindFirstChild("HumanoidRootPart")
        local targetHumanoid = target:FindFirstChild("Humanoid")
        if targetHrp and targetHumanoid and targetHumanoid.Health > 0 and target ~= myChar then
            if isVisible(targetHrp) then
                table.insert(targets, target)
            end
        end
    end
    return targets
end

local function getClosestTarget()
    local targets = getAllTargets()
    local bestTarget = nil
    local bestValue = math.huge
    for _, target in ipairs(targets) do
        local value = getDistanceToCenter(target)
        if value < bestValue then
            bestValue = value
            bestTarget = target
        end
    end
    return bestTarget
end

local function clearTarget()
    currentTarget = nil
    isTargetLocked = false
end

local function switchTarget()
    local targets = getAllTargets()
    if #targets == 0 then
        currentTarget = nil
        return
    end
    if #targets == 1 then
        currentTarget = targets[1]
        return
    end
    local currentIndex = 0
    for i, target in ipairs(targets) do
        if target == currentTarget then
            currentIndex = i
            break
        end
    end
    local nextIndex = (currentIndex % #targets) + 1
    currentTarget = targets[nextIndex]
end

local function updateButtonColor(active)
    if not guiButton then return end
    local mainBtn = guiButton:FindFirstChild("MainBtn")
    if mainBtn then
        local targetColor = active and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(180, 50, 50)
        TweenService:Create(mainBtn, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        mainBtn.Text = active and "打开" or "关闭"
    end
end

local function toggleAimbot(state)
    ConfigValues.AimbotEnable = state
    if ConfigValues.AimbotEnable then
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end

        createCenterDot()
        currentTarget = getClosestTarget()

        aimbotConnection = RunService.RenderStepped:Connect(function()
            local cam = Workspace.CurrentCamera
            local myChar = LocalPlayer.Character
            if not myChar then return end
            local hrp = myChar:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            if currentTarget and not isTargetValid(currentTarget) then
                clearTarget()
            end

            if not currentTarget then
                currentTarget = getClosestTarget()
            end

            updateCenterDotVisual(currentTarget ~= nil)

            if not currentTarget then return end

            local predictedPos = getPredictedPosition(currentTarget)
            if not predictedPos then return end

            if ConfigValues.AimbotMode == "CharacterLock" or ConfigValues.AimbotMode == "CamLock+CharacterLock" then
                local flatDir = Vector3.new(predictedPos.X - hrp.Position.X, 0, predictedPos.Z - hrp.Position.Z)
                if flatDir.Magnitude > 0.01 then
                    hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + flatDir.Unit)
                end
            end

            if ConfigValues.AimbotMode == "CamLock" or ConfigValues.AimbotMode == "CamLock+CharacterLock" then
                local camCF = cam.CFrame
                local camPos = camCF.Position

                local targetDirection = (predictedPos - camPos).Unit

                local currentDirection = camCF.LookVector

                local finalDirection
                if ConfigValues.Smoothness >= 0.95 then
                    finalDirection = targetDirection
                else
                    finalDirection = currentDirection:Lerp(targetDirection, ConfigValues.Smoothness)
                end

                cam.CFrame = CFrame.lookAt(camPos, camPos + finalDirection)
            end
        end)
    else
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end

        clearTarget()
        destroyCenterDot()
    end
    updateButtonColor(state)
end

local function createGui()
    if guiButton then return end
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AimbotGUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    local hideBtn = Instance.new("TextButton")
    hideBtn.Name = "HideBtn"
    hideBtn.Size = UDim2.new(0, 24, 0, 24)
    hideBtn.Position = UDim2.new(1, -30, 0, 5)
    hideBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    hideBtn.Text = "в—‰"
    hideBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    hideBtn.TextSize = 14
    hideBtn.Font = Enum.Font.GothamBold
    hideBtn.Parent = screenGui

    local hideCorner = Instance.new("UICorner")
    hideCorner.CornerRadius = UDim.new(0, 6)
    hideCorner.Parent = hideBtn

    local mainBtn = Instance.new("TextButton")
    mainBtn.Name = "MainBtn"
    mainBtn.Size = UDim2.new(0, 40, 0, 40)
    mainBtn.Position = UDim2.new(1, -48, 0, 35)
    mainBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    mainBtn.Text = "关闭"
    mainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    mainBtn.TextSize = 11
    mainBtn.Font = Enum.Font.GothamBold
    mainBtn.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = mainBtn

    guiButton = screenGui

    hideBtn.MouseButton1Click:Connect(function()
        guiVisible = not guiVisible
        mainBtn.Visible = guiVisible
        hideBtn.Text = guiVisible and "в—‰" or "в—‹"
        hideBtn.TextColor3 = guiVisible and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(100, 100, 100)
    end)

    mainBtn.MouseButton1Click:Connect(function()
        toggleAimbot(not ConfigValues.AimbotEnable)
    end)
end

local function destroyGui()
    if guiButton then
        guiButton:Destroy()
        guiButton = nil
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == ConfigValues.ToggleKey then
            toggleAimbot(not ConfigValues.AimbotEnable)
        elseif input.KeyCode == ConfigValues.SwitchKey then
            if ConfigValues.AimbotEnable then
                switchTarget()
            end
        end
    end
end)

local aimbotSection = Tabs.Random:Section({
    Title = "自瞄功能",
    Icon = "target",
    Opened = false,
})

aimbotSection:Toggle({
    Flag = "AimbotEnable",
    Title = "启用自瞄",
    Default = false,
    Callback = function(state)
        toggleAimbot(state)
    end
})

aimbotSection:Toggle({
    Flag = "AimbotWallCheck",
    Title = "墙壁检测",
    Default = false,
    Callback = function(state)
        ConfigValues.CheckWalls = state
    end
})

aimbotSection:Toggle({
    Flag = "ShowGUI",
    Title = "打开GUI",
    Default = false,
    Callback = function(state)
        if state then createGui() else destroyGui() end
    end
})

aimbotSection:Paragraph({
    Title = "自瞄设置",
})

aimbotSection:Dropdown({
    Flag = "AimbotMode",
    Title = "自瞄方式",
    Values = {"CamLock", "CharacterLock", "CamLock+CharacterLock"},
    Multi = false,
    Default = "CamLock+CharacterLock",
    Callback = function(value)
        ConfigValues.AimbotMode = value
    end
})

aimbotSection:Dropdown({
    Flag = "AimbotTarget",
    Title = "目标",
    Values = {"Killers", "Survivors"},
    Multi = false,
    Default = "Survivors",
    Callback = function(value)
        ConfigValues.AimbotTarget = value
        clearTarget()
    end
})

aimbotSection:Slider({
    Flag = "AimbotRadius",
    Title = "半径",
    Step = 10,
    Value = {Min = 50, Max = 1000, Default = 500},
    Callback = function(value)
        ConfigValues.MaxDistance = tonumber(value) or 500
    end
})

aimbotSection:Slider({
    Flag = "AimbotPrediction",
    Title = "预判值",
    Step = 0.005,
    Value = {Min = 0, Max = 0.5, Default = 0.165},
    Callback = function(value)
        ConfigValues.Prediction = tonumber(value) or 0.165
    end
})

aimbotSection:Slider({
    Flag = "AimbotSmooth",
    Title = "平滑度",
    Step = 0.01,
    Value = {Min = 0.05, Max = 1, Default = 1},
    Callback = function(value)
        ConfigValues.Smoothness = tonumber(value) or 1
    end
})

aimbotSection:Paragraph({
    Title = "PC按键控制",
})

aimbotSection:Input({
    Flag = "ToggleKeyInput",
    Title = "启用自瞄按键",
    Default = "L",
    Callback = function(value)
        local key = Enum.KeyCode[value:upper()]
        if key then
            ConfigValues.ToggleKey = key
        end
    end
})

aimbotSection:Input({
    Flag = "SwitchKeyInput",
    Title = "切换目标按键",
    Default = "T",
    Callback = function(value)
        local key = Enum.KeyCode[value:upper()]
        if key then
            ConfigValues.SwitchKey = key
        end
    end
})


local function getPlayerNames()
    local names = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(names, player.Name)
        end
    end
    return names
end

local function updateDropdown()
    if Tabs and Tabs.Random and Tabs.Random.SetDropdownValues then
        Tabs.Random:SetDropdownValues("Orbit", getPlayerNames())
    end
end

Players.PlayerAdded:Connect(updateDropdown)
Players.PlayerRemoving:Connect(updateDropdown)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local autoParryEnabled = false
local testMode = false
local parryMode = "Slasher"
local wallCheckEnabled = true
local visualizationEnabled = false
local detectionRange = 20
local detectionRangeSq = detectionRange * detectionRange
local verificationDelay = 0.02
local facingAngle = 70
local backAngle = 120
local lineLength = 10
local lineColor = Color3.fromRGB(255, 0, 0)
local twoTimeLineColor = Color3.fromRGB(255, 165, 0)

local ShedletskySounds = {
    [12222208] = true,
    [10548112] = true,
    [127324570265084] = true,
    [105937652127383] = true,
    [102923788301986] = true,
    [116618003477002] = true,
}

local GuestSounds = {
    [81976396729343] = true,
    [92831180929659] = true,
    [126620220725231] = true,
    [5989939664] = true,
    [8595983255] = true,
    [8595977193] = true,
    [100918679787313] = true,
    [609342351] = true,
    [121717335514560] = true,
    [107228895075799] = true,
}

local ChanceSounds = {
    ["0"] = true,
}

local TwoTimeSounds = {
    [144352131] = true,
    [83419374143723] = true,
    [81859713902429] = true,
    [86710781315432] = true,
    [99820161736138] = true,
}

local ShedletskyAnims = {
    [116618003477002] = true,
    [122503338277352] = true,
    [131696603025265] = true,
    [119462383658044] = true,
    [98031287364865] = true,
    [121255898612475] = true,
    [110400453990786] = true,
    [92004263738493] = true,
    [105614318732282] = true,
    [103741352379819] = true,
    [77448521277146] = true,
}

local GuestAnims = {
    [87259391926321] = true,
    [119850211147676] = true,
    [135018792929847] = true,
    [107757776267592] = true,
    [108911997126897] = true,
    [82137285150006] = true,
    [86709774283672] = true,
    [138040001965654] = true,
    [108807732150251] = true,
    [86096387000557] = true,
    [73908019523515] = true,
    [136007065400978] = true,
    [129843313690921] = true,
    [90604236361267] = true,
    [140703210927645] = true,
    [111270184603402] = true,
    [81905101227053] = true,
}

local ChanceAnims = {
    [90499469533503] = true,
    [101771617803133] = true,
    [79350075778160] = true,
    [134958187822107] = true,
    [111313169447787] = true,
    [71685573690338] = true,
    [73921036900313] = true,
    [77124578197357] = true,
    [127128388164133] = true,
}

local TwoTimeAnims = {
    [100725497418533] = true,
    [106086955212611] = true,
}

local soundHooks = {}
local animatorHooks = {}
local attackCooldowns = {}
local parryCooldown = false

local cachedRemote = nil
local function getRemote()
    if cachedRemote then return cachedRemote end
    local modules = ReplicatedStorage:FindFirstChild("Modules")
    local network = modules and modules:FindFirstChild("Network")
    local network2 = network and network:FindFirstChild("Network")
    cachedRemote = network2 and network2:FindFirstChild("RemoteEvent")
    return cachedRemote
end

local visualizationParts = {}
local visualizationFolder = Instance.new("Folder")
visualizationFolder.Name = "AutoParryVisualization"
visualizationFolder.Parent = workspace

local function createLine()
    local part = Instance.new("Part")
    part.Name = "FacingLine"
    part.Anchored = true
    part.CanCollide = false
    part.CanQuery = false
    part.CanTouch = false
    part.Material = Enum.Material.Neon
    part.Size = Vector3.new(0.1, 0.1, lineLength)
    part.Transparency = 0.3
    part.Parent = visualizationFolder
    return part
end

local function angleToDirection(lookVector, rightVector, angleDegrees)
    local angleRad = math.rad(angleDegrees)
    local cosA = math.cos(angleRad)
    local sinA = math.sin(angleRad)
    return (lookVector * cosA + rightVector * sinA).Unit
end

local function updateVisualization()
    if not visualizationEnabled or not autoParryEnabled then
        for _, data in pairs(visualizationParts) do
            if data.line1 then data.line1.Transparency = 1 end
            if data.line2 then data.line2.Transparency = 1 end
            if data.backLine1 then data.backLine1.Transparency = 1 end
            if data.backLine2 then data.backLine2.Transparency = 1 end
        end
        return
    end

    local myChar = lp.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    local processedPlayers = {}

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= lp or testMode then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if hrp then
                local dvec = hrp.Position - myRoot.Position
                local inRange = dvec:Dot(dvec) <= detectionRangeSq

                if not visualizationParts[player] then
                    visualizationParts[player] = {
                        line1 = createLine(),
                        line2 = createLine(),
                        backLine1 = createLine(),
                        backLine2 = createLine(),
                    }
                end

                local data = visualizationParts[player]
                processedPlayers[player] = true

                if inRange then
                    local pos = hrp.Position
                    local look = hrp.CFrame.LookVector
                    local right = hrp.CFrame.RightVector

                    local halfAngle = facingAngle / 2
                    local dir1 = angleToDirection(look, right, -halfAngle)
                    local dir2 = angleToDirection(look, right, halfAngle)

                    local endPos1 = pos + dir1 * lineLength
                    local endPos2 = pos + dir2 * lineLength

                    data.line1.Size = Vector3.new(0.1, 0.1, lineLength)
                    data.line1.CFrame = CFrame.new((pos + endPos1) / 2, endPos1)
                    data.line1.Color = lineColor
                    data.line1.Transparency = 0.3

                    data.line2.Size = Vector3.new(0.1, 0.1, lineLength)
                    data.line2.CFrame = CFrame.new((pos + endPos2) / 2, endPos2)
                    data.line2.Color = lineColor
                    data.line2.Transparency = 0.3

                    local myPos = myRoot.Position
                    local myLook = myRoot.CFrame.LookVector
                    local myRight = myRoot.CFrame.RightVector
                    local backLook = -myLook

                    local backHalfAngle = (180 - backAngle) / 2
                    local backDir1 = angleToDirection(backLook, myRight, -backHalfAngle)
                    local backDir2 = angleToDirection(backLook, myRight, backHalfAngle)

                    local backEndPos1 = myPos + backDir1 * lineLength
                    local backEndPos2 = myPos + backDir2 * lineLength

                    data.backLine1.Size = Vector3.new(0.1, 0.1, lineLength)
                    data.backLine1.CFrame = CFrame.new((myPos + backEndPos1) / 2, backEndPos1)
                    data.backLine1.Color = twoTimeLineColor
                    data.backLine1.Transparency = 0.3

                    data.backLine2.Size = Vector3.new(0.1, 0.1, lineLength)
                    data.backLine2.CFrame = CFrame.new((myPos + backEndPos2) / 2, backEndPos2)
                    data.backLine2.Color = twoTimeLineColor
                    data.backLine2.Transparency = 0.3
                else
                    data.line1.Transparency = 1
                    data.line2.Transparency = 1
                    data.backLine1.Transparency = 1
                    data.backLine2.Transparency = 1
                end
            end
        end
    end

    for player, data in pairs(visualizationParts) do
        if not processedPlayers[player] then
            if data.line1 then data.line1:Destroy() end
            if data.line2 then data.line2:Destroy() end
            if data.backLine1 then data.backLine1:Destroy() end
            if data.backLine2 then data.backLine2:Destroy() end
            visualizationParts[player] = nil
        end
    end
end

local function hasLineOfSight(fromPos, toPos, ignoreList)
    local direction = (toPos - fromPos)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = ignoreList or {}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true
    local result = workspace:Raycast(fromPos, direction, raycastParams)
    return result == nil
end

local facingAngleCos = math.cos(math.rad(facingAngle / 2))
local backAngleCos = math.cos(math.rad((180 - backAngle) / 2))

local function isFacingMe(enemyRoot, myRoot)
    local dir = (myRoot.Position - enemyRoot.Position).Unit
    local dot = enemyRoot.CFrame.LookVector:Dot(dir)
    return dot > facingAngleCos
end

local function isFacingMyBack(enemyRoot, myRoot)
    local dirToMe = (myRoot.Position - enemyRoot.Position).Unit
    local enemyDot = enemyRoot.CFrame.LookVector:Dot(dirToMe)
    local dirToEnemy = (enemyRoot.Position - myRoot.Position).Unit
    local myBackDot = (-myRoot.CFrame.LookVector):Dot(dirToEnemy)
    return enemyDot > facingAngleCos and myBackDot > backAngleCos
end

local function fireRemoteAbility(abilityName)
    if parryCooldown then return false end
    parryCooldown = true
    local remote = getRemote()
    if remote then
        local bufferMap = {
            ["Block"] = "\003\005\000\000\000Block",
            ["Punch"] = "\003\005\000\000\000Punch",
            ["Clone"] = "\003\005\000\000\000Clone",
            ["RagingPace"] = "\003\n\000\000\000RagingPace",
            ["404Error"] = "\003\b\000\000\000404Error",
            ["CorruptEnergy"] = "\003\r\000\000\000CorruptEnergy",
            ["DigitalFootprint"] = "\003\016\000\000\000DigitalFootprint",
            ["Crouch"] = "\003\006\000\000\000Crouch",
            ["Ghostburger"] = "\003\v\000\000\000Ghostburger",
            ["Slash"] = "\003\005\000\000\000Slash",
            ["FriedChicken"] = "\003\f\000\000\000FriedChicken",
            ["CoinFlip"] = "\003\b\000\000\000CoinFlip",
            ["Dagger"] = "\003\006\000\000\000Dagger",
            ["Carving Slash"] = "\003\r\000\000\000Carving Slash",
            ["Stab"] = "\003\004\000\000\000Stab",
            ["GashingWound"] = "\003\f\000\000\000GashingWound"
        }
        local bufferStr = bufferMap[abilityName] or ("\003\005\000\000\000" .. abilityName)
        remote:FireServer("UseActorAbility", {buffer.fromstring(bufferStr)})
    end
    task.delay(0.15, function()
        parryCooldown = false
    end)
    return true
end

local function tryParry()
    if parryMode == "John Doe" then
        return fireRemoteAbility("404Error")
    else
        return fireRemoteAbility("RagingPace")
    end
end

local function checkAndParry(enemyHRP, myRoot, category)
    if category == "TwoTime" then
        if isFacingMyBack(enemyHRP, myRoot) then
            return tryParry()
        end
    else
        if isFacingMe(enemyHRP, myRoot) then
            return tryParry()
        end
    end
    return false
end

local function processAttack(char, category)
    if not autoParryEnabled then return end
    if parryCooldown then return end

    local cooldownKey = tostring(char) .. category
    local now = tick()
    if attackCooldowns[cooldownKey] and now < attackCooldowns[cooldownKey] then return end
    attackCooldowns[cooldownKey] = now + 0.1

    local plr = Players:GetPlayerFromCharacter(char)
    if not testMode and plr and plr == lp then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local myChar = lp.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    local dvec = hrp.Position - myRoot.Position
    if dvec:Dot(dvec) > detectionRangeSq then return end

    if wallCheckEnabled then
        local ignoreList = {myChar, char}
        if not hasLineOfSight(myRoot.Position, hrp.Position, ignoreList) then
            return
        end
    end

    if checkAndParry(hrp, myRoot, category) then
        return
    end

    task.spawn(function()
        local startTime = tick()
        while tick() - startTime < verificationDelay do
            if parryCooldown then return end
            if not autoParryEnabled then return end

            local currentHRP = char:FindFirstChild("HumanoidRootPart")
            local currentMyChar = lp.Character
            local currentMyRoot = currentMyChar and currentMyChar:FindFirstChild("HumanoidRootPart")
            if not currentHRP or not currentMyRoot then return end

            if wallCheckEnabled then
                if not hasLineOfSight(currentMyRoot.Position, currentHRP.Position, {currentMyChar, char}) then
                    return
                end
            end

            if checkAndParry(currentHRP, currentMyRoot, category) then
                return
            end

            RunService.RenderStepped:Wait()
        end
    end)
end

local function extractNumericId(str)
    if not str then return nil end
    local numStr = tostring(str):match("%d+")
    if numStr then
        return tonumber(numStr)
    end
    return nil
end

local function getSoundCategory(id)
    if not id then return nil end
    local numId = tonumber(id)
    if not numId then return nil end
    if ShedletskySounds[numId] then return "Shedletsky" end
    if GuestSounds[numId] then return "Guest" end
    if ChanceSounds[numId] then return "Chance" end
    if TwoTimeSounds[numId] then return "TwoTime" end
    return nil
end

local function getAnimCategory(id)
    if not id then return nil end
    local numId = tonumber(id)
    if not numId then return nil end
    if ShedletskyAnims[numId] then return "Shedletsky" end
    if GuestAnims[numId] then return "Guest" end
    if ChanceAnims[numId] then return "Chance" end
    if TwoTimeAnims[numId] then return "TwoTime" end
    return nil
end

local function getCharacterFromDescendant(inst)
    if not inst then return nil end
    local current = inst.Parent
    while current do
        if current:FindFirstChildOfClass("Humanoid") then
            return current
        end
        current = current.Parent
    end
    return nil
end

local function processSound(sound)
    if not autoParryEnabled then return end
    if not sound or not sound:IsA("Sound") then return end

    local id = extractNumericId(sound.SoundId)
    if not id then return end

    local category = getSoundCategory(id)
    if not category then return end

    local char = getCharacterFromDescendant(sound)
    if not char then return end

    processAttack(char, category)
end

local function hookSound(sound)
    if not sound:IsA("Sound") then return end
    if soundHooks[sound] then return end

    local conn1 = sound.Played:Connect(function()
        processSound(sound)
    end)

    local conn2 = sound:GetPropertyChangedSignal("Playing"):Connect(function()
        if sound.Playing then
            processSound(sound)
        end
    end)

    local conn3
    conn3 = sound.Destroying:Connect(function()
        if conn1 then conn1:Disconnect() end
        if conn2 then conn2:Disconnect() end
        if conn3 then conn3:Disconnect() end
        soundHooks[sound] = nil
    end)

    soundHooks[sound] = {conn1, conn2, conn3}

    if sound.Playing then
        processSound(sound)
    end
end

local function processAnimationTrack(animTrack, char)
    if not autoParryEnabled then return end
    if not animTrack or not animTrack.Animation then return end

    local id = extractNumericId(animTrack.Animation.AnimationId)
    if not id then return end

    local category = getAnimCategory(id)
    if not category then return end

    processAttack(char, category)
end

local function hookAnimator(animator, char)
    if not animator:IsA("Animator") then return end
    if animatorHooks[animator] then return end

    local conn1 = animator.AnimationPlayed:Connect(function(animTrack)
        processAnimationTrack(animTrack, char)
    end)

    local conn2
    conn2 = animator.Destroying:Connect(function()
        if conn1 then conn1:Disconnect() end
        if conn2 then conn2:Disconnect() end
        animatorHooks[animator] = nil
    end)

    animatorHooks[animator] = {conn1, conn2}
end

local function hookCharacter(char)
    if not char then return end

    for _, desc in ipairs(char:GetDescendants()) do
        if desc:IsA("Sound") then
            task.spawn(hookSound, desc)
        elseif desc:IsA("Animator") then
            task.spawn(hookAnimator, desc, char)
        end
    end

    char.DescendantAdded:Connect(function(desc)
        if desc:IsA("Sound") then
            hookSound(desc)
        elseif desc:IsA("Animator") then
            hookAnimator(desc, char)
        end
    end)
end

local function onPlayerAdded(player)
    if player.Character then
        hookCharacter(player.Character)
    end
    player.CharacterAdded:Connect(function(char)
        task.wait(0.1)
        hookCharacter(char)
    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    task.spawn(onPlayerAdded, player)
end

Players.PlayerAdded:Connect(onPlayerAdded)

for _, desc in ipairs(workspace:GetDescendants()) do
    if desc:IsA("Sound") then
        task.spawn(hookSound, desc)
    end
end

workspace.DescendantAdded:Connect(function(desc)
    if desc:IsA("Sound") then
        hookSound(desc)
    end
end)

RunService.RenderStepped:Connect(updateVisualization)

local autoParrySection = Tabs.Random:Section({
    Title = "自动格挡",
    Icon = "shield",
    Desc = "",
    Opened = false,
})

autoParrySection:Toggle({
    Flag = "AutoParryEnabled",
    Title = "启用自动格挡",
    Default = false,
    Callback = function(state)
        autoParryEnabled = state
    end
})

autoParrySection:Toggle({
    Flag = "WallCheck",
    Title = "墙壁检测",
    Default = true,
    Callback = function(state)
        wallCheckEnabled = state
    end
})

autoParrySection:Dropdown({
    Flag = "ParryMode",
    Title = "格挡模式",
    Values = {"Slasher", "John Doe"},
    Multi = false,
    Default = "Slasher",
    Callback = function(value)
        parryMode = value
    end
})

autoParrySection:Slider({
    Flag = "DetectionRange",
    Title = "格挡检测范围",
    Step = 1,
    Value = {Min = 5, Max = 50, Default = 20},
    Suffix = " studs",
    Callback = function(val)
        detectionRange = tonumber(val) or 20
        detectionRangeSq = detectionRange * detectionRange
    end
})

autoParrySection:Slider({
    Flag = "VerificationDelay",
    Title = "最大验证时间",
    Step = 0.01,
    Value = {Min = 0.01, Max = 0.2, Default = 0.02},
    Suffix = " sec",
    Callback = function(val)
        verificationDelay = tonumber(val) or 0.02
    end
})

autoParrySection:Paragraph({
    Title = "攻击角度检测",
})

autoParrySection:Slider({
    Flag = "FacingAngle",
    Title = "正面判定角度 (普通弹反)",
    Step = 5,
    Value = {Min = 30, Max = 180, Default = 70},
    Suffix = "°",
    Callback = function(val)
        facingAngle = tonumber(val) or 70
        facingAngleCos = math.cos(math.rad(facingAngle / 2))
    end
})

autoParrySection:Slider({
    Flag = "BackAngle",
    Title = "背面判定角度 (二段弹反)",
    Step = 5,
    Value = {Min = 90, Max = 180, Default = 120},
    Suffix = "°",
    Callback = function(val)
        backAngle = tonumber(val) or 120
        backAngleCos = math.cos(math.rad((180 - backAngle) / 2))
    end
})

autoParrySection:Paragraph({
    Title = "视觉设置",
    Desc = "弹反范围可视化效果"
})

autoParrySection:Toggle({
    Flag = "VisualizationEnabled",
    Title = "显示判定范围线条",
    Default = false,
    Callback = function(state)
        visualizationEnabled = state
    end
})

autoParrySection:Slider({
    Flag = "LineLength",
    Title = "线条长度",
    Step = 1,
    Value = {Min = 5, Max = 30, Default = 10},
    Suffix = " 格",
    Callback = function(val)
        lineLength = tonumber(val) or 10
    end
})

autoParrySection:Colorpicker({
    Flag = "LineColor",
    Title = "正面判定线条颜色",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        lineColor = color
    end
})

autoParrySection:Colorpicker({
    Flag = "TwoTimeLineColor",
    Title = "二段背面线条颜色",
    Default = Color3.fromRGB(255, 165, 0),
    Callback = function(color)
        twoTimeLineColor = color
    end
})



do
    local replacements = {
        idle = "rbxassetid://134624270247120",
        walk = "rbxassetid://115946474977409",
        run  = "rbxassetid://132377038617766",
    }

    local enabled   = false
    local states    = {}
    local nameCache = {}

    local function parseId(str)
        if not str then return nil end
        local id = tostring(str):match("(%d+)")
        return id and tonumber(id) or nil
    end

    local function getAnimName(assetId)
        if not assetId then return nil end
        if nameCache[assetId] then return nameCache[assetId] end
        local ok, info = pcall(function()
            return MarketplaceService:GetProductInfo(assetId, Enum.InfoType.Asset)
        end)
        if ok and info and info.Name then
            nameCache[assetId] = info.Name
            return info.Name
        end
        return nil
    end

    local function playReplacement(animator, animType)
        if not replacements[animType] then return nil end
        local anim = Instance.new("Animation")
        anim.AnimationId = replacements[animType]
        local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
        if not ok or not track then return nil end
        track.Priority = Enum.AnimationPriority.Movement
        track:Play()
        return track
    end

    local function disconnectSafe(conn)
        if conn and typeof(conn) == "RBXScriptConnection" then conn:Disconnect() end
    end

    local function setupChar(char)
        if not char then return end
        local humanoid = char:WaitForChild("Humanoid")
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then animator = Instance.new("Animator"); animator.Parent = humanoid end

        local prev = states[char]
        if prev then
            disconnectSafe(prev.heartbeatConn)
            disconnectSafe(prev.playedConn)
            if prev.currentTrack and prev.currentTrack.IsPlaying then
                pcall(function() prev.currentTrack:Stop() end)
            end
        end

        local replSet = {}
        for _, v in pairs(replacements) do
            local id = parseId(v)
            if id then replSet[id] = true end
        end

        local s = {
            animator = animator, humanoid = humanoid,
            currentTrack = nil, currentType = nil,
            heartbeatConn = nil, playedConn = nil,
            replSet = replSet,
        }
        states[char] = s

        s.heartbeatConn = RunService.Heartbeat:Connect(function()
            if not enabled then return end
            local track = s.currentTrack
            if not (track and s.currentType and track.IsPlaying) then return end
            local ws = math.clamp(s.humanoid.WalkSpeed or 16, 0, 100)
            if s.currentType == "idle" then
                pcall(function() track:AdjustSpeed(1) end)
            elseif s.currentType == "walk" then
                pcall(function() track:AdjustSpeed(math.max(ws / 12, 0.2)) end)
            elseif s.currentType == "run" then
                pcall(function() track:AdjustSpeed(math.max(ws / 26, 0.2)) end)
            end
        end)

        s.playedConn = animator.AnimationPlayed:Connect(function(track)
            if not enabled then return end
            if not track or not track.Animation then return end
            local assetId = parseId(tostring(track.Animation.AnimationId or ""))
            if assetId and s.replSet[assetId] then return end
            if s.currentTrack == track then return end

            local name = assetId and getAnimName(assetId) or tostring(track.Animation.AnimationId or "")
            if type(name) ~= "string" then return end
            local lower = name:lower()

            local function swap(animType)
                if s.currentTrack then pcall(function() s.currentTrack:Stop() end) end
                local newTrack = playReplacement(animator, animType)
                if newTrack then s.currentTrack = newTrack; s.currentType = animType end
            end

            if     lower:find("idle") then swap("idle")
            elseif lower:find("walk") then swap("walk")
            elseif lower:find("run")  then swap("run")
            else

                local ws = s.humanoid.WalkSpeed
                if ws > 20 then swap("run")
                elseif ws > 2 then swap("walk")
                else swap("idle") end
            end
        end)
    end

    LocalPlayer.CharacterRemoving:Connect(function(char)
        local s = states[char]
        if s then
            disconnectSafe(s.heartbeatConn)
            disconnectSafe(s.playedConn)
            if s.currentTrack then pcall(function() s.currentTrack:Stop() end) end
            states[char] = nil
        end
    end)

    if LocalPlayer.Character then setupChar(LocalPlayer.Character) end
    LocalPlayer.CharacterAdded:Connect(setupChar)

local fakeAnimSection = Tabs.Random:Section({
    Title = "假受伤",
    Icon = "person-standing",
    Opened = false,
})

fakeAnimSection:Toggle({
    Flag = "FakeInjuredAnimations",
    Title = "开启假受伤动画",
    Default = false,
    Callback = function(state)
        enabled = state
        if not state then
            for _, s in pairs(states) do
                if s.currentTrack then
                    pcall(function() s.currentTrack:Stop() end)
                    s.currentTrack = nil
                    s.currentType  = nil
                end
            end
        end
    end
})

end


do
    local sprintModule
    local sprintOk, sprintErr = pcall(function()
        local sys = ReplicatedStorage:WaitForChild("Systems", 5)
        if not sys then error("Systems not found") end
        local ch = sys:WaitForChild("Character", 5)
        if not ch then error("Character not found") end
        local g = ch:WaitForChild("Game", 5)
        if not g then error("Game not found") end
        local sp = g:WaitForChild("Sprinting", 5)
        if not sp then error("Sprinting not found") end
        sprintModule = require(sp)
    end)
    if sprintOk then
    else
    end

    local enabled     = false
    local character, humanoid, rootPart
    local runTrack, idleTrack
    local runSpeed    = 1
    local lastMoveDir = Vector3.new()
    local isTurning   = false

    local runAnimObj  = Instance.new("Animation")
    local idleAnimObj = Instance.new("Animation")
    runAnimObj.AnimationId  = "rbxassetid://136252471123500"
    idleAnimObj.AnimationId = "rbxassetid://131082534135875"

    local function setup(char)
        character = char
        humanoid  = char:WaitForChild("Humanoid")
        rootPart  = char:WaitForChild("HumanoidRootPart")
        runTrack  = humanoid:LoadAnimation(runAnimObj)
        idleTrack = humanoid:LoadAnimation(idleAnimObj)
    end

    if LocalPlayer.Character then setup(LocalPlayer.Character) end
    LocalPlayer.CharacterAdded:Connect(setup)

    RunService.Heartbeat:Connect(function()
        if not enabled then return end
        if not humanoid or not rootPart then return end

        local moveDir = humanoid.MoveDirection

        if moveDir.Magnitude > 0 then
            if idleTrack and idleTrack.IsPlaying then idleTrack:Stop(0) end

            if lastMoveDir.Magnitude > 0 and moveDir:Dot(lastMoveDir) < 0.9 and not isTurning then
                isTurning = true
                local t = tick()
                while tick() - t < 0.08 do
                    rootPart.CFrame = rootPart.CFrame:Lerp(
                        CFrame.new(rootPart.Position, rootPart.Position + moveDir.Unit), 0.5)
                    RunService.Heartbeat:Wait()
                end
                rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + moveDir.Unit)
                isTurning = false
            elseif runTrack and not runTrack.IsPlaying and not isTurning then
                runTrack:Play(0)
                runTrack:AdjustSpeed(runSpeed)
                runTrack.TimePosition = 0
                rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + moveDir.Unit)
            end

            lastMoveDir = moveDir.Unit
        else
            if runTrack and runTrack.IsPlaying then runTrack:Stop(0) end
            if idleTrack and not idleTrack.IsPlaying then
                idleTrack:Play(0)
                idleTrack.TimePosition = 0
            end
            lastMoveDir = Vector3.new()
        end

        if not sprintModule.IsSprinting then
            sprintModule.IsSprinting = true
            sprintModule.__sprintedEvent:Fire(true)
        end
    end)

local fakeCloneSection = Tabs.Random:Section({
    Title = "高仿分身走位 (007n7)",
    Icon = "user",
    Opened = false,
})

fakeCloneSection:Toggle({
    Flag = "FakeCloneMoving",
    Title = "开启007n7高仿移动",
    Default = false,
    Callback = function(state) enabled = state end
})

end


do
    local enabled = false

    local function restoreWalls()
        local map = workspace:FindFirstChild("Map")
        if not (map and map:FindFirstChild("Ingame") and map.Ingame:FindFirstChild("Map")) then return end
        local walls = map.Ingame.Map:FindFirstChild("Killer_Only Wall")
                   or map.Ingame.Map:FindFirstChild("KillerOnlyEntrances")
        if walls then
            for _, v in pairs(walls:GetChildren()) do v.CanCollide = true end
        end
    end

    local function disableWalls()
        local map = workspace:FindFirstChild("Map")
        if not (map and map:FindFirstChild("Ingame") and map.Ingame:FindFirstChild("Map")) then return end
        local entrances = map.Ingame.Map:FindFirstChild("KillerOnlyEntrances")
        if entrances then
            for _, v in pairs(entrances:GetChildren()) do v.CanCollide = false end
        end
    end

    local killerEntrSection = Tabs.Random:Section({
        Title = "屠夫专属穿墙",
        Icon = "door-open",
        Opened = false,
    })

    killerEntrSection:Toggle({
        Flag = "AllowKillerEntrances",
        Title = "启用屠夫专属穿墙",
        Default = false,
        Callback = function(state)
            enabled = state
            if not state then
                pcall(restoreWalls)
                return
            end
            task.spawn(function()
                while enabled do
                    pcall(disableWalls)
                    task.wait(0.1)
                end
            end)
        end
    })
end

local orbitSection = Tabs.Random:Section({
    Title = "环绕",
    Icon = "rotate-cw",
    Opened = false,
})
local orbitActive = false
local orbitDistance = 10
local orbitSpeed = 5
local angle = 0
local targetPlayer = nil
local function getCharacter(player)
    return player.Character or player.CharacterAdded:Wait()
end
RunService.RenderStepped:Connect(function(dt)
    if not orbitActive or not targetPlayer then return end
    local targetChar = getCharacter(targetPlayer)
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    local myChar = getCharacter(LocalPlayer)
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot or not targetRoot then return end
    angle = angle + orbitSpeed * dt
    local offset = Vector3.new(math.cos(angle) * orbitDistance, 0, math.sin(angle) * orbitDistance)
    myRoot.CFrame = CFrame.new(targetRoot.Position + offset, targetRoot.Position)
end)
orbitSection:Toggle({
    Flag = "OrbitPlayers",
    Title = "环绕玩家[对着屠夫使用，隐身状态下打不到你]",
    Default = false,
    Callback = function(state)
        orbitActive = state
    end
})
orbitSection:Divider()
orbitSection:Dropdown({
    Title = "选择目标玩家",
    Values = getPlayerNames(),
    Multi = false,
    Default = nil,
    Callback = function(choice)
        local chosen = Players:FindFirstChild(choice)
        if chosen then
            targetPlayer = chosen
        else
            targetPlayer = nil
        end
    end
})
orbitSection:Slider({
    Flag = "OrbitSpeed",
    Title = "旋转速度",
    Step = 0.5,
    Value = {Min = 1, Max = 50, Default = orbitSpeed},
    Suffix = " speed",
    Callback = function(val)
        orbitSpeed = val
    end
})
orbitSection:Slider({
    Flag = "OrbitDistance",
    Title = "轨道距离",
    Step = 1,
    Value = {Min = 1, Max = 20, Default = orbitDistance},
    Suffix = " studs",
    Callback = function(val)
        orbitDistance = val
    end
})

local speedBoostSection = Tabs.Random:Section({
    Title = "速度提升",
    Icon = "zap",
    Opened = false,
})
speedBoostSection:Button({
    Title = "速度提升[如艾略特的尖峰时刻]",
    Callback = function()
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local sprintModule = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
        local defaultSprintSpeed = sprintModule.SprintSpeed
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Parent = PlayerGui
        local DragButton = Instance.new("TextButton")
        DragButton.Size = UDim2.new(0, 70, 0, 35)
        DragButton.Position = UDim2.new(0.05, 0, 0.2, 0)
        DragButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        DragButton.BorderSizePixel = 2
        DragButton.Text = "Boost"
        DragButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        DragButton.TextSize = 16
        DragButton.Font = Enum.Font.SourceSansBold
        DragButton.Parent = ScreenGui
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Color = Color3.fromRGB(0, 255, 0)
        UIStroke.Thickness = 2
        UIStroke.Parent = DragButton
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            local delta = input.Position - dragStart
            DragButton.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
        DragButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = DragButton.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        DragButton.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
        local debounce = false
        DragButton.MouseButton1Click:Connect(function()
            if debounce then return end
            debounce = true
            sprintModule.SprintSpeed = 37
            for i = 5, 1, -1 do
                DragButton.Text = tostring(i)
                task.wait(1)
            end
            sprintModule.SprintSpeed = defaultSprintSpeed
            DragButton.Text = "Boost"
            debounce = false
        end)
    end
})

end


local RADIUS = 40
local CHECK_INTERVAL = 0.15
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local attackIds = {
    ["72182155407310"] = true,
    ["72722244508749"] = true,
    ["8028421882"] = true,
    ["95802026624883"] = true,
    ["94215314"] = true,
    ["1956271358"] = true,
    ["115706752305794"] = true,
    ["82605295530067"] = true,
    ["96959123077498"] = true,
    ["105905509045149"] = true,
    ["98105697395689"] = true,
    ["9089408772"] = true
}
local nameTranslations = {
    ["Guest"] = "Block detected",
    ["Two Time"] = "Two Time"
}
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AttackAlertGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.Enabled = false
local alertFrame = Instance.new("Frame")
alertFrame.Size = UDim2.new(0, 150, 0, 35)
alertFrame.Position = UDim2.new(0.5, -75, 0.05, 0)
alertFrame.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
alertFrame.BorderSizePixel = 0
alertFrame.Visible = false
alertFrame.Parent = screenGui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = alertFrame
local alertLabel = Instance.new("TextLabel")
alertLabel.Size = UDim2.new(1, 0, 1, 0)
alertLabel.BackgroundTransparency = 1
alertLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
alertLabel.TextSize = 16
alertLabel.Font = Enum.Font.GothamBold
alertLabel.TextScaled = true
alertLabel.Text = ""
alertLabel.Parent = alertFrame
local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 5)
padding.PaddingRight = UDim.new(0, 5)
padding.Parent = alertLabel
local function getLocalPosition()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.Position
end
local function extractAnimId(animationId)
    return animationId and tostring(animationId):match("(%d+)")
end
local function getModelPosition(model)
    local part = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso") or model:FindFirstChild("Head")
    return part and part.Position
end
local function checkAnimations(model)
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then return false end
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        if track.Animation then
            local id = extractAnimId(track.Animation.AnimationId)
            if id and attackIds[id] then
                return true
            end
        end
    end
    return false
end
local function getDisplayName(name)
    return nameTranslations[name] or name
end
local cachedModels = {}
local lastCacheUpdate = 0
local function updateCache()
    cachedModels = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            table.insert(cachedModels, player.Character)
        end
    end
    local survivors = workspace:FindFirstChild("Players")
    survivors = survivors and survivors:FindFirstChild("Survivors")
    if survivors then
        for _, model in ipairs(survivors:GetChildren()) do
            if model:IsA("Model") then
                table.insert(cachedModels, model)
            end
        end
    end
end
local lastCheck = 0
local alertConnection = nil
local function startAlert()
    if alertConnection then return end
    alertConnection = RunService.Heartbeat:Connect(function()
        local now = tick()
        if now - lastCheck < CHECK_INTERVAL then return end
        lastCheck = now
        if now - lastCacheUpdate > 1 then
            updateCache()
            lastCacheUpdate = now
        end
        local localPos = getLocalPosition()
        if not localPos then
            alertFrame.Visible = false
            return
        end
        local detected = {}
        local radiusSq = RADIUS * RADIUS
        for _, model in ipairs(cachedModels) do
            local modelPos = getModelPosition(model)
            if modelPos then
                local dist = (localPos - modelPos).Magnitude
                if dist <= RADIUS then
                    local name = model.Name
                    if name == "Two Time" then
                        detected["Two Time"] = true
                    elseif name == "Guest" then
                        detected["Block detected"] = true
                    elseif checkAnimations(model) then
                        detected[getDisplayName(name)] = true
                    end
                end
            end
        end
        local names = {}
        for name in pairs(detected) do
            table.insert(names, "[" .. name .. "]")
        end
        if #names > 0 then
            alertLabel.Text = table.concat(names, " ")
            alertFrame.Visible = true
        else
            alertFrame.Visible = false
        end
    end)
end
local function stopAlert()
    if alertConnection then
        alertConnection:Disconnect()
        alertConnection = nil
        alertFrame.Visible = false
    end
end
local attackAlertSection = Tabs.Random:Section({
    Title = "访客检测",
    Icon = "shield-alert",
    Opened = false,
})
attackAlertSection:Toggle({
    Flag = "AttackAlert",
    Title = "启用攻击检测",
    Default = false,
    Callback = function(state)
        screenGui.Enabled = state
        if state then
            startAlert()
        else
            stopAlert()
        end
    end
})
attackAlertSection:Slider({
    Flag = "AttackAlertRadius",
    Title = "检测攻击半径",
    Step = 10,
    Value = {Min = 10, Max = 100, Default = 20},
    Suffix = " studs",
    Callback = function(value)
        RADIUS = value
    end
})
local killAuraSection = Tabs.Random:Section({
    Title = "杀戮光环",
    Icon = "crosshair",
    Opened = false,
})
killAuraSection:Button({
    Title = "杀戮光环[杀手]",
    Callback = function()
        local Players = game:GetService("Players")
        local lp = Players.LocalPlayer
        local char = lp.Character or lp.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        local pingMs = 350
        local updateRate = 0.02
        local standStillThreshold = 2
        local function predictPosition(targetHRP)
            local velocity = targetHRP.Velocity
            local delay = pingMs / 1000
            return targetHRP.Position + (velocity * delay)
        end
        local function getClosestSurvivor()
            local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
            if not survivorsFolder then
                return nil
            end
            local closest, minDist = nil, math.huge
            for _, survivor in ipairs(survivorsFolder:GetChildren()) do
                local targetHRP = survivor:FindFirstChild("HumanoidRootPart")
                if targetHRP then
                    local dist = (hrp.Position - targetHRP.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        closest = targetHRP
                    end
                end
            end
            return closest
        end
        task.spawn(function()
            while task.wait(updateRate) do
                local targetHRP = getClosestSurvivor()
                if targetHRP then
                    local speed = targetHRP.Velocity.Magnitude
                    local targetPos
                    if speed < standStillThreshold then
                        targetPos = targetHRP.Position
                    else
                        targetPos = predictPosition(targetHRP)
                    end
                    hrp.CFrame = CFrame.new(targetPos)
                end
            end
        end)
    end
})
local hideNamesSection = Tabs.Random:Section({
    Title = "隐藏名字",
    Icon = "eye-off",
    Opened = false,
})
local Players2 = game:GetService("Players")
local LocalPlayer2 = Players2.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local PlayerGui = LocalPlayer2:WaitForChild("PlayerGui")
local Workspace2 = game:GetService("Workspace")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local HideNamesEnabled = false
hideNamesSection:Toggle({
    Flag = "HideNames",
    Title = "隐藏名字",
    Default = false,
    Callback = function(state)
        HideNamesEnabled = state
    end
})
local FakeName = "LinniScript"
local function escapePattern(s)
    return s:gsub("([^%w])", "%%%1")
end
local function replaceNameInText(text)
    if not text or text == "" then return text end
    local out = text
    for _, plr in ipairs(Players2:GetPlayers()) do
        local name = tostring(plr.Name)
        local display = tostring(plr.DisplayName or "")
        if name ~= "" then
            out = out:gsub(escapePattern(name), FakeName)
        end
        if display ~= "" then
            out = out:gsub(escapePattern(display), FakeName)
        end
    end
    return out
end
local trackedObjects = {}
local function trackObject(obj)
    if not obj:IsA("TextLabel") and not obj:IsA("TextButton") and not obj:IsA("TextBox") then
        return
    end
    if HideNamesEnabled then
        obj.Text = replaceNameInText(obj.Text)
    end
    obj:GetPropertyChangedSignal("Text"):Connect(function()
        if HideNamesEnabled then
            local newText = replaceNameInText(obj.Text)
            if obj.Text ~= newText then
                obj.Text = newText
            end
        end
    end)
    if not trackedObjects[obj] then
        trackedObjects[obj] = true
    end
end
local function scanContainer(container)
    for _, obj in ipairs(container:GetDescendants()) do
        trackObject(obj)
    end
    container.DescendantAdded:Connect(function(obj)
        trackObject(obj)
    end)
end
scanContainer(PlayerGui)
scanContainer(CoreGui)
scanContainer(Workspace2)
scanContainer(ReplicatedFirst)
Players2.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(ch)
        scanContainer(ch)
    end)
    if plr.Character then scanContainer(plr.Character) end
end)
for _, plr in ipairs(Players2:GetPlayers()) do
    if plr.Character then scanContainer(plr.Character) end
end
task.spawn(function()
    while true do
        if HideNamesEnabled then
            for obj, _ in pairs(trackedObjects) do
                if obj and obj.Parent then
                    local fixed = replaceNameInText(obj.Text)
                    if obj.Text ~= fixed then
                        obj.Text = fixed
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)
local RunService2 = game:GetService("RunService")
local Players3 = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players3.LocalPlayer
local RemoteEvent
pcall(function()
    local m = ReplicatedStorage:WaitForChild("Modules", 5)
    local n = m and m:WaitForChild("Network", 5)
    local n2 = n and n:WaitForChild("Network", 5)
    local r = n2 and n2:WaitForChild("RemoteEvent", 5)
    RemoteEvent = r
end)
if RemoteEvent then
else
end
getgenv().device = player:GetAttribute("Device")
if type(getgenv().device) == "table" then
    getgenv().device = getgenv().device[1]
end
getgenv().device = tostring(getgenv().device or "PC")
getgenv().originalDevice = getgenv().device
getgenv().spoofDeviceEnabled = false
getgenv().selectedDevice = getgenv().device


local spoofDeviceSection = Tabs.Random:Section({
    Title = "欺骗设备",
    Icon = "smartphone",
    Opened = false,
})


spoofDeviceSection:Toggle({
    Flag = "EnableSpoofDevice",
    Title = "欺骗设备",
    Default = false,
    Callback = function(state)
        getgenv().spoofDeviceEnabled = state
        if state then
            if getgenv().heartbeatConn then
                getgenv().heartbeatConn:Disconnect()
            end
            getgenv().heartbeatConn = RunService.Heartbeat:Connect(function()
                getgenv().device = getgenv().selectedDevice
                RemoteEvent:FireServer("SetDevice", {buffer.fromstring("\""..getgenv().device.."\"")})
            end)
        else
            if getgenv().heartbeatConn then
                getgenv().heartbeatConn:Disconnect()
                getgenv().heartbeatConn = nil
            end
            getgenv().device = getgenv().originalDevice
            RemoteEvent:FireServer("SetDevice", {buffer.fromstring("\""..getgenv().device.."\"")})
        end
    end
})
spoofDeviceSection:Dropdown({
    Flag = "SelectDevice",
    Title = "选择设备",
    Values = {"PC", "Mobile", "Console"},
    Multi = false,
    Default = getgenv().selectedDevice,
    Callback = function(selectedOption)
        getgenv().selectedDevice = selectedOption
        if getgenv().spoofDeviceEnabled then
            getgenv().device = selectedOption
            RemoteEvent:FireServer("SetDevice", {buffer.fromstring("\""..selectedOption.."\"")})
        end
    end
})

local antiFootstepsSection = Tabs.Random:Section({
    Title = "反脚步声",
    Icon = "volume-x",
    Opened = false,
})
getgenv().blockFootstepPlayed = false
local function HookFootstepPlayed(enable)
    if enable then
        getgenv().activateRemoteHook("UnreliableRemoteEvent", "FootstepPlayed")
        getgenv().blockFootstepPlayed = true
    else
        getgenv().deactivateRemoteHook("UnreliableRemoteEvent", "FootstepPlayed")
        getgenv().blockFootstepPlayed = false
    end
end
antiFootstepsSection:Toggle({
    Flag = "AntiFootsteps",
    Title = "无脚步声",
    Default = false,
    Callback = function(value)
        if value then
            HookFootstepPlayed(true)
        else
            HookFootstepPlayed(false)
        end
    end
})

local antiHiddenStatsSection = Tabs.Random:Section({
    Title = "查看他人隐藏战绩",
    Icon = "eye",
    Opened = false,
})
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
getgenv().originalValues = {}
getgenv().paths = {"HideKillerWins", "HidePlaytime", "HideSurvivorWins"}
getgenv().toggleState = false
local function saveOriginalValues(player)
    if player == LocalPlayer then return end
    if not getgenv().originalValues[player.UserId] then
        getgenv().originalValues[player.UserId] = {}
    end
    for _, key in ipairs(getgenv().paths) do
        local value = player:FindFirstChild("PlayerData")
            and player.PlayerData:FindFirstChild("Settings")
            and player.PlayerData.Settings:FindFirstChild("Privacy")
            and player.PlayerData.Settings.Privacy:FindFirstChild(key)
        if value then
            getgenv().originalValues[player.UserId][key] = value.Value
        end
    end
end
local function setAllFalse(player)
    if player == LocalPlayer then return end
    for _, key in ipairs(getgenv().paths) do
        local value = player:FindFirstChild("PlayerData")
            and player.PlayerData:FindFirstChild("Settings")
            and player.PlayerData.Settings:FindFirstChild("Privacy")
            and player.PlayerData.Settings.Privacy:FindFirstChild(key)
        if value then
            value.Value = false
        end
    end
end
local function restoreValues(player)
    if player == LocalPlayer then return end
    if getgenv().originalValues[player.UserId] then
        for key, val in pairs(getgenv().originalValues[player.UserId]) do
            local value = player:FindFirstChild("PlayerData")
                and player.PlayerData:FindFirstChild("Settings")
                and player.PlayerData.Settings:FindFirstChild("Privacy")
                and player.PlayerData.Settings.Privacy:FindFirstChild(key)
            if value then
                value.Value = val
            end
        end
    end
end
local function togglePrivacy(disable)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if disable then
                saveOriginalValues(player)
                setAllFalse(player)
            else
                restoreValues(player)
            end
        end
    end
    getgenv().toggleState = disable
end
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer and getgenv().toggleState == true then
        saveOriginalValues(player)
        setAllFalse(player)
    end
end)
antiHiddenStatsSection:Toggle({
    Flag = "AntiHiddenStats",
    Title = "查看他人隐藏战绩",
    Default = false,
    Callback = function(value)
        if value then
            togglePrivacy(true)
        else
            togglePrivacy(false)
        end
    end
})

local cframeGhostingSection = Tabs.Random:Section({
    Title = "CFrame幽灵穿墙",
    Icon = "ghost",
    Opened = false,
})
cframeGhostingSection:Toggle({
    Flag = "CFrameGhosting",
    Title = "CFrame幽灵穿墙[用于卡坐标穿墙BUG]",
    Default = false,
    Callback = function(state)
        if state then
            getgenv().activateRemoteHook("UnreliableRemoteEvent", "UpdCF")
            local args = {
                "UpdateSettings",
                {
                    game:GetService("Players").LocalPlayer:WaitForChild("PlayerData"):WaitForChild("Settings"):WaitForChild("Advanced"):WaitForChild("ShowPlayerHitboxes"),
                    buffer.fromstring("true")
                }
            }
            pcall(function()
                local rs = game:GetService("ReplicatedStorage")
                local m = rs:WaitForChild("Modules", 5)
                local n = m and m:WaitForChild("Network", 5)
                local n2 = n and n:WaitForChild("Network", 5)
                local r = n2 and n2:WaitForChild("RemoteEvent", 5)
                if r then r:FireServer(unpack(args))
                else print("inline FireServer错误：找不到RemoteEvent") end
            end)
        else
            getgenv().deactivateRemoteHook("UnreliableRemoteEvent", "UpdCF")
            local args = {
                "UpdateSettings",
                {
                    game:GetService("Players").LocalPlayer:WaitForChild("PlayerData"):WaitForChild("Settings"):WaitForChild("Advanced"):WaitForChild("ShowPlayerHitboxes"),
                    buffer.fromstring("false")
                }
            }
            pcall(function()
                local rs = game:GetService("ReplicatedStorage")
                local m = rs:WaitForChild("Modules", 5)
                local n = m and m:WaitForChild("Network", 5)
                local n2 = n and n:WaitForChild("Network", 5)
                local r = n2 and n2:WaitForChild("RemoteEvent", 5)
                if r then r:FireServer(unpack(args))
                else print("inline FireServer错误：找不到RemoteEvent") end
            end)
        end
    end
})

do
    local enabled         = false
    local wasLastSurvivor = false
    local RemoteEvent
    pcall(function()
        local m = ReplicatedStorage:WaitForChild("Modules", 5)
        local n = m and m:WaitForChild("Network", 5)
        local n2 = n and n:WaitForChild("Network", 5)
        local r = n2 and n2:WaitForChild("RemoteEvent", 5)
        RemoteEvent = r
    end)
    if RemoteEvent then
    else
    end

    local function fireAbility(name)
        RemoteEvent:FireServer("UseActorAbility", { buffer.fromstring('"' .. name .. '"') })
    end

    local abilityMap = {
        ["007n7"]   = function() fireAbility("WalkspeedOverride") end,
        ["TwoTime"] = function() fireAbility("Stab")              end,
        ["Noob"]    = function() fireAbility("Punch")             end,
    }

    local function tryAbility(char)
        if not enabled or not char then return end
        for key, fn in pairs(abilityMap) do
            if char.Name:find(key) then pcall(fn); break end
        end
    end

    RunService.Heartbeat:Connect(function()
        if not enabled then return end
        local themes = workspace:FindFirstChild("Themes")
        local lms    = themes and themes:FindFirstChild("LastSurvivor")
        if lms and not wasLastSurvivor then
            tryAbility(LocalPlayer.Character)
            wasLastSurvivor = true
        elseif not lms then
            wasLastSurvivor = false
        end
    end)

    LocalPlayer.CharacterAdded:Connect(tryAbility)

    local lmsSection = Tabs.Random:Section({
        Title = "LMS自动技能",
        Icon = "zap",
        Opened = false,
    })

    lmsSection:Toggle({
        Flag = "LMSAutoAbility",
        Title = "LMS自动技能[007n7,Two Time,Noob]",
        Default = false,
        Callback = function(state) enabled = state end
    })
end


local guestAnimSection = Tabs.Random:Section({
    Title = "访客动画",
    Icon = "user",
    Opened = false,
})

        local Players = game:GetService("Players")
        local UserInputService = game:GetService("UserInputService")
        local LocalPlayer = Players.LocalPlayer
        local function playAnimation(animId)
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local Humanoid = Character:WaitForChild("Humanoid")
            local Animation = Instance.new("Animation")
            Animation.AnimationId = animId
            local track = Humanoid:LoadAnimation(Animation)
            track:Play()
        end
        local Animations = {
            ["Laggy (Guest)"] = "rbxassetid://136007065400978",
            ["Normal (Guest)"] = "rbxassetid://87259391926321",
            ["KJ (Guest)"] = "rbxassetid://138040001965654",
            ["Axe (Guest)"] = "rbxassetid://129843313690921",
            ["Fake Block m3/4 (Guest)"] = "rbxassetid://96959123077498",
            ["Fake Block m1/2 (Guest)"] = "rbxassetid://72722244508749"
        }
        local selectedAnim = nil
        guestAnimSection:Dropdown({
            Title = "选择动画",
            Values = {
                "Laggy (Guest)",
                "Normal (Guest)",
                "KJ (Guest)",
                "Axe (Guest)",
                "Fake Block m3/4 (Guest)",
                "Fake Block m1/2 (Guest)"
            },
            Value = "",
            Multi = false,
            AllowNone = true,
            Callback = function(Value)
                selectedAnim = Animations[Value]
            end
        })
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.ResetOnSpawn = false
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0, 30, 0, 30)
        Button.Position = UDim2.new(0.05, 0, 0.2, 0)
        Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Button.Text = ""
        Button.BorderSizePixel = 2
        Button.BorderColor3 = Color3.fromRGB(0, 100, 255)
        Button.Active = true
        Button.Draggable = true
        Button.Visible = false
        Button.Parent = ScreenGui
        Button.MouseButton1Click:Connect(function()
            if selectedAnim then
                playAnimation(selectedAnim)
            end
        end)

        guestAnimSection:Toggle({
            Title = "打开GUI按钮",
            Default = false,
            Callback = function(value)
                Button.Visible = value
            end
        })

        local animationKey = Enum.KeyCode.L
        guestAnimSection:Input({
            Flag = "GuestAnimKeyBind",
            Title = "设置KeyBind",
            Default = "L",
            Callback = function(value)
                local success, key = pcall(function()
                    return Enum.KeyCode[value:upper()]
                end)
                if success and key then
                    animationKey = key
                end
            end
        })
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == animationKey then
                if selectedAnim then
                    playAnimation(selectedAnim)
                end
            end
        end)

local customMusicSection = Tabs.Random:Section({
    Title = "自定义LMS音乐",
    Icon = "music",
    Opened = false,
})
local autoEnabled = false
local selectedSongName = "Burnout"
local customSongId = nil
local musicVolume = 5
local LMSSongs = {
    ["Burnout"] = "rbxassetid://130101085745481",
    ["Compass"] = "rbxassetid://127298326178102",
    ["Vanity"] = "rbxassetid://137266220091579",
    ["Close To Me"] = "rbxassetid://90022574613230",
    ["Plead"] = "rbxassetid://80564889711353",
    ["Creation Of Hatred"] = "rbxassetid://115884097233860",
    ["Hacklord LMS"] = "rbxassetid://134062685653533"
}
function getSongNames()
    local names = {}
    for name, _ in pairs(LMSSongs) do
        table.insert(names, name)
    end
    return names
end
customMusicSection:Toggle({
    Flag = "CustomLMSMusic",
    Title = "自定义LMS音乐",
    Default = autoEnabled,
    Callback = function(state)
        autoEnabled = state
    end
})
customMusicSection:Dropdown({
    Flag = "CustomLMSSong",
    Title = "准备好的歌曲",
    Values = getSongNames(),
    Multi = false,
    Default = selectedSongName,
    Callback = function(Value)
        selectedSongName = Value
        customSongId = nil
    end
})
customMusicSection:Input({
    Flag = "CustomMusicID",
    Title = "音乐ID[仅限数字]",
    Default = "",
    Callback = function(text)
        if tonumber(text) and text ~= "" then
            customSongId = "rbxassetid://" .. text
        else
            customSongId = nil
        end
    end
})
customMusicSection:Slider({
    Flag = "MusicVolume",
    Title = "音乐音量",
    Step = 1,
    Value = {Min = 1, Max = 45, Default = 5},
    Callback = function(value)
        musicVolume = value
    end
})
customMusicSection:Paragraph({
    Title = "自定义LMS",
    Desc = "你可以在robloxsong.com上获得ID"
})
local function checkSurvivorsAndPlayMusic()
    if not autoEnabled then return end
    local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
    if not survivorsFolder then return end
    local survivorCount = #survivorsFolder:GetChildren()
    local themes = workspace:FindFirstChild("Themes")
    if themes then
        local lastSurvivorSound = themes:FindFirstChild("LastSurvivor")
        if not lastSurvivorSound then return end
        if survivorCount == 1 then
            local songIdToPlay
            if customSongId then
                songIdToPlay = customSongId
            else
                songIdToPlay = LMSSongs[selectedSongName]
            end
            if songIdToPlay and lastSurvivorSound.SoundId ~= songIdToPlay then
                lastSurvivorSound.SoundId = songIdToPlay
                lastSurvivorSound.Volume = musicVolume
                lastSurvivorSound:Play()
            elseif lastSurvivorSound.Volume ~= musicVolume then
                lastSurvivorSound.Volume = musicVolume
            end
        else
            if lastSurvivorSound.IsPlaying then
                lastSurvivorSound:Stop()
            end
        end
    end
end
spawn(function()
    while true do
        wait(0.5)
        checkSurvivorsAndPlayMusic()
    end
end)


local antiSentrySection = Tabs.Random:Section({
    Title = "反哨兵",
    Icon = "shield-alert",
    Opened = false,
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local zoneSettings = {
    enabled = false,
    size = Vector3.new(8, 8, 15),
    transparency = 0,
    color = BrickColor.new("Royal purple"),
    offset = CFrame.new(0, 0, -8)
}
local currentZone = nil
local protectionTask = nil

local function createProtectedZone()
    if not zoneSettings.enabled then return end
    local character = player.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if currentZone and currentZone.Parent then
        currentZone:Destroy()
    end
    local zone = Instance.new("Part")
    zone.Name = "BlockZone"
    zone.Size = zoneSettings.size
    zone.CFrame = hrp.CFrame * zoneSettings.offset
    zone.Anchored = false
    zone.CanCollide = false
    zone.Material = Enum.Material.ForceField
    zone.BrickColor = zoneSettings.color
    zone.Transparency = zoneSettings.transparency
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = hrp
    weld.Part1 = zone
    weld.Parent = zone
    local highlight = Instance.new("Highlight")
    highlight.Adornee = zone
    highlight.FillColor = Color3.fromRGB(180, 0, 255)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.7
    highlight.Parent = zone
    zone.Parent = character
    currentZone = zone
    zone.AncestryChanged:Connect(function()
        if not zone.Parent and zoneSettings.enabled then
            task.wait(0.1)
            createProtectedZone()
        end
    end)
    return zone
end

local function destroyZone()
    if currentZone and currentZone.Parent then
        currentZone:Destroy()
        currentZone = nil
    end
end

local function startProtection()
    if protectionTask then
        task.cancel(protectionTask)
    end
    protectionTask = task.spawn(function()
        while zoneSettings.enabled do
            task.wait(1)
            if player.Character and not player.Character:FindFirstChild("BlockZone") then
                createProtectedZone()
            end
        end
    end)
end

local function stopProtection()
    if protectionTask then
        task.cancel(protectionTask)
        protectionTask = nil
    end
end

antiSentrySection:Toggle({
    Flag = "AntiSentry",
    Title = "反哨兵机关[塔夫无效]",
    Default = false,
    Callback = function(value)
        zoneSettings.enabled = value
        if value then
            createProtectedZone()
            startProtection()
        else
            stopProtection()
            destroyZone()
        end
    end
})

player.CharacterAdded:Connect(function()
    task.wait(1)
    if zoneSettings.enabled then
        createProtectedZone()
    end
end)

local johnDoeSection = Tabs.Random:Section({
    Title = "反约翰多",
    Icon = "skull",
    Opened = false,
})

johnDoeSection:Button({
    Title = "自动清除约翰多尖刺",
    Callback = function()
        local spikeFolder = workspace:WaitForChild("Map"):WaitForChild("Ingame")
        if spikeFolder:FindFirstChild("Spike") then
            for _, spike in pairs(spikeFolder.Spike:GetChildren()) do
                spike:Destroy()
            end
        end
        spikeFolder.ChildAdded:Connect(function(child)
            if child.Name == "Spike" then
                child:Destroy()
            end
        end)
        game:GetService("RunService").RenderStepped:Connect(function()
            local spike = spikeFolder:FindFirstChild("Spike")
            if spike then
                for _, obj in pairs(spike:GetChildren()) do
                    obj:Destroy()
                end
            end
        end)
    end
})

local trailLoopActive = false
johnDoeSection:Toggle({
    Flag = "DeleteJohnDoeTrail",
    Title = "删除约翰多残影",
    Default = false,
    Callback = function(state)
        trailLoopActive = state
        if trailLoopActive then
            task.spawn(function()
                while trailLoopActive do
                    local path = workspace.Players.Killers:FindFirstChild("JohnDoe")
                    if path and path:FindFirstChild("JohnDoeTrail") then
                        path.JohnDoeTrail:Destroy()
                    end
                    RunService.Heartbeat:Wait()
                end
            end)
        end
    end
})

local guestSkinSection = Tabs.Random:Section({
    Title = "访客皮肤",
    Icon = "paintbrush",
    Opened = false,
})

guestSkinSection:Button({
    Title = "访客随机皮肤",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/aA8hWXJF"))()
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local brightYellow = Color3.fromRGB(255, 220, 100)
        local faceDecalId = "rbxassetid://8855105222"
        local scarfMeshId = "rbxassetid://12327157296"
        local scarfTextureId = "rbxassetid://13547353512"
        local hairMeshId = "http://www.roblox.com/asset/?id=398987591"
        local hairTextureId = "http://www.roblox.com/asset/?id=398618334"
        local function cleanCharacter(char)
            local humanoid = char:WaitForChild("Humanoid")
            if char:FindFirstChild("ExpressionHolder") then
                char.ExpressionHolder:Destroy()
            end
            if humanoid then
                humanoid:RemoveAccessories()
            end
            for _, v in pairs(char:GetChildren()) do
                if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then
                    v:Destroy()
                end
            end
            local head = char:FindFirstChild("Head")
            if head then
                for _, v in pairs(head:GetChildren()) do
                    if v:IsA("Decal") and v.Name ~= "Face" then
                        v:Destroy()
                    end
                end
            end
        end
        local function createScarf(char)
            local scarf = Instance.new("Accessory")
            scarf.Name = "CustomScarf"
            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(1,1,1)
            handle.CanCollide = false
            handle.Color = Color3.fromRGB(27, 42, 53)
            handle.Parent = scarf
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshId = scarfMeshId
            mesh.TextureId = scarfTextureId
            mesh.Scale = Vector3.new(1.071,1.071,1.071)
            mesh.Parent = handle
            local attachment = Instance.new("Attachment")
            attachment.Name = "NeckAttachment"
            attachment.CFrame = CFrame.new(0,0.5,0)
            attachment.Parent = handle
            local weld = Instance.new("Weld")
            weld.Part0 = handle
            weld.Part1 = char:WaitForChild("Torso")
            weld.C0 = CFrame.new(0, 0.1, 1.2) * CFrame.Angles(0, math.rad(180), 0)
            weld.Parent = handle
            scarf.Parent = char
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:AddAccessory(scarf)
            end
        end
        local function createHair(char)
            local head = char:FindFirstChild("Head")
            if not head then return end
            local hair = Instance.new("Accessory")
            hair.Name = "CustomHair"
            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(1,1,1)
            handle.CanCollide = false
            handle.Parent = hair
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshId = hairMeshId
            mesh.TextureId = hairTextureId
            mesh.Scale = Vector3.new(1.05,1.05,1.05)
            mesh.Offset = Vector3.new(0,-0.1,0.05)
            mesh.Parent = handle
            hair.Parent = char
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:AddAccessory(hair)
                if humanoid.RigType == Enum.HumanoidRigType.R6 then
                    local weld = Instance.new("Weld")
                    weld.Part0 = head
                    weld.Part1 = handle
                    weld.C0 = CFrame.new(0, -0.1, 0.05)
                    weld.Parent = handle
                end
            end
        end
        local function applyStyle(char)
            cleanCharacter(char)
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Color = brightYellow
                end
            end
            local bodyColors = Instance.new("BodyColors")
            bodyColors.HeadColor3 = brightYellow
            bodyColors.LeftArmColor3 = brightYellow
            bodyColors.RightArmColor3 = brightYellow
            bodyColors.LeftLegColor3 = brightYellow
            bodyColors.RightLegColor3 = brightYellow
            bodyColors.TorsoColor3 = brightYellow
            bodyColors.Parent = char
            local shirt = Instance.new("Shirt")
            shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=836903658"
            shirt.Parent = char
            local pants = Instance.new("Pants")
            pants.PantsTemplate = "http://www.roblox.com/asset/?id=731578592"
            pants.Parent = char
            createScarf(char)
            createHair(char)
            local head = char:FindFirstChild("Head")
            if head and not head:FindFirstChild("Face") then
                local decal = Instance.new("Decal")
                decal.Name = "Face"
                decal.Texture = faceDecalId
                decal.Face = Enum.NormalId.Front
                decal.Parent = head
            end
            pcall(function()
                local playergui = player:FindFirstChild("PlayerGui")
                if playergui and playergui:FindFirstChild("TemporaryUI") and playergui.TemporaryUI:FindFirstChild("PlayerInfo") then
                    playergui.TemporaryUI.PlayerInfo.PlayerIcon.Image = "http://www.roblox.com/asset/?id=97047410245118"
                end
            end)
        end
        applyStyle(player.Character or player.CharacterAdded:Wait())
    end
})


local manualFixSection = Tabs.Generator:Section({
    Title = "手动修发电机",
    Icon = "pickaxe",
    Opened = false,
})

local Players2 = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer2 = Players2.LocalPlayer
local KeyBind = Enum.KeyCode.Y
local screenGui = nil
local button = nil
local cooldown = false
local cooldownTime = 1.50
local inputConnection = nil

local function getClosestGenerator()
    local character = LocalPlayer2.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    local hrp = character.HumanoidRootPart
    local folder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
    local map = folder and folder:FindFirstChild("Map")
    if not map then return nil end
    local closestGen = nil
    local closestDist = math.huge
    for _, g in ipairs(map:GetChildren()) do
        if g.Name == "Generator" and g:FindFirstChild("Progress") and tonumber(g.Progress.Value) < 100 then
            local dist = (g:GetPivot().Position - hrp.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closestGen = g
            end
        end
    end
    return closestGen
end

local function activateGenerator()
    if cooldown then return end
    if not button then return end
    local gen = getClosestGenerator()
    if gen and gen:FindFirstChild("Remotes") and gen.Remotes:FindFirstChild("RE") then
        gen.Remotes.RE:FireServer()
    end
    cooldown = true
    local timeLeft = tonumber(cooldownTime) or 1.5
    button.Text = string.format("%.2f", timeLeft)
    task.spawn(function()
        while timeLeft > 0 do
            task.wait(0.01)
            timeLeft = timeLeft - 0.01
            if button then
                button.Text = string.format("%.2f", timeLeft)
            end
        end
        if button then
            button.Text = ""
        end
        cooldown = false
    end)
end

local function createGUI()
    if screenGui then return end
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GeneratorButtonGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer2:WaitForChild("PlayerGui")
    button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 50, 0, 50)
    button.Position = UDim2.new(0, 10, 0, 10)
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    button.BorderColor3 = Color3.fromRGB(150, 0, 255)
    button.Text = ""
    button.TextScaled = true
    button.Parent = screenGui
    button.Active = true
    button.Draggable = true
    button.MouseButton1Click:Connect(activateGenerator)
    inputConnection = UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == KeyBind then
            activateGenerator()
        end
    end)
end

local function destroyGUI()
    if inputConnection then
        inputConnection:Disconnect()
        inputConnection = nil
    end
    if screenGui then
        screenGui:Destroy()
        screenGui = nil
        button = nil
    end
end

manualFixSection:Toggle({
    Flag = "ShowManualFixGUI",
    Title = "打开手动修发电机GUI",
    Default = false,
    Callback = function(state)
        if state then
            createGUI()
        else
            destroyGUI()
        end
    end
})


manualFixSection:Slider({
    Flag = "ManualFixCooldown",
    Title = "冷却时间",
    Step = 0.05,
    Value = {Min = 0.5, Max = 5, Default = 1.5},
    Suffix = "s",
    Callback = function(value)
        cooldownTime = tonumber(value) or 1.5
    end
})

manualFixSection:Input({
    Flag = "ManualFixKeyBind",
    Title = "手动修发电机快捷键设置",
    Default = "Y",
    Callback = function(value)
        value = tostring(value):upper()
        local success, keyEnum = pcall(function()
            return Enum.KeyCode[value]
        end)
        if success and keyEnum then
            KeyBind = keyEnum
        
        else
        end
    end
})

local autoFixSection = Tabs.Generator:Section({
    Title = "自动修发电机",
    Icon = "zap",
    Opened = false,
})

local autoFixEnabled = false
local autoMiniGameEnabled = false
local flowGameHooked = false

local function TpDoGenerator()
    local Players = game:GetService("Players")
    local character = Players.LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    local lastPosition = character.HumanoidRootPart.CFrame
    local function findGenerators()
        local folder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
        local map = folder and folder:FindFirstChild("Map")
        local generators = {}
        if map then
            for _, g in ipairs(map:GetChildren()) do
                if g.Name == "Generator" and g:FindFirstChild("Progress") and tonumber(g.Progress.Value) < 100 then
                    local playersNearby = false
                    for _, player in ipairs(game.Players:GetPlayers()) do
                        if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and g:FindFirstChild("Main") then
                            local distance = (player.Character.HumanoidRootPart.Position - g.Main.Position).Magnitude
                            if distance < 25 then
                                playersNearby = true
                                break
                            end
                        end
                    end
                    if not playersNearby then
                        table.insert(generators, g)
                    end
                end
            end
        end
        return generators
    end
    while autoFixEnabled do
        local generators = findGenerators()
        if #generators == 0 then
            task.wait(1)
            continue
        end
        for _, g in ipairs(generators) do
            if not autoFixEnabled then break end
            local player = game.Players.LocalPlayer
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                break
            end
            if g:FindFirstChild("Instances") and g.Instances:FindFirstChild("Generator") then
                local generatorInst = g.Instances.Generator
                if generatorInst:FindFirstChild("Progress") and generatorInst:FindFirstChild("Cube") then
                    local generatorPosition = generatorInst.Progress.CFrame.Position
                    local generatorDirection = (generatorInst.Cube.CFrame.Position - generatorPosition).Unit
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(
                        generatorPosition + Vector3.new(0, 0.5, 0),
                        generatorPosition + Vector3.new(generatorDirection.X, 0, generatorDirection.Z)
                    )
                end
            end
            task.wait(0.5)
            if g:FindFirstChild("Main") and g.Main:FindFirstChild("Prompt") and fireproximityprompt then
                fireproximityprompt(g.Main.Prompt)
            end
            while autoFixEnabled and g:FindFirstChild("Progress") and tonumber(g.Progress.Value) < 100 do
                task.wait(1.5)
                if g:FindFirstChild("Remotes") and g.Remotes:FindFirstChild("RE") then
                    g.Remotes.RE:FireServer()
                end
            end
            if g:FindFirstChild("Remotes") and g.Remotes:FindFirstChild("RF") then
                g.Remotes.RF:InvokeServer("leave")
            end
            task.wait(0.5)
        end
    end
    if lastPosition and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lastPosition
    end
end

autoFixSection:Toggle({
    Flag = "AutoFixGenerators",
    Title = "自动传送修发电机",
    Default = false,
    Callback = function(state)
        autoFixEnabled = state
        if state then
            task.spawn(TpDoGenerator)
        else
        end
    end
})

local autoMiniGameDelay = 0.5
autoFixSection:Slider({
    Flag = "MiniGameSolveDelay",
    Title = "小游戏通关完成速度",
    Step = 0.1,
    Value = {Min = 0.1, Max = 10, Default = 0.1},
    Callback = function(value)
        autoMiniGameDelay = value
    end
})

autoFixSection:Toggle({
    Flag = "AutoCompleteMiniGame",
    Title = "发电机小游戏自动完成",
    Default = false,
    Callback = function(state)
        autoMiniGameEnabled = state
        if state and not flowGameHooked then
            flowGameHooked = true
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local function getDirection(currentRow, currentCol, otherRow, otherCol)
                currentRow = tonumber(currentRow) or 0
                currentCol = tonumber(currentCol) or 0
                otherRow = tonumber(otherRow) or 0
                otherCol = tonumber(otherCol) or 0
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
                    elseif dir == "right" then dir = "left"
                    end
                    if dir then connections[dir] = true end
                end
                if nextnode and curr then
                    local dir = getDirection(curr.row, curr.col, nextnode.row, nextnode.col)
                    if dir then connections[dir] = true end
                end
                return connections
            end
            local function isNeighbourLocal(r1, c1, r2, c2)
                r1, c1, r2, c2 = tonumber(r1) or 0, tonumber(c1) or 0, tonumber(r2) or 0, tonumber(c2) or 0
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
                for _, ep in ipairs(endpoints or {}) do
                    for _, n in ipairs(path) do
                        if tonumber(n.row) == tonumber(ep.row) and tonumber(n.col) == tonumber(ep.col) then
                            startEndpoint = { row = ep.row, col = ep.col }
                            break
                        end
                    end
                    if startEndpoint then break end
                end
                if not startEndpoint then
                    local inPath = {}
                    for _, n in ipairs(path) do
                        inPath[coordKey(n)] = n
                    end
                    for _, n in ipairs(path) do
                        local neighbours = 0
                        local nRow, nCol = tonumber(n.row) or 0, tonumber(n.col) or 0
                        local dirs = { { nRow - 1, nCol }, { nRow + 1, nCol }, { nRow, nCol - 1 }, { nRow, nCol + 1 } }
                        for _, dir in ipairs(dirs) do
                            if inPath[`{dir[1]}-{dir[2]}`] then
                                neighbours = neighbours + 1
                            end
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
                for _, n in ipairs(path) do
                    remaining[coordKey(n)] = { row = n.row, col = n.col }
                end
                local ordered = {}
                local current = { row = startEndpoint.row, col = startEndpoint.col }
                table.insert(ordered, { row = current.row, col = current.col })
                remaining[coordKey(current)] = nil
                while true do
                    local hasRemaining = false
                    for _ in pairs(remaining) do hasRemaining = true break end
                    if not hasRemaining then break end
                    local foundNext = false
                    for key, node in pairs(remaining) do
                        if isNeighbourLocal(current.row, current.col, node.row, node.col) then
                            table.insert(ordered, { row = node.row, col = node.col })
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
            local function DrawSolutionOneByOne(puzzle)
                if not autoMiniGameEnabled then return end
                if not puzzle or not puzzle.Solution then return end
                local totalPaths = #puzzle.Solution
                local indices = {}
                for i = 1, totalPaths do table.insert(indices, i) end
                for i = #indices - 1, 2, -1 do
                    local j = math.random(1, i)
                    indices[i + 1], indices[j + 1] = indices[j + 1], indices[i + 1]
                end
                for _, colorIndex in ipairs(indices) do
                    if not autoMiniGameEnabled then return end
                    local path = puzzle.Solution[colorIndex]
                    local endpoints = puzzle.targetPairs[colorIndex]
                    local orderedPath = orderPathFromEndpoints(path, endpoints)
                    puzzle.paths[colorIndex] = {}
                    for i = 1, #orderedPath do
                        if not autoMiniGameEnabled then return end
                        local node = orderedPath[i]
                        table.insert(puzzle.paths[colorIndex], { row = node.row, col = node.col })
                        local prev = orderedPath[i - 1]
                        local nextNode = orderedPath[i + 1]
                        local conn = getConnections(prev, node, nextNode)
                        puzzle.gridConnections = puzzle.gridConnections or {}
                        puzzle.gridConnections[`{node.row}-{node.col}`] = conn
                        if puzzle.updateGui then puzzle:updateGui() end
                        task.wait(autoMiniGameDelay)
                    end
                    if puzzle.checkForWin then puzzle:checkForWin() end
                end
                if puzzle.checkForWin then puzzle:checkForWin() end
            end
            local _result = ReplicatedStorage:FindFirstChild("Modules")
            if _result then _result = _result:FindFirstChild("Misc") end
            if _result then _result = _result:FindFirstChild("FlowGameManager") end
            if _result then _result = _result:FindFirstChild("FlowGame") end
            if _result then
                local success, FlowGameModule = pcall(function() return require(_result) end)
                if success and FlowGameModule and FlowGameModule.new then
                    local old = FlowGameModule.new
                    FlowGameModule.new = function(...)
                        local output = { old(...) }
                        local puzzle = output[1]
                        if autoMiniGameEnabled then
                            task.spawn(function()
                                DrawSolutionOneByOne(puzzle)
                            end)
                        end
                        return puzzle
                    end
                end
            end
        end
        if state then
        else
        end
    end
})


local sk8FarmSection = Tabs.Generator:Section({
    Title = "Veeronica滑行挂机[可用于电池充电]",
    Icon = "activity",
    Opened = false,
})
sk8FarmSection:Paragraph({
    Title = "怎么用呢？",
    Desc = "先开启滑板技能，再点击开始挂机，想要效果更佳，请配合无限体力、自动特技、滑板控制一起使用，本功能同时可用于电池充电，完成后点击停止挂机即可，请找一个不会受到伤害的角度进行挂机",
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local distance = 2
local part = nil
local heartbeatConnection = nil

local function createCube()
    if part then return end
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local camera = workspace.CurrentCamera
    part = Instance.new("Part")
    part.Size = Vector3.new(10, 10, 10)
    part.Anchored = true
    part.CanCollide = true
    part.Color = Color3.fromRGB(255, 255, 0)
    part.CFrame = CFrame.new((camera.CFrame * CFrame.new(0, 0, -10)).Position)
    part.Orientation = Vector3.new(0, 0, 0)
    part.Name = "TeleportCube"
    part.Parent = workspace
    heartbeatConnection = RunService.Heartbeat:Connect(function()
        if part and hrp then
            local offset = Vector3.new(0, 0, part.Size.Z/2 + distance)
            local targetPos = (part.CFrame * CFrame.new(offset)).Position
            hrp.CFrame = CFrame.new(targetPos, targetPos + hrp.CFrame.LookVector)
        end
    end)
end

local function removeCube()
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
    if part then
        part:Destroy()
        part = nil
    end
end

sk8FarmSection:Button({
    Title = "开启农场",
    Callback = function()
        createCube()
    end
})

sk8FarmSection:Button({
    Title = "关闭农场",
    Callback = function()
        removeCube()
    end
})


do
    local enabled = false
    local RemoteEvent
    pcall(function()
        local m = ReplicatedStorage:WaitForChild("Modules", 5)
        local n = m and m:WaitForChild("Network", 5)
        local n2 = n and n:WaitForChild("Network", 5)
        local r = n2 and n2:WaitForChild("RemoteEvent", 5)
        RemoteEvent = r
    end)
    if RemoteEvent then
    else
    end
    local args    = { LocalPlayer.Name .. "SkateTrick", {} }

    RunService.Heartbeat:Connect(function()
        if enabled then RemoteEvent:FireServer(unpack(args)) end
    end)

    local farmSkateSection = Tabs.Generator:Section({
        Title = "滑板农场",
        Icon = "zap",
        Opened = false,
    })

    farmSkateSection:Toggle({
        Flag = "FarmMoneySkateboard",
        Title = "滑板金钱农场[先激活滑板]",
        Default = false,
        Callback = function(state) enabled = state end
    })
end

local UserInputService = game:GetService("UserInputService")
local isOpen = true
local toggleKey = Enum.KeyCode.P
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == toggleKey then
        if isOpen then
            Window:Close()
        else
            Window:Open()
        end
        isOpen = not isOpen
    end
end)

local uiSettingsSection = Tabs.Settings:Section({
    Title = "UI Settings",
    Icon = "monitor",
    Opened = false,
})

uiSettingsSection:Input({
    Flag = "ToggleKey",
    Title = "设置切换键[PC的关闭/打开UI]",
    Default = "P",
    Callback = function(value)
        value = tostring(value):upper()
        local keyEnum = Enum.KeyCode[value]
        if keyEnum then
            toggleKey = keyEnum
            Window:SetToggleKey(keyEnum)
            WindUI:Notify({
                Title = "按键已更改",
                Content = "Now using: " .. value,
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "错误",
                Content = "按键 '" .. value .. "' 不存在",
                Duration = 3
            })
        end
    end
})


local PRESET_NAME = "Auto block Preset"
local PRESET_JSON = [[
{
  "__version": 1.2,
  "__autoload": false,
  "__elements": {
    "AutoBlockMode": {
      "value": "Anti Bait",
      "__type": "Dropdown"
    },
    "HideNames": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoBlockZoneOutlineColor": {
      "value": "ffffff",
      "__type": "Colorpicker"
    },
    "GlideStabDuration": {
      "value": 0.4,
      "__type": "Slider"
    },
    "ColorTrapwire": {
      "value": "ff8c00",
      "__type": "Colorpicker"
    },
    "ZoneSmoothingEnabled": {
      "value": true,
      "__type": "Toggle"
    },
    "DelayBeforeBlockTime": {
      "value": 0.1,
      "__type": "Slider"
    },
    "MinStaminaValue": {
      "value": 0,
      "__type": "Slider"
    },
    "ESPCoolKidMinion": {
      "value": false,
      "__type": "Toggle"
    },
    "CustomFOVMultiplier": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoBlockRunZoneLength": {
      "value": "20.50",
      "__type": "Slider"
    },
    "CustomStaminaLoss": {
      "value": false,
      "__type": "Toggle"
    },
    "ESPSurvivors": {
      "value": true,
      "__type": "Toggle"
    },
    "HitboxDragShowRadius": {
      "value": false,
      "__type": "Toggle"
    },
    "MultiFrameEnabled": {
      "value": false,
      "__type": "Toggle"
    },
    "HighlightFillTransparency": {
      "value": "1.00",
      "__type": "Slider"
    },
    "ShowRole": {
      "value": false,
      "__type": "Toggle"
    },
    "HelpEvery": {
      "value": 0,
      "__type": "Slider"
    },
    "DangerousProximity": {
      "value": 12,
      "__type": "Slider"
    },
    "WaitDuration_Nosferatu": {
      "value": 0.3,
      "__type": "Slider"
    },
    "NosferatuRadius": {
      "value": 20,
      "__type": "Slider"
    },
    "ESPGenerators": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoBlockZoneVisibility": {
      "value": "0.00",
      "__type": "Slider"
    },
    "AutoSaveConfig": {
      "__type": "Dropdown"
    },
    "AntiSpinBaitMode": {
      "value": "Always",
      "__type": "Dropdown"
    },
    "BillboardOffset": {
      "value": 2.5,
      "__type": "Slider"
    },
    "AimbotPrediction": {
      "value": "0.04",
      "__type": "Slider"
    },
    "PartsWidth": {
      "value": 10,
      "__type": "Slider"
    },
    "ChanceAimbot": {
      "value": false,
      "__type": "Toggle"
    },
    "MSChecker": {
      "value": true,
      "__type": "Toggle"
    },
    "CustomStaminaGain": {
      "value": false,
      "__type": "Toggle"
    },
    "DeleteJohnDoeTrail": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoLoadEnabled": {
      "value": false,
      "__type": "Toggle"
    },
    "AntiSpinBaitPostAttackDelay": {
      "value": 0.03,
      "__type": "Slider"
    },
    "PitchDegrees": {
      "value": 40,
      "__type": "Slider"
    },
    "AntiStun": {
      "value": false,
      "__type": "Toggle"
    },
    "AimbotTarget": {
      "value": "Survivors",
      "__type": "Dropdown"
    },
    "ActivationRange": {
      "value": 20,
      "__type": "Slider"
    },
    "AutoClosePopups": {
      "value": false,
      "__type": "Toggle"
    },
    "HitboxExpander": {
      "value": false,
      "__type": "Toggle"
    },
    "InvisibilityDuration": {
      "value": 5,
      "__type": "Slider"
    },
    "AntiHiddenStats": {
      "value": false,
      "__type": "Toggle"
    },
    "WaitSomeUntilBlockDuration": {
      "value": "0.05",
      "__type": "Slider"
    },
    "ColorMinion1x1": {
      "value": "8b0000",
      "__type": "Colorpicker"
    },
    "ColorJohnDoe": {
      "value": "00ffff",
      "__type": "Colorpicker"
    },
    "ToggleKey": {
      "value": "",
      "__type": "Input"
    },
    "AutoBlockWindup": {
      "value": 75,
      "__type": "Slider"
    },
    "AutoCloseInterval": {
      "value": 0.01,
      "__type": "Slider"
    },
    "AutoHealTeammates": {
      "value": false,
      "__type": "Toggle"
    },
    "SpeedMultiplierValue": {
      "value": 1,
      "__type": "Slider"
    },
    "AutoBlockKillerLookingColor": {
      "value": "ff0000",
      "__type": "Colorpicker"
    },
    "AimbotClickTargetKey": {
      "value": "",
      "__type": "Input"
    },
    "ShowToggleButton": {
      "value": true,
      "__type": "Toggle"
    },
    "PunchHitboxPower": {
      "value": "44",
      "__type": "Slider"
    },
    "ESPSubspaceTripmine": {
      "value": false,
      "__type": "Toggle"
    },
    "PartsLifetime": {
      "value": 0.1,
      "__type": "Slider"
    },
    "SprintSpeedValue": {
      "value": 26,
      "__type": "Slider"
    },
    "AutoBlockAnimation": {
      "value": false,
      "__type": "Toggle"
    },
    "AntiSpinBaitColor": {
      "value": "ffa500",
      "__type": "Colorpicker"
    },
    "ColorKiller": {
      "value": "ff0000",
      "__type": "Colorpicker"
    },
    "ESPMode": {
      "value": [
        "Highlight",
        "Billboard"
      ],
      "__type": "Dropdown"
    },
    "AutoLoadConfig": {
      "__type": "Dropdown"
    },
    "WaitDuration_Slasher": {
      "value": 0.3,
      "__type": "Slider"
    },
    "AntiSpinBaitAngularHistoryDuration": {
      "value": "0.42",
      "__type": "Slider"
    },
    "ColorMedkit": {
      "value": "ff69b4",
      "__type": "Colorpicker"
    },
    "CustomSpeedMultiplier": {
      "value": false,
      "__type": "Toggle"
    },
    "AimbotMode": {
      "value": "CamLock+CharacterLock",
      "__type": "Dropdown"
    },
    "AutoInvisCrouch": {
      "value": false,
      "__type": "Toggle"
    },
    "NosferatuAutoRotate": {
      "value": false,
      "__type": "Toggle"
    },
    "NosferatuFarSpeed": {
      "value": 0.05,
      "__type": "Slider"
    },
    "AntiSpinBaitMaxAngularSpeed": {
      "value": "300",
      "__type": "Slider"
    },
    "AntiFog": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoBlockWalkZoneLength": {
      "value": 12,
      "__type": "Slider"
    },
    "ESPGraffiti": {
      "value": false,
      "__type": "Toggle"
    },
    "ColorSentry": {
      "value": "ffa500",
      "__type": "Colorpicker"
    },
    "PredictionStrength": {
      "value": "0.60",
      "__type": "Slider"
    },
    "ShowAIGUI": {
      "value": false,
      "__type": "Toggle"
    },
    "NosferatuFlightSpeed": {
      "value": 60,
      "__type": "Slider"
    },
    "WaitDuration_1x1x1x1": {
      "value": 0.3,
      "__type": "Slider"
    },
    "ESPTrapwire": {
      "value": false,
      "__type": "Toggle"
    },
    "NosferatuAutoComplete": {
      "value": false,
      "__type": "Toggle"
    },
    "MaxStaminaValue": {
      "value": 100,
      "__type": "Slider"
    },
    "ESPBloxyCola": {
      "value": false,
      "__type": "Toggle"
    },
    "AntiWrongBlock": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoBlockWalkZoneWidth": {
      "value": "9.00",
      "__type": "Slider"
    },
    "ChanceAimbotEnable": {
      "value": false,
      "__type": "Toggle"
    },
    "CustomLMSMusic": {
      "value": false,
      "__type": "Toggle"
    },
    "WallCheckVisualization": {
      "value": false,
      "__type": "Toggle"
    },
    "VoidRushNoCrash": {
      "value": false,
      "__type": "Toggle"
    },
    "NosferatuCloseSpeed": {
      "value": 0.005,
      "__type": "Slider"
    },
    "PizzaHPThreshold": {
      "value": 50,
      "__type": "Slider"
    },
    "MultiFrame": {
      "value": false,
      "__type": "Toggle"
    },
    "FallingZoneOffsetUp": {
      "value": "0.50",
      "__type": "Slider"
    },
    "HitboxDragMode": {
      "value": "BodyVelocity",
      "__type": "Dropdown"
    },
    "ESPMedkit": {
      "value": false,
      "__type": "Toggle"
    },
    "AIMode": {
      "value": "Killer Auto Play",
      "__type": "Dropdown"
    },
    "AutoTrick": {
      "value": false,
      "__type": "Toggle"
    },
    "HitboxDragRadiusColor": {
      "value": "00ff00",
      "__type": "Colorpicker"
    },
    "AntiSpinBaitMaxAngle": {
      "value": "82",
      "__type": "Slider"
    },
    "AutoBlockShowPlayerFacing": {
      "value": false,
      "__type": "Toggle"
    },
    "CFrameGhosting": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoSaveEnabled": {
      "value": false,
      "__type": "Toggle"
    },
    "NoCheckZone": {
      "value": true,
      "__type": "Toggle"
    },
    "ESPRitual": {
      "value": false,
      "__type": "Toggle"
    },
    "LockDuration": {
      "value": 1.4,
      "__type": "Slider"
    },
    "AutoBlockZoneVisualization": {
      "value": true,
      "__type": "Toggle"
    },
    "MiniGameSolveDelay": {
      "value": 0.1,
      "__type": "Slider"
    },
    "ShowManualFixGUI": {
      "value": false,
      "__type": "Toggle"
    },
    "ManualFixCooldown": {
      "value": 1.5,
      "__type": "Slider"
    },
    "EngageDistance": {
      "value": "200",
      "__type": "Slider"
    },
    "EnableBoost": {
      "value": false,
      "__type": "Toggle"
    },
    "ColorSurvivor": {
      "value": "00ff00",
      "__type": "Colorpicker"
    },
    "ChargeIgnoreObjectables": {
      "value": false,
      "__type": "Toggle"
    },
    "PredictionAmount": {
      "value": 0.08,
      "__type": "Slider"
    },
    "AutoInvisClone": {
      "value": false,
      "__type": "Toggle"
    },
    "HitboxDragRadius": {
      "value": "22",
      "__type": "Slider"
    },
    "CustomMusicID": {
      "value": "",
      "__type": "Input"
    },
    "BackstabType": {
      "__type": "Dropdown"
    },
    "PartsShowVisualization": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoEatPizza": {
      "value": false,
      "__type": "Toggle"
    },
    "EnablePrediction": {
      "value": false,
      "__type": "Toggle"
    },
    "PlasmaBeamSilentAim": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoBlockFacingMode": {
      "value": "No Check",
      "__type": "Dropdown"
    },
    "ColorSubspaceTripmine": {
      "value": "00ff7f",
      "__type": "Colorpicker"
    },
    "AimbotWallCheck": {
      "value": false,
      "__type": "Toggle"
    },
    "HitboxDistanceV12": {
      "value": 60,
      "__type": "Slider"
    },
    "MusicVolume": {
      "value": 5,
      "__type": "Slider"
    },
    "AutoInvisGhostburger": {
      "value": false,
      "__type": "Toggle"
    },
    "HitboxDragDuration": {
      "value": "0.30",
      "__type": "Slider"
    },
    "CustomMinStamina": {
      "value": false,
      "__type": "Toggle"
    },
    "ArrowSize": {
      "value": 10,
      "__type": "Slider"
    },
    "ESPKiller": {
      "value": true,
      "__type": "Toggle"
    },
    "Fullbright": {
      "value": false,
      "__type": "Toggle"
    },
    "CustomMaxStamina": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoBlockToggleKeybind": {
      "value": "",
      "__type": "Input"
    },
    "StaminaGainValue": {
      "value": 20,
      "__type": "Slider"
    },
    "ColorGingerbread": {
      "value": "cd853f",
      "__type": "Colorpicker"
    },
    "EnableEscapeAI": {
      "value": false,
      "__type": "Toggle"
    },
    "BackstabLockMode": {
      "__type": "Dropdown"
    },
    "DisengageDistance": {
      "value": "300",
      "__type": "Slider"
    },
    "AutoPunchLockMode": {
      "value": "CamLock+CharterLock",
      "__type": "Dropdown"
    },
    "AutoFixGenerators": {
      "value": false,
      "__type": "Toggle"
    },
    "ShowHitboxUI": {
      "value": false,
      "__type": "Toggle"
    },
    "ColorGraffiti": {
      "value": "800080",
      "__type": "Colorpicker"
    },
    "HitboxIncrease": {
      "value": 50,
      "__type": "Slider"
    },
    "TracersWidth": {
      "value": 1,
      "__type": "Slider"
    },
    "OrbitPlayers": {
      "value": false,
      "__type": "Toggle"
    },
    "AimbotEnable": {
      "value": false,
      "__type": "Toggle"
    },
    "Sk8Control": {
      "value": false,
      "__type": "Toggle"
    },
    "ESPFakeKiller": {
      "value": false,
      "__type": "Toggle"
    },
    "FallingDetection": {
      "value": true,
      "__type": "Toggle"
    },
    "WaitDuration_Sixer": {
      "value": 0.3,
      "__type": "Slider"
    },
    "AttackAlert": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoBlockZoneColor": {
      "value": "b400ff",
      "__type": "Colorpicker"
    },
    "ColorFakeKiller": {
      "value": "ff00ff",
      "__type": "Colorpicker"
    },
    "AntiWrongBlockRange": {
      "value": 15,
      "__type": "Slider"
    },
    "AutoBlockZoneCenterOffset": {
      "value": "-2.00",
      "__type": "Slider"
    },
    "TargetingType": {
      "value": "Lowest Health",
      "__type": "Dropdown"
    },
    "WaitSomeUntilBlock": {
      "value": false,
      "__type": "Toggle"
    },
    "ESPMinion1x1": {
      "value": false,
      "__type": "Toggle"
    },
    "NoCheckZoneRange": {
      "value": "7.50",
      "__type": "Slider"
    },
    "BackstabRange": {
      "value": 4,
      "__type": "Slider"
    },
    "AutoBlockRunZoneWidth": {
      "value": "9.50",
      "__type": "Slider"
    },
    "SkateboardIgnoreObjectables": {
      "value": false,
      "__type": "Toggle"
    },
    "BehindDistance": {
      "value": "1.70",
      "__type": "Slider"
    },
    "GlideStab": {
      "value": false,
      "__type": "Toggle"
    },
    "WaitDuration_JohnDoe": {
      "value": 0.3,
      "__type": "Slider"
    },
    "BillboardSizeSlider": {
      "value": 4,
      "__type": "Slider"
    },
    "FallingZoneOffsetDown": {
      "value": "0.50",
      "__type": "Slider"
    },
    "AutoBlockShowKillerLooking": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoClone": {
      "value": false,
      "__type": "Toggle"
    },
    "AntiSpinBaitPostAttack": {
      "value": false,
      "__type": "Toggle"
    },
    "AimbotSwitchKey": {
      "value": "",
      "__type": "Input"
    },
    "NoCheckZoneHeight": {
      "value": 5,
      "__type": "Slider"
    },
    "AntiWrongBlockVisualization": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoBlockPlayerFacingColor": {
      "value": "00008b",
      "__type": "Colorpicker"
    },
    "NosferatuFlightControl": {
      "value": false,
      "__type": "Toggle"
    },
    "FallingYThreshold": {
      "value": 0.5,
      "__type": "Slider"
    },
    "AutoBlockStandZoneLength": {
      "value": 10,
      "__type": "Slider"
    },
    "HitboxPower": {
      "value": 0.1,
      "__type": "Slider"
    },
    "AutoOffCheckInterval": {
      "value": 3,
      "__type": "Slider"
    },
    "SelectDevice": {
      "__type": "Dropdown"
    },
    "DisableStaminaLoss": {
      "value": false,
      "__type": "Toggle"
    },
    "AntiWrongBlockColor": {
      "value": "ffff00",
      "__type": "Colorpicker"
    },
    "GlideStabType": {
      "__type": "Dropdown"
    },
    "NoCheckZoneColor": {
      "value": "00ff00",
      "__type": "Colorpicker"
    },
    "OrbitSpeed": {
      "value": 5,
      "__type": "Slider"
    },
    "AntiSpinBaitVisualization": {
      "value": true,
      "__type": "Toggle"
    },
    "HitboxDragSpeed": {
      "value": "15",
      "__type": "Slider"
    },
    "AutoPunch": {
      "value": false,
      "__type": "Toggle"
    },
    "AlwaysBindsEnabled": {
      "value": false,
      "__type": "Toggle"
    },
    "AimbotKey": {
      "value": "",
      "__type": "Input"
    },
    "Backstab": {
      "value": false,
      "__type": "Toggle"
    },
    "DelayBeforeBlockEnabled": {
      "value": false,
      "__type": "Toggle"
    },
    "AimbotMobile": {
      "value": false,
      "__type": "Toggle"
    },
    "AntiFootsteps": {
      "value": false,
      "__type": "Toggle"
    },
    "WalkspeedOverrideIgnoreObjectables": {
      "value": false,
      "__type": "Toggle"
    },
    "ESPJohnDoe": {
      "value": false,
      "__type": "Toggle"
    },
    "HitboxVisualization": {
      "value": false,
      "__type": "Toggle"
    },
    "AntiSpinBait": {
      "value": true,
      "__type": "Toggle"
    },
    "AntiSlow": {
      "value": false,
      "__type": "Toggle"
    },
    "EnableSpoofDevice": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoCompleteMiniGame": {
      "value": false,
      "__type": "Toggle"
    },
    "HighlightOutlineTransparency": {
      "value": 0.1,
      "__type": "Slider"
    },
    "ZoneSmoothingStrength": {
      "value": "4.00",
      "__type": "Slider"
    },
    "ColorRitual": {
      "value": "960000",
      "__type": "Colorpicker"
    },
    "AutoOffEnabled": {
      "value": false,
      "__type": "Toggle"
    },
    "PartsSpawnDuration": {
      "value": "0.30",
      "__type": "Slider"
    },
    "ESPFakeGenerator": {
      "value": false,
      "__type": "Toggle"
    },
    "HitboxExpanderV12": {
      "value": false,
      "__type": "Toggle"
    },
    "ChanceAimbotSharpness": {
      "value": 4,
      "__type": "Slider"
    },
    "PartsLength": {
      "value": 10,
      "__type": "Slider"
    },
    "OrbitDistance": {
      "value": 10,
      "__type": "Slider"
    },
    "AutoBlockDetectionRange": {
      "value": "24.50",
      "__type": "Slider"
    },
    "CustomSprintSpeed": {
      "value": false,
      "__type": "Toggle"
    },
    "NoCheckZoneVisualization": {
      "value": true,
      "__type": "Toggle"
    },
    "KillerLookingTracerOffsetY": {
      "value": -1,
      "__type": "Slider"
    },
    "PartsOffsetZ": {
      "value": 0,
      "__type": "Slider"
    },
    "ShowHP": {
      "value": true,
      "__type": "Toggle"
    },
    "AntiSentry": {
      "value": false,
      "__type": "Toggle"
    },
    "Invisibility": {
      "value": false,
      "__type": "Toggle"
    },
    "WallCheckColor": {
      "value": "ff6464",
      "__type": "Colorpicker"
    },
    "PunchHitboxIncrease": {
      "value": true,
      "__type": "Toggle"
    },
    "ReverseDirection": {
      "value": false,
      "__type": "Toggle"
    },
    "WaitDuration_C00lkid": {
      "value": 0.3,
      "__type": "Slider"
    },
    "ColorFakeGenerator": {
      "value": "808080",
      "__type": "Colorpicker"
    },
    "AutoBlockFacingAngle": {
      "value": 90,
      "__type": "Slider"
    },
    "PartsSpawnInterval": {
      "value": 0.01,
      "__type": "Slider"
    },
    "WallCheck": {
      "value": false,
      "__type": "Toggle"
    },
    "NosferatuVerticalSpeed": {
      "value": 40,
      "__type": "Slider"
    },
    "ColorCoolKidMinion": {
      "value": "ffc0cb",
      "__type": "Colorpicker"
    },
    "CustomLMSSong": {
      "__type": "Dropdown"
    },
    "AutoBlockZoneHeight": {
      "value": 7,
      "__type": "Slider"
    },
    "ManualFixKeyBind": {
      "value": "",
      "__type": "Input"
    },
    "PlayerFacingTracerOffsetY": {
      "value": 1,
      "__type": "Slider"
    },
    "WaitDuration_Jason": {
      "value": 0.3,
      "__type": "Slider"
    },
    "BackstabAimDuration": {
      "value": 0.5,
      "__type": "Slider"
    },
    "RemoveEffects": {
      "value": false,
      "__type": "Toggle"
    },
    "PartsOffsetY": {
      "value": 0,
      "__type": "Slider"
    },
    "PartsColor": {
      "value": "b400ff",
      "__type": "Colorpicker"
    },
    "AlwaysCanSprint": {
      "value": false,
      "__type": "Toggle"
    },
    "AutoCloneDetectionRange": {
      "value": 20,
      "__type": "Slider"
    },
    "AntiBaitStrictness": {
      "value": "Part of body in Zone",
      "__type": "Dropdown"
    },
    "PartsTransparency": {
      "value": 0.5,
      "__type": "Slider"
    },
    "AlwaysSprint": {
      "value": false,
      "__type": "Toggle"
    },
    "ColorBloxyCola": {
      "value": "0096ff",
      "__type": "Colorpicker"
    },
    "AutoBlockStandZoneWidth": {
      "value": 5,
      "__type": "Slider"
    },
    "VoidRushFullControl": {
      "value": false,
      "__type": "Toggle"
    },
    "WaitSomeCheckInterval": {
      "value": 0.05,
      "__type": "Slider"
    },
    "AntiSpinBaitCheckDuration": {
      "value": "0.65",
      "__type": "Slider"
    },
    "ESPGingerbread": {
      "value": false,
      "__type": "Toggle"
    },
    "WaitDuration_Noli": {
      "value": 0.3,
      "__type": "Slider"
    },
    "AnimationWindupThreshold": {
      "value": 0.75,
      "__type": "Slider"
    },
    "TechAimingMode": {
      "__type": "Dropdown"
    },
    "BillboardTextSize": {
      "value": "6",
      "__type": "Slider"
    },
    "PartsHeight": {
      "value": 10,
      "__type": "Slider"
    },
    "KillerUpdateRate": {
      "value": "5.00",
      "__type": "Slider"
    },
    "ColorGenerator": {
      "value": "ffffff",
      "__type": "Colorpicker"
    },
    "ESPSentry": {
      "value": false,
      "__type": "Toggle"
    },
    "TeammatesHPThreshold": {
      "value": 50,
      "__type": "Slider"
    },
    "ShowUsername": {
      "value": false,
      "__type": "Toggle"
    },
    "PredictionTime": {
      "value": 0.12,
      "__type": "Slider"
    },
    "BackstabMode": {
      "__type": "Dropdown"
    },
    "HitboxDragToggle": {
      "value": true,
      "__type": "Toggle"
    },
    "ShowCharacterName": {
      "value": true,
      "__type": "Toggle"
    },
    "AttackerSelect": {
      "value": "John Doe",
      "__type": "Dropdown"
    },
    "AutoPunchMode": {
      "value": "Normal",
      "__type": "Dropdown"
    },
    "GlideStabAssist": {
      "value": false,
      "__type": "Toggle"
    },
    "ArrowTextSize": {
      "value": 12,
      "__type": "Slider"
    },
    "AimbotSmooth": {
      "value": "0.05",
      "__type": "Slider"
    },
    "SnapCornersSize": {
      "value": 10,
      "__type": "Slider"
    },
    "AutoBlockVerificationDuration": {
      "value": "0.25",
      "__type": "Slider"
    },
    "StaminaLossValue": {
      "value": 10,
      "__type": "Slider"
    },
    "AutoBlockToggle": {
      "value": true,
      "__type": "Toggle"
    },
    "ESPRefreshRate": {
      "value": "4.40",
      "__type": "Slider"
    },
    "InfiniteStamina": {
      "value": true,
      "__type": "Toggle"
    },
    "AimbotMaxDistance": {
      "value": "1000",
      "__type": "Slider"
    },
    "GuestAnimKeyBind": {
      "value": "",
      "__type": "Input"
    },
    "AttackAlertRadius": {
      "value": 20,
      "__type": "Slider"
    },
    "SuperFlingBumber": {
      "value": false,
      "__type": "Toggle"
    },
    "TrickHelper": {
      "value": false,
      "__type": "Toggle"
    },
    "FOVMultiplierValue": {
      "value": 1.125,
      "__type": "Slider"
    },
    "SnapCornersThickness": {
      "value": 2,
      "__type": "Slider"
    },
    "AntiWrongBlockTolerance": {
      "value": 0.15,
      "__type": "Slider"
    },
    "PathVisualizer": {
      "value": false,
      "__type": "Toggle"
    }
  },
  "__custom": []
}
]]

local ConfigManager = Window.ConfigManager
pcall(function()
    local _folder = "WindUI/LinniScript/config"
    if not isfolder(_folder) then
        makefolder(_folder)
    end
    writefile(_folder .. "/" .. PRESET_NAME .. ".json", PRESET_JSON)
end)
local configName = "Default"
local selectedConfig = nil

local manualSection = Tabs.Settings:Section({
    Title = "手动配置",
    Icon = "folder",
    Desc = "Manuel Save Configs",
    Opened = false,
})

manualSection:Input({
    Title = "配置名字",
    Default = "Default",
    Callback = function(text)
        configName = text
    end
})

manualSection:Button({
    Title = "保存配置",
    Callback = function()
        if configName ~= "" then
            Window.CurrentConfig = ConfigManager:Config(configName)
            if Window.CurrentConfig:Save() then
                WindUI:Notify({
                    Title = "保存配置",
                    Content = "配置 '" .. configName .. "' 保存成功",
                    Duration = 3
                })
                if configDropdown then
                    configDropdown:Refresh(ConfigManager:AllConfigs())
                end
                if autoSaveDropdown then
                    autoSaveDropdown:Refresh(ConfigManager:AllConfigs())
                end
                if autoLoadDropdown then
                    autoLoadDropdown:Refresh(ConfigManager:AllConfigs())
                end
            end
        end
    end
})

local configDropdown = manualSection:Dropdown({
    Title = "配置列表",
    Values = ConfigManager:AllConfigs(),
    Multi = false,
    Default = nil,
    Callback = function(value)
        selectedConfig = value
        configName = value
    end
})

manualSection:Button({
    Title = "加载配置",
    Callback = function()
        if selectedConfig then
            Window.CurrentConfig = ConfigManager:Config(selectedConfig)
            if Window.CurrentConfig:Load() then
                WindUI:Notify({
                    Title = "配置加载",
                    Content = "配置 '" .. selectedConfig .. "' 已加载",
                    Duration = 3
                })
            end
        else
            WindUI:Notify({
                Title = "错误请先选择一个配置",
                Duration = 3
            })
        end
    end
})

manualSection:Button({
    Title = "删除配置",
    Callback = function()
        if selectedConfig then
            if ConfigManager:DeleteConfig(selectedConfig) then
                local deletedName = selectedConfig
                selectedConfig = nil
                configDropdown:Refresh(ConfigManager:AllConfigs())
                if autoSaveDropdown then
                    autoSaveDropdown:Refresh(ConfigManager:AllConfigs())
                end
                if autoLoadDropdown then
                    autoLoadDropdown:Refresh(ConfigManager:AllConfigs())
                end
                WindUI:Notify({
                    Title = "配置已删除",
                    Content = "配置 '" .. deletedName .. "' 已删除",
                    Duration = 3
                })
            end
        else
            WindUI:Notify({
                Title = "错误请先选择一个配置",
                Duration = 3
            })
        end
    end
})

manualSection:Button({
    Title = "刷新列表",
    Callback = function()
        configDropdown:Refresh(ConfigManager:AllConfigs())
        if autoSaveDropdown then
            autoSaveDropdown:Refresh(ConfigManager:AllConfigs())
        end
        if autoLoadDropdown then
            autoLoadDropdown:Refresh(ConfigManager:AllConfigs())
        end
        WindUI:Notify({
            Title = "Refreshed",
            Content = "Config list updated!",
            Duration = 2
        })
    end
})

local autoSection = Tabs.Settings:Section({
    Title = "自动保存配置",
    Icon = "settings",
    Opened = false,
})

local autoSaveEnabled = false
local autoSaveConfig = "Default"
autoSection:Toggle({
    Flag = "AutoSaveEnabled",
    Title = "自动保存",
    Default = false,
    Callback = function(value)
        autoSaveEnabled = value
    end
})
local autoSaveDropdown = autoSection:Dropdown({
    Flag = "AutoSaveConfig",
    Title = "自动保存配置",
    Values = ConfigManager:AllConfigs(),
    Multi = false,
    Default = nil,
    Callback = function(value)
        autoSaveConfig = value
    end
})
autoSection:Divider()
local autoLoadEnabled = false
local autoLoadConfig = "Default"
autoSection:Toggle({
    Flag = "AutoLoadEnabled",
    Title = "自动加载",
    Default = false,
    Callback = function(value)
        autoLoadEnabled = value
        if value and autoLoadConfig then
            local config = ConfigManager:Config(autoLoadConfig)
            if config then
                config:SetAutoLoad(true)
            end
        end
    end
})
local autoLoadDropdown = autoSection:Dropdown({
    Flag = "AutoLoadConfig",
    Title = "选择要自动加载配置",
    Values = ConfigManager:AllConfigs(),
    Multi = false,
    Default = nil,
    Callback = function(value)
        autoLoadConfig = value
    end
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
LocalPlayer.AncestryChanged:Connect(function(_, parent)
    if not parent then
        if autoSaveEnabled and autoSaveConfig and autoSaveConfig ~= "" then
            local config = ConfigManager:Config(autoSaveConfig)
            if config then
                config:Save()
                WindUI:Notify({
                    Title = "自动保存",
                    Content = "关闭时自动保存配置: " .. autoSaveConfig,
                    Duration = 3
                })
            end
        end
    end
end)
LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
        if autoSaveEnabled and autoSaveConfig and autoSaveConfig ~= "" then
            local config = ConfigManager:Config(autoSaveConfig)
            if config then
                config:Save()
                WindUI:Notify({
                    Title = "自动保存",
                    Content = "传送时自动保存配置: " .. autoSaveConfig,
                    Duration = 3
                })
            end
        end
    end
end)
task.spawn(function()
    while task.wait(60) do
        if autoSaveEnabled and autoSaveConfig and autoSaveConfig ~= "" then
            local config = ConfigManager:Config(autoSaveConfig)
            if config then
                config:Save()
                WindUI:Notify({
                    Title = "自动保存",
                    Content = "定期自动保存: " .. autoSaveConfig,
                    Duration = 3
                })
            end
        end
    end
end)

local ServerSection = Tabs.Settings:Section({
    Title = "服务器工具",
    Icon = "server",
    Opened = false,
})

ServerSection:Button({
    Title = "跳转到另一个服务器",
    Callback = function()
        task.spawn(function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local PlaceId = game.PlaceId
            local CurrentJobId = game.JobId
            local function ServerHop()
                WindUI:Notify({
                    Title = "服务器跳转",
                    Content = "寻找另一个服务器...",
                    Duration = 3
                })
                local ServersUrl = "https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
                local success, result = pcall(function()
                    return game:HttpGet(ServersUrl)
                end)
                if not success then
                    WindUI:Notify({
                        Title = "服务器跳转",
                        Content = "HTTP错误，3秒后重试...",
                        Duration = 3
                    })
                    task.wait(3)
                    ServerHop()
                    return
                end
                local Data = Http:JSONDecode(result)
                if Data and Data.data then
                    for _, server in ipairs(Data.data) do
                        if server.playing < server.maxPlayers and server.id ~= CurrentJobId then
                            WindUI:Notify({
                                Title = "服务器跳转",
                                Content = "找到服务器，正在传送...",
                                Duration = 3
                            })
                            TPS:TeleportToPlaceInstance(PlaceId, server.id)
                            return
                        end
                    end
                end
                WindUI:Notify({
                    Title = "服务器跳转",
                    Content = "未找到合适的服务器，将在3秒后重试...",
                    Duration = 3
                })
                task.wait(3)
                ServerHop()
            end
            ServerHop()
        end)
    end
})


task.spawn(function()



do
    local _lp   = game:GetService("Players").LocalPlayer
    local _http = game:GetService("HttpService")

    local _tpSection = Tabs.Premium:Section({
        Title  = "传送玩家",
        Icon   = "cable",
        Opened = true,
    })

    local _tpList = {"(Press Refresh)"}
    local _tpDrop = _tpSection:Dropdown({
        Title     = "选择玩家传送",
        Multi     = false,
        AllowNone = true,
        Values    = _tpList,
        Value     = nil,
        Locked    = (not getgenv().__Linni_PREMIUM),
        LockedTitle = "Buy Premium (500 R$)",
        Callback  = function(v) end
    })

    local function _refreshUsers()
        local suc, resp = pcall(function()
            return WindUI.Creator.Request({
                Url     = getgenv().__Linni_BASE .. "/nsk_online?select=roblox_username,job_id",
                Method  = "GET",
                Headers = {
                    ["apikey"]        = getgenv().__Linni_ANONK,
                    ["Authorization"] = "Bearer " .. getgenv().__Linni_ANONK,
                }
            })
        end)
        if suc and resp and resp.Body then
            local ok, data = pcall(function() return _http:JSONDecode(resp.Body) end)
            if ok and data and #data > 0 then
                local items = {}
                for _, u in ipairs(data) do
                    if u.roblox_username ~= _lp.Name:lower() then
                        table.insert(items, u.roblox_username)
                    end
                end
                if #items > 0 then
                    _tpDrop:Refresh(items)
                    return
                end
            end
        end
        _tpDrop:Refresh({"No users online"})
    end

    _tpSection:Button({
        Title  = "刷新",
        Icon   = "refresh-cw",
        Locked = (not getgenv().__Linni_PREMIUM),
        LockedTitle = "Buy Premium (500 R$)",
        Callback = function() _refreshUsers() end
    })

    _tpSection:Button({
        Title  = "传送到选中玩家身边",
        Icon   = "cable",
        Locked = (not getgenv().__Linni_PREMIUM),
        LockedTitle = "Buy Premium (500 R$)",
        Callback = function()
            local selected = _tpDrop.Value
            if not selected or selected == "(Press Refresh)" or selected == "No users online" then
                WindUI:Notify({ Title = "传送", Content = "请先选择用户", Duration = 3, Icon = "alert-circle" })
                return
            end
            local target = game:GetService("Players"):FindFirstChild(selected)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local lchar = _lp.Character
                if lchar and lchar:FindFirstChild("HumanoidRootPart") then
                    lchar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                    WindUI:Notify({ Title = "传送", Content = "→ " .. selected, Duration = 3, Icon = "cable" })
                end
            else
                WindUI:Notify({ Title = "TP失败", Content = selected .. " 不在此服务器上", Duration = 3, Icon = "alert-circle" })
            end
        end
    })
end

local HitboxSection = Tabs.Premium:Section({
    Title = "范围v2",
    Icon = "shield-plus",
    Opened = false,
})

local lolz = {}
local toggleState = false
local guiVisible = false


do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")
    local UserInputService = game:GetService("UserInputService")

    if getgenv().emergency_stop == nil then
        getgenv().emergency_stop = false
    end
    local function StudsIntoPower(studs)
        return (studs * 6)
    end
    function lolz:ExtendHitbox(studs, time)
        local distance = StudsIntoPower(studs)
        local start = tick()
        getgenv().emergency_stop = false
        task.spawn(function()
            repeat
                RunService.Heartbeat:Wait()
                local player = Players.LocalPlayer
                local char = player.Character
                if not (char and char:FindFirstChild("HumanoidRootPart")) then
                    continue
                end
                local hrp = char.HumanoidRootPart
                local velocity = hrp.Velocity
                hrp.Velocity = velocity * distance + (Vector3.new(0, 1, 0) * distance * 2)
                RunService.RenderStepped:Wait()
                if char and char:FindFirstChild("HumanoidRootPart") then
                    hrp.Velocity = velocity
                end
            until tick() - start > tonumber(time) or getgenv().emergency_stop == true or toggleState == false
            if toggleState == true and (tick() - start > tonumber(time)) then
                getgenv().emergency_stop = true
            end
        end)
    end
    function lolz:StopExtendingHitbox()
        getgenv().emergency_stop = true
    end

    do
        if CoreGui:FindFirstChild("HitboxGui_V2") then
            CoreGui:FindFirstChild("HitboxGui_V2"):Destroy()
        end
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "HitboxGui_V2"
        ScreenGui.Parent = CoreGui
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.Enabled = false
        getgenv().__lin_ni = ScreenGui

        local Frame = Instance.new("Frame")
        Frame.Name = "MainFrame"
        Frame.Parent = ScreenGui
        Frame.Size = UDim2.new(0, 220, 0, 175)
        Frame.Position = UDim2.new(0.5, -110, 0.4, -87)
        Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Frame.BorderSizePixel = 0
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 12)
        UICorner.Parent = Frame
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Parent = Frame
        UIStroke.Thickness = 3
        UIStroke.Transparency = 0
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        task.spawn(function()
            while Frame.Parent do
                local t = tick()
                local hue = t % 5 / 5
                local color = Color3.fromHSV(hue, 1, 1)
                UIStroke.Color = color
                task.wait(0.05)
            end
        end)
        local Title = Instance.new("TextLabel")
        Title.Parent = Frame
        Title.Size = UDim2.new(1, 0, 0, 30)
        Title.BackgroundTransparency = 1
        Title.Text = "上帝模式OP"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 16
        local Container = Instance.new("Frame")
        Container.Parent = Frame
        Container.Size = UDim2.new(1, -20, 1, -40)
        Container.Position = UDim2.new(0, 10, 0, 35)
        Container.BackgroundTransparency = 1
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = Container
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 8)
        local function createInput(placeholder, default)
            local Box = Instance.new("TextBox")
            Box.Parent = Container
            Box.Size = UDim2.new(1, 0, 0, 30)
            Box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Box.PlaceholderText = placeholder
            Box.Text = default or ""
            Box.TextColor3 = Color3.fromRGB(240, 240, 240)
            Box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            Box.Font = Enum.Font.Gotham
            Box.TextSize = 13
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Box
            return Box
        end
        local StudsBox = createInput("大小随便输")
        local TimeBox = createInput("持续时间")
        local ActivateButton = Instance.new("TextButton")
        ActivateButton.Parent = Container
        ActivateButton.Size = UDim2.new(1, 0, 0, 35)
        ActivateButton.BackgroundColor3 = Color3.fromRGB(80, 180, 100)
        ActivateButton.Text = "开启"
        ActivateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ActivateButton.Font = Enum.Font.GothamBold
        ActivateButton.TextSize = 14
        ActivateButton.AutoButtonColor = true
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = ActivateButton
        ActivateButton.MouseButton1Click:Connect(function()
            toggleState = not toggleState
            if toggleState then
                ActivateButton.Text = "关闭"
                ActivateButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
                local studs = tonumber(StudsBox.Text) or 2
                local time = tonumber(TimeBox.Text) or 9e9
                lolz:ExtendHitbox(studs, time)
            else
                ActivateButton.Text = "开启"
                ActivateButton.BackgroundColor3 = Color3.fromRGB(80, 180, 100)
                lolz:StopExtendingHitbox()
            end
        end)
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            local delta = input.Position - dragStart
            Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
        Frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = Frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        Frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end
end
HitboxSection:Toggle({
    Flag = "ShowHitboxUI",
    Title = "打开范围UI",
    Locked = (not getgenv().__Linni_PREMIUM),
    LockedTitle = "This element is locked(Buy Premium)",
    Default = false,
    Callback = function(Value)
        guiVisible = Value
        if getgenv().__lin_ni then getgenv().__lin_ni.Enabled = Value end
        if Value then

        else

        end
    end
})

HitboxSection:Paragraph({
    Title = "范围",
    Desc = "使用这个功能一定要格外小心，如果被别人dc举报，你的账号会被封禁，你可以搭配隐身功能一起用，体验会更好，另外务必注意，这个技能可以把监管者狠狠击飞[同时自带隐身效果，能帮你规避被举报]",
})

end)

Window:SelectTab(1)