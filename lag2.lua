local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer

local isLagging = false
local spawnLoop = nil
local cleanupConnection = nil

-- Cleanup loop continu (innocent si pas de lag parts)
task.spawn(function()
    while true do
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name == "LagPart" then
                obj:Destroy()
            end
        end
        task.wait(0.3)
    end
end)

local function spawnBatch()
    for i = 1, 500 do
        task.spawn(function()
            local part = Instance.new("Part")
            part.Name = "LagPart"
            part.Parent = workspace
            part.Material = Enum.Material.Neon
            part.BrickColor = BrickColor.Random()
            part.Shape = Enum.PartType.Ball
            part.Size = Vector3.new(math.random(2, 4), math.random(2, 4), math.random(2, 4))
            part.TopSurface = Enum.SurfaceType.Smooth
            part.BottomSurface = Enum.SurfaceType.Smooth
            part.Anchored = false
            part.CanCollide = false
            part.Position = Vector3.new(
                math.random(-5000, 5000),
                math.random(500, 2000),
                math.random(-5000, 5000)
            )
            
            -- Vol chaotique
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Velocity = Vector3.new(
                math.random(-100, 100),
                math.random(50, 150),
                math.random(-100, 100)
            )
            bv.Parent = part
            
            -- Rotation folle
            local ba = Instance.new("BodyAngularVelocity")
            ba.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            ba.AngularVelocity = Vector3.new(
                math.random(-50, 50),
                math.random(-50, 50),
                math.random(-50, 50)
            )
            ba.Parent = part
            
            -- Particules RENDER LAG
            local pe = Instance.new("ParticleEmitter")
            pe.Parent = part
            pe.Texture = "rbxasset://textures/particles/sparkles_main.dds"
            pe.Lifetime = NumberRange.new(1, 3)
            pe.Rate = 100
            pe.SpreadAngle = Vector2.new(45, 45)
            pe.Speed = NumberRange.new(10, 30)
            
            -- Son AUDIO LAG
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://131961136"  -- Son chiant looped
            sound.Looped = true
            sound.Volume = 0.5
            sound.Parent = part
            sound:Play()
            
            Debris:AddItem(part, 15)  -- Clean serveur 15s
        end)
    end
end

LocalPlayer.Chatted:Connect(function(msg)
    msg = string.lower(msg)
    if msg == "/rida" then
        isLagging = not isLagging
        if isLagging then
            print("💥💥 LAG APOCALYPSE ACTIVÉ ! Spawn infini 500/1.5s → Vole ÉTERNEL ! 💥💥")
            spawnLoop = task.spawn(function()
                while isLagging do
                    spawnBatch()
                    task.wait(1.5)
                end
            end)
        else
            print("🛑 LAG STOPPÉ. Prochain /rida relance !")
        end
    end
end)

print("✅ LAG APOCALYPSE v2 Chargé ! /rida = Toggle infini. FPS Unlock recommandé. Domine Steal a Brainrot ! 🧠💣🔥")
