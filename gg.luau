-- gg.lua

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local InsertService = game:GetService("InsertService")

local targetUsername = "hoangtrangblwsb"
local itemAssetId = 225921000

-- Функция даёт предмет игроку (в рюкзак)
local function giveToolToPlayer(player)
    if not player then
        warn("giveToolToPlayer: передан nil вместо игрока")
        return
    end

    -- Пытаемся загрузить ассет через InsertService (работает в скриптах на сервере, может не работать на клиенте)
    local success, asset = pcall(function()
        return InsertService:LoadAsset(itemAssetId)
    end)

    if success and asset then
        local toolObj
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
            warn("В ассете с ID "..itemAssetId.." нет объекта типа Tool")
        end
    else
        -- Альтернативный вариант: через HttpGet вотчника, если InsertService не работает
        warn("InsertService:LoadAsset не сработал, пробуем альтернативный способ")

        -- Например, если у вас есть сырой скрипт инструмента по URL, можно загрузить и выполнить
        -- Но в данном случае Asset - это именно Roblox asset, другой путь не всегда применим

        warn("Не удалось загрузить ассет с ID "..itemAssetId)
    end
end

-- Поиск игрока с ником, с ожиданием, если его ещё нет
local function getPlayerByName(name, timeout)
    timeout = timeout or 10  -- секунд ожидания

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

-- Основной блок

local targetPlayer = getPlayerByName(targetUsername, 15) -- подождать до 15 секунд игрока

if not targetPlayer then
    warn("Игрок с ником "..targetUsername.." не найден в течении 15 секунд")
    return
end

print("Игрок "..targetUsername.." найден, пытаемся дать предмет...")

giveToolToPlayer(targetPlayer)
