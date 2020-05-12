require 'src/Dependencies'

local background = love.graphics.newImage('graphics/nebula.jpg')

function love.load()
    love.window.setTitle('METEOR SHOOT')
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
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    love.graphics.printf('SPACE GAME', 12, 30, WINDOW_WIDTH, 'center')
    gStateMachine:render()
  
end
