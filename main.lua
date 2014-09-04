	require "player"
	require "camera"
	require "bullet"
	require "enemy"
	require "level1"
	require "conf"
	require "border"

	bounds1 = {}
	paused = false
	function love.load()
		require("loveframes")
		xStar = {}    -- new array
		yStar = {}
		progressbar = loveframes.Create("progressbar", frame)
		progressbar2 = loveframes.Create("progressbar", frame)
		progressbar3 = loveframes.Create("progressbar", frame)

		fillStarArray()
		backgroundRendered = false;
		createUIElements()

		world = love.physics.newWorld(0, 0, 0,0,0,0,false)  --Gravity is being set to 0 in the x direction and 200 in the y direction.
        --These callback function names can be almost any you want:
		world:setCallbacks(beginContact, endContact, preSolve, postSolve)
        
	        
			
		border.load()
		player.load()
		enemy.load()
		--test
		level1.load()
	end

	function updateUI()

		
		--love.graphics.setColor(255,255,220)
		--love.graphics.rectangle("line", 0, love.graphics.getHeight() - 200, love.graphics.getWidth(), 200)
		progressbar:SetValue(player.health, progressbar:GetMax())
	end

	function createUIElements()
		local image = loveframes.Create("image", frame)
		image:SetImage("resources/images/kitty.jpg")
		image:SetPos(5, love.graphics.getHeight() - 200 + 5)

		love.graphics.setColor(0, 255, 0, 255)
    	love.graphics.print("This is a pretty lame example.", 5 + 96 + 5, love.graphics.getHeight() - 200 + 5)

		
		progressbar:SetPos(5 + 96 + 5, love.graphics.getHeight() - 200 + 5 + 139 - (3  *25) - 10)
		progressbar:SetWidth(150)
		progressbar:SetLerpRate(10)

		


		
		progressbar2:SetPos(5 + 96 + 5, love.graphics.getHeight() - 200 + 5 + 139 - (2 * 25) - 5)
		progressbar2:SetWidth(150)
		progressbar2:SetLerpRate(10)
		
		
		progressbar3:SetPos(5 + 96 + 5, love.graphics.getHeight() - 200 + 5 + 139 - 25)
		progressbar3:SetWidth(150)
		progressbar3:SetLerpRate(10)


	end

	function beginContact(a, b, coll)
		if(a:getUserData():sub(0,6) == "Bullet") and (b:getUserData() == "Bounds") then
			--io.write("BulletID is: " .. a:getUserData():sub(7,100) .. "\n")
			destroyBullet(a:getUserData():sub(7,100)) 
		end
		if(b:getUserData():sub(0,6) == "Bullet") and (a:getUserData() == "Bounds") then
			--io.write("BulletID is: " .. b:getUserData():sub(7,100) .. "\n")
			
			destroyBullet(b:getUserData():sub(7,100)) 
		end
		--BULLET AND ENEMY COLLISION
		if((a:getUserData() == "Bullet") and (b:getUserData():sub(0,5) == "Enemy")) then
			print("Bullet collided with enemy")
			for i,v in ipairs(enemy) do
				--io.write("b:getUserData():sub(6,7) is: " .. tostring(b:getUserData():sub(6,7)) .. " and v.dir is: " .. tostring(v.dir) .. "\n")
				if (b:getUserData():sub(6,7) == tostring(v.dir)) then
					if (tonumber(v.hitpoints) == 0) then 
						io.write("hitpoint is: " .. v.hitpoints .. "\n")
						io.write("remove at position: " .. tostring(i) .. "\n")
						b:destroy()
						--a:destroy()
						table.remove(enemy, i)

						if (table.maxn(enemy) == 0) then
							endLevel()
						end
					else
						print("Removing 1 hitpoint")
						v.hitpoints = v.hitpoints - 1
					end
				end
			end
		end
		if((b:getUserData() == "Bullet") and (a:getUserData():sub(0,5) == "Enemy")) then
			print("Bullet collided with enemy 2")
			for i,v in ipairs(enemy) do
				--io.write("a:getUserData():sub(6,7) is: " .. a:getUserData():sub(6,7) .. " and v.dir is: " .. tostring(v.dir) .. "\n" )
				--io.write(a:getUserData())
				if (a:getUserData():sub(6,7) == tostring(v.dir)) then
					if (tonumber(v.hitpoints) == 0) then 
						io.write("hitpoint is: " .. v.hitpoints .. "\n")
						io.write("remove at position: " .. tostring(i) .. "\n")
						a:destroy()
						--b:destroy()
						table.remove(enemy, i)
						if (table.maxn(enemy) == 0) then
							endLevel()
						end
					else
						print("Removing 1 hitpoint")
						v.hitpoints = v.hitpoints - 1
					end

				end
			end
		end
		if((a:getUserData() == "Player") and (b:getUserData():sub(0,5) == "Enemy")) then
			print("Player collided with Enemy")
			for i,v in ipairs(enemy) do
				--io.write("b:getUserData():sub(6,7) is: " .. tostring(b:getUserData():sub(6,7)) .. " and v.dir is: " .. tostring(v.dir) .. "\n")
				if (b:getUserData():sub(6,7) == tostring(v.dir)) then
					player.health = player.health - 1
					progressbar:SetValue(player.health, progressbar:GetMax())
					if (tonumber(player.health) == 0) then
						endLevel()
					end
					if (tonumber(v.hitpoints) == 0) then 
						io.write("hitpoint is: " .. v.hitpoints .. "\n")
						io.write("remove at position: " .. tostring(i) .. "\n")
						b:destroy()
						table.remove(enemy, i)
						if (table.maxn(enemy) == 0) then
							endLevel()
						end
					else
						print("Removing 1 hitpoint")
						v.hitpoints = v.hitpoints - 1
					end
				end
			end
		end
		if((b:getUserData() == "Player") and (a:getUserData():sub(0,5) == "Enemy")) then
			print("Player collided with Enemy 2")
			for i,v in ipairs(enemy) do
				--io.write("a:getUserData():sub(6,7) is: " .. a:getUserData():sub(6,7) .. " and v.dir is: " .. tostring(v.dir) .. "\n" )
				--io.write(a:getUserData())

				if (a:getUserData():sub(6,7) == tostring(v.dir)) then
					player.health = player.health - 1
					progressbar:SetValue(player.health, progressbar:GetMax())
					if (tonumber(player.health) == 0) then
						endLevel()
					end
					if (tonumber(v.hitpoints) == 0) then 
						io.write("hitpoint is: " .. v.hitpoints .. "\n")
						io.write("remove at position: " .. tostring(i) .. "\n")
						a:destroy()
						table.remove(enemy, i)
						if (table.maxn(enemy) == 0) then
							endLevel()
						end
					else
						print("Removing 1 hitpoint")
						v.hitpoints = v.hitpoints - 1
					end

				end
			end
		end

	end

	function endContact(a, b, coll)
		
	    --print('end contact')
	    
	end

	function preSolve(a, b, coll)
	    --print('preSolve')
	end

	function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
	    --print('postSolve')
	end

	function love.mousepressed(x, y, button)
		--[[]
		if button  == "l" then
	  		dy = (player.b:getY() + player.height/2) - (y + camera.y)
	  		dx = (player.b:getX() + player.width/2) - (x + camera.x)
	  		angle = math.atan2(dy,dx) + math.pi
	  		bullet.shoot(angle)
	  		print(math.deg(angle))
		end
		]]
	end

	function love.update(dt)
		if paused then return end
		world:update(dt)
		UPDATE_PLAYER(dt)
		UPDATE_ENEMY(dt)
		bullet.update(dt)
		if player.b:getX() > love.graphics.getWidth() / 2 then
			camera.x = player.b:getX() - love.graphics.getWidth() / 2
		end
		if player.b:getY() > love.graphics.getWidth() / 2 then
			camera.y = player.b:getY() - (love.graphics.getHeight() - 50) / 2
		end
		loveframes.update(dt)
	end

	function love.keypressed(key)
		if key == "p" then
			io.write("pause button pressed\n");
			paused = not paused
		elseif (not paused) then
			bullet.shoot(key)
		end
	end

	function love.draw()

		camera:set()
		renderBackground()
		border.draw()
		DRAW_PLAYER()
		DRAW_ENEMY()
		bullet.draw()
		camera:unset()
		updateUI()
		loveframes.draw()
	
	end

	function fillStarArray()
		
	    for i=1, numberofStars do
	      xStar[i] = math.random(0,maxBorderX)
	      yStar[i] = math.random(0,maxBorderY) 
	    end
	end

	

	function renderBackground()
		
		for i = 1, numberofStars/2 do
			love.graphics.setColor(255,255,220)
			love.graphics.rectangle("fill", xStar[i], yStar[i], math.random(5,7), math.random(5,7))
		end
		for j = numberofStars/2, numberofStars do
			love.graphics.setColor(255,255,220)
			love.graphics.rectangle("fill", xStar[j], yStar[j], math.random(3,5), math.random(3,5))
		end
		backgroundRendered = true;
		
	end

	function endLevel() 
		io.write("end of level\n")
		paused = not paused
	end