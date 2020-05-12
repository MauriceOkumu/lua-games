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
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf({COLORS,'Press `enter` or `return` to start the game'},12, 60, WINDOW_WIDTH, 'center')
end
