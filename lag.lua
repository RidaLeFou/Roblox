local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Debris = game:GetService("Debris")

local function lagBomb()
    for i = 1, 300 do
        spawn(function()
            local part = Instance.new("Part")
            part.Name = "BrainrotLag"
            part.Parent = workspace
            part.Material = Enum.Material.ForceField
            part.BrickColor = BrickColor.Random()
            part.Shape = Enum.PartType.Ball
            part.Size = Vector3.new(1, 1, 1)
            part.TopSurface = Enum.SurfaceType.Smooth
            part.BottomSurface = Enum.SurfaceType.Smooth
            part.Anchored = false
            part.CanCollide = false
            part.Position = Vector3.new(math.random(-1000, 1000), math.random(100, 1000), math.random(-1000, 1000))
            
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(4000, 4000, 4000)
            bv.Velocity = Vector3.new(math.random(-50, 50), math.random(50, 100), math.random(-50, 50))
            bv.Parent = part
            
            Debris:AddItem(part, 10) 
        end)
    end
    
    task.wait(5)
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name == "BrainrotLag" then
            obj:Destroy()
        end
    end
end

LocalPlayer.Chatted:Connect(function(msg)
    msg = string.lower(msg)
    if msg == "/rida" then
        lagBomb()
    end
end)
