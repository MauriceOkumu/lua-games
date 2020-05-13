PlayState = Class{__includes = BaseState}

function PlayState:enter()
   self.spacecraft = Spacecraft()
    self.asteroids = {}
    for i = 1, 5 do
      table.insert(self.asteroids, Comet())
    end
end

function PlayState:update(dt)
    self.spacecraft:update(dt)
    
    for k, comet in pairs(self.asteroids) do
        comet:update(dt)
        
    end

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
    self.spacecraft:render()
    
    for k, comet in pairs(self.asteroids) do
        comet:render()
        comet:renderParticles()
    end
   
    love.graphics.printf({COLORS,'Playing the game'},12, 60, WINDOW_WIDTH, 'center')
end