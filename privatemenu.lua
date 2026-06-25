-- nos_dywll private menu


local uis = game:GetService("UserInputService")
local plrs = game:GetService("Players")
local rs = game:GetService("RunService")
local ts = game:GetService("TeleportService")
local ws = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local lp = plrs.LocalPlayer
local cam = ws.CurrentCamera

local core
if gethui then 
    core = gethui()
elseif syn and syn.protect_gui then 
    core = lp:WaitForChild("PlayerGui")
else 
    core = game:GetService("CoreGui") or lp:WaitForChild("PlayerGui") 
end

if core:FindFirstChild("nos_dywll_PrivateMenu") then
    pcall(function() core.nos_dywll_PrivateMenu:Destroy() end)
end

local sg = Instance.new("ScreenGui")
sg.Name = "nos_dywll_PrivateMenu"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
sg.DisplayOrder = 9999
sg.Parent = core

local bgCol = Color3.fromRGB(22, 22, 24)
local strokeCol = Color3.fromRGB(60, 60, 65)
local baseFont = Enum.Font.Gotham

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 520, 0, 360)
main.Position = UDim2.new(0.5, -260, 0.5, -180)
main.BackgroundColor3 = bgCol
main.BorderSizePixel = 0
main.Active = true
main.ZIndex = 1
main.Parent = sg
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", main).Color = strokeCol

local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1, -12, 0, 30)
topbar.Position = UDim2.new(0, 6, 0, 6)
topbar.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
topbar.BorderSizePixel = 0
topbar.ZIndex = 2
topbar.Active = true
topbar.Parent = main
Instance.new("UICorner", topbar).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", topbar).Color = strokeCol

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.RichText = true
title.Text = '<i><font color="#E6DC45">Nos_dywll</font></i> - Private Menu'
title.TextColor3 = Color3.fromRGB(240, 240, 240)
title.TextSize = 14
title.Font = Enum.Font.GothamMedium
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 3
title.Parent = topbar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -25, 0.5, -10)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.Gotham
closeBtn.ZIndex = 4
closeBtn.Parent = topbar

local contentBox = Instance.new("Frame")
contentBox.Size = UDim2.new(1, -12, 1, -50)
contentBox.Position = UDim2.new(0, 6, 0, 42)
contentBox.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
contentBox.ZIndex = 2
contentBox.Parent = main
Instance.new("UICorner", contentBox).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", contentBox).Color = strokeCol

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -160, 0, 28)
searchBox.Position = UDim2.new(0, 10, 0, 8)
searchBox.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
searchBox.PlaceholderText = "Search features..."
searchBox.TextColor3 = Color3.fromRGB(220, 220, 220)
searchBox.TextSize = 12
searchBox.Font = baseFont
searchBox.ZIndex = 3
searchBox.ClearTextOnFocus = false
searchBox.Parent = contentBox
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", searchBox).Color = strokeCol

local bdBtn = Instance.new("TextButton")
bdBtn.Size = UDim2.new(0, 130, 0, 28)
bdBtn.Position = UDim2.new(1, -140, 0, 8)
bdBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
bdBtn.Text = "Skid Backdoors"
bdBtn.TextColor3 = Color3.fromRGB(230, 220, 69)
bdBtn.TextSize = 12
bdBtn.Font = baseFont
bdBtn.ZIndex = 4
bdBtn.Parent = contentBox
Instance.new("UICorner", bdBtn).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", bdBtn).Color = strokeCol

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -50)
content.Position = UDim2.new(0, 10, 0, 44)
content.BackgroundTransparency = 1
content.ScrollBarThickness = 3
content.Active = true
content.ZIndex = 3
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = contentBox
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.Parent = content

local state = {
    e="disabled", t="disabled", v="disabled", fly="disabled", speed="disabled",
    jump="disabled", ghost="disabled", spectate="disabled", frunk="disabled", 
    noclip="disabled", god="disabled", fullbright="disabled", nofog="disabled",
    hitbox="disabled", fling=false
}

local colOff = Color3.fromRGB(28, 28, 32)
local colArmed = Color3.fromRGB(60, 60, 80)
local colOn = Color3.fromRGB(45, 85, 45)
local btns = {}

local function mkbtn(id, txt)
    local b = Instance.new("TextButton")
    b.Name = id
    b.Size = UDim2.new(1, 0, 0, 34)
    b.BackgroundColor3 = colOff
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(210, 210, 210)
    b.TextSize = 13
    b.Font = baseFont
    b.ZIndex = 4
    b.Parent = content
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", b).Color = strokeCol
    table.insert(btns, b)
    return b
end

local bV = mkbtn("bV", "Execute Fling [V]")
local bSpeed = mkbtn("bSpeed", "Fast Walk")
local bFly = mkbtn("bFly", "Flight (WASD)")
local bFrunk = mkbtn("bFrunk", "Frunk")
local bGhost = mkbtn("bGhost", "Ghost Mode")
local bGoto = mkbtn("bGoto", "Goto Target")
local bJump = mkbtn("bJump", "High Jump")
local bDex = mkbtn("bDex", "Load Dex Explorer")
local bIY = mkbtn("bIY", "Load Infinite Yield")
local bEspHub = mkbtn("bEspHub", "Load Unnamed ESP")
local bNoclip = mkbtn("bNoclip", "Noclip")
local bE = mkbtn("bE", "Player ESP [E]")
local bT = mkbtn("bT", "Player Tracers [T]")
local bGod = mkbtn("bGod", "Godmode")
local bFullbright = mkbtn("bFullbright", "Fullbright")
local bNoFog = mkbtn("bNoFog", "No Fog")
local bHitbox = mkbtn("bHitbox", "Hitbox Expander")
local bRefresh = mkbtn("bRefresh", "Refresh Character")
local bRejoin = mkbtn("bRejoin", "Rejoin Server")
local bHop = mkbtn("bHop", "Server Hop")
local bI = mkbtn("bI", "Server Intel")
local bSpec = mkbtn("bSpec", "Spectate Target")
local bServerSide = mkbtn("bServerSide", "Server Side Executor")

table.sort(btns, function(a,b) return a.Text < b.Text end)
for i,v in ipairs(btns) do v.LayoutOrder = i end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local f = searchBox.Text:lower()
    for _,b in pairs(btns) do
        if f == "" then
            b.Visible = true
        else
            b.Visible = string.find(b.Text:lower(), f, 1, true) ~= nil
        end
    end
end)

-- Popups Framework
local function createPopup(titleText, size, position)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = bgCol
    frame.ZIndex = 10
    frame.Visible = false
    frame.Parent = main
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", frame).Color = strokeCol
    
    local titleL = Instance.new("TextLabel")
    titleL.Size = UDim2.new(1, 0, 0, 35)
    titleL.BackgroundTransparency = 1
    titleL.Text = titleText
    titleL.TextColor3 = Color3.fromRGB(230, 230, 230)
    titleL.TextSize = 13
    titleL.Font = baseFont
    titleL.ZIndex = 11
    titleL.Parent = frame
    
    return frame
end

-- Menus
local bdMenu = createPopup("Which backdoor to open?", UDim2.new(0, 280, 0, 135), UDim2.new(0.5, -140, 0.5, -67))
local ssFrame = createPopup("Server Side Executor", UDim2.new(0, 340, 0, 240), UDim2.new(0.5, -170, 0.5, -120))
local tMenu = createPopup("Target Config", UDim2.new(0, 200, 1, 0), UDim2.new(0, -210, 0, 0))
local sMenu = createPopup("Server Intel", UDim2.new(0, 200, 1, 0), UDim2.new(1, 10, 0, 0))

-- Target Box
local tBox = Instance.new("TextBox")
tBox.Size = UDim2.new(1, -20, 0, 36)
tBox.Position = UDim2.new(0, 10, 0, 45)
tBox.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
tBox.PlaceholderText = "Type name & Enter..."
tBox.TextColor3 = Color3.fromRGB(200, 200, 200)
tBox.Font = baseFont
tBox.TextSize = 12
tBox.ZIndex = 11
tBox.Parent = tMenu
Instance.new("UICorner", tBox).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", tBox).Color = strokeCol

-- Intel Scroll
local sScroll = Instance.new("ScrollingFrame")
sScroll.Size = UDim2.new(1, -10, 1, -35)
sScroll.Position = UDim2.new(0, 5, 0, 35)
sScroll.BackgroundTransparency = 1
sScroll.ScrollBarThickness = 2
sScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
sScroll.ZIndex = 11
sScroll.Parent = sMenu
Instance.new("UIListLayout", sScroll).Padding = UDim.new(0, 4)

local targetAction = nil
local sideOpen = false

local function refreshIntel()
    for _,v in pairs(sScroll:GetChildren()) do
        if v:IsA("TextLabel") then v:Destroy() end
    end
    for _,p in pairs(plrs:GetPlayers()) do
        local d = os.date("%Y-%m-%d", os.time() - (p.AccountAge * 86400))
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, 0, 0, 34)
        l.BackgroundTransparency = 1
        l.Text = p.Name .. "\n<font color='#888888'>" .. d .. "</font>"
        l.TextColor3 = Color3.fromRGB(220, 220, 220)
        l.TextSize = 12
        l.Font = baseFont
        l.RichText = true
        l.ZIndex = 11
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.Parent = sScroll
    end
end

bI.MouseButton1Click:Connect(function()
    sideOpen = not sideOpen
    sMenu.Visible = sideOpen
    bI.BackgroundColor3 = sideOpen and colArmed or colOff
    if sideOpen then refreshIntel() end
end)

bdBtn.MouseButton1Click:Connect(function() bdMenu.Visible = not bdMenu.Visible end)
bServerSide.MouseButton1Click:Connect(function() ssFrame.Visible = not ssFrame.Visible end)

-- Feature Toggle Logic
local function tog(btn, key, callback)
    btn.MouseButton1Click:Connect(function()
        if state[key] == "disabled" then
            state[key] = "active"
            btn.BackgroundColor3 = colOn
        else
            state[key] = "disabled"
            btn.BackgroundColor3 = colOff
            if key == "speed" or key == "jump" then
                if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
                    local h = lp.Character:FindFirstChildOfClass("Humanoid")
                    if key == "speed" then h.WalkSpeed = 16 end
                    if key == "jump" then h.JumpPower = 50 end
                end
            end
        end
        if callback then pcall(function() callback(state[key] == "active") end) end
    end)
end

tog(bFly, "fly")
tog(bSpeed, "speed")
tog(bJump, "jump")
tog(bNoclip, "noclip")
tog(bGod, "god")

tog(bFullbright, "fullbright", function(active)
    lighting.Brightness = active and 2 or 1
    lighting.Ambient = active and Color3.fromRGB(255,255,255) or Color3.fromRGB(128,128,128)
end)

tog(bNoFog, "nofog", function(active)
    lighting.FogEnd = active and 999999 or 1000
end)

-- Safe External Loaders
local function safeLoad(url)
    pcall(function() loadstring(game:HttpGet(url))() end)
end

bIY.MouseButton1Click:Connect(function() safeLoad('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source') end)
bDex.MouseButton1Click:Connect(function() safeLoad('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua') end)
bEspHub.MouseButton1Click:Connect(function() safeLoad('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua') end)
bRejoin.MouseButton1Click:Connect(function() ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp) end)
bHop.MouseButton1Click:Connect(function() ts:Teleport(game.PlaceId, lp) end)

-- ESP System (Memory Leak Patched)
local espFolder = Instance.new("Folder", core)
espFolder.Name = "nos_esp_folder"

local function upESP()
    if state.e ~= "active" then
        espFolder:ClearAllChildren()
        return
    end
    -- Cleanup invalid highlights
    for _,v in pairs(espFolder:GetChildren()) do
        local p = plrs:FindFirstChild(v.Name)
        if not p or not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then 
            v:Destroy() 
        end
    end
    -- Create new ones
    for _,p in pairs(plrs:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if not espFolder:FindFirstChild(p.Name) then
                local hl = Instance.new("Highlight")
                hl.Name = p.Name
                hl.FillColor = Color3.fromRGB(255,50,50)
                hl.OutlineColor = Color3.fromRGB(255,255,255)
                hl.DepthMode = "AlwaysOnTop"
                hl.Parent = espFolder
                hl.Adornee = p.Character
            end
        end
    end
end

-- Tracer System (Drawing Library Safe)
local lines = {}
local hasDraw = false
pcall(function() 
    local t = Drawing.new("Line")
    if t then hasDraw = true; t:Remove() end
end)

local function upTracers()
    if not hasDraw or state.t ~= "active" then
        for _,v in pairs(lines) do pcall(function() v.Visible = false end) end
        return
    end
    for _,p in pairs(plrs:GetPlayers()) do
        if p ~= lp then
            if not lines[p] then
                pcall(function()
                    local l = Drawing.new("Line")
                    l.Color = Color3.fromRGB(255,50,50)
                    l.Thickness = 1
                    lines[p] = l
                end)
            end
            local l = lines[p]
            if l then
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local pos, vis = cam:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                    if vis then
                        l.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                        l.To = Vector2.new(pos.X, pos.Y)
                        l.Visible = true
                    else l.Visible = false end
                else l.Visible = false end
            end
        end
    end
end

plrs.PlayerRemoving:Connect(function(p)
    if lines[p] then pcall(function() lines[p]:Remove() end) lines[p]=nil end
end)

-- Main Background Loop (Optimized to prevent crashing)
task.spawn(function()
    while true do
        task.wait(0.05) -- Keeps loop from freezing client
        pcall(upESP)
        pcall(upTracers)
        
        if lp.Character then
            local h = lp.Character:FindFirstChildOfClass("Humanoid")
            if h then
                if state.speed == "active" then h.WalkSpeed = 100 end
                if state.jump == "active" then h.JumpPower = 100 end
            end
        end
    end
end)

rs.Stepped:Connect(function()
    if state.noclip == "active" and lp.Character then
        for _,v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

local flySpeed = 50
rs.Heartbeat:Connect(function()
    if state.fly == "active" and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = lp.Character.HumanoidRootPart
        local moveDir = Vector3.new(0,0,0)
        
        if uis:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
        
        hrp.Velocity = moveDir.Magnitude > 0 and moveDir.Unit * flySpeed or Vector3.new(0,0,0)
    end
end)

-- Ghost Mode
bGhost.MouseButton1Click:Connect(function()
    state.ghost = state.ghost == "disabled" and "active" or "disabled"
    bGhost.BackgroundColor3 = state.ghost == "active" and colOn or colOff
    if lp.Character then
        for _,p in pairs(lp.Character:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then 
                p.Transparency = state.ghost == "active" and 0.5 or 0
            elseif p:IsA("Decal") then 
                p.Transparency = state.ghost == "active" and 0.5 or 0 
            end
        end
    end
end)

-- Target Locators
local function getTgt(hrp)
    local t, d = nil, math.huge
    for _,p in pairs(plrs:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if dist < d then d = dist; t = p.Character end
        end
    end
    return t
end

local function getClosest()
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local c = getTgt(lp.Character.HumanoidRootPart)
        if c then return plrs:GetPlayerFromCharacter(c) end
    end
end

local function getPlr()
    local txt = tBox.Text:lower()
    if txt == "" then return getClosest() end
    for _,p in pairs(plrs:GetPlayers()) do
        if p.Name:lower():sub(1,#txt) == txt or p.DisplayName:lower():sub(1,#txt) == txt then
            return p
        end
    end
end

bGoto.MouseButton1Click:Connect(function()
    if targetAction == "goto" and tMenu.Visible then
        tMenu.Visible = false; targetAction = nil; bGoto.BackgroundColor3 = colOff
    else
        tMenu.Visible = true; targetAction = "goto"; bGoto.BackgroundColor3 = colArmed; bSpec.BackgroundColor3 = colOff; tBox:CaptureFocus()
    end
end)

bSpec.MouseButton1Click:Connect(function()
    if state.spectate == "active" then
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then cam.CameraSubject = lp.Character.Humanoid end
        state.spectate = "disabled"; bSpec.BackgroundColor3 = colOff; bSpec.Text = "Spectate Target"; tMenu.Visible = false; targetAction = nil
    else
        if targetAction == "spectate" and tMenu.Visible then
            tMenu.Visible = false; targetAction = nil; bSpec.BackgroundColor3 = colOff
        else
            tMenu.Visible = true; targetAction = "spectate"; bSpec.BackgroundColor3 = colArmed; bGoto.BackgroundColor3 = colOff; tBox:CaptureFocus()
        end
    end
end)

tBox.FocusLost:Connect(function(ent)
    if ent then
        local t = getPlr()
        if t then
            if targetAction == "goto" and t.Character and lp.Character then
                lp.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
            elseif targetAction == "spectate" and t.Character then
                cam.CameraSubject = t.Character.Humanoid
                state.spectate = "active"
                bSpec.BackgroundColor3 = colOn
                bSpec.Text = "Stop Spectating"
            end
        end
        tMenu.Visible = false; targetAction = nil; bGoto.BackgroundColor3 = colOff; tBox.Text = ""
    end
end)

-- Crash-Proof Fling Logic
local function doFling()
    if state.v ~= "armed" or state.fling then return end
    local c = lp.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then return end
    local hrp = c.HumanoidRootPart
    local t = getTgt(hrp)
    if not t then return end
    local tp = t:FindFirstChild("HumanoidRootPart") or t:FindFirstChild("Torso")
    if not tp then return end

    state.fling = true
    bV.BackgroundColor3 = colOn

    local oldcf = hrp.CFrame
    local bav = Instance.new("BodyAngularVelocity")
    bav.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
    bav.AngularVelocity = Vector3.new(0,999999,0)
    bav.Parent = hrp

    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
    bv.Velocity = Vector3.new(99999,99999,99999)
    bv.Parent = hrp

    local st = tick()
    local con; con = rs.Heartbeat:Connect(function()
        if tick()-st > 1.5 or not tp.Parent then
            con:Disconnect()
            pcall(function() bav:Destroy() bv:Destroy() end)
            if hrp then hrp.CFrame = oldcf end
            state.fling = false
            bV.BackgroundColor3 = colOff
            return
        end
        hrp.CFrame = tp.CFrame * CFrame.new(math.random(-1,1)*0.05, math.random(-1,1)*0.05, math.random(-1,1)*0.05)
    end)
end

-- Keybinds
uis.InputBegan:Connect(function(k, g)
    if g then return end
    if k.KeyCode == Enum.KeyCode.E then
        if state.e == "armed" then state.e = "active"; bE.BackgroundColor3 = colOn end
    elseif k.KeyCode == Enum.KeyCode.T then
        if state.t == "armed" then state.t = "active"; bT.BackgroundColor3 = colOn end
    elseif k.KeyCode == Enum.KeyCode.V then
        if state.v == "armed" then doFling() end
    end
end)

bE.MouseButton1Click:Connect(function() state.e = state.e == "disabled" and "armed" or "disabled"; bE.BackgroundColor3 = state.e == "armed" and colArmed or colOff end)
bT.MouseButton1Click:Connect(function() state.t = state.t == "disabled" and "armed" or "disabled"; bT.BackgroundColor3 = state.t == "armed" and colArmed or colOff end)
bV.MouseButton1Click:Connect(function() state.v = state.v == "disabled" and "armed" or "disabled"; bV.BackgroundColor3 = state.v == "armed" and colArmed or colOff end)

-- Smooth Dragging System
local dragging = false
local dragInput, dragStart, startPos

topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

topbar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

uis.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)
print("nos_dywll loaded - Master Version (Crash-Proof)")
