PlayState = Class{__includes = BaseState}

EATER_SPEED = 350
GRAVITY_INCREASE = 40

function PlayState:init()
    self.eater = Eater()
    self.foods = {}
    self.score = 0
end

function PlayState:enter()
    sounds['start']:play()
    GAME_OVER = false
    ELAPSED_TIME = 0
    THRESHOLD = 16
end

FOOD_TYPES = {Burger, Sushi, Cake}

function PlayState:update(dt)
    ELAPSED_TIME = ELAPSED_TIME + dt

    for _, food_type in pairs(FOOD_TYPES) do
        if food_type:spawn(dt) then
            table.insert(self.foods, food_type())
            food_type:resetTimer()
        end
    end

    for _, food in pairs(self.foods) do
        food:update(dt)
    end

    for i, food in pairs(self.foods) do
        if self.eater:eats(food) then
            self.score = self.score + food:getPoints()
            sounds['eat']:play()
            table.remove(self.foods, i)
        end
    end

    if ELAPSED_TIME >= THRESHOLD then
        PlayState:gravityIncrease()
        THRESHOLD = THRESHOLD + 10
    end

    self.eater:update(dt)

    if GAME_OVER then
        for i, food in pairs(self.foods) do
            table.remove(self.foods, i)
        end

        sounds['over']:play()

        gStateMachine:change('score', {
            score = self.score
        })
    end
end

function PlayState:gravityIncrease()
    for _, foods in pairs(FOOD_TYPES) do
        foods:gravityIncrease()
    end
end


function PlayState:render()
    self.eater:render()

    for _, food in pairs(self.foods) do
        food:render()
    end

    love.graphics.setFont(largeFont)
    love.graphics.print('Score: ' .. tostring(self.score), (VIRTUAL_WIDTH - 140), 8)
    love.graphics.print('Time: ' .. math.floor(ELAPSED_TIME), (VIRTUAL_WIDTH - 140), 48)
end

function PlayState:exit()
    -- stop scrolling for the death/score screen
    GAME_OVER = true
end