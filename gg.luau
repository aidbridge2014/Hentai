-- gg.lua для выдачи предмета себе (под LocalPlayer)

local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")

local itemAssetId = 225921000
local player = Players.LocalPlayer

if not player then
    warn("Players.LocalPlayer не доступен. Запустите скрипт на стороне клиента.")
    return
end

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
        print("Tool с ID "..itemAssetId.." успешно добавлен в ваш рюкзак")
    else
        warn("В ассете нет объекта типа Tool")
    end
else
    warn("Не удалось загрузить ассет с ID "..itemAssetId)
end
