-- nos_dywll private menu | larpwtf
-- discord.gg/larpwtf

local uis = game:GetService("UserInputService")
local plrs = game:GetService("Players")
local rs = game:GetService("RunService")
local ts = game:GetService("TeleportService")
local ws = game:GetService("Workspace")
local lp = plrs.LocalPlayer
local cam = ws.CurrentCamera

local core
if gethui then core = gethui()
elseif syn and syn.protect_gui then core = lp:WaitForChild("PlayerGui")
else core = game:GetService("CoreGui") or lp:WaitForChild("PlayerGui") end

if core:FindFirstChild("nos_dywll_PrivateMenu") then
    pcall(function() core.nos_dywll_PrivateMenu:Destroy() end)
end

local sg = Instance.new("ScreenGui")
sg.Name = "nos_dywll_PrivateMenu"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = core

local bgCol = Color3.fromRGB(22, 22, 24)
local strokeCol = Color3.fromRGB(60, 60, 65)
local baseFont = Enum.Font.Gotham

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 520, 0, 360)
main.Position = UDim2.new(0.5, -260, 0.5, -180)
main.BackgroundColor3 = bgCol
main.BorderSizePixel = 0
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
title.ZIndex = 2
title.Parent = topbar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -25, 0.5, -10)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.Gotham
closeBtn.ZIndex = 3
closeBtn.Parent = topbar

local contentBox = Instance.new("Frame")
contentBox.Size = UDim2.new(1, -12, 1, -50)
contentBox.Position = UDim2.new(0, 6, 0, 42)
contentBox.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
contentBox.Parent = main
Instance.new("UICorner", contentBox).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", contentBox).Color = strokeCol

local bdBtn = Instance.new("TextButton")
bdBtn.Size = UDim2.new(0, 130, 0, 28)
bdBtn.Position = UDim2.new(1, -140, 0, 8)
bdBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
bdBtn.Text = "Skid Backdoors"
bdBtn.TextColor3 = Color3.fromRGB(230, 220, 69)
bdBtn.TextSize = 12
bdBtn.Font = baseFont
bdBtn.ZIndex = 3
bdBtn.Parent = contentBox
Instance.new("UICorner", bdBtn).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", bdBtn).Color = strokeCol

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -160, 0, 28)
searchBox.Position = UDim2.new(0, 10, 0, 8)
searchBox.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
searchBox.PlaceholderText = "Search features..."
searchBox.TextColor3 = Color3.fromRGB(220, 220, 220)
searchBox.TextSize = 12
searchBox.Font = baseFont
searchBox.ZIndex = 3
searchBox.Parent = contentBox
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", searchBox).Color = strokeCol

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -50)
content.Position = UDim2.new(0, 10, 0, 44)
content.BackgroundTransparency = 1
content.ScrollBarThickness = 2
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
local bGhost = mkbtn("bGhost", "Ghost Mode (Local Hide)")
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
local bI = mkbtn("bI", "Server Intel (Side Menu)")
local bSpec = mkbtn("bSpec", "Spectate Target")
local bAntiKick = mkbtn("bAntiKick", "Anti-Kick")
local bServerSide = mkbtn("bServerSide", "Server Side Executor")

table.sort(btns, function(a,b) return a.Text < b.Text end)
for i,v in ipairs(btns) do v.LayoutOrder = i end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local f = searchBox.Text:lower()
    for _,b in pairs(btns) do
        b.Visible = (f == "" or b.Text:lower():find(f))
    end
end)

-- backdoors popup (original)
local bdMenu = Instance.new("Frame")
bdMenu.Size = UDim2.new(0, 280, 0, 135)
bdMenu.Position = UDim2.new(0.5, -140, 0.5, -67)
bdMenu.BackgroundColor3 = bgCol
bdMenu.ZIndex = 10
bdMenu.Visible = false
bdMenu.Parent = main
Instance.new("UICorner", bdMenu).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", bdMenu).Color = strokeCol

local bdTitle = Instance.new("TextLabel")
bdTitle.Size = UDim2.new(1, 0, 0, 35)
bdTitle.BackgroundTransparency = 1
bdTitle.Text = "Which backdoor to open?"
bdTitle.TextColor3 = Color3.fromRGB(230, 230, 230)
bdTitle.TextSize = 13
bdTitle.Font = baseFont
bdTitle.ZIndex = 10
bdTitle.Parent = bdMenu

local patrickBtn = Instance.new("TextButton")
patrickBtn.Size = UDim2.new(0.5, -15, 0, 36)
patrickBtn.Position = UDim2.new(0, 10, 0, 45)
patrickBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
patrickBtn.Text = "Patrick"
patrickBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
patrickBtn.Font = baseFont
patrickBtn.ZIndex = 10
patrickBtn.Parent = bdMenu
Instance.new("UICorner", patrickBtn).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", patrickBtn).Color = strokeCol

local spunchBtn = Instance.new("TextButton")
spunchBtn.Size = UDim2.new(0.5, -15, 0, 36)
spunchBtn.Position = UDim2.new(0.5, 5, 0, 45)
spunchBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
spunchBtn.Text = "spunchbub"
spunchBtn.TextColor3 = Color3.fromRGB(230, 220, 69)
spunchBtn.Font = baseFont
spunchBtn.ZIndex = 10
spunchBtn.Parent = bdMenu
Instance.new("UICorner", spunchBtn).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", spunchBtn).Color = strokeCol

local closeBdBtn = Instance.new("TextButton")
closeBdBtn.Size = UDim2.new(1, -20, 0, 28)
closeBdBtn.Position = UDim2.new(0, 10, 1, -38)
closeBdBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 25)
closeBdBtn.Text = "Cancel"
closeBdBtn.TextColor3 = Color3.fromRGB(220, 100, 100)
closeBdBtn.Font = baseFont
closeBdBtn.ZIndex = 10
closeBdBtn.Parent = bdMenu
Instance.new("UICorner", closeBdBtn).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", closeBdBtn).Color = Color3.fromRGB(60,35,35)

-- server side executor
local ssFrame = Instance.new("Frame")
ssFrame.Size = UDim2.new(0, 340, 0, 240)
ssFrame.Position = UDim2.new(0.5, -170, 0.5, -120)
ssFrame.BackgroundColor3 = bgCol
ssFrame.Visible = false
ssFrame.ZIndex = 15
ssFrame.Parent = main
Instance.new("UICorner", ssFrame).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", ssFrame).Color = strokeCol

local ssTitle = Instance.new("TextLabel")
ssTitle.Size = UDim2.new(1,0,0,32)
ssTitle.BackgroundTransparency = 1
ssTitle.Text = "Server Side Executor"
ssTitle.TextColor3 = Color3.fromRGB(230,220,69)
ssTitle.TextSize = 14
ssTitle.Font = baseFont
ssTitle.Parent = ssFrame

local ssBox = Instance.new("TextBox")
ssBox.Size = UDim2.new(1,-20,1,-90)
ssBox.Position = UDim2.new(0,10,0,38)
ssBox.BackgroundColor3 = Color3.fromRGB(15,15,17)
ssBox.PlaceholderText = "-- paste server code"
ssBox.TextColor3 = Color3.fromRGB(200,200,200)
ssBox.MultiLine = true
ssBox.ClearTextOnFocus = false
ssBox.TextSize = 12
ssBox.Font = baseFont
ssBox.TextXAlignment = Enum.TextXAlignment.Left
ssBox.TextYAlignment = Enum.TextYAlignment.Top
ssBox.Parent = ssFrame
Instance.new("UICorner", ssBox).CornerRadius = UDim.new(0,4)
Instance.new("UIStroke", ssBox).Color = strokeCol

local execBtn = Instance.new("TextButton")
execBtn.Size = UDim2.new(0.48,-5,0,32)
execBtn.Position = UDim2.new(0,10,1,-42)
execBtn.BackgroundColor3 = Color3.fromRGB(40,70,40)
execBtn.Text = "Execute"
execBtn.TextColor3 = Color3.fromRGB(220,255,220)
execBtn.Font = baseFont
execBtn.Parent = ssFrame
Instance.new("UICorner", execBtn).CornerRadius = UDim.new(0,4)

local closeSS = Instance.new("TextButton")
closeSS.Size = UDim2.new(0.48,-5,0,32)
closeSS.Position = UDim2.new(0.52,5,1,-42)
closeSS.BackgroundColor3 = Color3.fromRGB(70,30,30)
closeSS.Text = "Close"
closeSS.TextColor3 = Color3.fromRGB(255,180,180)
closeSS.Font = baseFont
closeSS.Parent = ssFrame
Instance.new("UICorner", closeSS).CornerRadius = UDim.new(0,4)

-- target menu
local targetAction = nil
local tMenu = Instance.new("Frame")
tMenu.Size = UDim2.new(0, 200, 1, 0)
tMenu.Position = UDim2.new(0, -210, 0, 0)
tMenu.BackgroundColor3 = bgCol
tMenu.Visible = false
tMenu.Parent = main
Instance.new("UICorner", tMenu).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", tMenu).Color = strokeCol

local tTitle = Instance.new("TextLabel")
tTitle.Size = UDim2.new(1, -20, 0, 30)
tTitle.Position = UDim2.new(0, 10, 0, 0)
tTitle.BackgroundTransparency = 1
tTitle.Text = "Target Config"
tTitle.TextColor3 = Color3.fromRGB(230, 220, 69)
tTitle.Font = Enum.Font.GothamMedium
tTitle.TextXAlignment = Enum.TextXAlignment.Left
tTitle.Parent = tMenu

local tLine = Instance.new("Frame")
tLine.Size = UDim2.new(1, 0, 0, 1)
tLine.Position = UDim2.new(0, 0, 0, 30)
tLine.BackgroundColor3 = strokeCol
tLine.Parent = tMenu

local tBox = Instance.new("TextBox")
tBox.Size = UDim2.new(1, -20, 0, 36)
tBox.Position = UDim2.new(0, 10, 0, 45)
tBox.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
tBox.PlaceholderText = "Type name & Enter..."
tBox.TextColor3 = Color3.fromRGB(200, 200, 200)
tBox.Font = baseFont
tBox.TextSize = 12
tBox.Parent = tMenu
Instance.new("UICorner", tBox).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", tBox).Color = strokeCol

local tHint = Instance.new("TextLabel")
tHint.Size = UDim2.new(1, -20, 0, 40)
tHint.Position = UDim2.new(0, 10, 0, 90)
tHint.BackgroundTransparency = 1
tHint.Text = "*Leave blank + Enter for closest player."
tHint.TextColor3 = Color3.fromRGB(130, 130, 130)
tHint.Font = baseFont
tHint.TextSize = 11
tHint.TextXAlignment = Enum.TextXAlignment.Left
tHint.TextYAlignment = Enum.TextYAlignment.Top
tHint.TextWrapped = true
tHint.Parent = tMenu

-- server intel
local sideOpen = false
local sMenu = Instance.new("Frame")
sMenu.Size = UDim2.new(0, 200, 1, 0)
sMenu.Position = UDim2.new(1, 10, 0, 0)
sMenu.BackgroundColor3 = bgCol
sMenu.Visible = false
sMenu.Parent = main
Instance.new("UICorner", sMenu).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", sMenu).Color = strokeCol

local sTitle = Instance.new("TextLabel")
sTitle.Size = UDim2.new(1, -20, 0, 30)
sTitle.Position = UDim2.new(0, 10, 0, 0)
sTitle.BackgroundTransparency = 1
sTitle.Text = "Server Intel"
sTitle.TextColor3 = Color3.fromRGB(230, 220, 69)
sTitle.Font = Enum.Font.GothamMedium
sTitle.TextXAlignment = Enum.TextXAlignment.Left
sTitle.Parent = sMenu

local sLine = Instance.new("Frame")
sLine.Size = UDim2.new(1, 0, 0, 1)
sLine.Position = UDim2.new(0, 0, 0, 30)
sLine.BackgroundColor3 = strokeCol
sLine.Parent = sMenu

local sScroll = Instance.new("ScrollingFrame")
sScroll.Size = UDim2.new(1, -10, 1, -35)
sScroll.Position = UDim2.new(0, 5, 0, 35)
sScroll.BackgroundTransparency = 1
sScroll.ScrollBarThickness = 2
sScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
sScroll.Parent = sMenu
Instance.new("UIListLayout", sScroll).Padding = UDim.new(0, 4)

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
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.Parent = sScroll
    end
end

-- esp
local espFolder = Instance.new("Folder", core)
espFolder.Name = "nos_esp_folder"
local function upESP()
    if state.e ~= "active" then
        espFolder:ClearAllChildren() return
    end
    for _,v in pairs(espFolder:GetChildren()) do
        local p = plrs:FindFirstChild(v.Name)
        if not p or not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then v:Destroy() end
    end
    for _,p in pairs(plrs:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hl = espFolder:FindFirstChild(p.Name)
            if not hl then
                hl = Instance.new("Highlight")
                hl.Name = p.Name
                hl.FillColor = Color3.fromRGB(255,50,50)
                hl.OutlineColor = Color3.fromRGB(255,255,255)
                hl.FillTransparency = 0.6
                hl.OutlineTransparency = 0.2
                hl.DepthMode = "AlwaysOnTop"
                hl.Parent = espFolder
            end
            hl.Adornee = p.Character
        end
    end
end

-- tracers
local lines = {}
local hasDraw = pcall(function() return Drawing.new("Line") end)
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
                    l.Visible = false
                    l.Color = Color3.fromRGB(255,50,50)
                    l.Thickness = 1
                    lines[p] = l
                end)
            end
            local l = lines[p]
            if l then
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildOfClass("Humanoid") and p.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
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

-- noclip
rs.Stepped:Connect(function()
    if state.noclip == "active" and lp.Character then
        for _,v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- main loop
rs.RenderStepped:Connect(function()
    pcall(upESP)
    pcall(upTracers)
    
    if lp.Character then
        local h = lp.Character:FindFirstChildOfClass("Humanoid")
        local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
        if h then
            h.WalkSpeed = state.speed == "active" and 100 or 16
            h.JumpPower = state.jump == "active" and 100 or 50
        end
    end
end)

-- frunk
local function killFrunk()
    state.frunk = "disabled"
    bFrunk.BackgroundColor3 = colOff
    local c = lp.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        local cf = c.HumanoidRootPart.CFrame
        c:BreakJoints()
        local con; con = lp.CharacterAdded:Connect(function(nc)
            con:Disconnect()
            nc:WaitForChild("HumanoidRootPart").CFrame = cf
        end)
    end
end

local function doFrunk(tgt)
    if not tgt or not tgt.Character then return end
    state.frunk = "active"
    bFrunk.BackgroundColor3 = colOn
    if getgenv then getgenv().Victim = tgt.Name end
    _G.Victim = tgt.Name
    local h = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if h then
        task.spawn(function()
            pcall(function()
                if h.RigType == Enum.HumanoidRigType.R6 then
                    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
                else
                    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
                end
            end)
        end)
    end
end

-- target helpers
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

-- toggle helper
local function tog(b, k)
    b.MouseButton1Click:Connect(function()
        if state[k] == "disabled" then
            state[k] = "active"
            b.BackgroundColor3 = colOn
        else
            state[k] = "disabled"
            b.BackgroundColor3 = colOff
        end
    end)
end

tog(bFly, "fly")
tog(bSpeed, "speed")
tog(bJump, "jump")
tog(bNoclip, "noclip")
tog(bGod, "god")
tog(bFullbright, "fullbright")
tog(bNoFog, "nofog")

bE.MouseButton1Click:Connect(function()
    if state.e == "disabled" then 
        state.e = "armed" 
        bE.BackgroundColor3 = colArmed 
    else 
        state.e = "disabled" 
        bE.BackgroundColor3 = colOff 
    end
end)

bT.MouseButton1Click:Connect(function()
    if state.t == "disabled" then 
        state.t = "armed" 
        bT.BackgroundColor3 = colArmed 
    else 
        state.t = "disabled" 
        bT.BackgroundColor3 = colOff 
    end
end)

bV.MouseButton1Click:Connect(function()
    if state.v == "disabled" then 
        state.v = "armed" 
        bV.BackgroundColor3 = colArmed 
    else 
        state.v = "disabled" 
        bV.BackgroundColor3 = colOff 
    end
end)

bI.MouseButton1Click:Connect(function()
    sideOpen = not sideOpen
    sMenu.Visible = sideOpen
    bI.BackgroundColor3 = sideOpen and colArmed or colOff
    if sideOpen then refreshIntel() end
end)

bGhost.MouseButton1Click:Connect(function()
    if state.ghost == "disabled" then
        state.ghost = "active"
        bGhost.BackgroundColor3 = colOn
        if lp.Character then
            for _,p in pairs(lp.Character:GetDescendants()) do
                if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Transparency=0.5
                elseif p:IsA("Decal") then p.Transparency=0.5 end
            end
        end
    else
        state.ghost = "disabled"
        bGhost.BackgroundColor3 = colOff
        if lp.Character then
            for _,p in pairs(lp.Character:GetDescendants()) do
                if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Transparency=0
                elseif p:IsA("Decal") then p.Transparency=0 end
            end
        end
    end
end)

bRefresh.MouseButton1Click:Connect(function()
    local c = lp.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        local cf = c.HumanoidRootPart.CFrame
        c:BreakJoints()
        local con; con = lp.CharacterAdded:Connect(function(nc)
            con:Disconnect()
            nc:WaitForChild("HumanoidRootPart").CFrame = cf
        end)
    end
end)

bGoto.MouseButton1Click:Connect(function()
    if targetAction == "goto" and tMenu.Visible then
        tMenu.Visible = false
        targetAction = nil
        bGoto.BackgroundColor3 = colOff
    else
        tMenu.Visible = true
        targetAction = "goto"
        bGoto.BackgroundColor3 = colArmed
        bSpec.BackgroundColor3 = colOff
        tBox:CaptureFocus()
    end
end)

bSpec.MouseButton1Click:Connect(function()
    if state.spectate == "active" then
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = lp.Character.Humanoid
        end
        state.spectate = "disabled"
        bSpec.BackgroundColor3 = colOff
        bSpec.Text = "Spectate Target"
        tMenu.Visible = false
        targetAction = nil
    else
        if targetAction == "spectate" and tMenu.Visible then
            tMenu.Visible = false
            targetAction = nil
            bSpec.BackgroundColor3 = colOff
        else
            tMenu.Visible = true
            targetAction = "spectate"
            bSpec.BackgroundColor3 = colArmed
            bGoto.BackgroundColor3 = colOff
            tBox:CaptureFocus()
        end
    end
end)

bFrunk.MouseButton1Click:Connect(function()
    if state.frunk == "active" then 
        killFrunk()
    else
        local t = getClosest()
        if t then doFrunk(t) end
    end
end)

bHitbox.MouseButton1Click:Connect(function()
    local t = getClosest()
    if t and t.Character then
        for _,part in pairs(t.Character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Size = Vector3.new(10,10,10)
            end
        end
    end
end)

tBox.FocusLost:Connect(function(ent)
    if ent then
        local t = getPlr()
        if t then
            if targetAction == "goto" then
                if t.Character and t.Character:FindFirstChild("HumanoidRootPart") and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                    lp.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                end
            elseif targetAction == "spectate" then
                if t.Character and t.Character:FindFirstChild("Humanoid") then
                    cam.CameraSubject = t.Character.Humanoid
                    state.spectate = "active"
                    bSpec.BackgroundColor3 = colOn
                    bSpec.Text = "Stop Spectating"
                end
            end
        end
        tMenu.Visible = false
        targetAction = nil
        bGoto.BackgroundColor3 = colOff
        tBox.Text = ""
    end
end)

bRejoin.MouseButton1Click:Connect(function() ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp) end)
bHop.MouseButton1Click:Connect(function() ts:Teleport(game.PlaceId, lp) end)
bIY.MouseButton1Click:Connect(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
bDex.MouseButton1Click:Connect(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))() end)
bEspHub.MouseButton1Click:Connect(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))() end)

-- fling
local function doFling()
    if state.v ~= "armed" or state.fling then return end
    local c = lp.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then return end
    local hrp = c.HumanoidRootPart
    local t = getTgt(hrp)
    if not t then return end
    local tp = t:FindFirstChild("Torso") or t:FindFirstChild("UpperTorso") or t:FindFirstChild("HumanoidRootPart")
    if not tp then return end

    state.fling = true
    bV.BackgroundColor3 = colOn

    local oldcf = hrp.CFrame
    local bav = Instance.new("BodyAngularVelocity", hrp)
    bav.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
    bav.AngularVelocity = Vector3.new(0,999999,0)
    local bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
    bv.Velocity = Vector3.new(99999,99999,99999)

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

-- drag
local drag, dStart, sPos
topbar.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true
        dStart = inp.Position
        sPos = main.Position
    end
end)

uis.InputChanged:Connect(function(inp)
    if drag and inp.UserInputType == Enum.UserInputType.MouseMovement then
        local d = inp.Position - dStart
        main.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
    end
end)

topbar.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
end)

closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

print("nos_dywll loaded - buttons & exploits should work now")
