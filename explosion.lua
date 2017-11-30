explosion = {
  x = 0,
  y = 0,
  r = 0,
  active = false,
  strength = 0,
  maxStrength = 500,
  dissipation = 550,
  speed = 600
}

function explosion:new()
  explosion.x = sub.x
  explosion.y = sub.y
  explosion.strength = explosion.maxStrength
  explosion.active = true

  playingMusic:stop()
  gameOverSound:play()
end

function explosion:update(dt)
  explosion.r = explosion.r + (dt * explosion.speed)
  explosion.strength = explosion.strength - (dt * explosion.dissipation)

  if explosion.strength <= 0 then
    explosion:reset()
  end
end

function explosion:draw()
  love.graphics.setColor(255, 0, 0, explosion.strength /4)
  love.graphics.circle("fill", explosion.x, explosion.y, explosion.r)
end

function explosion:reset()
  explosion.active = false
  explosion.x = 0
  explosion.y = 0
  explosion.r = 0
  explosion.strength = 0
  explosion.maxStrength = 500
  explosion.dissipation = 250
  explosion.speed = 600
end
