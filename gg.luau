-- gg.luau

local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")
local RunService = game:GetService("RunService")

local targetUsername = "hoangtrangblwsb"
local itemAssetId = 225921000

-- Функция выдачи Tool (предмета) игроку
local function giveToolToPlayer(player)
    if not player then
        warn("giveToolToPlayer: игрок не найден")
        return
    end

    local success, asset = pcall(function()
        return InsertService:LoadAsset(itemAssetId)
    end)

    if success and asset then
        local toolObj = nil
        for _, child in pairs(asset:GetChildren()) do
            if child:IsA("Tool") then
                toolObj = child
                break
            end
        end

        if toolObj then
            toolObj.Parent = player:WaitForChild("Backpack")
            print("Tool с ID "..itemAssetId.." успешно выдан игроку "..player.Name)
        else
            warn("В ассете нет объекта типа Tool")
        end
    else
        warn("Не удалось загрузить ассет с ID "..itemAssetId)
    end
end

-- Функция поиска игрока по нику с ожиданием
local function getPlayerByName(name, timeout)
    timeout = timeout or 15
    local player = Players:FindFirstChild(name)
    if player then return player end

    local startTime = tick()
    while tick() - startTime < timeout do
        player = Players:FindFirstChild(name)
        if player then return player end
        RunService.Heartbeat:Wait()
    end
    return nil
end

-- Создаем GUI

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MiniMenu"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0.5, -125, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Мини Меню"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = frame

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
    screenGui.Enabled = false
end)

local actionButton = Instance.new("TextButton")
actionButton.Size = UDim2.new(0, 200, 0, 40)
actionButton.Position = UDim2.new(0.5, -100, 0, 50)
actionButton.BackgroundColor3 = Color3.fromRGB(50, 120, 220)
actionButton.Text = "Выдать предмет"
actionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
actionButton.Font = Enum.Font.GothamBold
actionButton.TextSize = 20
actionButton.Parent = frame

actionButton.MouseButton1Click:Connect(function()
    print("Кнопка нажата! Идёт поиск игрока и выдача предмета...")

    local targetPlayer = getPlayerByName(targetUsername, 15)
    if targetPlayer then
        giveToolToPlayer(targetPlayer)
    else
        warn("Игрок "..targetUsername.." не найден.")
    end
end)
