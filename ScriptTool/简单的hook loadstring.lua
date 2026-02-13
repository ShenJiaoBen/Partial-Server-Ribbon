
local oldLoadstring = loadstring or load
--会保存到Roblox文件夹[一般在忍者里面]
local folder = "文件夹"
if isfolder and not isfolder(folder) then
    makefolder(folder)
end

loadstring = function(str, chunkname)
    local success, err = pcall(function()
        if writefile then
            local filename = string.format("%s/loadstring_%s.lua", folder, tick())
            writefile(filename, str)
        end
    end)
    
    return oldLoadstring(str, chunkname)
end
--放脚本