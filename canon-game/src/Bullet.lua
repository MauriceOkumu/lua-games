Bullet = Class{}
function Bullet:init(craft)
   self.laser = love.graphics.newImage('graphics/bullet.png')
   self.width = self.laser:getWidth() / 2
   self.x = craft.x
   self.y = craft.y - self.laser:getHeight()  + 60 
   self.dy = 0
   self.updateBulletX = true
   self.show_bullet = true
end


function Bullet:update(dt)
   
    if love.keyboard.wasPressed('space') then
        self.dy = self.dy + 600 * dt
        gSounds['laser']:play()
        self.updateBulletX = false
       
     end
     self.y = self.y - self.dy
   
end

function Bullet:reload()
    
end

function Bullet:collides(target)
    if self.updateBulletX == false then
        if self.x >= target.x and self.x <= target.x + target.width then
            if self.y <= target.y + target.height then
                self.show_bullet = false
               return true
            end
        end
    end
end

function Bullet:render()
    if self.show_bullet then
      love.graphics.draw(self.laser, self.x -10, self.y)
    end
end