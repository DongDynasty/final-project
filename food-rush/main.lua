push = require 'push'
Class = require 'class'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 624
VIRTUAL_HEIGHT = 351

require 'StateMachine'

require 'BaseFood'

require 'Eater'
require 'Burger'
require 'Sushi'
require 'Cake'

require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'

local background = love.graphics.newImage('background.png')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())
    math.random()
    math.random()
    Burger_Spawner = math.random(3, 4)
    Sushi_Spawner = math.random(4, 6)
    Cake_Spawner = math.random(12, 20)

    love.window.setTitle('Food Rush!')

    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('font.ttf', 14)
    largeFont = love.graphics.newFont('font.ttf', 28)
    hugeFont = love.graphics.newFont('font.ttf', 56)
    love.graphics.setFont(largeFont)

    sounds = {
        ['eat'] = love.audio.newSource('eat.wav', 'static'),
        ['start'] = love.audio.newSource('game_start.mp3', 'static'),
        ['over'] = love.audio.newSource('game_over.mp3', 'static'),

        -- https://incompetech.com/music/royalty-free/music.html
        ['music'] = love.audio.newSource('magic_dustbin.mp3', 'static')
    }

    sounds['music']:setLooping(true)
    sounds['music']:play()

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')

    -- initialize input table
    love.keyboard.keysPressed = {}

    -- initialize mouse input table
    love.mouse.buttonsPressed = {}
end



function love.resize(w, h)
    push:resize(w, h)
end



function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end



function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end



function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end



function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end



function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end



function love.draw()
    push:start()

    love.graphics.draw(background, 0, -72)
    gStateMachine:render()

    push:finish()
end