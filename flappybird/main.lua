
require 'push'
Class = require 'class'
require 'Bird'
require 'PipePair'
require 'Pipe'

WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 700



local background = love.graphics.newImage('background.jpg')
local bg_scroll = 0

local ground = love.graphics.newImage('fore_ground.png')
local g_scroll = 1280

local BG_SPEED = 20
local G_SPEED = 60

local flappy = Bird()
local pipe = Pipe()

local pipePairs = {}
local spawnTimer = 0

local lastY =  math.random(120) - 70

local scrolling = true

local BG_LOOPING_POINT =  - 1200

font = love.graphics.newFont(20)
function love.load()
    -- Avoid blurriness
    -- love.graphics.setDefaultFilters('nearest', 'nearest')

    love.window.setTitle('Flappy bird')

    -- push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { 
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    
    love.graphics.setFont(font)
    love.keyboard.KeysPressed = {}
end

function love.draw()
    -- push:start()
    
    love.graphics.draw(background, -bg_scroll, 0)
    love.graphics.draw(background, -bg_scroll - 1200, 0)
    -- love.graphics.draw(background, -bg_scroll-1100 + WINDOW_WIDTH / 2, 0)
    -- love.graphics.draw(ground, g_scroll+ WINDOW_WIDTH, 550)
    -- for k, pipe in pairs(pipes) do
    --     pipe:render()
    -- end
    -- flappy:render()
    love.graphics.print('FLAPPY BIRD', 500, 30)
    -- if gametime == 'night' then 
    --     love.graphics.setColor(0, 255, 0, 255)
    --  end
    -- push:finish()
    flappy:render()
    
    for k, pair in pairs(pipePairs) do
        pair:render()
    end
    love.graphics.draw(ground, g_scroll , 550)
    love.graphics.draw(ground, g_scroll + 1200 , 550)
    
end


function love.update(dt)
    -- if love.keyboard.isDown('n') then
    --     gametime = 'night'
    -- end
    if scrolling then
        bg_scroll = (bg_scroll + BG_SPEED * dt) % BG_LOOPING_POINT
        g_scroll =  (g_scroll - G_SPEED * dt) % BG_LOOPING_POINT
        -- pipe:update(dt)
        spawnTimer = spawnTimer + dt 
        
        if spawnTimer > 4 then 
            -- table.insert(pipes, Pipe())
            -- spawnTimer = 0

            local y = math.max(-PIPE_HEIGHT + 60, 
                    math.min(lastY + math.random(-30, 30), WINDOW_HEIGHT - 190))
                lastY = y
                
                table.insert(pipePairs, PipePair(y))
                spawnTimer = 0
        end
        flappy:update(dt)

        for k, pair in pairs(pipePairs) do 
            pair:update(dt)

           for l, pipe in pairs(pair.pipes) do
            if flappy:collides(pipe) then
                scrolling = false
            end
          end

            if pair.x < -PIPE_WIDTH then
                pair.remove = true
            end
        end
        -- flash out the keys pressed table after every frame
        for k, pair in pairs(pipePairs) do
            if pair.remove then
                table.remove(pipePairs, k)
            end
        end
        love.keyboard.KeysPressed = {}
    end
end

function love.keyboard.wasPressed(key)
    -- Query the keys pressed table
    if  love.keyboard.KeysPressed[key] then
        return true
    else
        return false
    end

end


function love.keypressed(key)
    -- Put the pressed keys in the table
    love.keyboard.KeysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end

end