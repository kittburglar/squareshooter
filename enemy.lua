
enemy = {}

function enemy.load()

	enemy.x = 5
	enemy.y = 5
	enemy.xvel = 0
	enemy.yvel = 0
	enemy.friction = 7
	enemy.speed = 2250
	enemy.width = 40
	enemy.height = 40
	enemy.jump = 30
	enemy.inair = false
	enemy.jetpack = true

	--collusion
	--enemy = {}	
end



function enemy.spawn(x,y,dir,hp)
	enemy.b = love.physics.newBody(world,x,y,"dynamic")
	enemy.b:setMass(10)
	enemy.b:setGravityScale(0)
	enemy.s = love.physics.newRectangleShape(enemy.width,enemy.height)
	enemy.f = love.physics.newFixture(enemy.b,enemy.s)
	enemy.f:setUserData("Enemy" .. tostring(dir))
	table.insert(enemy, {hitpoints = hp, width = enemy.width, height = enemy.height,x = enemy.b:getX(), y = enemy.b:getY(), dir = dir, body = enemy.b, shape = enemy.s, fixture = enemy.f})
	
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
		--io.write("v.body:getX() is: " .. tostring(v.body:getX()) - player.b:getX()  .. "love.graphics.getWidth() is:" .. love.graphics.getWidth() .. "\n")
		--if ((v.body:getX() <= player.b:getX() - love.graphics.getWidth()/2) and (v.body:getY() <= player.b:getX() - love.graphics.getHeight()/2)) then
			love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
			love.graphics.rectangle('fill',v.body:getX()-25,v.body:getY()-25,v.width,v.height)
		--end
	end
end


function enemy.move(x,y)
	--enemy.b:applyForce(math.max(math.min(player.b:getX() - enemy.b:getX(),100), -100), math.max(math.min(player.b:getY() - enemy.b:getY(),100), -100))
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
end

function enemy.move(x,y)
	for i,v in ipairs(enemy) do
			--v.body:applyForce(math.max(math.min(player.b:getX() - v.body:getX(),100), -100), math.max(math.min(player.b:getY() - v.body:getY(),100), -100))
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