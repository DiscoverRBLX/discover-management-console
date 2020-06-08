-- This script is to check to make sure if DMC core script loaded correctly.
ReplicatedStoragee = game:FindFirstChildOfClass("ReplicatedStorage")

local AdminService = Instance.new("Configuration",ReplicatedStoragee)
AdminService.Name = "DiscoverManagementConsole"
--
		local DisplayMessageSignal = Instance.new("RemoteEvent",AdminService)
		DisplayMessageSignal.Name = "DisplayMessageSignal"
--
		local DisplayScrollFrameSignal = Instance.new("RemoteEvent",AdminService)
		DisplayScrollFrameSignal.Name = "DisplayScrollFrameSignal"
--
		local DismissMessageSignal = Instance.new("RemoteEvent",AdminService)
		DismissMessageSignal.Name = "DismissMessageSignal"
--
		local DisplayInputSignal = Instance.new("RemoteEvent",AdminService)
		DisplayInputSignal.Name = "DisplayInputSignal"
--
		local TellSignal = Instance.new("RemoteEvent",AdminService)
		TellSignal.Name = "TellSignal"
--
		local CTSU = Instance.new("RemoteEvent",AdminService)
		CTSU.Name = "ClientToServerCommu"
--
		local STCU = Instance.new("RemoteEvent",AdminService)
		STCU.Name = "ServerToClientCommu"
--

Event = game:GetService("RunService").Stepped:connect(function()
	wait()

local toremove = ReplicatedStoragee:FindFirstChild("DiscoverManagementConsole")

toremove.Changed:connect(function()
	toremove:remove()
end)

if not ReplicatedStoragee:FindFirstChild("DiscoverManagementConsole") then
	local AdminService = Instance.new("Configuration",ReplicatedStoragee)
AdminService.Name = "DiscoverManagementConsole"
elseif not ReplicatedStoragee.DiscoverManagementConsole:FindFirstChild("DisplayMessageSignal") then
		local new = Instance.new("RemoteEvent",ReplicatedStoragee:FindFirstChild("DiscoverManagementConsole"))
		new.Name = "DisplayMessageSignal"
elseif not ReplicatedStoragee.DiscoverManagementConsole:FindFirstChild("DisplayScrollFrameSignal") then
		local new = Instance.new("RemoteEvent",ReplicatedStoragee:FindFirstChild("DiscoverManagementConsole"))
		new.Name = "DisplayScrollFrameSignal"
elseif not ReplicatedStoragee.DiscoverManagementConsole:FindFirstChild("DisplayInputSignal") then
	local new = Instance.new("RemoteEvent",ReplicatedStoragee:FindFirstChild("DiscoverManagementConsole"))
	new.Name = "DisplayInputSignal"
elseif  not ReplicatedStoragee.DiscoverManagementConsole:FindFirstChild("DismissMessageSignal") then
	local new = Instance.new("RemoteEvent",ReplicatedStoragee:FindFirstChild("DiscoverManagementConsole"))
	new.Name = "DismissMessageSignal"
elseif not ReplicatedStoragee.DiscoverManagementConsole:FindFirstChild("TellSignal") then
		local new = Instance.new("RemoteEvent",ReplicatedStoragee:FindFirstChild("DiscoverManagementConsole"))
		new.Name = "TellSignal"
elseif not ReplicatedStoragee.DiscoverManagementConsole:FindFirstChild("ClientToServerCommu") then
		local new = Instance.new("RemoteEvent",ReplicatedStoragee:FindFirstChild("DiscoverManagementConsole"))
		new.Name = "ClientToServerCommu"
return
	end
end)

for i,v in pairs(ReplicatedStoragee:FindFirstChild("DiscoverManagementConsole"):GetChildren()) do
	v.Changed:connect(function()
		ReplicatedStoragee:FindFirstChild("DiscoverManagementConsole"):remove()
	end)
end