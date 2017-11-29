require("ocean")
require("sub")
require("seamines")

game = {
  state = "menu",
  fullscreen = false,
  score = 0,
  highscore = 0,
  timer = 0
}

function game:update(dt)
  ocean:update(dt)
  game:checkCollisions()
  seamines:update(dt)
  sub:update(dt)
  game:updateScore(dt)
end

function game:draw()
  ocean:draw_below()
  seamines:draw()
  if game.state ~= "gameOver" then
    sub:draw()
  end
  ocean:draw_above()

  if game.state == "playing" then
    game:drawUi()
  elseif game.state == "paused" then
    game:drawPaused()
  elseif game.state == "gameOver" then
    game:drawGameover()
  end
end

function game:drawPaused()
  local w, h = love.graphics.getWidth(), love.graphics.getHeight()
  love.graphics.setColor(0,0,0, 100)
  love.graphics.rectangle("fill", 0,0, w, h)
  love.graphics.setColor(255,255,255)
  love.graphics.printf("PAUSE", 0, h/2, w, "center")
end

function game:drawGameover()
  explosion:draw(dt)

  local w, h = love.graphics.getWidth(), love.graphics.getHeight()
  love.graphics.setColor(0,0,0, 100)
  love.graphics.rectangle("fill", 0,0, w, h)
  love.graphics.setColor(255,255,255)
  love.graphics.printf("GAME OVER", 0, h/2, w, "center")
  love.graphics.print("High Score: " .. math.floor(game.highscore), 10, 10)
  love.graphics.printf("Press Enter to play again and esc to go back to menu", 0, h/3, w, "center")
end

function game:drawUi()
  love.graphics.setColor(200, 0, 0)
  love.graphics.print("High Score: " .. math.floor(game.highscore), 10, 10)
  love.graphics.print("Score: " .. math.floor(game.score), 10, 30)
  -- love.graphics.print("Seamines: " .. table.getn(seamines), 10, 50)
  -- love.graphics.print("Bubbles: " .. table.getn(bubbles), 10, 70)
  -- love.graphics.print("SubBubbles: " .. table.getn(subBubbles), 10, 90)
  -- love.graphics.print("SubBubbleTimer: " .. subBubbleTimer, 10, 110)
end

function game:new()
  game.difficultyTime = 0.1
  game.difficultySpeed = 40
  game.difficultySpacing = 150
  game.timer = 0
  game.score = 0
  game.state = "playing"

  ocean:reset()
  sub:reset()
  seamines:reset()
end

function game:updateScore(dt)
  game.score = game.score + dt
end

function game:checkCollisions()
  for index, seamine in ipairs(seamines) do
    if (intersects(sub, seamine) or intersects(seamine, sub)) then
      sub.explode()
      game.state = "gameOver"
    end
  end
end

function intersects(rect1, rect2)
  if rect1.x < rect2.x and rect1.x + rect1.w > rect2.x and
  rect1.y < rect2.y and rect1.y + rect1.h > rect2.y then
    return true
  else
    return false
  end
end
