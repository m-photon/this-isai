local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- High-compatibility GUI parenting for Xeno
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

-- Define colors
local themeColor = Color3.fromRGB(0, 255, 120) 
local grayColor = Color3.fromRGB(100, 100, 100)

-- Prevent duplicate GUIs
if guiParent:FindFirstChild("PrivateAnimationsGui") then
    guiParent.PrivateAnimationsGui:Destroy()
end

-- Create the main ScreenGui
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "PrivateAnimationsGui"
mainGui.ResetOnSpawn = false
mainGui.IgnoreGuiInset = true
mainGui.Parent = guiParent

-- Create the Main Frame
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

-- Create the Top Bar/Title
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

-- === CLOSE BUTTON ===
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

-- === SPINNING DIAMOND ===
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

-- Create a ScrollingFrame to hold the buttons
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

-- Helper function to make styled buttons
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

-- === CREATE BUTTONS ===
local inspectorBtn = createStyledButton("InspectorButton", "Inspector", buttonContainer)

for i = 1, 14 do
    createStyledButton("BlankButton" .. i, "", buttonContainer)
end

gridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    buttonContainer.CanvasSize = UDim2.new(0, 0, 0, gridLayout.AbsoluteContentSize.Y + 20)
end)

-- Make the GUI Draggable
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

-- === ANIMATION INTEGRATION LOGIC ===
inspectorBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if not char then return end
    
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not torso then return end

    -- Locate shoulder joints automatically based on R6 / R15 avatar type
    local rShoulder = torso:FindFirstChild("Right Shoulder") or char:FindFirstChild("RightShoulder") or (char:FindFirstChild("RightUpperArm") and char.RightUpperArm:FindFirstChild("RightShoulder"))
    local lShoulder = torso:FindFirstChild("Left Shoulder") or char:FindFirstChild("LeftShoulder") or (char:FindFirstChild("LeftUpperArm") and char.LeftUpperArm:FindFirstChild("LeftShoulder"))
    
    if rShoulder and lShoulder then
        -- Direct assignment loop bypassing main script globals entirely
        task.spawn(function()
            -- Force flag updates locally if they exist in scope
            if ATTACK ~= nil then ATTACK = true end
            if Rooted ~= nil then Rooted = true end
            
            -- Smooth transition loop
            for step = 1, 20 do
                if Clerp then
                    -- If the main script's Clerp is available, utilize it smoothly
                    rShoulder.C0 = Clerp(rShoulder.C0, CFrame.new(1.0, -0.2, 0.6) * CFrame.Angles(math.rad(-45), 0, math.rad(-30)), 0.3)
                    lShoulder.C0 = Clerp(lShoulder.C0, CFrame.new(-1.0, -0.2, 0.6) * CFrame.Angles(math.rad(-45), 0, math.rad(30)), 0.3)
                else
                    -- Direct Lerp fallback if executed independently
                    rShoulder.C0 = rShoulder.C0:Lerp(CFrame.new(1.0, -0.2, 0.6) * CFrame.Angles(math.rad(-45), 0, math.rad(-30)), 0.3)
                    lShoulder.C0 = lShoulder.C0:Lerp(CFrame.new(-1.0, -0.2, 0.6) * CFrame.Angles(math.rad(-45), 0, math.rad(30)), 0.3)
                end
                if Swait then Swait() else task.wait(0.03) end
            end
            
            -- Lock position directly to prevent internal animations from resetting the arms immediately
            while true do
                rShoulder.C0 = CFrame.new(1.0, -0.2, 0.6) * CFrame.Angles(math.rad(-45), 0, math.rad(-30))
                lShoulder.C0 = CFrame.new(-1.0, -0.2, 0.6) * CFrame.Angles(math.rad(-45), 0, math.rad(30))
                task.wait()
            end
        end)
    end
end)
