local run = true

-- Фиксируем позицию запуска скрипта
local localPlayer = game.Players.LocalPlayer
local startPosition = nil

if localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
    startPosition = localPlayer.Character.HumanoidRootPart.CFrame
else
    warn("Скрипт не может определить позицию LocalPlayer.")
    return
end

while run do
    -- Проверяем, что начальная позиция зафиксирована
    if startPosition then
        local spacing = 3 -- Расстояние между игроками в линии
        local positionOffset = 0 -- Начальный сдвиг для первого игрока

        for _, player in ipairs(game.Players:GetPlayers()) do
            -- Исключаем LocalPlayer и проверяем, что игрок из команды "Outlaws"
            if player ~= localPlayer and player.Team and player.Team.Name == "Outlaws" then
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = player.Character.HumanoidRootPart

                    -- Сбрасываем инерцию
                    hrp.Velocity = Vector3.zero
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero

                    -- Рассчитываем позицию в линии перед сохранённой позицией LocalPlayer
                    local newPosition = startPosition.Position + (startPosition.LookVector * 5) + Vector3.new(positionOffset, 0, 0)

                    -- Телепортируем игрока
                    hrp.CFrame = CFrame.new(newPosition)

                    -- Увеличиваем сдвиг для следующего игрока
                    positionOffset = positionOffset + spacing
                end
            end
        end
    end

    wait(0.1)
end
