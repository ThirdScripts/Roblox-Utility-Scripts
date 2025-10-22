local function expandAllPlayerHitboxes()
      local localPlayer = game.Players.LocalPlayer

      for _, player in ipairs(game.Players:GetPlayers()) do
        pcall(function()
          if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hitbox = player.Character:FindFirstChild("HumanoidRootPart")
            if hitbox then
              hitbox.Size = Vector3.new(10, 10, 10)
              hitbox.CanCollide = false
              hitbox.Transparency = 0.5
              hitbox.Color = Color3.fromRGB(255, 0, 0)
            end
          end
        end)
      end
    end

    while true do
      expandAllPlayerHitboxes()
      wait(1)
    end
