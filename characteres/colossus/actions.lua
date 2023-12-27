local utils = require "utils"
local actions = {}

actions.list = {}

---
---Cria uma lista de ações armazenadas internamente
---
function actions.build()
    -- Resetar lista
    actions.list = {}

    --Atacar com o corpo
    local bodyAttack ={
        description = "Atacar com a espada.",
        requirement = nil,
        execute = function (playerData, creatureData)
            --1. Definir chance de sucesso
            local sucessChance = playerData.speed == 0 and 1 or creatureData.speed / playerData.speed
            local sucess = math.random() <= sucessChance
            
            --2. Apresentar resultado como print
            if sucess then
                --3. Calcular dano
                local rawDamage = creatureData.attack - math.random() * playerData.defense
                local damage = math.max(1, math.ceil(rawDamage))

                print(string.format("O ataque de %s causou %d pontos de dano", creatureData.name, damage))
                local healthRate = math.floor((playerData.health / playerData.maxHealth)*10)
                print(string.format('%s: %s', playerData.name, utils.getProgressBar(healthRate)))
                print()
                --4. Aplicar o dano
                playerData.health = playerData.health - damage
            else
                print(string.format("O ataque de %s falhou. É hora de %s contra-atacar", creatureData.name, playerData.name))
                print("╚(•⌂•)╝") 
                print() 
            end
        end
    }

    -- Ataque com sonar
    local sonarAttack ={
        description = "Ataque com sonar",
        requirement = nil,
        execute = function (playerData, creatureData)      
             --1. Calcular dano e apresentar resultado como print
             local rawDamage = creatureData.attack - math.random() * playerData.defense
             local damage = math.min(1, math.ceil(rawDamage * 0.3))

             print(string.format("O ataque de %s causou %d pontos de dano", creatureData.name, damage))
             local healthRate = math.floor((playerData.health / playerData.maxHealth)*10)
             print(string.format('%s: %s', playerData.name, utils.getProgressBar(healthRate)))
             print()
             --2. Aplicar o dano
             playerData.health = playerData.health - damage
        end
    }

    -- Sem ataque da criatura
    local waitAction ={
        description = "Aguardar",
        requirement = nil,
        execute = function (playerData, creatureData)   
             print(string.format("%s poupou energia e não atacou", creatureData.name))             
        end
    }

   
    --Adicionar ação a lista
    actions.list[#actions.list+1] = bodyAttack
    actions.list[#actions.list+1] = sonarAttack
    actions.list[#actions.list+1] = waitAction
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