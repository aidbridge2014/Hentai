local Players = game:GetService("Players")
local targetUsername = "hoangtrangblwsb"
local itemAssetId = 225921000

local targetPlayer = Players:FindFirstChild(targetUsername)
if targetPlayer then
    -- Создаем новый объект Tool через InsertService
    local InsertService = game:GetService("InsertService")
    local success, tool = pcall(function()
        return InsertService:LoadAsset(itemAssetId)
    end)
    
    if success and tool then
        -- В LoadAsset может прийти Model или Folder, берем первый элемент типа Tool
        local toolObj
        for _, child in pairs(tool:GetChildren()) do
            if child:IsA("Tool") then
                toolObj = child
                break
            end
        end

        if toolObj then
            -- Кладём Tool в рюкзак игрока (Backpack)
            toolObj.Parent = targetPlayer:WaitForChild("Backpack")
            print("Tool успешно дан игроку "..targetUsername)
        else
            print("В загруженном объекте нет Tool")
        end
    else
        warn("Не удалось загрузить предмет с ID "..itemAssetId)
    end
else
    warn("Игрок с ником "..targetUsername.." не найден")
end
