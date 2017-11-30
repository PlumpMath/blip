menu = {}
ocean:reset()
sub:reset()

function menu:draw()
  love.graphics.setColor(0, 0, 0, 150)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  love.graphics.setColor(50, 150, 250)

  local w, h = love.graphics.getWidth(), love.graphics.getHeight()

  love.graphics.setFont(titleFont)
  love.graphics.printf("BLIP", 0, h/4.5, w, "center")

  love.graphics.setFont(menuFont)
  love.graphics.printf("\"Incoming sea mines Captain!\"", 0, h/2.8, w, "center")
  love.graphics.printf("\"We can use Left/A and Right/D to dodge them\"", 0, h/2.8+20, w, "center")
  love.graphics.printf("\"And use Space to detect them on our sonar!\"", 0, h/2.8+40, w, "center")

  love.graphics.setFont(smallMenuFont)
  love.graphics.printf("\"Oh and by the way we found this minor glitch in our systems where for some reason our engines go faster and faster each time we ping our sonar..\"", 0, h/2.8+80, w, "center")
  love.graphics.printf("\"but dont worry about that..\"", 0, h/2.8+120, w, "center")

  love.graphics.setFont(menuFont)
  love.graphics.printf("High Score: " .. math.floor(game.highscore), 0, h/2.8+160, w, "center")
  love.graphics.printf("Press F to toggle fullscreen", 0, h/2.8+180, w, "center")
  love.graphics.printf("Press Enter to play or Esc to quit anytime", 0, h/2.8+200, w, "center")
end

