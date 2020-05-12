PlayState = Class{__includes = BaseState}



function PlayState:enter()
--    self.bullets = Bullet()
   self.spacecraft = Spacecraft()
   self.comets = Comet()
end

function PlayState:update(dt)
    self.spacecraft:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('right') then
        gGamestate = true
    end
    if love.keyboard.wasPressed('left') then
        gGamestate = false
    end
end

function PlayState:render()
    love.graphics.setFont(gFonts['large'])
--    self.bullets:render()
   self.comets:render()
   self.spacecraft:render()
    love.graphics.printf({COLORS,'Playing the game'},12, 60, WINDOW_WIDTH, 'center')
end