require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())
    -- love.window.setMode(W_WIDTH, W_HEIGHT, {
    --     fullscreen = false,
    --     vsync = true,
    --     resizable = false
    -- })
    tiles = generateLevel()
    gFonts = {
        ['large'] = love.graphics.newFont('fonts/font.ttf',32)
    }

    gTextures = {
        ['tile'] = love.graphics.newImage('graphics/tiles.png'),
        ['character'] = love.graphics.newImage('graphics/character.png'),
        ['toppers'] = love.graphics.newImage('graphics/tile_tops.png'),
        ['other_tiles'] = love.graphics.newImage('graphics/other_tiles.png')
    }
--   tiles
    quads = GenerateQuads(gTextures['tile'],TILE_SIZE, TILE_SIZE)
    other_quads = GenerateQuads(gTextures['other_tiles'],TILE_SIZE, TILE_SIZE)
    top_quads = GenerateQuads(gTextures['toppers'], TILE_SIZE, TILE_SIZE)

     -- divide quad tables into tile sets
     tilesets = GenerateTileSets(other_quads, TILE_SETS_WIDE, TILE_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)
     toppersets = GenerateTileSets(top_quads, TOPPER_SETS_WIDE, TOPPER_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)
 
     -- random tile set and topper set for the level
     tileset = math.random(#tilesets)
     topperset = math.random(#toppersets)

    -- character
    characterQuads = GenerateQuads(gTextures['character'], CHARACTER_WIDTH , CHARACTER_HEIGHT)
    characterX = V_WIDTH / 2 - (CHARACTER_WIDTH / 2)
    characterY = ((7 - 1) * TILE_SIZE) - CHARACTER_HEIGHT
    characterDY = 0

    -- Animations 
    idleAnimation = Animation{
        frames = {1},
        interval = 1
    }
    
    movingAnimation = Animation{
        frames = {10, 11},
        interval = 0.2
    }
    jumpAnimation = Animation{
        frames = {3},
        interval = 1
    }

    currentAnimation = idleAnimation
    direction = 'right'

    cameraScroll = 0
    backgroundR = math.random()
    backgroundG = math.random()
    backgroundB = math.random()

    -- for y = 1, map_height do
    --     table.insert(tiles, {})
    --     for x = 1, map_width do
    --         table.insert(tiles[y], {
    --             id = y < 7 and SKY or GROUND
    --         })
    --     end
    -- end

    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(V_WIDTH, V_HEIGHT,W_WIDTH, W_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })
    love.window.setTitle('JUMPIN\' JAY')
end

function love.resize(w, h)
    return push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'space' and characterDY == 0 then
        characterDY = JUMP_VELOCITY
        currentAnimation = jumpAnimation
    end
    if key == 'r' then
        tileset = math.random(#tilesets)
        topperset = math.random(#toppersets)
    end
end

function love.update(dt)
    characterDY = characterDY + GRAVITY
    characterY = characterY + characterDY * dt

    if characterY > ((7 -1) * TILE_SIZE) - CHARACTER_HEIGHT then
        characterY = ((7 -1) * TILE_SIZE) - CHARACTER_HEIGHT
        characterDY = 0
    end

    currentAnimation:update(dt)

    if love.keyboard.isDown('left') then 
    --   cameraScroll = cameraScroll - CAMERA_SCROLL_SPEED * dt
    characterX = characterX - CHARACTER_MOVE_SPEED * dt

    if characterDY == 0 then
        currentAnimation = movingAnimation
    end
        direction = 'left'
    elseif love.keyboard.isDown('right') then 
        -- cameraScroll = cameraScroll + CAMERA_SCROLL_SPEED * dt
        characterX = characterX + CHARACTER_MOVE_SPEED * dt
        if characterDY == 0 then
            currentAnimation = movingAnimation
        end
        direction = 'right'
    else
        currentAnimation = idleAnimation
    end
    cameraScroll = characterX -(V_WIDTH /2) + (CHARACTER_WIDTH / 2)
end


function love.draw()
    -- love.graphics.setFont(gFonts['large'])
    -- love.graphics.printf({{1,.4,.7,1},'JUMPIN\' JAY'}, 12, 30, W_WIDTH, 'center')
    push:start()
    love.graphics.translate(-math.floor(cameraScroll), 0)
    love.graphics.clear(backgroundR, backgroundG, backgroundB, 1)

        for y = 1, map_height do
            for x =1, map_width do
                local tile = tiles[y][x]
                -- love.graphics.draw(gTextures['tile'], 
                -- quads[tile.id],(x -1 )* TILE_SIZE, (y - 1) * TILE_SIZE)
                love.graphics.draw(gTextures['other_tiles'],tilesets[tileset][tile.id],
                (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
                if tile.topper then
                    love.graphics.draw(gTextures['toppers'], toppersets[topperset][tile.id], 
                        (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
                end
            end
        end
        -- draw character
        love.graphics.draw(gTextures['character'], characterQuads[currentAnimation:getCurrentFrame()],
         math.floor(characterX) + CHARACTER_WIDTH / 2,
          math.floor(characterY) + CHARACTER_HEIGHT / 2,
        --   Translation axis
         0, direction == 'left' and -1 or 1, 1,
        --  offset
         CHARACTER_WIDTH / 2, CHARACTER_HEIGHT / 2)
    push:finish()
end

function generateLevel()
    local tiles = {}

    -- create 2D array completely empty first so we can just change tiles as needed
    for y = 1, map_height do
        table.insert(tiles, {})

        for x = 1, map_width do
            table.insert(tiles[y], {
                id = SKY,
                topper = false
            })
        end
    end

    -- iterate over X at the top level to generate the level in columns instead of rows
    for x = 1, map_width do
        -- random chance for a pillar
        local spawnPillar = math.random(5) == 1
        
        if spawnPillar then
            for pillar = 4, 6 do
                tiles[pillar][x] = {
                    id = GROUND,
                    topper = pillar == 4 and true or false
                }
            end
        end

        -- always generate ground
        for ground = 7, map_height do
            tiles[ground][x] = {
                id = GROUND,
                topper = (not spawnPillar and ground == 7) and true or false 
            }
        end
    end

    return tiles
end
