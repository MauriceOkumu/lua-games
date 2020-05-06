WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 700

local background = love.graphics.newImage('background.jpg')
local ground = love.graphics.newImage('fore_ground.png')
font = love.graphics.newFont(20)
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    love.window.setTitle('Flappy bird')
    -- love.graphics.setColor(0, 255, 0, 255)
    love.graphics.setFont(font)
end

function love.draw()
    love.graphics.print('Welcome to flappy bird', 500, 300)
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(ground, 0, 530)
end