local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local mouse = localPlayer:GetMouse()
local targetParent = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or localPlayer:WaitForChild("PlayerGui")

local oldGui = targetParent:FindFirstChild("nos_dywll_PrivateMenu")
if oldGui then oldGui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "nos_dywll_PrivateMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = targetParent

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 240)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -120)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local dragBar = Instance.new("Frame")
dragBar.Name = "DragBar"
dragBar.Size = UDim2.new(1, 0, 0, 50)
dragBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
dragBar.BorderSizePixel = 0
dragBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleLabel"
titleText.Size = UDim2.new(1, -20, 1, 0)
titleText.Position = UDim2.new(0, 12, 0, 0)
titleText.BackgroundTransparency = 1
titleText.RichText = true 
titleText.Text = '<font color="#FFD700">nos_dywyll\'s</font>\nPrivate menu'
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 22
titleText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic)
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.TextYAlignment = Enum.TextYAlignment.Center
titleText.LineHeight = 1.1
titleText.Parent = dragBar

local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -20, 1, -65)
contentFrame.Position = UDim2.new(0, 10, 0, 60)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = contentFrame

local visorButton = Instance.new("TextButton")
visorButton.Name = "VisorButton"
visorButton.Size = UDim2.new(1, 0, 0, 38)
visorButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
visorButton.BorderSizePixel = 0
visorButton.Text = "Inspector (Global)"
visorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
visorButton.TextSize = 22
visorButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
visorButton.Parent = contentFrame

local visorMenu = Instance.new("Frame")
visorMenu.Name = "VisorMenu"
visorMenu.Size = UDim2.new(0, 140, 0, 35)
visorMenu.Position = UDim2.new(0, 25, 1, -60)
visorMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
visorMenu.BorderSizePixel = 0
visorMenu.Visible = false
visorMenu.Parent = screenGui

local visorText = Instance.new("TextLabel")
visorText.Name = "VisorText"
visorText.Size = UDim2.new(1, 0, 1, 0)
visorText.BackgroundTransparency = 1
visorText.Text = "V=pickup/letgo"
visorText.TextColor3 = Color3.fromRGB(75, 255, 255)
visorText.TextSize = 18
visorText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
visorText.Parent = visorMenu

-- Core Variables
local visorActive = false
local isHolding = false
local targetPart = nil
local physicsConnection = nil
local HOLD_DISTANCE = 15

-- [CRITICAL FE BYPASS]: Claims network ownership of distant map objects via executor properties
task.spawn(function()
	while task.wait() do
		pcall(function()
			settings().Physics.AllowSleep = false
			if sethiddenproperty then
				sethiddenproperty(localPlayer, "SimulationRadius", 9e9)
				sethiddenproperty(localPlayer, "MaxSimulationRadius", 9e9)
			end
		end)
	end
end)

local function dropObject()
	isHolding = false
	if physicsConnection then
		physicsConnection:Disconnect()
		physicsConnection = nil
	end
	
	if targetPart then
		pcall(function()
			targetPart.CanCollide = true
			targetPart.AssemblyLinearVelocity = Vector3.zero
			targetPart.AssemblyAngularVelocity = Vector3.zero
		end)
		targetPart = nil
	end
end

local function updateObjectPosition()
	if not targetPart or targetPart.Anchored or not targetPart:IsDescendantOf(workspace) then 
		dropObject()
		return 
	end
	
	local targetPosition = mouse.Hit.Position
	
	if mouse.Target == nil then
		local camera = workspace.CurrentCamera
		targetPosition = camera.CFrame.Position + (mouse.UnitRay.Direction * HOLD_DISTANCE)
	end
	
	-- Velocity + Position hybrid to force FE replication instantly
	local currentPos = targetPart.Position
	local direction = targetPosition - currentPos
	
	targetPart.AssemblyLinearVelocity = direction * 25
	targetPart.AssemblyAngularVelocity = Vector3.zero
end

local function pickupObject(part)
	isHolding = true
	targetPart = part
	targetPart.CanCollide = false
	
	physicsConnection = RunService.RenderStepped:Connect(updateObjectPosition)
end

-- [GLOBAL MAP SCANNER]: Constantly searches the entire workspace for unanchored parts closest to your mouse
local function getClosestUnanchoredPart()
	local closestPart = nil
	local shortestDistance = math.huge
	local mousePos = mouse.Hit.Position
	
	for _, part in ipairs(workspace:GetDescendants()) do
		if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(localPlayer.Character) then
			-- Calculate how close this map object is to your mouse cursor position
			local distance = (part.Position - mousePos).Magnitude
			if distance < shortestDistance then
				shortestDistance = distance
				closestPart = part
			end
		end
	end
	return closestPart
end

visorButton.MouseButton1Click:Connect(function()
	visorActive = not visorActive
	visorMenu.Visible = visorActive
	visorButton.BackgroundColor3 = visorActive and Color3.fromRGB(55, 55, 55) or Color3.fromRGB(35, 35, 35)
	
	if not visorActive and isHolding then
		dropObject()
	end
end)

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	
	if visorActive and input.KeyCode == Enum.KeyCode.V then
		if isHolding then
			dropObject()
		else
			local part = getClosestUnanchoredPart()
			if part then
				pickupObject(part)
			end
		end
	end
end)

-- UI Dragging System
local dragging, dragInput, dragStart, startPos

dragBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

dragBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
