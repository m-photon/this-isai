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

-- Main Window (Sharp Rectangular Style)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 240)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -120)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.ZIndex = 1
mainFrame.Parent = screenGui

-- Top Drag Bar
local dragBar = Instance.new("Frame")
dragBar.Name = "DragBar"
dragBar.Size = UDim2.new(1, 0, 0, 50)
dragBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
dragBar.BorderSizePixel = 0
dragBar.ZIndex = 2
dragBar.Parent = mainFrame

-- Title text (Fixed using RichText italics to prevent crashes)
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleLabel"
titleText.Size = UDim2.new(1, -20, 1, 0)
titleText.Position = UDim2.new(0, 12, 0, 0)
titleText.BackgroundTransparency = 1
titleText.RichText = true 
titleText.Text = '<i><font color="#FFD700">nos_dywyll\'s</font>\nPrivate menu</i>'
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 14
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.TextYAlignment = Enum.TextYAlignment.Center
titleText.LineHeight = 1.1
titleText.ZIndex = 3
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

-- Menu Button (Fixed with RichText italics)
local visorButton = Instance.new("TextButton")
visorButton.Name = "VisorButton"
visorButton.Size = UDim2.new(1, 0, 0, 38)
visorButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
visorButton.BorderSizePixel = 0
visorButton.RichText = true
visorButton.Text = "<i>Visor</i>"
visorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
visorButton.Font = Enum.Font.GothamBold
visorButton.TextSize = 14
visorButton.ZIndex = 3
visorButton.Parent = contentFrame

-- Status Box
local visorMenu = Instance.new("Frame")
visorMenu.Name = "VisorMenu"
visorMenu.Size = UDim2.new(0, 140, 0, 35)
visorMenu.Position = UDim2.new(0, 25, 1, -60)
visorMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
visorMenu.BorderSizePixel = 0
visorMenu.Visible = false
visorMenu.ZIndex = 2
visorMenu.Parent = screenGui

local visorText = Instance.new("TextLabel")
visorText.Name = "VisorText"
visorText.Size = UDim2.new(1, 0, 1, 0)
visorText.BackgroundTransparency = 1
visorText.RichText = true
visorText.Text = "<i>V=kill nearby</i>"
visorText.TextColor3 = Color3.fromRGB(255, 75, 75)
visorText.Font = Enum.Font.GothamBold
visorText.TextSize = 14
visorText.ZIndex = 3
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
	
	local selectionBox = Instance.new("SelectionBox")
	selectionBox.Name = "VisorTargetOutline"
	selectionBox.Color3 = Color3.fromRGB(255, 0, 0)
	selectionBox.LineThickness = 0.05
	selectionBox.Adornee = targetChar
	selectionBox.Parent = targetChar
	
	local savedCFrame = hrp.CFrame
	local rootJoint = hrp:FindFirstChild("RootJoint") or char:FindFirstChild("RootJoint", true) or (char:FindFirstChild("LowerTorso") and char.LowerTorso:FindFirstChild("Root"))
	local originalC0 = rootJoint and rootJoint.C0
	
	local startTime = tick()
	local duration = 0.4
	
	local loop
	loop = RunService.Stepped:Connect(function()
		local elapsed = tick() - startTime
		
		if elapsed > duration or not targetPart or not targetPart.Parent or not char or not hrp or not rootJoint then
			loop:Disconnect()
			if selectionBox then selectionBox:Destroy() end
			
			if rootJoint and originalC0 then rootJoint.C0 = originalC0 end
			
			hrp.AssemblyLinearVelocity = Vector3.zero
			hrp.AssemblyAngularVelocity = Vector3.zero
			
			humanoid.PlatformStand = false
			humanoid:ChangeState(Enum.HumanoidStateType.Running)
			flinging = false
			return
		end
		
		humanoid.PlatformStand = true
		
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
		
		hrp.CFrame = targetPart.CFrame
		
		hrp.AssemblyLinearVelocity = Vector3.new(99999, 99999, 99999)
		hrp.AssemblyAngularVelocity = Vector3.new(99999, 99999, 99999)
		
		rootJoint.C0 = CFrame.new(0, 50000, 0) * originalC0
	end)
end

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if visorActive and input.KeyCode == Enum.KeyCode.V then
		fling()
	end
end)

-- Dragging Engine
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
