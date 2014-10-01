bullet_speed = 2000
bullet = {}
ID = 0;
function bullet.spawn(x,y,dir,size)
	
	bullet.b = love.physics.newBody(world,x,y,"dynamic")
	bullet.b:setInertia(1000)
	bullet.b:setGravityScale(0)
	bullet.s = love.physics.newRectangleShape(size,size)
	bullet.f = love.physics.newFixture(bullet.b,bullet.s)
	bullet.f:setRestitution(0)
	bullet.f:setUserData("Bullet" .. tostring(ID))
	io.write("BulletID is: " .. tostring(ID) .. "\n");

	table.insert(bullet, {bulletID = tostring(ID); hitwall = false, width = size, height = size,x = bullet.b:getX(), y = bullet.b:getY(), dir = dir, body = bullet.b, shape = bullet.s, fixture = bullet.f})
	ID = ID + 1;
	end

function bullet.draw()
	for i,v in ipairs(bullet) do
		love.graphics.setColor(0,255,0)
		love.graphics.rectangle('fill',v.body:getX()-5,v.body:getY()-5,v.width,v.height)

	end
end



function bullet.update(dt)
	for i,v in ipairs(bullet) do
		if v.dir == 'up' then
			--v.body:applyForce(0, -1000)
			local thrust_fx = math.sin(player.b:getAngle()) *  bullet_speed
        	local thrust_fy = -math.cos(player.b:getAngle()) *  bullet_speed
        	v.body:applyForce (-thrust_fx, -thrust_fy)
		end
		if v.dir == 'right' then
			v.body:applyForce(1000, 0)
		end
		if v.dir == 'down' then
			v.body:applyForce(0, 1000)
		end
		if v.dir == 'left' then
			v.body:applyForce(-1000, 0)
		end
	end
end
 
function destroyBullet(id) 

	io.write("destorying bullet" .. id .. "\n");
	for i,v in ipairs(bullet) do
		io.write("id is: " .. id .. " v.bulletID is: " .. v.bulletID .. "\n")
		if id == v.bulletID then
			v.body:destroy()
			table.remove(bullet, i)
		end
	end
end


function bullet.shoot2(key)
	if (((math.deg(angle) > 45) and (math.deg(angle) < 135))) then
		print("down")
		print(angle)
		bullet.spawn(player.b:getX(),player.b:getY() + player.height/2,'down_mouse');
	
	elseif (((math.deg(angle) > 135) and (math.deg(angle) < 225))) then
		print("left")
		print(angle)
		bullet.spawn(player.b:getX() - player.width/2, player.b:getY(),'left_mouse');


	elseif (((math.deg(angle) > 225) and (math.deg(angle) < 315))) then
		print("up")
		print(angle)
		bullet.spawn(player.b:getX(), player.b:getY() - player.height/2,'up_mouse');	

	elseif (((math.deg(angle) > 0) and (math.deg(angle) < 45))) then
		print("right")
		print(angle)
		bullet.spawn(player.b:getX() + player.width/2,player.b:getY(),'right_mouse');
	
	elseif (((math.deg(angle) > 315) and (math.deg(angle) < 360))) then
		print("right")
		print(angle)
		bullet.spawn(player.b:getX() + player.width/2,player.b:getY(),'right_mouse');	
	end
end

	function bullet.shoot(key)
	--[[
	if (((math.deg(angle) > 45) and (math.deg(angle) < 135))) then
		--print("down")
		--print(angle)
		bullet.spawn(player.b:getX() + player.width/2 , player.b:getY() + player.height,'l', angle)	
	
	elseif (((math.deg(angle) > 135) and (math.deg(angle) < 225))) then
		print("left")
		print(angle)
		bullet.spawn(player.b:getX(), player.b:getY() + player.height/2,'l', angle)	


	elseif (((math.deg(angle) > 225) and (math.deg(angle) < 315))) then
		print("up")
		print(angle)
		bullet.spawn(player.b:getX() + player.width/2, player.b:getY(),'l', angle)	

	elseif (((math.deg(angle) > 0) and (math.deg(angle) < 45))) then
		print("right")
		print(angle)
		bullet.spawn(player.b:getX() + player.width, player.b:getY() + player.height/2 + (math.deg(angle))/1.8,'l', angle)	
	
	elseif (((math.deg(angle) > 315) and (math.deg(angle) < 360))) then
		print("right")
		print(angle)
		bullet.spawn(player.b:getX() + player.width, player.b:getY() + player.height/2 + (math.deg(angle))/1.8,'l', angle)	
	end
	]]
	
	if (key == "up") then
		bulletX = player.b:getX()
		bulletY = player.b:getY()

		print("up");
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


		bullet.spawn(bulletX, bulletY,'up',8);
		--bullet.spawn2();
	elseif (key == "right") then
		print("right");
		bullet.spawn(player.b:getX() + player.width/2,player.b:getY(),'right');
	elseif (key == "down") then
		print("down");
		bullet.spawn(player.b:getX(),player.b:getY() + player.height/2,'down');
	elseif (key == "left") then
		print("left");	
		bullet.spawn(player.b:getX() - player.width/2, player.b:getY(),'left');
	end
	
end