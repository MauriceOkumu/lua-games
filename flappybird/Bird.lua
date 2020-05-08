Bird= Class{}
local GRAVITY = 10
sounds = {
    ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
    ['move'] = love.audio.newSource('sounds/move.wav', 'static'),
}

function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = WINDOW_WIDTH / 2 -8
    self.y = WINDOW_HEIGHT / 2 -8

    self.dy = 0
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Bird:collides(pipe)
     -- the 2's are left and top offsets
    -- the 4's are right and bottom offsets
    -- both offsets are used to shrink the bounding box to give the player
    -- a little bit of leeway with the collision
    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end

    return false
end

function Bird:update(dt)
   self.dy = self.dy + GRAVITY * dt
   if love.keyboard.wasPressed('space') then
    self.dy = -3
    sounds.jump:play()

   end
--    if love.keyboard.wasPressed('left') then
--     self.x = self.x - 10
--     sounds.move:play()
--    end
--    if love.keyboard.wasPressed('right') then
--     self.x = self.x + 10 
--     sounds.move:play()
--    end
    self.y = self.y + self.dy
end