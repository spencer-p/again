
function love.load()
	purple = { spritesheet = love.graphics.newImage("purple.png") }
	purple.spritesheet:setFilter('nearest', 'nearest')
	purple.still = love.graphics.newQuad(0, 0, 8, 8, 24, 8);
	purple.stepLeft = love.graphics.newQuad(8, 0, 8, 8, 24, 8);
	purple.stepRight = love.graphics.newQuad(16, 0, 8, 8, 24, 8);
	purple.current = purple.still;
	purple.facing = 'right'
	purple.scale = 10
	love.graphics.setBackgroundColor(32, 32, 32)
	position = { x = 400-(4*purple.scale), y = 300-(4*purple.scale) }
	velocity = { x = 0, y = 0 }
	speed = 5;
	counter = 0;
end

function love.focus(f) running = f end

function love.draw()
	love.graphics.print(counter.."\n"..position.x..", "..position.y, 0, 0);
	if purple.facing == 'right' then
		love.graphics.draw(purple.spritesheet, purple.current, position.x, position.y, 0, purple.scale, purple.scale, 0, 0, 0, 0);
	else
		love.graphics.draw(purple.spritesheet, purple.current, position.x+(8*purple.scale), position.y, 0, -purple.scale, purple.scale, 0, 0, 0, 0);
	end
end

function love.update(dt)

	if not running then return end

	counter = (counter + 4 * dt) % 4

	if love.keyboard.isDown('up') then
		position.y = position.y + -speed
		if position.y < 0 then
			position.y = 0
		end
	end
	if love.keyboard.isDown('down') then
		position.y = position.y + speed
		if position.y > 600-(8*purple.scale) then
			position.y = 600-(8*purple.scale)
		end
	end
	if love.keyboard.isDown('left') then
		position.x = position.x + -speed
		if position.x < 0 then
			position.x = 0
		end
	end
	if love.keyboard.isDown('right') then
		position.x = position.x + speed
		if position.x > 800-(8*purple.scale) then
			position.x = 800-(8*purple.scale)
		end
	end

	if love.keyboard.isDown('up') or love.keyboard.isDown('down') or love.keyboard.isDown('left') or love.keyboard.isDown('right') then
		if math.floor(counter) % 2 == 0 then
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
	if key == ' ' then
		if purple.facing == 'left' then
			purple.facing = 'right'
		else
			purple.facing = 'left'
		end
	end
	if key == 'escape' then
		love.event.push('quit')
	end
end

function love.keyreleased(key)
end
