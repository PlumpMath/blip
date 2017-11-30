ping = {
  x = 0,
  y = 0,
  r = 0,
  active = false,
  strength = 0,
  maxStrength = 500,
  dissipation = 250,
  speed = 600,
  timer = 3
}

function ping:new()
  if ping.active == false and ping.timer >= 0 then
    ping.x = sub.x + (sub.w / 2)
    ping.y = sub.y + (sub.h / 2)
    ping.strength = ping.maxStrength
    ping.active = true
    ping.timer = 3
    game.difficultySpeed = game.difficultySpeed + 10

    pingSound:play()
  end
end

function ping:update(dt)
  ping.r = ping.r + (dt * ping.speed)
  ping.strength = ping.strength - (dt * ping.dissipation)

  if ping.strength <= 0 then
    ping:reset()
  end

  -- Calculate time till ping can be reused
  ping.timer = ping.timer - dt
  if ping.timer <= 0 then
    ping.timer = 0
  end
end

function ping:draw()
  love.graphics.setColor(155, 155, 155, ping.strength /4)
  love.graphics.circle("fill", ping.x, ping.y, ping.r)
end

function ping:reset()
  ping.active = false
  ping.x = 0
  ping.y = 0
  ping.r = 0
  ping.strength = 0
  ping.maxStrength = 500
  ping.dissipation = 250
  ping.speed = 600
  ping.timer = 3
end
