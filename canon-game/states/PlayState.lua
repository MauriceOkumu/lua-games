PlayState = Class{__includes = BaseState}

function PlayState:enter()
   bullet = Bullet()
   self.bullet = bullet
end

function PlayState:update(dt)
    self.bullet:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
   self.bullet:render()
    love.graphics.print('Playing the game', 80, 240)
end