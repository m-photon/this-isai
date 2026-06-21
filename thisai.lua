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

-- 4. Custom Two-Line Title Text
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleLabel"
titleText.Size = UDim2.new(1, -20, 1, 0)
titleText.Position = UDim2.new(0, 12, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "nos_dywll's\nPrivate menu"
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
-- VISOR DETACHED PROXY FLING (LEG ANCHORED STABILIZATION)
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
	
	-- 1. Create the physical 3x3 Neon Block
	local proxyBlock = Instance.new("Part")
	proxyBlock.Size = Vector3.new(3, 3, 3)
	proxyBlock.Color = Color3.fromRGB(0, 255, 255)
	proxyBlock.Material = Enum.Material.Neon
	proxyBlock.CanCollide = false
	proxyBlock.Anchored = true
	proxyBlock.CFrame = hrp.CFrame
	proxyBlock.Parent = workspace
	
	-- 2. Save original position to return to later
	local savedCFrame = hrp.CFrame
	
	-- 3. Find and track your Joint motor (Handles R6 & R15 compatibility)
	local rootJoint = hrp:FindFirstChild("RootJoint")
	if not rootJoint and char:FindFirstChild("LowerTorso") then
		rootJoint = char.LowerTorso:FindFirstChild("Root")
	end
	
	-- 4. Anchor ONLY your feet and legs to the ground to act as an anchor
	local oldCollisions = {}
	local anchoredLegs = {}
	for _, part in pairs(char:GetChildren()) do
		if part:IsA("BasePart") then
			oldCollisions[part] = part.CanCollide
			part.CanCollide = false -- Keeps collisions off so the spinning root doesn't hit yourself
			
			-- Targets R6 and R15 leg/foot structures dynamically
			local partName = part.Name:lower()
			if partName:find("leg") or partName:find("foot") then
				anchoredLegs[part] = part.Anchored
				part.Anchored = true -- Firmly plants legs to the floor
			end
		end
	end
	
	-- 5. Disconnect the HumanoidRootPart joint invisibly
	if rootJoint then rootJoint.Enabled = false end
	
	-- 6. Inject the hyper-spin physics engine forces onto the invisible HumanoidRootPart
	local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
	bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bodyAngularVelocity.P = 1000000000000000000000000000
	bodyAngularVelocity.AngularVelocity = Vector3.new(10000, 10000, 10000)
	bodyAngularVelocity.Parent = hrp
	
	local startTime = tick()
	local travelDuration = 0.3 
	local totalDuration = 1.6  
	
	local connection
	connection = RunService.Heartbeat:Connect(function()
		local elapsed = tick() - startTime
		
		-- Cleanup condition
		if elapsed > totalDuration or not targetPart or not targetPart.Parent or not char or not hrp then
			
			-- Destroy proxy block and forces
			proxyBlock:Destroy()
			bodyAngularVelocity:Destroy()
			
			-- Teleport your hidden physics root back and weld your character back together seamlessly
			hrp.CFrame = savedCFrame
			hrp.Velocity = Vector3.new(0, 0, 0)
			if rootJoint then rootJoint.Enabled = true end
			
			-- Release legs from ground anchor and restore collisions
			for part, wasAnchored in pairs(anchoredLegs) do
				if part and part.Parent then part.Anchored = wasAnchored end
			end
			for part, canCollide in pairs(oldCollisions) do
				if part and part.Parent then part.CanCollide = canCollide end
			end
			
			connection:Disconnect()
			flinging = false
			return
		end
		
		-- Target Position Vector
		local destination = targetPart.Position
		local currentPos
		
		if elapsed < travelDuration then
			-- PHASE 1: Smoothly fly out from your body and travel over to the target player
			local alpha = elapsed / travelDuration
			currentPos = savedCFrame.Position:Lerp(destination, alpha)
		else
			-- PHASE 2: Lock onto the target aggressively to perform the physics crush fling
			currentPos = destination + Vector3.new(0, 0.1, 0)
		end
		
		-- Align both the visible 3x3 Block and your invisible spinning root together
		proxyBlock.CFrame = CFrame.new(currentPos)
		hrp.CFrame = CFrame.new(currentPos)
		hrp.Velocity = Vector3.new(75, 75, 75) 
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
