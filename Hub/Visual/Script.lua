-- // Hub Simples em Lua para KRNL // --
-- // Feito por ChatGPT // --

-- Cria a ScreenGui
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TabsFrame = Instance.new("Frame")
local ContentFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

-- Definições
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true -- deixa a hub arrastável

TabsFrame.Name = "TabsFrame"
TabsFrame.Parent = MainFrame
TabsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabsFrame.Size = UDim2.new(0, 100, 1, 0)

UIListLayout.Parent = TabsFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ContentFrame.Position = UDim2.new(0, 100, 0, 0)
ContentFrame.Size = UDim2.new(1, -100, 1, 0)

-- Função para criar abas
local function CriarAba(nome, callback)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = TabsFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TabButton.Size = UDim2.new(1, 0, 0, 40)
    TabButton.Text = nome
    TabButton.TextColor3 = Color3.fromRGB(255,255,255)

    local Frame = Instance.new("Frame")
    Frame.Parent = ContentFrame
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Frame.Visible = false

    TabButton.MouseButton1Click:Connect(function()
        for _,v in pairs(ContentFrame:GetChildren()) do
            if v:IsA("Frame") then
                v.Visible = false
            end
        end
        Frame.Visible = true
        if callback then
            callback(Frame)
        end
    end)

    return Frame
end

-- Criando as 5 abas
local Aba1 = CriarAba("Função 1", function(Frame)
    local Btn = Instance.new("TextButton", Frame)
    Btn.Size = UDim2.new(0,150,0,50)
    Btn.Position = UDim2.new(0.5, -75, 0.5, -25)
    Btn.Text = "Executar Função 1"
    Btn.MouseButton1Click:Connect(function()
        print("Função 1 ativada!")
        -- Coloque seu código aqui
    end)
end)

local Aba2 = CriarAba("Função 2", function(Frame)
    local Btn = Instance.new("TextButton", Frame)
    Btn.Size = UDim2.new(0,150,0,50)
    Btn.Position = UDim2.new(0.5, -75, 0.5, -25)
    Btn.Text = "Executar Função 2"
    Btn.MouseButton1Click:Connect(function()
        print("Função 2 ativada!")
        -- Coloque seu código aqui
    end)
end)

local Aba3 = CriarAba("Função 3", function(Frame)
    local Btn = Instance.new("TextButton", Frame)
    Btn.Size = UDim2.new(0,150,0,50)
    Btn.Position = UDim2.new(0.5, -75, 0.5, -25)
    Btn.Text = "Executar Função 3"
    Btn.MouseButton1Click:Connect(function()
        print("Função 3 ativada!")
        -- Coloque seu código aqui
    end)
end)

local Aba4 = CriarAba("Função 4", function(Frame)
    local Btn = Instance.new("TextButton", Frame)
    Btn.Size = UDim2.new(0,150,0,50)
    Btn.Position = UDim2.new(0.5, -75, 0.5, -25)
    Btn.Text = "Executar Função 4"
    Btn.MouseButton1Click:Connect(function()
        print("Função 4 ativada!")
        -- Coloque seu código aqui
    end)
end)

local Aba5 = CriarAba("Função 5", function(Frame)
    local Btn = Instance.new("TextButton", Frame)
    Btn.Size = UDim2.new(0,150,0,50)
    Btn.Position = UDim2.new(0.5, -75, 0.5, -25)
    Btn.Text = "Executar Função 5"
    Btn.MouseButton1Click:Connect(function()
        print("Função 5 ativada!")
        -- Coloque seu código aqui
    end)
end)

-- Ativa a primeira aba por padrão
Aba1.Visible = true
