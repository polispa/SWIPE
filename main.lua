function love.load()

  instruction = {"up", "right", "down", "left"}
  i = 1 --pointer in "instruction" array above
  score = 0
  hiScore = 0
  newHiScore = false --High score beaten?
  posx = love.math.random(100, 550) -- instructions position
  posy = love.math.random(100, 350)
  --arrowPosx = love.math.random(100, 550) -- arrows positions
  --arrowPosy = love.math.random(100, 350)
  --angleArrows = {0, 1.57, 3.14, 4.71}
  --a = 1
  angle = 0 -- instruction rotation
  timeStart = 30 --timer setting
  time = timeStart
  mainMenu = true --player in main menu
  fail = false -- player mistake
  timeOut = false --time out
  mToggle = true -- music switch

--font type list----------------------------------------------
  quicksandL = love.graphics.newFont("font/Quicksand_Bold.otf", 100)
  quicksandM = love.graphics.newFont("font/Quicksand_Book.otf", 30)
  quicksandS = love.graphics.newFont("font/Quicksand_Book.otf", 15)
  quicksandI = love.graphics.newFont("font/Quicksand_Bold.otf", 30)
  ------------------------------------------------------------
  love.graphics.setBackgroundColor(0, 220, 255)
  vignette = love.graphics.newImage("image/vignette.png") --vignette effect


  percival = love.audio.newSource("sound/percival.mp3", "stream")

  love.audio.play(percival) -- Play BGM
end
--------------------------------------------------------------
function love.keyboard.setKeyRepeat(enable) -- avoids button spamming

  enable = true

end
--------------------------------------------------------------
function love.update(dt)

  if love.keyboard.isDown("escape")then --game exit
    love.event.quit()
  end

  if mainMenu == false and fail == false and timeOut == false then -- countdown starts only in-game
    time = time - dt --countdown

    if time <= 0 then -- if player runs out of time
      timeOut = true
      if hiScore < score then -- Test if high score is beaten
        hiScore = score
      end
    end
  end

end --love.update end
----------------------------------------------------------------
function love.keypressed(key, scancode, isrepeat)

  isrepeat = true --anti button spam

  if mainMenu == false and fail == false and timeOut == false then --{
    if key == "up" or key == "down" or key == "left" or key == "right" then
      if key == instruction[i] then -- If correct key is pressed
        score = score + 1 --score add
      end

      if key ~= instruction[i] then -- If wrong key is pressed
        fail = true
        if hiScore < score then -- Test if high score is beaten
          hiScore = score
          newHiScore = true
        end
      end

      if score >= 15 then -- Instruction appears randomly on canvas (15)
        posx = love.math.random(100, 550) -- Randomly change directive position
        posy = love.math.random(110, 350) --ditto
      end

      if score >= 30  then -- Instructions rotate randomly (30)
        angle = love.math.random(0, 6)
        --a = math.random(1, 4)
      end

      love.graphics.setBackgroundColor(love.math.random(0,200),love.math.random(0,200),love.math.random(0,200))
      i = love.math.random(1, 4) --Randomly choses directive

      mainMenu = false
    end -- up down right left condition
  end --} end of if mainMenu == false and fail == false then

  if key == "return" then -- To launch game and exit main menu
    mainMenu = false
    fail = false
    timeOut = false
    angle = 0
    time = timeStart --time reset
    score = 0 -- score reset
    newHiScore = false
  end

  if key == "m" then -- music player
    mToggle = not mToggle
    if mToggle == false then
      love.audio.stop(percival)
    else
      love.audio.play(percival)
    end
  end
end --love.keypressed end
--------------------------------------------------------------
function love.draw(dt)

  if mainMenu == true then --Player in main menu
    love.graphics.setColor(10, 10, 10, 200) --Swipe & Enter to start logo color
    love.graphics.setFont(quicksandL) --"Swipe" logo size
    love.graphics.printf("SWIPE", 0, 140, 640, "center")
    --love.graphics.setNewFont(30) --"Enter to start" size
    love.graphics.setFont(quicksandM)
    love.graphics.printf("Press ENTER to START", 0, 300, 640, "center")
    love.graphics.setFont(quicksandS) -- credits size
    love.graphics.printf("Coded (with Love) by Maxime Leconte and Yann Gaudemer", 0, 350, 640, "center")
    love.graphics.print("Alpha Build 2", 500, 10)
    love.graphics.print("Press M to start/stop music", 10, 10)
  else
    if timeOut == true then --Player runs out of time
      love.graphics.setFont(quicksandL)
      love.graphics.printf("TIME OUT!", 0, 140, 640, "center")
      love.graphics.setFont(quicksandM)
      love.graphics.printf("Your score : "..score, 0, 300, 640, "center")
      if newHiScore == true then
        love.graphics.printf("NEW HIGH SCORE!", 0, 330, 640, "center")
      end
      love.graphics.printf("Press ENTER to restart", 0, 390, 640, "center")
    --end
    elseif fail == true then -- Player makes a mistake
      love.graphics.setColor(255, 255, 255, 255) -- OOPS color
      love.graphics.setFont(quicksandL) -- OOPS size
      love.graphics.printf("OOPS!", 0, 140, 640, "center")
      love.graphics.setFont(quicksandM)
      love.graphics.printf("Your score : "..score, 0, 300, 640, "center")
      if newHiScore == true then
        love.graphics.printf("NEW HIGH SCORE!", 0, 330, 640, "center")
      end
      love.graphics.printf("Press ENTER to restart", 0, 390, 640, "center")
    else --in-game
      love.graphics.setColor(0, 0, 0, 200) -- header color
      love.graphics.rectangle("fill", 0, 0, 640, 80) -- header size
      love.graphics.setFont(quicksandM)
      love.graphics.setColor(255, 255, 255, 255) -- font color
      love.graphics.print("Score : "..score, 360, 10)
      love.graphics.print("High Score : "..hiScore, 10, 10)
      love.graphics.print("Time left : "..math.floor(time), 360, 40)
    end
  end

  if mainMenu == false and fail == false and timeOut == false then
    love.graphics.setFont(quicksandI)
    love.graphics.print(instruction[i], posx, posy, angle) -- up down left right
  end

  love.graphics.draw(vignette, 0, 0) --vignette effect
end --love.draw end
--------------------------------------------------------------
