
require 'push'
Class = require 'class'
require 'Bird'
require 'Pipe'

WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 700

-- USING THE PUSH LIBRARY
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.jpg')
local bg_scroll = 0

local ground = love.graphics.newImage('fore_ground.png')
local g_scroll = 1280

local BG_SPEED = 30
local G_SPEED = 60
local flappy = Bird()
local pipe = Pipe()

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
    
    -- love.graphics.draw(background, -bg_scroll, 0)
    -- love.graphics.draw(background, -bg_scroll-1100 + WINDOW_WIDTH / 2, 0)
    -- love.graphics.draw(ground, g_scroll+ WINDOW_WIDTH, 550)
    love.graphics.draw(ground, g_scroll , 550)
    love.graphics.draw(ground, g_scroll + 1200 , 550)
    -- flappy:render()
    love.graphics.print('FLAPPY BIRD', 500, 30)
    if gametime == 'night' then 
        love.graphics.setColor(0, 255, 0, 255)
     end
    -- push:finish()
    flappy:render()
    pipe:render()
end

function love.update(dt)
    -- if love.keyboard.isDown('n') then
    --     gametime = 'night'
    -- end
    -- bg_scroll = (bg_scroll + BG_SPEED * dt) % BG_LOOPING_POINT
    g_scroll =  (g_scroll - G_SPEED * dt) % BG_LOOPING_POINT
    flappy:update(dt)
    pipe:update(dt)
    -- flash out the keys pressed table after every frame
    love.keyboard.KeysPressed = {}
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