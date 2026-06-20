--GUI
local NetlessServerAdmin = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Outline = Instance.new("Frame")
local InfoButton = Instance.new("TextButton")
local Reanimation = Instance.new("TextButton")
local Credits = Instance.new("TextButton")
local EverythingFrame = Instance.new("ScrollingFrame")
local ReanimationFrame = Instance.new("Frame")
local PermanentReanimation = Instance.new("TextButton")
local BotReanimation = Instance.new("TextButton")
local ReanimInfo = Instance.new("TextLabel")
local InfoFrame = Instance.new("Frame")
local Info = Instance.new("TextLabel")
local CreditsFrame = Instance.new("Frame")
local CreditsText = Instance.new("TextLabel")
local CopiedLink = Instance.new("TextLabel")
local Discord = Instance.new("TextButton")

NetlessServerAdmin.Name = "NetlessServerAdmin"
NetlessServerAdmin.Parent = game.CoreGui
NetlessServerAdmin.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = NetlessServerAdmin
MainFrame.Active = true
MainFrame.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
MainFrame.Position = UDim2.new(0.0645398498, 0, 0.427597612, 0)
MainFrame.Selectable = true
MainFrame.Size = UDim2.new(0, 319, 0, 238)
MainFrame.Draggable = true

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Size = UDim2.new(0, 318, 0, 19)
Title.Font = Enum.Font.Code
Title.Text = "FE Server Admin"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

Outline.Name = "Outline"
Outline.Parent = MainFrame
Outline.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
Outline.BorderColor3 = Color3.fromRGB(0, 255, 0)
Outline.BorderSizePixel = 3
Outline.Position = UDim2.new(0.335000008, 0, 0.104999997, 0)
Outline.Size = UDim2.new(0, 101, 0, 28)

InfoButton.Name = "InfoButton"
InfoButton.Parent = MainFrame
InfoButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InfoButton.BackgroundTransparency = 1.000
InfoButton.Position = UDim2.new(0.752060294, 0, 0.105042018, 0)
InfoButton.Size = UDim2.new(0, 79, 0, 28)
InfoButton.Font = Enum.Font.SourceSans
InfoButton.Text = "Info"
InfoButton.TextColor3 = Color3.fromRGB(0, 0, 0)
InfoButton.TextSize = 20.000
InfoButton.TextWrapped = true

Reanimation.Name = "Reanimation"
Reanimation.Parent = MainFrame
Reanimation.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Reanimation.BackgroundTransparency = 1.000
Reanimation.Position = UDim2.new(0.317328781, 0, 0.105042025, 0)
Reanimation.Size = UDim2.new(0, 115, 0, 28)
Reanimation.Font = Enum.Font.SourceSans
Reanimation.Text = "Reanimation"
Reanimation.TextColor3 = Color3.fromRGB(0, 0, 0)
Reanimation.TextSize = 20.000
Reanimation.TextWrapped = true

Credits.Name = "Credits"
Credits.Parent = MainFrame
Credits.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Credits.BackgroundTransparency = 1.000
Credits.Position = UDim2.new(-0.000290811062, 0, 0.105042018, 0)
Credits.Size = UDim2.new(0, 79, 0, 28)
Credits.Font = Enum.Font.SourceSans
Credits.Text = "Credits"
Credits.TextColor3 = Color3.fromRGB(0, 0, 0)
Credits.TextSize = 20.000
Credits.TextWrapped = true

EverythingFrame.Name = "EverythingFrame"
EverythingFrame.Parent = MainFrame
EverythingFrame.Active = true
EverythingFrame.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
EverythingFrame.Position = UDim2.new(0, 0, 0.275999993, 0)
EverythingFrame.Size = UDim2.new(0, 319, 0, 172)
EverythingFrame.CanvasSize = UDim2.new(3, 0, 0, 0)
EverythingFrame.CanvasPosition = Vector2.new(319, 0)
EverythingFrame.ScrollingEnabled = false
EverythingFrame.ScrollBarImageTransparency = 1

ReanimationFrame.Name = "ReanimationFrame"
ReanimationFrame.Parent = EverythingFrame
ReanimationFrame.Active = true
ReanimationFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
ReanimationFrame.Position = UDim2.new(0.333000004, 0, 0, 0)
ReanimationFrame.Selectable = true
ReanimationFrame.Size = UDim2.new(0, 319, 0, 159)

PermanentReanimation.Name = "PermanentReanimation"
PermanentReanimation.Parent = ReanimationFrame
PermanentReanimation.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
PermanentReanimation.Position = UDim2.new(0.0478076488, 0, 0.01581534, 0)
PermanentReanimation.Size = UDim2.new(0, 289, 0, 29)
PermanentReanimation.Style = Enum.ButtonStyle.RobloxRoundDropdownButton
PermanentReanimation.Font = Enum.Font.SourceSans
PermanentReanimation.Text = "Permanent"
PermanentReanimation.TextColor3 = Color3.fromRGB(0, 0, 0)
PermanentReanimation.TextSize = 20.000
PermanentReanimation.TextWrapped = true
PermanentReanimation.TextXAlignment = Enum.TextXAlignment.Left

BotReanimation.Name = "BotReanimation"
BotReanimation.Parent = ReanimationFrame
BotReanimation.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
BotReanimation.Position = UDim2.new(0.0477184951, 0, 0.232129261, 0)
BotReanimation.Size = UDim2.new(0, 289, 0, 29)
BotReanimation.Style = Enum.ButtonStyle.RobloxRoundDropdownButton
BotReanimation.Font = Enum.Font.SourceSans
BotReanimation.Text = "Bot"
BotReanimation.TextColor3 = Color3.fromRGB(0, 0, 0)
BotReanimation.TextSize = 20.000
BotReanimation.TextWrapped = true
BotReanimation.TextXAlignment = Enum.TextXAlignment.Left

ReanimInfo.Name = "ReanimInfo"
ReanimInfo.Parent = ReanimationFrame
ReanimInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ReanimInfo.BackgroundTransparency = 1.000
ReanimInfo.Position = UDim2.new(0.0130000096, 0, 0.411194909, 0)
ReanimInfo.Size = UDim2.new(0, 311, 0, 91)
ReanimInfo.Font = Enum.Font.SourceSans
ReanimInfo.Text = [[I accendentally changed the link of this script and I didn't notice until months later. But I changed it back. If anything like this happens again, I have a discord server that you can access any of my scripts in the credits tab.
OneReverseCard - 7/26/22]]

ReanimInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
ReanimInfo.TextScaled = true
ReanimInfo.TextSize = 20.000
ReanimInfo.TextWrapped = true

InfoFrame.Name = "InfoFrame"
InfoFrame.Parent = EverythingFrame
InfoFrame.Active = true
InfoFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
InfoFrame.Position = UDim2.new(0.666999996, 0, 0, 0)
InfoFrame.Selectable = true
InfoFrame.Size = UDim2.new(0, 319, 0, 159)

Info.Name = "Info"
Info.Parent = InfoFrame
Info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Info.BackgroundTransparency = 1.000
Info.Position = UDim2.new(0.0130000003, 0, 0.0199999996, 0)
Info.Size = UDim2.new(0, 311, 0, 155)
Info.Font = Enum.Font.SourceSans
Info.Text = [[- Since there's no hat fling, each reanimation is going to put you into perma death.
- You can use Stylish Aviators (as the glasses) with this script (but it's not required).
- The GUI now won't be destroyed when you die before reanimating.]]
Info.TextColor3 = Color3.fromRGB(255, 255, 255)
Info.TextSize = 20.000
Info.TextWrapped = true
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.TextYAlignment = Enum.TextYAlignment.Top

CreditsFrame.Name = "CreditsFrame"
CreditsFrame.Parent = EverythingFrame
CreditsFrame.Active = true
CreditsFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
CreditsFrame.Selectable = true
CreditsFrame.Size = UDim2.new(0, 319, 0, 159)

CreditsText.Name = "CreditsText"
CreditsText.Parent = CreditsFrame
CreditsText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CreditsText.BackgroundTransparency = 1.000
CreditsText.Position = UDim2.new(0.00940438919, 0, 0.0151445884, 0)
CreditsText.Size = UDim2.new(0, 308, 0, 87)
CreditsText.Font = Enum.Font.SourceSans
CreditsText.Text = [[- Orignal Script By SHACKLUSTER (Unsure)
- Converted To SS By SpaceAviator (Unsure)
- Converted To FE By ONEReverseCard#5311 With Help From ShownApe#1111]]
CreditsText.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditsText.TextScaled = true
CreditsText.TextSize = 20.000
CreditsText.TextWrapped = true
CreditsText.TextXAlignment = Enum.TextXAlignment.Left
CreditsText.TextYAlignment = Enum.TextYAlignment.Top

CopiedLink.Name = "CopiedLink"
CopiedLink.Parent = CreditsFrame
CopiedLink.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CopiedLink.BackgroundTransparency = 1.000
CopiedLink.Position = UDim2.new(0.184952974, 0, 0.746668756, 0)
CopiedLink.Size = UDim2.new(0, 200, 0, 35)
CopiedLink.Font = Enum.Font.SourceSans
CopiedLink.Text = "Copied Discord Server Link"
CopiedLink.TextColor3 = Color3.fromRGB(255, 255, 255)
CopiedLink.TextScaled = true
CopiedLink.TextSize = 14.000
CopiedLink.TextWrapped = true

Discord.Name = "Discord"
Discord.Parent = CreditsFrame
Discord.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Discord.Position = UDim2.new(0.0414489023, 0, 0.766720414, 0)
Discord.Size = UDim2.new(0, 289, 0, 29)
Discord.Style = Enum.ButtonStyle.RobloxRoundDropdownButton
Discord.Font = Enum.Font.SourceSans
Discord.Text = "Discord Server"
Discord.TextColor3 = Color3.fromRGB(0, 0, 0)
Discord.TextSize = 20.000
Discord.TextWrapped = true
Discord.TextXAlignment = Enum.TextXAlignment.Left

--Variables
local permaDeath = false
local bot = false
local pressingShift = false
local reanimated = false
local botHats = {}

-- FIXED: Wrapped the global perma-kill routine into a safe, reusable function 
-- instead of letting it fire instantly on line 1.
local function executionKillRoutine()
    local InstantPlayer = game:GetService("Players").LocalPlayer
    local char = InstantPlayer.Character or InstantPlayer.CharacterAdded:Wait()
    if char then
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.Health = 0
        end
        char:BreakJoints()
    end
end

--Resetting GUI Value
if not game.CoreGui:FindFirstChild("ResetGUIValue") then
    local resetGUIValue = Instance.new("BoolValue", game.CoreGui)
    resetGUIValue.Name = "ResetGUIValue"
end

--Server Admin
local function ServerAdmin()
    --Variables
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local torso = nil
    
    -- Ensure FakeCharacter folder structure exists before building references
    local reanimFolder = character:WaitForChild("FakeCharacter")
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
    
    --//====================================================\\--
    --||            CREATED BY SHACKLUSTER
    --//====================================================//--
    
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

    -- Cleaned up visual update block loop execution syntax bug
    local MSH = true 
    if MSH then
        local TIME = 10
        for LOOP = 1, TIME+1 do
            Swait()
        end
    end
end

-- To trigger your kill routine, assign it to your Reanimation UI buttons or your preferred load event, like this:
PermanentReanimation.MouseButton1Click:Connect(function()
    permaDeath = true
    executionKillRoutine() -- Fires perfectly right as the reanimation routine starts!
    ServerAdmin()
end)
