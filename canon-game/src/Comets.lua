Comet = Class{}
local comet_speed = 2
function Comet:init()
    self.comets = {}
    self.image = love.graphics.newImage('graphics/asteroid.png')
    for i = 1, 10 do
        table.insert(self.comets, {
            x = math.random(-2,WINDOW_WIDTH),
            y = -100,
            dy = 0
        })
    end
    self.x = math.random(WINDOW_WIDTH)
    self.y = 100
    
end

function Comet:update(dt)
    for k, comet in pairs(self.comets) do
        -- Acceleration
        comet.dy = comet.dy + (math.random(-1,comet_speed) * dt)
        comet.y = comet.y + comet.dy

        --  self.y = self.y + (math.random(COMET_SPEED) * dt)
        if comet.y > WINDOW_HEIGHT then
            comet.dy = comet.dy -1
            comet.y = - 100
        end
    end
end

function Comet:collides(target)
end

function Comet:render()
    for k, comet in pairs(self.comets) do
        love.graphics.draw(self.image, comet.x, comet.y)
    end
end
