--Because ROBLOX update broke the feature in which creates a localscript I HAVE TO DO IT MANUALLY!
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Character = Player.Character
local Humanoid = Character:FindFirstChild("Humanoid")
local Torso = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera
local Move = {W = 0, S = 0, A = 0, D = 0}
local Speed = 2

Instance.new("StringValue",script).Name = "DO_NOT_REENABLE"			

if Player:FindFirstChildOfClass("PlayerGui"):FindFirstChild("DConsole_NOCLIP_SCRIPT") then
    Player:FindFirstChildOfClass("PlayerGui"):FindFirstChild("DConsole_NOCLIP_SCRIPT"):remove()
                Character:FindFirstChild("HumanoidRootPart")
Character:FindFirstChild("HumanoidRootPart").Anchored = false
if Character:FindFirstChild("Humanoid") then
        Character:FindFirstChild("Humanoid").PlatformStand = false
end
end
            
script.Parent = Player:FindFirstChild("PlayerGui")
script.Name = "DConsole_NOCLIP_SCRIPT"

Mouse.KeyDown:connect(function(key)
    if key:lower() == "w" then
        Move.W = 1
    elseif key:lower() == "s" then
        Move.S = 1
    elseif key:lower() == "a" then
        Move.A = 1
    elseif key:lower() == "d" then
        Move.D = 1
--[[	elseif key:lower() == "q" then
        Speed = Speed + 1
    elseif key:lower() == "e" then
        Speed = Speed - 1]]
    end
end)

Mouse.KeyUp:connect(function(key)
    if key:lower() == "w" then
        Move.W = 0
    elseif key:lower() == "s" then
        Move.S = 0
    elseif key:lower() == "a" then
        Move.A = 0
    elseif key:lower() == "d" then
        Move.D = 0
    end
end)

Torso.Anchored = true
Humanoid.PlatformStand = true

local eventt = Humanoid.Changed:connect(function()
    Humanoid.PlatformStand = true
end)

local event = game:GetService("RunService").RenderStepped:connect(function()
    Torso.CFrame = CFrame.new(
        Torso.Position,
        Camera.CoordinateFrame.p) *
        CFrame.Angles(0, math.rad(180), 0) *
        CFrame.new((Move.D - Move.A) *
        Speed,
        0,
        (Move.S - Move.W) *
        Speed
    )
end)

repeat wait(0.25) until not script.Parent

event:disconnect()
eventt:disconnect()