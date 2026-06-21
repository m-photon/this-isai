local uis = game:GetService("UserInputService")
local plrs = game:GetService("Players")
local rs = game:GetService("RunService")

local lp = plrs.LocalPlayer
local mouse = lp:GetMouse()
local cam = workspace.CurrentCamera
local core = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or lp:WaitForChild("PlayerGui")

pcall(function() core:FindFirstChild("nos_dywll_PrivateMenu"):Destroy() end)

local sg = Instance.new("ScreenGui")
sg.Name = "nos_dywll_PrivateMenu"
sg.ResetOnSpawn = false
sg.Parent = core

--- MAIN MENU ---
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 350, 0, 240)
main.Position = UDim2.new(0.5, -175, 0.5, -120)
main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
main.BorderSizePixel = 0
main.Parent = sg

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(45, 45, 45)
stroke.Thickness = 1
stroke.Parent = main

local bgDiamond = Instance.new("ImageLabel")
bgDiamond.Size = UDim2.new(0.7, 0, 0.7, 0)
bgDiamond.Position = UDim2.new(0.5, 0, 0.5, 25) 
bgDiamond.AnchorPoint = Vector2.new(0.5, 0.5)
bgDiamond.BackgroundTransparency = 1
bgDiamond.Image = "rbxassetid://6034287525"
bgDiamond.ImageTransparency = 0.85 
bgDiamond.ZIndex = 0 
bgDiamond.Parent = main

--- TOP BAR ---
local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1, 0, 0, 45)
topbar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topbar.BorderSizePixel = 0
topbar.ZIndex = 2
topbar.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.RichText = true 
title.Text = '<font color="#FFD700">nos_dywyll\'s</font>\nPrivate menu'
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.Code
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center
title.ZIndex = 2
title.Parent = topbar

--- PLAYER INTEL SIDE MENU ---
local sideOpen = false

local sideMenu = Instance.new("Frame")
sideMenu.Size = UDim2.new(0, 200, 1, 0)
sideMenu.Position = UDim2.new(1, 5, 0, 0)
sideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
sideMenu.BorderSizePixel = 0
sideMenu.Visible = false
sideMenu.Parent = main

local sideStroke = Instance.new("UIStroke")
sideStroke.Color = Color3.fromRGB(45, 45, 45)
sideStroke.Thickness = 1
sideStroke.Parent = sideMenu

local sideTitle = Instance.new("TextLabel")
sideTitle.Size = UDim2.new(1, 0, 0, 30)
sideTitle.BackgroundTransparency = 1
sideTitle.Text = " Server Intel"
sideTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
sideTitle.TextSize = 14
sideTitle.Font = Enum.Font.Code
sideTitle.TextXAlignment = Enum.TextXAlignment.Left
sideTitle.Parent = sideMenu

local sideLine = Instance.new("Frame")
sideLine.Size = UDim2.new(1, 0, 0, 1)
sideLine.Position = UDim2.new(0, 0, 0, 30)
sideLine.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
sideLine.BorderSizePixel = 0
sideLine.Parent = sideMenu

local sideScroll = Instance.new("ScrollingFrame")
sideScroll.Size = UDim2.new(1, -10, 1, -35)
sideScroll.Position = UDim2.new(0, 5, 0, 35)
sideScroll.BackgroundTransparency = 1
sideScroll.BorderSizePixel = 0
sideScroll.ScrollBarThickness = 4
sideScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
sideScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
sideScroll.Parent = sideMenu

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 4)
sideLayout.Parent = sideScroll

local function refreshIntel()
	for _, child in pairs(sideScroll:GetChildren()) do
		if child:IsA("TextLabel") then child:Destroy() end
	end
	
	for _, p in pairs(plrs:GetPlayers()) do
		local ageDays = p.AccountAge
		local joinDate = os.date("%Y-%m-%d", os.time() - (ageDays * 86400))
		
		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(1, 0, 0, 30)
		lbl.BackgroundTransparency = 1
		lbl.Text = p.Name .. "\n<font color='#888888'>" .. joinDate .. "</font>"
		lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
		lbl.TextSize = 13
		lbl.Font = Enum.Font.Code
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.RichText = true
		lbl.Parent = sideScroll
	end
end

--- BUTTONS ---
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -55)
content.Position = UDim2.new(0, 10, 0, 50)
content.BackgroundTransparency = 1
content.ZIndex = 2
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.Parent = content

local function createBtn(name, text)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.TextSize = 16
	btn.Font = Enum.Font.Code
	btn.ZIndex = 2
	btn.Parent = content
	
	local btnStroke = Instance.new("UIStroke")
	btnStroke.Color = Color3.fromRGB(40, 40, 40)
	btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	btnStroke.Parent = btn
	return btn
end

local vBtn = createBtn("vBtn", "UN Fling [V]")
local tBtn = createBtn("tBtn", "Item Magnet [T]")
local iBtn = createBtn("iBtn", "Server Intel")

--- CLEAN STATUS HUD ---
local hud = Instance.new("Frame")
hud.Size = UDim2.new(0, 200, 1, -40)
hud.Position = UDim2.new(0, 15, 0, 20)
hud.BackgroundTransparency = 1
hud.Parent = sg

local hudLayout = Instance.new("UIListLayout")
hudLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
hudLayout.Padding = UDim.new(0, 4)
hudLayout.Parent = hud

local function createStatus(name, text, color)
	local lbl = Instance.new("TextLabel")
	lbl.Name = name
	lbl.Size = UDim2.new(1, 0, 0, 20)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = color
	lbl.TextSize = 15
	lbl.Font = Enum.Font.Code
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextStrokeTransparency = 0.2
	lbl.Visible = false
	lbl.Parent = hud
	return lbl
end

local vStatus = createStatus("vStatus", "> [V] Fling Ready", Color3.fromRGB(255, 100, 100))
local tStatus = createStatus("tStatus", "> [T] Magnet Ready", Color3.fromRGB(100, 200, 255))

--- STATE & LOGIC ---
local state = { v = false, fling = false, t = false }

rs.Heartbeat:Connect(function()
	if state.t or state.fling then
		pcall(function()
			settings().Physics.AllowSleep = false
			if sethiddenproperty then sethiddenproperty(lp, "SimulationRadius", math.huge) end
		end)
	end
end)

local function getTarget(hrp)
	local tgt, dist = nil, math.huge
	for _, p in pairs(plrs:GetPlayers()) do
		if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local d = (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude
			if d < dist then dist = d; tgt = p.Character end
		end
	end
	return tgt
end

vBtn.MouseButton1Click:Connect(function()
	state.v = not state.v
	vStatus.Visible = state.v
	vBtn.BackgroundColor3 = state.v and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
end)

tBtn.MouseButton1Click:Connect(function()
	state.t = not state.t
	tStatus.Visible = state.t
	tBtn.BackgroundColor3 = state.t and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
end)

iBtn.MouseButton1Click:Connect(function()
	sideOpen = not sideOpen
	sideMenu.Visible = sideOpen
	iBtn.BackgroundColor3 = sideOpen and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
	if sideOpen then
		refreshIntel()
	end
end)

local function ghostFling()
	if state.fling then return end
	local char = lp.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChildWhichIsA("Humanoid") then return end
	local hrp, hum = char.HumanoidRootPart, char:FindFirstChildWhichIsA("Humanoid")
	
	local tgt = getTarget(hrp)
	if not tgt then return end
	local tp = tgt:FindFirstChild("Torso") or tgt:FindFirstChild("UpperTorso") or tgt:FindFirstChild("HumanoidRootPart")
	if not tp then return end
	
	state.fling = true
	local sc = hrp.CFrame
	local oct, occ = cam.CameraType, cam.CFrame
	cam.CameraType = Enum.CameraType.Scriptable
	cam.CFrame = occ
	
	local sb = Instance.new("SelectionBox")
	sb.Color3 = Color3.fromRGB(255, 0, 0)
	sb.LineThickness = 0.05
	sb.Adornee = tgt
	sb.Parent = tgt
	
	local start = tick()
	local pts = {}
	for _, p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then table.insert(pts, p) end end
	
	local conn; conn = rs.Stepped:Connect(function()
		if tick() - start > 0.6 or not tp or not tp.Parent or not char or not hrp then
			conn:Disconnect()
			if sb then sb:Destroy() end
			hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
			hrp.CFrame = sc
			hum:ChangeState(Enum.HumanoidStateType.Running)
			cam.CameraType, cam.CameraSubject = oct, hum
			state.fling = false
			return
		end
		for _, p in pairs(pts) do p.CanCollide = false end
		hrp.CFrame = tp.CFrame
		hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity = Vector3.zero, Vector3.new(0, 99999, 0)
	end)
end

local function doMagnet()
	local pos = mouse.Hit.Position
	if not pos then return end
	
	local targetHeight = pos + Vector3.new(0, 4, 0)
	
	for _, o in pairs(workspace:GetDescendants()) do
		if o:IsA("BasePart") and not o.Anchored then
			
			-- Safer check that works on all executors
			local isCharacter = false
			local md = o:FindFirstAncestorOfClass("Model")
			if md and md:FindFirstChildWhichIsA("Humanoid") then isCharacter = true end
			if o:FindFirstAncestorWhichIsA("Accessory") or o:FindFirstAncestorWhichIsA("Tool") then isCharacter = true end
			
			if not isCharacter then
				for _, f in pairs(o:GetChildren()) do
					if f:IsA("BodyMover") or f:IsA("Constraint") or f:IsA("AlignPosition") or f:IsA("Torque") then f:Destroy() end
				end
				
				o.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
				o.CanCollide = false
				
				o.CFrame = CFrame.new(targetHeight + Vector3.new(math.random(-2,2), math.random(-1,2), math.random(-2,2)))
				
				-- The magic velocity trick to maintain network ownership and prevent sleeping
				o.AssemblyLinearVelocity = Vector3.new(14.4626, 14.4626, 14.4626)
				o.AssemblyAngularVelocity = Vector3.new(14.4626, 14.4626, 14.4626)
			end
		end
	end
end

uis.InputBegan:Connect(function(k, p)
	if p then return end
	if state.v and k.KeyCode == Enum.KeyCode.V then ghostFling()
	elseif state.t and k.KeyCode == Enum.KeyCode.T then doMagnet() end
end)

--- DRAG LOGIC ---
local drag, ds, sp
topbar.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		drag, ds, sp = true, i.Position, main.Position
	end
end)
uis.InputChanged:Connect(function(i)
	if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
		local d = i.Position - ds
		main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
	end
end)
uis.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
end)
