-- Переменная для остановки цикла (если понадобится)
local run = true

-- Основной цикл, телепортирующий всех игроков к LocalPlayer
while run do
    local localPlayer = game.Players.LocalPlayer
    
    -- Проверка, что у LocalPlayer есть персонаж и HumanoidRootPart
    if localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local localRoot = localPlayer.Character.HumanoidRootPart.CFrame
        local offset = localPlayer.Character.HumanoidRootPart.CFrame.lookVector * 2  -- Смещение на 2 единицы вперед
        
        -- Перебор всех игроков на сервере
        for _, player in ipairs(game.Players:GetPlayers()) do
            -- Проверка, чтобы не телепортировать самого LocalPlayer
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                -- Перемещение HumanoidRootPart игрока к позиции LocalPlayer с учетом смещения
                player.Character.HumanoidRootPart.CFrame = localRoot + offset
            end
        end
    end
    
    -- Ожидание перед следующим выполнением, чтобы снизить нагрузку на сервер
    wait(0.1)  -- интервал в 0.1 секунды, можно изменить
end
