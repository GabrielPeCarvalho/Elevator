fisica = {}

--Funcao que cria o .csv de fisica
function cria_csv_fisica(filename)
  arquivo_csv_fisica = io.open(filename, 'w')
  arquivo_csv_fisica:write('Tempo;Forca Motriz;Tracao;Energia\n')
end

function add_csv_fisica(t,fm,tra,en)
  local t_string = tostring(t):gsub('%.',',')
  local fm_string = tostring(fm):gsub('%.',',')
  local tra_string = tostring(tra):gsub('%.',',')
  local en_string = tostring(en):gsub('%.',',')
  local line = t_string..';'..fm_string..';'..tra_string..';'..en_string..'\n'
  arquivo_csv_fisica:write(line)
  
end

function fisica:load()
  
  cria_csv_fisica('fisica.csv')
  fisica.elevador_peso = 10000
  fisica.contrapeso_peso = 5000
  fisica.tempo_ligado = 0
  fisica.energia = 0
  fisica.tracao = 0
  fisica.forca_motriz = 0
  diagrama = false
  
end

function fisica:update(dt)
  
  --Arquivo .csv
  if start == true then
    add_csv_fisica(elevador.tempo,fisica.forca_motriz,fisica.tracao,fisica.energia)
  end
  
  --Um elevador medio gasta 0.11 Kw por segundo, e o custo escolhido do Kw foi de 1.1 reais.
  if elevador.vel ~= 0 and pause == false and config == false and aparencia == false then
    fisica.tempo_ligado = fisica.tempo_ligado + dt
  end
  fisica.energia = fisica.tempo_ligado*0.11*1.1 
  
  
  -- Quando V = cte; Forca motriz + Tracao = peso do elevador 
  if elevador.vel == 300 or elevador.vel == -300 or elevador.vel == 0 then
    fisica.tracao = fisica.contrapeso_peso
    fisica.forca_motriz = fisica.elevador_peso - fisica.tracao
    
  --Quando o elevador esta acelerando, Fm + T - Peso do elevador = Massa do elevador (peso / 10) * Aceleracao
  -- A tracao = Peso do contrapeso - Massa do contrapeso (peso / 10) * Aceleracao
  --2.6 é o valor da aceleracao em m/s^2 do elevador, calculada a partir da equação de Torricelli
  elseif elevador.vel ~= 0 then
    fisica.tracao = fisica.contrapeso_peso - (fisica.contrapeso_peso/10 * 2.6)
    fisica.forca_motriz = fisica.elevador_peso + (fisica.elevador_peso/10 * 2.6) - fisica.tracao
  end
  
  --Força normal que atua sobre a carga
  if elevador.vel == 0 or elevador.vel == 300 or elevador.vel == -300 then
    fisica.normal = cronometro.peso_total
  elseif elevador.ac > 0 then
    fisica.normal = cronometro.peso_total + (cronometro.peso_total/10 * 2.6)
  elseif elevador.ac < 0 then
    fisica.normal = cronometro.peso_total - (cronometro.peso_total/10 *2.6)
  
  end
end

function cria_vetor(m,x,y,h,t) -- O argumento 'm' permite a troca do sentido da seta. Quando m = 1, a seta aponta para cima, quando m = 2, para baixo.
  if m == 1 then
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle('fill',x,y,5,h)
    love.graphics.polygon('fill',x-5,y,x+10,y,x+2.5,y-5)
    love.graphics.setColor(1,1,1)
    love.graphics.print(t,cenario.fonte,x+15,y)
  elseif m == 2 then
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle('fill',x,y,5,h)
    love.graphics.polygon('fill',x-5,y+h,x+10,y+h,x+2.5,y+h+5)
    love.graphics.setColor(1,1,1)
    love.graphics.print(t,cenario.fonte,x+15,y+h)
  end
end
function fisica:draw()
  if diagrama == true then
    cria_vetor(1,410,elevador.y-fisica.tracao/100-10,fisica.tracao/100,'T') --Tracao no elevador
    cria_vetor(2,392.5,elevador.y+90,fisica.elevador_peso/100,'P') -- Peso do elevador
    cria_vetor(2,362.5,-elevador.y-1380,fisica.contrapeso_peso/100,'P') -- Peso do contrapeso
    cria_vetor(1,355,-elevador.y-fisica.tracao/100-1460,fisica.tracao/100,'T') --Tracao no contrapeso
    cria_vetor(1,380,elevador.y-fisica.forca_motriz/100-10,fisica.forca_motriz/100,'FM') --Forca motriz
    cria_vetor(1,392.5,elevador.y-fisica.normal/50+40,fisica.normal/50,'N') -- Forca normal que atua sobre a carga
    love.graphics.push()
    if elevador.y>=300 then
      love.graphics.translate(0,-elevador.y+300)
    end
    love.graphics.setColor(1,1,1)
    love.graphics.draw(cenario.motor,700,elevador.y-200,0,1.5,1.5)
    love.graphics.draw(cenario.polia,723,elevador.y-178,cenario.rotacao,1.6,1.6,cenario.polia:getWidth()/2,cenario.polia:getHeight()/2)
    cria_vetor(1,720,elevador.y-148,fisica.forca_motriz/100,'FM') --Forca motriz
    love.graphics.pop()
  end
end

