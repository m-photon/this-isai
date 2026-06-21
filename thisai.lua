-- Private FE Animations GUI (Studio UI Mockup)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Define the custom Green color theme
local themeColor = Color3.fromRGB(0, 255, 120) -- A sharp, lime/neon green

-- Prevent duplicate GUIs if the script runs multiple times
if playerGui:FindFirstChild("PrivateAnimationsGui") then
    playerGui.PrivateAnimationsGui:Destroy()
end

-- Create the main ScreenGui
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "PrivateAnimationsGui"
mainGui.ResetOnSpawn = false
mainGui.IgnoreGuiInset = true -- Better for full screen control
mainGui.Parent = playerGui

-- Create the Main Frame (Black Background with Green Border)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Deep black
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = themeColor -- Applied green border
mainFrame.Active = true
mainFrame.Parent = mainGui

-- Add a UICorner for smoother edges
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = mainFrame

-- Create the Top Bar/Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundColor3 = Color3.fromRGB(5, 5, 5) -- Slightly darker top bar
titleLabel.BorderSizePixel = 0
-- Modification: Updated title text
titleLabel.Text = " nos_dywll's private FE animations"
titleLabel.Font = Enum.Font.GothamBold -- Sleeker font than cartoon for this theme
titleLabel.TextSize = 16
-- Modification: Title text is now green
titleLabel.TextColor3 = themeColor 
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- Modification: The SpongeBob Icon (faceLabel) block has been removed.

-- Create the Code Editor Box
local editor = Instance.new("TextBox")
editor.Name = "Editor"
editor.Size = UDim2.new(1, -20, 1, -95)
editor.Position = UDim2.new(0, 10, 0, 45)
editor.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Slightly lighter black
editor.TextColor3 = Color3.fromRGB(220, 220, 220) -- Slightly dimmed white text
editor.Text = "-- private animation suite loaded\n-- waiting for selection..."
editor.Font = Enum.Font.Code
editor.TextSize = 14
editor.TextXAlignment = Enum.TextXAlignment.Left
editor.TextYAlignment = Enum.TextYAlignment.Top
editor.ClearTextOnFocus = false
editor.MultiLine = true
editor.Parent = mainFrame

local editorCorner = Instance.new("UICorner")
editorCorner.CornerRadius = UDim.new(0, 4)
editorCorner.Parent = editor

-- Function to generate green-themed buttons easily
local function createButton(name, text, pos)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 110, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark button backgrounds
    btn.BorderSizePixel = 1 -- Keeping border for structure
    btn.BorderColor3 = themeColor -- Applied green border to buttons
    btn.Text = text
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 16
    btn.TextColor3 = themeColor -- Button text is green
    btn.Parent = mainFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    -- Basic Hover Effect
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    
    return btn
end

-- Create the Bottom Buttons (Kept layout similar to executor for comparison)
local playBtn = createButton("Play", "Play", UDim2.new(0, 10, 1, -45))
local stopBtn = createButton("Stop", "Stop", UDim2.new(0, 130, 1, -45))
local configBtn = createButton("Config", "Config", UDim2.new(1, -120, 1, -45))

-- Wire up the Stop button (previously Clear) to clear the text
stopBtn.MouseButton1Click:Connect(function()
    editor.Text = "-- animations stopped\n-- buffer cleared"
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
