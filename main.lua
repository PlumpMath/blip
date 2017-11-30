require("game")
require("inputs")

function love.load()
  -- mainFont = love.graphics.newFont("resources/fonts/Coolville.ttf", 20)
  mainFont = love.graphics.newFont("resources/fonts/pcsenior.ttf", 13)
  titleFont = love.graphics.newFont("resources/fonts/pcsenior.ttf", 40)
  menuFont = love.graphics.newFont("resources/fonts/pcsenior.ttf", 15)
  smallMenuFont = love.graphics.newFont("resources/fonts/pcsenior.ttf", 12)

  love.mouse.setVisible(false)

  pingSound = love.audio.newSource("resources/audio/ping.wav", "static")
  gameOverSound = love.audio.newSource("resources/audio/gameOver.wav", "static")
  -- menuMusic = love.audio.newSource("resources/audio/menu.wav", "static")
  menuMusic = love.audio.newSource("resources/audio/menu5.wav", "static")
  -- menuMusic2 = love.audio.newSource("resources/audio/menu3.wav", "static")
  playingMusic = love.audio.newSource("resources/audio/playing.wav", "static")
  menuMusic:setLooping(true)
  playingMusic:setLooping(true)

  menuMusic:play()
  -- menuMusic2:play()
end

function love.draw()
  love.graphics.setFont(mainFont)
  game:draw()
end

function love.update(dt)
  game:update(dt)
end
