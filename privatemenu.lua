local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
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
visorButton.Text = "Move all un"
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
visorText.Text = "V=Item Swarm"
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

-- New function to scan the map for anything we can throw
local function getUnanchoredMapParts(targetChar)
	local mapParts = {}
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and not obj.Anchored then
			-- Ensure we don't grab our own body parts or the target's body parts
			local isOurs = localPlayer.Character and obj:IsDescendantOf(localPlayer.Character)
			local isTargets = targetChar and obj:IsDescendantOf(targetChar)
			
			if not isOurs and not isTargets then
				table.insert(mapParts, obj)
			end
		end
	end
	return mapParts
end

local function fling()
	if flinging then return end
	
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	
	local targetChar = getClosestPlayer(hrp)
	if not targetChar then return end
	
	local targetPart = targetChar:FindFirstChild("Torso") or targetChar:FindFirstChild("UpperTorso") or targetChar:FindFirstChild("HumanoidRootPart")
	if not targetPart then return end
	
	flinging = true
	
	local selectionBox = Instance.new("SelectionBox")
	selectionBox.Name = "VisorTargetOutline"
	selectionBox.Color3 = Color3.fromRGB(255, 0, 0)
	selectionBox.LineThickness = 0.05
	selectionBox.Adornee = targetChar
	selectionBox.Parent = targetChar
	
	-- Grab all unanchored parts currently in the workspace
	local unanchoredParts = getUnanchoredMapParts(targetChar)
	
	local startTime = tick()
	local duration = 1.5 -- Increased duration slightly so the items have time to do damage
	
	local loop
	loop = RunService.Stepped:Connect(function()
		local elapsed = tick() - startTime
		
		-- End the loop if time is up, the target died, or they left
		if elapsed > duration or not targetPart or not targetPart.Parent then
			loop:Disconnect()
			if selectionBox then selectionBox:Destroy() end
			flinging = false
			return
		end
		
		-- Continuously teleport all map items to the target and spin them rapidly
		for _, part in ipairs(unanchoredParts) do
			if part and part.Parent then
				part.CanCollide = false
				part.CFrame = targetPart.CFrame
				part.AssemblyLinearVelocity = Vector3.zero
				part.AssemblyAngularVelocity = Vector3.new(99999, 99999, 99999)
			end
		end
	end)
end

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if visorActive and input.KeyCode == Enum.KeyCode.V then
		fling()
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
