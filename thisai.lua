local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Simplified GUI Parenting for Executors (like Xeno)
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
buttonContainer.BackgroundTransparency = 0.5 -- See-through for the diamond
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
gridLayout.SortOrder = Enum.
