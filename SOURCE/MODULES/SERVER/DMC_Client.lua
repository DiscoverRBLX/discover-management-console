 --[[
DISCOVER! MANAGEMENT CONTROLLER UI HANDLER SCRIPT.
Everything below is all the code in which makes DMC's interfaces.
--]]
repeat wait()
script.Parent = nil
until script.Parent == nil

Players = game:FindFirstChildOfClass("Players")
ReplicatedStorage = game:FindFirstChildOfClass("ReplicatedStorage")
ReplicatedStorage:FindFirstChild("DiscoverManagementConsole")
Players.LocalPlayer:WaitForChild("PlayerGui")

--UI SETTINGS
tweentime =  0.5 
tweenstyle = "Back" 
TweenService = game:GetService("TweenService")

-- SYSTEM SETTINGS
EmergencyMode = false --Used during emergencies such as DMC service outage.
AnimationGo = true --Tell the script that it's alright to animate text.
AnimateNoScroll = true --Again, don't touch this.
letellTrans = false --Deals with the hint.
HintShowing = false --Don't re-animate the hint UI if it's already been animated.
MsgShowing = false --Don't re-animate the message UI if it's already been animated.
TimeShowing = false
AlertFlash = false
HttpStatus = false

if game.HttpService == true then
	HttpStatus = true
end

--Thanks for stopping by have a nice day. Now the actual code!
PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
player = game:GetService("Players").LocalPlayer
TellGuiBounceOffset = 5

local Images = {
	SysClose = "rbxassetid://1480666400";
	SysCloseHover = "rbxassetid://1480666583";
	SysCloseClick = "rbxassetid://1480666916";
	Arrow = "rbxassetid://150085532";
	ArrowHover = "rbxassetid://150087188";
	ArrowClick = "rbxassetid://150085536";
}

ReplicatedStorage:WaitForChild("DiscoverManagementConsole")
DisplayMessage = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("DisplayMessageSignal")
DismissMessage = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("DismissMessageSignal")
DisplayScrollFrame = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("DisplayScrollFrameSignal")
DisplayInput = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("DisplayInputSignal")
SendClientServer = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("ClientToServerCommu")
Tell = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("TellSignal")
STCU = ReplicatedStorage:WaitForChild("DiscoverManagementConsole"):WaitForChild("ServerToClientCommu")
--Makes the message Ui

--script.Parent = game:FindFirstChildOfClass("ReplicatedFirst")

function MakeMsgGui()
	
	if not Gui then
		MakeAdmiGui()
	end
	
	local MsgGui = Instance.new("TextButton", Gui)
	MsgGui.Name = "Msg"
	MsgGui.Text = ""
	MsgGui.Draggable = true
	MsgGui.Modal = true
	MsgGui.AutoButtonColor = false
	MsgGui.Position = UDim2.new(0.5, -250, 0.5, -125)
	MsgGui.Size = UDim2.new(0, 500, 0, 300)
	MsgGui.BackgroundColor3 =Color3.fromRGB(54, 54, 54)
	MsgGui.BackgroundTransparency = 0.5
	MsgGui.BorderSizePixel = 0
	MsgGui.ZIndex = 10
	MsgGui.ClipsDescendants = true
	
	local Msg = Instance.new("TextLabel", MsgGui)
	Msg.Name = "Msg"
	Msg.Position = UDim2.new(0, 0,0.237, 0)
	Msg.Size = UDim2.new(1, 0,0.743, 0)
	Msg.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
	Msg.BackgroundTransparency = 1
	Msg.BorderSizePixel = 0
	Msg.Text = "Message"
	Msg.Font = "Arial"
	Msg.FontSize = "Size18"
	Msg.TextStrokeTransparency = 0.7
	Msg.TextWrapped = true
	Msg.TextScaled = false
	Msg.TextSize = 18
	Msg.TextYAlignment = "Top"
	Msg.TextColor3 = Color3.new(1, 1, 1)
	Msg.ZIndex = 10
	
	local MsgUIOver = Instance.new("Frame", MsgGui)
	MsgUIOver.Name = "OveFrame"
	MsgUIOver.Position = UDim2.new(0, 0,0, 0)
	MsgUIOver.Size = UDim2.new(1, 0,0.18, 0)
	MsgUIOver.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
	MsgUIOver.BackgroundTransparency = 0.150
	MsgUIOver.BorderSizePixel = 0
	
	local MsgUIUnder = Instance.new("Frame", MsgGui)
	MsgUIUnder.Name= "UndeFrame"
	MsgUIUnder.Position = UDim2.new(0, 0,0.213, 0)
	MsgUIUnder.Size = UDim2.new(1, 0,0.787, 0)
	MsgUIUnder.BackgroundColor3 = Color3.fromRGB(89, 134, 104)
	MsgUIUnder.BackgroundTransparency = 0.400
	MsgUIUnder.BorderSizePixel = 0
	
	local Title = Instance.new("TextLabel", MsgGui)
	Title.Name = "Title"
	Title.Position = UDim2.new(0, 0,0.05, 0)
	Title.Size = UDim2.new(1, 0,0.127, 0)
	Title.BackgroundTransparency = 1
	Title.BorderSizePixel = 0
	Title.TextYAlignment = "Top"
	Title.Text = "Message"
	Title.Font = "ArialBold"
	Title.FontSize = "Size24"
	Title.TextStrokeTransparency = 0.7
	Title.TextWrapped = true
	Title.TextScaled = false
	Title.TextSize = 30
	Title.TextYAlignment = "Top"
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.ZIndex = 10
	
	local TimeRemain = Instance.new("Frame", MsgGui)
	TimeRemain.Name = "TimeRemaining"
	TimeRemain.Visible = false --WIP
	TimeRemain.BackgroundColor3 = Color3.fromRGB(75, 136, 71)
	TimeRemain.Position = UDim2.new(0, 0, 0, 0)
	TimeRemain.Size = UDim2.new(1, 0,0.04, 0)
	TimeRemain.BorderSizePixel = 0
	TimeRemain.ZIndex = 10
-- UIBlur

local Transparency = MsgGui.BackgroundTransparency
local GUIName = MsgGui

local Cam = workspace.CurrentCamera
local GUI = GUIName
local Event = nil


local SG = nil
function IsSG(Obj)
	if Obj:IsA("ScreenGui") then
		SG = Obj
	elseif Obj then
		IsSG(Obj.Parent)
	end
end
IsSG(GUI)
	return Msg
end


function MakeAdmiGui()
	if EmergencyMode == false and not PlayerGui:FindFirstChild("DConsole") then
	Gui = Instance.new("ScreenGui",PlayerGui)
	Gui.Name = "DConsole"
	Gui.ResetOnSpawn = false
	Gui.Parent = PlayerGui
	return Gui
	elseif EmergencyMode == true then
	Gui = Instance.new("ScreenGui",PlayerGui)
	Gui.Name = "DConsole_EMERGENCY"
	Gui.ResetOnSpawn = false
	Gui.Parent = PlayerGui
	return Gui
			end
end


function MakeInputGui()
	
	if not Gui then
		MakeAdmiGui()
	end
	
	local MiniUI = Instance.new("TextButton",Gui)
	MiniUI.Name = "InputUI"
	MiniUI.Modal = true
	MiniUI.AutoButtonColor = false
	MiniUI.Text = ""
	MiniUI.Position = UDim2.new(0, 0,0.787, 0)
	MiniUI.Size = UDim2.new(0, 331,0, 202)
	MiniUI.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
	MiniUI.BackgroundTransparency = 0.5
	MiniUI.BorderSizePixel = 0
	MiniUI.ZIndex = 10
	
	local InputUIop = Instance.new("Frame", MiniUI)
	InputUIop.Name = "OveFrame"
	InputUIop.Position = UDim2.new(0, 0,0, 0)
	InputUIop.Size = UDim2.new(1, 0,0.202, 0)
	InputUIop.BackgroundColor3 = Color3.fromRGB(54, 95, 209)
	InputUIop.BackgroundTransparency = 0.150
	InputUIop.BorderSizePixel = 0
	
	local InputUIBottom = Instance.new("Frame", MiniUI)
	InputUIBottom.Name= "UndeFrame"
	InputUIBottom.Position = UDim2.new(0, 0,0.258, 0)
	InputUIBottom.Size = UDim2.new(1, 0,0.742, 0)
	InputUIBottom.BackgroundColor3 = Color3.fromRGB(89, 134, 104)
	InputUIBottom.BackgroundTransparency = 0.600
	InputUIBottom.BorderSizePixel = 0	
	
	local Input = Instance.new("TextBox",MiniUI)
	Input.Name = "ClientInput"
	Input.Text = ""
	Input.Position = UDim2.new(0.036, 0,0.306, 0)
	Input.Size = UDim2.new(0, 225,0, 128)
	Input.TextColor3 = Color3.fromRGB(255, 255, 255)
	Input.TextStrokeTransparency = 0.65
	Input.TextScaled = true
	Input.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
	Input.BackgroundTransparency = 0.350
	Input.BorderSizePixel = 0
	Input.ZIndex = 10
	
	local Act = Instance.new("TextButton",MiniUI)
	Act.Name = "Action"
	Act.Text = ""
	Act.Position = UDim2.new(0.743, 0,0.308, 0)
	Act.TextColor3 = Color3.fromRGB(255, 255, 255)
	Act.TextStrokeTransparency = 0.65
	Act.TextScaled = true
	Act.Size = UDim2.new(0, 74,0, 128)
	Act.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
	Act.BackgroundTransparency = 0.360
	Act.BorderSizePixel = 0
	Act.ZIndex = 10
	
	local title = Instance.new("TextLabel",MiniUI)
	title.Name = "Title"
	title.Text = ""
	title.TextWrapped = true
	title.Font = "ArialBold"
	title.Position = UDim2.new(0.036, 0,0, 0)
	title.Size = UDim2.new(0.931, 0,0.202, 0)
	title.BackgroundColor3 = Color3.fromRGB(54, 95, 209)
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextStrokeColor3 = Color3.fromRGB(0,0,0)
	title.TextStrokeTransparency = 0.750
	title.TextSize = 30
	title.BackgroundTransparency = 1
	title.BorderSizePixel = 0
	title.ZIndex = 10
	
	local Close = Instance.new("ImageButton", MiniUI)
	Close.Name = "Close"
	Close.Position = UDim2.new(0, 0, 0, 0)
	Close.Size = UDim2.new(0.1, 0,0.202, 0)
	Close.BorderSizePixel = 0
	Close.BackgroundTransparency = 1
	Close.ZIndex = 10
	Close.Image = "rbxassetid://1480666400"
	Close.ImageColor3 = Color3.fromRGB(255, 255, 255)
	
		Close.MouseEnter:connect(function()
		Close.Image = "rbxassetid://1480666583"
	end)

	Act.MouseButton1Up:connect(function()
	if Act.Text == ">" then
			SendClientServer:FireServer("ac0887598d93cf8590b1ebf6cf8d79022cb956be",Input.Text)
	end
	Input.Text = ""
	end)

	Close.MouseLeave:connect(function()
		Close.Image = "rbxassetid://1480666400"
	end)
	
	Close.MouseButton1Up:connect(function()
		Close.Image = "rbxassetid://1480666916"
		
		MiniUI:TweenPosition(UDim2.new(0.5,-125,0.5,-125),nil,tweenstyle,tweentime,true)
		TweenBackgroundTransparency(MiniUI,	0.6,1,tweentime*0.4)
		TweenBackgroundTransparency(MiniUI.Action,0.6,1,tweentime*0.4)
		TweenTextTransparency(MiniUI.Title,0,1,tweentime*0.35)
		TweenTextTransparency(MiniUI.ClientInput,0.650,1,tweentime*0.35)
		TweenTextTransparency(MiniUI.Action,0.650,1,tweentime*0.35)
		TweenBackgroundTransparency(InputUIop,0.150,1,tweentime*0.35)
		TweenBackgroundTransparency(InputUIBottom,0.600,1,tweentime*0.35)
		TweenBackgroundTransparency(MiniUI,0,1,tweentime*0.35)
		TweenBackgroundTransparency(MiniUI.ClientInput,0,1,tweentime*0.35)
		TweenImageTransparency(Close,0,1,tweentime*0.4)
		
		if math.random() > 0.5 then
			TweenRotation(MiniUI,360,math.random(325,380),tweentime*0.8)
		else
			TweenRotation(MiniUI,0,math.random(20,35),tweentime*0.8)
		end
		
		wait(tweentime*0.3)
		--Up.Visible = false
		Close.Visible = false
		--Down.Visible = false
		
		wait(tweentime*0.7)
		MiniUI:Destroy()
	end)
	
	Close.MouseButton1Down:connect(function()
		Close.Image = Images.SysCloseClick
	end)
	
end

function DoDisplayInput(title,output)
			if not Gui then
			MakeAdmiGui()
			end
			
			if not PlayerGui:FindFirstChild("DConsole"):FindFirstChild("InputUI") then
			MakeInputGui()
			end
			
			if title == nil then
			title = "title"
			end
			
			if output == nil then
			output = ""
			end
		
		local InputUI = PlayerGui:FindFirstChild("DConsole"):FindFirstChild("InputUI")		
		InputUI.Position = UDim2.new(0.37, 0,0.4, 0)
		InputUI.Title.Text = title
		InputUI.Action.Text = output
		TweenBackgroundTransparency(InputUI,1,0.6500,tweentime*0.5)
		TweenBackgroundTransparency(InputUI.Action,1,0.6500,tweentime*0.5)
		TweenBackgroundTransparency(InputUI.ClientInput,1,0.6500,tweentime*0.5)
		TweenBackgroundTransparency(InputUI.UndeFrame,1,0.600,tweentime*0.5)
		TweenBackgroundTransparency(InputUI.OveFrame,1,0.150,tweentime*0.5)
		TweenTextTransparency(InputUI.Title,1,0,tweentime*0.65)
		TweenTextTransparency(InputUI.Action,1,0,tweentime*0.65)
		TweenTextTransparency(InputUI.ClientInput,1,0,tweentime*0.65)
		TweenRotation(InputUI,7,0,tweentime*0.7)
		InputUI.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
		InputUI.Draggable = false
		InputUI:TweenSizeAndPosition(UDim2.new(0, 331,0, 202),UDim2.new(0, 0,0.787, 0),nil,tweenstyle,tweentime*1.1,true)
		InputUI.Visible = true
		-- UIBlur
local Transparency = InputUI.BackgroundTransparency
local GUIName = InputUI

local Cam = workspace.CurrentCamera
local GUI = GUIName
local Event = nil

local SG = nil
function IsSG(Obj)
	if Obj:IsA("ScreenGui") then
		SG = Obj
	elseif Obj then
		IsSG(Obj.Parent)
	end
end
IsSG(GUI)
wait(0.5)
InputUI.Draggable = true	
end

function DoDisplayMessage(title,text,displaytime)
	spawn(function()
		local text,title = text,title
		
		if not Gui then
			MakeAdmiGui()
		end
		
		if not PlayerGui:FindFirstChild("DConsole") or not PlayerGui:FindFirstChild("DConsole"):FindFirstChild("Msg") then
			MakeMsgGui()
		end

		local message = PlayerGui:FindFirstChild("DConsole"):FindFirstChild("Msg")
		
		if title == nil then
			title = "Message"
		end
		
		if text == nil then
			text = title
			title = "Message"
		end

		message.Size = UDim2.new(0,0,0,0)
		message.Visible = true		
		message.Title.Text = "[ Content Deleted ]"
		message.Msg.Text = "[ Content Deleted ]"
		message.Title.Text = tostring(title)
		message.Msg.Text = tostring(text)
		message.Position = UDim2.new(0.5,-125,0.5,-100)
		message.Size = UDim2.new(0,250,0,150)
		
		message.TimeRemaining.Size = UDim2.new(displaytime*0.1,0,0.04, 0)
		message.TimeRemaining:TweenSize(UDim2.new(0,0,0.04, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, displaytime*1, true)
		--Countdown, make number BIG
		if MsgShowing == false and message.Title.Text =="🕒 Countdown" then
			--message.TimeRemaining.BackgroundTransparency = tweentime
			message.Msg.TextSize = "50"
			message.TimeRemaining.Size = UDim2.new(1,0,0.04, 0)
			message.TimeRemaining:TweenSize(UDim2.new(0,0,0.04, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.8, true)
		elseif  message.Title.Text ~="🕒 Countdown" then
			message.Msg.TextSize = 18
		end
		
		if MsgShowing == false and message.Title.Text == "Unknown Command" then
			TweenTextTransparency(message.Title,1,0,tweentime*0.65)
		TweenTextTransparency(message.Msg,1,0,tweentime*0.65)
		TweenBackgroundTransparency(message,1,0.6500,tweentime*0.5)
		TweenBackgroundTransparency(message.OveFrame,1,0.150,tweentime*0.4)
		TweenBackgroundTransparency(message.UndeFrame,1,0.400,tweentime*0.4)
		TweenRotation(message,10,0,tweentime*0.5)
		message.TimeRemaining.BackgroundTransparency = tweentime
		--message.BackgroundColor3 = Color3.fromRGB(116, 106, 70)
		message.UndeFrame.BackgroundColor3 =  Color3.fromRGB(187, 199, 123)
		message.OveFrame.BackgroundColor3 =  Color3.fromRGB(187, 199, 123)
		message.Draggable = false
		message:TweenSizeAndPosition(UDim2.new(0,500,0,300),UDim2.new(0.5,-250,0.5,-150),nil,tweenstyle,tweentime*1.1,true)
		message.Visible = true
		wait(0.5)
		message.Draggable = true
		end
		
		if MsgShowing == false and message.Title.Text == "⚠ A Command Error has occurred" then
			TweenTextTransparency(message.Title,1,0,tweentime*0.65)
		TweenTextTransparency(message.Msg,1,0,tweentime*0.65)
		TweenBackgroundTransparency(message,1,0.6500,tweentime*0.5)
		TweenBackgroundTransparency(message.OveFrame,1,0.150,tweentime*0.4)
		TweenBackgroundTransparency(message.UndeFrame,1,0.400,tweentime*0.4)
		TweenRotation(message,10,0,tweentime*0.5)
		message.TimeRemaining.BackgroundTransparency = tweentime
		--message.BackgroundColor3 = Color3.fromRGB(116, 106, 70)
		message.UndeFrame.BackgroundColor3 = Color3.fromRGB(187, 199, 123)
		message.OveFrame.BackgroundColor3 =  Color3.fromRGB(187, 199, 123)
		message.Draggable = false
		message:TweenSizeAndPosition(UDim2.new(0,500,0,300),UDim2.new(0.5,-250,0.5,-150),nil,tweenstyle,tweentime*1.1,true)
		message.Visible = true
		wait(0.5)
		message.Draggable = true
		end
		
		if MsgShowing == false and message.Title.Text ~= "⚠ A DMC Error has occurred" and message.Title.Text ~= "Unknown Command" and message.Title.Text ~= "⚠ A Command Error has occurred" then
		TweenTextTransparency(message.Title,1,0,tweentime*0.65)
		TweenTextTransparency(message.Msg,1,0,tweentime*0.65)
		TweenBackgroundTransparency(message,1,0.6500,tweentime*0.5)
		TweenRotation(message,7,0,tweentime*0.6)
		TweenBackgroundTransparency(message.OveFrame,1,0.150,tweentime*0.4)
		TweenBackgroundTransparency(message.UndeFrame,1,0.400,tweentime*0.4)
		message.TimeRemaining.BackgroundTransparency = tweentime
		message.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
		message.UndeFrame.BackgroundColor3 =  Color3.fromRGB(54, 54, 54)
		message.OveFrame.BackgroundColor3 =  Color3.fromRGB(54, 54, 54)
		message.Draggable = false
		message:TweenSizeAndPosition(UDim2.new(0,500,0,300),UDim2.new(0.5,-250,0.5,-150),nil,tweenstyle,tweentime*1.1,true)
		message.Visible = true
		wait(0.5)
		message.Draggable = true
		elseif MsgShowing == true then
		message.Visible = true
		message.Position = UDim2.new(0.5, -250,0.5, -150)
		-- lol funny error position
		elseif MsgShowing == false and message.Title.Text == "⚠ A DMC Error has occurred" then
							if math.random() > 0.5 then
					message.Rotation = 20
				else
					message.Rotation = -20
				end
		TweenTextTransparency(message.Title,1,0,tweentime*0.65)
		TweenTextTransparency(message.Msg,1,0,tweentime*0.65)
		TweenBackgroundTransparency(message.OveFrame,1,0.150,tweentime*0.4)
		TweenBackgroundTransparency(message.UndeFrame,1,0.400,tweentime*0.4)
		--message.BackgroundColor3 = Color3.fromRGB(71, 35, 35)
		message.UndeFrame.BackgroundColor3 =  Color3.fromRGB(199, 93, 93)
		message.OveFrame.BackgroundColor3 =  Color3.fromRGB(199, 93, 93)
		TweenBackgroundTransparency(message,1,0.6500,tweentime*0.8)
		TweenBackgroundTransparency(TimeShowing,1,0.6500,tweentime*0.8)
		message.Draggable = false
		message:TweenSizeAndPosition(UDim2.new(0,500,0,300),UDim2.new(0.5,-250,0.5,-150),nil,"Quad",tweentime*0.5,true)
		message.Visible = true
		wait(0.5)
		message.Draggable = true
		end
		message.Draggable = true
	--	message.TimeRemaining:TweenSize(UDim2.new(0,0,0.04, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, tweentime*0.5, true)
		wait(tweentime)
		
		if displaytime ~= nil then
			MsgShowing = false
			delay(displaytime,function()if message.Msg.Text == tostring(text)then DoDismissMessage(player)end end)
		end
	end)
end

function EmergencyAlert(title,text,displaytime)
EmergencyMode = true
	spawn(function()
		local text,title = text,title
		
		if not Gui then
			MakeAdmiGui()
		end
		
		if not PlayerGui:FindFirstChild("DConsole_EMERGENCY") or not PlayerGui:FindFirstChild("DConsole_EMERGENCY"):FindFirstChild("Msg") then
			MakeMsgGui()
		end

		local message = PlayerGui:FindFirstChild("DConsole_EMERGENCY"):FindFirstChild("Msg")
		
		message.Size = UDim2.new(0,0,0,0)
		message.Visible = true		
		message.Title.Text = ""
		message.Msg.Text = ""
		message.Title.Text = tostring(title)
		message.Msg.Text = tostring(text)
		message.Position = UDim2.new(0.5,-125,0.5,-100)
		message.Size = UDim2.new(0,250,0,150)
		TweenTextTransparency(message.Title,1,0,tweentime*0.65)
		TweenBackgroundTransparency(message.UndeFrame,1,0,tweentime*0.65)
		TweenBackgroundTransparency(message.OveFrame,1,0,tweentime*0.65)
		TweenTextTransparency(message.Msg,1,0,tweentime*0.65)
		TweenBackgroundTransparency(message,1,0.6500,tweentime*0.5)
		TweenRotation(message,5,0,tweentime*0.65)
		--wait()
		message:TweenSizeAndPosition(UDim2.new(0,500,0,300),UDim2.new(0.5,-250,0.5,-150),nil,tweenstyle,tweentime*1.1,true)
		message.Visible = true
		wait(tweentime)
	wait(10)
	DoDismissMessage(player)
				message.Draggable = false
	end)
end

for _,i in pairs(Images) do
	game:GetService("ContentProvider"):Preload(i)
end

function TweenBackgroundTransparency(element,starta,enda,length)
	coroutine.resume(coroutine.create(function()
element.BackgroundTransparency = starta
local goal = {}
goal.BackgroundTransparency = enda
local tweenInfo = TweenInfo.new(length, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(element, tweenInfo, goal)
tween:Play()	
--[[		local startTime = time()
		local lastTrans = element.BackgroundTransparency
		while time() - startTime < length do
			if element.BackgroundTransparency == lastTrans then
				element.BackgroundTransparency = ((enda - starta) * ((time() - startTime)/length)) + starta
			else
				break
			end
			lastTrans = element.BackgroundTransparency
			wait()
		end
		element.BackgroundTransparency = enda]]
		return true
	end))
end

function TweenRotation(element,starta,enda,length)
element.Rotation = starta
	coroutine.resume(coroutine.create(function()
local goal = {}
goal.Rotation = enda
local tweenInfo = TweenInfo.new(length)
local tween = TweenService:Create(element, tweenInfo, goal)
tween:Play()	
--[[		local startTime = time()
		local lastRot = element.Rotation
		while time() - startTime < length do
			if element.Rotation == lastRot then
				element.Rotation = ((enda - starta) * ((time() - startTime)/length)) + starta
			else
				break
			end
						wait()
			lastRot = element.Rotation
		end
		element.Rotation = enda]]
		return true
	end))
end

function TweenTextTransparency(element,starta,enda,length)
	coroutine.resume(coroutine.create(function()
		--[[
local TextStrokeTrans = element.TextStrokeTransparency
element.TextTransparency = starta
element.TextStrokeTransparency = starta
local goal = {}
goal.TextTransparency = enda
goal.TextStrokeTransparency = TextStrokeTrans
local tweenInfo = TweenInfo.new(length)
local tween = TweenService:Create(element, tweenInfo, goal)
		tween:Play()	]]
		local startTime = time()
		local lastTextTrans = element.TextTransparency
		local lastTextStrokeTrans = element.TextStrokeTransparency
			while time() - startTime < length do
			if element.TextTransparency == lastTextTrans and element.TextStrokeTransparency == lastTextStrokeTrans then
				element.TextTransparency = ((enda - starta) * ((time() - startTime)/length)) + starta
				element.TextStrokeTransparency = 0.75 + (element.TextTransparency * 0.25)
			else
				break
			end
			lastTextTrans = element.TextTransparency
			lastTextStrokeTrans = element.TextStrokeTransparency
			wait()
		end
		element.TextTransparency = enda
		element.TextStrokeTransparency = 0.75 + (element.TextTransparency * 0.25)
		return true
	end))
end


function TweenImageTransparency(element,starta,enda,length)
coroutine.resume(coroutine.create(function()
element.ImageTransparency = starta
local goal = {}
goal.ImageTransparency = enda
local tweenInfo = TweenInfo.new(length, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(element, tweenInfo, goal)
tween:Play()	
		return true
	end))
end

function MakeTellGui(parent)
	if parent == "root" then
		return
	end
	if not Gui then
		MakeAdmiGui(parent)
	end
	local TellText = Instance.new("TextLabel",Gui)
	TellText.Name = "Message"
	TellText.BackgroundColor3 = Color3.new(0,0,0)
	TellText.BackgroundTransparency = 1
	TellText.BorderSizePixel = 0
	TellText.Font = "ArialBold"
	TellText.FontSize = "Size18"
	TellText.Text = "Message"
	TellText.TextStrokeTransparency = 0.5
	TellText.TextColor3 = Color3.new(1,1,1)
	TellText.Size = UDim2.new(1,0,0,32)
	if TellText.Rotation ~= 0 then
	TellText.Position = UDim2.new(0,0,-1,0)
	TellText.ZIndex = 10
	TellText.Rotation = 365
	else
	TellText.Position = UDim2.new(0,0,0,-2)
	TellText.ZIndex = 10
	end
	
	local FakeBar = Instance.new("TextLabel",TellText)
	FakeBar.Name = "FakeBar"
	FakeBar.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
	FakeBar.BackgroundTransparency = 0.35
	FakeBar.BorderSizePixel = 0
	FakeBar.Size = UDim2.new(2,0,0,180)
	FakeBar.Position = UDim2.new(0,0,0,-150)
	FakeBar.ZIndex = 9

-- UIBlur
local Transparency = FakeBar.BackgroundTransparency
local GUIName = FakeBar

local Cam = workspace.CurrentCamera
local GUI = GUIName
local Event = nil

local SG = nil
function IsSG(Obj)
	if Obj:IsA("ScreenGui") then
		SG = Obj
	elseif Obj then
		IsSG(Obj.Parent)
	end
end
IsSG(GUI)
	return TellText
end

function DoTell(msg,displaytime)
		
	
	if not Gui then
		MakeAdmiGui()
	end
	
	if not Gui:FindFirstChild("Message") then
		letellmsg = MakeTellGui(PlayerGui)
	end
	
	if not msg then
		msg = ""
	end
	
	if displaytime == nil then
		displaytime = 4
	end
	
if HintShowing == false then
	HintShowing = true
	letellmsg.Text = msg
	letellmsg.Position = UDim2.new(0,0,0,-120)
	letellmsg.Rotation = TellGuiBounceOffset
	letellmsg.FakeBar.BackgroundTransparency = 1
	TweenBackgroundTransparency(letellmsg.FakeBar,	1,0.6,tweentime*1.1)
	letellmsg:TweenPosition(UDim2.new(0,0,0,-2.1),nil,tweenstyle,tweentime*0.9,true)
	TweenRotation(letellmsg,TellGuiBounceOffset,0,tweentime*0.5)
	TweenTextTransparency(letellmsg,1,0,tweentime*1.1)
	letellmsg.FakeBar.BackgroundTransparency = 0.5
	letellTrans = false
	wait(0.2)
	letellmsg.FakeBar.BackgroundTransparency = 0.5
--[[elseif HintShowing == true then
	letellmsg.Text = msg	
	letellmsg.Rotation = 0
letellmsg.FakeBar.BackgroundTransparency = 0.5
	letellmsg:TweenPosition(UDim2.new(0,0,0,10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
		letellmsg.Rotation = 0
	wait(0.2)
		letellmsg.Rotation = 0
	letellmsg:TweenPosition(UDim2.new(0,0,0,-2.1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
		letellmsg.FakeBar.BackgroundTransparency = 0.5
]]
	HintShowing = false
	letellTrans = false
end
wait(displaytime)
if letellmsg.Position == UDim2.new(0, 0,0, -2) then
			letellmsg.FakeBar.BackgroundTransparency = 0.5
		if letellmsg.Text == msg then
			letellmsg.FakeBar.BackgroundTransparency = 0.5
			TweenRotation(letellmsg,360,360 -TellGuiBounceOffset,tweentime*0.5)
		letellTrans = true
			if letellTrans == true then
			letellmsg:TweenPosition(UDim2.new(0,0,0,-110),nil,tweenstyle,tweentime*1,true)
			wait(0.5)
			end
			if letellmsg.Position == UDim2.new(0,0,0,-110) then
				letellmsg.FakeBar.BackgroundTransparency = 1
			end
			HintShowing = false
		end
		end
end

function DoDisplayScrollFrame(title,desc,text)
	
	if player == nil or player == "root" then
		return
	end
	
	if not Gui then
		MakeAdmiGui()
	end
	
	local title = title
		local desc = desc
		local text = text
	
	if title == nil then
		title = "Scrolling_Frame_Title"
	end
	
	if desc == nil then
		desc = "No description available."
	end
	
if desc == "" then
		desc = "No description available."
	end
	
	if text == nil then
		text = "No content available."
	end
	
	if text == "" then
		text = "No content available."
	end
	
			
	if not PlayerGui:FindFirstChild("DConsole") then
		MakeAdmiGui(player)
	end
	
	local MsgStrips = {}
	
	local DesStrips = {}
	
	local ReenableMsg = false
	
	local ScrollGui = Instance.new("TextButton", Gui)
	ScrollGui.Name = "ScrollGui"
	ScrollGui.Text = ""
	ScrollGui.Modal = true
	ScrollGui.AutoButtonColor = false
	ScrollGui.Draggable = true
	ScrollGui.Position = UDim2.new(0.5, -125, 0.5, -125)
	ScrollGui.Size = UDim2.new(0, 250, 0, 250)
	ScrollGui.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
	ScrollGui.BackgroundTransparency = 0.850
	ScrollGui.BorderSizePixel = 0
	ScrollGui.ZIndex = 2000
	ScrollGui.ClipsDescendants = true
	
	local ScrollUderUIop = Instance.new("Frame", ScrollGui)
	ScrollUderUIop.Name = "OveFrame"
	ScrollUderUIop.Position = UDim2.new(0, 0,0, 0)
	ScrollUderUIop.Size = UDim2.new(1, 0,0.138, 0)
	ScrollUderUIop.BackgroundColor3 = Color3.fromRGB(54, 95, 209)
	ScrollUderUIop.BackgroundTransparency = 0.150
	ScrollUderUIop.BorderSizePixel = 0
	ScrollUderUIop.ZIndex = 2000
	
	local ScrollUderUIBottom = Instance.new("Frame", ScrollGui)
	ScrollUderUIBottom.Name= "UndeFrame"
	ScrollUderUIBottom.Position = UDim2.new(0, 0,0.162, 0)
	ScrollUderUIBottom.Size = UDim2.new(1, 0,0.838, 0)
	ScrollUderUIBottom.BackgroundColor3 = Color3.fromRGB(89, 134, 104)
	ScrollUderUIBottom.BackgroundTransparency = 0.400
	ScrollUderUIBottom.BorderSizePixel = 0
	ScrollUderUIBottom.ZIndex = 2000
	
	local ScrollingFrameCutter = Instance.new("Frame", ScrollGui)
	ScrollingFrameCutter.Name = "ScrollingFrameCutter"
	ScrollingFrameCutter.Position = UDim2.new(0, 0,0.676, -250)
	ScrollingFrameCutter.Size = UDim2.new(1, 0,0.824, 0)
	ScrollingFrameCutter.BackgroundColor3 = Color3.new(54, 54, 54)
	ScrollingFrameCutter.BackgroundTransparency = 1
	ScrollingFrameCutter.BorderSizePixel = 0
	ScrollingFrameCutter.ZIndex = 2000
	ScrollingFrameCutter.ClipsDescendants = true
	ScrollingFrameCutter.Visible = false
	
	local AntiScrollDrag = Instance.new("TextButton",ScrollGui)
	AntiScrollDrag.Name = "ScrollHelper"
	AntiScrollDrag.Position = UDim2.new(0, 0,0, 0)
	AntiScrollDrag.Size = UDim2.new(0, 9,1, 0)
	AntiScrollDrag.BackgroundTransparency = 1
	AntiScrollDrag.BorderSizePixel = 0
	AntiScrollDrag.ZIndex = 2000
	AntiScrollDrag.Text = ""
	
	local MsgContainer = Instance.new("ScrollingFrame", ScrollingFrameCutter)
	MsgContainer.Name = "MsgContainer"
	MsgContainer.BackgroundTransparency = 1
	MsgContainer.Size = UDim2.new(1, 0,1, 0)
	MsgContainer.BorderSizePixel = 0
	MsgContainer.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	MsgContainer.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	MsgContainer.VerticalScrollBarInset = "Always"
	MsgContainer.VerticalScrollBarPosition = "Right"
	MsgContainer.ClipsDescendants = false
	MsgContainer.ScrollBarThickness = 9
	MsgContainer.ZIndex = 2000
	if desc ~= "none" then
	MsgContainer.Size = UDim2.new(1, 0,0.857, 0)
	MsgContainer.Position = UDim2.new(0, 0,0.143, 0)
	end
	
	if desc ~= "none" then
	local DescContainer = Instance.new("Frame", ScrollingFrameCutter)
	DescContainer.Name = "DescContainer"
	DescContainer.Size = UDim2.new(1, 0,0.15, 0)
	DescContainer.BackgroundTransparency = 1
	DescContainer.BorderSizePixel = 0
	DescContainer.ZIndex = 2000
	end
	--[[

	local TidBit = Instance.new("TextButton", ScrollGui)
	TidBit.ZIndex = 10
	TidBit.Name = "Description"
	TidBit.Position = UDim2.new(MsgStrips)
	TidBit.Text = desc
	TidBit.Visible = false
	]]
	
--[[	
	local Up = Instance.new("ImageButton", ScrollGui)
	Up.Name = "Up"
	Up.Position = UDim2.new(0.93, 0, 0.02, 0)
	Up.Size = UDim2.new(0.055, 0, 0.055, 0)
	Up.BackgroundTransparency = 1
	Up.ZIndex = 10
	Up.Image = Images.Arrow
	Up.Visible = false]]

-- UIBlur
local Transparency = ScrollGui.BackgroundTransparency
local GUIName = ScrollGui

local Cam = workspace.CurrentCamera
local GUI = GUIName
local Event = nil

local SG = nil
function IsSG(Obj)
	if Obj:IsA("ScreenGui") then
		SG = Obj
	elseif Obj then
		IsSG(Obj.Parent)
	end
end
IsSG(GUI)

	local Title = Instance.new("TextLabel", ScrollGui)
	Title.Name = "Title"
	Title.Position = UDim2.new(0, 0, 0.025, 0)
	Title.Size = UDim2.new(1, 0, 0.1, 0)
	Title.BackgroundTransparency = 1
	Title.BorderSizePixel = 0
	Title.Text = title
	Title.Font = Enum.Font.ArialBold
	Title.FontSize = Enum.FontSize.Size24
	Title.TextScaled = true
	Title.TextWrapped = true
	Title.TextYAlignment = Enum.TextYAlignment.Top
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.ZIndex = 2000
	
	local Close = Instance.new("ImageButton", ScrollGui)
	Close.Name = "Close"
	Close.Position = UDim2.new(0, 0, 0, 0)
	Close.Size = UDim2.new(0.1, 0, 0.1, 0)
	Close.BorderSizePixel = 0
	Close.BackgroundTransparency = 1
	Close.ZIndex = 2000
	Close.Image = "rbxassetid://1480666400"
	Close.ImageColor3 = Color3.fromRGB(255, 255, 255)
		
		Close.MouseEnter:connect(function()
		Close.Image = "rbxassetid://1480666583"
	end)

	Close.MouseLeave:connect(function()
		Close.Image = "rbxassetid://1480666400"
	end)
	
	Close.MouseButton1Up:connect(function()
		if MsgContainer == nil or MsgContainer.Parent == nil then
			return
		end
		Close.Image = "rbxassetid://1480666583"
		
		ScrollGui:TweenSizeAndPosition(UDim2.new(0,200,0,250),UDim2.new(0.5,-125,0.5,-125),nil,tweenstyle,tweentime,true)
		TweenBackgroundTransparency(ScrollGui,	0.6,1,tweentime*0.4)
		TweenBackgroundTransparency(ScrollUderUIop, 0.6,1,tweentime*0.4)
		TweenBackgroundTransparency(ScrollUderUIBottom, 0.6,1,tweentime*0.4)
		TweenImageTransparency(Close,0,1,tweentime*0.4)
		--TweenBackgroundTransparency(Up,0.85,1,tweentime*0.375)
		--TweenBackgroundTransparency(Down,0.85,1,tweentime*0.375)
		--TweenBackgroundTransparency(Close,0.85,1,tweentime*0.375)

		--TweenTextTransparency(Up,0,1,tweentime*0.35)
		--TweenTextTransparency(Down,0,1,tweentime*0.35)
		--TweenTextTransparency(Close,0,1,tweentime*0.35)
		
		TweenTextTransparency(Title,0,1,tweentime*0.35)
			MsgContainer.Visible = false
			if desc ~= "none" then
			ScrollingFrameCutter:FindFirstChild("DescContainer").Visible = false
			end
		for _,i in pairs(MsgStrips) do
			
			i.Visible = false
		end
		
		if math.random() > 0.5 then
			TweenRotation(ScrollGui,360,math.random(325,380),tweentime*0.8)
		else
			TweenRotation(ScrollGui,0,math.random(20,35),tweentime*0.8)
		end
		
		wait(tweentime*0.3)
		AnimationGo = false
		MsgContainer.Visible = false
		--Up.Visible = false
		Close.Visible = false
		--Down.Visible = false
		
		wait(tweentime*0.7)
		
		ScrollGui:Destroy()
		AnimationGo = true
	end)
	
	--Change active gui

	ScrollGui.MouseButton1Click:connect(function()
		ScrollGui.Active = true
		if ScrollGui.Active == true then
			ScrollGui.ScrollHelper.ZIndex = 1999
			ScrollGui.ZIndex = 2000
		for i,v in pairs(ScrollGui:GetChildren()) do
			v.ZIndex = 2000
		end
		
		for i,v in pairs(ScrollGui.ScrollingFrameCutter:GetChildren()) do
			v.ZIndex = 2000
		end
		if ScrollGui.ScrollingFrameCutter:FindFirstChild("DescContainer") then
		for i,v in pairs(ScrollGui.ScrollingFrameCutter.DescContainer:GetChildren()) do
			v.ZIndex = 2000
		end
		end
				
		for i,v in pairs(ScrollGui.ScrollingFrameCutter.MsgContainer:GetChildren()) do
			v.ZIndex = 2000
		end
		end
	end)
	
	ScrollGui.MouseLeave:connect(function()
		ScrollGui.Active = false
			ScrollGui.ZIndex = 1
		for i,v in pairs(ScrollGui:GetChildren()) do
			v.ZIndex = 1
		end
		
		for i,v in pairs(ScrollGui.ScrollingFrameCutter:GetChildren()) do
			v.ZIndex = 1
		end
		
	if ScrollGui.ScrollingFrameCutter:FindFirstChild("DescContainer") then
		for i,v in pairs(ScrollGui.ScrollingFrameCutter:FindFirstChild("DescContainer"):GetChildren()) do
			v.ZIndex = 1
		end
	end		
		for i,v in pairs(ScrollGui.ScrollingFrameCutter.MsgContainer:GetChildren()) do
			v.ZIndex = 1
		end
	end)
	
	
	
	
	Close.MouseButton1Down:connect(function()
		Close.Image = Images.SysCloseClick
	end)
	
	ScrollingFrameCutter.Visible = false
	
	TweenRotation(ScrollGui,5,0,tweentime*0.8)
	
	ScrollGui:TweenSizeAndPosition(UDim2.new(0,500,0,500),UDim2.new(0.5,-250,0.5,-250),nil,tweenstyle,tweentime*1.1,true)
	TweenBackgroundTransparency(ScrollGui,1,0.6500,tweentime*0.6500)
	TweenBackgroundTransparency(ScrollUderUIBottom,1,0.400,tweentime*0.6500)
	TweenBackgroundTransparency(ScrollUderUIop,1,0.150,tweentime*0.6500)
	--TweenBackgroundTransparency(Up,1,0.85,tweentime*0.5)
	--TweenBackgroundTransparency(Down,1,0.85,tweentime*0.5)
	--TweenBackgroundTransparency(Close,1,0.85,tweentime*0.5)
	
	--TweenTextTransparency(Up,1,0,tweentime*0.6)
	--TweenTextTransparency(Down,1,0,tweentime*0.6)
	--TweenTextTransparency(Close,1,0,tweentime*0.6)
	
	TweenTextTransparency(Title,1,0,tweentime*0.6)
	
	wait(tweentime*1.2)
	
	ScrollingFrameCutter.Parent = ScrollGui
	ScrollingFrameCutter.Visible = true
	
if title == "📝 Chat Logs" then
	if desc ~= "none" then
for desc in desc:gmatch("[^\n]+") do
local Desc = Instance.new("TextLabel", ScrollingFrameCutter:FindFirstChild("DescContainer"))		
		Desc.Font = "ArialBold"
		Desc.Name = "Description"..(#DesStrips + 1)
		Desc.Position = UDim2.new(0,0,0.05,#DesStrips * 18)	
		Desc.Size = UDim2.new(1, 0, 0, 16)
		Desc.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
		Desc.BackgroundTransparency = 1
		Desc.BorderSizePixel = 0
		ScrollingFrameCutter:FindFirstChild("DescContainer").Size = UDim2.new(1,0,#DesStrips + 0.15,0)
		Desc.Text = " "..tostring(desc)
		Desc.FontSize = Enum.FontSize.Size18
		Desc.TextTransparency = #MsgContainer:GetChildren() > 24 and 0 or 1
		Desc.TextYAlignment = Enum.TextYAlignment.Center
		Desc.TextXAlignment = Enum.TextXAlignment.Left
		Desc.TextColor3 = Color3.new(1, 1, 1)
		Desc.TextStrokeTransparency = #MsgContainer:GetChildren() > 24 and 0.75 or 1
		Desc.TextWrapped = true
	Desc.TextScaled = false
		Desc:TweenPosition(UDim2.new(0,0,0,#DesStrips * 18), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0, true)
		Desc.ZIndex = 2000
		TweenTextTransparency(Desc,1,0,tweentime*0.25)
		--Down.Visible = true
	--	Up.Visible = true
		--wait(0)
		table.insert(DesStrips,Desc)
end
end

	for TEXT in text:gmatch("[^\n]+") do
		if ScrollGui.Rotation == 0 then
		local Msg = Instance.new("TextLabel", MsgContainer)
					if text == nil then
		text = title
		title = "localization string not found"
			return
		end	
	if text == "" then
		text = Msg
		title = "localization string not found"
	end
		Msg.Name = "HighLight"..(#MsgStrips + 1)
		Msg.Position = UDim2.new(0.01, 0,0.05,#MsgStrips)	
		MsgContainer.CanvasSize = UDim2.new(1, 0,#MsgStrips * 0.0455)
		Msg.Size = UDim2.new(1, 0, 0, 16)
	--	Msg.Position = UDim2.new(0,0,0,#MsgStrips * 18)
		Msg.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
		Msg.BackgroundTransparency = 1
		Msg.BorderSizePixel = 0
		Msg.Text = " "..tostring(TEXT)
		Msg.Font = Enum.Font.Arial
		Msg.FontSize = Enum.FontSize.Size18
		Msg.TextTransparency = #MsgContainer:GetChildren() > 24 and 0 or 1
		Msg.TextYAlignment = Enum.TextYAlignment.Center
		Msg.TextXAlignment = Enum.TextXAlignment.Left
		Msg.TextColor3 = Color3.new(1, 1, 1)
		Msg.TextStrokeTransparency = #MsgContainer:GetChildren() > 24 and 0.75 or 1
		Msg.TextWrapped = true
		Msg.TextScaled = true
		Msg:TweenPosition(UDim2.new(0,0,0,#MsgStrips * 18), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)
		Msg.ZIndex = 2000
		TweenTextTransparency(Msg,1,0,tweentime*0.25)
		--Down.Visible = true
	--	Up.Visible = true
		--wait(0)
		table.insert(MsgStrips,Msg)
		end
	end
		MsgContainer.ClipsDescendants = true
		--[[
			
					local Desc = Instance.new("TextLabel", DescContainer)	
		if DescContainer == nil then
				if text == nil then
		text = title
		title = "localization string not found"
					end		
		Desc.Name = "Description"..(#MsgStrips + 1)
		Desc.Position = UDim2.new(0,0,0.05,#MsgStrips * 18)	
		Desc.Size = UDim2.new(1, 0, 0, 16)
		Desc.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
		Desc.BackgroundTransparency = 1
		Desc.BorderSizePixel = 0
		Desc.Text = " "..tostring(TEXT)
		Desc.Font = Enum.Font.Arial
		Desc.FontSize = Enum.FontSize.Size18
		Desc.TextTransparency = #MsgContainer:GetChildren() > 24 and 0 or 1
		Desc.TextYAlignment = Enum.TextYAlignment.Center
		Desc.TextXAlignment = Enum.TextXAlignment.Left
		Desc.TextColor3 = Color3.new(1, 1, 1)
		Desc.TextStrokeTransparency = #MsgContainer:GetChildren() > 24 and 0.75 or 1
		Desc.TextWrapped = true
		Desc.TextScaled = true
		Desc:TweenPosition(UDim2.new(0,0,0,#MsgStrips * 18), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)
		Desc.ZIndex = 9
		TweenTextTransparency(Desc,1,0,tweentime*0.25)
		--Down.Visible = true
	--	Up.Visible = true
		--wait(0)
		table.insert(MsgStrips,Desc)
		]]
		return
end

if title == "🎶 Music Presets" then
	if desc ~= "none" then
for desc in desc:gmatch("[^\n]+") do
local Desc = Instance.new("TextLabel", ScrollingFrameCutter:FindFirstChild("DescContainer"))		
		Desc.Font = "ArialBold"	
		Desc.Name = "Description"..(#DesStrips + 1)
		Desc.Position = UDim2.new(0,0,0.05,#DesStrips * 18)	
		Desc.Size = UDim2.new(1, 0, 0, 16)
		Desc.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
		Desc.BackgroundTransparency = 1
		Desc.BorderSizePixel = 0
		ScrollingFrameCutter:FindFirstChild("DescContainer").Size = UDim2.new(1,0,#DesStrips + 0.15,0)
		Desc.Text = " "..tostring(desc)
		Desc.FontSize = Enum.FontSize.Size18
		Desc.TextTransparency = #MsgContainer:GetChildren() > 24 and 0 or 1
		Desc.TextYAlignment = Enum.TextYAlignment.Center
		Desc.TextXAlignment = Enum.TextXAlignment.Left
		Desc.TextColor3 = Color3.new(1, 1, 1)
		Desc.TextStrokeTransparency = #MsgContainer:GetChildren() > 24 and 0.75 or 1
		Desc.TextWrapped = true
	Desc.TextScaled = false
		Desc:TweenPosition(UDim2.new(0,0,0,#DesStrips * 18), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0, true)
		Desc.ZIndex = 2000
		TweenTextTransparency(Desc,1,0,tweentime*0.25)
		--Down.Visible = true
	--	Up.Visible = true
		--wait(0)
		table.insert(DesStrips,Desc)
end
end

	for TEXT in text:gmatch("[^\n]+") do
		if ScrollGui.Rotation == 0 then
		local Msg = Instance.new("TextLabel", MsgContainer)
					if text == nil then
		text = title
		title = "localization string not found"
			return
		end	
	if text == "" then
		text = Msg
		title = "localization string not found"
	end
		Msg.Name = "HighLight"..(#MsgStrips + 1)
		Msg.Position = UDim2.new(0.01, 0,0.05,#MsgStrips)	
		MsgContainer.CanvasSize = UDim2.new(1, 0,#MsgStrips * 0.0438)
		Msg.Size = UDim2.new(1, 0, 0, 16)
	--	Msg.Position = UDim2.new(0,0,0,#MsgStrips * 18)
		Msg.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
		Msg.BackgroundTransparency = 1
		Msg.BorderSizePixel = 0
		Msg.Text = " "..tostring(TEXT)
		Msg.Font = Enum.Font.Arial
		Msg.FontSize = Enum.FontSize.Size18
		Msg.TextTransparency = #MsgContainer:GetChildren() > 24 and 0 or 1
		Msg.TextYAlignment = Enum.TextYAlignment.Center
		Msg.TextXAlignment = Enum.TextXAlignment.Left
		Msg.TextColor3 = Color3.new(1, 1, 1)
		Msg.TextStrokeTransparency = #MsgContainer:GetChildren() > 24 and 0.75 or 1
		Msg.TextWrapped = true
		Msg.TextScaled = true
		Msg:TweenPosition(UDim2.new(0,0,0,#MsgStrips * 18), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)
		Msg.ZIndex = 2000
		TweenTextTransparency(Msg,1,0,tweentime*0.25)
		--Down.Visible = true
	--	Up.Visible = true
		--wait(0)
		table.insert(MsgStrips,Msg)
		end
	end
		MsgContainer.ClipsDescendants = true
		--[[
			
					local Desc = Instance.new("TextLabel", DescContainer)	
		if DescContainer == nil then
				if text == nil then
		text = title
		title = "localization string not found"
					end		
		Desc.Name = "Description"..(#MsgStrips + 1)
		Desc.Position = UDim2.new(0,0,0.05,#MsgStrips * 18)	
		Desc.Size = UDim2.new(1, 0, 0, 16)
		Desc.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
		Desc.BackgroundTransparency = 1
		Desc.BorderSizePixel = 0
		Desc.Text = " "..tostring(TEXT)
		Desc.Font = Enum.Font.Arial
		Desc.FontSize = Enum.FontSize.Size18
		Desc.TextTransparency = #MsgContainer:GetChildren() > 24 and 0 or 1
		Desc.TextYAlignment = Enum.TextYAlignment.Center
		Desc.TextXAlignment = Enum.TextXAlignment.Left
		Desc.TextColor3 = Color3.new(1, 1, 1)
		Desc.TextStrokeTransparency = #MsgContainer:GetChildren() > 24 and 0.75 or 1
		Desc.TextWrapped = true
		Desc.TextScaled = true
		Desc:TweenPosition(UDim2.new(0,0,0,#MsgStrips * 18), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)
		Desc.ZIndex = 9
		TweenTextTransparency(Desc,1,0,tweentime*0.25)
		--Down.Visible = true
	--	Up.Visible = true
		--wait(0)
		table.insert(MsgStrips,Desc)
		]]
		return
end

if title== "📄 Commands" then
	if desc ~= "none" then
for desc in desc:gmatch("[^\n]+") do
local Desc = Instance.new("TextLabel", ScrollingFrameCutter:FindFirstChild("DescContainer"))			
		Desc.Font = "ArialBold"
		Desc.Name = "Description"..(#DesStrips + 1)
		Desc.Position = UDim2.new(0,0,0.05,#DesStrips * 18)	
		Desc.Size = UDim2.new(1, 0, 0, 16)
		Desc.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
		Desc.BackgroundTransparency = 1
		Desc.BorderSizePixel = 0
		ScrollingFrameCutter:FindFirstChild("DescContainer").Size = UDim2.new(1,0,#DesStrips + 0.15,0)
		Desc.Text = " "..tostring(desc)
		Desc.FontSize = Enum.FontSize.Size18
		Desc.TextTransparency = #MsgContainer:GetChildren() > 24 and 0 or 1
		Desc.TextYAlignment = Enum.TextYAlignment.Center
		Desc.TextXAlignment = Enum.TextXAlignment.Left
		Desc.TextColor3 = Color3.new(1, 1, 1)
		Desc.TextStrokeTransparency = #MsgContainer:GetChildren() > 24 and 0.75 or 1
		Desc.TextWrapped = true
		Desc.TextScaled = false
		Desc:TweenPosition(UDim2.new(0,0,0,#DesStrips * 18), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0, true)
		Desc.ZIndex = 2000
		TweenTextTransparency(Desc,1,0,tweentime*0.25)
		--Down.Visible = true
	--	Up.Visible = true
		--wait(0)
		table.insert(DesStrips,Desc)
end
	end
	
	for a in text:gmatch("[^\n]+") do
		if ScrollGui.Rotation == 0 then
		local Msg = Instance.new("TextButton", MsgContainer)
			if text == nil then
		text = title
		title = "localization string not found"
			end
			
		Msg.Name = "HighLight"..(#MsgStrips + 1)
		Msg.Position = UDim2.new(0.01, 0,0.02,#MsgStrips )
		Msg.Size = UDim2.new(0.2, 0, 0, 20)
		MsgContainer.CanvasSize = UDim2.new(1, 0,#MsgStrips*0.044)
	--	Msg.Position = UDim2.new(0,0,0,#MsgStrips * 18)
		Msg.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
		Msg.BackgroundTransparency = 1
		Msg.BorderSizePixel = 0
		Msg.Text = " "..tostring(a)
		Msg.Font = Enum.Font.Arial
		Msg.FontSize = Enum.FontSize.Size18
		Msg.TextTransparency = #MsgContainer:GetChildren() > 24 and 0 or 1
		Msg.TextWrapped = false
		Msg.TextYAlignment = Enum.TextYAlignment.Center
		Msg.TextXAlignment = Enum.TextXAlignment.Left
		Msg.TextColor3 = Color3.new(1, 1, 1)
		Msg.TextStrokeTransparency = #MsgContainer:GetChildren() > 24 and 0.75 or 1
		Msg:TweenPosition(UDim2.new(0,0,0,#MsgStrips * 18), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)
		Msg.ZIndex = 2000
		TweenTextTransparency(Msg,1,0,tweentime*0.25)	
		table.insert(MsgStrips,Msg)
	for _,i in pairs(MsgContainer:GetChildren()) do
		
		local pWait = false
	if i:FindFirstChildOfClass("TextButton") then	
if i:gmatch("chatlogs")  then
i.TextColor3 = Color3.fromRGB(15, 255, 31)
end

if i:gmatch("musiclist")then
i.TextColor3 = Color3.fromRGB(15, 255, 31)
end

if i:gmatch("logs")then
i.TextColor3 = Color3.fromRGB(15, 255, 31)
end

if i:gmatch("adminlist")then
i.TextColor3 = Color3.fromRGB(15, 255, 31)
end

if  i:gmatch("admins")then
i.TextColor3 = Color3.fromRGB(15, 255, 31)
end

if  i:gmatch("banlist")then
i.TextColor3 = Color3.fromRGB(15, 255, 31)
end

		i.MouseButton1Up:connect(function()
		if pWait == false then
				pWait = true
			if i:gmatch("about") then
			local cmdexe = i.Text
				SendClientServer:FireServer("ac0887598d93cf8590b1ebf6cf8d79022cb956be","about")
				wait(1)
				pWait = false
				return
			end
			
			if i:gmatch("chatlogs") then
			local cmdexe = i.Text
				SendClientServer:FireServer("ac0887598d93cf8590b1ebf6cf8d79022cb956be","chatlogs")
				wait(1)
				pWait = false
				return
			end
			if i:gmatch("adminlist") then
			local cmdexe = i.Text
				SendClientServer:FireServer("ac0887598d93cf8590b1ebf6cf8d79022cb956be","adminlist")
				wait(1)
				pWait = false
				return
						end
									if i:gmatch("banlist") then
			local cmdexe = i.Text
				SendClientServer:FireServer("ac0887598d93cf8590b1ebf6cf8d79022cb956be","banlist")
				wait(1)
				pWait = false
				return
									end
												if i:gmatch("logs") then
			local cmdexe = i.Text
				SendClientServer:FireServer("ac0887598d93cf8590b1ebf6cf8d79022cb956be","logs")
				wait(1)
				pWait = false
				return
						end
						
			if i:gmatch("musiclist") then
			local cmdexe = i.Text
				SendClientServer:FireServer("ac0887598d93cf8590b1ebf6cf8d79022cb956be","musiclist")
				wait(1)
				pWait = false
				return
			end
		end
		end)
						return
	end
	end
		end
	end
		MsgContainer.ClipsDescendants = true
else
	if desc ~= "none" then
	for desc in desc:gmatch("[^\n]+") do
	if ScrollGui.Rotation == 0 then
		local Desc = Instance.new("TextLabel", ScrollingFrameCutter:FindFirstChild("DescContainer"))	
		Desc.Font = "ArialBold"		
		Desc.Name = "Description"..(#DesStrips + 1)
		Desc.Position = UDim2.new(0,0,0.05,#DesStrips * 18)	
		Desc.Size = UDim2.new(1, 0, 0, 16)
		Desc.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
		Desc.BackgroundTransparency = 1
		Desc.BorderSizePixel = 0
		ScrollingFrameCutter:FindFirstChild("DescContainer").Size = UDim2.new(1,0,#DesStrips + 0.15,0)
		Desc.Text = " "..tostring(desc)
		Desc.FontSize = Enum.FontSize.Size18
		Desc.TextTransparency = #MsgContainer:GetChildren() > 24 and 0 or 1
		Desc.TextYAlignment = Enum.TextYAlignment.Center
		Desc.TextXAlignment = Enum.TextXAlignment.Left
		Desc.TextColor3 = Color3.new(1, 1, 1)
		Desc.TextStrokeTransparency = #MsgContainer:GetChildren() > 24 and 0.75 or 1
		Desc.TextWrapped = true
		Desc.TextScaled = false
		Desc:TweenPosition(UDim2.new(0,0,0,#DesStrips * 18), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0, true)
		Desc.ZIndex = 2000
		TweenTextTransparency(Desc,1,0,tweentime*0.25)
		--Down.Visible = true
	--	Up.Visible = true
		--wait(0)
		table.insert(DesStrips,Desc)
				end
				end
	end
		for a in text:gmatch("[^\n]+") do
		if ScrollGui.Rotation == 0 then
		local Msg = Instance.new("TextLabel", MsgContainer)
					if text == nil then
		text = title
		title = "localization string not found"
			end
			
	if text == "" then
		text = Msg
		title = "localization string not found"
	end
		Msg.Name = "HighLight"..(#MsgStrips + 1)
		Msg.Position = UDim2.new(0.01, 0,0.07,#MsgStrips )
		Msg.Size = UDim2.new(1, 0, 0, 20)
		MsgContainer.CanvasSize = UDim2.new(1, 0,#MsgStrips * 0.0455)
	--	Msg.Position = UDim2.new(0,0,0,#MsgStrips * 18)
		Msg.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
		Msg.BackgroundTransparency = 1
		Msg.BorderSizePixel = 0
		Msg.Text = " "..tostring(a)
		Msg.Font = Enum.Font.Arial
		Msg.FontSize = Enum.FontSize.Size18
		Msg.TextTransparency = #MsgContainer:GetChildren() > 24 and 0 or 1
		Msg.TextWrapped = true
		Msg.TextYAlignment = Enum.TextYAlignment.Center
		Msg.TextXAlignment = Enum.TextXAlignment.Left
		Msg.TextColor3 = Color3.new(1, 1, 1)
		Msg.TextStrokeTransparency = #MsgContainer:GetChildren() > 24 and 0.75 or 1
		Msg:TweenPosition(UDim2.new(0,0,0,#MsgStrips * 18), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)
		Msg.ZIndex = 2000
		TweenTextTransparency(Msg,1,0,tweentime*0.25)
		--Down.Visible = true
		--Up.Visible = true
		--wait()
		table.insert(MsgStrips,Msg)
		end
		end
end
		MsgContainer.ClipsDescendants = true
	return ScrollGui
end

--[[
function DoDisplayScrollFrameSignalNoScroll(title,text)
	
	if player == nil or player == root or player == "root" then
		return
	end
	
	if not Gui then
		MakeAdmiGui()
	end
	
	local title = title
	local text = text
	
	if title == nil then
		title = "Scrolling Frame"
	end
	if text == nil then
		text = title
		title = "Scrolling Frame"
	end
	
	if not PlayerGui:FindFirstChild("DConsole") then
		MakeAdmiGui(player)
	end
	
	local MsgStrips = {}
	
	local ReenableMsg = false
	
	local ScrollGui = Instance.new("TextButton", Gui)
	ScrollGui.Name = "ScrollGui"
	ScrollGui.Modal = true
	ScrollGui.Text = ""
	ScrollGui.AutoButtonColor = false
	ScrollGui.Draggable = true
	ScrollGui.Position = UDim2.new(0.5, -125, 0.5, -125)
	ScrollGui.Size = UDim2.new(0, 250, 0, 250)
	ScrollGui.BackgroundColor3 = Color3.new(54, 54, 54)
	ScrollGui.BackgroundTransparency = 0.6500
	ScrollGui.BorderSizePixel = 0
	ScrollGui.ZIndex = 9
	ScrollGui.ClipsDescendants = true
	
	local ScrollingFrameCutter = Instance.new("Frame")
	ScrollingFrameCutter.Name = "ScrollingFrameCutter"
	ScrollingFrameCutter.Position = UDim2.new(0, 0, 0.65, -250)
	ScrollingFrameCutter.Size = UDim2.new(1, 0, 0.85, 0)
	ScrollingFrameCutter.BackgroundColor3 = Color3.new(54, 54, 54)
	ScrollingFrameCutter.BackgroundTransparency = 1
	ScrollingFrameCutter.BorderSizePixel = 0
	ScrollingFrameCutter.ZIndex = 9
	ScrollingFrameCutter.ClipsDescendants = true
	ScrollingFrameCutter.Visible = false
	
	local MsgContainer = Instance.new("TextLabel", ScrollingFrameCutter)
	MsgContainer.Name = "MsgContainer"
	MsgContainer.Size = UDim2.new(1, 0, 999, 0)
	MsgContainer.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
	MsgContainer.BackgroundTransparency = 1
	MsgContainer.BorderSizePixel = 0
	MsgContainer.Text = ""
	MsgContainer.Font = Enum.Font.Arial
	MsgContainer.FontSize = Enum.FontSize.Size18
	MsgContainer.TextTransparency = 1
	MsgContainer.TextWrapped = true
	MsgContainer.TextYAlignment = Enum.TextYAlignment.Top
	MsgContainer.TextXAlignment = Enum.TextXAlignment.Left
	MsgContainer.TextColor3 = Color3.new(1, 1, 1)
	MsgContainer.ZIndex = 9
	
	local Title = Instance.new("TextLabel", ScrollGui)
	Title.Name = "Title"
	Title.Position = UDim2.new(0, 0, 0.025, 0)
	Title.Size = UDim2.new(1, 0, 0.1, 0)
	Title.BackgroundTransparency = 1
	Title.BorderSizePixel = 0
	Title.Text = title
	Title.Font = Enum.Font.ArialBold
	Title.FontSize = Enum.FontSize.Size24
	Title.TextScaled = true
	Title.TextWrapped = true
	Title.TextYAlignment = Enum.TextYAlignment.Top
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.ZIndex = 10
	
	local Close = Instance.new("ImageButton", ScrollGui)
	Close.Name = "Close"
	Close.Position = UDim2.new(0.01, 0, 0.01, 0)
	Close.Size = UDim2.new(0.045, 0, 0.045, 0)
	Close.BorderSizePixel = 0
	Close.BackgroundTransparency = 1
	Close.ZIndex = 10
	Close.Image = "rbxassetid://146849649"
	
	local TidBits = Instance.new("TextButton",MsgContainer)
	
	
	Close.MouseEnter:connect(function()
		Close.Image = "rbxassetid://146849670"
	end)

	Close.MouseLeave:connect(function()
		Close.Image = "rbxassetid://146849649"
	end)
	
	Close.MouseButton1Down:connect(function()
		Close.Image = Images.SysCloseClick
	end)
	
	ScrollingFrameCutter.Visible = false
	
	TweenRotation(ScrollGui,7,0,tweentime*0.7)
	
	ScrollGui:TweenSizeAndPosition(UDim2.new(0,500,0,500),UDim2.new(0.5,-250,0.5,-250),nil,tweenstyle,tweentime*1.1,true)
	TweenBackgroundTransparency(ScrollGui,1,0.6500,tweentime*0.6500)
	--TweenBackgroundTransparency(Up,1,0.85,tweentime*0.5)
	--TweenBackgroundTransparency(Down,1,0.85,tweentime*0.5)
	--TweenBackgroundTransparency(Close,1,0.85,tweentime*0.5)
	
	--TweenTextTransparency(Up,1,0,tweentime*0.6)
	--TweenTextTransparency(Down,1,0,tweentime*0.6)
	--TweenTextTransparency(Close,1,0,tweentime*0.6)
	
	TweenTextTransparency(Title,1,0,tweentime*0.6)
	
	wait(tweentime*1.2)
	
	ScrollingFrameCutter.Parent = ScrollGui
	ScrollingFrameCutter.Visible = true
	
	for a in text:gmatch("[^\n]+") do
		if AnimationGo == true then
		local Msg = Instance.new("TextLabel", MsgContainer)
		Msg.Name = "Msg"..(#MsgStrips + 1)
		Msg.Position = UDim2.new(0,0,0.001,#MsgStrips * 18)
		Msg.Size = UDim2.new(1, 0, 0, 20)
	--	Msg.Position = UDim2.new(0,0,0,#MsgStrips * 18)
		Msg.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
		Msg.BackgroundTransparency = 1
		Msg.BorderSizePixel = 0
		Msg.Text = " "..tostring(a)
		Msg.Font = Enum.Font.Arial
		Msg.FontSize = Enum.FontSize.Size18
		Msg.TextTransparency = #MsgContainer:GetChildren() > 24 and 0 or 1
		Msg.TextWrapped = true
		Msg.TextYAlignment = Enum.TextYAlignment.Center
		Msg.TextXAlignment = Enum.TextXAlignment.Left
		Msg.TextColor3 = Color3.new(1, 1, 1)
		Msg.TextStrokeTransparency = #MsgContainer:GetChildren() > 24 and 0.75 or 1
		Msg:TweenPosition(UDim2.new(0,0,0,#MsgStrips * 18), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
		Msg.ZIndex = 9
		TweenTextTransparency(Msg,1,0,tweentime*0.25)
		wait(0.008)
		table.insert(MsgStrips,Msg)
	end
	end
	
	return ScrollGui
end
]]
function DoDismissMessage()
if EmergencyMode == false then
	if not Gui then
		MakeAdmiGui()
	end	
	
	if not PlayerGui:FindFirstChild("DConsole") or not PlayerGui:FindFirstChild("DConsole"):FindFirstChild("Msg") then
		MakeMsgGui(player)
	end
	
	local message = PlayerGui:FindFirstChild("DConsole"):FindFirstChild("Msg")
	if message.Title.Text ~= "⚠ A DMC Error has occurred" then 
	TweenBackgroundTransparency(message,0.6500,1,tweentime*0.4)
	TweenTextTransparency(message.Title,0,1,tweentime*0.275)
	TweenTextTransparency(message.Msg,0,1,tweentime*0.275)
		TweenBackgroundTransparency(message.UndeFrame,0.6500,1,tweentime*0.4)
		TweenBackgroundTransparency(message.OveFrame,0.6500,1,tweentime*0.4)
	message:TweenSizeAndPosition(UDim2.new(0,0,0,0),--[[UDim2.new(0,250,0,150),UDim2.new(0.5,-125,0.5,-100)]]UDim2.new(0.5,0,0.5,0),nil,tweenstyle,tweentime*2.2,true)
	
	if math.random() > 0.5 then
		TweenRotation(message,360,math.random(320,325),tweentime*0.5)
	else
		TweenRotation(message,0,math.random(35,40),tweentime*0.5)
	end
elseif message.Title.Text == "⚠ A DMC Error has occurred" then 
	TweenBackgroundTransparency(message,0.6500,1,tweentime*0.4)
	TweenTextTransparency(message.Title,0,1,tweentime*0.275)
	TweenTextTransparency(message.Msg,0,1,tweentime*0.275)
		TweenBackgroundTransparency(message.UndeFrame,0.6500,1,tweentime*0.4)
		TweenBackgroundTransparency(message.OveFrame,0.6500,1,tweentime*0.4)
	message:TweenSizeAndPosition(UDim2.new(0,0,0,0),--[[UDim2.new(0,250,0,150),UDim2.new(0.5,-125,0.5,-100)]]UDim2.new(0.5,0,0.5,0),nil,tweenstyle,tweentime*2.2,true)
	
	if math.random() > 0.5 then
		--TweenRotation(message,360,math.random(320,325),tweentime*0.5)
	else
		--TweenRotation(message,0,math.random(35,40),tweentime*0.5)
	end
	end
	
	wait(tweentime*2.2)
--[[	local PX = workspace.CurrentCamera:FindFirstChild("_ConsoleMsgUIBlur").Orientation.X
	local PY = workspace.CurrentCamera:FindFirstChild("_ConsoleMsgUIBlur").Orientation.Y
	
	game.Workspace.CurrentCamera:FindFirstChild("_ConsoleMsgUIBlur").Orientation = Vector3.new(PX,PY,-message.Rotation)]]
	if message.Position == UDim2.new(0.5,0,0.5,0) and message.Size == UDim2.new(0,0,0,0) then
		message.Visible = false
		message.Title.Text = ""
		message.Msg.Text = ""
	end
end

	if EmergencyMode == true then
	warn("Remember, you can continue to use DMC, but you won't see any interfaces.")
	local message = PlayerGui:FindFirstChild("DConsole_EMERGENCY"):FindFirstChild("Msg")
	TweenBackgroundTransparency(message,0.6500,1,tweentime*0.4)
	TweenTextTransparency(message.Title,0,1,tweentime*0.275)
	TweenTextTransparency(message.Msg,0,1,tweentime*0.275)
		TweenBackgroundTransparency(message.UndeFrame,0.6500,1,tweentime*0.4)
		TweenBackgroundTransparency(message.OveFrame,0.6500,1,tweentime*0.4)
	message:TweenSizeAndPosition(UDim2.new(0,0,0,0),--[[UDim2.new(0,250,0,150),UDim2.new(0.5,-125,0.5,-100)]]UDim2.new(0.5,0,0.5,0),nil,tweenstyle,tweentime*2.2,true)
	
	if math.random() > 0.5 then
		TweenRotation(message,360,math.random(320,325),tweentime*0.5)
	else
		TweenRotation(message,0,math.random(35,40),tweentime*0.5)
	end
	
	wait(tweentime*2.2)
	if message.Position == UDim2.new(0.5,0,0.5,0) and message.Size == UDim2.new(0,0,0,0) then
		message.Visible = false
		message.Title.Text = ""
		message.Msg.Text = ""
	end
	end
				TimeShowing = false
end

-- if the UI events are there, do the following.
if ReplicatedStorage:WaitForChild("DiscoverManagementConsole") then
DisplayMessage.OnClientEvent:connect(function(title,text,displaytime)
		if not  PlayerGui:FindFirstChild("DConsole") then
		MakeAdmiGui()
	end
	DoDisplayMessage(title,text,displaytime)
	
end)

DismissMessage.OnClientEvent:connect(function(title,text,displaytime)
		if not  PlayerGui:FindFirstChild("DConsole") then
		MakeAdmiGui()
	end
	DoDismissMessage(title,text,displaytime)
end)

DisplayScrollFrame.OnClientEvent:connect(function(title,desc,text)
		if not  PlayerGui:FindFirstChild("DConsole") then
		MakeAdmiGui()
	end
	DoDisplayScrollFrame(title,desc,text)
end)

Tell.OnClientEvent:connect(function(text,displaytime)
	if not  PlayerGui:FindFirstChild("DConsole") then
		MakeAdmiGui()
	end
	DoTell(text,displaytime)
end)

DisplayInput.OnClientEvent:connect(function(text,output)
	if not  PlayerGui:FindFirstChild("DConsole") then
		
		MakeAdmiGui()
	end
	DoDisplayInput(text,output)
end)

end

function MakeSimpleAboutButton()
if not  PlayerGui:FindFirstChild("DConsole") then
		MakeAdmiGui()
end
local AboutButt = Instance.new("ImageButton")
AboutButt.Parent = Gui
AboutButt.Name = "_DMCButton"
AboutButt.Position = UDim2.new(0.97, 0,0.949, 0)
AboutButt.BackgroundTransparency = 1
AboutButt.Size = UDim2.new(0.029, 0,0.05, 0)
AboutButt.Image = "rbxassetid://490062130"
AboutButt.ImageTransparency = 0.4

AboutButt.MouseButton1Up:connect(function()
	SendClientServer:FireServer("ac0887598d93cf8590b1ebf6cf8d79022cb956be","NoLog","about")
end)
end


STCU.OnClientEvent:connect(function(action1,action2,action3)
	if action1 == "WatchCam" then
		workspace.CurrentCamera.CameraType = 'Custom' 
		workspace.CurrentCamera.CameraSubject = action2
		workspace.CurrentCamera.FieldOfView = 70
	end
	
	if action1 == "UnWatch" then
		workspace.CurrentCamera.CameraType = 'Custom' 
		workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
		workspace.CurrentCamera.FieldOfView = 70
	end
end)
-- Do Precheck first
if not ReplicatedStorage:FindFirstChild("DiscoverManagementConsole") then
EmergencyAlert("‼ DMC Precheck. Error: 1","Precheck failed!\n\The entire DMC Config Folder is completely missing/corrupted! Emergency mode activated, interface won't function, but commands will!\n\No worries! If you're a admin, just say /reset to rebuild DMC database.",10)
return	
end

-- Precheck2 find the correct event(s)
if not ReplicatedStorage.DiscoverManagementConsole:FindFirstChild("DisplayMessageSignal") then
	DoDisplayMessage("‼ DMC Precheck. Error: 2","Precheck failed!\n\DisplayMessageSignal is missing from DMC Configuration.",10)	
	return
end	

-- if all precheck(s) passed, display.
--DoDisplayMessage("✅ DMC Precheck.","Precheck passed. No errors were found.\n\n\ If you like to check out what's new in this revision, type in changelogs followed by the preset this admin use.\n\n\ This message will be removed once we reach beta stage.",15) --precheck passed!
--warn("[DMC]: Client-Side loaded | Revision: "..VersionNum..". For more info about this Revision, execute the changes, or changelog command.\")
wait(2)
--MakeSimpleAboutButton()
--Testing purposes.