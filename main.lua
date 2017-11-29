require("menu")
require("game")
require("inputs")

function love.load()
end

function love.draw()
  if game.state == "menu" then
    menu:draw()
  else
    game:draw()
  end
end

function love.update(dt)
  if game.state == "playing" then
    game:update(dt)
  elseif game.state == "gameOver" then
    game.highscore = game.score
    explosion:update(dt)
  end
end
