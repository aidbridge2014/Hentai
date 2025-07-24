-- ID предмета Rainbow Magic Carpet
local itemId = 225921000

-- Функция для выдачи предмета игроку через InsertService
local InsertService = game:GetService("InsertService")
local player = game.Players.LocalPlayer
if not player then
    return -- если игрок не найден, прекращаем выполнение
end

-- Пытаемся загрузить предмет по ID и добавить в рюкзак игрока
local success, item = pcall(function()
    return InsertService:LoadAsset(itemId)
end)

if success and item then
    -- Предмет может быть моделью, ищем инструмент внутри или сами экземпляры
    local tool = item:FindFirstChildWhichIsA("Tool") or item:GetChildren()[1]
    if tool then
        tool.Parent = player.Backpack
    else
        warn("Не удалось найти инструмент внутри загруженного объекта")
        item:Destroy()
    end
else
    warn("Не удалось загрузить предмет по ID " .. tostring(itemId))
end
