-- Dependências
local player = require("characteres.player.player")
local playerActions = require("characteres.player.actions")
local colossus = require('characteres.colossus.colossus')
local utils = require("utils")

-- Habilitar o UTF8
utils.enableUTF8()

--Header
utils.printHeader()

local boss = colossus

-- Imprimi as informações do boss
utils.printCreature(boss)

-- Build actions
playerActions.build();

-- Loop da batalha
while true do
    -- Mostrar opções de ações para o jogador
    print("O que você desejar fazer?")
    local validPlayerActions = playerActions.getValidActions(player, boss)
    for i, action in pairs(validPlayerActions) do
        print(string.format("%d. %s", i, action.description))
    end
    local chosenIndex = utils.ask()
    local chosenAction = validPlayerActions[chosenIndex]
    local isActionValid = chosenAction ~= nil
    
    -- Simular o turno do jogador
    if isActionValid then
        chosenAction.execute(player, boss)
    else
        print('Sua ação é inválida. Você perdeu a vez')
    end
    
    -- saída: boss morre
    if boss.health <=0 then
        break
    end
    -- Simular o turno do boss

    -- saída: jogador morre
    if player.health <=0 then
        break
    end
end
