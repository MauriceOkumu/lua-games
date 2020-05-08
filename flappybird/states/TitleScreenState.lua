TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()
    -- nothing
end

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function TitleScreenState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf({COLORS,'Flappy Bird'}, 0, 64, WINDOW_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf({COLORS,'Press Enter'}, 0, 100, WINDOW_WIDTH, 'center')
end