-- Executable Private FE Animations GUI

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Executor GUI Protection (Hides the GUI in CoreGui or gethui() if supported)
local guiParent = (gethui and gethui()) or pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or player:WaitForChild("PlayerGui")

-- Define colors
local themeColor = Color3.fromRGB(0, 255, 120) -- Custom Green
local grayColor = Color3.fromRGB(100, 100, 100) -- Mid-Gray for diamond

-- Prevent duplicate GUIs if the script runs multiple times
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

-- === CREATE THE CLOSE BUTTON ===
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 25)
closeButton.Position = UDim2.new(1, -35, 0, 5) -- Positioned in the top right
closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
closeButton.BorderSizePixel = 1
closeButton.BorderColor3 = Color3.fromRGB(255, 50, 50) -- Red border
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.TextColor3 = Color3.fromRGB(255, 50, 50) -- Red text
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeButton

-- Close button hover effect
closeButton.MouseEnter:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end)
closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    closeButton.TextColor3 = Color3.fromRGB(255, 50, 50)
end)

-- Close button click logic
closeButton.MouseButton1Click:Connect(function()
    mainGui:Destroy()
end)

-- === CREATE THE SPINNING DIAMOND ===
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
inspectorBtn.MouseButton1Click:Connect(function()
    -- This pcall ensures the GUI won't crash if it's run without the main FE script's variables
    local success, err = pcall(function()
        if reanimated == true and ATTACK == false then
            coroutine.resume(coroutine.create(function()
                ATTACK = true
                Rooted = true
                
                -- ONLY moves the hands behind the back, nothing else
                for i = 0, 2, 0.1 / Animation_Speed do
                    Swait()
                    RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.1, 0.3, 0.6) * CFrame.Angles(math.rad(-45), math.rad(-10), math.rad(-30)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
                    LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.1, 0.3, 0.6) * CFrame.Angles(math.rad(-45), math.rad(10), math.rad(30)) * LEFTSHOULDERC0, 1 / Animation_Speed)
                end
                
                ATTACK = false
                Rooted = false
            end))
        end
    end)
    
    if not success then
        warn("Animation failed to play. Make sure this script is executed alongside your FE Reanimation variables (Swait, Clerp, RootJoint, etc.). Error: " .. tostring(err))
    end
end)
