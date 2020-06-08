local DMCUI = script.Parent.Parent.DMC_Client
local ReplicatedStorage = game:FindFirstChildOfClass("ReplicatedStorage")
game.Players.PlayerAdded:connect(function(plr)
script.Parent.Parent:FindFirstChild("DMC_Client"):Clone().Parent = plr.PlayerGui
end)