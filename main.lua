function love.load()
	scale = 5
	purple = { spritesheet = love.graphics.newImage("purple.png") }
	purple.spritesheet:setFilter('nearest', 'nearest')
	purple.still = love.graphics.newQuad(0, 0, 8, 8, 24, 8)
	purple.stepLeft = love.graphics.newQuad(8, 0, 8, 8, 24, 8)
	purple.stepRight = love.graphics.newQuad(16, 0, 8, 8, 24, 8)
	purple.current = purple.still
	purple.facing = 'right'
	love.graphics.setBackgroundColor(32, 32, 32)
	position = { x = love.graphics.getWidth()/(2*scale)-4, y = love.graphics.getHeight()/(2*scale)-4 }
	velocity = { x = 0, y = 0 }
	speed = 1
	speedMultiplier = 1
	counter = 0
	tick = 0
end

function love.focus(f) running = f end

function love.draw()
	love.graphics.print(math.floor(counter).." "..love.timer.getFPS().."\n"..position.x..", "..position.y, 0, 0)
	love.graphics.scale(scale)
	if purple.facing == 'right' then
		love.graphics.draw(purple.spritesheet, purple.current, math.floor(position.x), math.floor(position.y))
	else
		love.graphics.draw(purple.spritesheet, purple.current, math.floor(position.x+8), math.floor(position.y), 0, -1, 1)
	end
end

function love.update(dt)

	if not running then return end

	tick = tick + 1
	if tick < 2 then return end
	tick = 0

	counter = (counter + 120 * dt) % 120

	if love.keyboard.isDown('up') then
		position.y = position.y - speed*speedMultiplier
		if position.y < 0 then
			position.y = 0
		end
	end
	if love.keyboard.isDown('down') then
		position.y = position.y + speed*speedMultiplier
		if position.y > love.graphics.getHeight()/scale-8 then
			position.y = love.graphics.getHeight()/scale-8
		end
	end
	if love.keyboard.isDown('left') then
		position.x = position.x - speed*speedMultiplier
		if position.x < 0 then
			position.x = 0
		end
	end
	if love.keyboard.isDown('right') then
		position.x = position.x + speed*speedMultiplier
		if position.x > love.graphics.getWidth()/scale-8 then
			position.x = love.graphics.getWidth()/scale-8
		end
	end

	if love.keyboard.isDown('up') or love.keyboard.isDown('down') or love.keyboard.isDown('left') or love.keyboard.isDown('right') then
		if math.floor(counter/15) % 2 == 0 then
			purple.current = purple.stepLeft
		else
			purple.current = purple.stepRight
		end
	else
		purple.current = purple.still
	end

end

function love.keypressed(key)
	if key == 'left' or key == 'right' then
		purple.facing = key
	end
	if key == 'escape' then
		love.event.push('quit')
	end
	if key == ' ' then
		running = not running
	end
	if key == 'lshift' then
		speedMultiplier = 2
	end
end

function love.keyreleased(key)
	if key == purple.facing and (love.keyboard.isDown('left') or love.keyboard.isDown('right')) then
		if key == 'left' then
			purple.facing = 'right'
		else
			purple.facing = 'left'
		end
	elseif key == 'lshift' then
		speedMultiplier = 1
	end
end
