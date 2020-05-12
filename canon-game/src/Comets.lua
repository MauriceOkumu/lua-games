Comet = Class{}

function Comet:init()
    self.comets = {}
    self.image = love.graphics.newImage('graphics/asteroid.png')
    for i = 1, 10 do
        table.insert(self.comets, {
            x = math.random(WINDOW_WIDTH),
            -- y = math.random(WINDOW_HEIGHT - 100)
        })
    end
end

function Comet:update(dt)
end

function Comet:collides(target)
end

function Comet:render()
    for k, comet in pairs(self.comets) do
        love.graphics.draw(self.image, comet.x, comet.y)
    end
end
