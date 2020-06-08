--Because ROBLOX update broke the feature in which creates a localscript I HAVE TO DO IT MANUALLY!
Character = game.Players.LocalPlayer.Character
checkonce = true

if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("DConsole_FLY_SCRIPT") and not game.Players.LocalPlayer.PlayerGui:FindFirstChild("DConsole_NOCLIP_SCRIPT") then
	checkonce = false
	wait(1)
	script.Parent.UnflyClip:Destroy()
	wait(5)
end


if checkonce == true and not game.Players.LocalPlayer.PlayerGui:FindFirstChild("DConsole_NOCLIP_SCRIPT") then
	game.Players.LocalPlayer.PlayerGui.DConsole_FLY_SCRIPT:destroy()
		if Character and Character:FindFirstChild("HumanoidRootPart") then
			if Character.HumanoidRootPart:FindFirstChild("FlySmoke") then
				Character.HumanoidRootPart:FindFirstChild("FlySmoke"):Destroy()
				end
			end
			if Character.HumanoidRootPart:FindFirstChild("BodyGyro") then
				Character.HumanoidRootPart:FindFirstChild("BodyGyro"):Destroy()
				end
			if Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
				Character.HumanoidRootPart:FindFirstChild("BodyVelocity"):Destroy()
			end
		if Character:FindFirstChild("Humanoid") then
			Character:FindFirstChild("Humanoid").PlatformStand = false
		end
		end
		
if checkonce == true and game.Players.LocalPlayer.PlayerGui:FindFirstChild("DConsole_NOCLIP_SCRIPT") then
	game.Players.LocalPlayer.PlayerGui.DConsole_NOCLIP_SCRIPT:destroy()
			Character:FindFirstChild("HumanoidRootPart")
			Character:FindFirstChild("HumanoidRootPart").Anchored = false
			if Character:FindFirstChild("Humanoid") then
					Character:FindFirstChild("Humanoid").PlatformStand = false
			end
			end
wait(1)
script:Destroy()