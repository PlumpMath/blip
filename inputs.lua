require("sub")

function love.keypressed(key)
  -- Anywhere
  if key == "escape" then
    love.event.push("quit")
  end

  -- Menu
  if game.state == "menu" then
    if key == "return" then
      game:new()
    elseif key == "f" then
      if game.fullscreen then
        love.window.setFullscreen(false, "desktop")
        game.fullscreen = false
      else
        love.window.setFullscreen(true, "desktop")
        game.fullscreen = true
      end
    end

  -- In Game
  elseif game.state == "playing" then
    if key == "space" then
      sub.activatePing()
    elseif key == "p" then
      game.state = "paused"
    end
  elseif game.state == "paused" then
    if key == "p" then
      game.state = "playing"
    end
  elseif game.state == "gameOver" then
    if key == "return" then
      ocean:reset()
      sub:reset()
      game:new()
    end
  end
end
