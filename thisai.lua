-- FIXED KILL ROUTINE: Waits for the reanimation framework to build 
-- the FakeCharacter model BEFORE killing you, preventing the infinite yield loop.
local function executionKillRoutine()
    local InstantPlayer = game:GetService("Players").LocalPlayer
    local char = InstantPlayer.Character or InstantPlayer.CharacterAdded:Wait()
    if char then
        -- Wait a maximum of 5 seconds for the reanimation script to create FakeCharacter
        local fakeChar = char:WaitForChild("FakeCharacter", 5) 
        
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.Health = 0
        end
        char:BreakJoints()
    end
end

--Server Admin
local function ServerAdmin()
    --Variables
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local torso = nil
    
    -- Ensure FakeCharacter folder structure exists before building references
    local reanimFolder = character:WaitForChild("FakeCharacter", 5)
    if not reanimFolder then 
        warn("FakeCharacter failed to load in time!")
        return 
    end
    
    local reanimation = reanimFolder:WaitForChild("Reanimation")
    local cTorso = reanimation:WaitForChild("Torso")
    local cHRP = reanimation:WaitForChild("HumanoidRootPart")
    
    --Reanimated
    reanimated = true
    
    if permaDeath == true and character:FindFirstChildOfClass("Humanoid") and character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
        torso = character:WaitForChild("Torso")
    end
        
    --Flinging
    local flinging = false
    local getChild = nil
    
    local function GetCHILD(CHILD)
        getChild = CHILD
    end
    
    --Netless--
    local glasses = nil
    local GWeld = nil
    local glassesReady = false
    local glassesList = "VarietyShades02"
    
    --Glasses
    for i,v in pairs(character:GetChildren()) do
        if v.Name == glassesList then
            glasses = reanimation:FindFirstChild(v.Name)
        end
    end
    
    if character:FindFirstChild("VarietyShades02") and glasses then
        GWeld = glasses.Handle:FindFirstChildWhichIsA("Weld")
    end
    
    local bodyAngularVelocity = Instance.new("BodyAngularVelocity", hrp)
    bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyAngularVelocity.P = 1000000000000000000000000000
    bodyAngularVelocity.AngularVelocity = Vector3.new(10000, 10000, 10000)
    
    local function Positioning()
        local hum = character:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        
        --Positioning BodyParts
        for i,v in pairs(character:GetChildren()) do
            if v:IsA("Part") and v.Name ~= "HumanoidRootPart" and hum.RigType == Enum.HumanoidRigType.R6 then
                local targetPart = reanimation:FindFirstChild(v.Name)
                if targetPart then v.CFrame = targetPart.CFrame end
            end
        end
        
        --Flinging
        if flinging == true then
            if hum.RigType == Enum.HumanoidRigType.R15 and bodyAngularVelocity.AngularVelocity == Vector3.new(0, 0, 0) then
                bodyAngularVelocity.AngularVelocity = Vector3.new(10000, 10000, 10000)
            end
            
            if getChild and getChild:FindFirstChild("Torso") then
                hrp.Position = getChild.Torso.Position
            elseif getChild and getChild:FindFirstChild("UpperTorso") then
                hrp.Position = getChild.UpperTorso.Position
            end
        else
            if hum.RigType == Enum.HumanoidRigType.R6 then
                hrp.Position = Vector3.new(reanimation.Torso.Position.X, -50, reanimation.Torso.Position.Z)
            else
                hrp.Position = reanimation.Torso.Position
                if bodyAngularVelocity.AngularVelocity == Vector3.new(10000, 10000, 10000) then
                    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
                end
            end
        end
        
        --R15
        if hum.RigType == Enum.HumanoidRigType.R15 then
            if character:FindFirstChild("Head") then character.Head.CFrame = reanimation.Head.CFrame end
            if character:FindFirstChild("UpperTorso") then character.UpperTorso.CFrame = reanimation.Torso.CFrame * CFrame.new(0, 0.185, 0) end
            if character:FindFirstChild("LowerTorso") then character.LowerTorso.CFrame = reanimation.Torso.CFrame * CFrame.new(0, -0.8, 0) end
            
            if character:FindFirstChild("LeftUpperArm") then character.LeftUpperArm.CFrame = reanimation["Left Arm"].CFrame * CFrame.new(0, 0.4, 0) end
            if character:FindFirstChild("LeftLowerArm") then character.LeftLowerArm.CFrame = reanimation["Left Arm"].CFrame * CFrame.new(0, -0.19, 0) end
            if character:FindFirstChild("LeftHand") then character.LeftHand.CFrame = reanimation["Left Arm"].CFrame * CFrame.new(0, -0.84, 0) end
            
            if character:FindFirstChild("RightUpperArm") then character.RightUpperArm.CFrame = reanimation["Right Arm"].CFrame * CFrame.new(0, 0.4, 0) end
            if character:FindFirstChild("RightLowerArm") then character.RightLowerArm.CFrame = reanimation["Right Arm"].CFrame * CFrame.new(0, -0.19, 0) end
            if character:FindFirstChild("RightHand") then character.RightHand.CFrame = reanimation["Right Arm"].CFrame * CFrame.new(0, -0.84, 0) end
        end
        
        game:GetService("RunService").Heartbeat:Wait()
    end
    
    local Player = game:GetService("Players").LocalPlayer
    local PlayerGui = Player.PlayerGui
    local Mouse = Player:GetMouse()
    local Cam = workspace.CurrentCamera
    local Backpack = Player.Backpack
    
    local Character = reanimation
    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
    local RootPart = Character["HumanoidRootPart"]
    local Torso = Character["Torso"]
    local Head = Character["Head"]
    
    local hrpPart = Player.Character:WaitForChild("HumanoidRootPart")
    hrpPart.Transparency = 0
    
    local IT = Instance.new
    local CF = CFrame.new
    local VT = Vector3.new
    local RAD = math.rad
    local ANGLES = CFrame.Angles
    
    local ArtificialHB = Instance.new("BindableEvent", script)
    ArtificialHB.Name = "ArtificialHB"
    
    local frame = 1 / 60
    local tf = 0
    
    game:GetService("RunService").Heartbeat:Connect(function(s)
        tf = tf + s
        if tf >= frame then
            for i = 1, math.floor(tf / frame) do
                ArtificialHB:Fire()
            end
            tf = tf - frame * math.floor(tf / frame)
        end
    end)
    
    function Swait(NUMBER)
        if NUMBER == 0 or NUMBER == nil then
            ArtificialHB.Event:Wait()
        else
            for i = 1, NUMBER do
                ArtificialHB.Event:Wait()
            end
        end
    end

    local MSH = true 
    if MSH then
        local TIME = 10
        for LOOP = 1, TIME+1 do
            Swait()
        end
    end
end

-- Button Trigger Setup
PermanentReanimation.MouseButton1Click:Connect(function()
    permaDeath = true
    -- We run ServerAdmin first to kick off the initialization checks, 
    -- then process the execution kill routine smoothly.
    task.spawn(ServerAdmin)
    task.spawn(executionKillRoutine)
end)
