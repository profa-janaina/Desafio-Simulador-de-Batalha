local utils = require "utils"
local actions = {}

actions.list = {}

---
---Cria uma lista de ações armazenadas internamente
---
function actions.build()
    -- Resetar lista
    actions.list = {}

    --Atacar com espada
    local swordAttack ={
        description = "Atacar com a espada.",
        requirement = nil,
        execute = function (playerData, creatureData)
            --1. Definir chance de sucesso
            local sucessChance = creatureData.speed == 0 and 1 or playerData.speed / creatureData.speed
            local sucess = math.random() <= sucessChance
            
            --2. Apresentar resultado como print
            if sucess then
                --3. Calcular dano
                local rawDamage = playerData.attack - math.random() * creatureData.defense
                local damage = math.max(1, math.ceil(rawDamage))

                print(string.format("Você atacou a criatura causando %d pontos de dano", damage))
                local healthRate = math.floor((creatureData.health / creatureData.maxHealth)*10)
                print(string.format('%s: %s', creatureData.name, utils.getProgressBar(healthRate)))
                print()
                --4. Aplicar o dano
                creatureData.health = creatureData.health - damage
            else
                print("O seu ataque falhou, treine mais e tente novamente")  
            end
        end
    }

    -- Usar poção de regeneração
    local regenPotion ={
        description = "Tomar uma poção de regeneração.",
        requirement = function (playerData, creatureData)
            return playerData.potions >= 1
        end,
        execute = function (playerData, creatureData)
            --Tirar poção do inventário
            playerData.potions =  playerData.potions -1

            -- Recuperar vida
            local regenPoints = 5
            playerData.health = math.min(playerData.maxHealth, playerData.health + regenPoints)
            print("Você usou uma poção e recuperou pontos de vida")
        end
    }

    --Adicionar ação a lista
    actions.list[#actions.list+1] = swordAttack
    actions.list[#actions.list+1] = regenPotion
end

---
---Retorna uma lista de ações válidas
---@param playerData table
---@param creatureData table
---@return table
---
function actions.getValidActions(playerData, creatureData)
    local validaActions = {}
    for _, action in pairs(actions.list) do
       local requirement = action.requirement
       local isValid = requirement == nil or requirement(playerData, creatureData)
       if isValid then
        validaActions[#validaActions+1] = action        
       end 
    end
    return validaActions
end

return actions