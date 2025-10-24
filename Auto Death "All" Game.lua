-- LocalScript: Лазер убивает всегда
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Player = Players.LocalPlayer

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Name = "LaserKill"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 120, 0, 80)
frame.Position = UDim2.new(0.5, -60, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 20)
title.BackgroundTransparency = 1
title.Text = "Laser Kill"
title.TextColor3 = Color3.fromRGB(255, 150, 150)
title.Font = Enum.Font.GothamBold
title.Parent = frame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -4, 0, 30)
toggleBtn.Position = UDim2.new(0, 2, 0, 25)
toggleBtn.Text = "START"
toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
toggleBtn.Parent = frame

local deleteBtn = Instance.new("TextButton")
deleteBtn.Size = UDim2.new(1, -4, 0, 25)
deleteBtn.Position = UDim2.new(0, 2, 0, 60)
deleteBtn.Text = "DELETE"
deleteBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
deleteBtn.Parent = frame

screenGui.Parent = Player:WaitForChild("PlayerGui")

-- Переменные
local isRunning = false
local laser = nil

-- Создание лазера
local function createLaser()
	if laser and laser.Parent then
		laser:Destroy()
	end

	laser = Instance.new("Part")
	laser.Name = "KillLaser"
	laser.Size = Vector3.new(6, 0.2, 6)
	laser.Color = Color3.fromRGB(255, 50, 50)
	laser.Material = Enum.Material.Neon
	laser.Anchored = true
	laser.CanCollide = true
	laser.Transparency = 0.7
	laser.Parent = Workspace

	-- Урон без флага touched
	laser.Touched:Connect(function(hit)
		local char = Player.Character
		if not char then return end

		local humanoid = hit:FindFirstAncestorOfClass("Model") and hit:FindFirstAncestorOfClass("Model"):FindFirstChild("Humanoid")
		if humanoid and humanoid.Parent == char and humanoid.Health > 0 then
			humanoid:TakeDamage(999)
		end
	end)
end

-- Обновление позиции
local function updateLaser()
	if not isRunning or not laser then return end
	local char = Player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		laser.Position = hrp.Position - Vector3.new(0, 3, 0)
	end
end

-- Старт
local function start()
	if isRunning then return end
	isRunning = true
	toggleBtn.Text = "STOP"
	toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
	createLaser()
	game:GetService("RunService").RenderStepped:Connect(updateLaser)
end

-- Стоп
local function stop()
	isRunning = false
	toggleBtn.Text = "START"
	toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
	if laser then
		laser:Destroy()
		laser = nil
	end
end

-- Удалить всё
deleteBtn.MouseButton1Click:Connect(function()
	stop()
	screenGui:Destroy()
end)

toggleBtn.MouseButton1Click:Connect(function()
	if isRunning then stop() else start() end
end)
