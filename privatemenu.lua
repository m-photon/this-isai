-- Services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Determine the best parent (CoreGui for executors, PlayerGui as a fallback)
local targetParent
local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
if success and coreGui then
	targetParent = coreGui
else
	targetParent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- Anti-Duplicate: Destroy the old GUI if it's already running
local existingGui = targetParent:FindFirstChild("nos_dywll_PrivateMenu")
if existingGui then
	existingGui:Destroy()
end

-- 1. Create the ScreenGui container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "nos_dywll_PrivateMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = targetParent

-- 2. Create the Main Frame (Deep Black Window)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 240)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -120)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = mainFrame

-- 3. Create the Grey Drag Bar (Top Handle)
local dragBar = Instance.new("Frame")
dragBar.Name = "DragBar"
dragBar.Size = UDim2.new(1, 0, 0, 50)
dragBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
dragBar.BorderSizePixel = 0
dragBar.Parent = mainFrame

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 8)
barCorner.Parent = dragBar

-- 4. Custom Two-Line Title Text (With Yellow RichText Name)
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleLabel"
titleText.Size = UDim2.new(1, -20, 1, 0)
titleText.Position = UDim2.new(0, 12, 0, 0)
titleText.BackgroundTransparency = 1
titleText.RichText = true 
titleText.Text = '<font color="#FFD700">nos_dywyll\'s</font>\nPrivate menu'
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 14
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.TextYAlignment = Enum.TextYAlignment.Center
titleText.LineHeight = 1.1
titleText.Parent = dragBar

-- 5. Main Content Area
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

-- 6. Add "Visor" Button to Menu
local visorButton = Instance.new("TextButton")
visorButton.Name = "VisorButton"
visorButton.Size = UDim2.new(1, 0, 0, 38)
visorButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
visorButton.Text = "Visor"
visorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
visorButton.Font = Enum.Font.GothamBold
visorButton.TextSize = 14
visorButton.Parent = contentFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = visorButton

-- 7. Bottom-Left Mini Menu
local visorMenu = Instance.new("Frame")
visorMenu.Name = "VisorMenu"
visorMenu.Size = UDim2.new(0, 140, 0, 35)
visorMenu.Position = UDim2.new(0, 25, 1, -60)
visorMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
visorMenu.BorderSizePixel = 0
visorMenu.Visible = false
visorMenu.Parent = screenGui

local visorMenuCorner = Instance.new("UICorner")
visorMenuCorner.CornerRadius = UDim.new(0, 6)
visorMenuCorner.Parent = visorMenu

local visorText = Instance.new("TextLabel")
visorText.Name = "VisorText"
visorText.Size = UDim2.new(1, 0, 1, 0)
visorText.BackgroundTransparency = 1
visorText.Text = "V=kill neaby"
visorText.TextColor3 = Color3.fromRGB(255, 75, 75)
visorText.Font = Enum.Font.GothamBold
visorText.TextSize = 14
visorText.Parent = visorMenu


----------------------------------------------------------------
-- VISOR PROXY FLING (RED HIGHLIGHT & FIXED CAMERA SYSTEM)
----------------------------------------------------------------

local visorActive = false
local flinging = false

visorButton.MouseButton1Click:Connect(function()
	visorActive = not visorActive
	visorMenu.Visible = visorActive
	
	if visorActive then
		visorButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	else
		visorButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	end
end)

local function flingNearestPlayer()
	if flinging then return end
	
	local localPlayer = Players.LocalPlayer
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
	if not hrp or not humanoid then return end
	
	-- Find Nearest Target
	local targetCharacter = nil
	local shortestDistance = math.huge
	
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= localPlayer and p.Character then
			local targetHrp = p.Character:FindFirstChild("HumanoidRootPart")
			if targetHrp then
				local dist = (hrp.Position - targetHrp.Position).Magnitude
				if dist < shortestDistance then
					shortestDistance = dist
					targetCharacter = p.Character
				end
			end
		end
	end
	
	if not targetCharacter then return end
	
	local targetPart = targetCharacter:FindFirstChild("Torso") or targetCharacter:FindFirstChild("UpperTorso") or targetCharacter:FindFirstChild("HumanoidRootPart")
	if not targetPart then return end
	
	flinging = true
	
	-- STATE FIX: Disable the Humanoid balance system so it doesn't fight the extreme physics velocity
	humanoid.PlatformStand = true
	
	-- 1. Create and apply the Red Highlight onto the target character
	local targetHighlight = Instance.new("Highlight")
	targetHighlight.Name = "VisorTargetHighlight"
	targetHighlight.FillColor = Color3.fromRGB(255, 0, 0)
	targetHighlight.OutlineColor = Color3.fromRGB(255, 50, 50)
	targetHighlight.FillTransparency = 0.35
	targetHighlight.OutlineTransparency = 0
	targetHighlight.Parent = targetCharacter
	
	-- Automatically destroy the red highlight after exactly 0.5 seconds
	task.delay(0.5, function()
		if targetHighlight then
			targetHighlight:Destroy()
		end
	end)
	
	-- Camera Lock: Fixes camera focus onto your stationary Head
	local camera = workspace.CurrentCamera
	local staticPart = char:FindFirstChild("Head") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
	if camera and staticPart then
		camera.CameraSubject = staticPart
	end
	
	-- 2. Save original reference position data
	local savedCFrame = hrp.CFrame
	
	-- 3. Locate the main root joint dynamically
	local rootJoint = hrp:FindFirstChild("RootJoint") or char:FindFirstChild("RootJoint", true) or (char:FindFirstChild("LowerTorso") and char.LowerTorso:FindFirstChild("Root"))
	local originalC0 = rootJoint and rootJoint.C0
	
	-- 4. Set character collisions off
	local oldCollisions = {}
	for _, part in pairs(char:GetChildren()) do
		if part:IsA("BasePart") then
			oldCollisions[part] = part.CanCollide
			part.CanCollide = false
		end
	end
	
	-- 5. Attach hyper-spin velocity parameters onto the hidden RootPart
	local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
	bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bodyAngularVelocity.P = 1000000000000000000000000000
	bodyAngularVelocity.AngularVelocity = Vector3.new(15000, 15000, 15000)
	bodyAngularVelocity.Parent = hrp
	
	local startTime = tick()
	local travelDuration = 0.25 
	local totalDuration = 1.3  
	
	-- Quick function to wipe out all physics states on all body parts
	local function clearAllVelocity()
		if not hrp or not char then return end
		for _, part in pairs(char:GetChildren()) do
			if part:IsA("BasePart") then
				part.Velocity = Vector3.new(0, 0, 0)
				part.RotVelocity = Vector3.new(0, 0, 0)
				pcall(function()
					part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
				end)
			end
		end
	end
	
	local connection
	connection = RunService.Heartbeat:Connect(function()
		local elapsed = tick() - startTime
		
		-- Cleanup condition
		if elapsed > totalDuration or not targetPart or not targetPart.Parent or not char or not hrp or not rootJoint then
			
			-- Destroy forces immediately
			if bodyAngularVelocity then bodyAngularVelocity:Destroy() end
			if targetHighlight then targetHighlight:Destroy() end
			
			-- Hard anchor character to instantly kill running physics vectors
			hrp.Anchored = true
			
			-- Safely re-align visual limb matrices back to base operations
			if rootJoint and originalC0 then rootJoint.C0 = originalC0 end
			hrp.CFrame = savedCFrame
			
			-- Wipe velocities across all parts
			clearAllVelocity()
			
			-- Restore normal collisions
			for part, canCollide in pairs(oldCollisions) do
				if part and part.Parent then part.CanCollide = canCollide end
			end
			
			if camera and humanoid then camera.CameraSubject = humanoid end
			
			-- Allow physics step to completely register the position lock before letting go
			task.delay(0.1, function()
				if hrp and hrp.Parent and humanoid then
					clearAllVelocity()
					hrp.Anchored = false
					humanoid.PlatformStand = false
					humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) -- Force character back to normal standing physics
				end
			end)
			
			connection:Disconnect()
			flinging = false
			return
		end
		
		-- Track target positions
		local destination = targetPart.Position
		local currentPos
		
		if elapsed < travelDuration then
			local alpha = elapsed / travelDuration
			currentPos = savedCFrame.Position:Lerp(destination, alpha)
		else
			currentPos = destination + Vector3.new(0, 0.05, 0)
		end
		
		-- Invisible root hub tracks onto target to perform the physics crush fling
		hrp.CFrame = CFrame.new(currentPos) * savedCFrame.Rotation
		
		-- Maintain ultra high physics vectors to destroy the target's network ownership authority
		hrp.Velocity = Vector3.new(99999, 99999, 99999) 
		pcall(function()
			hrp.AssemblyLinearVelocity = Vector3.new(99999, 99999, 99999)
		end)
		
		-- Counter-Inverse Matrix: Keeps your visible body parts completely frozen at home base
		rootJoint.C0 = hrp.CFrame:Inverse() * savedCFrame * originalC0
	end)
end

-- Key bind listener
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if visorActive and input.KeyCode == Enum.KeyCode.V then
		flingNearestPlayer()
	end
end)


----------------------------------------------------------------
-- SMOOTH DRAGGING SYSTEM
----------------------------------------------------------------

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	mainFrame.Position = UDim2.new(
		startPos.X.Scale, 
		startPos.X.Offset + delta.X, 
		startPos.Y.Scale, 
		startPos.Y.Offset + delta.Y
	)
end

dragBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
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
		update(input)
	end
end)
