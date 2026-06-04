-- Synchronization Interface --
cloneref = cloneref or function(f) return f; end;

local SyncManager = {};
local CoreGui = cloneref(game:GetService('CoreGui'));

SyncManager.Players = {};
SyncManager.RenderValue = false;
SyncManager.Thread = nil;
SyncManager.Icon = "rbxassetid://120358385035996";

function SyncManager:Init(NL_Lib)
	SyncManager.Icon = NL_Lib.GlobalLogo;
	SyncManager.NL = NL_Lib;
end;

function SyncManager:SetPlayers(list)
	table.clear(SyncManager.Players);
	SyncManager.Players = list;
end;

function SyncManager:_LoadPlayerList()
	local PlayerList: ScreenGui = CoreGui:FindFirstChild("PlayerList");

	for i,v: Player in next , SyncManager.Players do task.wait();
		local uid = tostring(v.UserId);
		
		local frame: Frame = PlayerList:FindFirstChild('p_'..uid,true) or PlayerList:FindFirstChild("PlayerEntry_"..uid,true);

		if frame then
			local PlayerIcon: ImageLabel = frame:FindFirstChild("PlayerIcon",true);

			if PlayerIcon then
				if not PlayerIcon:GetAttribute('OldImage') then
					PlayerIcon:SetAttribute('OldImage',PlayerIcon.Image);
				end;

				PlayerIcon.Image = SyncManager.Icon;
			end;
		end;
	end;
end;

SyncManager.Clear = (function()
    local PlayerList: ScreenGui = CoreGui:FindFirstChild("PlayerList");

    for i,v in next , PlayerList:GetDescendants() do
        if v:GetAttribute('OldImage') then
            v.Image = v:GetAttribute('OldImage')
        end;
    end;
end);

function SyncManager:Render(value)
	if not value then
		if SyncManager.Thread then
			task.cancel(SyncManager.Thread);
			SyncManager.Thread = nil;

            SyncManager.Clear();
		end;
	else
		if not SyncManager.Thread then
			SyncManager.Thread = task.spawn(function()
				while true do task.wait(0.1)

					SyncManager:_LoadPlayerList();

					if not SyncManager.RenderValue then
						break;
					end;
				end;
			end);
		end;
	end;

	SyncManager.RenderValue = value;
end;

return SyncManager;
