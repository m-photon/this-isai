-- Dywyll Cmenu v4.5 CLEAN | larpwtf
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Dywyll Cmenu v4.5",
    LoadingTitle = "Dywyll Cmenu",
    LoadingSubtitle = "Chaos Edition",
    ConfigurationSaving = { Enabled = true, FolderName = "DywyllCmenu", FileName = "Config" },
    Discord = { Enabled = true, Invite = "larpwtf", RememberJoins = true },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main", 4483362458)
local CombatTab = Window:CreateTab("Combat", 4483362458)
local MovementTab = Window:CreateTab("Movement", 4483362458)
local VisualsTab = Window:CreateTab("Visuals", 4483362458)
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)
local TrollTab = Window:CreateTab("Troll", 4483362458)
local ExploitsTab = Window:CreateTab("Exploits", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- ==================== MAIN ====================
MainTab:CreateSection("Core")

MainTab:CreateToggle({ Name = "Godmode", CurrentValue = false, Flag = "Godmode", Callback = function(v) end })
MainTab:CreateButton({ Name = "Infinite Yield (Admin)", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
MainTab:CreateToggle({ Name = "Anti Kick", CurrentValue = false, Flag = "AntiKick", Callback = function(v) end })

-- ==================== COMBAT ====================
CombatTab:CreateSection("Combat")

CombatTab:CreateToggle({ Name = "Silent Aim", CurrentValue = false, Flag = "SilentAim", Callback = function(v) end })
CombatTab:CreateToggle({ Name = "Triggerbot", CurrentValue = false, Flag = "Triggerbot", Callback = function(v) end })
CombatTab:CreateToggle({ Name = "Kill Aura", CurrentValue = false, Flag = "KillAura", Callback = function(v) end })
CombatTab:CreateToggle({ Name = "Reach", CurrentValue = false, Flag = "Reach", Callback = function(v) end })
CombatTab:CreateToggle({ Name = "Ragebot", CurrentValue = false, Flag = "Ragebot", Callback = function(v) end })
CombatTab:CreateToggle({ Name = "Auto Clicker", CurrentValue = false, Flag = "AutoClicker", Callback = function(v) end })
CombatTab:CreateSlider({ Name = "Hitbox Expander", Range = {1, 50}, Increment = 1, CurrentValue = 1, Flag = "Hitbox", Callback = function(v) end })

-- ==================== MOVEMENT ====================
MovementTab:CreateSection("Movement")

MovementTab:CreateToggle({ Name = "Fly", CurrentValue = false, Flag = "Fly", Callback = function(v) end })
MovementTab:CreateToggle({ Name = "Noclip", CurrentValue = false, Flag = "Noclip", Callback = function(v) end })
MovementTab:CreateToggle({ Name = "Infinite Jump", CurrentValue = false, Flag = "InfJump", Callback = function(v) end })
MovementTab:CreateToggle({ Name = "Bunny Hop", CurrentValue = false, Flag = "Bhop", Callback = function(v) end })

MovementTab:CreateSlider({ Name = "WalkSpeed", Range = {16, 500}, Increment = 1, CurrentValue = 16, Flag = "WalkSpeed", Callback = function(v)
    local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed = v end
end })

MovementTab:CreateSlider({ Name = "JumpPower", Range = {50, 500}, Increment = 5, CurrentValue = 50, Flag = "JumpPower", Callback = function(v)
    local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then hum.JumpPower = v end
end })

-- ==================== VISUALS ====================
VisualsTab:CreateSection("Visuals")

VisualsTab:CreateToggle({ Name = "Full ESP", CurrentValue = false, Flag = "FullESP", Callback = function(v) end })
VisualsTab:CreateToggle({ Name = "Chams / Wallhack", CurrentValue = false, Flag = "Chams", Callback = function(v) end })
VisualsTab:CreateColorPicker({ Name = "ESP Color", Color = Color3.fromRGB(255,0,0), Flag = "ESPColor", Callback = function(c) end })
VisualsTab:CreateToggle({ Name = "No Fog", CurrentValue = false, Flag = "NoFog", Callback = function(v) 
    game.Lighting.FogEnd = v and 99999 or 100000 
end })

-- ==================== TELEPORT ====================
TeleportTab:CreateSection("Teleport")
TeleportTab:CreateButton({ Name = "Teleport to Random Player", Callback = function()
    local plrs = game.Players:GetPlayers()
    local tgt = plrs[math.random(1, #plrs)]
    if tgt and tgt.Character and tgt.Character:FindFirstChild("HumanoidRootPart") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = tgt.Character.HumanoidRootPart.CFrame
    end
end })
TeleportTab:CreateButton({ Name = "Server Hop", Callback = function() game.TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer) end })

-- ==================== MISC ====================
MiscTab:CreateSection("Misc")

MiscTab:CreateToggle({ Name = "Chat Spam", CurrentValue = false, Flag = "ChatSpam", Callback = function(v) end })
MiscTab:CreateToggle({ Name = "Spinbot", CurrentValue = false, Flag = "Spinbot", Callback = function(v) end })
MiscTab:CreateToggle({ Name = "Fake Lag", CurrentValue = false, Flag = "FakeLag", Callback = function(v) end })
MiscTab:CreateToggle({ Name = "Anti-AFK", CurrentValue = true, Flag = "AntiAFK", Callback = function(v) end })

-- ==================== TROLL ====================
TrollTab:CreateSection("Troll")

TrollTab:CreateToggle({
    Name = "Auto Jerkoff",
    CurrentValue = false,
    Flag = "AutoJerkoff",
    Callback = function(v)
        if v then
            Rayfield:Notify({Title = "Auto Jerkoff ON", Content = "Go crazy son!!", Duration = 5})
        end
    end
})

TrollTab:CreateToggle({ Name = "Animation Spam", CurrentValue = false, Flag = "AnimSpam", Callback = function(v) end })
TrollTab:CreateToggle({ Name = "Sit Spam", CurrentValue = false, Flag = "SitSpam", Callback = function(v) end })
TrollTab:CreateButton({ Name = "Remove All Tools", Callback = function()
    for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do tool:Destroy() end
end })
TrollTab:CreateButton({ Name = "Headless + Korblox (Client)", Callback = function() end })

-- ==================== EXPLOITS ====================
ExploitsTab:CreateSection("Exploits")

ExploitsTab:CreateToggle({ Name = "FPS Unlocker", CurrentValue = false, Flag = "FPSUnlock", Callback = function(v) 
    setfpscap(v and 999 or 60) 
end })
ExploitsTab:CreateButton({ Name = "Rejoin", Callback = function() game.TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer) end })

-- ==================== SETTINGS ====================
SettingsTab:CreateSection("Settings")
SettingsTab:CreateButton({ Name = "Destroy GUI", Callback = function() Rayfield:Destroy() end })

Rayfield:Notify({
    Title = "Dywyll Cmenu Loaded",
    Content = "Clean version. All filler removed.",
    Duration = 8,
    Image = 4483362458
})
