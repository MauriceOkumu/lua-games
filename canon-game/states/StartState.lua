StartState = Class{__includes = BaseState}
color = {1,.3,.4,1}
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
    love.graphics.printf({COLORS,'INSTRUCTIONS'},12, 80, WINDOW_WIDTH, 'center')

    love.graphics.printf({COLORS,'Press', color ,' =>',COLORS,' key to move left and',
    color,' <= ', COLORS,'key to move right'},12, 140, WINDOW_WIDTH, 'center')

    love.graphics.printf({COLORS,'Press ',color, '`space`',COLORS,' to shoot!'},12, 200, WINDOW_WIDTH, 'center')
    love.graphics.printf({COLORS,'Press ',color, '`enter`',COLORS,' to start the game !'},12, 260, WINDOW_WIDTH, 'center')
   
end

