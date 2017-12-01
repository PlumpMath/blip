require("game")
require("inputs")

function love.load()
  love.mouse.setVisible(false)

  mainFont = love.graphics.newFont("resources/fonts/pcsenior.ttf", 13)
  titleFont = love.graphics.newFont("resources/fonts/pcsenior.ttf", 40)
  menuFont = love.graphics.newFont("resources/fonts/pcsenior.ttf", 15)
  smallMenuFont = love.graphics.newFont("resources/fonts/pcsenior.ttf", 12)

  pingSound = love.audio.newSource("resources/audio/ping.wav", "static")
  gameOverSound = love.audio.newSource("resources/audio/gameOver.wav", "static")
  menuMusic = love.audio.newSource("resources/audio/menu.wav", "static")
  playingMusic = love.audio.newSource("resources/audio/playing.wav", "static")
  menuMusic:setLooping(true)
  playingMusic:setLooping(true)

  menuMusic:play()
end

function love.draw()
  love.graphics.setFont(mainFont)
  game:draw()
end

function love.update(dt)
  game:update(dt)
end
