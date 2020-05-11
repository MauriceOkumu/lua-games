Bullet = Class{}

function Bullet:init()
    self.x = 80
    self.y = 300
end


function Bullet:update(dt)
    self.y = self.y + (BULLET_SPEED * dt)
end

function Bullet:reset()
end

function Bullet:collides(target)
end

function Bullet:render()
    love.graphics.print('Rendered bullet', self.x, self.y)
end