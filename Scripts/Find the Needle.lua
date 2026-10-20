local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Immediate cleanup of the old interface
local oldGui = CoreGui:FindFirstChild("NeedleHyperDrive")
if oldGui then oldGui:Destroy() end

local state = { active = true }
local connections = {}

local function getHRP()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- ==========================================
-- ULTRA-FAST TARGETED NOCLIP (Keeps the ground stable)
-- ==========================================
connections["Noclip"] = RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                if part.Name ~= "LeftFoot" and part.Name ~= "RightFoot" and part.Name ~= "LowerTorso" and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = false
                end
            end
        end
    end
