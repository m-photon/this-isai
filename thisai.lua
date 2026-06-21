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
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -120) -- Center of screen
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
dragBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Sleek grey
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

-- 5. Main Content Area (For menu buttons)
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -20, 1, -65)
contentFrame.Position = UDim2.new(0, 10, 0, 60)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- UI List Layout to automatically arrange future buttons neatly
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

-- 7. Bottom-Left Mini Menu (Hidden by Default)
local visorMenu = Instance.new("Frame")
visorMenu.Name = "VisorMenu"
visorMenu.Size = UDim2.new(0, 140, 0, 35)
visorMenu.Position = UDim2.new(0, 25, 1, -60) -- Perfect fit for bottom left
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
visorText.TextColor3 = Color3.fromRGB(255, 75, 75) -- Soft red highlight
visorText.Font = Enum.Font.GothamBold
visorText.TextSize = 14
visorText.Parent = visorMenu


----------------------------------------------------------------
-- VISOR MENU TOGGLE & FLING SYSTEM (Extracted From Your Code)
----------------------------------------------------------------

local visorActive = false
local flinging = false

-- Toggle bottom left menu display when clicking Visor button
visorButton.MouseButton1Click:Connect(function()
	visorActive = not visorActive
	visorMenu.Visible = visorActive
	
	-- Tiny visual indicator change on main menu button
	if visorActive then
		visorButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	else
		visorButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	end
end)

-- The optimized standalone Fling script utilizing your exact settings
local function flingNearestPlayer()
	if flinging then return end
	
	local localPlayer = Players.LocalPlayer
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	
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
	
	-- Stop if no players are nearby
	if not targetCharacter then return end
	
	local targetPart = targetCharacter:FindFirstChild("Torso") or targetCharacter:FindFirstChild("UpperTorso") or targetCharacter:FindFirstChild("HumanoidRootPart")
	if not targetPart then return end
	
	flinging = true
	
	-- Setup the massive BodyAngularVelocity spin force from your script
	local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
	bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bodyAngularVelocity.P = 1000000000000000000000000000
	bodyAngularVelocity.AngularVelocity = Vector3.new(10000, 10000, 10000)
	bodyAngularVelocity.Parent = hrp
	
	local startTime = tick()
	local flingDuration = 1.5 -- Run fling tracking loop for 1.5 seconds
	
	-- Temporarily disable character parts collisions so you pass straight through them cleanly
	local oldCollisions = {}
	for _, part in pairs(char:GetChildren()) do
		if part:IsA("BasePart") then
			oldCollisions[part] = part.CanCollide
			part.CanCollide = false
		end
	end
	
	-- Aggressive fast physics update tracking loop
	local connection
	connection = RunService.Heartbeat:Connect(function()
		if tick() - startTime > flingDuration or not targetPart or not targetPart.Parent or not char or not hrp then
			-- Cleanup forces & restore player collision settings
			bodyAngularVelocity:Destroy()
			for part, canCollide in pairs(oldCollisions) do
				if part and part.Parent then
					part.CanCollide = canCollide
				end
			end
			connection:Disconnect()
			flinging = false
			return
		end
		
		-- Warp onto target and apply velocity vector changes to bypass network collision ownership rules
		hrp.CFrame = CFrame.new(targetPart.Position + Vector3.new(0, 0.2, 0))
		hrp.Velocity = Vector3.new(65, 65, 65)
	end)
end

-- Key listener for V key bind
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end -- Don't fire if player is typing in chat box
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
