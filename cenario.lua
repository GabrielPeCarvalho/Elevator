cenario = {}

function cenario:load()
  cenario.fonte = love.graphics.newFont('AUGUSTUS.ttf',12)
  cenario.andares = 11
  cenario.teto = 600-(30+(230*cenario.andares))
  cenario.alpha = 1
  cenario.escolha = 1
  cenario.janela= love.graphics.newImage('imagens/janela.png')
  cenario.andar= love.graphics.newImage('imagens/andar.png')
  cenario.andar2= love.graphics.newImage('imagens/andar2.png')
  cenario.contrapeso= love.graphics.newImage('imagens/contrapeso.png')
  cenario.polia= love.graphics.newImage('imagens/polia.png')
  cenario.motor= love.graphics.newImage('imagens/motor.png')
  cenario.casa_de_maquinas= love.graphics.newImage('imagens/CDM.png')
  cenario.vidro= love.graphics.newImage('imagens/vidro.png')
  cenario.ceu= love.graphics.newImage('imagens/ceu.png')
  cenario.frameplanta= 1
  cenario.framefundo= 1
  cenario.frameestrela= 1
  cenario.rotacao= 0
  cenario.volume_musica= 0

  cenario.animacaoplanta = {}
  for i = 1, 60 do
    cenario.animacaoplanta[i] = love.graphics.newImage('anim/plant/plant ('..math.ceil(i/5)..').png')
  end
  cenario.animacaofundo = {}
  for i = 1, 40 do
    cenario.animacaofundo[i] = love.graphics.newImage('anim/fundo/fundo ('..math.ceil(i/5)..').png')
  end
  cenario.animacaoestrela = {}
  for i = 1, 350 do
    cenario.animacaoestrela[i] = love.graphics.newImage('anim/estrela/estrela ('..math.ceil(i/5)..').png')
  end
end

function cenario:update(dt)
  
  --Rotacao da polia
  if elevador.vel > 0 and pause == false and config == false and aparencia == false then
    cenario.rotacao = cenario.rotacao - 0.1
  elseif elevador.vel < 0 and pause == false and config == false and aparencia == false then
    cenario.rotacao = cenario.rotacao + 0.1
  end
  
  --Animacao do fundo, da planta e da estrela 
  cenario.framefundo = cenario.framefundo+1
  if cenario.framefundo >= 40 then
    cenario.framefundo = 1
  end
  
  cenario.frameestrela = cenario.frameestrela+1
  if cenario.frameestrela >= 350 then
    cenario.frameestrela = 1
  end
  
  cenario.frameplanta = cenario.frameplanta+1
  if cenario.frameplanta >= 60 then
    cenario.frameplanta = 1
  end
end

--Funcao que cria andares
function cria_andar(n)
  love.graphics.setColor(1,1,1)
  love.graphics.draw(cenario.ceu,0,0-(230*n))
  love.graphics.draw(cenario.ceu,400,0-(230*n))
  if cenario.escolha == 1 then
    love.graphics.draw(cenario.andar,145,570-(230*n))
  else
    love.graphics.draw(cenario.andar2,145,570-(230*n))
  end
  love.graphics.draw(cenario.casa_de_maquinas,145,cenario.teto-120)
  love.graphics.draw(cenario.contrapeso,345,-elevador.y-1460) --Contrapeso
  cria_retangulo(145,cenario.teto-20,500,20,0,0,0)
  cria_retangulo(460,520-(230*(n-1)),75,25,0.43,0.18,0) --Placa
  love.graphics.setColor(1,1,1)
  love.graphics.draw(cenario.motor,380,cenario.teto-43,0,1.6,1.6,cenario.motor:getWidth()/2,cenario.motor:getHeight()/2)
  love.graphics.draw(cenario.polia,380,cenario.teto-43,cenario.rotacao,1.6,1.6,cenario.polia:getWidth()/2,cenario.polia:getHeight()/2)
  love.graphics.draw(cenario.janela,175,395-(230*(n-1)))
  love.graphics.draw(cenario.janela,515,395-(230*(n-1)))
end
function cria_texto(n)
  if n== cenario.andares then
    n=n-1
  end
  love.graphics.setColor(1,1,1)
  love.graphics.print(n..'º Andar',cenario.fonte,463,297.5-(230*(n-1)))
  love.graphics.setColor(1,1,1)
  love.graphics.print('Térreo',cenario.fonte,470,527.5)
end

function cenario:draw()

  --Camera
  if elevador.y<=300 then
    love.graphics.translate(0,-elevador.y+300)
  end
  
  --Fundo
  love.graphics.setColor(1,1,1)
  love.graphics.draw(cenario.animacaofundo[cenario.framefundo],0,-30)
  
  --Loops
  for n=1,cenario.andares do
    cria_andar(n)
  end
  for n=1,cenario.andares do
    cria_texto(n)
  end
  
  --Ambiente
  cria_retangulo(0,570,800,30,0.5,0.5,0.5) --Chao
  
  --Planta
  love.graphics.setColor(1,1,1)
  love.graphics.draw(cenario.animacaoplanta[cenario.frameplanta],675,467.5,0,0.5,0.5)
  
  --Estrela
  love.graphics.draw(cenario.animacaoestrela[cenario.frameestrela],0,0,0,0.5,0.5)
  love.graphics.draw(cenario.animacaoestrela[cenario.frameestrela],600,-800,0,0.5,0.5)
  love.graphics.draw(cenario.animacaoestrela[cenario.frameestrela],580,-1500,0,0.5,0.5)
  love.graphics.draw(cenario.animacaoestrela[cenario.frameestrela],10,cenario.teto - 100,0,0.5,0.5)
  
  love.graphics.push()
  if elevador.y>=300 then
    love.graphics.translate(0,-elevador.y+300)
  end
  --Informacoes
  love.graphics.setColor(54/255,51/255,143/255)
  love.graphics.rectangle('fill',5,elevador.y-295,135,150)
  love.graphics.setColor(1,1,1)
  love.graphics.print('T: '..tostring(math.floor(elevador.tempo))..' Sec.',cenario.fonte,10,elevador.y-290)
  love.graphics.print('Lista de pedidos:',cenario.fonte,10,elevador.y-265)
  love.graphics.print(tostring(math.ceil(manutencao.timer_manutencao_prev))..' segundos \nate a proxima \nmanutencao',cenario.fonte,10,elevador.y-225)
  love.graphics.print(fisica.energia..' \nReais gastos',cenario.fonte,10,elevador.y-175)
  for i=1, #elevador.pedidos do
    love.graphics.print(elevador.pedidos[i],cenario.fonte,15*(i-1)+10,elevador.y-250)
  end
  love.graphics.setColor(0,1,0)
  love.graphics.print('Peso total: '..cronometro.peso_total..('N'),cenario.fonte,650,elevador.y-290)
  if alerta == true then
    love.graphics.setColor(1,0,0)
    love.graphics.print('ALERTA! A massa da \ncarga excede \n160 quilos!',cenario.fonte,650,elevador.y-270)
  end
  
  love.graphics.pop()
  


end

return cenario