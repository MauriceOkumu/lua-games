Comet = Class{}


local comet_speed = 2
local image = love.graphics.newImage('graphics/asteroid.png')
function Comet:init()
    self.width = image:getWidth()
    self.height = image:getHeight()
    self.x = math.random(-40, WINDOW_WIDTH - self.width)
    self.y = 100
    self.dy = 0

    -- Particle belongs to comet 
    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)
    -- lasts between 0.5-2 seconds seconds
    self.psystem:setParticleLifetime(0.5, 2)
    self.psystem:setColors({
        math.random(), math.random(), math.random(), math.random()
       
    })

     -- give it an acceleration of anywhere between X1,Y1 and X2,Y2 (0, 0) and (80, 80) here
    -- gives generally downward 
    self.psystem:setLinearAcceleration(-15, 0, -15, -80)

    -- spread of particles; normal looks more natural than uniform
    self.psystem:setEmissionArea('normal', 10, 10)
    
end

function Comet:update(dt)
    self.dy = self.dy + (math.random(-1,comet_speed) * dt)
    self.y  = self.y + self.dy
    
    if self.y > WINDOW_HEIGHT then
        self.dy = self.dy -1
        self.y = - 100
    end
    self.psystem:update(dt)

end

function Comet:collides()
    -- self.psystem:emit(64)
end

function Comet:render()
    love.graphics.draw(image, self.x, self.y)
end

function Comet:renderParticles()
    self.psystem:emit(64)
    love.graphics.draw(self.psystem, self.x + self.width / 2 , self.y - 8)
end
