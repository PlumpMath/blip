require("ping")
require("explosion")

sub = {
  x = love.graphics.getWidth() / 2,
  y = love.graphics.getHeight() / 3 * 2,
  xVelocity = 0,
  yVelocity = 0,
  acc = 20,
  maxSpeed = 50,
  friction = 5,
  r = 30,
  w = 30,
  h = 30,
  speed = 3
}

subBubbleTimer = 0
subBubbles = {}

function sub:activatePing()
  ping.new()
end

function sub:explode()
  explosion.new()
end

function sub:update(dt)
  sub.x = sub.x + sub.xVelocity
  sub.y = sub.y + sub.yVelocity

  sub.xVelocity = sub.xVelocity * (1 - math.min(dt * sub.friction, 1))
  sub.yVelocity = sub.yVelocity * (1 - math.min(dt * sub.friction, 1))

  if love.keyboard.isDown("left", "a") and sub.xVelocity > -sub.maxSpeed then
    sub.xVelocity = sub.xVelocity - sub.acc * dt
  elseif love.keyboard.isDown("right", "d") and sub.xVelocity < sub.maxSpeed then
    sub.xVelocity = sub.xVelocity + sub.acc * dt
  end

  if ping.active then
    ping:update(dt)
  end

  if subBubbleTimer > 0 then
    subBubbleTimer = subBubbleTimer - dt
  else
    subBubble:spawn()
    subBubbleTimer = love.math.random(0.1, 0.5) / (game.difficultySpeed / 30)
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
  love.graphics.rectangle('fill', sub.x, sub.y, sub.w, sub.h)
  love.graphics.rectangle('fill', sub.x + 4, sub.y - 10, sub.w - 8, sub.h)
  love.graphics.rectangle('fill', sub.x + 4, sub.y + 10, sub.w - 8, sub.h)
  love.graphics.rectangle('fill', sub.x + 8, sub.y - 20, sub.w - 16, sub.h)
  love.graphics.rectangle('fill', sub.x + 8, sub.y + 20, sub.w - 16, sub.h)
  love.graphics.rectangle('fill', sub.x + 10, sub.y + 60, 4, 4)
  love.graphics.rectangle('fill', sub.x + 8, sub.y + 62, 4, 4)
  love.graphics.rectangle('fill', sub.x + 13, sub.y + 50, 4, 4)
  love.graphics.rectangle('fill', sub.x + 9, sub.y + 65, 4, 4)

  if ping.active then
    ping:draw()
  end

  subBubbles:draw()
end

function subBubbles:draw()
  for index, bubble in ipairs(subBubbles) do
    love.graphics.setColor(200, 200, 255, 100)
    love.graphics.rectangle('fill', bubble.x, bubble.y, bubble.w, bubble.h)
  end
end

subBubble = {}

function subBubble:spawn()
  table.insert(subBubbles, subBubble:new())
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

function sub:reset()
  sub.x = love.graphics.getWidth() / 2
  sub.y = love.graphics.getHeight() / 3 * 2
  sub.xVelocity = 0
  sub.yVelocity = 0
  sub.acc = 20
  sub.maxSpeed = 50
  sub.friction = 5
  sub.r = 30
  sub.w = 30
  sub.h = 30
  sub.speed = 3

  ping:reset()
  subBubbles:reset()
end

function subBubbles:reset()
  for index, bubble in ipairs(subBubbles) do
    table.remove(subBubbles, index)
  end
  if table.getn(subBubbles) > 0 then
    subBubbles:reset()
  end
  subBubbleTimer = 0
end
