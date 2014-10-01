require "player"
require "camera"
require "bullet"
require "enemy"
require "level1"
require "conf"
require "border"
require "interface"
require "animation"
cron = require 'cron'
bounds1 = {}
paused = false
shader = love.graphics.newShader[[
    extern vec2 size = vec2(20,20);
   extern int samples = 5; // pixels per axis; higher = bigger glow, worse performance
   extern float quality = .15; // lower = smaller glow, better quality

   vec4 effect(vec4 colour, Image tex, vec2 tc, vec2 sc)
   {
      vec4 source = Texel(tex, tc);
      vec4 sum = vec4(0);
      int diff = (samples - 1) / 2;
      vec2 sizeFactor = vec2(1) / size * quality;

      for (int x = -diff; x <= diff; x++)
      {
         for (int y = -diff; y <= diff; y++)
         {
            vec2 offset = vec2(x, y) * sizeFactor;
            sum += Texel(tex, tc + offset);
         }
      }

   return ((sum / (samples * samples)) + source) * colour;
   }
	]]

function love.load()
	

	require("loveframes")
	xStar = {}    -- new array
	yStar = {}
	
	--spawn = cron.every(3, function() enemy.spawn(maxBorderX/2+100,maxBorderX/2+100,i,1) end)


	fillStarArray()
	backgroundRendered = false;
	interface.createUserInterface()

	world = love.physics.newWorld(0, 0, 0,0,0,0,false)  --Gravity is being set to 0 in the x direction and 200 in the y direction.
    --These callback function names can be almost any you want:
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    


    border.load()
    player.load()
    enemy.load()
	--test
	level1.load()
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
	if((a:getUserData():sub(0,6) == "Bullet") and (b:getUserData():sub(0,5) == "Enemy")) then
		destroyBullet(a:getUserData():sub(7,100)) 
		print("Bullet collided with enemy")
		for i,v in ipairs(enemy) do
			--io.write("b:getUserData():sub(6,10) is: " .. tostring(b:getUserData():sub(6,10)) .. " and v.dir is: " .. tostring(v.dir) .. "\n")
			if (b:getUserData():sub(6,string.len(b:getUserData())) == tostring(v.dir)) then
				v.hitpoints = v.hitpoints - 1
				if (tonumber(v.hitpoints) == 0) then 
					io.write("hitpoint is: " .. v.hitpoints .. "\n")
					io.write("remove at position: " .. tostring(i) .. "\n")
					animation.explosion(v.body:getX(),v.body:getY(), "explosion")
					b:destroy()
					table.remove(enemy, i)
					player.upscore(50)
					if (table.maxn(enemy) == 0) then
						endLevel()
					end
				end
			end
		end
	end
	if((b:getUserData():sub(0,6) == "Bullet") and (a:getUserData():sub(0,5) == "Enemy")) then
		print("Bullet collided with enemy 2")
		destroyBullet(b:getUserData():sub(7,100)) 
		for i,v in ipairs(enemy) do
			--io.write("a:getUserData():sub(6,10) is: " .. a:getUserData():sub(6,string.len(a:getUserData())) .. " and v.dir is: " .. tostring(v.dir) .. "\n" )
			--io.write(a:getUserData())
			if (a:getUserData():sub(6,string.len(a:getUserData())) == tostring(v.dir)) then
				v.hitpoints = v.hitpoints - 1
				if (tonumber(v.hitpoints) == 0) then 
					io.write("hitpoint is: " .. v.hitpoints .. "\n")
					io.write("remove at position: " .. tostring(i) .. "\n")

					animation.explosion(v.body:getX(),v.body:getY(), "explosion")
					a:destroy()
					table.remove(enemy, i)
					player.upscore(50)
					if (table.maxn(enemy) == 0) then
						endLevel()
					end
					
				end

			end
		end
	end
	if((a:getUserData() == "Player") and (b:getUserData():sub(0,5) == "Enemy")) then
		print("Player collided with Enemy")
		for i,v in ipairs(enemy) do
			--io.write("b:getUserData():sub(6,10) is: " .. tostring(b:getUserData():sub(6,10)) .. " and v.dir is: " .. tostring(v.dir) .. "\n")
			if (b:getUserData():sub(6,10) == tostring(v.dir)) then
				player.health = player.health - 1
				v.hitpoints = v.hitpoints - 1
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
					
				end
			end
		end
	end
	if((b:getUserData() == "Player") and (a:getUserData():sub(0,5) == "Enemy")) then
		print("Player collided with Enemy 2")
		for i,v in ipairs(enemy) do
			--io.write("a:getUserData():sub(6,10) is: " .. a:getUserData():sub(6,10) .. " and v.dir is: " .. tostring(v.dir) .. "\n" )
			--io.write(a:getUserData())

			if (a:getUserData():sub(6,10) == tostring(v.dir)) then
				player.health = player.health - 1
				v.hitpoints = v.hitpoints - 1
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
	if button  == "l" then
		dy = (player.b:getY() + player.height/2) - (y + camera.y)
		dx = (player.b:getX() + player.width/2) - (x + camera.x)
		angle = math.atan2(dy,dx) + math.pi
		bullet.shoot2(angle)
		print(math.deg(angle))
	end
	
end

function love.update(dt)
	if paused then return end
	spawn:update(dt)
	world:update(dt)
	UPDATE_PLAYER(dt)
	UPDATE_ENEMY(dt)
	bullet.update(dt)
	--if player.b:getX() > love.graphics.getWidth() / 2 then
		--camera.x = player.b:getX() - love.graphics.getWidth() / 2
	camera.x = maxBorderX/2 - love.graphics.getWidth() /2
	--end
	--if player.b:getY() > love.graphics.getWidth() / 2 then
		--camera.y = player.b:getY() - (love.graphics.getHeight() - 50) / 2
	camera.y = maxBorderY/2 - love.graphics.getHeight() /2
	--end
	--loveframes.update(dt)
end


--cron.after(3, enemy.spawn(maxBorderX/2+100,maxBorderX/2+100,i,1));


function love.keypressed(key)
	if key == "p" then
		io.write("pause button pressed\n");
		paused = not paused
	elseif (not paused) then
		bullet.shoot(key)
	end
end

function love.draw()
	--love.graphics.setShader(shader)
	camera:set()
	--renderBackground()
	animation.draw()
	border.draw()
	DRAW_PLAYER()
	DRAW_ENEMY()
	bullet.draw()
	camera:unset()
	interface.level()
	interface.update()
	--love.graphics.setShader()

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