--GUI
local NetlessServerAdmin = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local InspectorButton = Instance.new("TextButton")
local ButtonCorner = Instance.new("UICorner")

NetlessServerAdmin.Name = "NetlessServerAdmin"
NetlessServerAdmin.Parent = game:GetService("CoreGui")
NetlessServerAdmin.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = NetlessServerAdmin
MainFrame.Active = true
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.5, -100, 0.8, -25)
MainFrame.Size = UDim2.new(0, 200, 0, 50)
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(50, 50, 50)
UIStroke.Thickness = 1.5
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

InspectorButton.Name = "InspectorButton"
InspectorButton.Parent = MainFrame
InspectorButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
InspectorButton.Position = UDim2.new(0.025, 0, 0.05, 0)
InspectorButton.Size = UDim2.new(0.95, 0, 0.9, 0)
InspectorButton.Font = Enum.Font.ComicSansMC
InspectorButton.Text = "inspector"
InspectorButton.TextColor3 = Color3.fromRGB(230, 230, 230)
InspectorButton.TextSize = 22
InspectorButton.AutoButtonColor = true

ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = InspectorButton

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
--|| CREATED BY SHACKLUSTER
--\\====================================================//--
--wait(0.2)
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
--//=================================\\
--|| USEFUL VALUES
--\\=================================//
Animation_Speed = 3
Frame_Speed = 1 / 60 -- (1 / 30) OR (1 / 60)
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
--ROBLOXIDLEANIMATION.Parent = Humanoid
local WEAPONGUI = IT("ScreenGui", PlayerGui)
WEAPONGUI.Name = "Weapon GUI"
local Effects = IT("Folder", Player.Character)
Effects.Name = "Effects"
--print("e")
--local ANIMATOR = Humanoid.Animator
--local ANIMATE = Character.Animate
local UNANCHOR = true
local SC = false
--//=================================\\
--\\=================================//
--//=================================\\
--|| SAZERENOS' ARTIFICIAL HEARTBEAT
--\\=================================//
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
--//=================================\\
--\\=================================//
--//=================================\\
--|| SOME FUNCTIONS
--\\=================================//
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
return (m21 - m12) * recip
