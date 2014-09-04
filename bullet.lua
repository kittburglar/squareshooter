bullet_speed = 5000
bullet = {}
ID = 0;
function bullet.spawn(x,y,dir)
	
	bullet.b = love.physics.newBody(world,x,y,"dynamic")
	bullet.b:setMass(100)
	bullet.b:setGravityScale(0)
	bullet.s = love.physics.newRectangleShape(10,10)
	bullet.f = love.physics.newFixture(bullet.b,bullet.s)
	bullet.f:setRestitution(0)
	bullet.f:setUserData("Bullet" .. tostring(ID))
	io.write("BulletID is: " .. tostring(ID) .. "\n");

	table.insert(bullet, {bulletID = tostring(ID); hitwall = false, width = 10, height = 10,x = bullet.b:getX(), y = bullet.b:getY(), dir = dir, body = bullet.b, shape = bullet.s, fixture = bullet.f})
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
			v.body:applyForce(0, -1000)
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
				table.remove(bullet, i)
			end
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
			print("up");
			bullet.spawn(player.b:getX(), player.b:getY() - player.height/2,'up');
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