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
	--love.graphics.setColor(225,0,0)
	--love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)

	--love.graphics.rectangle("fill", player.b:getX()-player.width/2, player.b:getY()-player.height/2,player.width,player.height)
	love.graphics.draw(player.image, player.b:getX(), player.b:getY(), player.b:getAngle(), 1, 1, player.width/2, player.height/2)

end




function player.move(dt)
		
		dy = (player.b:getY() + player.height/2) - love.mouse.getY()
  		dx = (player.b:getX() + player.width/2) - love.mouse.getX()
  		--angle = math.atan2(dy,dx) + math.pi
		--player.b:setAngle(angle)

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
        	player.b:applyForce (thrust_fx, thrust_fy)
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

function UPDATE_PLAYER(dt)
	--player.physics(dt)
    enemy.move();
	player.move(player.b:getX(),player.b:getY())
	player.boundary()
end

function DRAW_PLAYER()
	player.draw()
end