-- Secure game scripts mapping with verified URLs
local Games = {
    [3623096087] = [[
-- Legend of Power Script
local ScriptInfo = {
    Author = "LN",
    Description = "Legend of Power Script",
    Team = "LegendofPower",
    Version = "1.0"
}

-- Safe loader function
local function LoadScript()
    local success, response = pcall(function()
        return game:HttpGetAsync("https://raw.githubusercontent.com/ShenJiaoBen/Partial-Server-Ribbon/main/LN力量.lua", true)
    end)
    
    if success and response then
        local loaded, err = pcall(loadstring, response)
        if not loaded then
            warn("Script load error:", err)
        end
    else
        warn("Failed to fetch script:", response)
    end
end

LoadScript()
]],

    [16732694052] = [[
-- Fish Game Script
local ScriptInfo = {
    Author = "LN",
    Description = "Fish Game Script",
    Team = "FreeScripts",
    Version = "1.0"
}

-- Safe loader function
local function LoadScript()
    local success, response = pcall(function()
        return game:HttpGetAsync("https://raw.githubusercontent.com/ShenJiaoBen/Partial-Server-Ribbon/main/FishScriptLn.lua", true)
    end)
    
    if success and response then
        local loaded, err = pcall(loadstring, response)
        if not loaded then
            warn("Script load error:", err)
        end
    else
        warn("Failed to fetch script:", response)
    end
end

LoadScript()
]],

    [7239319209] = [[
-- Ohio Game Script
local ScriptInfo = {
    Author = "King",
    Description = "Ohio Game Script",
    Team = "KingTeam",
    Version = "1.0"
}

-- Safe loader function
local function LoadScript()
    local success, response = pcall(function()
        return game:HttpGetAsync("https://raw.githubusercontent.com/ShenJiaoBen/ShenJiaoBen/main/new_ohio.lua", true)
    end)
    
    if success and response then
        local loaded, err = pcall(loadstring, response)
        if not loaded then
            warn("Script load error:", err)
        end
    else
        warn("Failed to fetch script:", response)
    end
end

LoadScript()
]]
}

return Games
