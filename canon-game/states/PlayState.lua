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
        if self.spacecraft:hits_comet(comet) then 
            gSounds['collision']:play()
            table.remove(self.asteroids, k)
            table.insert(self.asteroids, Comet())
        end
        if self.spacecraft:collides(comet) then
            table.remove(self.asteroids, k)
            gSounds['collision']:play()
        end
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
    if self.spacecraft.health == 0 then
        gStateMachine:change('gameover')
        gSounds['music']:stop()
    end
end

function PlayState:render()
    love.graphics.setFont(gFonts['large'])  
    for k, comet in pairs(self.asteroids) do
        comet:render()
        comet:renderParticles()
    end
    self.spacecraft:render()
    love.graphics.print({{1,.3,.4,1},'SCORE : ' .. SCORE}, 15, 30)
    gSounds['game_ended']:stop()
    gSounds['music']:play()
end