require("game")

menu = {}

function menu:draw()
  love.graphics.setColor(200, 0, 0)
  love.graphics.print("\"Incoming seamines captain! We can use sonar to detect those mines.\"", 10, 10)
  love.graphics.print("\"Oh.. I forgot to mention. We messed up the wiring so each time you send out a we will go a little bit faster each time\"", 10, 30)
  -- love.graphics.print("Good luck captain", 10, 30)

  love.graphics.print("Highscore: 0", 10, 70)

  love.graphics.print("Left/A - go left, Right/D - go right, Space - ping", 10, 110)
  love.graphics.print("Press F to toggle fullscreen", 10, 130)
  love.graphics.print("Press Enter to play", 10, 150)
  love.graphics.print("Press Esc to exit", 10, 170)
end
