--Because ROBLOX update broke the feature in which creates a localscript I HAVE TO DO IT MANUALLY!

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local HumanoidRootPart = Player.Character:WaitForChild("HumanoidRootPart")
local Humanoid = Player.Character:WaitForChild("Humanoid")
local Flying = true
local Control = {f = 0, b = 0, l = 0, r = 0} 
local LastControl = {f = 0, b = 0, l = 0, r = 0} 
local MaxSpeed = 50 
local Speed = 0
local Camera = workspace.CurrentCamera

if Player:FindFirstChildOfClass("PlayerGui"):FindFirstChild("DConsole_FLY_SCRIPT") then
    wait(1)
    Player:FindFirstChildOfClass("PlayerGui"):FindFirstChild("DConsole_FLY_SCRIPT"):remove()
    if Player.Character.HumanoidRootPart:FindFirstChild("BodyGyro") then
    Player.Character.HumanoidRootPart:FindFirstChild("BodyGyro"):Destroy()
    end
if Player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
    Player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity"):Destroy()
end
end

if Player.Character:FindFirstChild("Humanoid").Health == 0 then
    wait(1)
    script:Destroy()
    return
end

--[[
local FlySmoke = Instance.new("Smoke",HumanoidRootPart)
FlySmoke.Name = "FlySmoke"
FlySmoke.Opacity = 0.08
FlySmoke.Size = 25]]

Instance.new("StringValue",script).Name = "DO_NOT_REENABLE"			

script.Parent = Player:FindFirstChild("PlayerGui")
script.Name = "DConsole_FLY_SCRIPT"

function Fly() 
    local Gyro = Instance.new("BodyGyro", HumanoidRootPart) 
    Gyro.P = 9e4 
    Gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
    Gyro.cframe = HumanoidRootPart.CFrame --why is cframe in lowercase for BodyGyros
    
    local Velocity = Instance.new("BodyVelocity", HumanoidRootPart) 
    Velocity.velocity = Vector3.new(0,0.1,0) --roblox why is velocity lowercase
    Velocity.maxForce = Vector3.new(9e9, 9e9, 9e9) 
    
    repeat
        wait() 
        
        Humanoid.PlatformStand = true 
        
        if Control.l + Control.r + Control.f + Control.b > 0 then
            --FlySmoke.Enabled = true
        else
            --FlySmoke.Enabled = false
        end
        
        if Control.l + Control.r ~= 0 or Control.f + Control.b ~= 0 then 
        
            Speed = Speed+.5+(Speed/MaxSpeed) 
            
            if Speed > MaxSpeed then 
                Speed = MaxSpeed 
            end 
        elseif not (Control.l + Control.r ~= 0 or Control.f + Control.b ~= 0) and Speed ~= 0 then 
            Speed = Speed-1 
            if Speed < 0 then 
                Speed = 0 
            end 
        end 
            
        if (Control.l + Control.r) ~= 0 or (Control.f + Control.b) ~= 0 then 
        
            Velocity.velocity = 
                ((Camera.CoordinateFrame.lookVector * (Control.f + Control.b)) +
                ((Camera.CoordinateFrame * CFrame.new(Control.l + Control.r,(Control.f + Control.b) * 0.2, 0).p) - --yuck
                Camera.CoordinateFrame.p))*Speed
                
            LastControl = {f = Control.f, b = Control.b, l = Control.l, r = Control.r}
            
        elseif (Control.l + Control.r) == 0 and (Control.f + Control.b) == 0 and Speed ~= 0 then 
        
            Velocity.velocity = 
                ((Camera.CoordinateFrame.lookVector * (LastControl.f + LastControl.b)) +
                ((Camera.CoordinateFrame * CFrame.new(LastControl.l + LastControl.r, (LastControl.f + LastControl.b) * 0.2, 0).p) - --also yuck
                Camera.CoordinateFrame.p))*Speed 
                
        else 
            Velocity.velocity = Vector3.new(0,0.1,0) 
        end
        
        Gyro.cframe = Camera.CoordinateFrame * CFrame.Angles(-math.rad((Control.f+Control.b)*50*Speed/MaxSpeed),0,0) 
        
    until not Flying or not script.Parent
    
    Control = {f = 0, b = 0, l = 0, r = 0} 
    LastControl = {f = 0, b = 0, l = 0, r = 0} 
    Speed = 0
    Gyro:Destroy()
    Velocity:Destroy()
    Humanoid.PlatformStand = false 
    
end

Mouse.KeyDown:connect(function(key) 
    if key:lower() == "e" then 
        Flying = not Flying
        if Flying then
            Fly()
        end
    elseif key:lower() == "w" then 
        Control.f = 1 
    elseif key:lower() == "s" then 
        Control.b = -1 
    elseif key:lower() == "a" then 
        Control.l = -1 
    elseif key:lower() == "d" then 
        Control.r = 1 
    end 
end) 

Mouse.KeyUp:connect(function(key) 
    if key:lower() == "w" then 
        Control.f = 0 
    elseif key:lower() == "s" then 
        Control.b = 0 
    elseif key:lower() == "a" then 
        Control.l = 0 
    elseif key:lower() == "d" then 
        Control.r = 0 
    end 
end)

Fly()

--unfly

