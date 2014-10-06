require "enemy"
require "conf"

player = {}

function player.load()

	player.x = maxBorderX/2- 200
	player.y = maxBorderY/2 - 200
	player.width = 32
	player.height = 32
	player.health = 10
	player.speed = 200
	player.score = 0
	player.boost = 1000
	--collusion
	--player = {}
	player.b = love.physics.newBody(world,player.x,player.y,"dynamic")
	player.b:setMass(10)
	player.b:setGravityScale(0)
	player.s = love.physics.newRectangleShape(player.width,player.height)
	
	player.f = love.physics.newFixture(player.b,player.s)
	player.f:setRestitution(0)
	player.f:setUserData("Player")
	player.image = love.graphics.newImage("resources/images/ship.png")
	player.b:setAngle(0)


end

function player.draw()
	--love.graphics.rectangle('fill',player.b:getX()-player.width/2,player.b:getY()-player.width/2,player.width,player.height)
	
	love.graphics.draw(player.image, player.b:getX(), player.b:getY(), player.b:getAngle(), 1, 1, player.width/2, player.height/2)
end




function player.move(dt)
		if love.keyboard.isDown('d') then
			player.b:setAngle(player.b:getAngle() + 0.1)
			
		end

		--left
		if love.keyboard.isDown('a') then
			player.b:setAngle(player.b:getAngle() - 0.1)
		end
		
		--down
		if love.keyboard.isDown('s') then
			--player.b:applyForce(0,player.speed)
			local thrust_fx = -math.sin(player.b:getAngle()) *  player.speed
        	local thrust_fy = math.cos(player.b:getAngle()) *  player.speed
        	player.b:applyForce (-thrust_fx, -thrust_fy)
		end

		--up
		if love.keyboard.isDown('w') then
			
			--player.b:applyForce(0,-player.speed)
			local thrust_fx = -math.sin(player.b:getAngle()) *  player.speed
        	local thrust_fy = math.cos(player.b:getAngle()) *  player.speed
        	animation.start(player.b:getX(), player.b:getY(), "boost", math.random(3,6), math.random(0,10), 1)
			
        	player.b:applyForce (thrust_fx, thrust_fy)
		end
		if love.keyboard.isDown(' ') then
			
			--player.b:applyForce(0,-player.speed)

			animation.start(player.b:getX(), player.b:getY(), "boost", math.random(3,6), math.random(0,10), 1)
			local thrust_fx = -math.sin(player.b:getAngle()) *  player.boost
        	local thrust_fy = math.cos(player.b:getAngle()) *  player.boost
        	player.b:applyForce (thrust_fx , thrust_fy)
		end
		if player.b:getAngularVelocity() > 0 then
			player.b:setAngularVelocity(player.b:getAngularVelocity() - 0.03)
		elseif player.b:getAngularVelocity() < 0 then
			player.b:setAngularVelocity(player.b:getAngularVelocity() + 0.03)
		end

end

function player.boundary()
	if player.x < 0 then
		player.x = 0
	end
	if player.y + player.height > groundlevel then
		player.y = groundlevel - player.height
	end
end

function player.super()
--SHOOT
        	bulletX = player.b:getX()
			bulletY = player.b:getY()

			print(tostring(player.b:getAngle()));
			--translate to origin
			bulletX = bulletX - player.b:getX()
			bulletY = bulletY - player.b:getY()

			--rotate
			bulletX = bulletX * math.cos(player.b:getAngle()) - bulletY * math.sin(player.b:getAngle())
			bulletY = bulletY * math.cos(player.b:getAngle()) + bulletX * math.sin(player.b:getAngle())

			--translate back
			bulletX = bulletX + player.b:getX()
			bulletY = bulletY + player.b:getY()

			local thrust_fx = -math.sin(player.b:getAngle()) *  30
	        local thrust_fy = math.cos(player.b:getAngle()) *  30

	       	bulletX = bulletX + thrust_fx
	       	bulletY = bulletY + thrust_fy


			bullet.spawn(bulletX, bulletY,'up', 5);	
end

function UPDATE_PLAYER(dt)
	
	--player.super()
    enemy.move();
	player.move(player.b:getX(),player.b:getY())
	player.boundary()
end

function DRAW_PLAYER()
	player.draw()
end


function player.upscore(x)
	player.score = player.score + x
end