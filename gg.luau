local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MenuWithButtonList"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Основное окно меню
local frameWidth, frameHeight = 380, 300
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, frameWidth, 0, frameHeight)
frame.Position = UDim2.new(0.5, -frameWidth/2, 0.5, -frameHeight/2)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35) -- тёмный фон
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0
frame.ZIndex = 3
frame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 24)
uiCorner.Parent = frame

-- Скролл панель для кнопок
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -60) -- отступы для шапки и краёв
scrollFrame.Position = UDim2.new(0, 10, 0, 50)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- подстроим динамически
scrollFrame.ScrollBarThickness = 6
scrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

scrollFrame.Parent = frame

local uiPadding = Instance.new("UIPadding")
uiPadding.PaddingLeft = UDim.new(0, 5)
uiPadding.PaddingTop = UDim.new(0, 5)
uiPadding.PaddingRight = UDim.new(0, 5)
uiPadding.PaddingBottom = UDim.new(0, 5)
uiPadding.Parent = scrollFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 8)
uiListLayout.Parent = scrollFrame

-- Обновление CanvasSize по содержимому
local function updateCanvasSize()
    local contentSize = uiListLayout.AbsoluteContentSize
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 10)
end

uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)

-- Функция создания кнопки с эффектами
local function createButton(text)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- серый базовый цвет
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    
    local uiCornerBtn = Instance.new("UICorner")
    uiCornerBtn.CornerRadius = UDim.new(0, 12)
    uiCornerBtn.Parent = button
    
    button.Text = text
    button.TextColor3 = Color3.fromRGB(230, 230, 230)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 20
    
    -- Состояния кнопки
    button.MouseEnter:Connect(function()
        if button.BackgroundColor3 ~= Color3.fromRGB(80, 180, 80) then -- не зеленый
            button.BackgroundColor3 = Color3.fromRGB(130, 130, 130) -- светлее серого при наведении
        end
    end)
    
    button.MouseLeave:Connect(function()
        if button.BackgroundColor3 ~= Color3.fromRGB(80, 180, 80) then
            button.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- исходный серый
        end
    end)
    
    button.MouseButton1Click:Connect(function()
        -- Окрашиваем кнопку в зелёный и снимаем с остальных зеленую подсветку
        for _, btn in pairs(scrollFrame:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            end
        end
        button.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
        print("Кнопка '"..text.."' нажата!")
        
        -- Здесь можно добавить вызов вашей функции для кнопки "Give" или других
    end)
    
    return button
end

-- Шапка меню
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 40)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- серая шапка
header.BorderSizePixel = 0
header.Text = "Меню"
header.TextColor3 = Color3.fromRGB(230, 230, 230)
header.Font = Enum.Font.GothamBold
header.TextSize = 22
header.TextXAlignment = Enum.TextXAlignment.Left
header.TextYAlignment = Enum.TextYAlignment.Center
header.Parent = frame

local headerUICorner = Instance.new("UICorner")
headerUICorner.CornerRadius = UDim.new(0, 24)
headerUICorner.Parent = header

-- Добавляем кнопку "Give" в список
local giveButton = createButton("Give")
giveButton.Parent = scrollFrame

-- Обновляем размер скролла
updateCanvasSize()
