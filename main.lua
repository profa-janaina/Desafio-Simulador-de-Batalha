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

-- Loop da batalha
while true do
    -- Mostrar opções de ações para o jogador
    -- Simular o turno do jogador
    
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
