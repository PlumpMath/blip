require("ping")
require("explosion")

sub = { segments = {} }

subBubbleXTimer = 0
subBubbleYTimer = 0
subBubbles = {}

function sub:activatePing()
  ping.new()
end

function sub:explode()
  explosion.new()
end

function sub:update(dt)
  if sub.x < 0 then
    sub.x = 0
  elseif sub.x > love.graphics.getWidth() then
    sub.x = love.graphics.getWidth()
  else
  end

  sub.xVelocity = sub.xVelocity * (1 - math.min(dt * sub.friction, 1))

  if sub.x <= 0 then
    sub.xVelocity = 5
  elseif sub.x >= love.graphics.getWidth() then
    sub.xVelocity = -5
  end

  sub.x = sub.x + sub.xVelocity

  if game.state == "playing" then
    if love.keyboard.isDown("left", "a") and sub.xVelocity > -sub.maxSpeed then
      sub.xVelocity = sub.xVelocity - sub.acc * dt
    elseif love.keyboard.isDown("right", "d") and sub.xVelocity < sub.maxSpeed then
      sub.xVelocity = sub.xVelocity + sub.acc * dt
    end
  end

  sub.segments = {
    { x = sub.x + 8, y = sub.y - 20, w = sub.w - 16, h = sub.h },
    { x = sub.x + 4, y = sub.y - 10, w = sub.w - 8, h = sub.h },
    { x = sub.x, y = sub.y, w = sub.w, h = sub.h },
    { x = sub.x + 4, y = sub.y + 10, w = sub.w - 8, h = sub.h },
    { x = sub.x + 8, y = sub.y + 20, w = sub.w - 16, h = sub.h }
  }

  if ping.active then
    ping:update(dt)
  end

  if subBubbleYTimer > 0 then
    subBubbleYTimer = subBubbleYTimer - dt
  else
    subBubble:spawn()
    subBubbleYTimer = love.math.random(0.1, 0.5) / (game.difficultySpeed / 30)
  end

  if math.abs(sub.xVelocity) > 1 then
    if subBubbleXTimer > 0 then
      subBubbleXTimer = subBubbleXTimer - dt
    else
      subBubble:spawnMore()
      subBubbleXTimer = love.math.random(0.01, 0.1) / math.abs(sub.xVelocity)
    end
  end

  for index, bubble in ipairs(subBubbles) do
    bubble.y = bubble.y + (dt * game.difficultySpeed * 2)
    bubble.lifetime = bubble.lifetime - dt
    if bubble.lifetime <= 0 then
      table.remove(subBubbles, index)
    end
  end
end

function sub:draw()
  love.graphics.setColor(55, 250, 200)
  for index, segment in ipairs(sub.segments) do
    love.graphics.rectangle("fill", segment.x, segment.y, segment.w, segment.h)
  end

  if ping.active then
    ping:draw()
  end

  subBubbles:draw()
end

function subBubbles:draw()
  for index, bubble in ipairs(subBubbles) do
    love.graphics.setColor(200, 200, 255, 100)
    love.graphics.rectangle("fill", bubble.x, bubble.y, bubble.w, bubble.h)
  end
end

subBubble = {}
subBubbleMore = {}

function subBubble:spawn()
  table.insert(subBubbles, subBubble:new())
end

function subBubble:spawnMore()
  table.insert(subBubbles, subBubbleMore:new())
end

function subBubble:new()
  return {
    x = love.math.random(sub.x, sub.x + sub.w),
    y = sub.y + sub.h,
    w = love.math.random(3, 5),
    h = love.math.random(3, 5),
    lifetime = love.math.random(3, 5)
  }
end

function subBubbleMore:new()
  return {
    x = love.math.random(sub.x, sub.x + sub.w),
    y = love.math.random(sub.y, sub.y + sub.h),
    w = love.math.random(3, 5),
    h = love.math.random(3, 5),
    lifetime = love.math.random(3, 5)
  }
end

function sub:reset()
  sub.x = love.graphics.getWidth() / 2
  sub.y = love.graphics.getHeight() / 3 * 2
  sub.xVelocity = 0
  sub.acc = 20
  sub.maxSpeed = 50
  sub.friction = 5
  sub.w = 30
  sub.h = 60

  sub.segments = {
    { x = sub.x + 8, y = sub.y - 20, w = sub.w - 16, h = sub.h },
    { x = sub.x + 4, y = sub.y - 10, w = sub.w - 8, h = sub.h },
    { x = sub.x, y = sub.y, w = sub.w, h = sub.h },
    { x = sub.x + 4, y = sub.y + 10, w = sub.w - 8, h = sub.h },
    { x = sub.x + 8, y = sub.y + 20, w = sub.w - 16, h = sub.h }
  }

  ping:reset()
  explosion:reset()
  subBubbles:reset()
end

function subBubbles:reset()
  for index, bubble in ipairs(subBubbles) do
    table.remove(subBubbles, index)
  end
  if table.getn(subBubbles) > 0 then
    subBubbles:reset()
  end
  subBubbleYTimer = 0
  subBubbleXTimer = 0
end
