-- GUI simples com botão toggle
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

local enabled = false
local platform = nil
local loop = nil

-- GUI Config
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Position = UDim2.new(0.4, 0, 0.4, 0)
ToggleButton.Size = UDim2.new(0, 200, 0, 50)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "Ativar Plataforma"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 22.0

-- Função de toggle
ToggleButton.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        ToggleButton.Text = "Desativar Plataforma"

        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- Cria plataforma
            platform = Instance.new("Part")
            platform.Size = Vector3.new(10, 1, 10)
            platform.Anchored = true
            platform.CanCollide = true
            platform.Position = char.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
            platform.Parent = workspace

            -- Loop para subir
            loop = game:GetService("RunService").RenderStepped:Connect(function()
                if platform then
                    platform.Position = platform.Position + Vector3.new(0, 0.1, 0) -- sobe
                end
            end)
        end
    else
        ToggleButton.Text = "Ativar Plataforma"

        -- Para o loop e remove a plataforma
        if loop then loop:Disconnect() loop = nil end
        if platform then platform:Destroy() platform = nil end
    end
end)
