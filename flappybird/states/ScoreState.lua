
ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()

    love.graphics.printf({COLORS,'Oof! You lost!'}, 0, 64, WINDOW_WIDTH, 'center')

    love.graphics.setFont(flappyFont)
    love.graphics.printf({COLORS,'Score: ' .. tostring(self.score)}, 0, 100, WINDOW_WIDTH, 'center')

    love.graphics.printf({{255, 0, 0, 1},'Press Enter to Play Again!'}, 0, 160, WINDOW_WIDTH, 'center')
end