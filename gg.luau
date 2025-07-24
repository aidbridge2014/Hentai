-- Мини меню GUI для Roblox (Luau)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Создаем ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MiniMenu"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Создаем Frame (окно меню)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 120) -- ширина 250, высота 120 пикселей
frame.Position = UDim2.new(0.5, -125, 0.5, -60) -- по центру экрана
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Текст заголовка
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Мини Меню"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = frame

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 3)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false -- Скрываем меню при нажатии X
end)

-- Пример кнопки action в меню
local actionButton = Instance.new("TextButton")
actionButton.Size = UDim2.new(0, 200, 0, 40)
actionButton.Position = UDim2.new(0.5, -100, 0, 50)
actionButton.BackgroundColor3 = Color3.fromRGB(50, 120, 220)
actionButton.Text = "Выполнить действие"
actionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
actionButton.Font = Enum.Font.GothamBold
actionButton.TextSize = 20
actionButton.Parent = frame

actionButton.MouseButton1Click:Connect(function()
    print("Кнопка нажата! Здесь вызов вашей функции.")
    -- Здесь разместите реальный код вашего скрипта, например:
    -- giveToolToPlayer(Players.LocalPlayer)
end)
