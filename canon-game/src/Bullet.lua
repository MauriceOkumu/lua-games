Bullet = Class{}
function Bullet:init()
    self.bullets = {}
    for i = 1, 5 do
        table.insert(self.bullets, {
          x = math.random(WINDOW_WIDTH - 100),
          y = math.random(WINDOW_HEIGHT - 100)
        })
    end
end


function Bullet:update(dt)
    -- self.y = self.y + (BULLET_SPEED * dt)
end

function Bullet:reset()
end

function Bullet:collides(target)
end

function Bullet:render()
    for k, bullet in pairs(self.bullets) do
     love.graphics.print('Rendered bullet', bullet.x, bullet.y)
    end
end