Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage('pipe.png')
local PIPE_SCROLL = -60

function Pipe:init()
    self.x = WINDOW_WIDTH - 300
    self.y = math.random(WINDOW_HEIGHT / 2, WINDOW_HEIGHT - 10)
    self.width = PIPE_IMAGE:getWidth()
    
end
function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end

function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, self.x, self.y)
end