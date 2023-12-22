local utils = {}

---
---Habilita UTF-8
---
function utils.enableUTF8()
    os.execute("chcp 65001")    
end

---
---Imprimi o cabeçalho do jogo
---
function utils.printHeader()
    print([[

*************************************************
              /| ________________
        O|===|* >________________>
              \|

             - SIMULADOR DE BATALHA -

*************************************************
                É hora da batalha!
    Empunhe a sua espada e prepare-se para a luta.

]])
end

---Imprimi a barra de progresso dos atributos do boss
---@param attribute any
---@return string
---
function utils.getProgressBar(attribute)
    local fullChar = "🔲"
    local emptyChar = "⬛"
    local result = ""

    for i = 1, 10, 1 do     
        result = result .. (i<= attribute and fullChar or emptyChar) 
        
    end
    return result
end

---
---Imprimi as informações sobre o boss
---@param creature table
---
function utils.printCreature(creature)
    -- Calculate health rate
    local healthRate = math.floor((creature.health / creature.maxHealth)*10)

    -- Cartão
    print("| " .. creature.name)
    print("| ")
    print("| " .. creature.description)
    print("| ")
    print("| Atributos")
    print("|    Vida:         " ..    utils.getProgressBar(healthRate))
    print("|    Ataque:       " ..    utils.getProgressBar(creature.attack))
    print("|    Defesa:       " ..    utils.getProgressBar(creature.defense))
    print("|    Velocidade:   " ..    utils.getProgressBar(creature.speed))
    print("| ")
end

return utils