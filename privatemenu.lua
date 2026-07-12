--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()


local Window = OrionLib:MakeWindow({
    Name = "Item Manager by JJP",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "JJPGui"
})


local Tab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local teleportEnabled = false
local nametagEnabled = false
local useWebhook = false
local webhookURL = ""
local lastEKeyPressTime = 0
local teleportConnection
local currentTarget
local teleportDistance = 15  
local processedItems = {} 
local ignoredItems = {} 
local currentTargetStartTime = nil 
local targetTimeout = 15


local function createNametag(model, text)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Adornee = model
    billboardGui.AlwaysOnTop = true
    billboardGui.Size = UDim2.new(0, 75, 0, 15)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboardGui
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0
    textLabel.Text = text
    textLabel.TextScaled = true

    billboardGui.Parent = model
end


local function refreshNametags()
    local itemsFolder = workspace:FindFirstChild("Item_Spawns") and workspace.Item_Spawns:FindFirstChild("Items")
    if itemsFolder then
        for _, item in pairs(itemsFolder:GetChildren()) do
            if item:IsA("Model") then
                
                for _, child in pairs(item:GetChildren()) do
                    if child:IsA("BillboardGui") then
                        child:Destroy()
                    end
                end

                local proximityPrompt = item:FindFirstChildWhichIsA("ProximityPrompt")
                if proximityPrompt then
                    local objectText = proximityPrompt.ObjectText
                    createNametag(item, objectText)
                end
            end
        end
    end
end


local function onNewModelAdded(model)
    if model:IsA("Model") then
        local proximityPrompt = model:FindFirstChildWhichIsA("ProximityPrompt")
        if proximityPrompt then
            local objectText = proximityPrompt.ObjectText
            createNametag(model, objectText)
        end
    end
end


local function findClosestModel()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local itemsFolder = workspace:FindFirstChild("Item_Spawns") and workspace.Item_Spawns:FindFirstChild("Items")
    if itemsFolder then
        local closestModel
        local closestDistance = math.huge

        for _, item in pairs(itemsFolder:GetChildren()) do
            if item:IsA("Model") and item.PrimaryPart and not ignoredItems[item] then
                local distance = (item.PrimaryPart.Position - humanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestModel = item
                end
            end
        end

        return closestModel, closestDistance
    end
    return nil, nil
end


local function moveTowardsTarget()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")


    if not currentTarget or not currentTarget:IsDescendantOf(workspace) then
        currentTarget, _ = findClosestModel()
        currentTargetStartTime = tick()
    end

    if currentTarget and currentTarget.PrimaryPart then
        local targetPosition = currentTarget.PrimaryPart.Position
        local distanceToTarget = (targetPosition - humanoidRootPart.Position).Magnitude

        if distanceToTarget > teleportDistance then
            local direction = (targetPosition - humanoidRootPart.Position).Unit
            humanoidRootPart.CFrame = humanoidRootPart.CFrame + direction * teleportDistance
        else
            humanoidRootPart.CFrame = CFrame.new(targetPosition)
        end

        
        if tick() - currentTargetStartTime >= targetTimeout then
            ignoredItems[currentTarget] = true
            currentTarget = nil 
            return 
        end

        
        local currentTime = tick()
        if currentTime - lastEKeyPressTime >= 1 then
            lastEKeyPressTime = currentTime
            local VirtualInputManager = game:GetService("VirtualInputManager")
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            wait(0.3)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)

            
            if useWebhook and webhookURL ~= "" and not processedItems[currentTarget] then
                processedItems[currentTarget] = true

                local itemName = "Unknown Item"
                local proximityPrompt = currentTarget:FindFirstChildWhichIsA("ProximityPrompt")
                if proximityPrompt then
                    itemName = proximityPrompt.ObjectText
                end

                local backpack = game.Players.LocalPlayer.Backpack
                local itemCount = {}
                for _, item in pairs(backpack:GetChildren()) do
                    itemCount[item.Name] = (itemCount[item.Name] or 0) + 1
                end

                local itemList = {}
                for name, count in pairs(itemCount) do
                    table.insert(itemList, name .. " x" .. count)
                end

                local embed = {
                    title = "Got new item",
                    description = itemName,
                    color = 65280,
                    fields = {
                        { name = "Item inventory", value = table.concat(itemList, ", ") }
                    },
                    footer = { text = game.Players.LocalPlayer.Name }
                }
                SendMessageEMBED(webhookURL, embed)
            end
        end
    end
end



Tab:AddToggle({
    Name = "Enable Teleporting",
    Default = false,
    Callback = function(Value)
        teleportEnabled = Value
        if teleportEnabled then
            teleportConnection = coroutine.wrap(function()
                while teleportEnabled do
                    moveTowardsTarget()
                    wait(0.3)
                end
            end)
            teleportConnection()
        else
            teleportConnection = nil
        end
    end
})

Tab:AddLabel("(RE ENABLE FEW TIMES IF DOESNT WORK INSTANTLY)")

Tab:AddToggle({
    Name = "Use Webhook",
    Default = false,
    Callback = function(Value)
        useWebhook = Value
    end
})


Tab:AddTextbox({
    Name = "Webhook URL",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        webhookURL = Value
    end
})


function SendMessage(url, message)
    local http = game:GetService("HttpService")
    local headers = { ["Content-Type"] = "application/json" }
    local data = { ["content"] = message }
    local body = http:JSONEncode(data)
    request({ Url = url, Method = "POST", Headers = headers, Body = body })
    print("Message sent to webhook.")
end

function SendMessageEMBED(url, embed)
    local http = game:GetService("HttpService")
    local headers = { ["Content-Type"] = "application/json" }
    local data = { ["embeds"] = { embed } }
    local body = http:JSONEncode(data)
    request({ Url = url, Method = "POST", Headers = headers, Body = body })
    print("Embed sent to webhook.")
end

Tab:AddToggle({
    Name = "Enable Nametags",
    Default = false,
    Callback = function(Value)
        nametagEnabled = Value

        if nametagEnabled then
            refreshNametags()

            
            updateTask = task.spawn(function()
                while nametagEnabled do
                    refreshNametags()
                    task.wait(2) 
                end
            end)
        else
            
            nametagEnabled = false
            if updateTask then
                task.cancel(updateTask)
            end

           
            local itemsFolder = workspace:FindFirstChild("Item_Spawns") and workspace.Item_Spawns:FindFirstChild("Items")
            if itemsFolder then
                for _, item in pairs(itemsFolder:GetChildren()) do
                    for _, child in pairs(item:GetChildren()) do
                        if child:IsA("BillboardGui") then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    end
})

OrionLib:Init()
