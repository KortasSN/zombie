function love.load()
  sprites = {}
  sprites.player = love.graphics.newImage('sprites/player.png')
  sprites.bullet = love.graphics.newImage('sprites/bullet.png')
  sprites.zombie = love.graphics.newImage('sprites/zombie.png')
  sprites.background = love.graphics.newImage('sprites/background.png')

  player = {}
  player.x = 200
  player.y = 200
  player.speed = 180

  zombies = {}
  bullets = {}

end






function love.update(dt)
  if love.keyboard.isDown('s') then
    player.y = player.y + player.speed * dt
   end

  if love.keyboard.isDown('w') then
   player.y = player.y - player.speed * dt
  end

  if love.keyboard.isDown('a') then
    player.x = player.x - player.speed * dt
  end

  if love.keyboard.isDown('d') then
   player.x = player.x + player.speed * dt
  end

  for i, z in ipairs(zombies) do
    z.x = z.x + math.cos(zombiePlayerAngle(z)) * z.speed * dt
    z.y = z.y + math.sin(zombiePlayerAngle(z)) * z.speed * dt

    if distanceBetween(z.x, z.y, player.x, player.y) < 35 then
      for i, z in ipairs(zombies) do
        zombies[i] = nil
      end
    end
  end

  for i, b in ipairs(bullets) do
    b.x = b.x + math.cos(b.direction) * b.speed * dt
    b.y = b.y + math.sin(b.direction) * b.speed * dt
  end
end

-- 45 * (pi /180) is the radian value
-- 1.5 * (180 / pi) is the degree value

function love.draw()
  love.graphics.draw(sprites.background, 0, 0)
  love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngle(), nil, nil, sprites.player:getWidth()/2, sprites.player:getHeight()/2)

  for i, z in ipairs(zombies) do
    love.graphics.draw(sprites.zombie, z.x, z.y, zombiePlayerAngle(z), nil, nil, sprites.zombie:getWidth()/2, sprites.zombie:getHeight()/2)
  end

  for i, b in ipairs(bullets) do
    love.graphics.draw(sprites.bullet, b.x, b.y, nil, 0.5, 0.5, sprites.bullet:getWidth()/2, sprites.bullet:getHeight()/2)
  end
end


function playerMouseAngle()
  return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end

function zombiePlayerAngle(enemy)
  return math.atan2(player.y - enemy.y, player.x - enemy.x)
end

function spawnZombie()
  zombie = {}
  zombie.x = math.random(0, love.graphics.getWidth())
  zombie.y = math.random(0, love.graphics.getHeight())
  zombie.speed = 100

  table.insert(zombies, zombie)
end

function spawnBullet()
  bullet = {}
  bullet.x = player.x
  bullet.y = player.y
  bullet.speed = 500
  bullet.direction = playerMouseAngle()

  table.insert(bullets, bullet)

end

function love.keypressed(key, scancode, isrepeat)
 if key == 'space' then
   spawnZombie()
 end
end
function love.mousepressed(x, y, b, isTouch)
  if b == 1 then
    spawnBullet()
  end
end

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end














--
