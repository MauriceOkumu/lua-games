Spacecraft = Class{}

function Spacecraft:init()
    self.x = 500
    self.y = 500
    self.image = love.graphics.newImage('graphics/Battleship.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.damage = 0
    self.health = 5
   
end


function Spacecraft:update(dt)
    if gGamestate then
    self.x = self.x + SPACECRAFT_SPEED 
    end
    if gGamestate == false then
        self.x = self.x - SPACECRAFT_SPEED 
    end
     if self.x < 0 then
        self.x = 0
     end

     if self.x >= WINDOW_WIDTH - self.width then
        self.x = WINDOW_WIDTH - self.width
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
 
function Spacecraft:render()
    love.graphics.draw(self.image,self.x, self.y)

end