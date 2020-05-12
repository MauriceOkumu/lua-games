Spacecraft = Class{}

function Spacecraft:init()
    self.x = 500
    self.y = 500
    self.image = love.graphics.newImage('graphics/Battleship.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
   
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

function Spacecraft:collides(target)
end

function Spacecraft:render()
    love.graphics.draw(self.image,self.x, self.y)

end