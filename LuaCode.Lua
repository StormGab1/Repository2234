local Event = game.ReplicatedStorage:FindFirstChild("Aceitar")
local Corrida = workspace:FindFirstChild("Corrida")
local Folder = game.ReplicatedStorage:FindFirstChild("Ganhadores")

local debounce = false
local debounc2 = false
local Number = 0
local Number2 = 0
local Number3 = 0
local Number4 = 0

game.Players.PlayerAdded:Connect(function(player)
	if player.AccountAge < 10 then
		-- verifica se o player é novo e adiciona um debounce para evitar trapaça
		print(player.Name)
	local debounce1 = Instance.new("BoolValue")
	debounce1.Name = "Valor"
	
	debounce1.Parent = player
	end
end)

-- Função para selecionar um mapa aleatório para a corrida
local function RandomMap()
	local MapsFolder = game.ReplicatedStorage.RaceMaps
	local MapaAtual = workspace:FindFirstChild("Corrida")

	if MapaAtual then
		MapaAtual.Inicio.Transparency = 0.9
		MapaAtual.Inicio.CanCollide = true
		MapaAtual.Parent = MapsFolder
	end

	local Maps = MapsFolder:GetChildren()
	local MapaRandom = math.random(1, #Maps)
	local selectedMap = Maps[MapaRandom]

	selectedMap.Parent = workspace
	Corrida = selectedMap
end

-- Função para anunciar os vencedores da corrida
local function ganhadores()
	if debounce then
		for _, player in pairs(game.Players:GetChildren()) do
			local Debounc = player:FindFirstChild("Corrida")
			Debounc.Value = true
		end

		for _, player in pairs(game.Players:GetChildren()) do
			local Gui = game.StarterGui.RunTimer:Clone()
			Gui.Ganhadores.Visible = true
			Gui.Ganhadores.LocalScript.Enabled = true
			Gui.Parent = player.PlayerGui
		end

		task.wait(1)
		Number, Number2, Number3, Number4 = 0, 0, 0, 0
		debounce, debounc2 = false, false

		for _, player in pairs(game.Players:GetChildren()) do
			local valor = player:FindFirstChild("Valor2")
			if valor then valor.Value = false end
		end

		task.wait(1)

		for _, player in pairs(Folder:GetChildren()) do
			player:Destroy()
		end

		for _, plr in pairs(script.Folder:GetChildren()) do
			local p = game.Players:FindFirstChild(plr.Name)
			if p then
				local Humanoid = p.Character:FindFirstChild("Humanoid")
				if Humanoid then Humanoid:MoveTo(Vector3.new(182, 4, -178)) end
				plr:Destroy()
			end
		end
	end

	for _, player in pairs(game.Players:GetChildren()) do
		local Debounc = player:FindFirstChild("Corrida")
		Debounc.Value = true
	end
end

-- Função para verificar e anunciar os vencedores
local function chamarwinners()
	for _, player in pairs(script.Folder:GetChildren()) do
		Number2 += 1
	end

	for _, winner in pairs(Folder:GetChildren()) do
		Number3 += 1
	end

	if Number2 == Number3 then
		ganhadores()
	end

	for _, player in pairs(Folder:GetChildren()) do
		local plr = script.Folder:FindFirstChild(player.Value)
		if plr then
			plr:Destroy()
		end
	end
end

-- Função principal da corrida
local function corrida()
	debounc2, debounce = true, true

	for _, player in pairs(script.Folder:GetChildren()) do
		player:Destroy()
	end

	for _, player in pairs(game.Players:GetChildren()) do
		local Gui = game.StarterGui.RunTimer:Clone()
		Gui.Run.LocalScript.Enabled = true
		Gui.Run.Visible = true
		Gui.Parent = player.PlayerGui
	end

	task.wait(60)

	for _, Player in pairs(Folder:GetChildren()) do
		if Player then Number4 += 1 end
	end

	task.wait(1)

	if Number4 == 0 then
		ganhadores()
	end
end

-- Evento de aceitação da corrida
Event.OnServerEvent:Connect(function(player)
	if debounce then
		local Char = script.Folder:FindFirstChild(player.Name)
		if not Char then
			local Name = Instance.new("StringValue")
			Name.Name = player.Name
			Name.Parent = script.Folder

			local Humanoid = player.Character:FindFirstChild("HumanoidRootPart")
			local Character = player.Character
			if Humanoid then
				local deboun = player:FindFirstChild("Corrida")
				deboun.Value = false
				Humanoid.Anchored = true
				Character:MoveTo(Vector3.new(11, 30.5, -1550))
				task.wait(3)
				Humanoid.Anchored = false

				for _, p in pairs(script.Folder:GetChildren()) do
					local plr = game.Players:FindFirstChild(p.Name)
					if plr and debounc2 then
						local Gui = game.StarterGui.RunTimer:Clone()
						Gui.Parent = plr.PlayerGui
						Gui.Time.LocalScript.Enabled = true
						Gui.Time.Visible = true
					else
						p:Destroy()
					end
				end

				debounc2 = false
				task.wait(5)
				Corrida.Inicio.CanCollide = false
				Corrida.Inicio.Transparency = 1
			end
		end
	end
end)

-- Função para atualizar a corrida e verificar se alguém completou a corrida
local function Update()
	Corrida.Chegada.Touched:Connect(function(part)
		if debounce then
			local Humanoid = part.Parent:FindFirstChild("HumanoidRootPart")
			if Humanoid then
				local Player = game.Players:FindFirstChild(Humanoid.Parent.Name)
				local leaderstats = Player:FindFirstChild("leaderstats")
				local valor = Player:FindFirstChild("Valor2")

				if valor.Value == false then
					valor.Value = true

					if script.Folder:FindFirstChild(Player.Name) then
						local Gui = game.StarterGui.RunTimer:Clone()

						if Number < 3 then
							local Value = Instance.new("StringValue")
							Number += 1
							Gui.Fim.Lugar.Text = tostring(Number)

							if Number == 1 then
								Gui.Fim.Coin.Text = "100"
								leaderstats.Coins.Value += 100
								Value.Name = "Win1"
								Value.Value = Player.Name
								Value.Parent = Folder
								Player.Character:MoveTo(Vector3.new(182, 4, -178))
								chamarwinners()
							elseif Number == 2 then
								Gui.Fim.Coin.Text = "50"
								leaderstats.Coins.Value += 50
								Value.Name = "Win2"
								Value.Value = Player.Name
								Value.Parent = Folder
								Player.Character:MoveTo(Vector3.new(182, 4, -178))
								chamarwinners()
							elseif Number == 3 then
								Gui.Fim.Coin.Text = "25"
								leaderstats.Coins.Value += 25
								Value.Name = "Win3"
								Value.Value = Player.Name
								Value.Parent = Folder
								Player.Character:MoveTo(Vector3.new(182, 4, -178))
								ganhadores()
							end

							Gui.Fim.Visible = true
							Gui.Fim.LocalScript.Enabled = true
							Gui.Parent = Player.PlayerGui
						end
					end
				end
			end
		end
	end)
end


local function IniciarCorrida()
	RandomMap()
	task.wait(0.5)
	Update()
	corrida()
end


while true do
	IniciarCorrida()
	task.wait(80)
end
