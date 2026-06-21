local uis = game:GetService("UserInputService")
local plrs = game:GetService("Players")
local rs = game:GetService("RunService")

local lp = plrs.LocalPlayer
local mouse = lp:GetMouse()
local cam = workspace.CurrentCamera
local core = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or lp:WaitForChild("PlayerGui")

-- Safely clear previous menu if it exists
local oldMenu = core:FindFirstChild("nos_dywll_PrivateMenu")
if oldMenu then pcall(function() oldMenu:Destroy() end) end

local sg = Instance.new("ScreenGui")
sg.Name = "nos_dywll_PrivateMenu"
sg.ResetOnSpawn = false
sg.Parent = core

--- MAIN MENU ---
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 350, 0, 280) 
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
topbar.Active = true 
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
-- Split states into menu selection (_enabled) and execution active (_active)
local state = {
	c_enabled = false, c_active = false,
	e_enabled = false, e_active = false,
	t_enabled = false, t_active = false,
	v_enabled = false, fling = false
}

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
local vBtn = createBtn("vBtn", "Execute Fling [V]")
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
local vStatus = createStatus("vStatus", "> Flinging Target...", Color3.fromRGB(255, 100, 100))

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
	local mousePos = Vector2.new(mouse.X, mouse.Y)
	
	for _, p in pairs(plrs:GetPlayers()) do
		if p ~= lp and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChildWhichIsA("Humanoid") and p.Character:FindFirstChildWhichIsA("Humanoid").Health > 0 then
			local vector, onScreen = cam:WorldToScreenPoint(p.Character.Head.Position)
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
	if not (state.e_enabled and state.e_active) then
		espFolder:ClearAllChildren()
		return
	end
	
	for _, child in pairs(espFolder:GetChildren()) do
		local p = plrs:FindFirstChild(child.Name)
		if not p or not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then
			child:Destroy()
		end
	end
	
	for _, p in pairs(plrs:GetPlayers()) do
		if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local hl = espFolder:FindFirstChild(p.Name)
			if not hl then
				hl = Instance.new("Highlight")
				hl.Name = p.Name
				hl.FillColor = Color3.fromRGB(255, 50, 50)
				hl.OutlineColor = Color3.fromRGB(255, 255, 255)
				hl.FillTransparency = 0.6
				hl.OutlineTransparency = 0.2
				hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				hl.Parent = espFolder
			end
			hl.Adornee = p.Character
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
			if state.t_enabled and state.t_active and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildWhichIsA("Humanoid") and p.Character:FindFirstChildWhichIsA("Humanoid").Health > 0 then
				local vector, onScreen = cam:WorldToScreenPoint(p.Character.HumanoidRootPart.Position)
				if onScreen then
					line.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
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
		pcall(function() tracers[p]:Remove() end)
		tracers[p] = nil
	end
end)

rs.RenderStepped:Connect(function()
	if state.e_enabled and state.e_active then
		updateESP()
	else
		espFolder:ClearAllChildren()
	end
	updateTracers()
end)

--- MENU BUTTON TOGGLES ---
local function toggleSilentAimMenu()
	state.c_enabled = not state.c_enabled
	if not state.c_enabled then
		state.c_active = false
		cStatus.Visible = false
	end
	cBtn.BackgroundColor3 = state.c_enabled and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
end

local function toggleESPMenu()
	state.e_enabled = not state.e_enabled
	if not state.e_enabled then
		state.e_active = false
		eStatus.Visible = false
		updateESP()
	end
	eBtn.BackgroundColor3 = state.e_enabled and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
end

local function toggleTracersMenu()
	state.t_enabled = not state.t_enabled
	if not state.t_enabled then
		state.t_active = false
		tStatus.Visible = false
	end
	tBtn.BackgroundColor3 = state.t_enabled and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
end

local function toggleFlingMenu()
	state.v_enabled = not state.v_enabled
	vBtn.BackgroundColor3 = state.v_enabled and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
end

--- GHOST FLING EXECUTION ---
local function ghostFling()
	if not state.v_enabled or state.fling then return end
	local char = lp.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChildWhichIsA("Humanoid") then return end
	local hrp, hum = char.HumanoidRootPart, char:FindFirstChildWhichIsA("Humanoid")
	
	local tgt = getTarget(hrp)
	if not tgt then return end
	local tp = tgt:FindFirstChild("Torso") or tgt:FindFirstChild("UpperTorso") or tgt:FindFirstChild("HumanoidRootPart")
	if not tp then return end
	
	state.fling = true
	vStatus.Visible = true
	local oldCFrame = hrp.CFrame
	
	local bav = Instance.new("BodyAngularVelocity")
	bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bav.AngularVelocity = Vector3.new(0, 999999, 0)
	bav.Parent = hrp
	
	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bv.Velocity = Vector3.new(99999, 99999, 99999)
	bv.Parent = hrp

	local start = tick()
	local conn
	conn = rs.Heartbeat:Connect(function()
		if tick() - start > 1.5 or not tp or not tp.Parent or not char or not hrp or not hum then
			conn:Disconnect()
			if bav and bav.Parent then bav:Destroy() end
			if bv and bv.Parent then bv:Destroy() end
			if hrp and hrp.Parent then
				hrp.AssemblyLinearVelocity = Vector3.zero
				hrp.AssemblyAngularVelocity = Vector3.zero
				hrp.CFrame = oldCFrame
			end
			if hum and hum.Parent then
				hum:ChangeState(Enum.HumanoidStateType.GettingUp)
			end
			state.fling = false
			vStatus.Visible = false
			return
		end
		
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		for _, part in pairs(char:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
		
		hrp.CFrame = tp.CFrame * CFrame.new(math.random(-1,1)*0.05, math.random(-1,1)*0.05, math.random(-1,1)*0.05)
	end)
end

cBtn.MouseButton1Click:Connect(toggleSilentAimMenu)
eBtn.MouseButton1Click:Connect(toggleESPMenu)
tBtn.MouseButton1Click:Connect(toggleTracersMenu)
vBtn.MouseButton1Click:Connect(toggleFlingMenu)

iBtn.MouseButton1Click:Connect(function()
	sideOpen = not sideOpen
	sideMenu.Visible = sideOpen
	iBtn.BackgroundColor3 = sideOpen and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
	if sideOpen then
		refreshIntel()
	end
end)

--- SILENT AIM FUNCTION HOOKS ---
local oldRaycast
oldRaycast = hookfunction(workspace.Raycast, newcclosure(function(self, origin, direction, params)
	if state.c_enabled and state.c_active and not checkcaller() then
		local closest = getClosestToCursor()
		if closest and closest.Character and closest.Character:FindFirstChild("Head") then
			local targetPos = closest.Character.Head.Position
			local newDirection = (targetPos - origin).Unit * direction.Magnitude
			return oldRaycast(self, origin, newDirection, params)
		end
	end
	return oldRaycast(self, origin, direction, params)
end))

local oldFindPartOnRay
oldFindPartOnRay = hookfunction(workspace.FindPartOnRay, newcclosure(function(self, ray, ignoreDescendantsInstance, terrainCellsAreCubes, fractionMultiplier)
	if state.c_enabled and state.c_active and not checkcaller() then
		local closest = getClosestToCursor()
		if closest and closest.Character and closest.Character:FindFirstChild("Head") then
			local targetPos = closest.Character.Head.Position
			local newRay = Ray.new(ray.Origin, (targetPos - ray.Origin).Unit * ray.Direction.Magnitude)
			return oldFindPartOnRay(self, newRay, ignoreDescendantsInstance, terrainCellsAreCubes, fractionMultiplier)
		end
	end
	return oldFindPartOnRay(self, ray, ignoreDescendantsInstance, terrainCellsAreCubes, fractionMultiplier)
end))

local oldFindPartOnRayWithIgnoreList
oldFindPartOnRayWithIgnoreList = hookfunction(workspace.FindPartOnRayWithIgnoreList, newcclosure(function(self, ray, ignoreList, terrainCellsAreCubes, fractionMultiplier)
	if state.c_enabled and state.c_active and not checkcaller() then
		local closest = getClosestToCursor()
		if closest and closest.Character and closest.Character:FindFirstChild("Head") then
			local targetPos = closest.Character.Head.Position
			local newRay = Ray.new(ray.Origin, (targetPos - ray.Origin).Unit * ray.Direction.Magnitude)
			return oldFindPartOnRayWithIgnoreList(self, newRay, ignoreList, terrainCellsAreCubes, fractionMultiplier)
		end
	end
	return oldFindPartOnRayWithIgnoreList(self, ray, ignoreList, terrainCellsAreCubes, fractionMultiplier)
end))

local oldIndex
oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, idx)
	if state.c_enabled and state.c_active and not checkcaller() and self == mouse then
		local closest = getClosestToCursor()
		if closest and closest.Character and closest.Character:FindFirstChild("Head") then
			if idx == "Hit" then
				return closest.Character.Head.CFrame
			elseif idx == "Target" then
				return closest.Character.Head
			end
		end
	end
	return oldIndex(self, idx)
end))

--- KEYBIND INPUT LISTENER ---
uis.InputBegan:Connect(function(k, p)
	if p then return end
	
	if k.KeyCode == Enum.KeyCode.C then
		if state.c_enabled then
			state.c_active = not state.c_active
			cStatus.Visible = state.c_active
		end
	elseif k.KeyCode == Enum.KeyCode.E then
		if state.e_enabled then
			state.e_active = not state.e_active
			eStatus.Visible = state.e_active
			if not state.e_active then updateESP() end
		end
	elseif k.KeyCode == Enum.KeyCode.T then
		if state.t_enabled then
			state.t_active = not state.t_active
			tStatus.Visible = state.t_active
		end
	elseif k.KeyCode == Enum.KeyCode.V then
		if state.v_enabled then
			ghostFling()
		end
	end
end)

--- ABSOLUTE MOUSE DRAG ENGINE ---
local dragging = false
local dragStart = Vector2.zero
local startPos = UDim2.new()

topbar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = Vector2.new(mouse.X, mouse.Y)
		startPos = main.Position
	end
end)

uis.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = Vector2.new(mouse.X, mouse.Y) - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

uis.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)
