--开源上传，提供作弊者学习服务
--@霖溺
--霖溺工作室制作
--二改请标记原作者

if "霖溺-吃吃世界" == LnScript then

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/KingScriptAE/No-sirve-nada./refs/heads/main/main.lua"))()

function gradient(text, startColor, endColor)
    local result = ""
    local chars = {}
    
    for uchar in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        table.insert(chars, uchar)
    end
    
    local length = #chars
    
    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = startColor.R + (endColor.R - startColor.R) * t
        local g = startColor.G + (endColor.G - startColor.G) * t
        local b = startColor.B + (endColor.B - startColor.B) * t
        
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', 
            math.floor(r * 255), 
            math.floor(g * 255), 
            math.floor(b * 255), 
            chars[i])
    end
    
    return result
end

local Confirmed = false  

WindUI:Popup({
    Title = gradient("吃掉世界脚本", Color3.fromHex("#eb1010"), Color3.fromHex("#1023eb")),
    Icon = "info",
    Content = gradient("部分功能可能会失效", Color3.fromHex("#10eb3c"), Color3.fromHex("#67c97a")) .. gradient(" \n前1年做的", Color3.fromHex("#001e80"), Color3.fromHex("#16f2d9")),  
    Buttons = {  
        {
            Title = gradient("关闭脚本", Color3.fromHex("#e80909"), Color3.fromHex("#630404")),
            Callback = function() end,
            Variant = "Tertiary",
        },
        {
            Title = gradient("加载脚本", Color3.fromHex("#90f09e"), Color3.fromHex("#13ed34")),
            Callback = function() Confirmed = true end,
            Variant = "Secondary",
        }
    }
})

repeat task.wait() until Confirmed

WindUI:Notify({
    Title = gradient("吃掉世界脚本", Color3.fromHex("#eb1010"), Color3.fromHex("#1023eb")),
    Content = "脚本加载成功",
    Icon = "check-circle",
    Duration = 3,
})

local Window = WindUI:CreateWindow({
    Title = gradient("吃掉世界", Color3.fromHex("#001e80"), Color3.fromHex("#16f2d9")), 
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = gradient("@霖溺", Color3.fromHex("#1bf2b2"), Color3.fromHex("#1bcbf2")),
    Folder = "XKcore",
    Size = UDim2.fromOffset(300, 270),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    Background = "rbxassetid://99599917888886",

})

Window:SetBackgroundImage("rbxassetid://99599917888886")
Window:SetBackgroundImageTransparency(0.9)

Window:EditOpenButton({
    Title = "打开霖溺脚本",
    Icon = "monitor",
    CornerRadius = UDim.new(2, 6),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("1E213D"),
        Color3.fromHex("1F75FE")
    ),
    Draggable = true,
})

local Tabs = {
    InfoTab = Window:Tab({ Title = gradient("关于脚本", Color3.fromHex("#ffffff"), Color3.fromHex("#636363")), Icon = "info" }),
    MainTab = Window:Tab({ Title = gradient("主要功能", Color3.fromHex("#ffffff"), Color3.fromHex("#636363")), Icon = "terminal" }),
}

Tabs.InfoTab:Section({Title = "信息"})

Tabs.InfoTab:Paragraph({
    Title = "注入器: " .. identifyexecutor(),
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 42,
})

Tabs.InfoTab:Paragraph({
    Title = "地图ID: " .. game.PlaceId,
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 42,
})

Tabs.InfoTab:Paragraph({
    Title = "用户名: " .. game.Players.LocalPlayer.Character.Name,
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 42,
})


Tabs.MainTab:Section({Title = "自动功能"})

local EATLN = false
local SellLN = false
local ThrowLN = false
local BuyLN = false

Tabs.MainTab:Toggle({
    Title = "自动吃",
    Callback = function(state)
        EATLN = state
        if EATLN then
            while EATLN do
                game:GetService("Players").LocalPlayer.Character.Events.Eat:FireServer()
                wait()
            end
        end
    end
})

Tabs.MainTab:Toggle({
    Title = "自动抓",
    Callback = function(state)
        SellLN = state
        if SellLN then
            while SellLN do
                local args = {
                    [1] = false,
                    [2] = false
                }
                game:GetService("Players").LocalPlayer.Character.Events.Grab:FireServer(unpack(args))
                wait()
            end
        end
    end
})

Tabs.MainTab:Toggle({
    Title = "自动丢",
    Callback = function(state)
        ThrowLN = state
        if ThrowLN then
            while ThrowLN do
                game:GetService("Players").LocalPlayer.Character.Events.ThrowLN:FireServer()
                wait()
            end
        end
    end
})

Tabs.MainTab:Section({Title = "自动购买"})

Tabs.MainTab:Toggle({
    Title = "自动购买吃掉速度",
    Callback = function(state)
        BuyLN = state
        if BuyLN then
            while BuyLN do
                game:GetService("ReplicatedStorage").Events.PurchaseEvent:FireServer("EatSpeed")
                wait()
            end
        end
    end
})

Tabs.MainTab:Toggle({
    Title = "自动购买乘数",
    Callback = function(state)
        BuyLN = state
        if BuyLN then
            while BuyLN do
                game:GetService("ReplicatedStorage").Events.PurchaseEvent:FireServer("Multiplier")
                wait()
            end
        end
    end
})

Tabs.MainTab:Toggle({
    Title = "自动购买行走速度",
    Callback = function(state)
        BuyLN = state
        if BuyLN then
            while BuyLN do
                game:GetService("ReplicatedStorage").Events.PurchaseEvent:FireServer("Speed")
                wait()
            end
        end
    end
})

Tabs.MainTab:Toggle({
    Title = "自动购买最大尺寸",
    Callback = function(state)
        BuyLN = state
        if BuyLN then
            while BuyLN do
                game:GetService("ReplicatedStorage").Events.PurchaseEvent:FireServer("MaxSize")
                wait()
            end
        end
    end
})

wait(1)
else
setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")
game.Players.LocalPlayer:Kick("你没进群/没复制全吧❌")
end