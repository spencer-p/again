require('purple')

function love.load()
	scale = 5
	love.graphics.setBackgroundColor(32, 32, 32)
	player = Purple:new()
	player:init(love.graphics.getWidth()/scale, love.graphics.getHeight()/scale)
	tick = 0
end

function love.focus(f) running = f end

function love.draw()
	love.graphics.print(love.timer.getFPS(), 0, 0)
	love.graphics.scale(scale)
	player:draw()
end

function love.update(dt)

	if not running then return end

	tick = tick + 1
	if tick < 2 then return end
	tick = 0

	player:update(dt, love.graphics.getWidth()/scale, love.graphics.getHeight()/scale)

end

function love.keypressed(key)

	player:keypressed(key)

	if key == 'escape' then
		love.event.push('quit')
	end
	if key == ' ' then
		running = not running
	end

end

function love.keyreleased(key)
	player:keyreleased(key)
end
