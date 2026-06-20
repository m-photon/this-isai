-- // GUI Setup
local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "InspectorGUI"
-- If running via standard Studio, use PlayerGui. If executor, CoreGui is safer.
ScreenGui.Parent = game:GetService("CoreGui") 

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 120)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -60) -- Centered
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0.35, 0)
Title.BackgroundTransparency = 1
Title.Text = "Inspector Anim"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.Code
Title.TextScaled = true
Title.Parent = MainFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "Toggle"
ToggleButton.Size = UDim2.new(0.8, 0, 0.45, 0)
ToggleButton.Position = UDim2.new(0.1, 0, 0.45, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleButton.Text = "OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.Code
ToggleButton.TextScaled = true
ToggleButton.Parent = MainFrame

-- // Procedural Animation Variables
local playing = false
local SINE = 0
local RAD = math.rad
local COS = math.cos
local CF = CFrame.new
local ANGLES = CFrame.Angles
local connection = nil

-- Base R6 C0 Joint Angles (Needed for math offsets and resetting)
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local RIGHTHIPC0 = CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTHIPC0 = CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))

-- // The Toggle Logic
ToggleButton.MouseButton1Click:Connect(function()
	playing = not playing
	
	local char = player.Character
	if not char or not char:FindFirstChild("Humanoid") then return end
	
	-- Rig Check (Script math is built for R6)
	if char.Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
		warn("Inspector Animation requires an R6 rig to function properly!")
		playing = false
		return
	end

	local RootJoint = char.HumanoidRootPart:FindFirstChild("RootJoint")
	local Neck = char.Torso:FindFirstChild("Neck")
	local RightShoulder = char.Torso:FindFirstChild("Right Shoulder")
	local LeftShoulder = char.Torso:FindFirstChild("Left Shoulder")
	local RightHip = char.Torso:FindFirstChild("Right Hip")
	local LeftHip = char.Torso:FindFirstChild("Left Hip")

	if playing then
		-- Turn ON
		ToggleButton.Text = "ON"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		
		-- Disable standard default animations so they don't fight our math
		char.Animate.Disabled = true

		connection = runService.Heartbeat:Connect(function()
			SINE = SINE + 1
			
			-- The extracted signature procedural math from your script
			if RootJoint then
				RootJoint.C0 = RootJoint.C0:lerp(ROOTC0 * CF(0 - 0.04 * COS(SINE / 24), 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0 - 2.5 * COS(SINE / 24)), RAD(0)), 0.1)
			end
			if Neck then
				Neck.C0 = Neck.C0:lerp(NECKC0 * CF(0, 0, 0) * ANGLES(RAD(3 - 7 * COS(SINE / 12)), RAD(0), RAD(0)), 0.1)
			end
			if RightShoulder then
				RightShoulder.C0 = RightShoulder.C0:lerp(CF(1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-45 - 1.5 * COS(SINE / 12)), RAD(0), RAD(-45)) * ANGLES(RAD(0), RAD(25), RAD(0)) * RIGHTSHOULDERC0, 0.1)
			end
			if LeftShoulder then
				LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-44 - 1.5 * COS(SINE / 12)), RAD(0), RAD(45)) * ANGLES(RAD(0), RAD(-25), RAD(0)) * LEFTSHOULDERC0, 0.1)
			end
			if RightHip then
				RightHip.C0 = RightHip.C0:lerp(CF(1, -1 + 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-2 - 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 0.1)
			end
			if LeftHip then
				LeftHip.C0 = LeftHip.C0:lerp(CF(-1, -1 - 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-2 + 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 0.1)
			end
		end)
	else
		-- Turn OFF
		ToggleButton.Text = "OFF"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		
		if connection then 
			connection:Disconnect() 
		end
		
		-- Re-enable standard animations
		char.Animate.Disabled = false
		
		-- Reset all joints back to their default structural states
		if RootJoint then RootJoint.C0 = ROOTC0 end
		if Neck then Neck.C0 = NECKC0 end
		if RightShoulder then RightShoulder.C0 = RIGHTSHOULDERC0 end
		if LeftShoulder then LeftShoulder.C0 = LEFTSHOULDERC0 end
		if RightHip then RightHip.C0 = RIGHTHIPC0 end
		if LeftHip then LeftHip.C0 = LEFTHIPC0 end
	end
end)
