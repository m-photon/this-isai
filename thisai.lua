-- Wait for the player and their GUI to load
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create the main ScreenGui
local spunchGui = Instance.new("ScreenGui")
spunchGui.Name = "SpunchbubExecutor"
spunchGui.ResetOnSpawn = false
spunchGui.Parent = playerGui

-- Create the Main Frame (SpongeBob Yellow Background)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(243, 236, 116) -- Spunchbub yellow
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.Active = true
mainFrame.Parent = spunchGui

-- Create the Top Bar/Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(200, 190, 50) -- Darker yellow for contrast
titleLabel.BorderSizePixel = 0
titleLabel.Text = " spunchbub executor v1.0"
titleLabel.Font = Enum.Font.Cartoon
titleLabel.TextSize = 24
titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- Add a funny sponge emoji to the top right
local faceLabel = Instance.new("TextLabel")
faceLabel.Name = "Icon"
faceLabel.Size = UDim2.new(0, 40, 0, 40)
faceLabel.Position = UDim2.new(1, -45, 0, 0)
faceLabel.BackgroundTransparency = 1
faceLabel.Text = "🧽"
faceLabel.TextSize = 28
faceLabel.Parent = mainFrame

-- Create the Code Editor Box
local editor = Instance.new("TextBox")
editor.Name = "Editor"
editor.Size = UDim2.new(1, -20, 1, -100)
editor.Position = UDim2.new(0, 10, 0, 50)
editor.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark theme editor
editor.TextColor3 = Color3.fromRGB(200, 200, 200)
editor.Text = "-- aw hell naw spunchbub took 40 benadryls\n\nprint('Ready to execute!')"
editor.Font = Enum.Font.Code
editor.TextSize = 14
editor.TextXAlignment = Enum.TextXAlignment.Left
editor.TextYAlignment = Enum.TextYAlignment.Top
editor.ClearTextOnFocus = false
editor.MultiLine = true
editor.Parent = mainFrame

-- Function to generate buttons easily
local function createButton(name, text, pos)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 100, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 200) -- Ocean/Bikini Bottom blue
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    btn.Text = text
    btn.Font = Enum.Font.Cartoon
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = mainFrame
    return btn
end

-- Create the Bottom Buttons
local execBtn = createButton("Execute", "Execute", UDim2.new(0, 10, 1, -45))
local clearBtn = createButton("Clear", "Clear", UDim2.new(0, 120, 1, -45))
local attachBtn = createButton("Attach", "Attach", UDim2.new(1, -110, 1, -45))

-- Wire up the Clear button
clearBtn.MouseButton1Click:Connect(function()
    editor.Text = ""
end)

-- Make the GUI Draggable
local UserInputService = game:GetService("UserInputService")
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
