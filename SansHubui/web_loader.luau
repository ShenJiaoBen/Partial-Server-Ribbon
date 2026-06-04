local NeverLose = {};

NeverLose.BaseURL = "https://raw.githubusercontent.com/ShenJiaoBen/Partial-Server-Ribbon/refs/heads/main/SansHubui/";
NeverLose.Files = {
    Source = "source.luau",
    Module = "module.luau",
    Logo = "logo.png"
};

function NeverLose:Load()
    local source = game:HttpGet(self.BaseURL .. self.Files.Source);
    local module = game:HttpGet(self.BaseURL .. self.Files.Module);
    
    local UILib = loadstring(source)();
    local Mod = loadstring(module)();
    
    return UILib, Mod;
end;

return NeverLose;
