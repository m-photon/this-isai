local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Prevent duplicate GUIs from spawning
if CoreGui:FindFirstChild("SimpleFlingGui") then
    CoreGui.SimpleFlingGui:Destroy()
end

-- Create the GUI
local SimpleFlingGui = Instance.new("ScreenGui")
SimpleFlingGui.Name = "SimpleFlingGui"
SimpleFlingGui.Parent = CoreGui
SimpleFlingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = SimpleFlingGui
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
MainFrame.BorderSizePixel = 3
MainFrame.Position = UDim2.new(0.5, -100, 0.85, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 40)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1.000
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Font = Enum.Font.Code
Title.Text = "Hover + V to Fling"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16.000
Title.TextWrapped = true

-- Fling Logic
local flinging = false

Mouse.KeyDown:Connect(function(key)
    if key:lower() == "v" and not flinging then
        local target = Mouse.Target
        
        -- Check if we are hovering over a valid player/character
        if target and target.Parent and target.Parent:FindFirstChildWhichIsA("Humanoid") then
            local targetChar = target.Parent
            local targetRoot = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Torso") or targetChar:FindFirstChild("UpperTorso")
            local targetHum = targetChar:FindFirstChildWhichIsA("Humanoid")
            
            local myChar = Player.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local myHum = myChar and myChar:FindFirstChildWhichIsA("Humanoid")
            
            -- Make sure we have the parts, and we aren't targeting ourselves
            if targetRoot and myRoot and myHum and targetChar ~= myChar then
                flinging = true
                Title.Text = "Flinging: " .. targetChar.Name
                Title.TextColor3 = Color3.fromRGB(255, 0, 0)
                
                -- Save original position to teleport back after the fling
                local originalCFrame = myRoot.CFrame
                
                -- Stop our character from fighting the spin
                myHum.PlatformStand = true
                
                -- Apply the spinning force
                local bav = Instance.new("BodyAngularVelocity")
                bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bav.P = math.huge
                bav.AngularVelocity = Vector3.new(0, 999999, 0) -- Massive Y-axis spin
                bav.Parent = myRoot
                
                -- Apply aggressive tracking force
                local bp = Instance.new("BodyPosition")
                bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bp.P = math.huge
                bp.Position = targetRoot.Position
                bp.Parent = myRoot
                
                local startTime = tick()
                local connection
                
                -- Heartbeat loop to track the target
                connection = RunService.Heartbeat:Connect(function()
                    -- Stop flinging after 1.5 seconds, or if target leaves/dies
                    if tick() - startTime >= 1.5 or not targetRoot.Parent or not targetHum or targetHum.Health <= 0 then
                        connection:Disconnect()
                        if bav then bav:Destroy() end
                        if bp then bp:Destroy() end
                        
                        -- Reset physics and position
                        myRoot.Velocity = Vector3.new(0, 0, 0)
                        myRoot.RotVelocity = Vector3.new(0, 0, 0)
                        myRoot.CFrame = originalCFrame
                        myHum.PlatformStand = false
                        
                        flinging = false
                        Title.Text = "Hover + V to Fling"
                        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                    else
                        -- Constantly update the BodyPosition to pull us into their character
                        bp.Position = targetRoot.Position
                        
                        -- Force RotVelocity manually as a backup in case BodyAngularVelocity throttles
                        myRoot.RotVelocity = Vector3.new(0, 50000, 0)
                    end
                end)
            end
        end
    end
end)
