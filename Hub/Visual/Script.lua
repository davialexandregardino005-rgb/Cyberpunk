-- Hub quadrada, estilosa e funcional para KRNL
-- Aba 1: botão "Tool" -> dá uma Tool; segurando a Tool, clique no mapa para teleportar
-- Uso: cole no executor KRNL e rode

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BeautifulHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 520) -- quadrada e grande
MainFrame.Position = UDim2.new(0.3, 0, 0.18, 0)
MainFrame.AnchorPoint = Vector2.new(0,0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

-- Aesthetic: rounded corners, shadow, gradient
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 14)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Thickness = 1
UIStroke.Color = Color3.fromRGB(40, 40, 50)
UIStroke.Transparency = 0.15

local UIGradient = Instance.new("UIGradient", MainFrame)
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(28,28,34)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18,18,22))
}
UIGradient.Rotation = 270

-- Topbar / Title
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 56)
TopBar.Position = UDim2.new(0,0,0,0)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "✨ Beautiful Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(230,230,240)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Left: Tabs
local TabsFrame = Instance.new("Frame", MainFrame)
TabsFrame.Name = "TabsFrame"
TabsFrame.Position = UDim2.new(0, 12, 0, 70)
TabsFrame.Size = UDim2.new(0, 130, 0, 430)
TabsFrame.BackgroundTransparency = 1

local TabsUIList = Instance.new("UIListLayout", TabsFrame)
TabsUIList.SortOrder = Enum.SortOrder.LayoutOrder
TabsUIList.Padding = UDim.new(0, 8)

-- Right: Content
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Name = "ContentFrame"
ContentFrame.Position = UDim2.new(0, 154, 0, 70)
ContentFrame.Size = UDim2.new(1, -166, 0, 430)
ContentFrame.BackgroundTransparency = 1

-- Function to create a nice tab button and content panel
local function CreateTab(tabName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 48)
    btn.BackgroundColor3 = Color3.fromRGB(30,30,36)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Text = tabName
    btn.TextColor3 = Color3.fromRGB(230,230,235)
    btn.Parent = TabsFrame
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,10)

    local panel = Instance.new("Frame", ContentFrame)
    panel.Size = UDim2.new(1, 0, 1, 0)
    panel.Position = UDim2.new(0, 0, 0, 0)
    panel.BackgroundTransparency = 1
    panel.Visible = false

    return btn, panel
end

-- Create 5 tabs
local tabButtons = {}
local tabPanels = {}
for i = 1, 5 do
    local name = "Aba "..i
    local btn, panel = CreateTab(name)
    tabButtons[i] = btn
    tabPanels[i] = panel
end

-- Activate first tab by default
tabPanels[1].Visible = true

-- Tab switching logic
for i, btn in ipairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(tabPanels) do p.Visible = false end
        tabPanels[i].Visible = true
    end)
end

-- Helper to create a centered button inside a panel
local function MakeCenteredButton(parent, text, sizeX, sizeY, posY)
    sizeX = sizeX or 200
    sizeY = sizeY or 48
    posY = posY or 0.5
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0, sizeX, 0, sizeY)
    b.Position = UDim2.new(0.5, -sizeX/2, posY, -sizeY/2)
    b.BackgroundColor3 = Color3.fromRGB(60,60,70)
    b.BorderSizePixel = 0
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0,10)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    b.Text = text
    b.TextColor3 = Color3.fromRGB(245,245,250)
    return b
end

-- ========= Aba 1: Tool + Teleport =========
local panel1 = tabPanels[1]

local labelInfo = Instance.new("TextLabel", panel1)
labelInfo.Size = UDim2.new(1, -40, 0, 40)
labelInfo.Position = UDim2.new(0, 20, 0, 12)
labelInfo.BackgroundTransparency = 1
labelInfo.Font = Enum.Font.Gotham
labelInfo.TextSize = 14
labelInfo.TextColor3 = Color3.fromRGB(200,200,210)
labelInfo.Text = "Clique em 'Tool' para receber a ferramenta. Segure-a e clique no mapa para teleportar."
labelInfo.TextXAlignment = Enum.TextXAlignment.Left

local toolBtn = MakeCenteredButton(panel1, "Tool", 220, 52, 0.45)

-- Function: cria a Tool simples com Handle
local function CreateTeleportTool()
    local tool = Instance.new("Tool")
    tool.Name = "TeleportTool"
    tool.RequiresHandle = true
    tool.CanBeDropped = true

    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1,1,1)
    handle.Anchored = false
    handle.CanCollide = false
    handle.Transparency = 0.15
    handle.Material = Enum.Material.SmoothPlastic
    handle.Parent = tool

    -- Visual: pequeno brilho
    local mesh = Instance.new("SpecialMesh", handle)
    mesh.MeshType = Enum.MeshType.Sphere
    mesh.Scale = Vector3.new(0.6,0.6,0.6)

    return tool
end

-- Teleport logic: quando equipado, clicar no mapa teleporta o personagem
local function SetupToolTeleport(tool)
    local mouse = LocalPlayer:GetMouse()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    local equipped = false
    local connButton = nil
    local debounce = false

    local function teleportTo(position)
        if not character or not character.Parent then return end
        local hrp = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
        if not hrp then return end
        if debounce then return end
        debounce = true
        -- teleport a alguns studs acima para evitar ficar preso no chão
        local targetCFrame = CFrame.new(position + Vector3.new(0, 3.5, 0))
        -- tenta setar CFrame com cuidado
        pcall(function()
            hrp.CFrame = targetCFrame
        end)
        wait(0.15)
        debounce = false
    end

    -- Conecta quando tool é equipado
    tool.Equipped:Connect(function()
        equipped = true
        -- conectar clique do mouse
        connButton = mouse.Button1Down:Connect(function()
            -- só teleportar se o mouse estiver apontando para algo (Hit)
            local hit = mouse.Hit
            if hit and hit.p then
                teleportTo(hit.p)
            end
        end)
    end)

    tool.Unequipped:Connect(function()
        equipped = false
        if connButton then
            connButton:Disconnect()
            connButton = nil
        end
    end)
end

toolBtn.MouseButton1Click:Connect(function()
    -- dar a tool para o jogador
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    if not backpack then
        warn("Backpack não encontrado.")
        return
    end

    -- se já tiver a tool no inventário ou na mão, não criar duplicata
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("TeleportTool") then
        -- já equipado
        return
    end
    if backpack:FindFirstChild("TeleportTool") then
        return
    end

    local tool = CreateTeleportTool()
    tool.Parent = backpack
    SetupToolTeleport(tool)
end)

-- ========= Abas 2-5: placeholders limpos (você pode editar) =========
for i = 2, 5 do
    local panel = tabPanels[i]
    local sampleLabel = Instance.new("TextLabel", panel)
    sampleLabel.Size = UDim2.new(1, -40, 0, 40)
    sampleLabel.Position = UDim2.new(0, 20, 0, 12)
    sampleLabel.BackgroundTransparency = 1
    sampleLabel.Font = Enum.Font.Gotham
    sampleLabel.TextSize = 16
    sampleLabel.TextColor3 = Color3.fromRGB(200,200,210)
    sampleLabel.Text = "Conteúdo da Aba "..i.." (edite como quiser)."
    sampleLabel.TextXAlignment = Enum.TextXAlignment.Left
end

-- (Opcional) tecla para fechar/abrir a hub (ex: RightControl)
local UserInputService = game:GetService("UserInputService")
local visible = true
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        visible = not visible
        MainFrame.Visible = visible
    end
end)

print("[Beautiful Hub] carregada com sucesso.")
