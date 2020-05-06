Tablebound = Class{}

function Tablebound:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function Tablebound:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end