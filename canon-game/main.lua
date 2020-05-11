require 'src/Dependencies'

function love.load()
    love.window.setTitle('Canon Shoot')
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { 
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gStateMachine = StateMachine{
        ['start'] = function() return StartState end,
        ['play'] = function() return PlayState end,
    }

    love.keyboard.keysPressed = {}
    gStateMachine:change('start')
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
    love.graphics.printf('CANON GAME', 12, 30, WINDOW_WIDTH, 'center')
    love.graphics.printf('PRESS ENTER TO START THE GAME', 12, 60, WINDOW_WIDTH, 'center')
    gStateMachine:render()
  
end
