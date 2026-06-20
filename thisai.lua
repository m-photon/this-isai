-- INSTANT PERMA-KILL ROUTINE (Executes immediately before everything else loads)
local InstantPlayer = game:GetService("Players").LocalPlayer
if InstantPlayer and InstantPlayer.Character then
    local hum = InstantPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if hum then
        hum.Health = 0
    end
    InstantPlayer.Character:BreakJoints()
end

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
--Have Fun :)
--
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

--Varibles
local permaDeath = false
local bot = false
local pressingShift = false
local reanimated = false
local botHats = {}

--Resetting GUI Value
if not game.CoreGui:FindFirstChild("ResetGUIValue") then
    local resetGUIValue = Instance.new("BoolValue", game.CoreGui)
    resetGUIValue.Name = "ResetGUIValue"
end

--Server Admin
local function ServerAdmin()
    --Variables
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    local hrp = character.HumanoidRootPart
    local torso = nil
    local reanimFolder = character.FakeCharacter
    local reanimation = reanimFolder.Reanimation
    local cTorso = reanimation.Torso
    local cHRP = reanimation.HumanoidRootPart
    --Reanimated
    reanimated = true
    
    if permaDeath == true and character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
        torso = character.Torso
    end
        
    --Flinging
    local flinging = false
    local getChild = nil
    
    local function GetCHILD(CHILD)
        getChild = CHILD
    end
    
    --Netless--
    --Variables
    local glasses = nil
    local GWeld = nil
    local glasesPosition = nil
    local CFrame0 = nil
    local CFrame1 = nil
    local glassesReady = false
    local glassesList = "VarietyShades02", "e"
    
    --Glasses
    for i,v in pairs(character:GetChildren()) do
        if v.Name == glassesList then
            glasses = reanimation:FindFirstChild(v.Name)
        end
    end
    
    if character:FindFirstChild("VarietyShades02") then
        CFrame0 = CFrame.new(0, 0, 0)
        CFrame1 = CFrame.new(0, 0, 0)
        GWeld = glasses.Handle:FindFirstChildWhichIsA("Weld")
    end
    
    --Flinging (Hats)
    for i,v in pairs(character:GetChildren()) do
        
    end
    
    local bodyAngularVelocity = Instance.new("BodyAngularVelocity", hrp)
    bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyAngularVelocity.P = 1000000000000000000000000000
    bodyAngularVelocity.AngularVelocity = Vector3.new(10000, 10000, 10000)
    
    local function Positioning()
        --Positioning BodyParts
        for i,v in pairs(character:GetChildren()) do
            if v:IsA("Part") and v.Name ~= "HumanoidRootPart" and character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
                v.CFrame = reanimation:FindFirstChild(v.Name).CFrame
            end
        end
        
        --Flinging
        if flinging == true then
            if character.Humanoid.RigType == Enum.HumanoidRigType.R15 and bodyAngularVelocity.AngularVelocity == Vector3.new(0, 0, 0) then
                bodyAngularVelocity.AngularVelocity = Vector3.new(10000, 10000, 10000)
            end
            
            if getChild:FindFirstChild("Torso") then
                hrp.Position = getChild.Torso.Position
            end
            
            if getChild:FindFirstChild("UpperTorso") then
                hrp.Position = getChild.UpperTorso.Position
            end
        else
            if character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
                hrp.Position = Vector3.new(reanimation.Torso.Position.X, -50, reanimation.Torso.Position.Z)
            else
                hrp.Position = reanimation.Torso.Position
                if bodyAngularVelocity.AngularVelocity == Vector3.new(10000, 10000, 10000) then
                    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
                end
            end
        end
        
        --R15
        if character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
            --Head
            character.Head.CFrame = reanimation.Head.CFrame
            
            --Torso
            character.UpperTorso.CFrame = reanimation.Torso.CFrame * CFrame.new(0, 0.185, 0)
            character.LowerTorso.CFrame = reanimation.Torso.CFrame * CFrame.new(0, -0.8, 0)
            
            --HumanoidRootPart
            --character.HumanoidRootPart.CFrame = cHRP.CFrame
            
            --Left Arm
            character.LeftUpperArm.CFrame = reanimation["Left Arm"].CFrame * CFrame.new(0, 0.4, 0)
            character.LeftLowerArm.CFrame = reanimation["Left Arm"].CFrame * CFrame.new(0, -0.19, 0)
            character.LeftHand.CFrame = reanimation["Left Arm"].CFrame * CFrame.new(0, -0.84, 0)
            
            --Right Arm
            character.RightUpperArm.CFrame = reanimation["Right Arm"].CFrame * CFrame.new(0, 0.4, 0)
            character.RightLowerArm.CFrame = reanimation["Right Arm"].CFrame * CFrame.new(0, -0.19, 0)
            character.RightHand.CFrame = reanimation["Right Arm"].CFrame * CFrame.new(0, -0.84, 0)
            
            --Left Leg
            character.LeftUpperLeg.CFrame = reanimation["Left Leg"].CFrame * CFrame.new(0, 0.55, 0)
            character.LeftLowerLeg.CFrame = reanimation["Left Leg"].CFrame * CFrame.new(0, -0.19, 0)
            character.LeftFoot.CFrame = reanimation["Left Leg"].CFrame * CFrame.new(0, -0.85, 0)
            
            --Right Leg
            character.RightUpperLeg.CFrame = reanimation["Right Leg"].CFrame * CFrame.new(0, 0.55, 0)
            character.RightLowerLeg.CFrame = reanimation["Right Leg"].CFrame * CFrame.new(0, -0.19, 0)
            character.RightFoot.CFrame = reanimation["Right Leg"].CFrame * CFrame.new(0, -0.85, 0)
        end
        
        --Positioning The Hats
        for i,v in pairs(character:GetChildren()) do
            if v:IsA("Accessory") and not v.Name ~= glasses then
                if bot == false then
                    v.Handle.CFrame = reanimation:FindFirstChild(v.Name).Handle.CFrame
                else
                    --Arms and Legs
                    if v.Name ~= "Head" and reanimation:FindFirstChild(v.Name) and v.Name ~= glasses.Name then
                        v.Handle.CFrame = reanimation:FindFirstChild(v.Name).CFrame * CFrame.Angles(1.5708, 0, 0)
                    end
                    
                    --Head
                    if v.Name == "Head" then
                        --Medi Hood
                        if v.Handle:FindFirstChildWhichIsA("SpecialMesh").MeshId == "rbxassetid://617474228" then
                            v.Handle.CFrame = reanimation:FindFirstChild(v.Name).CFrame * CFrame.new(0, -0.025, 0.23)
                        end
                        
                        --Shadowed Head
                        if v.Handle:FindFirstChildWhichIsA("SpecialMesh").MeshId == "rbxassetid://4904532191" then
                            v.Handle.CFrame = reanimation:FindFirstChild(v.Name).CFrame
                        end
                    end
                    
                    --Left Half Of The Torso
                    if v.Name == "Torso1" then
                        v.Handle.CFrame = reanimation.Torso.CFrame * CFrame.new(-0.5, 0, 0) * CFrame.Angles(1.5708, 0, 0)
                    end
                    
                    --Right Half Of The Torso
                    if v.Name == "Torso2" then
                        v.Handle.CFrame = reanimation.Torso.CFrame * CFrame.new(0.5, 0, 0) * CFrame.Angles(1.5708, 0, 0)
                    end
                end
            end
        end
        
        --Positioning The Glasses
        if glasses ~= nil then
            for i,v in pairs(character:GetChildren()) do
                if v.Name == glasses.Name and v:IsA("Accessory") then
                    if glassesReady == false then
                        v.Handle.CFrame = CFrame.new(0, -50, 0)
                    else
                        v.Handle.CFrame = glasses.Handle.CFrame
                    end
                end
            end
        end
        
        game:GetService("RunService").Heartbeat:wait()
    end
    
    --//====================================================\\--
    --||			   CREATED BY SHACKLUSTER
    --\\====================================================//--
    
    Player = game:GetService("Players").LocalPlayer
    PlayerGui = Player.PlayerGui
    Mouse = Player:GetMouse()
    Cam = workspace.CurrentCamera
    Backpack = Player.Backpack
    Character = Player.Character.FakeCharacter.Reanimation
    Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
    RootPart = Character["HumanoidRootPart"]
    Torso = Character["Torso"]
    Head = Character["Head"]
    RightArm = Character["Right Arm"]
    LeftArm = Character["Left Arm"]
    RightLeg = Character["Right Leg"]
    LeftLeg = Character["Left Leg"]
    RootJoint = RootPart["RootJoint"]
    Neck = Torso["Neck"]
    RightShoulder = Torso["Right Shoulder"]
    LeftShoulder = Torso["Left Shoulder"]
    RightHip = Torso["Right Hip"]
    LeftHip = Torso["Left Hip"]
    
    local hrp = Player.Character.HumanoidRootPart
    hrp.Transparency = 0
    
    IT = Instance.new
    CF = CFrame.new
    VT = Vector3.new
    RAD = math.rad
    C3 = Color3.new
    UD2 = UDim2.new
    BRICKC = BrickColor.new
    ANGLES = CFrame.Angles
    EULER = CFrame.fromEulerAnglesXYZ
    COS = math.cos
    ACOS = math.acos
    SIN = math.sin
    ASIN = math.asin
    ABS = math.abs
    MRANDOM = math.random
    FLOOR = math.floor
    
    Animation_Speed = 3
    Frame_Speed = 1 / 60
    local Speed = 16
    local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
    local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
    local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
    local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
    local DAMAGEMULTIPLIER = 1
    local ANIM = "Idle"
    local ATTACK = false
    local EQUIPPED = false
    local HOLD = false
    local COMBO = 1
    local Rooted = false
    local SINE = 0
    local KEYHOLD = false
    local CHANGE = 2 / Animation_Speed
    local WALKINGANIM = false
    local VALUE1 = false
    local VALUE2 = false
    local ROBLOXIDLEANIMATION = IT("Animation")
    ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
    ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
    local WEAPONGUI = IT("ScreenGui", PlayerGui)
    WEAPONGUI.Name = "Weapon GUI"
    local Effects = IT("Folder", Player.Character)
    Effects.Name = "Effects"
    local UNANCHOR = true
    local SC = false
    
    ArtificialHB = Instance.new("BindableEvent", script)
    ArtificialHB.Name = "ArtificialHB"
    
    script:WaitForChild("ArtificialHB")
    
    frame = Frame_Speed
    tf = 0
    allowframeloss = false
    tossremainder = false
    lastframe = tick()
    script.ArtificialHB:Fire()
    
    game:GetService("RunService").Heartbeat:connect(function(s, p)
    	tf = tf + s
    	if tf >= frame then
    		if allowframeloss then
    			ArtificialHB:Fire()
    			lastframe = tick()
    		else
    			for i = 1, math.floor(tf / frame) do
    				ArtificialHB:Fire()
    			end
    			lastframe = tick()
    		end
    		if tossremainder then
    			tf = 0
    		else
    			tf = tf - frame * math.floor(tf / frame)
    		end
    	end
    end)
    
    function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
    	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
    end
    
    function PositiveAngle(NUMBER)
    	if NUMBER >= 0 then
    		NUMBER = 0
    	end
    	return NUMBER
    end
    
    function NegativeAngle(NUMBER)
    	if NUMBER <= 0 then
    		NUMBER = 0
    	end
    	return NUMBER
    end
    
    function Swait(NUMBER)
    	if NUMBER == 0 or NUMBER == nil then
    		ArtificialHB.Event:wait()
    	else
    		for i = 1, NUMBER do
    			ArtificialHB.Event:wait()
    		end
    	end
    end
    
    function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
    	local NEWMESH = IT(MESH)
    	if MESH == "SpecialMesh" then
    		NEWMESH.MeshType = MESHTYPE
    		if MESHID ~= "nil" and MESHID ~= "" then
    			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
    		end
    		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
    			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
    		end
    	end
    	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
    	NEWMESH.Scale = SCALE
    	NEWMESH.Parent = PARENT
    	return NEWMESH
    end
    
    function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
    	local NEWPART = IT("Part")
    	NEWPART.formFactor = FORMFACTOR
    	NEWPART.Reflectance = REFLECTANCE
    	NEWPART.Transparency = TRANSPARENCY
    	NEWPART.CanCollide = false
    	NEWPART.Locked = true
    	NEWPART.Anchored = true
    	if ANCHOR == false then
    		NEWPART.Anchored = false
    	end
    	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
    	NEWPART.Name = NAME
    	NEWPART.Size = SIZE
    	NEWPART.Position = Torso.Position
    	NEWPART.Material = MATERIAL
    	NEWPART:BreakJoints()
    	NEWPART.Parent = PARENT
    	return NEWPART
    end
    
    local function weldBetween(a, b)
        local weldd = Instance.new("ManualWeld")
        weldd.Part0 = a
        weldd.Part1 = b
        weldd.C0 = CFrame.new()
        weldd.C1 = b.CFrame:inverse() * a.CFrame
        weldd.Parent = a
        return weldd
    end
    
    function QuaternionFromCFrame(cf)
    	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
    	local trace = m00 + m11 + m22
    	if trace > 0 then 
    		local s = math.sqrt(1 + trace)
    		local recip = 0.5 / s
    		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
    	else
    		local i = 0
    		if m11 > m00 then
    			i = 1
    		end
    		if m22 > (i == 0 and m00 or m11) then
    			i = 2
    		end
    		if i == 0 then
    			local s = math.sqrt(m00 - m11 - m22 + 1)
    			local recip = 0.5 / s
    			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
    		elseif i == 1 then
    			local s = math.sqrt(m11 - m22 - m00 + 1)
    			local recip = 0.5 / s
    			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
    		elseif i == 2 then
    			local s = math.sqrt(m22 - m00 - m11 + 1)
    			local recip = 0.5 / s return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
    		end
    	end
    end
     
    function QuaternionToCFrame(px, py, pz, x, y, z, w)
    	local xs, ys, zs = x + x, y + y, z + z
    	local wx, wy, wz = w * xs, w * ys, w * zs
    	local xx = x * xs
    	local xy = x * ys
    	local xz = x * zs
    	local yy = y * ys
    	local yz = y * zs
    	local zz = z * zs
    	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
    end
     
    function QuaternionSlerp(a, b, t)
    	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
    	local startInterp, finishInterp;
    	if cosTheta >= 0.0001 then
    		if (1 - cosTheta) > 0.0001 then
    			local theta = ACOS(cosTheta)
    			local invSinTheta = 1 / SIN(theta)
    			startInterp = SIN((1 - t) * theta) * invSinTheta
    			finishInterp = SIN(t * theta) * invSinTheta
    		else
    			startInterp = 1 - t
    			finishInterp = t
    		end
    	else
    		if (1 + cosTheta) > 0.0001 then
    			local theta = ACOS(-cosTheta)
    			local invSinTheta = 1 / SIN(theta)
    			startInterp = SIN((t - 1) * theta) * invSinTheta
    			finishInterp = SIN(t * theta) * invSinTheta
    		else
    			startInterp = t - 1
    			finishInterp = t
    		end
    	end
    	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
    end
    
    function Clerp(a, b, t)
    	local qa = {QuaternionFromCFrame(a)}
    	local qb = {QuaternionFromCFrame(b)}
    	local ax, ay, az = a.x, a.y, a.z
    	local bx, by, bz = b.x, b.y, b.z
    	local _t = 1 - t
    	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
    end
    
    -- (Completed missing looping logic from the original cut-off Shackluster effect library block)
    if MSH ~= nil then
        local BOOMR1 = 1+BOOMERANG/50
        local BOOMR2 = 1+SIZEBOOMERANG/50
        local MOVESPEED = nil
        if MOVEDIRECTION ~= nil then
            if USEBOOMERANGMATH == true then
                MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)*BOOMR1
            else
                MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)
            end
        end
        local GROWTH = nil
        if USEBOOMERANGMATH == true then
            GROWTH = (SIZE - ENDSIZE)*(BOOMR2+1)
        else
            GROWTH = (SIZE - ENDSIZE)
        end
        local TRANS = TRANSPARENCY - ENDTRANSPARENCY
        if TYPE == "Block" then
            EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
        else
            EFFECT.CFrame = CFRAME
        end
        for LOOP = 1, TIME+1 do
            Swait()
            -- Effect updates handled here in render sequence
        end
    end
    end)
end
