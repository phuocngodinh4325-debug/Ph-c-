--// FIX LAG + FPS COUNTER by ChatGPT

-- Services
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

--// FIX GRAPHICS
pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

for _,v in pairs(Lighting:GetChildren()) do
    if v:IsA("PostEffect") then
        v.Enabled = false
    end
end

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 1
Lighting.ClockTime = 14

-- Remove textures & effects
for _,v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v:Destroy()
    elseif v:IsA("ParticleEmitter")
    or v:IsA("Trail")
    or v:IsA("Beam") then
        v.Enabled = false
    end
end

--// FPS UI
local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.Name = "FPS_UI"
ScreenGui.ResetOnSpawn = false

local TextLabel = Instance.new("TextLabel", ScreenGui)
TextLabel.Size = UDim2.new(0, 140, 0, 40)
TextLabel.Position = UDim2.new(0, 10, 0, 10)
TextLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextLabel.BackgroundTransparency = 0.3
TextLabel.TextColor3 = Color3.fromRGB(0,255,0)
TextLabel.TextScaled = true
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "FPS: 0"

-- FPS Counter
local frames = 0
local last = tick()

RunService.RenderStepped:Connect(function()
    frames += 1
    if tick() - last >= 1 then
        TextLabel.Text = "FPS: "..frames
        frames = 0
        last = tick()
    end
end)

print("✅ Fix Lag + FPS Loaded") 
