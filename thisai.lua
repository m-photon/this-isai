print("--- XENO GUI TEST START ---")

local player = game:GetService("Players").LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

local testGui = Instance.new("ScreenGui")
testGui.Name = "XenoTest"
testGui.Parent = guiParent

local testFrame = Instance.new("Frame")
testFrame.Size = UDim2.new(0, 200, 0, 100)
testFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
testFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Bright Red
testFrame.Parent = testGui

print("--- XENO GUI TEST END ---")
