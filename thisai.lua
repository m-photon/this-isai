-- // GUI Setup
local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FE_InspectorGUI"
ScreenGui.Parent = game:GetService("CoreGui") 

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 120)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -60)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0.35, 0)
Title.BackgroundTransparency = 1
Title.Text = "FE Inspector Anim"
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

-- // State & Animation Variables
local playing = false
local SINE = 0
local RAD = math.rad
local COS = math.cos
local SIN = math.sin
local CF = CFrame.new
local ANGLES = CFrame.Angles

local fakeCharModel = nil
local loopConnection = nil
local physicsConnection = nil

-- Rig Constraints for the Fake Character Model
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))

-- // Toggle Logic
ToggleButton.MouseButton1Click:Connect(function()
	if playing then return end 
	
	-- Fetch the character dynamically at the moment of the click
	local char = player.Character
	if not char or not char:FindFirstChild("Humanoid") then return end
	
	-- Visible Rig Check
	if char.Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
		ToggleButton.Text = "MUST BE R6!"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
		task.wait(2)
		if not playing then
			ToggleButton.Text = "OFF"
			ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		end
		return
	end
	
	playing = true
	ToggleButton.Text = "FE ACTIVE"
	ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
	ToggleButton.AutoButtonColor = false
	
	-- // Setup Reanimation
	char.Archivable = true
	fakeCharModel = char:Clone()
	fakeCharModel.Name = "FakeCharacter"
	
	for _, v in pairs(fakeCharModel:GetChildren()) do
		if v:IsA("LocalScript") or v:IsA("Script") or v:IsA("Accessory") then
			v:Destroy()
		end
		if v:IsA("BasePart") then
			v.Transparency = 1 
			v.CanCollide = false
		end
	end
	
	-- Ensure the fake character starts exactly where you are standing
	fakeCharModel:SetPrimaryPartCFrame(char:GetPrimaryPartCFrame())
	fakeCharModel.Parent = workspace
	char.Archivable = false
	
	if char:FindFirstChild("Animate") then char.Animate.Disabled = true end
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then 
		humanoid.BreakJointsOnDeath = false
		humanoid.Health = 0 
	end
	char:BreakJoints()
	
	settings().Physics.AllowSleep = false
	settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalThrottle.Disabled
	workspace.CurrentCamera.CameraSubject = fakeCharModel:FindFirstChildOfClass("Humanoid")
	
	-- // Math Setup
	local FakeRoot = fakeCharModel.HumanoidRootPart.RootJoint
	local FakeNeck = fakeCharModel.Torso.Neck
	local FakeRS = fakeCharModel.Torso["Right Shoulder"]
	local FakeLS = fakeCharModel.Torso["Left Shoulder"]
	local FakeRH = fakeCharModel.Torso["Right Hip"]
	local FakeLH = fakeCharModel.Torso["Left Hip"]
	
	-- Core tracking loops
	loopConnection = runService.Stepped:Connect(function()
		SINE = SINE + 2
		
		local fakeHum = fakeCharModel:FindFirstChildOfClass("Humanoid")
		local velocity = (fakeCharModel.HumanoidRootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude
		local walkSpeedValue = 8 / (fakeHum.WalkSpeed / 16)
		
		if velocity > 1 then
			-- /// WALKING ///
			FakeRoot.C0 = FakeRoot.C0:lerp(ROOTC0 * CF(0, 0, -0.05) * ANGLES(RAD(5), RAD(0), RAD(-7 * COS(SINE / walkSpeedValue))), 0.2)
			FakeRoot.C1 = FakeRoot.C1:lerp(ROOTC0 * CF(0, 0, 0.1 * COS(SINE / (walkSpeedValue/2))) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2)
			FakeNeck.C0 = FakeNeck.C0:lerp(NECKC0 * CF(0, 0, 0) * ANGLES(RAD(5 - 1 * SIN(SINE / (walkSpeedValue / 2))), RAD(0), RAD(7 * COS(SINE / walkSpeedValue))), 0.2)
			FakeNeck.C1 = FakeNeck.C1:lerp(CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)), 0.2)
			FakeRS.C0 = FakeRS.C0:lerp(CF(1.5, 0.5, 0) * ANGLES(RAD(60 * COS(SINE / walkSpeedValue)), RAD(-5), RAD(5)) * RIGHTSHOULDERC0, 0.2)
			FakeLS.C0 = FakeLS.C0:lerp(CF(-1.5, 0.5, 0) * ANGLES(RAD(-60 * COS(SINE / walkSpeedValue)), RAD(5), RAD(-5)) * LEFTSHOULDERC0, 0.2)
			FakeRH.C0 = FakeRH.C0:lerp(CF(1 , -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2)
			FakeLH.C0 = FakeLH.C0:lerp(CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2)
			FakeRH.C1 = FakeRH.C1:lerp(CF(0.5, 0.875 - 0.125 * SIN(SINE / walkSpeedValue) - 0.15 * COS(SINE / walkSpeedValue*2), 0.25 * SIN(SINE / walkSpeedValue)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10+50 * COS(SINE / walkSpeedValue))), 0.2)
			FakeLH.C1 = FakeLH.C1:lerp(CF(-0.5, 0.875 + 0.125 * SIN(SINE / walkSpeedValue) - 0.15 * COS(SINE / walkSpeedValue*2), -0.25 * SIN(SINE / walkSpeedValue)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-10+50 * COS(SINE / walkSpeedValue))), 0.2)
		else
			-- /// IDLE ///
			FakeRoot.C0 = FakeRoot.C0:lerp(ROOTC0 * CF(0 - 0.04 * COS(SINE / 24), 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0 - 2.5 * COS(SINE / 24)), RAD(0)), 0.1)
			FakeRoot.C1 = FakeRoot.C1:lerp(ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.1)
			FakeNeck.C0 = FakeNeck.C0:lerp(NECKC0 * CF(0, 0, 0) * ANGLES(RAD(3 - 7 * COS(SINE / 12)), RAD(0), RAD(0)), 0.1)
			FakeNeck.C1 = FakeNeck.C1:lerp(CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)), 0.1)
			FakeRS.C0 = FakeRS.C0:lerp(CF(1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-45 - 1.5 * COS(SINE / 12)), RAD(0), RAD(-45)) * ANGLES(RAD(0), RAD(25), RAD(0)) * RIGHTSHOULDERC0, 0.1)
			FakeLS.C0 = FakeLS.C0:lerp(CF(-1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-44 - 1.5 * COS(SINE / 12)), RAD(0), RAD(45)) * ANGLES(RAD(0), RAD(-25), RAD(0)) * LEFTSHOULDERC0, 0.1)
			FakeRH.C0 = FakeRH.C0:lerp(CF(1, -1 + 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-2 - 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 0.1)
			FakeLH.C0 = FakeLH.C0:lerp(CF(-1, -1 - 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-2 + 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 0.1)
			FakeRH.C1 = FakeRH.C1:lerp(CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.1)
			FakeLH.C1 = FakeLH.C1:lerp(CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.1)
		end
		
		fakeHum:Move(char:FindFirstChildOfClass("Humanoid").MoveDirection, true)
		if char:FindFirstChildOfClass("Humanoid").Jump then fakeHum.Jump = true end
		
		for _, part in pairs(char:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
				local targetPart = fakeCharModel:FindFirstChild(part.Name)
				if targetPart then
					part.CFrame = targetPart.CFrame
				end
			end
		end
		
		if char:FindFirstChild("HumanoidRootPart") and fakeCharModel:FindFirstChild("Torso") then
			char.HumanoidRootPart.CFrame = CF(fakeCharModel.Torso.Position.X, -150, fakeCharModel.Torso.Position.Z)
		end
	end)
	
	physicsConnection = runService.Heartbeat:Connect(function()
		for _, part in pairs(char:GetChildren()) do
			if part:IsA("BasePart") then
				if part.Name == "HumanoidRootPart" then
					part.Velocity = Vector3.new(30, 0, 30)
				else
					part.Velocity = Vector3.new(-30, 0, -30)
				end
			end
		end
	end)
end)
