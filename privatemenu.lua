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
backgroundDiamond.Size = UDim2.new(0.7, 0, 0.7, 0) -- Takes up 70% of the menu
backgroundDiamond.Position = UDim2.new(0.5, 0, 0.5, 25) -- Centered perfectly under the top bar
backgroundDiamond.AnchorPoint = Vector2.new(0.5, 0.5)
backgroundDiamond.BackgroundTransparency = 1
backgroundDiamond.Image = "rbxassetid://6034287525" -- Roblox Diamond Asset ID
backgroundDiamond.ImageTransparency = 0.85 -- Makes it faded/watermarked
backgroundDiamond.ZIndex = 0 -- Ensures it stays behind the buttons
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


--- STATE VARIABLES ---
local visorActive = false
local flinging = false
local magnetActive = false

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

--- FUNCTIONS ---
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
	local duration = 0.8 
	
	local characterParts = {}
	for _, part in pairs(char:GetDescendants()) do
		if part:IsA("BasePart") then
			table.insert(characterParts, part)
		end
	end
	
	humanoid.PlatformStand = true 
	
	local loop
	loop = RunService.Stepped:Connect(function()
		local elapsed = tick() - startTime
		
		if elapsed > duration or not targetPart or not targetPart.Parent or not char or not hrp then
			loop:Disconnect()
			if selectionBox then selectionBox:Destroy() end
			
			hrp.AssemblyLinearVelocity = Vector3.zero
			hrp.AssemblyAngularVelocity = Vector3.zero
			hrp.CFrame = savedCFrame 
			
			humanoid.PlatformStand = false
			humanoid:ChangeState(Enum.HumanoidStateType.Running)
			camera.CameraType = oldCameraType
			camera.CameraSubject = humanoid
			
			flinging = false
			return
		end
		
		for _, part in ipairs(characterParts) do
			part.CanCollide = false
		end
		
		local randomJitter = Vector3.new(math.random(-10, 10) / 100, math.random(-10, 10) / 100, math.random(-10, 10) / 100)
		hrp.CFrame = targetPart.CFrame * CFrame.new(randomJitter)
		
		hrp.AssemblyLinearVelocity = Vector3.new(99999, 99999, 99999)
		hrp.AssemblyAngularVelocity = Vector3.new(99999, 99999, 99999)
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
