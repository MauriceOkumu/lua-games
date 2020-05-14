GameoverState = Class{__includes = BaseState}

function GameoverState:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameoverState:render()
    love.graphics.printf({COLORS,'GAME OVER!!'},12, 60, WINDOW_WIDTH, 'center')
    love.graphics.printf({COLORS,'Press `enter` to start another game!'},12, 90, WINDOW_WIDTH, 'center')
end