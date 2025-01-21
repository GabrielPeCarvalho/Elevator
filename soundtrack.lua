soundtrack = {}

function soundtrack:load()
  soundtrack.musica = love.audio.newSource('sons/musica.mp3','stream')
  soundtrack.ding = love.audio.newSource('sons/ding.mp3','static')
  soundtrack.start = love.audio.newSource('sons/start.mp3','static')
  soundtrack.click = love.audio.newSource('sons/click.mp3','static')
  soundtrack.elevador_quebrado = love.audio.newSource('sons/elevadorquebrado.mp3','static')
  soundtrack.motor_quebrado = love.audio.newSource('sons/motorquebrado.mp3','static')
  soundtrack.manutencao = love.audio.newSource('sons/manutencao.mp3','static')
  soundtrack.porta= love.audio.newSource('sons/porta.mp3','static')
  soundtrack.polia_quebrada= love.audio.newSource('sons/polia_quebrada.mp3','static')
  soundtrack.batida= love.audio.newSource('sons/batida.mp3','static')
  soundtrack.explosao1= love.audio.newSource('sons/explosao1.mp3','static')
  soundtrack.explosao2= love.audio.newSource('sons/explosao2.mp3','static')
  play = true
end

function play_once(sound)
  if play == true then
    sound:play()
    play = false
  end
end

return soundtrack