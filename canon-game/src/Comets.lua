Comet = Class{}

function Comet:init()
    self.comets = {}
    for i = 1, 10 do
        table.insert(self.comets, {
            x = math.random(WINDOW_WIDTH - 100),
            y = math.random(WINDOW_HEIGHT - 100)
        })
    end
end

function Comet:update(dt)
end

function Comet:collides(target)
end

function Comet:render()
    for k, comet in pairs(self.comets) do
        love.graphics.print('COMET', comet.x, comet.y)
    end
end
