local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local mouse = localPlayer:GetMouse()
local camera = workspace.CurrentCamera
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

--- FADED DIAMOND BACKGROUND ---
local backgroundDiamond = Instance.new("ImageLabel")
backgroundDiamond.Name = "BackgroundDiamond"
backgroundDiamond.Size = UDim2.new(0.7, 0, 0.7, 0)
backgroundDiamond.Position = UDim2.new(0.5, 0, 0.5, 25) 
backgroundDiamond.AnchorPoint = Vector2.new(0.5, 0.5)
backgroundDiamond.BackgroundTransparency = 1
backgroundDiamond.Image = "rbxassetid://6034287525"
backgroundDiamond.ImageTransparency = 0.85 
backgroundDiamond.ZIndex = 0 
backgroundDiamond.Parent = mainFrame

local dragBar = Instance.new("Frame")
dragBar.Name = "DragBar"
dragBar.Size = UDim2.new(1, 0, 0, 50)
dragBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
dragBar.BorderSizePixel = 0
dragBar.ZIndex = 2
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
titleText.ZIndex = 2
titleText.Parent = dragBar

local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -20, 1, -65)
contentFrame.Position = UDim2.new(0, 10, 0, 60)
contentFrame.BackgroundTransparency = 1
contentFrame.ZIndex = 2
contentFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = contentFrame

--- FLING BUTTON SETUP ---
local visorButton = Instance.new("TextButton")
visorButton.Name = "VisorButton"
visorButton.Size = UDim2.new(1, 0, 0, 38)
visorButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
visorButton.BorderSizePixel = 0
visorButton.Text = "UN fling(might bug)"
visorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
visorButton.TextSize = 22
visorButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
visorButton.ZIndex = 2
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
visorText.Text = "V=UN fling"
visorText.TextColor3 = Color3.fromRGB(255, 75, 75)
visorText.TextSize = 20
visorText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
visorText.Parent = visorMenu

--- MAGNET BUTTON SETUP ---
local magnetButton = Instance.new("TextButton")
magnetButton.Name = "MagnetButton"
magnetButton.Size = UDim2.new(1, 0, 0, 38)
magnetButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
magnetButton.BorderSizePixel = 0
magnetButton.Text = "Item Magnet"
magnetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
magnetButton.TextSize = 22
magnetButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
magnetButton.ZIndex = 2
magnetButton.Parent = contentFrame

local magnetMenu = Instance.new("Frame")
magnetMenu.Name = "MagnetMenu"
magnetMenu.Size = UDim2.new(0, 140, 0, 35)
magnetMenu.Position = UDim2.new(0, 25, 1, -100)
magnetMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
magnetMenu.BorderSizePixel = 0
magnetMenu.Visible = false
magnetMenu.Parent = screenGui

local magnetText = Instance.new("TextLabel")
magnetText.Name = "MagnetText"
magnetText.Size = UDim2.new(1, 0, 1, 0)
magnetText.BackgroundTransparency = 1
magnetText.Text = "T=Bring Items"
magnetText.TextColor3 = Color3.fromRGB(75, 175, 255)
magnetText.TextSize = 20
magnetText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
magnetText.Parent = magnetMenu

--- CHAIR OVERLOAD SETUP ---
local chairButton = Instance.new("TextButton")
chairButton.Name = "ChairButton"
chairButton.Size = UDim2.new(1, 0, 0, 38)
chairButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
chairButton.BorderSizePixel = 0
chairButton.Text = "Chair Overload"
chairButton.TextColor3 = Color3.fromRGB(255, 255, 255)
chairButton.TextSize = 22
chairButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
chairButton.ZIndex = 2
chairButton.Parent = contentFrame

local chairMenu = Instance.new("Frame")
chairMenu.Name = "ChairMenu"
chairMenu.Size = UDim2.new(0, 140, 0, 35)
chairMenu.Position = UDim2.new(0, 25, 1, -140)
chairMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
chairMenu.BorderSizePixel = 0
chairMenu.Visible = false
chairMenu.Parent = screenGui

local chairText = Instance.new("TextLabel")
chairText.Name = "ChairText"
chairText.Size = UDim2.new(1, 0, 1, 0)
chairText.BackgroundTransparency = 1
chairText.Text = "G=Chair Nearest"
chairText.TextColor3 = Color3.fromRGB(150, 255, 75)
chairText.TextSize = 20
chairText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
chairText.Parent = chairMenu

-- Top Left Tracker Box
local chairTracker = Instance.new("Frame")
chairTracker.Name = "ChairTracker"
chairTracker.Size = UDim2.new(0, 160, 0, 40)
chairTracker.Position = UDim2.new(0, 20, 0, 20)
chairTracker.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
chairTracker.BorderSizePixel = 0
chairTracker.Visible = false
chairTracker.Parent = screenGui

local chairTrackerCorner = Instance.new("UICorner")
chairTrackerCorner.CornerRadius = UDim.new(0, 6)
chairTrackerCorner.Parent = chairTracker

local chairTrackerText = Instance.new("TextLabel")
chairTrackerText.Name = "ChairTrackerText"
chairTrackerText.Size = UDim2.new(1, 0, 1, 0)
chairTrackerText.BackgroundTransparency = 1
chairTrackerText.Text = "Chairs found: 0"
chairTrackerText.TextColor3 = Color3.fromRGB(255, 215, 0)
chairTrackerText.TextSize = 18
chairTrackerText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
chairTrackerText.Parent = chairTracker


--- STATE VARIABLES ---
local visorActive = false
local flinging = false
local magnetActive = false
local chairActive = false
local foundChairs = {}

--- NETWORK OWNERSHIP BYPASS ---
RunService.Heartbeat:Connect(function()
	if magnetActive or flinging or chairActive then
		pcall(function()
			settings().Physics.AllowSleep = false
			if sethiddenproperty then
				sethiddenproperty(localPlayer, "SimulationRadius", math.huge)
			end
		end)
	end
end)

--- SHARED FUNCTIONS ---
local function getClosestPlayer(hrp)
	local target, shortDist = nil, math.huge
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= localPlayer and p.Character then
			local tHrp = p.Character:FindFirstChild("HumanoidRootPart")
			if tHrp then
				local dist = (hrp.Position - tHrp.Position).Magnitude
				if dist < shortDist then
					shortDist = dist
					target = p.Character
				end
			end
		end
	end
	return target
end

--- CHAIR FUNCTIONS ---
local function scanForChairs()
	foundChairs = {}
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Seat") or obj:IsA("VehicleSeat") then
			table.insert(foundChairs, obj)
		end
	end
	chairTrackerText.Text = "Chairs found: " .. #foundChairs
end

local function spawnChairAtClosest()
	if #foundChairs == 0 then return end
	
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	
	local targetChar = getClosestPlayer(hrp)
	if not targetChar then return end
	
	local targetPart = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Torso") or targetChar:FindFirstChild("UpperTorso")
	if not targetPart then return end
	
	local chair = table.remove(foundChairs)
	
	if chair and chair.Parent then
		for _, force in pairs(chair:GetChildren()) do
			if force:IsA("BodyMover") or force:IsA("Constraint") or force:IsA("AlignPosition") or force:IsA("Torque") then
				force:Destroy()
			end
		end
		
		chair.Anchored = false
		chair.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		chair.CanCollide = false
		
		-- Teleport directly onto the nearest player's torso
		chair.CFrame = targetPart.CFrame
		chair.AssemblyLinearVelocity = Vector3.zero
		chair.AssemblyAngularVelocity = Vector3.zero
		
		chairTrackerText.Text = "Chairs found: " .. #foundChairs
	else
		-- If the chair no longer exists, instantly try the next one in the list
		spawnChairAtClosest()
	end
end

--- BUTTON CLICKS ---
visorButton.MouseButton1Click:Connect(function()
	visorActive = not visorActive
	visorMenu.Visible = visorActive
	visorButton.BackgroundColor3 = visorActive and Color3.fromRGB(55, 55, 55) or Color3.fromRGB(35, 35, 35)
end)

magnetButton.MouseButton1Click:Connect(function()
	magnetActive = not magnetActive
	magnetMenu.Visible = magnetActive
	magnetButton.BackgroundColor3 = magnetActive and Color3.fromRGB(55, 55, 55) or Color3.fromRGB(35, 35, 35)
end)

chairButton.MouseButton1Click:Connect(function()
	chairActive = not chairActive
	chairMenu.Visible = chairActive
	chairTracker.Visible = chairActive
	chairButton.BackgroundColor3 = chairActive and Color3.fromRGB(55, 55, 55) or Color3.fromRGB(35, 35, 35)
	
	if chairActive then
		scanForChairs()
	end
end)

--- FLING / MAGNET FUNCTIONS ---
local function ghostFling()
	if flinging then return end
	
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
	if not hrp or not humanoid then return end
	
	local targetChar = getClosestPlayer(hrp)
	if not targetChar then return end
	
	local targetPart = targetChar:FindFirstChild("Torso") or targetChar:FindFirstChild("UpperTorso") or targetChar:FindFirstChild("HumanoidRootPart")
	if not targetPart then return end
	
	flinging = true
	
	local savedCFrame = hrp.CFrame
	local oldCameraType = camera.CameraType
	local oldCameraCFrame = camera.CFrame
	
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CFrame = oldCameraCFrame
	
	local selectionBox = Instance.new("SelectionBox")
	selectionBox.Name = "VisorTargetOutline"
	selectionBox.Color3 = Color3.fromRGB(255, 0, 0)
	selectionBox.LineThickness = 0.05
	selectionBox.Adornee = targetChar
	selectionBox.Parent = targetChar
	
	local startTime = tick()
	local duration = 0.6 
	
	local characterParts = {}
	for _, part in pairs(char:GetDescendants()) do
		if part:IsA("BasePart") then
			table.insert(characterParts, part)
		end
	end
	
	local loop
	loop = RunService.Stepped:Connect(function()
		local elapsed = tick() - startTime
		
		if elapsed > duration or not targetPart or not targetPart.Parent or not char or not hrp then
			loop:Disconnect()
			if selectionBox then selectionBox:Destroy() end
			
			hrp.AssemblyLinearVelocity = Vector3.zero
			hrp.AssemblyAngularVelocity = Vector3.zero
			hrp.CFrame = savedCFrame 
			
			humanoid:ChangeState(Enum.HumanoidStateType.Running)
			camera.CameraType = oldCameraType
			camera.CameraSubject = humanoid
			
			flinging = false
			return
		end
		
		for _, part in ipairs(characterParts) do
			part.CanCollide = false
		end
		
		hrp.CFrame = targetPart.CFrame
		hrp.AssemblyLinearVelocity = Vector3.zero
		hrp.AssemblyAngularVelocity = Vector3.new(0, 99999, 0)
	end)
end

local function magnetItems()
	local targetPos = mouse.Hit.Position
	if not targetPos then return end
	
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and not obj.Anchored then
			local parentModel = obj:FindFirstAncestorOfClass("Model")
			if parentModel and parentModel:FindFirstChildWhichIsA("Humanoid") then
				continue
			end
			
			for _, force in pairs(obj:GetChildren()) do
				if force:IsA("BodyMover") or force:IsA("Constraint") or force:IsA("AlignPosition") or force:IsA("Torque") then
					force:Destroy()
				end
			end
			
			obj.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
			obj.CanCollide = false
			
			local randomOffset = Vector3.new(math.random(-4, 4), math.random(1, 6), math.random(-4, 4))
			obj.CFrame = CFrame.new(targetPos + randomOffset)
			
			obj.AssemblyLinearVelocity = Vector3.zero
			obj.AssemblyAngularVelocity = Vector3.zero
		end
	end
end

--- KEYBINDS ---
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	
	if visorActive and input.KeyCode == Enum.KeyCode.V then
		ghostFling()
	elseif magnetActive and input.KeyCode == Enum.KeyCode.T then
		magnetItems()
	elseif chairActive and input.KeyCode == Enum.KeyCode.G then
		spawnChairAtClosest()
	end
end)

--- Smooth UI Dragging ---
local dragging = false
local dragStart, startPos

dragBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(
			startPos.X.Scale, 
			startPos.X.Offset + delta.X, 
			startPos.Y.Scale, 
			startPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)
