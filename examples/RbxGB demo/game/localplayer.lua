local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local PlayerModule = require(Player.PlayerScripts:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()

Controls:Disable()


local SG = Player.PlayerGui:WaitForChild("ScreenGui")
local Button = SG:WaitForChild("TextButton")
Button.Activated:Connect(function()
    SG:ClearAllChildren()
    local s = Instance.new("Sound", SG)
    s.SoundId = "rbxassetid://116885156127521"
    s:Play()
    
    local b = Instance.new("TextButton", SG)
    b.Size = UDim2.new(.1, 0, .1, 0)
    b.Position = UDim2.new(.8, 0, .8, 0)
    b.Text = "JUMPPP!!!"
    
    b.Activated:Connect(function()
        local Char = Player.Character
        if Char then
        local Hum = Char:FindFirstChildOfClass("Humanoid")
            if Hum then
                Hum.Jump = true
            end
        end
    end)
end)

while true do
    task.wait()
    local Char = Player.Character
    if Char then
        local Hum = Char:FindFirstChildOfClass("Humanoid")
        if Hum then
            Hum:Move(Vector3.zAxis, false)
            Hum.WalkSpeed = 45
        end
        
        local HRP = Char:FindFirstChild("HumanoidRootPart")
        if HRP then
            local Cam = workspace.CurrentCamera
            if Cam then
                Cam.CameraType = Enum.CameraType.Scriptable
                Cam.CFrame = CFrame.lookAt(HRP.Position + Vector3.new(0, 7, -15), HRP.Position)
            end
        end
    end
end