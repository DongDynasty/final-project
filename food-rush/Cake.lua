Cake = Class{__includes = BaseFood}

local cake_image = love.graphics.newImage('cake.png')

Cake_Spawnable = false
Cake_Timer = 0
Cake_Gravity = 150
Cake_Points = 5

function Cake:init()
    self.width = cake_image:getWidth()
    self.height = cake_image:getHeight()
   
    self.x = math.random(0, VIRTUAL_WIDTH - self.width)
    self.y = 0 - self.height
end

function Cake:update(dt)
    if self.y < VIRTUAL_HEIGHT then
        self.y = self.y + Cake_Gravity * dt
    else
        GAME_OVER = true
    end
end

function Cake:gravityIncrease()
    Cake_Gravity = Cake_Gravity + GRAVITY_INCREASE
end

function Cake:spawn(dt)
    Cake_Timer = Cake_Timer + dt

    if Cake_Timer > Cake_Spawner then
        Cake_Spawnable = true
        Cake_Spawner = math.random(12, 20)
    else
        Cake_Spawnable = false
    end

    return Cake_Spawnable
end

function Cake:resetTimer()
    Cake_Timer = 0
end

function Cake:getPoints()
    return Cake_Points
end

function Cake:render()
    love.graphics.draw(cake_image, self.x, self.y)
end