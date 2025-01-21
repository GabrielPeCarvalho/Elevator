cronometro = {}

function cronometro:load()
  cronometro.armazena_tempos = {}
  cronometro.inicia_cronometro = {}
  cronometro.para_cronometro = {}
  cronometro.stop = {}
  cronometro.start = {}
  cronometro.pesos = {}
  cronometro.passageiros = {}
  cronometro.peso_total = 0
  cronometro.tempoMaior = 0
  
end

function table.sum(tabela)
  local sum = 0
  for k,v in pairs(tabela) do
    sum = sum + v
  end
  return sum
end

function cronometro:update(dt)
  for i = 1, #cronometro.armazena_tempos do
    if cronometro.start[i] == true and pause == false then
      cronometro.armazena_tempos[i] = cronometro.armazena_tempos[i] + dt
      cronometro.passageiros[i] = cronometro.pesos[i]
    end
    if cronometro.stop[i] == true then
      cronometro.start[i] = false
    end
    if elevador.andaratual == cronometro.inicia_cronometro[i] and elevador.vel == 0 then
      cronometro.start[i] = true
    elseif elevador.andaratual == cronometro.para_cronometro[i] and elevador.vel == 0 and cronometro.start[i] == true  then
      cronometro.stop[i] = true
    end
    if cronometro.stop[i] == true then
      cronometro.inicia_cronometro[i] = -1
      cronometro.para_cronometro[i] = -1
      cronometro.passageiros[i] = 0
      cronometro.pesos[i] = 0
    end
  end
  
  cronometro.peso_total = table.sum(cronometro.passageiros)
  if #cronometro.armazena_tempos > 0 then
    cronometro.tempoMaior = math.max(unpack(cronometro.armazena_tempos))
  end
end

return cronometro