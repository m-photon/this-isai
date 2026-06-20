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
local isSpawning = false
local SINE = 0
local RAD = math.rad
local COS = math.cos
local SIN = math.sin
local CF = CFrame.new
local ANGLES = CFrame.Angles

local fakeCharModel = nil
local loopConnection = nil
local physicsConnection = nil

-- Rig Constraints
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))

-- // Cleanup
local function CleanupReanimation()
	playing = false
	isSpawning = false
	ToggleButton.Text = "OFF"
	ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	
	if loopConnection then loopConnection:Disconnect() end
	if physicsConnection then physicsConnection:Disconnect() end
	
	if fakeCharModel then 
		fakeCharModel:Destroy() 
		fakeCharModel = nil
	end
	
	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			workspace.CurrentCamera.CameraSubject = hum
			hum.Health = 0 -- Force cleanly respawn
		end
	end
end

player.CharacterAdded:Connect(function(newChar)
	if playing then CleanupReanimation() end
end)

-- // Toggle Logic
ToggleButton.MouseButton1Click:Connect(function()
	if isSpawning then return end
	if playing then 
		CleanupReanimation()
		return 
	end 
	
	local char = player.Character
	if not char or not char:FindFirstChild("Humanoid") then return end
	
	if char.Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
		ToggleButton.Text = "MUST BE R6!"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
		task.wait(2)
		ToggleButton.Text = "OFF"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		return
	end
	
	isSpawning = true
	ToggleButton.Text = "LOADING (5s)..."
	ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
	
	-- 1. Create the Fake Character
	char.Archivable = true
	fakeCharModel = char:Clone()
	fakeCharModel.Name = "FakeCharacter"
	char.Archivable = false
	
	for _, v in pairs(fakeCharModel:GetChildren()) do
		if v:IsA("LocalScript") or v:IsA("Script") then
			v:Destroy()
		end
		if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 1 
		end
	end
	
	fakeCharModel:SetPrimaryPartCFrame(char:GetPrimaryPartCFrame())
	fakeCharModel.Parent = workspace
	
	-- Disable collisions between real and fake parts during the wait
	for _, realPart in pairs(char:GetChildren()) do
		if realPart:IsA("BasePart") then
			for _, fakePart in pairs(fakeCharModel:GetChildren()) do
				if fakePart:IsA("BasePart") then
					local ncc = Instance.new("NoCollisionConstraint")
					ncc.Part0 = realPart
					ncc.Part1 = fakePart
					ncc.Parent = fakeCharModel
				end
			end
		end
	end
	
	-- 2. Netless Angular Velocity Trick
	local realHRP = char:FindFirstChild("HumanoidRootPart")
	if realHRP then
		local bav = Instance.new("BodyAngularVelocity")
		bav.Name = "NetlessSpin"
		bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		bav.P = 1e27
		bav.AngularVelocity = Vector3.new(10000, 10000, 10000)
		bav.Parent = realHRP
	end
	
	-- 3. Perma-Death Swap Sequence
	task.spawn(function()
		-- Claim network ownership sequence
		player.Character = fakeCharModel
		workspace.CurrentCamera.CameraSubject = fakeCharModel:FindFirstChildOfClass("Humanoid")
		task.wait(2.5)
		
		player.Character = char
		task.wait(3)
		
		-- Kill character AFTER the wait
		if char and char:FindFirstChild("Humanoid") then
			char:BreakJoints()
			if char:FindFirstChild("Animate") then char.Animate.Disabled = true end
			char.Humanoid.AutoRotate = false
		end
		
		local FakeRoot = fakeCharModel.HumanoidRootPart.RootJoint
		local FakeNeck = fakeCharModel.Torso.Neck
		local FakeRS = fakeCharModel.Torso["Right Shoulder"]
		local FakeLS = fakeCharModel.Torso["Left Shoulder"]
		local FakeRH = fakeCharModel.Torso["Right Hip"]
		local FakeLH = fakeCharModel.Torso["Left Hip"]
		
		-- 4. Start Math Loops ONLY after death occurs
		loopConnection = runService.Stepped:Connect(function()
			if not fakeCharModel or not fakeCharModel:FindFirstChild("HumanoidRootPart") then return end
			SINE = SINE + 2
			
			local fakeHum = fakeCharModel:FindFirstChildOfClass("Humanoid")
			local velocity = (fakeCharModel.HumanoidRootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude
			local walkSpeedValue = 8 / (fakeHum.WalkSpeed / 16)
			
			-- Procedural Math
			if velocity > 1 then
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
			
			-- Forward Inputs
			if char:FindFirstChildOfClass("Humanoid") then
				fakeHum:WalkToPoint(fakeCharModel.HumanoidRootPart.Position + char:FindFirstChildOfClass("Humanoid").MoveDirection * 100)
				if char:FindFirstChildOfClass("Humanoid").Jump then fakeHum.Jump = true end
			end
			
			-- Teleport Real Limbs
			for _, part in pairs(char:GetChildren()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
					local targetPart = fakeCharModel:FindFirstChild(part.Name)
					if targetPart and part.Name ~= "HumanoidRootPart" then
						part.CFrame = targetPart.CFrame
					end
				end
			end
			
			-- Hide Real RootPart safely underground
			if realHRP and fakeCharModel:FindFirstChild("Torso") then
				realHRP.CFrame = CF(fakeCharModel.Torso.Position.X, fakeCharModel.Torso.Position.Y - 45, fakeCharModel.Torso.Position.Z)
			end
		end)
		
		physicsConnection = runService.Heartbeat:Connect(function()
			for _, part in pairs(char:GetChildren()) do
				if part:IsA("BasePart") then
					if part.Name == "HumanoidRootPart" then
						part.Velocity = Vector3.new(20, 0, 20)
					else
						part.Velocity = Vector3.new(-17.7, 0, -17.7)
					end
				end
			end
		end)
		
		playing = true
		isSpawning = false
		ToggleButton.Text = "FE ACTIVE"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		workspace.CurrentCamera.CameraSubject = fakeCharModel:FindFirstChildOfClass("Humanoid")
	end)
end)
