local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local chatService = game:GetService("TextChatService")

local command = "/rida"

local function onMessageReceived(message, speaker)
    if speaker == localPlayer and message == command then
        launchThePolitelyDisruptiveDevice()
    end
end

if chatService.OnIncomingMessage then
    chatService.OnIncomingMessage:Connect(function(messageObj)
        onMessageReceived(messageObj.Text, Players:FindFirstChild(messageObj.TextSource.Name))
    end)
else
    localPlayer.Chatted:Connect(function(message)
        onMessageReceived(message, localPlayer)
    end)
end

function launchThePolitelyDisruptiveDevice()
    print("Activation du Champ de Ralentissement Poli (CRP).")
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then 
            
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            
            for i = 1, 10000 do 
                local particleEmitter = Instance.new("ParticleEmitter")
                particleEmitter.Parent = humanoidRootPart
                particleEmitter.Rate = 10000
                particleEmitter.Speed = NumberRange.new(500, 1000)
                particleEmitter.Lifetime = NumberRange.new(10, 20)
                particleEmitter.Size = NumberSequence.new(0.1) 
                particleEmitter.Enabled = true
                
                game:GetService("RunService").Heartbeat:Connect(function()
                    if particleEmitter and particleEmitter.Parent then
                        particleEmitter.Acceleration = Vector3.new(math.random(-1000,1000), math.random(-1000,1000), math.random(-1000,1000))
                    end
                end)
            end
            
            local tool = Instance.new("Tool")
            tool.RequiresHandle = false
            tool.Name = "LagAid" .. player.Name
            tool.Parent = player.Backpack or character
            for i = 1, 50 do
                local clone = tool:Clone()
                clone.Parent = tool.Parent
                task.wait(0.01) -
            end
            
            spawn(function()
                while task.wait(0.1) and player.Parent do
                    pcall(function()
                        humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(0.5), 0) 
                        character.Humanoid.WalkSpeed = math.random(1, 50)
                    end)
                end
            end)
        end
    end
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "CRP Activé",
        Text = "Lag enabled",
        Duration = 5
    })
end
