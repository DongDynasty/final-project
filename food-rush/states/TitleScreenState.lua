TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)
    -- transition to countdown when enter/return are pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function TitleScreenState:render()
    local rectWidth = 210
    local rectHeight = 70

    love.graphics.rectangle('fill', (VIRTUAL_WIDTH / 2) - (rectWidth / 2), 55, rectWidth, rectHeight)

    love.graphics.setColor(0, 0, 0)

    love.graphics.setFont(largeFont)
    love.graphics.printf('Food Rush!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter', 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1)
end