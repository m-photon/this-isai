local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local targetParent = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or localPlayer:WaitForChild("PlayerGui")

-- Forcefully delete any existing menus to prevent old ones from getting stuck
for _, gui in pairs(targetParent:GetChildren()) do
	if gui.Name == "nos_dywll_PrivateMenu" then
		gui:Destroy()
	end
end

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

-- BUTTON TEXT IS SET HERE
local visorButton = Instance.new("TextButton")
visorButton.Name = "VisorButton"
visorButton.Size = UDim2.new(1, 0, 0, 38)
visorButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
visorButton.BorderSizePixel = 0
visorButton.Text = "UN fling(might bug)"
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
visorText.Text = "V=UN fling"
visorText.TextColor3 = Color3.fromRGB(255, 75, 75)
visorText.TextSize = 20
visorText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
visorText.Parent = visorMenu

local visorActive = false
local flinging = false

visorButton.MouseButton1Click:Connect(function()
	visorActive = not visorActive
	visorMenu.Visible = visorActive
	visorButton.BackgroundColor3 = visorActive and Color3.fromRGB(55, 55, 55) or Color3.fromRGB(35, 35, 35)
end)

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
	
	-- Save original state
	local savedCFrame = hrp.CFrame
	local oldCameraType = camera.CameraType
	local oldCameraCFrame = camera.CFrame
	
	-- Detach camera so your screen doesn't spin wildly
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CFrame = oldCameraCFrame
	
	local selectionBox = Instance.new("SelectionBox")
	selectionBox.Name = "VisorTargetOutline"
	selectionBox.Color3 = Color3.fromRGB(255, 0, 0)
	selectionBox.LineThickness = 0.05
	selectionBox.Adornee = targetChar
	selectionBox.Parent = targetChar
	
	local startTime = tick()
	local duration = 0.6 -- Short and aggressive
	
	-- Pre-collect parts for optimization
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
			
			-- Restore character and camera cleanly
			hrp.AssemblyLinearVelocity = Vector3.zero
			hrp.AssemblyAngularVelocity = Vector3.zero
			hrp.CFrame = savedCFrame 
			
			humanoid:ChangeState(Enum.HumanoidStateType.Running)
			camera.CameraType = oldCameraType
			camera.CameraSubject = humanoid
			
			flinging = false
			return
		end
		
		-- Ghost mode: Turn off collisions so you don't get stuck on the map
		for _, part in ipairs(characterParts) do
			part.CanCollide = false
		end
		
		-- The actual FE Fling mechanism
		hrp.CFrame = targetPart.CFrame
		hrp.AssemblyLinearVelocity = Vector3.zero
		hrp.AssemblyAngularVelocity = Vector3.new(0, 99999, 0)
	end)
end

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if visorActive and input.KeyCode == Enum.KeyCode.V then
		ghostFling()
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
