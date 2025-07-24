-- gg.lua

local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")

local targetUsername = "hoangtrangblwsb"
local itemAssetId = 225921000

-- Пытаемся найти игрока с нужным ником
local targetPlayer = Players:FindFirstChild(targetUsername)

if targetPlayer then
    -- Пытаемся загрузить предмет по Asset ID
    local success, asset = pcall(function()
        return InsertService:LoadAsset(itemAssetId)
    end)

    if success and asset then
        -- Ищем в загруженном объекте первую Tool
        local toolObj = nil
        for _, child in pairs(asset:GetChildren()) do
            if child:IsA("Tool") then
                toolObj = child
                break
            end
        end

        if toolObj then
            toolObj.Parent = targetPlayer:WaitForChild("Backpack")
            print("Tool с ID "..itemAssetId.." успешно выдан игроку "..targetUsername)
        else
            warn("В ассете с ID "..itemAssetId.." нет объекта типа Tool")
        end
    else
        warn("Не удалось загрузить ассет с ID "..itemAssetId)
    end
else
    warn("Игрок с ником "..targetUsername.." не найден в игре")
end
