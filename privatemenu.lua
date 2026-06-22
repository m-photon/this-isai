
local uis = game:GetService("UserInputService")
local plrs = game:GetService("Players")
local rs = game:GetService("RunService")
local ts = game:GetService("TeleportService")

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
main.Size = UDim2.new(0, 500, 0, 300) 
main.Position = UDim2.new(0.5, -250, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
main.BorderSizePixel = 0
main.Parent = sg

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(45, 45, 45)
stroke.Thickness = 1
stroke.Parent = main

local bgDiamond = Instance.new("ImageLabel")
bgDiamond.Size = UDim2.new(0.6, 0, 0.8, 0)
bgDiamond.Position = UDim2.new(0.5, 0, 0.5, 20)
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
title.Text = '<font color="#FFD700">Nos_dywylls</font> private paid menu'
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.Code
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center
title.ZIndex = 2
title.Active = false 
title.Parent = topbar

--- SEARCH BAR AREA ---
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -20, 0, 30)
searchBox.Position = UDim2.new(0, 10, 0, 52)
searchBox.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
searchBox.BorderSizePixel = 0
searchBox.Text = ""
searchBox.PlaceholderText = "🔍 Search features..."
searchBox.TextColor3 = Color3.fromRGB(220, 220, 220)
searchBox.TextSize = 13
searchBox.Font = Enum.Font.Code
searchBox.ZIndex = 3
searchBox.Parent = main

local searchStroke = Instance.new("UIStroke")
searchStroke.Color = Color3.fromRGB(45, 45, 45)
searchStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
searchStroke.Parent = searchBox

--- MAIN SCROLLING CONTENT ---
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -100)
content.Position = UDim2.new(0, 10, 0, 90)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 2
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.ZIndex = 2
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.Parent = content

--- DYNAMIC TARGET INPUT SIDE MENU (LEFT SIDE FOR GOTO/SPECTATE) ---
local activeTargetAction = nil

local targetMenu = Instance.new("Frame")
targetMenu.Size = UDim2.new(0, 200, 1, 0)
targetMenu.Position = UDim2.new(0, -205, 0, 0) 
targetMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
targetMenu.BorderSizePixel = 0
targetMenu.Visible = false
targetMenu.Parent = main

local targetStroke = Instance.new("UIStroke")
targetStroke.Color = Color3.fromRGB(45, 45, 45)
targetStroke.Thickness = 1
targetStroke.Parent = targetMenu

local targetTitle = Instance.new("TextLabel")
targetTitle.Size = UDim2.new(1, 0, 0, 30)
targetTitle.BackgroundTransparency = 1
targetTitle.Text = " Target Config"
targetTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
targetTitle.TextSize = 14
targetTitle.Font = Enum.Font.Code
targetTitle.TextXAlignment = Enum.TextXAlignment.Left
targetTitle.Parent = targetMenu

local targetLine = Instance.new("Frame")
targetLine.Size = UDim2.new(1, 0, 0, 1)
targetLine.Position = UDim2.new(0, 0, 0, 30)
targetLine.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
targetLine.BorderSizePixel = 0
targetLine.Parent = targetMenu

local targetBox = Instance.new("TextBox")
targetBox.Size = UDim2.new(1, -20, 0, 36)
targetBox.Position = UDim2.new(0, 10, 0, 45)
targetBox.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
targetBox.BorderSizePixel = 0
targetBox.Text = ""
targetBox.PlaceholderText = "Type name & press Enter..."
targetBox.TextColor3 = Color3.fromRGB(200, 200, 200)
targetBox.TextSize = 12
targetBox.Font = Enum.Font.Code
targetBox.ZIndex = 2
targetBox.Parent = targetMenu

local boxStroke = Instance.new("UIStroke")
boxStroke.Color = Color3.fromRGB(40, 40, 40)
boxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
boxStroke.Parent = targetBox

local targetHint = Instance.new("TextLabel")
targetHint.Size = UDim2.new(1, -20, 0, 40)
targetHint.Position = UDim2.new(0, 10, 0, 90)
targetHint.BackgroundTransparency = 1
targetHint.Text = "*Leave blank and press Enter to instantly target the closest player."
targetHint.TextColor3 = Color3.fromRGB(130, 130, 130)
targetHint.TextSize = 11
targetHint.Font = Enum.Font.Code
targetHint.TextXAlignment = Enum.TextXAlignment.Left
targetHint.TextYAlignment = Enum.TextYAlignment.Top
targetHint.TextWrapped = true
targetHint.Parent = targetMenu

--- PLAYER INTEL SIDE MENU (RIGHT SIDE) ---
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

--- STATE CONFIGURATION ---
local state = {
    e = "disabled",
    t = "disabled",
    v = "disabled",
    fly = "disabled",
    speed = "disabled",
    jump = "disabled",
    ghost = "disabled",
    spectate = "disabled",
    frunk = "disabled",
    fling_running = false
}

local COLOR_DISABLED = Color3.fromRGB(25, 25, 25)
local COLOR_ARMED = Color3.fromRGB(55, 55, 75) 
local COLOR_ACTIVE = Color3.fromRGB(35, 75, 35) 

--- UI FACTORY FUNCTION ---
local allButtons = {}
local function createBtn(name, text)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, -5, 0, 36)
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
    
    table.insert(allButtons, btn)
    return btn
end

--- BUILDING THE UI LAYOUT (SORTED ALPHABETICALLY) ---
local vBtn       = createBtn("vBtn", "Execute Fling [V]")
local speedBtn   = createBtn("speedBtn", "Fast Walk")
local flyBtn     = createBtn("flyBtn", "Flight (WASD)")
local frunkBtn   = createBtn("frunkBtn", "Frunk")
local ghostBtn   = createBtn("ghostBtn", "Ghost Mode (Local Hide)")
local gotoBtn    = createBtn("gotoBtn", "Goto Target")
local jumpBtn    = createBtn("jumpBtn", "High Jump")
local dexBtn     = createBtn("dexBtn", "Load Dex Explorer")
local iyBtn      = createBtn("iyBtn", "Load Infinite Yield")
local espHubBtn  = createBtn("espHubBtn", "Load Unnamed ESP")
local eBtn       = createBtn("eBtn", "Player ESP [E]")
local tBtn       = createBtn("tBtn", "Player Tracers [T]")
local refreshBtn = createBtn("refreshBtn", "Refresh Character")
local rejoinBtn  = createBtn("rejoinBtn", "Rejoin Server")
local hopBtn     = createBtn("hopBtn", "Server Hop")
local iBtn       = createBtn("iBtn", "Server Intel (Side Menu)")
local specBtn    = createBtn("specBtn", "Spectate Target")

-- Ensure alphabetical rendering regardless of instantiation order
table.sort(allButtons, function(a, b) return a.Text < b.Text end)
for i, btn in ipairs(allButtons) do
    btn.LayoutOrder = i
end

--- DYNAMIC SEARCH FILTER CORES ---
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local filter = string.lower(searchBox.Text)
    for _, btn in pairs(allButtons) do
        if filter == "" or string.find(string.lower(btn.Text), filter) then
            btn.Visible = true
        else
            btn.Visible = false
        end
    end
end)

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

local eStatus = createStatus("eStatus", "> [E] Player ESP Active", Color3.fromRGB(100, 200, 255))
local tStatus = createStatus("tStatus", "> [T] Tracers Active", Color3.fromRGB(255, 150, 50))
local vStatus = createStatus("vStatus", "> Flinging Target...", Color3.fromRGB(255, 100, 100))

--- CORE LOGIC CHECKS & TARGETING ---
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

local function getClosestPlayer()
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local closestChar = getTarget(lp.Character.HumanoidRootPart)
        if closestChar then
            return plrs:GetPlayerFromCharacter(closestChar)
        end
    end
    return nil
end

local function getTargetPlayer()
    local txt = string.lower(targetBox.Text)
    if txt == "" then 
        return getClosestPlayer()
    end
    for _, p in pairs(plrs:GetPlayers()) do
        if string.sub(string.lower(p.Name), 1, #txt) == txt or string.sub(string.lower(p.DisplayName), 1, #txt) == txt then
            return p
        end
    end
    return nil
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
        if not p or not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then child:Destroy() end
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
                    local vector, onScreen = cam:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                    if onScreen then
                        line.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                        line.To = Vector2.new(vector.X, vector.Y)
                        line.Visible = true
                    else line.Visible = false end
                else line.Visible = false end
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

--- RENDER LOOP ENGINE ---
rs.RenderStepped:Connect(function()
    if state.e == "active" then updateESP() else espFolder:ClearAllChildren() end
    updateTracers()
    
    if lp.Character and not state.fling_running then
        local char = lp.Character
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        if hum then
            if state.speed == "active" then hum.WalkSpeed = 100 else hum.WalkSpeed = 16 end
            if state.jump == "active" then hum.UseJumpPower = true; hum.JumpPower = 100 else hum.JumpPower = 50 end
        end
        
        if state.fly == "active" and hrp and hum then
            hum.PlatformStand = true
            if not hrp:FindFirstChild("FlyVelocity") then
                local bv = Instance.new("BodyVelocity")
                bv.Name = "FlyVelocity"
                bv.MaxForce = Vector3.new(100000, 100000, 100000)
                bv.Parent = hrp
                local bg = Instance.new("BodyGyro")
                bg.Name = "FlyGyro"
                bg.MaxTorque = Vector3.new(100000, 100000, 100000)
                bg.P = 9000
                bg.Parent = hrp
            end
            local bv = hrp:FindFirstChild("FlyVelocity")
            local bg = hrp:FindFirstChild("FlyGyro")
            
            local moveDir = Vector3.zero
            if uis:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
            
            if moveDir.Magnitude > 0 then
                bv.Velocity = moveDir.Unit * 100
            else
                bv.Velocity = Vector3.zero
            end
            bg.CFrame = cam.CFrame
        else
            if hrp then
                if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
                if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
            end
            if hum and state.fly == "disabled" then
                hum.PlatformStand = false
            end
        end
    end
end)

--- FRUNK CONTROLLER (LOADS PASTEFIED R6/R15 LOOPS) ---
local function stopFrunkLoop()
    state.frunk = "disabled"
    frunkBtn.BackgroundColor3 = COLOR_DISABLED
    
    -- Automatically refreshes character to safely break the background loop
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local cf = char.HumanoidRootPart.CFrame
        char:BreakJoints()
        local conn
        conn = lp.CharacterAdded:Connect(function(newChar)
            conn:Disconnect()
            newChar:WaitForChild("HumanoidRootPart").CFrame = cf
        end)
    end
end

local function startFrunkLoop(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    
    state.frunk = "active"
    frunkBtn.BackgroundColor3 = COLOR_ACTIVE
    
    -- Set target variables globally for the Pastefy scripts
    if getgenv then getgenv().Victim = targetPlayer.Name end
    _G.Victim = targetPlayer.Name
    
    local char = lp.Character
    local hum = char and char:FindFirstChildWhichIsA("Humanoid")
    
    if hum then
        -- Automatically run the correct setup based on your rig type
        if hum.RigType == Enum.HumanoidRigType.R6 then
            task.spawn(function()
                pcall(function()
                    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
                end)
            end)
        elseif hum.RigType == Enum.HumanoidRigType.R15 then
            task.spawn(function()
                pcall(function()
                    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
                end)
            end)
        end
    end
end

--- MENU BUTTON INTERFACE OPERATIONS ---

eBtn.MouseButton1Click:Connect(function()
    if state.e == "disabled" then state.e = "armed"; eBtn.BackgroundColor3 = COLOR_ARMED
    else state.e = "disabled"; eStatus.Visible = false; espFolder:ClearAllChildren(); eBtn.BackgroundColor3 = COLOR_DISABLED end
end)

tBtn.MouseButton1Click:Connect(function()
    if state.t == "disabled" then state.t = "armed"; tBtn.BackgroundColor3 = COLOR_ARMED
    else state.t = "disabled"; tStatus.Visible = false; tBtn.BackgroundColor3 = COLOR_DISABLED end
end)

vBtn.MouseButton1Click:Connect(function()
    if state.v == "disabled" then state.v = "armed"; vBtn.BackgroundColor3 = COLOR_ARMED
    else state.v = "disabled"; vStatus.Visible = false; vBtn.BackgroundColor3 = COLOR_DISABLED end
end)

iBtn.MouseButton1Click:Connect(function()
    sideOpen = not sideOpen
    sideMenu.Visible = sideOpen
    iBtn.BackgroundColor3 = sideOpen and COLOR_ARMED or COLOR_DISABLED
    if sideOpen then refreshIntel() end
end)

local function simpleToggle(btn, key)
    btn.MouseButton1Click:Connect(function()
        if state[key] == "disabled" then
            state[key] = "active"
            btn.BackgroundColor3 = COLOR_ACTIVE
        else
            state[key] = "disabled"
            btn.BackgroundColor3 = COLOR_DISABLED
        end
    end)
end

simpleToggle(flyBtn, "fly")
simpleToggle(speedBtn, "speed")
simpleToggle(jumpBtn, "jump")

ghostBtn.MouseButton1Click:Connect(function()
    if state.ghost == "disabled" then
        state.ghost = "active"
        ghostBtn.BackgroundColor3 = COLOR_ACTIVE
        if lp.Character then
            for _, p in pairs(lp.Character:GetDescendants()) do
                if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Transparency = 0.5
                elseif p:IsA("Decal") then p.Transparency = 0.5 end
            end
        end
    else
        state.ghost = "disabled"
        ghostBtn.BackgroundColor3 = COLOR_DISABLED
        if lp.Character then
            for _, p in pairs(lp.Character:GetDescendants()) do
                if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Transparency = 0
                elseif p:IsA("Decal") then p.Transparency = 0 end
            end
        end
    end
end)

refreshBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local cf = char.HumanoidRootPart.CFrame
        char:BreakJoints()
        local conn
        conn = lp.CharacterAdded:Connect(function(newChar)
            conn:Disconnect()
            newChar:WaitForChild("HumanoidRootPart").CFrame = cf
        end)
    end
end)

gotoBtn.MouseButton1Click:Connect(function()
    if activeTargetAction == "goto" and targetMenu.Visible then
        targetMenu.Visible = false
        activeTargetAction = nil
        gotoBtn.BackgroundColor3 = COLOR_DISABLED
    else
        targetMenu.Visible = true
        activeTargetAction = "goto"
        targetTitle.Text = " Action: Goto Target"
        gotoBtn.BackgroundColor3 = COLOR_ARMED
        specBtn.BackgroundColor3 = COLOR_DISABLED
        targetBox:CaptureFocus()
    end
end)

specBtn.MouseButton1Click:Connect(function()
    if state.spectate == "active" then
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = lp.Character.Humanoid
        end
        state.spectate = "disabled"
        specBtn.BackgroundColor3 = COLOR_DISABLED
        specBtn.Text = "Spectate Target"
        targetMenu.Visible = false
        activeTargetAction = nil
    else
        if activeTargetAction == "spectate" and targetMenu.Visible then
            targetMenu.Visible = false
            activeTargetAction = nil
            specBtn.BackgroundColor3 = COLOR_DISABLED
        else
            targetMenu.Visible = true
            activeTargetAction = "spectate"
            targetTitle.Text = " Action: Spectate"
            specBtn.BackgroundColor3 = COLOR_ARMED
            gotoBtn.BackgroundColor3 = COLOR_DISABLED
            targetBox:CaptureFocus()
        end
    end
end)

-- Instant Closest-Target Frunk Execution
frunkBtn.MouseButton1Click:Connect(function()
    if state.frunk == "active" then
        stopFrunkLoop()
    else
        local nearPlayer = getClosestPlayer()
        if nearPlayer then
            startFrunkLoop(nearPlayer)
        end
    end
end)

targetBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local t = getTargetPlayer()
        if t then
            if activeTargetAction == "goto" then
                if t.Character and t.Character:FindFirstChild("HumanoidRootPart") and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                    lp.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                end
                targetMenu.Visible = false
                activeTargetAction = nil
                gotoBtn.BackgroundColor3 = COLOR_DISABLED
            elseif activeTargetAction == "spectate" then
                if t.Character and t.Character:FindFirstChild("Humanoid") then
                    cam.CameraSubject = t.Character.Humanoid
                    state.spectate = "active"
                    specBtn.BackgroundColor3 = COLOR_ACTIVE
                    specBtn.Text = "Stop Spectating"
                end
                targetMenu.Visible = false
                activeTargetAction = nil
            end
        else
            targetMenu.Visible = false
            activeTargetAction = nil
            gotoBtn.BackgroundColor3 = COLOR_DISABLED
            if state.spectate ~= "active" then specBtn.BackgroundColor3 = COLOR_DISABLED end
        end
        targetBox.Text = ""
    end
end)

rejoinBtn.MouseButton1Click:Connect(function()
    ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
end)

hopBtn.MouseButton1Click:Connect(function()
    ts:Teleport(game.PlaceId, lp)
end)

iyBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

dexBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()
end)

espHubBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))()
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

--- KEYBIND INPUT LISTENER ---
uis.InputBegan:Connect(function(k, p)
    if p then return end
    
    if k.KeyCode == Enum.KeyCode.E then
        if state.e == "armed" then state.e = "active"; eStatus.Visible = true; eBtn.BackgroundColor3 = COLOR_ACTIVE
        elseif state.e == "active" then state.e = "armed"; eStatus.Visible = false; espFolder:ClearAllChildren(); eBtn.BackgroundColor3 = COLOR_ARMED end
    elseif k.KeyCode == Enum.KeyCode.T then
        if state.t == "armed" then state.t = "active"; tStatus.Visible = true; tBtn.BackgroundColor3 = COLOR_ACTIVE
        elseif state.t == "active" then state.t = "armed"; tStatus.Visible = false; tBtn.BackgroundColor3 = COLOR_ARMED end
    elseif k.KeyCode == Enum.KeyCode.V then
        if state.v == "armed" then ghostFling() end
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
            if input.UserInputState == Enum.UserInputState.End then Dragging = false end
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
