manutencao = {}

function manutencao:load()
  
  status = false
  conserto = false
  conserto_queda = false
  defeito = false
  queda = false
  explosao1 = false
  explosao2 = false
  alerta = false
  desgaste = false
  manutencao.frame_explosao1 = 1
  manutencao.frame_explosao2 = 1
  manutencao.duracao_elevador= 100
  manutencao.duracao_polia= 100
  manutencao.duracao_motor= 100
  manutencao.timer_manutencao_prev= 50
  manutencao.timer_manutencao_cor= 0
  manutencao.timer_queda = 0
  manutencao.vidroalpha= 0
  manutencao.random1 = math.random(5,12)
  manutencao.random2 = math.random(5,12)
  manutencao.random3 = math.random(5,12)
  
  manutencao.explosao1 = {}
  for i = 1, 95 do
    manutencao.explosao1[i] = love.graphics.newImage('anim/explosao1/explosao1 ('..math.ceil(i/5)..').png')
  end
  manutencao.explosao2 = {}
  for i = 1, 130 do
    manutencao.explosao2[i] = love.graphics.newImage('anim/explosao2/explosao2 ('..math.ceil(i/5)..').png')
  end

end

function manutencao:update(dt)
  --Diminuicao da duracao de cada componente
  if elevador.vel ~= 0 then 
    if manutencao.duracao_elevador >= 0 and pause == false and config == false and aparencia == false then
      manutencao.duracao_elevador = manutencao.duracao_elevador - manutencao.random1 / 100
    end
    if manutencao.duracao_polia >= 0 and pause == false and config == false and aparencia == false then
      manutencao.duracao_polia = manutencao.duracao_polia - manutencao.random2 / 100
    end
    if manutencao.duracao_motor >= 0 and pause == false and config == false and aparencia == false then
      manutencao.duracao_motor = manutencao.duracao_motor - manutencao.random3 / 100
    end
  end
  
  --Defeito de cada componente
  if manutencao.duracao_motor < 1 and manutencao.duracao_motor > 0.8 then
    soundtrack.motor_quebrado:play()
    manutencao.random1 = math.random(5,12)
    defeito = true
  end
  if manutencao.duracao_elevador < 1 and manutencao.duracao_elevador > 0.8 then
    soundtrack.elevador_quebrado:play()
    manutencao.random2 = math.random(5,12)
    manutencao.vidroalpha= 1
    defeito = true
  end
  if manutencao.duracao_polia < 1 and manutencao.duracao_polia > 0.8 then
    soundtrack.polia_quebrada:play()
    manutencao.random3 = math.random(5,12)
    queda = true
  end
  if elevador.tempo > 0 and defeito == false and start == true and pause == false and config == false and aparencia == false and queda == false then
    manutencao.timer_manutencao_prev = manutencao.timer_manutencao_prev - dt
  end
  
  if cronometro.peso_total > 1600 then
    alerta = true
    desgaste = true
  else
    alerta = false
    desgaste = false
  end
  if desgaste == true then
    manutencao.random1 = math.random(14,18)
    manutencao.random2 = math.random(14,18)
    manutencao.random3 = math.random(14,18)
    desgaste = false
  end
  
  --Queda do elevador
  if queda == true and pause == false and config == false and aparencia == false then
    movimento = false
    elevador.ac = -10
    elevador.vel = elevador.vel + elevador.ac
    fisica.forca_motriz = 0
    if elevador.y == 479 then
      elevador.ac = 0
      elevador.vel = 0
      cenario.vidro_alpha = 1
      manutencao.timer_queda = manutencao.timer_queda + dt
      if elevador.andaratual <= 3 then
        soundtrack.batida:setVolume(0.3)
        play_once(soundtrack.batida)
        manutencao.vidroalpha = 1
      elseif elevador.andaratual > 3 and elevador.andaratual <= 7 then
        soundtrack.explosao1:setVolume(0.2)
        play_once(soundtrack.explosao1)
        manutencao.vidroalpha = 1
        explosao1 = true
      elseif elevador.andaratual > 7 then 
        soundtrack.explosao2:setVolume(0.5)
        play_once(soundtrack.explosao2)
        manutencao.vidroalpha = 1
        explosao2 = true
      end
    end
  end
  
  --Manutencao Preventiva
  if manutencao.timer_manutencao_prev < 0 then
    conserto = true
    manutencao.timer_manutencao_prev = 50
  end
  
  --Defeito do elevador
  if defeito == true and pause == false and config == false and aparencia == false then
    movimento = false
    manutencao.timer_manutencao_cor = manutencao.timer_manutencao_cor + dt
    if elevador.vel > 0 then
      elevador.ac = -10
      elevador.vel = elevador.vel + elevador.ac
      if elevador.vel <= 0 then
        elevador.vel = 0
      end
    elseif elevador.vel < 0 then
      elevador.ac = 10
      elevador.vel = elevador.vel + elevador.ac
      if elevador.vel >= 0 then
        elevador.vel = 0
      end
    end
  end
  
  --Manutencao Corretiva
  if manutencao.timer_manutencao_cor > 5 then
    conserto = true
    manutencao.timer_manutencao_cor = 0
  end

  --Manutencao
  if conserto == true then
    soundtrack.manutencao:setVolume(0.2)
    soundtrack.manutencao:play()
    manutencao.duracao_elevador = 100
    manutencao.duracao_polia = 100
    manutencao.duracao_motor = 100
    manutencao.vidroalpha = 0
    manutencao.timer_manutencao_cor = 0
    movimento = true
    defeito = false
    conserto = false
    manutencao.random1 = math.random(5,12)
    manutencao.random2 = math.random(5,12)
    manutencao.random3 = math.random(5,12)
  end
  
  --Manutencao pós queda
  if manutencao.timer_queda > 5 then
    conserto_queda = true
  end
  if conserto_queda == true then
    elevador.pedidos = {}
    soundtrack.manutencao:setVolume(0.2)
    soundtrack.manutencao:play()
    manutencao.vidroalpha = 0
    manutencao.duracao_elevador = 100
    manutencao.duracao_polia = 100
    manutencao.duracao_motor = 100
    manutencao.timer_queda = 0
    manutencao.frame_explosao1 = 1
    manutencao.frame_explosao2 = 1
    manutencao.random1 = math.random(5,12)
    manutencao.random2 = math.random(5,12)
    manutencao.random3 = math.random(5,12)
    queda = false
    defeito = false
    conserto_queda = false
    explosao1 = false
    explosao2 = false
    play = true
  end
  
  --Animacao das explosoes
  if explosao1 == true and pause == false and config == false and aparencia == false and manutencao.frame_explosao1 < 95 then
    manutencao.frame_explosao1 = manutencao.frame_explosao1 + 1
  end
  if explosao2 == true and pause == false and config == false and aparencia == false and manutencao.frame_explosao2 < 130 then
    manutencao.frame_explosao2 = manutencao.frame_explosao2 + 1
  end
  
end

function manutencao:draw()
  
  love.graphics.push()
  
  if elevador.y>=300 then
    love.graphics.translate(0,-elevador.y+300)
  end
  
  --Status dos componentes
  if status == true and pause == false and config == false and aparencia == false then
    love.graphics.setColor(1,1,1)
    love.graphics.print('Elevador: '..math.ceil(manutencao.duracao_elevador),cenario.fonte,10,elevador.y-120)
    love.graphics.print('Polia: '..math.ceil(manutencao.duracao_polia),cenario.fonte,10,elevador.y-75)
    love.graphics.print('Motor: '..math.ceil(manutencao.duracao_motor),cenario.fonte,10,elevador.y-35)
    love.graphics.rectangle('line',10,elevador.y-101,100,22)
    love.graphics.rectangle('line',10,elevador.y-61,100,22)
    love.graphics.rectangle('line',10,elevador.y-21,100,22)
    cria_retangulo(10,elevador.y-100,manutencao.duracao_elevador,20,0,1,0)
    cria_retangulo(10,elevador.y-60,manutencao.duracao_polia,20,0,1,0)
    cria_retangulo(10,elevador.y-20,manutencao.duracao_motor,20,0,1,0)
  end
  love.graphics.pop()
  
  if explosao1 == true then
    love.graphics.setColor(1,1,1)
    love.graphics.draw(manutencao.explosao1[manutencao.frame_explosao1],310,450)
  end
  if explosao2 == true then
    love.graphics.setColor(1,1,1)
    love.graphics.draw(manutencao.explosao2[manutencao.frame_explosao2],150,200,0,0.5,0.5)
  end
  
end

return manutencao