function love.load()
  moleX = 200
  moleY = 200
  score = 0
  respawnTimer = 0
  timer = 10
  --load files
  scoreFont = love.graphics.newFont("Minecraft.ttf",36)
  popSound = love.audio.newSource("pop.wav", "static")
  moleImg = love.graphics.newImage("mole.png")

  gameover = false
  respawnTime = 0.5
end

function love.mousepressed(x, y, button)
  if button == 1 and gameover == false then
    dist = math.sqrt((x-(moleX+62.5))^2 + (y-(moleY+45))^2) -- we add half of width and heigh to get center point
    if dist < 50 then
      score = score+1
      popSound:play()
      setMolePosition()
    end
  end
end

-- this is day 2 task answer
function love.keypressed( key )
   if key == "r" and gameover == true then
	    score = 0
      gameover = false
      moleX = 200
      moleY = 200
      timer = 10
   end
end
-- day 2 answer endsx

function love.update(dt)
  if gameover == false then
    respawnTimer= respawnTimer + dt
    timer = timer - dt
    if respawnTimer >= respawnTime then
      setMolePosition()
    end
    if timer <= 0 then
      gameover = true
    end
  end
end

function setMolePosition()
  respawnTimer = 0
  moleX = math.random(100 ,love.graphics.getWidth()-100)
  moleY = math.random(100 ,love.graphics.getHeight()-100)
end

function love.draw()
  love.graphics.setBackgroundColor(0.4,0.63,0.93)
  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(scoreFont)
  if gameover == false then
    love.graphics.print("score: ".. score,0,0)
    love.graphics.print("time left:  : ".. math.ceil(timer),200,0)
  else
    love.graphics.print("time up. score: ".. score ,0,0)
  end
  love.graphics.draw(moleImg, moleX, moleY)
end
