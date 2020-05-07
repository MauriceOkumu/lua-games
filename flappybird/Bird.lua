Bird= Class{}
local GRAVITY = 10
sounds = {
    ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
    ['move'] = love.audio.newSource('sounds/move.wav', 'static'),
    -- ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
}

function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = WINDOW_WIDTH / 2
    self.y = WINDOW_HEIGHT / 2

    self.dy = 0
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Bird:update(dt)
   self.dy = self.dy + GRAVITY * dt
   if love.keyboard.wasPressed('space') then
    self.dy = -5
    sounds.jump:play()
   end
   if love.keyboard.wasPressed('left') then
    self.x = self.x - 10
    sounds.move:play()
   end
   if love.keyboard.wasPressed('right') then
    self.x = self.x + 10 
    sounds.move:play()
   end
    self.y = self.y + self.dy
end