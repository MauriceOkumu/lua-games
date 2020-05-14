require 'src/Dependencies'

local bg_scroll = 0

function love.load()
    love.window.setTitle('ASTEROID SHOOT')
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { 
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    gStateMachine = StateMachine{
        ['start'] = function() return StartState end,
        ['play'] = function() return PlayState end,
        ['gameover'] = function() return GameoverState end
    }

    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/flappy.ttf', 32),
    }

    gSounds = {
        ['music'] = love.audio.newSource('sounds/spacegamemusic.mp3', 'static'),
        ['collision'] = love.audio.newSource('sounds/collision.wav', 'static'),
        ['laser'] = love.audio.newSource('sounds/laser.wav', 'static'),
        ['game_ended'] = love.audio.newSource('sounds/game_ended.wav', 'static')
    }
    gTextures = {
        ['particle'] = love.graphics.newImage('graphics/particle.png'),
        ['background'] = love.graphics.newImage('graphics/sta.png')
    }

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    love.keyboard.keysPressed = {}
    gStateMachine:change('start')
    gGamestate = false
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end



function love.update(dt)
    bg_scroll = (bg_scroll + SCROLLING_SPEED * dt) % LOOPING_POINT
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    love.graphics.draw(gTextures['background'], 0, bg_scroll - 770)
    love.graphics.printf({{1,.5,.2,1},'ASTEROID SHOOT'}, 12, 30, WINDOW_WIDTH, 'center')
    gStateMachine:render()
  
end
 