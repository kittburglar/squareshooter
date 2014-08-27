
enemy = {}

function enemy.load()

	enemy.x = 5
	enemy.y = 5
	enemy.xvel = 0
	enemy.yvel = 0
	enemy.friction = 7
	enemy.speed = 2250
	enemy.width = 50
	enemy.height = 50
	enemy.jump = 30
	enemy.inair = false
	enemy.jetpack = true

	--collusion
	--enemy = {}
		enemy.b = love.physics.newBody(world,maxBorderX/2,maxBorderY/2,"dynamic")
		--enemy.b:setMass(10)
		enemy.s = love.physics.newRectangleShape(-25,-25,50,50,0)
		enemy.f = love.physics.newFixture(enemy.b,enemy.s)
		--enemy.b:setMass(10)
		enemy.f:setRestitution(0.4)
		enemy.f:setUserData("Enemy")
		enemy.b:setInertia(0)
end

function enemy.spawn(x,y,dir)
	enemy.b = love.physics.newBody(world,maxBorderX/2,maxBorderY/2,"dynamic")
	enemy.b:setMass(10)
	enemy.b:setGravityScale(0)
	enemy.s = love.physics.newRectangleShape(-25,-25,50,50,0)
	enemy.f = love.physics.newFixture(enemy.b,enemy.s)
	enemy.f:setRestitution(0)
	enemy.f:setUserData("Enemy" .. tostring(dir))
	table.insert(enemy, {width = 50, height = 50,x = x, y = y, dir = dir, body = enemy.b, shape = enemy.s, fixture = enemy.f})
	
end
--[[
function enemy.draw()
	love.graphics.setColor(0,0,255)
	--love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.width, enemy.height)
	love.graphics.rectangle("fill", enemy.b:getX()-25,enemy.b:getY()-25,enemy.width,enemy.height)
end
]]
function enemy.draw()
	for i,v in ipairs(enemy) do
		
		love.graphics.setColor(0,0,255)
		love.graphics.rectangle('fill',v.body:getX(),v.body:getY(),v.width,v.height)
	end
end


--function enemy.move(x,y)
--	enemy.b:applyForce(math.max(math.min(player.b:getX() - enemy.b:getX(),100), -100), math.max(math.min(player.b:getY() - enemy.b:getY(),100), -100))
    --[[
	if love.keyboard.isDown('l') then
			enemy.b:applyForce(1000,0)
		end

		--left
		if love.keyboard.isDown('j') then
			enemy.b:applyForce(-1000,0)
		end
		
		--down
		if love.keyboard.isDown('k') then
			enemy.b:applyForce(0,1000)
		end

		--up
		if love.keyboard.isDown('i') then
			enemy.b:applyForce(0,-1000)
		end
		]]
--end

function enemy.move(x,y)
	for i,v in ipairs(enemy) do
		--if v.dir == 'up' then
			--v.body:applyForce(0, -1000)
			v.body:applyForce(math.max(math.min(player.b:getX() - v.body:getX(),100), -100), math.max(math.min(player.b:getY() - v.body:getY(),100), -100))
		--end
		
	end
end


function enemy.boundary()
	if enemy.x < 0 then
		enemy.x = 0
		enemy.xvel = 0
	end
	if enemy.y + enemy.height > groundlevel then
		enemy.y = groundlevel - enemy.height
		enemy.yvel = 0
	end
end

function UPDATE_ENEMY(dt)

	--enemy.spawn()
	enemy.move(dt)
	enemy.boundary()
end

function DRAW_ENEMY()
	enemy.draw()
end