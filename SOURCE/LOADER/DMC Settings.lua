--[[ DISCOVER! MANAGEMENT CONSOLE
-- Loader Rev: 16

Hey everyone!

Thanks for inserting Discover! Management Console, I hope you have a
great time with this admin!

Before I go any further, I would like to give a special thanks for the people who
tested DMC during development, I couldn't have done it without you guys. To
see the people who helped with DMC, say credits, followed by a prefix you
choose!

I have started working on this admin script since April of 2017, I had no
clue what to call my ongoing project, probably give it a project codename
but I was too lazy to come up with any. I haven't told anyone that I was
developing a admin script in which will be free for everyone until July
where I made my first test place that showcased this admin in action.

During development, I always want to look back at some old admin script 
in which got discontinued, or doesn't work anymore due to a possible
ROBLOX update. I always thought of bringing some old Commands
in good use, I have also experimented with different admin scripts,
either open or closed source, and always being curious on how it
works.

This admin is not "yet" advanced such as Adonis, EISS, or 
MakerModelLua's Admin just to name a few. It's just a fun
little project that I created, but due to a lot of feedback, A lot
of you want this admin. I never thought that many of you wanted
this admin for your game.

Of course, I will still continue developing this project, by adding
fun commands, and probably some anti-exploit options to go
along with it. I would like to say thanks for using my Admin script
and for taking your time reading this message.

-This admin is inspired by many variety of admin scripts out there.

~TechnologicalByte



To add someone on the list, you must add two "" inside the {}, for example 
SuperAdmins = {"TechnologicalByte"}
]]

SuperAdmins =  {"TechnologicalByte","Player1","PlayerName2"} --Access to all commands.
-- Can you leave my name in there please?? You don't have to :)

Admins = {} --Limit access on some commands.

BannedPlayers ={}



SuperAdminUserIds = {} --Access to ALL commands, these persist even if the player changes his/her name

AdminUserIds = {} --Access to most commands, besides ban, kick, unban, punish, unpunish, shutdown, and scripting commands

BannedUserIds = {} --Banned userids, these will persist even if the player changes his/her username



																																																																																																													--[[
====================================================================
======================= ADVANCED SETTINGS ==========================
====================================================================																																																																																												]]



AdminGamePass = 0 --A game pass for players to get Admin

SuperAdminGamePass = 0


GroupId = 0

GroupIdAdminRank = 0

GroupIdSuperAdminRank = 0

--You may select another standard form of syntax
--Make sure only one is enabled, or else it will revert to default

Syntax_Default = true --The default command syntax outside Roblox. / begins a command, arguments are separated using spaces (ex. /walkspeed me 20)
Syntax_Kohls = false 
Syntax_Person299s = false --The same syntax as Person299's admin. Commands have no beginning, and they use / to separate arguments (ex. walkspeed/me/20)

--Or configure your own command syntax!

Override_Syntax = false  --Set this to true if you want to chance CommandPrefix or Command Separator

CommandPrefix = "/" --The beginning of a command, "/" by default, may be more than 1 character

CommandSeparator = " " --The character separating commands

ReportUnknownCommand = true --If Override_Syntax is on, this will allow you to make it where it does not warn you if a command doesn't exist. Useful for those using nothing as the command prefix.

-- You're all set! Now, publish the game, and let DMC do the work.








-- DON'T MODIFY ANYTHING BELOW!!
game:FindFirstChildOfClass("ServerScriptService"):WaitForChild("MainModule")
script.Parent = game:FindFirstChildOfClass("ServerScriptService"):FindFirstChild("MainModule")

local compilefenv = {}
			for a,i in pairs(getfenv()) do
				if ((type(i) == "table" and a == "Admins" or a == "SuperAdmins" or a == "BannedPlayers" or a == "AdminUserIds" or a == "SuperAdminUserIds" or a == "BannedPlayerUserIds") or type(i) ~= "table") and type(i) ~= "function" and type(i) ~= "userdata" and a ~= "Commands" and a ~= "sha1" and a ~= "CodeSignCache" and a ~= "AllPlayers" and a ~= "logs" and a ~= "Scripts" and a ~= "PlaceNames" then
				--	print(a.." = "..tostring(i))
					compilefenv[tostring(a)] = i
				end
			end
			
local passJSON = game:GetService("HttpService"):JSONEncode(compilefenv)
			
	_G.AdmiApprovedEnvironment = passJSON
		
	local passValue = Instance.new("StringValue",script.Parent)
	passValue.Name = "CONSOLE_PREFERENCES"
	passValue.Value = passJSON
script:remove()