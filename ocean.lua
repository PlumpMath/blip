ocean = {}

ocean.bubbleTimer = 0

bubbles = {}

function ocean:reset()
  bubbles:reset()
end

function ocean:update(dt)
  bubbles:update(dt)
end

function ocean:draw_below()
  love.graphics.setColor(0, 0, 150)
  love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  bubbles:draw_below()
end

function ocean:draw_above()
  bubbles:draw_above()
end

function bubbles:reset()
  for index, bubble in ipairs(bubbles) do
    table.remove(bubbles, index)
  end
  if table.getn(bubbles) > 0 then
    bubbles:reset()
  elseif table.getn(bubbles) <= 0 then
    for i=1,100 do table.insert(bubbles, bubble:initial()) end
  end
end

function bubbles:draw_below()
  for index, bubble in ipairs(bubbles) do
    if bubble.above == 0 then
      love.graphics.setColor(200, 200, 255, 100)
      love.graphics.rectangle('fill', bubble.x, bubble.y, bubble.w, bubble.h)
    end
  end
end

function bubbles:draw_above()
  for index, bubble in ipairs(bubbles) do
    if bubble.above == 1 then
      love.graphics.setColor(200, 200, 255, 100)
      love.graphics.rectangle('fill', bubble.x, bubble.y, bubble.w, bubble.h)
    end
  end
end

function bubbles:update(dt)
  ocean.bubbleTimer = ocean.bubbleTimer + dt

  if ocean.bubbleTimer >= 0.25 then
    bubble:spawn()
    ocean.bubbleTimer = 0
  end

  for index, bubble in ipairs(bubbles) do
    if bubble.y > (love.graphics.getHeight() + 10) then
      table.remove(bubbles, index)
    end

    bubble.y = bubble.y + (dt * game.difficultySpeed)
  end
end

-- BUBBLE

bubble = {}

function bubble:spawn()
  table.insert(bubbles, bubble:new())
end

function bubble:initial()
  return {
    x = love.math.random(0, love.graphics.getWidth()),
    y = love.math.random(-400, love.graphics.getHeight() + 400),
    w = 3,
    h = 3,
    above = love.math.random(0, 1)
  }
end

function bubble:new()
  return {
    x = love.math.random(0, love.graphics.getWidth()),
    y = love.math.random(-50, -100),
    w = 3,
    h = 3,
    above = love.math.random(0, 1)
  }
end
