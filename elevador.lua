elevador = {}
elevador.pedidos = {}

--Funcao que le o arquivo .txt
function read_file(filename)
  
  local subida = {}
  local descida = {}
  local file = io.open(filename,'r')
  
  for line in file:lines() do
    local virg = line:find(',')
    
    origem = tonumber(line:sub(1,virg-1))
    destino = tonumber(line:sub(virg+1))
    
    if origem < destino then
      table.insert(subida,origem)
      table.insert(subida,destino)
    elseif origem > destino then
      table.insert(descida,origem)
      table.insert(descida,destino)
    end
  end
  
  table.sort(subida)
  table.sort(descida, function(a,b)
      return a>b
  end)
  
  for i=1, #subida do
    if subida[i] ~= elevador.pedidos[#elevador.pedidos] then
      table.insert(elevador.pedidos,subida[i])
    end
  end
  for i=1, #descida do
    if descida[i] ~= elevador.pedidos[#elevador.pedidos] then
      table.insert(elevador.pedidos,descida[i])
    end
  end
  
  file:close()
end

--Funcao que cria o arquivo .csv
function cria_csv(filename)
  arquivo_csv = io.open(filename, 'w')
  arquivo_csv:write('Tempo;Altura;Velocidade\n')
end

--Funcao que atualiza o arquivo .csv
function add_csv(t,h,v,a)
  local t_string = tostring(t):gsub('%.',',')
  local h_string = tostring(h):gsub('%.',',')
  local v_string = tostring(v):gsub('%.',',')
  local line = t_string..';'..h_string..';'..v_string..'\n'
  arquivo_csv:write(line)
end


function elevador:load()
  
  read_file('pedidos.txt')
  cria_csv('dados.csv')
  elevador.escolha=1
  elevador.elevador=love.graphics.newImage('imagens/elevador.png')
  elevador.elevador2=love.graphics.newImage('imagens/elevador2.png')
  elevador.elevador3  =love.graphics.newImage('imagens/elevador3.png')
  elevador.y=480
  elevador.vel=0
  elevador.ac=10
  elevador.desac=0
  elevador.larguraporta=39
  elevador.pedidoatual=1
  elevador.andaratual=0
  elevador.tempo=0 --Tempo total do programa
  elevador.timer=0 --Timer do elevador
  start = false
  pedidos_online = false
  
end

function elevador:update(dt)
  
  --Arquivo CSV
  if start == true then
    add_csv(elevador.tempo, 479 - elevador.y, elevador.vel,elevador.ac)
  end
  --Temporizador
  if start == true and pause == false and config == false and aparencia == false then
    elevador.tempo=elevador.tempo+dt
  end
  --Velocidade do elevador
  if pause == false and config == false and aparencia == false then
    elevador.y=elevador.y-(elevador.vel*dt)
  end
  --Coordenada do andar
  if #elevador.pedidos > 0 then
    elevador.yandar= 570-(elevador.pedidos[1]*230)
  end
  
  --Movimento por pedidos:
  if elevador.y <= 500-(230*(elevador.andaratual+1)) and queda == false then
    elevador.andaratual = elevador.andaratual+1
  elseif elevador.y >= 500-(230*(elevador.andaratual)) and queda == false then
    elevador.andaratual = elevador.andaratual-1
  end
  
  if movimento == true and elevador.y > elevador.yandar and pause == false and config == false and aparencia == false then
    if elevador.vel <300 then
      elevador.ac = 10
      elevador.vel=elevador.vel+elevador.ac
    end
  elseif movimento == true and elevador.y < elevador.yandar-160 and pause == false and config == false and aparencia == false then
    if elevador.vel >-300 then
      elevador.ac = -10
      elevador.vel=elevador.vel+elevador.ac
    end
  --Desaceleracao do elevador subindo
  elseif movimento == true and elevador.y <= elevador.yandar and elevador.y > elevador.yandar-80 and elevador.vel > 0 and pause == false and config == false and aparencia == false and defeito == false then
    elevador.ac = -10
    elevador.vel = elevador.vel + elevador.ac
    if elevador.vel <= 0 then
      elevador.vel = 0
    end
  --Desaceleracao do elevador descendo
  elseif movimento == true and elevador.y >= elevador.yandar-160 and elevador.y < elevador.yandar-80 and elevador.vel < 0 and pause == false and config == false and aparencia == false and defeito == false then
    elevador.ac = 10
    elevador.vel = elevador.vel + elevador.ac
    if elevador.vel >= 0 then
      elevador.vel = 0
    end
    
    if elevador.vel == 300 or elevador.vel == -300 then
      elevador.ac = 0
    end
  end
  
  
  if movimento == true and elevador.andaratual == elevador.pedidos[elevador.pedidoatual] and pause == false and config == false and aparencia == false then 
    
    --Timer do elevador (Apenas ativado quando o elevador para)
    elevador.timer = elevador.timer+dt
    
    if elevador.timer> 1 and elevador.timer<= 1.5 then
      soundtrack.ding:play()
    end
    if elevador.timer> 1.5 then
      abre = true
      fecha = false
      if elevador.timer < 2 then
        soundtrack.porta:setVolume(0.8)
        soundtrack.porta:play()
      end
    end 
    if elevador.timer >=4 then
      abre = false
      fecha = true
      soundtrack.porta:setVolume(0.8)
      soundtrack.porta:play()
    end
    if elevador.timer >= 5 then
      elevador.pedidoatual = 1
      table.remove(elevador.pedidos,1)
      elevador.timer = 0
    end
  end
  
  if elevador.pedidoatual > #elevador.pedidos and pedidos_online == false then
    elevador.pedidoatual = #elevador.pedidos
    movimento = false
    start = false
    elevador.vel = 0
    arquivo_csv:close()
    arquivo_csv_fisica:close()
  elseif elevador.pedidoatual > #elevador.pedidos and pedidos_online == true then
    elevador.vel = 0
  end

  if pedidos_online == true and elevador.tempo == dt then
    elevador.pedidos = {}
  end

  --Limitacao do elevador
  if elevador.y < cenario.teto+131 then
    elevador.y=cenario.teto+131
  elseif elevador.y > 479 then
    elevador.y=479
  end
  --Musica
  if start == true then
    soundtrack.musica:setVolume(cenario.volume_musica/10)
    soundtrack.musica:play()
  end
  --Movimentacao
  if elevador.tempo > 2 then
    movimento = true
  end
end

function cria_retangulo(x,y,w,h,r,g,b)
  love.graphics.setColor(r,g,b)
  love.graphics.rectangle('fill',x,y,w,h)
end

function elevador:draw()
  cria_retangulo(394,cenario.teto-50,3,-cenario.teto+600-80+(elevador.y-480),0,0,0)
  cria_retangulo(364,cenario.teto-50,3,-cenario.teto-600-325+(-elevador.y-480),0,0,0)
  love.graphics.setColor(1,1,1)
  if elevador.escolha == 1 then
    love.graphics.draw(elevador.elevador,345,elevador.y-10)
  elseif elevador.escolha == 2 then
    love.graphics.draw(elevador.elevador2,345,elevador.y-10)
  else
    love.graphics.draw(elevador.elevador3,345,elevador.y-10)
  end
  cria_retangulo(370,elevador.y+40,40,40,0.5,0.5,0.5)
  cria_retangulo(355,elevador.y,elevador.larguraporta,80,0,0.8,0.7)
  cria_retangulo(435,elevador.y,-elevador.larguraporta,80,0,0.8,0.7)
  love.graphics.setColor(0,0.8,0.7,manutencao.vidroalpha)
  love.graphics.draw(cenario.vidro,425,elevador.y,math.pi/2,0.16)
  love.graphics.setColor(1,1,1)
  love.graphics.line(370,elevador.y+5,360,elevador.y+20)
  love.graphics.line(390,elevador.y+5,365,elevador.y+40)

end

return elevador