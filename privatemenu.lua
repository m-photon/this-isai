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

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = mainFrame

local dragBar = Instance.new("Frame")
dragBar.Name = "DragBar"
dragBar.Size = UDim2.new(1, 0, 0, 50)
dragBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
dragBar.BorderSizePixel = 0
dragBar.Parent = mainFrame

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 8)
barCorner.Parent = dragBar

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
visorButton.Text = "Visor"
visorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
visorButton.Font = Enum.Font.GothamBold
visorButton.TextSize = 14
visorButton.Parent = contentFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = visorButton

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
visorText.Text = "V=kill nearby"
visorText.TextColor3 = Color3.fromRGB(255, 75, 75)
visorText.Font = Enum.Font.GothamBold
visorText.TextSize = 14
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

local function fling()
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
	humanoid.PlatformStand = true
	
	-- Strict property assignment sequence to block default cyan rendering
	local hl = Instance.new("Highlight")
	hl.Name = "VisorTargetHighlight"
	hl.Adornee = targetChar
	hl.FillColor = Color3.fromRGB(255, 0, 0)
	hl.OutlineColor = Color3.fromRGB(255, 0, 0)
	hl.FillTransparency = 1
	hl.OutlineTransparency = 0
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = targetChar
	
	local camera = workspace.CurrentCamera
	local savedCFrame = hrp.CFrame
	local rootJoint = hrp:FindFirstChild("RootJoint") or char:FindFirstChild("RootJoint", true) or (char:FindFirstChild("LowerTorso") and char.LowerTorso:FindFirstChild("Root"))
	local originalC0 = rootJoint and rootJoint.C0
	
	local startTime = tick()
	local travelTime = 0.1  -- Fast gap closer
	local duration = 0.35  -- Total time before controls hand back to you
	
	local function resetPhysics()
		if not char then return end
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				pcall(function()
					part.Velocity = Vector3.zero
					part.RotVelocity = Vector3.zero
					part.AssemblyLinearVelocity = Vector3.zero
					part.AssemblyAngularVelocity = Vector3.zero
				end)
			end
		end
	end
	
	local loop
	loop = RunService.Heartbeat:Connect(function()
		local elapsed = tick() - startTime
		
		if elapsed > duration or not targetPart or not targetPart.Parent or not char or not hrp or not rootJoint then
			loop:Disconnect()
			if hl then hl:Destroy() end
			
			if rootJoint and originalC0 then rootJoint.C0 = originalC0 end
			
			resetPhysics()
			if camera and humanoid then camera.CameraSubject = humanoid end
			
			-- Instant physics release so you don't stick or freeze
			humanoid.PlatformStand = false
			humanoid:ChangeState(Enum.HumanoidStateType.Running)
			flinging = false
			return
		end
		
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
		
		local targetPos = targetPart.Position
		local currentPos = elapsed < travelTime and savedCFrame.Position:Lerp(targetPos, elapsed / travelTime) or (targetPos + Vector3.new(0, 0.05, 0))
		
		hrp.CFrame = CFrame.new(currentPos) * savedCFrame.Rotation
		
		pcall(function()
			hrp.AssemblyLinearVelocity = Vector3.new(99999, 99999, 99999)
			hrp.AssemblyAngularVelocity = Vector3.new(15000, 15000, 15000)
		end)
		
		-- Keeps visual body in skybox tracking directly over the target
		rootJoint.C0 = CFrame.new(0, 2000, 0) * originalC0
	end)
end

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if visorActive and input.KeyCode == Enum.KeyCode.V then
		fling()
	end
end)

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
