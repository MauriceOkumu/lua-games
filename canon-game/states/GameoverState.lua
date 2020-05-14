GameoverState = Class{__includes = BaseState}

function GameoverState:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
        SCORE = 0
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameoverState:render()
    gSounds['game_ended']:play()
    gSounds['game_ended']:setLooping(true)
    love.graphics.printf({COLORS,'FINAL SCORE :  ',color, SCORE },12, 100, WINDOW_WIDTH, 'center')
    
    love.graphics.printf({COLORS,'Press ',color, '`enter`',
    COLORS,' to start the another game !'},12, 200, WINDOW_WIDTH, 'center')
end