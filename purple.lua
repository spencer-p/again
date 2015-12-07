Purple = {}

function Purple:new()
	local object = { src = { path = "assets/purple.png", size = 8 } }
	self.__index = self
	return setmetatable(object, self)
end

function Purple:init()

	-- load the sprite sheet
	self.spritesheet = love.graphics.newImage(self.src.path)
	self.spritesheet:setFilter('nearest', 'nearest')

	-- set up the frames
	self.still = love.graphics.newQuad(0, 0, self.src.size, self.src.size, 3*self.src.size, self.src.size)
	self.stepLeft = love.graphics.newQuad(self.src.size, 0, self.src.size, self.src.size, 3*self.src.size, self.src.size)
	self.stepRight = love.graphics.newQuad(2*self.src.size, 0, self.src.size, self.src.size, 3*self.src.size, self.src.size)
	self.current = self.still

	-- player's metadata
	self.facing = "right"
	self.pos = { x = love.graphics.getWidth()/(2*scale)-(self.src.size/2), y = love.graphics.getHeight()/(2*scale)-(self.src.size/2) }
	self.velocity = { x = 0, y = 0 }
	self.speed = 1

end

function Purple:draw()

	-- scale -1 on x axis if facing left
	if self.facing == "right" then
		love.graphics.draw(self.spritesheet, self.current, math.floor(self.pos.x), math.floor(self.pos.y))
	else
		love.graphics.draw(self.spritesheet, self.current, math.floor(self.pos.x)+self.src.size, math.floor(self.pos.y), 0, -1, 1)
	end

end

function Purple:update(dt)

	-- input checks for movement

	-- UP
	if love.keyboard.isDown('up') then
		self.pos.y = self.pos.y - self.speed
		if self.pos.y < 0 then
			self.pos.y = 0
		end
	end

	-- DOWN
	if love.keyboard.isDown('down') then
		self.pos.y = self.pos.y + self.speed % (love.graphics.getHeight()/scale-self.src.size)
	end

	-- LEFT
	if love.keyboard.isDown('left') then
		self.pos.x = self.pos.x - self.speed
		if self.pos.x < 0 then
			self.pos.x = 0
		end
	end

	-- RIGHT
	if love.keyboard.isDown('right') then
		self.pos.x = self.pos.x + self.speed % (love.graphics.getWidth()/scale-self.src.size)
	end


	-- decide which leg will be out
	counter = (counter + 120 * dt) % 120 -- twice a second i think

	if love.keyboard.isDown('up') or love.keyboard.isDown('down') or love.keyboard.isDown('left') or love.keyboard.isDown('right') then
		if math.floor(counter/15) % 2 == 0 then
			self.current = self.stepLeft
		else
			self.current = self.stepRight
		end
	else
		self.current = self.still
	end

end

function Purple:keypressed(key)
	if key == 'left' or key == 'right' then
		self.facing = key
	elseif key == 'lshift' then
		self.speed = 2
	end
end

function Purple:keyreleased(key)
	if key == self.facing and (love.keyboard.isDown('left') or love.keyboard.isDown('right')) then
		if key == 'left' then
			self.facing = 'right'
		else
			self.facing = 'left'
		end
	elseif key == 'lshift' then
		self.speed = 1
	end
end
