ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
    sounds['music']:stop()
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    local rectWidth = 300
    local rectHeight = 150

    love.graphics.rectangle('fill', (VIRTUAL_WIDTH / 2) - (rectWidth / 2), 45, rectWidth, rectHeight)

    love.graphics.setColor(0, 0, 0)

    love.graphics.setFont(largeFont)
    love.graphics.printf('You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1)
end

function ScoreState:exit()
    sounds['music']:play()
end