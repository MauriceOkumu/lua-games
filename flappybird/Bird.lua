Bird= Class{}
local GRAVITY = 10

local sprite_width = 71
local sprite_height = 64
local num_frames = 4
local sprites = {}
local fps = .05
local cur_frame = 1
local time_passed = 0
 
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

    self.atlas = love.graphics.newImage('bluebird.png')

    for num = 1, num_frames do
       sprites[num] = love.graphics.newQuad((num -1) * sprite_width, 0,
        sprite_width, sprite_height,self.atlas:getDimensions())
    end
end


function Bird:collides(pipe)
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
    time_passed = time_passed + dt
    if time_passed > fps then
        time_passed = time_passed - fps
        -- cur_frame = cur_frame + 1
        
        -- if cur_frame > num_frames then
        --     cur_frame = 1
        -- end
        cur_frame = cur_frame % num_frames + 1
        
        
    end
    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.atlas, sprites[cur_frame], self.x, self.y )
end