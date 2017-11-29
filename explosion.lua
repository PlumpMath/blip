explosion = {
  x = 0,
  y = 0,
  r = 0,
  active = false,
  strength = 0,
  maxStrength = 500,
  dissipation = 550,
  speed = 600,
  timer = 3
}

function explosion:new()
  if explosion.active == false and explosion.timer >= 0 then
    explosion.x = sub.x
    explosion.y = sub.y
    explosion.strength = explosion.maxStrength
    explosion.active = true
    explosion.timer = 3
    game.difficultySpeed = game.difficultySpeed + 2
  end
end

function explosion:update(dt)
  explosion.r = explosion.r + (dt * explosion.speed)
  explosion.strength = explosion.strength - (dt * explosion.dissipation)

  if explosion.strength <= 0 then
    explosion:reset()
  end

  -- Calculate time till explosion can be reused
  explosion.timer = explosion.timer - dt
  if explosion.timer <= 0 then
    explosion.timer = 0
  end
end

function explosion:draw()
  love.graphics.setColor(255, 0, 0, explosion.strength /4)
  love.graphics.circle('fill', explosion.x, explosion.y, explosion.r)
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
  explosion.timer = 3
end
