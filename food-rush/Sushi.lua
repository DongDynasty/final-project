Sushi = Class{__includes = BaseFood}

local sushi_image = love.graphics.newImage('sushi.png')

Sushi_Spawnable = false
Sushi_Timer = 0
Sushi_Gravity = 100
Sushi_Points = 2

function Sushi:init()
    self.width = sushi_image:getWidth()
    self.height = sushi_image:getHeight()
    
    self.x = math.random(0, VIRTUAL_WIDTH - self.width)
    self.y = 0 - self.height
end

function Sushi:update(dt)
    if self.y < VIRTUAL_HEIGHT then
        self.y = self.y + Sushi_Gravity * dt
    else
        GAME_OVER = true
    end
end

function Sushi:gravityIncrease()
    Sushi_Gravity = Sushi_Gravity + GRAVITY_INCREASE
end

function Sushi:spawn(dt)
    Sushi_Timer = Sushi_Timer + dt

    if Sushi_Timer > Sushi_Spawner then
        Sushi_Spawnable = true
        Sushi_Spawner = math.random(9, 13)
    else
        Sushi_Spawnable = false
    end

    return Sushi_Spawnable
end

function Sushi:resetTimer()
    Sushi_Timer = 0
end

function Sushi:getPoints()
    return Sushi_Points
end

function Sushi:render()
    love.graphics.draw(sushi_image, self.x, self.y)
end