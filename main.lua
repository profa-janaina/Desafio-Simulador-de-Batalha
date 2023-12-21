-- Habilitar o UTF8
os.execute("chcp 65001")

-- Dependências
local player = require("characteres.player")
local colossus = require('characteres.colossus')

--Header
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

local boss = colossus
