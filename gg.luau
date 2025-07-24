local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BeautifulMenu"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Увеличенный размер меню по X и Y
local frameWidth, frameHeight = 380, 220
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, frameWidth, 0, frameHeight)
frame.Position = UDim2.new(0.5, -frameWidth / 2, 0.5, -frameHeight / 2)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35) -- глубокий тёмно-синий оттенок
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.18
frame.ZIndex = 3
frame.Parent = screenGui

-- Шапка (Header)
local headerHeight = 40
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, headerHeight)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- серая шапка
header.BorderSizePixel = 0
header.ZIndex = 4
header.Parent = frame

local headerUICorner = Instance.new("UICorner")
headerUICorner.CornerRadius = UDim.new(0, 24)
headerUICorner.Parent = header

-- Текст заголовка в шапке
local headerText = Instance.new("TextLabel")
headerText.Size = UDim2.new(1, -20, 1, 0)
headerText.Position = UDim2.new(0, 10, 0, 0)
headerText.BackgroundTransparency = 1
headerText.Text = "Меню"
headerText.TextColor3 = Color3.fromRGB(230, 230, 230)
headerText.Font = Enum.Font.GothamBold
headerText.TextSize = 22
headerText.TextXAlignment = Enum.TextXAlignment.Left
headerText.ZIndex = 5
headerText.Parent = header

-- Эффект плавной тени (UIStroke + SoftShadow)
local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(60, 90, 160)
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Parent = frame

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 24)
uiCorner.Parent = frame

-- Реализация мягкой тени через дополнительный Frame позади основного окна
local shadow = Instance.new("Frame")
shadow.Size = frame.Size + UDim2.new(0, 28, 0, 28) -- увеличим тень пропорционально меню
shadow.Position = frame.Position + UDim2.new(0, -14, 0, -14)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.85
shadow.BorderSizePixel = 0
shadow.ZIndex = 2
shadow.Parent = screenGui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 36)
shadowCorner.Parent = shadow

-- Дополнительно: полупрозрачный белый градиент сверху для глубины
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.15, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(25, 25, 35))
})
gradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0.0, 0.45),
    NumberSequenceKeypoint.new(0.22, 0.9),
    NumberSequenceKeypoint.new(0.33, 1),
    NumberSequenceKeypoint.new(1, 1)
})
gradient.Rotation = 90
gradient.Parent = frame

-- Кнопка закрытия (крестик)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 28, 0, 28)
closeButton.Position = UDim2.new(1, -38, 0, 6) -- чуть сдвинута внутрь шапки
closeButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.AutoButtonColor = true
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 24
closeButton.ZIndex = 5
closeButton.Parent = header -- добавляем крестик в шапку

local closeButtonCorner = Instance.new("UICorner")
closeButtonCorner.CornerRadius = UDim.new(0, 14)
closeButtonCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)
