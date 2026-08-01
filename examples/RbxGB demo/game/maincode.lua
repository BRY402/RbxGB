-- just a quick whipped up game dont mind the mess

local function obstacle(pos)
    local part = Instance.new("Part")
    part.Anchored = true
    part.Color = Color3.new(1, 0, 0)
    part.Size = Vector3.new(3, 3, 3)
    part.Material = "SmoothPlastic"
    part.Parent = workspace
    part.Position = pos
    
    part.Touched:Once(function(t)
        t:Destroy()
        part:Destroy()
    end)
end

local cs = Instance.new("Sound", game:FindService("SoundService"))
cs.SoundId = "rbxassetid://135483737426662"

local function coin(pos)
    local part = Instance.new("Part")
    part.Anchored = true
    part.Color = Color3.new(1, 1, 0)
    part.Size = Vector3.new(1, 1, 1)
    part.Material = "SmoothPlastic"
    part.Parent = workspace
    part.Position = pos
    part.CanCollide = false
    
    part.Touched:Once(function()
        part:Destroy()
        cs:Play()
    end)
end

local Players = game:FindService("Players")
Players.PlayerAdded:Connect(function(Player)
    local z = 0
    local x = 0
    local part = Instance.new("Part")
    part.Anchored = true
    part.Color = Color3.new(0, 0, 0)
    part.Size = Vector3.new(20, .5, 256)
    part.Material = "SmoothPlastic"
    part.Parent = workspace
    local part2 = Instance.new("Part")
    part2.Anchored = true
    part2.Color = Color3.new(1, 1, 0)
    part2.Size = Vector3.new(1, .1, 256)
    part2.Material = "SmoothPlastic"
    part2.Parent = workspace
    part2.CanCollide = false
    
    local PG = Player.PlayerGui
    local ls = workspace:FindFirstChild("LocalScript")
    ls:Clone().Parent = PG
    
    local SG = Instance.new("ScreenGui", PG)
    local Text = Instance.new("TextLabel", SG)
    Text.Text = "Sick rjnner demo game fr"
    Text.Position = UDim2.new(0.4, 0, 0.2, 0)
    Text.TextSize = 20
    Text.TextColor3 = Color3.new(1, 1, 1)
    Text.Size = UDim2.new(0.1, 0, 0.05, 0)
    local Buttom = Instance.new("TextButton", SG)
    Buttom.Size = UDim2.new(0.075, 0, 0.05, 0)
    Buttom.Position = UDim2.new(0.4, 0, 0.5, 0)
    Buttom.Text = "LET ME PLAY!!!"
    Buttom.TextSize = 30
    Buttom.TextColor3 = Color3.new(1, 0, 0)
    
    local Sound = Instance.new("Sound", SG)
    Sound.SoundId = "rbxassetid://140543746670318"
    Sound:Play()
    
    task.spawn(function()
        while Player.Parent do
        task.wait()
        local Character = Player.Character
        if Character then
            local HRP = Character:FindFirstChild("HumanoidRootPart")
            if HRP then
                z = HRP.Position.Z
                x = HRP.Position.X
                part.Position = Vector3.new(x, 1, z)
                part2.Position = Vector3.new(x, 1.6, z)
            end
        end
    end
    end)
    
    task.spawn(function()
    while Player.Parent do
        task.wait(5)
        obstacle(Vector3.new(x, 3, z + 72))
    end
    end)
    
    task.spawn(function()
    while Player.Parent do
        task.wait(2)
        coin(Vector3.new(x, 2, z + 57))
    end
    end)
end)