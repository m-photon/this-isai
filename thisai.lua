-- Private FE Animations GUI - Button Layout (Studio UI Mockup)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Define the custom Green color theme
local themeColor = Color3.fromRGB(0, 255, 120)

-- Prevent duplicate GUIs if the script runs multiple times
if playerGui:FindFirstChild("PrivateAnimationsGui") then
    playerGui.PrivateAnimationsGui:Destroy()
end

-- Create the main ScreenGui
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "PrivateAnimationsGui"
mainGui.ResetOnSpawn = false
mainGui.IgnoreGuiInset = true
mainGui.Parent = playerGui

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

-- Create a ScrollingFrame to hold the buttons
local buttonContainer = Instance.new("ScrollingFrame")
buttonContainer.Name = "ButtonContainer"
buttonContainer.Size = UDim2.new(1, -20, 1, -55)
buttonContainer.Position = UDim2.new(0, 10, 0, 45)
buttonContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
buttonContainer.BorderSizePixel = 0
buttonContainer.ScrollBarThickness = 6
buttonContainer.ScrollBarImageColor3 = themeColor
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

-- === CREATE THE INSPECTOR BUTTON ===
local inspectorBtn = createStyledButton("InspectorButton", "Inspector", buttonContainer)

-- Generate remaining blank buttons
for i = 1, 14 do
    createStyledButton("BlankButton" .. i, "", buttonContainer)
end

-- Update CanvasSize based on the number of buttons
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

-- This is where you connect the GUI to the script you provided.
inspectorBtn.MouseButton1Click:Connect(function()
    print("Inspector button clicked!")
    
    -- NOTE: To make this actually play the animation from your script, 
    -- you must integrate this GUI script INSIDE your ServerAdmin() function.
    -- Specifically, it needs access to these variables from your script:
    -- RootJoint, Neck, RightShoulder, LeftShoulder, RightHip, LeftHip, ATTACK, Rooted
    
    -- Example of how it hooks up (assuming this block is pasted inside your ServerAdmin scope):
    --[[
    if reanimated == true and ATTACK == false then
        coroutine.resume(coroutine.create(function()
            ATTACK = true
            Rooted = true
            
            -- Your animation sequence here (Example: first few frames of IntroThing)
            for i=0, 0.4, 0.1 / Animation_Speed do
                Swait()
                RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0, -0.31, -0.65 + 0.05 * math.cos(SINE / 12)) * CFrame.Angles(math.rad(60), 0, 0), 1 / Animation_Speed)
                Neck.C0 = Clerp(Neck.C0, NECKC0 * CFrame.Angles(math.rad(0 - 2.5 * math.sin(SINE / 12)), 0, 0), 1 / Animation_Speed)
                RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.35, 0.5, -1.4) * CFrame.Angles(math.rad(65), 0, math.rad(-15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
                LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(0, math.rad(5), math.rad(-35)) * LEFTSHOULDERC0, 1 / Animation_Speed)
            end
            
            ATTACK = false
            Rooted = false
        end))
    end
    ]]
end)
