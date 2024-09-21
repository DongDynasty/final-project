Eater = Class{}

local EATER_IMAGE = love.graphics.newImage('eater.png')

function Eater:init()
    self.width = EATER_IMAGE:getWidth()
    self.height = EATER_IMAGE:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = (VIRTUAL_HEIGHT / 2 - (self.height / 2)) + 120
    self.dy = 0
    self.dx = 0
end

function Eater:update(dt)
    if love.keyboard.isDown('a') then
        self.dx = -EATER_SPEED
    elseif love.keyboard.isDown('d') then
        self.dx = EATER_SPEED
    else
        self.dx = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Eater:eats(food)
    if (self.x + 4) + (self.width - 8) >= food.x and (self.x + 4) < food.x + food.width then
        if (self.y + self.height) + 40 >= food.y and self.y + 40 < food.y + food.height then
            return true
        end
    end

    return false
end

function Eater:render()
    love.graphics.draw(EATER_IMAGE, self.x, self.y)
end