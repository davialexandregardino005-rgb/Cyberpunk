-- GUI com título e arrastável apenas pelo título
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")

local enabled = false
local platform = nil
local loop = nil

-- GUI Config
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 100)
MainFrame.Active = true
MainFrame.Draggable = false -- frame em si não arrastável

-- Título
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.Text = "Plataforma GUI"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.Font = Enum.Font.SourceSansBold
TitleBar.TextSize = 20
TitleBar.TextStrokeTransparency = 0.5

-- Botão
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Position = UDim2.new(0.1, 0, 0.5, 0)
ToggleButton.Size = UDim2.new(0.8, 0, 0.35, 0)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "Ativar Plataforma"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 18

-- Arrastar pelo título
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

TitleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

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

			-- Loop: plataforma segue player e sobe
			loop = game:GetService("RunService").RenderStepped:Connect(function()
				if platform and char and char:FindFirstChild("HumanoidRootPart") then
					local hrp = char.HumanoidRootPart
					-- posição segue o player + sobe suavemente
					platform.Position = Vector3.new(
						hrp.Position.X,
						platform.Position.Y + 0.1, -- sobe
						hrp.Position.Z
					)
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
