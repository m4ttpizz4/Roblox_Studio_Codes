--Função para tocar o som quando o jogador morrer:
local function onPlayerDied(player)
    local character = player.Character
    if character then
        local sound = character:FindFirstChild("som_morte")
        if sound then
            sound:Play()
        end
    end
end

--Evento quando o personagem é spawnado:
local function onCharacterAdded(character)
    local player = game.Players:GetPlayerFromCharacter(character)
    character:WaitForChild("Humanoid").Died:Connect(function()
        onPlayerDied(player)
    end)
end

--Conectando a função ao evento para todos os jogadores:
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(onCharacterAdded)
end)

--Conectando a função ao evento para jogadores já existentes:
for _, player in pairs(game.Players:GetPlayers()) do
    if player.Character then
        onCharacterAdded(player.Character)
    end
    player.CharacterAdded:Connect(onCharacterAdded)
end
