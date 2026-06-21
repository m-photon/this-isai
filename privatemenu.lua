local uis = game:GetService("UserInputService")
local plrs = game:GetService("Players")
local rs = game:GetService("RunService")

local lp = plrs.LocalPlayer
local mouse = lp:GetMouse()
local cam = workspace.CurrentCamera

-- Safely determine the absolute best execution GUI parent container
local core = nil
if gethui then
	core = gethui()
elseif syn and syn.protect_gui then
	core = lp:WaitForChild("PlayerGui")
else
	local success, res = pcall(function() return game:GetService("CoreGui") end)
	core = (success and res) and res or lp:WaitForChild("PlayerGui")
end

-- Safely clear previous menu instances
if core:FindFirstChild("nos_dywll_PrivateMenu") then
	pcall(function() core["nos_dywll_PrivateMenu"]:Destroy() end)
end

local sg = Instance.new("ScreenGui")
sg.Name = "nos_dywll_PrivateMenu"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
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
title.Active = false -- Prevents text blocking mouse inputs on the topbar drag frame
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

--- STATE CONFIGURATION ---
local state = {
	c = "disabled",
	e = "disabled",
	t = "disabled",
	v = "disabled",
	fling_running = false
}

local COLOR_DISABLED = Color3.fromRGB(25, 25, 25)
local COLOR_ARMED = Color3.fromRGB(55, 55, 75) 
local COLOR_ACTIVE = Color3.fromRGB(35, 75, 35) 

local function createBtn(name, text)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = COLOR_DISABLED
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

--- CORE LOGIC CHECKS ---
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
	if state.e ~= "active" then
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

--- TRACERS LOGIC WITH EXECUTOR CRASH GUARD ---
local tracers = {}
local hasDrawing = pcall(function() return Drawing ~= nil and Drawing.new ~= nil end)

local function updateTracers()
	if not hasDrawing or state.t ~= "active" then 
		for _, v in pairs(tracers) do pcall(function() v.Visible = false end) end
		return 
	end
	
	for _, p in pairs(plrs:GetPlayers()) do
		if p ~= lp then
			if not tracers[p] then
				local success, line = pcall(function() return Drawing.new("Line") end)
				if success then
					line.Visible = false
					line.Color = Color3.fromRGB(255, 50, 50)
					line.Thickness = 1
					line.Transparency = 1
					tracers[p] = line
				end
			end
			
			local line = tracers[p]
			if line then
				if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildWhichIsA("Humanoid") and p.Character:FindFirstChildWhichIsA("Humanoid").Health > 0 then
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
end

plrs.PlayerRemoving:Connect(function(p)
	if tracers[p] then
		pcall(function() tracers[p]:Remove() end)
		tracers[p] = nil
	end
end)

rs.RenderStepped:Connect(function()
	if state.e == "active" then updateESP() else espFolder:ClearAllChildren() end
	updateTracers()
end)

--- MENU BUTTON INTERFACE OPERATIONS (ARMING MECHANICS) ---
cBtn.MouseButton1Click:Connect(function()
	if state.c == "disabled" then
		state.c = "armed"
		cBtn.BackgroundColor3 = COLOR_ARMED
	else
		state.c = "disabled"
		cStatus.Visible = false
		cBtn.BackgroundColor3 = COLOR_DISABLED
	end
end)

eBtn.MouseButton1Click:Connect(function()
	if state.e == "disabled" then
		state.e = "armed"
		eBtn.BackgroundColor3 = COLOR_ARMED
	else
		state.e = "disabled"
		eStatus.Visible = false
		espFolder:ClearAllChildren()
		eBtn.BackgroundColor3 = COLOR_DISABLED
	end
end)

tBtn.MouseButton1Click:Connect(function()
	if state.t == "disabled" then
		state.t = "armed"
		tBtn.BackgroundColor3 = COLOR_ARMED
	else
		state.t = "disabled"
		tStatus.Visible = false
		tBtn.BackgroundColor3 = COLOR_DISABLED
	end
end)

vBtn.MouseButton1Click:Connect(function()
	if state.v == "disabled" then
		state.v = "armed"
		vBtn.BackgroundColor3 = COLOR_ARMED
	else
		state.v = "disabled"
		vStatus.Visible = false
		vBtn.BackgroundColor3 = COLOR_DISABLED
	end
end)

iBtn.MouseButton1Click:Connect(function()
	sideOpen = not sideOpen
	sideMenu.Visible = sideOpen
	iBtn.BackgroundColor3 = sideOpen and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(25, 25, 25)
	if sideOpen then refreshIntel() end
end)

--- GHOST FLING EXECUTION ---
local function ghostFling()
	if state.v ~= "armed" or state.fling_running then return end
	local char = lp.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChildWhichIsA("Humanoid") then return end
	local hrp, hum = char.HumanoidRootPart, char:FindFirstChildWhichIsA("Humanoid")
	
	local tgt = getTarget(hrp)
	if not tgt then return end
	local tp = tgt:FindFirstChild("Torso") or tgt:FindFirstChild("UpperTorso") or tgt:FindFirstChild("HumanoidRootPart")
	if not tp then return end
	
	state.fling_running = true
	vStatus.Visible = true
	vBtn.BackgroundColor3 = COLOR_ACTIVE
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
			if bav and bav.Parent then pcall(function() bav:Destroy() end) end
			if bv and bv.Parent then pcall(function() bv:Destroy() end) end
			if hrp and hrp.Parent then
				hrp.AssemblyLinearVelocity = Vector3.zero
				hrp.AssemblyAngularVelocity = Vector3.zero
				hrp.CFrame = oldCFrame
			end
			if hum and hum.Parent then
				pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
			end
			state.fling_running = false
			vStatus.Visible = false
			vBtn.BackgroundColor3 = (state.v == "armed") and COLOR_ARMED or COLOR_DISABLED
			return
		end
		
		pcall(function() hum:ChangeState(Enum.HumanoidStateType.Physics) end)
		for _, part in pairs(char:GetChildren()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
		
		hrp.CFrame = tp.CFrame * CFrame.new(math.random(-1,1)*0.05, math.random(-1,1)*0.05, math.random(-1,1)*0.05)
	end)
end

--- CRASH-GUARDED ENGINE ENVIRONMENT HOOKS ---
if hookfunction and hookmetamethod then
	pcall(function()
		local oldRaycast
		oldRaycast = hookfunction(workspace.Raycast, newcclosure(function(self, origin, direction, params)
			if state.c == "active" and not checkcaller() then
				local closest = getClosestToCursor()
				if closest and closest.Character and closest.Character:FindFirstChild("Head") then
					return oldRaycast(self, origin, (closest.Character.Head.Position - origin).Unit * direction.Magnitude, params)
				end
			end
			return oldRaycast(self, origin, direction, params)
		end))

		local oldFindPartOnRay
		oldFindPartOnRay = hookfunction(workspace.FindPartOnRay, newcclosure(function(self, ray, ignoreDescendantsInstance, terrainCellsAreCubes, fractionMultiplier)
			if state.c == "active" and not checkcaller() then
				local closest = getClosestToCursor()
				if closest and closest.Character and closest.Character:FindFirstChild("Head") then
					local newRay = Ray.new(ray.Origin, (closest.Character.Head.Position - ray.Origin).Unit * ray.Direction.Magnitude)
					return oldFindPartOnRay(self, newRay, ignoreDescendantsInstance, terrainCellsAreCubes, fractionMultiplier)
				end
			end
			return oldFindPartOnRay(self, ray, ignoreDescendantsInstance, terrainCellsAreCubes, fractionMultiplier)
		end))

		local oldIndex
		oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, idx)
			if state.c == "active" and not checkcaller() and self == mouse then
				local closest = getClosestToCursor()
				if closest and closest.Character and closest.Character:FindFirstChild("Head") then
					if idx == "Hit" then return closest.Character.Head.CFrame
					elseif idx == "Target" then return closest.Character.Head end
				end
			end
			return oldIndex(self, idx)
		end))
	end)
end

--- KEYBIND INPUT LISTENER ---
uis.InputBegan:Connect(function(k, p)
	if p then return end
	
	if k.KeyCode == Enum.KeyCode.C then
		if state.c == "armed" then
			state.c = "active"
			cStatus.Visible = true
			cBtn.BackgroundColor3 = COLOR_ACTIVE
		elseif state.c == "active" then
			state.c = "armed"
			cStatus.Visible = false
			cBtn.BackgroundColor3 = COLOR_ARMED
		end
		
	elseif k.KeyCode == Enum.KeyCode.E then
		if state.e == "armed" then
			state.e = "active"
			eStatus.Visible = true
			eBtn.BackgroundColor3 = COLOR_ACTIVE
		elseif state.e == "active" then
			state.e = "armed"
			eStatus.Visible = false
			espFolder:ClearAllChildren()
			eBtn.BackgroundColor3 = COLOR_ARMED
		end
		
	elseif k.KeyCode == Enum.KeyCode.T then
		if state.t == "armed" then
			state.t = "active"
			tStatus.Visible = true
			tBtn.BackgroundColor3 = COLOR_ACTIVE
		elseif state.t == "active" then
			state.t = "armed"
			tStatus.Visible = false
			tBtn.BackgroundColor3 = COLOR_ARMED
		end
		
	elseif k.KeyCode == Enum.KeyCode.V then
		if state.v == "armed" then
			ghostFling()
		end
	end
end)

--- ENGINE-NATIVE SMOOTH UI DRAG SYSTEM ---
local Dragging = false
local DragInput, DragStart, StartPos

local function Update(input)
	local Delta = input.Position - DragStart
	main.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
end

topbar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		Dragging = true
		DragStart = input.Position
		StartPos = main.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				Dragging = false
			end
		end)
	end
end)

topbar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		DragInput = input
	end
end)

uis.InputChanged:Connect(function(input)
	if input == DragInput and Dragging then
		Update(input)
	end
end)
