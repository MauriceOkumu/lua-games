require 'src/Dependencies'

local background = love.graphics.newImage('graphics/sta.png')
local bg_scroll = 0

function love.load()
    love.window.setTitle('ASTEROID SHOOT')
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { 
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    gStateMachine = StateMachine{
        ['start'] = function() return StartState end,
        ['play'] = function() return PlayState end,
    }

    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/flappy.ttf', 32),
    }

    love.keyboard.keysPressed = {}
    gStateMachine:change('start')
    gGamestate = false
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end



function love.update(dt)
    bg_scroll = (bg_scroll + SCROLLING_SPEED * dt) % LOOPING_POINT
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    love.graphics.draw(background, 0, bg_scroll - 770)
    love.graphics.printf('SPACE GAME', 12, 30, WINDOW_WIDTH, 'center')
    gStateMachine:render()
  
end
