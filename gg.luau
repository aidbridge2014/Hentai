local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SimpleMenu"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150) -- ширина 300, высота 150 пикселей
frame.Position = UDim2.new(0.5, -150, 0.5, -75) -- по центру экрана
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- чёрный цвет
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.4 -- слегка прозрачное окно
frame.Parent = screenGui
