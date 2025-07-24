local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BeautifulMenu"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 180)
frame.Position = UDim2.new(0.5, -170, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35) -- глубокий тёмно-синий оттенок
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.18
frame.Parent = screenGui

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
shadow.Size = frame.Size + UDim2.new(0, 24, 0, 24)
shadow.Position = frame.Position + UDim2.new(0, -12, 0, -12)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.85
shadow.BorderSizePixel = 0
shadow.ZIndex = frame.ZIndex - 1
shadow.Parent = screenGui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 36)
shadowCorner.Parent = shadow

-- Помещаем основной frame сверху (визуально)
frame.ZIndex = 2
shadow.ZIndex = 1

-- Дополнительно: неактивно добавим полупрозрачный белый градиент сверху для глубины
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.15, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(25,25,35)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(25,25,35))
})
gradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0.0, 0.45),
    NumberSequenceKeypoint.new(0.22, 0.9),
    NumberSequenceKeypoint.new(0.33, 1),
    NumberSequenceKeypoint.new(1, 1)
})
gradient.Rotation = 90
gradient.Parent = frame
