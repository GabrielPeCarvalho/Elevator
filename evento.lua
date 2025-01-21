evento = {}
math.randomseed(os.time())

function evento:update(dt)
  --Movimento da porta  
  if abre == true and pause == false and config == false and aparencia == false then
    if elevador.larguraporta >0 then
      elevador.larguraporta = elevador.larguraporta-0.8
      if elevador.larguraporta <=0 then
        abre = false
      end
    end
  elseif fecha == true and pause == false and config == false and aparencia == false then
    if elevador.larguraporta <39 then
      elevador.larguraporta = elevador.larguraporta+0.8
      if elevador.larguraporta >=39 then
        fecha = false
      end
    end
  end
  if randomiza_andar == true then
    elevador.y = 480 - 230 * math.random(0,9)
    randomiza_andar = false
  end
end

--Botoes
function love.mousepressed(x,y,button)
  --START--
  if button == 1 and x > 50 and x < 135 and y > 200 and y < 220 and iniciar == true then
    menu.alpha_options = 1
    options = true
    iniciar = false
    soundtrack.click:play()
  --PEDIDOS OFFLINE--
  elseif button == 1 and x > 50 and x < 240 and y > 300 and y < 330 and options == true then
    options = false
    iniciar = false
    pedidos_online = false
    start = true
    soundtrack.start:play()
    --PEDIDOS ONLINE--
  elseif button == 1 and x > 50 and x < 240 and y > 200 and y < 230 and options == true then
    iniciar = false
    options = false
    pedidos_online = true
    start = true
    randomiza_andar = true
    soundtrack.start:play()
  --TUTORIAL--
  elseif button == 1 and x > 50 and x < 135 and y > 270 and y < 290 and iniciar == true then
    menu.alpha_tutorial = 1
    tutorial = true
    iniciar = false
    soundtrack.click:play()
    --CREDITOS--
  elseif button == 1 and x > 120 and x < 260 and y > 500 and y < 530 and iniciar == true then
    creditos = true
    iniciar = false
    soundtrack.click:play()
  --TUTORIAL/PROXIMO--
  elseif button == 1 and x > 690 and x < 750 and y > 480 and y < 550 and tutorial == true then
    tutorial = false
    tutorial2 = true
    soundtrack.click:play()
  --TUTORIAL/ANTERIOR--
  elseif button == 1 and x > 690 and x < 750 and y > 480 and y < 550 and tutorial2 == true then
    tutorial2 = false
    tutorial = true
    soundtrack.click:play()
  --TUTORIAL/VOLTAR--
  elseif button == 1 and x > 350 and x < 470 and y > 500 and y < 520 and iniciar == false and tutorial == true then
    soundtrack.click:play()
    tutorial = false
    iniciar = true
  --TUTORIAL2/VOLTAR--
  elseif button == 1 and x > 350 and x < 470 and y > 500 and y < 520 and iniciar == false and tutorial2 == true then
    soundtrack.click:play()
    tutorial2 = false
    iniciar = true
  --START/VOLTAR--
  elseif button == 1 and x > 120 and x < 230 and y > 500 and y < 520 and iniciar == false and options == true then
    soundtrack.click:play()
    options = false
    iniciar = true
  --PAUSE//VOLTAR--
  elseif button == 1 and x > 350 and x < 450 and y > 200 and y < 220 and pause == true then
    pause = false
    soundtrack.click:play()
  --CREDITOS//VOLTAR
  elseif button == 1 and x > 120 and x < 260 and y > 500 and y < 530 and creditos == true then
    creditos = false
    iniciar = true
    soundtrack.click:play()
  --CONFIG//APARENCIA
  elseif button == 1 and x > 550 and x < 650 and y > 200 and y < 220 and config == true then
    config = false
    aparencia = true
    soundtrack.click:play()
  --CONFIG//APARENCIA//VOLTAR
  elseif button == 1 and x > 350 and x < 450 and y > 500 and y < 520 and aparencia == true then
    aparencia = false
    config = true
    soundtrack.click:play()
  --CONFIG//VOLTAR
  elseif button == 1 and x > 350 and x < 450 and y > 500 and y < 520 and config == true then
    config = false
    pause = true
    soundtrack.click:play()
  --PAUSE//CONFIG--
  elseif button == 1 and x > 350 and x < 450 and y > 300 and y < 320 and pause == true then
    pause = false
    config = true
    soundtrack.click:play()
  --PAUSE//VOLUME +
  elseif button == 1 and x > 180 and x < 220 and y > 250 and y < 285 and config == true and cenario.volume_musica < 10 then
    cenario.volume_musica = cenario.volume_musica + 1
  --PAUSE//VOLUME -
  elseif button == 1 and x > 180 and x < 220 and y > 285 and y < 320 and config == true and cenario.volume_musica > 0 then
    cenario.volume_musica = cenario.volume_musica - 1
  --PAUSE//BRILHO +
  elseif button == 1 and x > 380 and x < 420 and y > 250 and y < 285 and config == true and menu.brilho > 0 then
    menu.brilho = menu.brilho - 1
  --PAUSE//BRILHO -
  elseif button == 1 and x > 380 and x < 420 and y > 285 and y < 320 and config == true and menu.brilho < 5 then
    menu.brilho = menu.brilho + 1
  --SAIR--
  elseif button == 1 and x > 50 and x < 95 and y > 340 and y < 360 and iniciar == true then
    love.event.quit()
  --PAUSE//SAIR--
  elseif button == 1 and x > 350 and x < 430 and y > 400 and y < 420 and pause == true then
    love.event.quit()
  --PAUSE//MENU PRINCIPAL--
  elseif button == 1 and x > 300 and x < 500 and y > 100 and y < 120 and pause == true then
    iniciar = true
    pause = false
    movimento = false
    start = false
    cronometro.start = false
    cronometro.stop = false
    elevador.y = 480
    elevador.vel = 0
    fisica.energia = 0
    elevador.pedidos = {}
    manutencao.duracao_elevador = 100
    manutencao.duracao_polia = 100
    manutencao.duracao_motor = 100
    manutencao.vidroalpha = 0
    cronometro.armazena_tempos = {}
    cronometro.inicia_cronometro = {}
    cronometro.para_cronometro = {}
    cronometro.stop = {}
    cronometro.start = {}
    cronometro.tempoMaior = 0
    cronometro.peso_total = 0
    soundtrack.musica:stop()
  --TROCA DE CABINA--
  elseif button == 1 and x > 100 and x < 200 and y > 100 and y < 200 and aparencia == true then
    elevador.escolha = 1
  elseif button == 1 and x > 350 and x < 450 and y > 100 and y < 200 and aparencia == true then
    elevador.escolha = 2
  elseif button == 1 and x > 600 and x < 700 and y > 100 and y < 200 and aparencia == true then
    elevador.escolha = 3
  --TROCA DE ANDAR--
  elseif button == 1 and x > 400 and x < 650 and y > 300 and y < 415 and aparencia == true then
    cenario.escolha = 2
  elseif button == 1 and x > 100 and x < 350 and y > 300 and y < 415 and aparencia == true then
    cenario.escolha = 1
  end

end

function gera_destino(origem)
  local destino_atual = math.random(0,10)
  while destino_atual == origem do
    destino_atual = math.random(0,10)
  end
  
  table.insert(cronometro.para_cronometro, destino_atual)
  return destino_atual
end

function andar_nao_esta_na_lista(pedidos, andar)
  for i=1, #pedidos do
    if andar == pedidos[i] then
      return false
    end
  end
  
  return true
end

function ordena_pedidos(origem)
  destino_atual = gera_destino(origem)
  
  if #elevador.pedidos > 1 then
    local subida, descida, complementar = separa_pedidos()
    
    if (elevador.andaratual < elevador.pedidos[1]) or (#elevador.pedidos >= 2 and elevador.andaratual == elevador.pedidos[1] and elevador.andaratual < elevador.pedidos[2]) then      
      if origem < destino_atual then        
        if elevador.andaratual < origem then          
          subida = reordena_pedidos(subida, origem, true)
          subida = reordena_pedidos(subida, destino_atual, true)
        else          
          complementar = reordena_pedidos(complementar, origem, true)
          complementar = reordena_pedidos(complementar, destino_atual, true)
        end
      else        
        descida = reordena_pedidos(descida, origem, false)
        descida = reordena_pedidos(descida, destino_atual, false)
      end
      
      unifica_pedidos(subida, descida, complementar)
    elseif (elevador.andaratual > elevador.pedidos[1]) or (#elevador.pedidos >= 2 and elevador.andaratual == elevador.pedidos[1] and elevador.andaratual > elevador.pedidos[2]) then
      
      if origem < destino_atual then        
        subida = reordena_pedidos(subida, origem, true)
        subida = reordena_pedidos(subida, destino_atual, true)
      else        
        if elevador.andaratual > origem then          
          descida = reordena_pedidos(descida, origem, false)
          descida = reordena_pedidos(descida, destino_atual, false)
        else          
          complementar = reordena_pedidos(complementar, origem, false)
          complementar = reordena_pedidos(complementar, destino_atual, false)
        end
      end
      
      unifica_pedidos(descida, subida, complementar)
    end
    
  else    
    table.insert(elevador.pedidos, origem)
    table.insert(elevador.pedidos, destino_atual)
  end
end

function unifica_pedidos(primeira, segunda, complementares)
  elevador.pedidos = {}
  for i=1, #primeira do
    table.insert(elevador.pedidos, primeira[i])
  end
  
  for i=1, #segunda do
    table.insert(elevador.pedidos, segunda[i])
  end
  
  for i=1, #complementares do
    table.insert(elevador.pedidos, complementares[i])
  end
  
  --Remover copias
  for i = #elevador.pedidos, 2, -1 do
    if elevador.pedidos[i] == elevador.pedidos[i-1] then
      table.remove(elevador.pedidos, i)
    end
  end
end


function reordena_pedidos(pedidos, andar, subindo)
  
  if andar_nao_esta_na_lista(pedidos, andar) then
    local novos_pedidos = {}
    local ja_inseriu = false
    local condicao
    
    for i=1, #pedidos do
      if subindo then
        condicao = pedidos[i] > andar
      else
        condicao = pedidos[i] < andar
      end
      
      if condicao and not ja_inseriu then
        table.insert(novos_pedidos, andar)
        ja_inseriu = true
      end
      
      table.insert(novos_pedidos, pedidos[i])
    end
    
    if not ja_inseriu then
      table.insert(novos_pedidos, andar)
    end
    
    return novos_pedidos
  end
  
  return pedidos
end



function separa_pedidos()
  local subida = {}
  local descida = {}
  local complementar = {}
  local comeca_subindo = false
  local preencheu_subida = false
  local preencheu_descida = false
  local ultimo_preenchido
  
  if #elevador.pedidos <= 1 then
    table.insert(subida, elevador.pedidos[1])
  else  
    if elevador.pedidos[1] < elevador.pedidos[2] then
      table.insert(subida, elevador.pedidos[1])
      ultimo_preenchido = "s"
      comeca_subindo = true
    else
      table.insert(descida, elevador.pedidos[1])
      ultimo_preenchido = "d"
      comeca_subindo = false
    end
  end
  
  for i=2, #elevador.pedidos - 1 do
    if elevador.pedidos[i] < elevador.pedidos[i+1] then
      if not comeca_subindo then
        preencheu_subida = true
      end
      
      if preencheu_descida then
        table.insert(complementar, elevador.pedidos[i])
        ultimo_preenchido = "c"
      else
        table.insert(subida, elevador.pedidos[i])
        ultimo_preenchido = "s"
      end
    else
      if comeca_subindo then
        preencheu_descida = true
      end
      
      if preencheu_subida then
        table.insert(complementar, elevador.pedidos[i])
        ultimo_preenchido = "c"
      else
        table.insert(descida, elevador.pedidos[i])
        ultimo_preenchido = "d"
      end
    end
  end
  
  if #elevador.pedidos >= 2 then
    local ultimo = elevador.pedidos[#elevador.pedidos]
    if ultimo_preenchido == "c" then
      table.insert(complementar, ultimo)
    elseif ultimo_preenchido == "d" then
      table.insert(descida, ultimo)
    else
      table.insert(subida, ultimo)
    end
  end

  return subida, descida, complementar
end




function love.keypressed(k)
  if k == 'escape' and start == true and pause == false and config == false and aparencia == false then
    pause = true
  elseif k == 'escape' and start == true and pause == true then
    pause = false
  elseif k == 'escape' and start == true and pause == false and config == true then
    config = false
  elseif pedidos_online == true and k >= '0' and k <='9' then
    ordena_pedidos(tonumber(k))
    table.insert(cronometro.inicia_cronometro, tonumber(k))
    table.insert(cronometro.start, false)
    table.insert(cronometro.stop, false)
    table.insert(cronometro.armazena_tempos, 0)
    table.insert(cronometro.pesos, math.random(400,1200))
  elseif pedidos_online == true and k == 'c' then
    ordena_pedidos(10)
    table.insert(cronometro.inicia_cronometro, 10)
    table.insert(cronometro.start, false)
    table.insert(cronometro.stop, false)
    table.insert(cronometro.armazena_tempos, 0)
    table.insert(cronometro.pesos, math.random(400,1200))
  elseif k == 'space' and status == false and start == true then
    status = true
  elseif k == 'space' and status == true and start == true then
    status = false
  elseif k == 'a' and defeito == false and start == true then  --Manutencao preditiva
    conserto = true
  elseif k == 'd' and diagrama == false then
    diagrama = true
  elseif k == 'd' and diagrama == true then
    diagrama = false
  elseif k == 'l' then
    manutencao.duracao_polia = 2
  elseif k == 'g' then
    abre = true
    fecha = false
  end
end

return evento