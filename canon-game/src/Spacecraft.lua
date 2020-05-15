Spacecraft = Class{}
bullets = {}
local next = next
function Spacecraft:init()
    self.x = 500
    self.y = 500
    self.image = love.graphics.newImage('graphics/Battleship.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.damage = 0
    self.health = 3
    table.insert(bullets, Bullet(self))
end


function Spacecraft:update(dt)
    if gGamestate then
    self.x = self.x + SPACECRAFT_SPEED 
        for k, bullet in pairs(bullets) do
            if bullet.updateBulletX then
                bullet.x = self.x + self.width / 2 + SPACECRAFT_SPEED - 4
            end
        end
    end
    if gGamestate == false then
        self.x = self.x - SPACECRAFT_SPEED 
        for k, bullet in pairs(bullets) do
            if bullet.updateBulletX then
                bullet.x = self.x + self.width / 2 - SPACECRAFT_SPEED 
            end
        end
    end
     if self.x < 0 then
        self.x = 0
     end

     if self.x >= WINDOW_WIDTH - self.width then
        self.x = WINDOW_WIDTH - self.width
     end
     for k, bullet in pairs(bullets) do
        bullet:update(dt)
        if bullet.y <= 0 then
            table.remove(bullets, k)
        end
     end

     if love.keyboard.wasPressed('space') then
        table.insert(bullets, Bullet(self))
     end
    
end

function Spacecraft:reset()
    
end

function Spacecraft:collides(comet)
    if self.x + 2 >= comet.x and self.x + 2 <= comet.x + comet.width then
        if self.y + 2<= comet.y + comet.height - 4 then
            self.health = self.health - 1
            return true
        end

    end
    return false
end

 function Spacecraft:hits_comet(comet)
    for k, bullet in pairs(bullets) do
        if bullet:collides(comet) then 
            SCORE = SCORE + 1
            table.remove(bullets, k)
            return true
        end
    end
 end

function Spacecraft:render()
    for k, bullet in pairs(bullets) do
        bullet:render()
    end
    love.graphics.draw(self.image,self.x, self.y)
end