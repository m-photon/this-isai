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
main.Size = UDim2.new(0, 350, 0, 280) -- Expanded to fit 5 buttons
main.Position = UDim2.new(0.5, -175, 0.5, -140)
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

--- MAIN LIST BUTTONS ---
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -55)
content.Position = UDim2.new(0, 10, 0, 50)
content.BackgroundTransparency = 1
content.ZIndex = 2
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.Parent = content

--- STATE & LOGIC ---
local state = { v = false, c = false, e = false, t = false, fling = false }

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

local cBtn = createBtn("cBtn", "Silent Aim [C]")
local eBtn = createBtn("eBtn", "Player ESP [E]")
local tBtn = createBtn("tBtn", "Tracers [T]")
local vBtn = createBtn("vBtn", "UN Fling [V]")
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

local cStatus = createStatus("cStatus", "> [C] Silent Aim Active", Color3.fromRGB(100, 255, 100))
local eStatus = createStatus("eStatus", "> [E] Player ESP Active", Color3.fromRGB(100, 200, 255))
local tStatus = createStatus("tStatus", "> [T] Tracers Active", Color3.fromRGB(255, 150, 50))
local vStatus = createStatus("vStatus", "> [V] Fling Ready", Color3.fromRGB(255, 100, 100))

--- FUNCTIONS ---
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

local function getClosestToCursor()
	local closestDist = math.huge
	local closestPlr = nil
	local mousePos = uis:GetMouseLocation()
	
	for _, p in pairs(plrs:GetPlayers()) do
		if p ~= lp and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChildWhichIsA("Humanoid") and p.Character:FindFirstChildWhichIsA("Humanoid").Health > 0 then
			local vector, onScreen = cam:WorldToViewportPoint(p.Character.Head.Position)
			if onScreen then
				local dist = (Vector2.new(vector.X, vector.Y) - mousePos).Magnitude
				if dist < closestDist then
					closestDist = dist
					closestPlr = p
				end
			end
		end
	end
	return closestPlr
end

--- ESP LOGIC ---
local espFolder = Instance.new("Folder")
espFolder.Name = "nos_dywyll_ESP"
espFolder.Parent = core

local function updateESP()
	if not state.e then
		espFolder:ClearAllChildren()
		return
	end
	
	for _, p in pairs(plrs:GetPlayers()) do
		if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			if not espFolder:FindFirstChild(p.Name) then
				local hl = Instance.new("Highlight")
				hl.Name = p.Name
				hl.Adornee = p.Character
				hl.FillColor = Color3.fromRGB(255, 50, 50)
				hl.OutlineColor = Color3.fromRGB(255, 255, 255)
				hl.FillTransparency = 0.6
				hl.OutlineTransparency = 0.2
				hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				hl.Parent = espFolder
			else
				espFolder[p.Name].Adornee = p.Character
			end
		end
	end
end

--- TRACERS LOGIC ---
local tracers = {}
local function updateTracers()
	for _, p in pairs(plrs:GetPlayers()) do
		if p ~= lp then
			if not tracers[p] then
				local line = Drawing.new("Line")
				line.Visible = false
				line.Color = Color3.fromRGB(255, 50, 50)
				line.Thickness = 1
				line.Transparency = 1
				tracers[p] = line
			end
			
			local line = tracers[p]
			if state.t and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildWhichIsA("Humanoid") and p.Character:FindFirstChildWhichIsA("Humanoid").Health > 0 then
				local vector, onScreen = cam:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
				if onScreen then
					line.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y) -- Originates from bottom center
					line.To = Vector2.new(vector.X, vector.Y)
					line.Visible = true
				else
					line.Visible = false
				end
			else
				line.Visible = false
			end
		end
	end
end

plrs.PlayerRemoving:Connect(function(p)
	if tracers[p] then
		tracers[p]:Remove()
		tracers[p] = nil
	end
end)

rs.RenderStepped:Connect(function()
	if state.e then
		updateESP()
	end
	updateTracers()
end)

--- BUTTON CLICKS ---
cBtn.MouseButton1Click:Connect(function()
	state.c = not state.c
	cStatus.Visible = state.c
	cBtn.BackgroundColor3 = state.c and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
end)

eBtn.MouseButton1Click:Connect(function()
	state.e = not state.e
	eStatus.Visible = state.e
	eBtn.BackgroundColor3 = state.e and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
	if not state.e then updateESP() end
end)

tBtn.MouseButton1Click:Connect(function()
	state.t = not state.t
	tStatus.Visible = state.t
	tBtn.BackgroundColor3 = state.t and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
end)

vBtn.MouseButton1Click:Connect(function()
	state.v = not state.v
	vStatus.Visible = state.v
	vBtn.BackgroundColor3 = state.v and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
end)

iBtn.MouseButton1Click:Connect(function()
	sideOpen = not sideOpen
	sideMenu.Visible = sideOpen
	iBtn.BackgroundColor3 = sideOpen and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
	if sideOpen then
		refreshIntel()
	end
end)

--- GHOST FLING ---
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

--- SILENT AIM HOOK ---
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
	local method = getnamecallmethod()
	local args = {...}
	
	if state.c and not checkcaller() and (method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRayWithWhitelist" or method == "FindPartOnRay" or method == "Raycast") then
		local closest = getClosestToCursor()
		if closest and closest.Character and closest.Character:FindFirstChild("Head") then
			local origin = method == "Raycast" and args[1] or args[1].Origin
			local targetPos = closest.Character.Head.Position
			local direction = (targetPos - origin).Unit * 1000
			
			if method == "Raycast" then
				args[2] = direction
			else
				args[1] = Ray.new(origin, direction)
			end
			
			return oldNamecall(self, unpack(args))
		end
	end
	
	return oldNamecall(self, ...)
end))

uis.InputBegan:Connect(function(k, p)
	if p then return end
	if k.KeyCode == Enum.KeyCode.V and state.v then 
		ghostFling() 
	elseif k.KeyCode == Enum.KeyCode.C then
		state.c = not state.c
		cStatus.Visible = state.c
		cBtn.BackgroundColor3 = state.c and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
	elseif k.KeyCode == Enum.KeyCode.E then
		state.e = not state.e
		eStatus.Visible = state.e
		eBtn.BackgroundColor3 = state.e and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
		if not state.e then updateESP() end
	elseif k.KeyCode == Enum.KeyCode.T then
		state.t = not state.t
		tStatus.Visible = state.t
		tBtn.BackgroundColor3 = state.t and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
	end
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
