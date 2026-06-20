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
            local myChar = Player.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            
            if targetRoot and myRoot then
                flinging = true
                Title.Text = "Flinging: " .. targetChar.Name
                Title.TextColor3 = Color3.fromRGB(255, 0, 0)
                
                -- Save original position to teleport back after the fling
                local originalCFrame = myRoot.CFrame
                
                -- Apply the spinning force (Using the exact math from your original script)
                local bav = Instance.new("BodyAngularVelocity")
                bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bav.P = 1000000000000000000000000000
                bav.AngularVelocity = Vector3.new(10000, 10000, 10000)
                bav.Parent = myRoot
                
                -- Put character in jumping state to avoid floor friction stopping the fling
                if myChar:FindFirstChildWhichIsA("Humanoid") then
                    myChar:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
                
                local startTime = tick()
                local connection
                
                -- Heartbeat loop to stick to the target
                connection = RunService.Heartbeat:Connect(function()
                    -- Stop flinging after 1.5 seconds or if target leaves/dies
                    if tick() - startTime >= 1.5 or not targetRoot.Parent then
                        connection:Disconnect()
                        if bav then bav:Destroy() end
                        
                        -- Reset physics and position
                        myRoot.Velocity = Vector3.new(0, 0, 0)
                        myRoot.RotVelocity = Vector3.new(0, 0, 0)
                        myRoot.CFrame = originalCFrame
                        
                        flinging = false
                        Title.Text = "Hover + V to Fling"
                        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                    else
                        -- Teleport inside the target continuously to apply physics damage
                        myRoot.CFrame = targetRoot.CFrame
                    end
                end)
            end
        end
    end
end)
