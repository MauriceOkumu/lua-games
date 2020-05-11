StartState = Class{__includes = BaseState}

function StartState:enter(params)
end

function StartState:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    love.graphics.print('Hello from startState', 80, 200)
    love.graphics.print('Press `enter` or `return` to start the game', 80, 240)
end

