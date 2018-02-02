function love.load()

  instruction = {"up", "right", "down", "left"}
  i = 1 --pointer in "instruction" array above
  score = 0
  hiScore = 0
  posx = love.math.random(100, 550)
  posy = love.math.random(100, 350)
  angle = 0
  punishment = true
  timeStart = 120 --timer setting
  time = timeStart
  mainMenu = true
  mos = love.graphics.newImage("image/38234.jpg")

  love.graphics.setNewFont(30)
  love.graphics.setBackgroundColor(0, 220, 255)

  --abc = love.audio.newSource("sound/123.mp3", "stream")

  --love.audio.play(abc)
end
--------------------------------------------------------------
function love.update(dt)

  if love.keyboard.isDown("escape")then --game exit
    love.event.quit()
  end

  time = time - dt --countdown

  if time <= 0 then -- if player runs out of time
    if hiScore < score then -- Test if high score is beaten
      hiScore = score
    end
    score = 0 --score and timer reset
    time = timeStart
  end

end
----------------------------------------------------------------
function love.keypressed(key, isrepeat)


    if key == instruction[i] then -- If correct key is pressed
      score = score + 1 --score add
      punishment = false
    end

    if key ~= instruction[i] then -- If wrong key is pressed
      if hiScore < score then -- Test if high score is beaten
        hiScore = score
      end
      score = 0 -- score reset
      time = timeStart --time reset
      if (punishment == true and mainMenu == false) then --punishment for very bad players
        --love.system.openURL("https://www.youtube.com/embed/DSzlq7SaqTQ?rel=0&amp;autoplay=1;fs=0;autohide=0;hd=0;")
      end
    end

  if score >= 15 then -- Directive appears randomly on canvas when 15 points is reached
    posx = love.math.random(100, 550) -- Randomly change directive position
    posy = love.math.random(100, 350) --ditto
  end
  if score >= 30 then
    angle = math.random(0, 6)
  end

  love.graphics.setBackgroundColor(love.math.random(0,200),love.math.random(0,200),love.math.random(0,200))
  i = love.math.random(1, 4) --Randomly choses directive

  love.timer.sleep(0.3) --To avoid button spamming

  mainMenu = false

end
--------------------------------------------------------------
function love.draw()

  if mainMenu == true then
    love.graphics.draw(mos, 500, 390, 0, 0.2)
    love.graphics.setColor(10, 10, 10, 200)
    love.graphics.setNewFont(100)
    love.graphics.printf("SWIPE", 0, 140, 640, "center")
    love.graphics.setNewFont(30)
    love.graphics.printf("Press ENTER to START", 0, 300, 640, "center")
  else
    love.graphics.setColor(0, 0, 0, 200) -- header color
    love.graphics.rectangle("fill", 0, 0, 640, 80) -- header size
    love.graphics.setColor(255, 255, 255, 255) -- font color
    love.graphics.print("Score : "..score, 360, 10)
    love.graphics.print("High Score : "..hiScore, 10, 10)
    love.graphics.print("Time left : "..math.floor(time), 360, 40)
    --love.graphics.rotate(angle)
    love.graphics.print(instruction[i], posx, posy)
  end

end
