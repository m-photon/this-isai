-- =======================================================================
-- NOS_DYWLL'S UNIFIED FE REANIMATION & PRIVATE ANIMATIONS SCRIPT
-- =======================================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- =======================================================================
-- PART 1: THE STUDIO UI GRAPHICS INTERFACE (Forced to load first)
-- =======================================================================
local guiParent
local success, result = pcall(function() return gethui() end)
if success and result then
    guiParent = result
else
    local coreSuccess, coreResult = pcall(function() return game:GetService("CoreGui") end)
    if coreSuccess and coreResult then
        guiParent = coreResult
    else
        guiParent = player:WaitForChild("PlayerGui")
    end
end

-- Theme setup
local themeColor = Color3.fromRGB(0, 255, 120) 
local grayColor = Color3.fromRGB(100, 100, 100)

if guiParent:FindFirstChild("PrivateAnimationsGui") then
    guiParent.PrivateAnimationsGui:Destroy()
end

local mainGui = Instance.new("ScreenGui")
mainGui.Name = "PrivateAnimationsGui"
mainGui.ResetOnSpawn = false
mainGui.IgnoreGuiInset = true
mainGui.Parent = guiParent

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = themeColor
mainFrame.Active = true
mainFrame.Parent = mainGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
titleLabel.BorderSizePixel = 0
titleLabel.Text = " nos_dywll's private FE animations"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = themeColor 
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 25)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
closeButton.BorderSizePixel = 1
closeButton.BorderColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.TextColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeButton

closeButton.MouseEnter:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end)
closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    closeButton.TextColor3 = Color3.fromRGB(255, 50, 50)
end)
closeButton.MouseButton1Click:Connect(function()
    mainGui:Destroy()
end)

-- Spinning central background diamond
local diamond = Instance.new("Frame")
diamond.Name = "SpinningDiamond"
diamond.Size = UDim2.new(0, 120, 0, 120)
diamond.AnchorPoint = Vector2.new(0.5, 0.5)
diamond.Position = UDim2.new(0.5, 0, 0.5, 0)
diamond.BackgroundColor3 = grayColor
diamond.BorderSizePixel = 0
diamond.Rotation = 45
diamond.ZIndex = 1
diamond.Parent = mainFrame

local diamondCorner = Instance.new("UICorner")
diamondCorner.CornerRadius = UDim.new(0, 10)
diamondCorner.Parent = diamond

task.spawn(function()
    while diamond.Parent do
        local dt = task.wait()
        diamond.Rotation = diamond.Rotation + (90 * dt)
    end
end)

local buttonContainer = Instance.new("ScrollingFrame")
buttonContainer.Name = "ButtonContainer"
buttonContainer.Size = UDim2.new(1, -20, 1, -55)
buttonContainer.Position = UDim2.new(0, 10, 0, 45)
buttonContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
buttonContainer.BackgroundTransparency = 0.5
buttonContainer.BorderSizePixel = 0
buttonContainer.ScrollBarThickness = 6
buttonContainer.ScrollBarImageColor3 = themeColor
buttonContainer.ZIndex = 2
buttonContainer.Parent = mainFrame

local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(0, 4)
containerCorner.Parent = buttonContainer

local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(0, 145, 0, 40)
gridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
gridLayout.Parent = buttonContainer

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 10)
padding.PaddingLeft = UDim.new(0, 10)
padding.Parent = buttonContainer

local function createStyledButton(name, text, parent)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = themeColor
    btn.Text = text
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.TextColor3 = themeColor
    btn.ZIndex = 3
    btn.Parent = parent
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    return btn
end

-- Populate Grid
local inspectorBtn = createStyledButton("InspectorButton", "Inspector", buttonContainer)

for i = 1, 14 do
    createStyledButton("BlankButton" .. i, "", buttonContainer)
end

gridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    buttonContainer.CanvasSize = UDim2.new(0, 0, 0, gridLayout.AbsoluteContentSize.Y + 20)
end)

-- Dragging Handler
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleLabel.InputBegan:Connect(function(input)
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

titleLabel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)


-- =======================================================================
-- PART 2: THE FE REANIMATION & ANIMATION BACKGROUND ENGINE
-- =======================================================================
local reanimated = false
local ATTACK = false
local Rooted = false
local Animation_Speed = 2
local SINE = 0
local inspecting = false

-- Global joints setup inside isolated threads to protect UI rendering
local RootJoint, Neck, RightShoulder, LeftShoulder, RightHip, LeftHip
local ROOTC0, NECKC0, RIGHTSHOULDERC0, LEFTSHOULDERC0, RIGHTHIPC0, LEFTHIPC0

local function Swait()
    RunService.Heartbeat:Wait()
end

local function Clerp(a, b, t)
    return a:Lerp(b, t)
end

task.spawn(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local torso = char:WaitForChild("Torso", 5)
    local rootPart = char:WaitForChild("HumanoidRootPart", 5)
    
    if not torso or not rootPart then
        warn("Reanimation Setup Error: R6 Torso parts not loaded.")
        return
    end

    RootJoint = rootPart:WaitForChild("Root Joint", 2)
    Neck = torso:WaitForChild("Neck", 2)
    RightShoulder = torso:WaitForChild("Right Shoulder", 2)
    LeftShoulder = torso:WaitForChild("Left Shoulder", 2)
    RightHip = torso:WaitForChild("Right Hip", 2)
    LeftHip = torso:WaitForChild("Left Hip", 2)

    if not (RootJoint and Neck and RightShoulder and LeftShoulder and RightHip and LeftHip) then
        warn("Reanimation Setup Error: Standard motor joints missing.")
        return
    end

    -- Store original structural anchors
    ROOTC0 = RootJoint.C0
    NECKC0 = Neck.C0
    RIGHTSHOULDERC0 = RightShoulder.C0
    LEFTSHOULDERC0 = LeftShoulder.C0
    RIGHTHIPC0 = RightHip.C0
    LEFTHIPC0 = LeftHip.C0
    reanimated = true

    -- Passive Claim Replication (Netless physics sync loop)
    task.spawn(function()
        while reanimated and char:IsDescendantOf(workspace) do
            RunService.Heartbeat:Wait()
            settings().Physics.AllowSleep = false
            player.MaximumSimulationRadius = math.huge
            pcall(function() setsimulationradius(math.huge) end)
            
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Velocity = Vector3.new(0, -30, 0)
                end
            end
        end
    end)

    -- Stance Stablizer / Idle breathing engine
    task.spawn(function()
        while reanimated and char:IsDescendantOf(workspace) do
            Swait()
            if not ATTACK then
                SINE = SINE + 1
                RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CFrame.new(0, 0, 0.05 * math.cos(SINE / 12)), 0.1)
                Neck.C0 = Clerp(Neck.C0, NECKC0 * CFrame.Angles(math.rad(2 * math.sin(SINE / 12)), 0, 0), 0.1)
                RightShoulder.C0 = Clerp(RightShoulder.C0, RIGHTSHOULDERC0 * CFrame.new(0, 0.02 * math.sin(SINE / 12), 0) * CFrame.Angles(0, 0, math.rad(1 * math.sin(SINE / 12))), 0.1)
                LeftShoulder.C0 = Clerp(LeftShoulder.C0, LEFTSHOULDERC0 * CFrame.new(0, 0.02 * math.sin(SINE / 12), 0) * CFrame.Angles(0, 0, math.rad(-1 * math.sin(SINE / 12))), 0.1)
                RightHip.C0 = Clerp(RightHip.C0, RIGHTHIPC0 * CFrame.new(0, -0.02 * math.cos(SINE / 12), 0), 0.1)
                LeftHip.C0 = Clerp(LeftHip.C0, LEFTHIPC0 * CFrame.new(0, -0.02 * math.cos(SINE / 12), 0), 0.1)
            end
        end
    end)
end)

-- =======================================================================
-- PART 3: TOGGLE HANDLER & FE REPLICATION CONNECTORS
-- =======================================================================
inspectorBtn.MouseButton1Click:Connect(function()
    if not reanimated then 
        warn("Wait for engine to index your character joints before using animations.")
        return 
    end
    
    inspecting = not inspecting
    
    if inspecting then
        inspectorBtn.Text = "Inspecting..."
        inspectorBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
        inspectorBtn.BorderColor3 = Color3.fromRGB(255, 255, 0)
        
        coroutine.resume(coroutine.create(function()
            ATTACK = true
            Rooted = true
            
            -- Absolute target positioning offsets anchored firmly to the original base coordinates
            local rightInspectC0 = CFrame.new(-0.2, -0.1, 0.5) * CFrame.Angles(math.rad(-60), 0, math.rad(-30)) * RIGHTSHOULDERC0
            local leftInspectC0 = CFrame.new(0.2, -0.1, 0.5) * CFrame.Angles(math.rad(-60), 0, math.rad(30)) * LEFTSHOULDERC0
            
            while inspecting and reanimated do
                Swait()
                RightShoulder.C0 = Clerp(RightShoulder.C0, rightInspectC0, 1 / Animation_Speed)
                LeftShoulder.C0 = Clerp(LeftShoulder.C0, leftInspectC0, 1 / Animation_Speed)
                RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0, 1 / Animation_Speed)
                Neck.C0 = Clerp(Neck.C0, NECKC0, 1 / Animation_Speed)
            end
            
            ATTACK = false
            Rooted = false
            inspectorBtn.Text = "Inspector"
            inspectorBtn.TextColor3 = themeColor
            inspectorBtn.BorderColor3 = themeColor
        end))
    else
        inspecting = false
    end
end)
