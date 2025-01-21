menu = {}

function menu:load()
  menu.img = love.graphics.newImage('imagens/tutorial.png')
  menu.seta = love.graphics.newImage('imagens/seta.png')
  menu.volume = love.graphics.newImage('imagens/volume.png')
  iniciar = true
  options = false
  tutorial = false
  tutorial2 = false
  online = false
  pause = false
  config = false
  aparencia = false
  creditos = false
  --Transparencia de cada menu
  menu.alpha = 1
  menu.alpha_tutorial = 0
  menu.alpha_options = 0
  menu.alpha_online = 0
  menu.brilho= 0
end


function menu:update(dt)
  --Cor dos botoes
  --START--
  if love.mouse.getX() > 50 and love.mouse.getX() < 135 and love.mouse.getY() > 200 and love.mouse.getY() < 220 then
    menu.r1= 1
  else 
    menu.r1= 0
  end
  --TUTORIAL--
  if love.mouse.getX() > 50 and love.mouse.getX() < 150 and love.mouse.getY() > 270 and love.mouse.getY() < 290 then
    menu.r2= 1
  else 
    menu.r2= 0
  end
  --SAIR--
  if love.mouse.getX() > 50 and love.mouse.getX() < 95 and love.mouse.getY() > 340 and love.mouse.getY() < 360 then
    menu.r3= 1
  else 
    menu.r3= 0
  end
  --CREDITOS--
  if love.mouse.getX() > 120 and love.mouse.getX() < 260 and love.mouse.getY() > 500 and love.mouse.getY() < 530 then
    menu.r4= 1
  else 
    menu.r4= 0
  end
  --TUTORIAL/VOLTAR--
  if love.mouse.getX() > 350 and love.mouse.getX() < 470 and love.mouse.getY() > 500 and love.mouse.getY() < 520  and tutorial == true then
    menu.c4= 0
  else 
    menu.c4= 1
  end
  --PEDIDOS ONLINE--
  if love.mouse.getX() > 50 and love.mouse.getX() < 240 and love.mouse.getY() > 200 and love.mouse.getY() < 230  and options == true then
    menu.c5= 0
  else 
    menu.c5= 1
  end
  --PEDIDOS OFFLINE--
  if love.mouse.getX() > 50 and love.mouse.getX() < 240 and love.mouse.getY() > 300 and love.mouse.getY() < 330  and options == true then
    menu.c6= 0
  else 
    menu.c6= 1
  end
  --START/VOLTAR--
  if love.mouse.getX() > 120 and love.mouse.getX() < 230 and love.mouse.getY() > 500 and love.mouse.getY() < 520  and options == true then
    menu.c7= 0
  else 
    menu.c7= 1
  end
  --TUTORIAL2/VOLTAR
  if love.mouse.getX() > 350 and love.mouse.getX() < 470 and love.mouse.getY() > 500 and love.mouse.getY() < 520  and tutorial2 == true then
    menu.c8= 0
  else 
    menu.c8= 1
  end
  --PAUSE/VOLTAR
  if love.mouse.getX() > 350 and love.mouse.getX() < 450 and love.mouse.getY() > 200 and love.mouse.getY() < 220  and pause == true then
    menu.c9= 0
  else 
    menu.c9= 1
  end
  --PAUSE/CONFIG
  if love.mouse.getX() > 350 and love.mouse.getX() < 450 and love.mouse.getY() > 300 and love.mouse.getY() < 320  and pause == true then
    menu.c10= 0
  else 
    menu.c10= 1
  end
  --PAUSE/SAIR
  if love.mouse.getX() > 350 and love.mouse.getX() < 430 and love.mouse.getY() > 400 and love.mouse.getY() < 420  and pause == true then
    menu.c11= 0
  else 
    menu.c11= 1
  end
  --CREDITOS/VOLTAR
  if love.mouse.getX() > 120 and love.mouse.getX() < 230 and love.mouse.getY() > 500 and love.mouse.getY() < 530  and creditos == true then
    menu.c12= 1
  else
    menu.c12= 0
  end
  --PAUSE/APARENCIA
  if love.mouse.getX() > 550 and love.mouse.getX() < 650 and love.mouse.getY() > 200 and love.mouse.getY() < 220  and config == true then
    menu.c13= 0
  else
    menu.c13= 1
  end
  --PAUSE/APARENCIA/VOLTAR
  if love.mouse.getX() > 350 and love.mouse.getX() < 450 and love.mouse.getY() > 500 and love.mouse.getY() < 530  and aparencia == true then
    menu.c14= 0
  else
    menu.c14= 1
  end
  --PAUSE/MENU PRINCIPAL
  if love.mouse.getX() > 300 and love.mouse.getX() < 500 and love.mouse.getY() > 100 and love.mouse.getY() < 120  and pause == true then
    menu.c15= 0
  else
    menu.c15= 1
  end
  --CONFIG/VOLTAR
  if love.mouse.getX() > 350 and love.mouse.getX() < 450 and love.mouse.getY() > 500 and love.mouse.getY() < 530  and config == true then
    menu.c16= 0
  else
    menu.c16= 1
  end
end

function menu:draw()
  
  --Texto do menu principal
  if iniciar == true then
    love.graphics.setColor(0,0.6,1,0.5)
    love.graphics.rectangle('fill',400,0,400,600)
    love.graphics.setColor(0,0.6,1,menu.alpha)
    love.graphics.rectangle('fill',0,0,400,600)
    love.graphics.setColor(1,0,0,menu.alpha)
    love.graphics.print('ELEVADOR \nSIMULATOR',cenario.fonte,100,50,0,2)
    love.graphics.print('By Grupo 2',cenario.fonte,130,120)
    love.graphics.setColor(menu.r1,0,0,menu.alpha)
    love.graphics.print('INICIAR',cenario.fonte,50,200,0,1.5)
    love.graphics.setColor(menu.r2,0,0,menu.alpha)
    love.graphics.print('TUTORIAL',cenario.fonte,50,270,0,1.5)
    love.graphics.setColor(menu.r3,0,0,menu.alpha)
    love.graphics.print('SAIR',cenario.fonte,50,340,0,1.5)
    love.graphics.setColor(menu.r4,0,0,menu.alpha)
    love.graphics.print('CREDITOS',cenario.fonte,120,500,0,2)
  end
  
  --Creditos
  if creditos == true then
    love.graphics.setColor(0,0.6,1,0.5)
    love.graphics.rectangle('fill',400,0,400,600)
    love.graphics.setColor(0,0.6,1)
    love.graphics.rectangle('fill',0,0,400,600)
    love.graphics.setColor(0,0,0)
    love.graphics.print('GRUPO 2:', cenario.fonte,50,50,0,2)
    love.graphics.print('-Rafael Bastos', cenario.fonte,50,90,0,1.2)
    love.graphics.print('-Gabriel Pereira', cenario.fonte,50,120,0,1.2)
    love.graphics.print('-Carla Martins', cenario.fonte,50,150,0,1.2)
    love.graphics.print('-Enrico Vergolino', cenario.fonte,50,180,0,1.15)
    love.graphics.print('-Mariana', cenario.fonte,50,210,0,1.2)
    love.graphics.print('-PROFESSOR:', cenario.fonte,50,270,0,1.2)
    love.graphics.print('-Luis Bicalho', cenario.fonte,50,300,0,1.2)
    love.graphics.print('-Monitores:', cenario.fonte,50,360,0,1.2)
    love.graphics.print('-Marcello Nascif', cenario.fonte,50,390,0,1.2)
    love.graphics.print('-Leonardo Trote', cenario.fonte,50,420,0,1.2)
    love.graphics.setColor(menu.c12,0,0)
    love.graphics.print('VOLTAR', cenario.fonte,120,500,0,2)
  end
  --Tutorial
  if tutorial == true then
    love.graphics.setColor(1,1,1,menu.alpha_tutorial)
    love.graphics.draw(menu.img,0,0,0,2)
    love.graphics.setColor(1,menu.c4,menu.c4,menu.alpha_tutorial)
    love.graphics.print('-- VOLTAR --',cenario.fonte,350,500,0,1.5)
    love.graphics.setColor(1,1,1,menu.alpha_tutorial)
    love.graphics.draw(menu.seta,700,500)
    love.graphics.print('Proximo',cenario.fonte,690,480)
    love.graphics.print('1- Clique no botao \'Iniciar\' no menu para \nescolher o modo da simulaçao.',cenario.fonte,10,60,0,1.5)
    love.graphics.print('2- Na opçao \'Pedidos offline\', os pedidos \npré determinados serao lidos.',cenario.fonte,10,140,0,1.5)
    love.graphics.print('3- Na opçao \'Pedidos online\', pressione teclas \npara levar o elevador ao destino desejado. \nAs teclas de \'1\' a \'9\' levam o elevador ao \nandar correspondente ao numero, a tecla \'0\' \nleva o elevador ao terreo e a tecla \'c\' \nleva o elevador a cobertura. O elevador\ncomecara no terreo.',cenario.fonte,10,220,0,1.5)
    love.graphics.print('4- Pressione a tecla \'Esc\' para acessar o \nmenu de pause.',cenario.fonte,10,400,0,1.5)
  end
  if tutorial2 == true then
    love.graphics.setColor(1,1,1,menu.alpha_tutorial)
    love.graphics.draw(menu.img,0,0,0,2)
    love.graphics.setColor(1,menu.c8,menu.c8,menu.alpha_tutorial)
    love.graphics.print('-- VOLTAR --',cenario.fonte,350,500,0,1.5)
    love.graphics.setColor(1,1,1,menu.alpha_tutorial)
    love.graphics.draw(menu.seta,750,530,math.pi)
    love.graphics.print('Anterior',cenario.fonte,690,480)
    love.graphics.print('5- O status dos componentes do elevador pode \nser visualizado ao apertar a barra de espaco',cenario.fonte,10,60,0,1.5)
    love.graphics.print('6- A manutencao preventiva do elevador e \nrealizada periodicamente enquanto o elevador \nfunciona, a cada 50 segundos.',cenario.fonte,10,120,0,1.5)
    love.graphics.print('7- A manutencao preditiva do elevador pode \nser realizada enquanto o elevador funciona, \nao apertar a tecla \'a\'.',cenario.fonte,10,200,0,1.5)
    love.graphics.print('8- A manutencao corretiva do elevador ocorre \n5 segundos apos algum componente quebrar.',cenario.fonte,10,280,0,1.5)
    love.graphics.print('9- Pressione a tecla \'D\' para revelar o diagrama \n de forcas.',cenario.fonte,10,340,0,1.5)
    love.graphics.print('10- Pressione a tecla \'L\' para quebrar o cabo do \nelevador e visualizar as quedas.',cenario.fonte,10,390,0,1.5)
    love.graphics.print('11- Quando a carga atinge um valor superior a 1600N, \n os componentes desgastarao mais rapidamente.',cenario.fonte,10,440,0,1.5)
  end
  --Opcoes dos pedidos
  if options == true then
    love.graphics.setColor(0,0.6,1,0.5)
    love.graphics.rectangle('fill',400,0,400,600)
    love.graphics.setColor(0,0.6,1)
    love.graphics.rectangle('fill',0,0,400,600)
    love.graphics.setColor(1,menu.c5,menu.c5,menu.alpha_options)
    love.graphics.print('--PEDIDOS ONLINE--',cenario.fonte,50,200,0,1.5)
    love.graphics.setColor(1,menu.c6,menu.c6,menu.alpha_options)
    love.graphics.print('--PEDIDOS OFFLINE--',cenario.fonte,50,300,0,1.5)
    love.graphics.setColor(1,menu.c7,menu.c7,menu.alpha_options)
    love.graphics.print('--VOLTAR--',cenario.fonte,120,500,0,1.5)
  end
  
  --Menu de pause
  love.graphics.push()
  if elevador.y>=300 then
    love.graphics.translate(0,-elevador.y+300)
  end
  
  if pause == true then
    love.graphics.setColor(0,0,0,0.7)
    love.graphics.rectangle('fill',0,elevador.y-300,800,600)
    love.graphics.setColor(1,menu.c9,menu.c9)
    love.graphics.print('--VOLTAR--',cenario.fonte,350,elevador.y - 100,0,1.5)
    love.graphics.setColor(1,menu.c10,menu.c10)
    love.graphics.print('--CONFIG.--',cenario.fonte,350,elevador.y ,0,1.5)
    love.graphics.setColor(1,menu.c11,menu.c11)
    love.graphics.print('--SAIR--',cenario.fonte,360,elevador.y + 100,0,1.5)
    love.graphics.setColor(1,menu.c15,menu.c15)
    love.graphics.print('--MENU PRINCIPAL--',cenario.fonte,300,elevador.y - 200,0,1.5)
    love.graphics.setColor(1,1,1)
    love.graphics.print('Duracao dos pedidos: ',cenario.fonte,630,elevador.y-220)
    love.graphics.print('Pedido mais \ndemorado:'..'\n'..cronometro.tempoMaior, cenario.fonte, 630, elevador.y-270)
    for i = 1 , #cronometro.armazena_tempos do
      love.graphics.print(cronometro.armazena_tempos[i],cenario.fonte,650,elevador.y-200+(20*i))
    end
  end
  
  if config == true then
    love.graphics.setColor(0,0,0,0.7)
    love.graphics.rectangle('fill',0,elevador.y-300,800,600)
    love.graphics.setColor(1,1,1)
    love.graphics.print('--VOLUME--',cenario.fonte,150,elevador.y - 100,0,1.5)
    love.graphics.print(tostring(cenario.volume_musica * 10)..'%',cenario.fonte,90,elevador.y - 15,0,1.5)
    love.graphics.draw(menu.volume,180,elevador.y - 50)
    love.graphics.print('--BRILHO--',cenario.fonte,350,elevador.y - 100,0,1.5)
    love.graphics.draw(menu.volume,380,elevador.y - 50)
    love.graphics.setColor(1,menu.c13,menu.c13)
    love.graphics.print('--APARENCIA--',cenario.fonte,550,elevador.y-100,0,1.5)
    love.graphics.setColor(1,menu.c16,menu.c16)
    love.graphics.print('--VOLTAR--',cenario.fonte,350,elevador.y+200,0,1.5)
  end
  
  if aparencia == true then
    love.graphics.setColor(0,0,0,0.7)
    love.graphics.rectangle('fill',0,elevador.y-300,800,600)
    love.graphics.setColor(1,1,1)
    love.graphics.print('--CABINAS--',cenario.fonte,350,elevador.y - 250,0,1.5)
    love.graphics.draw(elevador.elevador,100,elevador.y - 200)
    love.graphics.draw(elevador.elevador2,350,elevador.y - 200)
    love.graphics.draw(elevador.elevador3,600,elevador.y - 200)
    love.graphics.print('--ANDARES--',cenario.fonte,350,elevador.y - 50,0,1.5)
    love.graphics.draw(cenario.andar,100,elevador.y,0,0.5,0.5)
    love.graphics.draw(cenario.andar2,400,elevador.y,0,0.5,0.5)
    love.graphics.setColor(1,menu.c14,menu.c14)
    love.graphics.print('--VOLTAR--',cenario.fonte,350,elevador.y + 200,0,1.5)
  end
  --Brilho
  love.graphics.setColor(0,0,0,menu.brilho/10)
  love.graphics.rectangle('fill',0,elevador.y-300,800,600)
  love.graphics.pop()
end

return menu