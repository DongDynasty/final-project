Burger = Class{__includes = BaseFood}

local burger_image = love.graphics.newImage('burger.png')

Burger_Spawnable = false
Burger_Timer = 0
Burger_Gravity = 70
Burger_Points = 1

function Burger:init()
    self.width = burger_image:getWidth()
    self.height = burger_image:getHeight()
    
    self.x = math.random(0, VIRTUAL_WIDTH - self.width)
    self.y = 0 - self.height
end

function Burger:update(dt)
    if self.y < VIRTUAL_HEIGHT then
        self.y = self.y + Burger_Gravity * dt
    else
        GAME_OVER = true
    end
end

function Burger:gravityIncrease()
    Burger_Gravity = Burger_Gravity + GRAVITY_INCREASE
end

function Burger:spawn(dt)
    Burger_Timer = Burger_Timer + dt

    if Burger_Timer > Burger_Spawner then
        Burger_Spawnable = true
        Burger_Spawner = math.random(2, 3)
    else
        Burger_Spawnable = false
    end

    return Burger_Spawnable
end

function Burger:resetTimer()
    Burger_Timer = 0
end

function Burger:getPoints()
    return Burger_Points
end

function Burger:render()
    love.graphics.draw(burger_image, self.x, self.y)
end