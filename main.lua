-- require("menu")
require("game")
require("inputs")

function love.load()
end

function love.draw()
  game:draw()
end

function love.update(dt)
  if game.state == "playing" then
    game:update(dt)
  elseif game.state == "menu" then
    ocean:update(dt)
    sub:update(dt)
  elseif game.state == "gameOver" then
    game.highscore = game.score
    explosion:update(dt)
  end
end
