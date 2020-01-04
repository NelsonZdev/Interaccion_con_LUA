push = require 'push'

WINDOWS_WIDTH = 800
WINDOWS_HEIGTH = 600

VIRTUAL_WIDTH = 400
VIRTUAL_HEIGTH = 200

PADDLE_SPEED = 200

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')

    smallFont = love.graphics.newFont('pixelart.ttf',8)

    scoreFont = love.graphics.newFont('pixelart.ttf',32)

    math.randomseed(os.time())

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGTH,WINDOWS_WIDTH,WINDOWS_HEIGTH,{
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    --Clear Score
    player1Score = 0
    player2Score = 0
    --Player position
    player1Y = 30
    player2Y = VIRTUAL_HEIGTH - 50
    --
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGTH / 2 - 2 

    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50,50)

    gameState = 'start'

end

function love.update(dt)

    if love.keyboard.isDown('w') then
        player1Y = math.max(0,player1Y + -PADDLE_SPEED * dt)

    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGTH - 20,player1Y + PADDLE_SPEED * dt)

    end

    if love.keyboard.isDown('up') then
        player2Y = math.max(0,player2Y + -PADDLE_SPEED * dt)

    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGTH - 20, player2Y + PADDLE_SPEED * dt)

    end

    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGTH / 2 - 2

            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50,50) * 1.5
        end
    end     

end
function love.draw()

    push:apply('start')

    love.graphics.clear(40,45,52,0)

    love.graphics.setFont(smallFont)

    love.graphics.printf('Hello Pong!',0,20,VIRTUAL_WIDTH,'center')

    love.graphics.setFont(scoreFont)
    --Players Score
    love.graphics.print(tostring(player1Score),VIRTUAL_WIDTH / 2 -50, VIRTUAL_HEIGTH / 3)

    love.graphics.print(tostring(player2Score),VIRTUAL_WIDTH / 2 +30, VIRTUAL_HEIGTH / 3)
    --Draw Zone
    love.graphics.rectangle('fill',10,player1Y,5,20)

    love.graphics.rectangle('fill',VIRTUAL_WIDTH - 10 ,player2Y,5,20)

    love.graphics.rectangle('fill',ballX,ballY ,4,4)

    push:apply('end')
end