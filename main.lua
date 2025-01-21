require 'elevador'
require 'cenario'
require 'evento'
require 'soundtrack'
require 'menu'
require 'fisica'
require 'manutencao'
require 'cronometro'

function love.load()
  elevador:load()
  cenario:load()
  soundtrack:load()
  menu:load()
  fisica:load()
  manutencao:load()
  cronometro:load()
end

function love.update(dt)
  elevador:update(dt)
  cenario:update(dt)
  evento:update(dt)
  menu:update(dt)
  fisica:update(dt)
  manutencao:update(dt)
  cronometro:update(dt)
end

function love.draw()
  cenario:draw()
  elevador:draw()
  fisica:draw()
  menu:draw()
  manutencao:draw()
end

--FIM