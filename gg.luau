-- Имя предмета для выдачи (замените на нужное)
local itemName = "TestItem" 

-- Получаем локального игрока
local player = game.Players.LocalPlayer
if not player then
    return -- если игрок не найден, прерываем скрипт
end

-- Пытаемся найти предмет в ServerStorage
local item = game:GetService("ServerStorage"):FindFirstChild(itemName)
if item then
    -- Клонируем предмет и кладём в рюкзак игрока (Backpack)
    local clonedItem = item:Clone()
    clonedItem.Parent = player.Backpack
else
    warn("Предмет с именем '" .. itemName .. "' не найден в ServerStorage")
end
