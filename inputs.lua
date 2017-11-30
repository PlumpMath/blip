require("sub")

function love.keypressed(key)
  -- Anywhere
  if key == "escape" then
    love.event.push("quit")
  end

  -- Menu
  if game.state == "menu" then
    if key == "return" then
      menuMusic:stop()
      playingMusic:play()
      game:new()
    elseif key == "f" then
      if game.fullscreen then
        love.window.setFullscreen(false, "desktop")
        game.fullscreen = false
        ocean:reset()
        sub:reset()
      else
        love.window.setFullscreen(true, "desktop")
        game.fullscreen = true
        ocean:reset()
        sub:reset()
      end
    end

  -- In Game
  elseif game.state == "playing" then
    if key == "space" then
      sub.activatePing()
    elseif key == "p" then
      playingMusic:stop()
      game.state = "paused"
    end
  elseif game.state == "paused" then
    if key == "p" then
      playingMusic:play()
      game.state = "playing"
    end
  elseif game.state == "gameOver" then
    if key == "return" then
      playingMusic:play()
      ocean:reset()
      sub:reset()
      game:new()
    end
  end
end
