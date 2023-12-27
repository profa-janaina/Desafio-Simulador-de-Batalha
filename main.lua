-- Dependências
local player = require("characteres.player.player")
local playerActions = require("characteres.player.actions")
local colossus = require('characteres.colossus.colossus')
local colossusActions = require('characteres.colossus.actions')
local fenix = require('characteres.fenix.fenix')
local fenixActions = require('characteres.fenix.actions')
local taki = require('characteres.taki.taki')
local takiActions = require('characteres.taki.actions')
local sweet = require('characteres.sweet.sweet')
local sweetActions = require('characteres.sweet.actions')

local utils = require("utils")

-- Habilitar o UTF8
utils.enableUTF8()

--Header
utils.printHeader()

-- Boss configurations
local boss = sweet
local bossActions = sweetActions

-- Imprimi as informações do boss
utils.printCreature(boss)

-- Build actions
playerActions.build();
bossActions.build();

-- Loop da batalha
while true do
    -- Mostrar opções de ações para o jogador
    print(string.format("Qual a próxima ação de %s?", player.name))
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
        print(string.format('Ação é inválida. %s perdeu a vez', player.name))
    end
    
    -- saída: boss morre
    if boss.health <=0 then
        break
    end
    -- Simular o turno do boss
    print()
    local validBossActions = bossActions.getValidActions(player, boss)
    local bossAction = validBossActions[math.random(#validBossActions)]
    bossAction.execute(player, boss)

    -- saída: jogador morre
    if player.health <=0 then
        break
    end
end

if player.health <=0 then
    print()
    print('-------------------------------------------------------------')
    print('     (+_+)        GAME OVER         (+_+)       ')
    print('-------------------------------------------------------------')
    print()
    print(string.format("%s não resistiu e foi derrotado por %s", player.name, boss.name))
    print(' ¯"\"(°_o)/¯ Quem sabe na próxima vez...')
    print()
end

if boss.health <=0 then
    print()
    print('-------------------------------------------------------------')
    print('    "\"^o^/        VICTORY         "\"^o^/      ')
    print('-------------------------------------------------------------')
    print()
    print(string.format("%s foi espetacular e derrotou %s", player.name, boss.name))
    print('(☞ﾟヮﾟ)☞ Parabéns!!! ')
    print()
end