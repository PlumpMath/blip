require("ping")

-- SEAMINES

seamines = {}

function seamines:reset()
  for index, seamine in ipairs(seamines) do
    table.remove(seamines, index)
  end
  if table.getn(seamines) > 0 then
    seamines:reset()
  end
end

function seamines:draw()
  for index, seamine in ipairs(seamines) do
    love.graphics.setColor(100, 100, 100, seamine.alpha)
    love.graphics.rectangle('fill', seamine.x, seamine.y, seamine.w, seamine.h)
    love.graphics.rectangle('fill', seamine.x + 6, seamine.y, seamine.w / 3, seamine.h * 1.4)
    love.graphics.rectangle('fill', seamine.x + 6, seamine.y, seamine.w / 3, -(seamine.h * 0.4))
    love.graphics.rectangle('fill', seamine.x, seamine.y + 6, seamine.w * 1.4, seamine.h / 3)
    love.graphics.rectangle('fill', seamine.x, seamine.y + 6, -(seamine.w * 0.4), seamine.h / 3)
  end
end

function seamines:update(dt)
  game.timer = game.timer + dt

  if game.timer >= game.difficultyTime then
    seamine:spawn()
    game.timer = 0
  end

  for index, seamine in ipairs(seamines) do
    if seamine.y > (love.graphics.getHeight() + 10) then
      table.remove(seamines, index)
    end

    if checkSeamineDetected(ping, seamine) then
      seamine.alpha = ping.strength
    else
      seamine.alpha = 0
    end

    seamine.y = seamine.y + (dt * game.difficultySpeed)
  end
end

-- SEAMINE

seamine = {}

function seamine:spawn()
  valid_seamine = true
  new_seamine = seamine:new()

  for index, seamine in ipairs(seamines) do
    if checkSeaminesOverlap(new_seamine, seamine) then
      valid_seamine = false
    end
  end

  if valid_seamine then
    table.insert(seamines, new_seamine)
  end
end

function seamine:new()
  local size = love.math.random(15, 20)
  return {
    x = love.math.random(0, love.graphics.getWidth()),
    y = love.math.random(-50, -100),
    r = size,
    h = size,
    w = size,
    alpha = 0
  }
end

function checkSeaminesOverlap(seamine1, seamine2)
  distance_between_circles = distance(seamine1.x, seamine1.y, seamine2.x, seamine2.y)
  if distance_between_circles - (seamine1.r + seamine2.r + game.difficultySpacing) < 0 then
    return true
  end
end

function checkSeamineDetected(ping, seamine)
  distance_between_circles = distance(ping.x, ping.y, seamine.x, seamine.y)
  if distance_between_circles - (ping.r + seamine.r) < 0 then
    return true
  end
end

function distance(x1, y1, x2, y2)
  return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end
