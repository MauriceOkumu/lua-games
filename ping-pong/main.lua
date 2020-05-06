Class = require 'class'
require 'Ball'
require 'Paddle'
require 'Tablebound'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
PADDLE_SPEED = 200
ping = 'PING PONG'

font = love.graphics.newFont(20)

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    player1score = 0
    player2score = 0
    love.window.setTitle(ping)

    ball = Ball( WINDOW_WIDTH / 2 - 20,  WINDOW_HEIGHT / 2 - 20, 20, 20)
    player1 = Paddle(80, 120, 15, 40)
   player2 = Paddle(1200, 620, 15, 40)
    ttop = Tablebound(40, 100,WINDOW_WIDTH - 80, 5)
    tbot = Tablebound(40, 680,WINDOW_WIDTH - 75, 5)
    tleft = Tablebound(40, 100,5,580)
    tright = Tablebound(WINDOW_WIDTH - 40, 100,5,580)

    -- Sounds
-- love.audio.newSource(path, [static, stream]) -> static will be in-memory, 
-- stream loaded on the fly

    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }
    
    gameState = 'start'
end

function love.draw()
    love.graphics.printf(
        ping,
        0,
         40,
        WINDOW_WIDTH,
    'center')
    love.graphics.print('PLAYER-1 : scores - ' .. player1score, 260, 60)
    love.graphics.print('PLAYER-2 : scores - ' .. player2score, WINDOW_WIDTH - 260, 60)

    if gameState == 'start' then
      love.graphics.print('PRESS \'enter\' OR \'return \' TO START OR \'esc\' TO QUIT', 400 , 640)
    end
    
    if scoreState == 'goal' then
        love.graphics.print('GOOAALLL!!', 560, 320)
    end

    player1:render()
    player2:render()
    ball:render()
    ttop:render()
    tbot:render()
    tleft:render()
    tright:render()
    displayFPS()

end

function love.update(dt)
    if gameState == 'play' then
        -- detect ball collision with paddles, reversing dx if true and
        -- slightly increasing it, then altering the dy based on the position of collision
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 15
            sounds.paddle_hit:play()
            -- keep velocity going in the same direction, but randomize it
            if ball.dy < 100 then
                ball.dy = -math.random(100, 150)
            else
                ball.dy = math.random(100, 150)
            end
        end
        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x =player2.x - 20
            sounds.paddle_hit:play()

            -- keep velocity going in the same direction, but randomize it
            if ball.dy <= 100 then
                ball.dy = -math.random(100, 150)
            else
                ball.dy = math.random(100, 150)
            end
        end

        -- detect upper and lower screen boundary collision and reverse if collided
        if ball.y <= 100 then
            ball.y = 100
            ball.dy = -ball.dy
            sounds.wall_hit:play()
        end

        -- to account for the ball's size
        if ball.y >= WINDOW_HEIGHT - 60 then
            ball.y = WINDOW_HEIGHT - 60
            ball.dy = -ball.dy
            sounds.wall_hit:play()
        end
        -- scoring
        scored()
    end


    -- player 1 movement
    if love.keyboard.isDown('w') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player1.dy = -PADDLE_SPEED 
    elseif love.keyboard.isDown('s') then
        -- add positive paddle speed to current Y scaled by deltaTime
        player1.dy = PADDLE_SPEED 
    else
        player1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current Y scaled by deltaTime
       player2.dy = -PADDLE_SPEED 
    elseif love.keyboard.isDown('down') then
        -- add positive paddle speed to current Y scaled by deltaTime
       player2.dy = PADDLE_SPEED 
    else
       player2.dy = 0
    end

    if gameState == 'play' then
         ball:update(dt)
    end
    player1:update(dt)
    player2:update(dt)
    
end

function love.keypressed(key)
    -- keys can be accessed by string name
    if key == 'escape' then
        -- function LÖVE gives us to terminate application
        love.event.quit()
    -- if we press enter during the start state of the game, we'll go into play mode
    -- during play mode, the ball will move in a random direction
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
            scoreState = 'nil'

        else
            gameState = 'start'
            ball:reset()
        end
    end
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setColor(0, 255, 0, 255)
    -- love.graphics.setTextScale(3)
    -- concatenate string with number with ..
    love.graphics.setFont(font)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 60, 60)
end

function scored()
    if ball.x > WINDOW_WIDTH - 40 then
        player1score = player1score + 1
        gameState = 'start'
        scoreState = 'goal'
        ball:reset()
        sounds.score:play()
    end
    if ball.x < 40 then
        player2score = player2score + 1
        gameState = 'start'
        scoreState = 'goal'
        ball:reset()
        sounds.score:play()
    end
end

