-- Dependências
local player = require("characteres.player")
local colossus = require('characteres.colossus')
local utils = require("utils")

-- Habilitar o UTF8
utils.enableUTF8()

--Header
utils.printHeader()

local boss = colossus

-- Imprimi as informações do boss
utils.printCreature(boss)
