
enemy = {}

function enemy.load()

	
	enemy.speed = 200
	enemy.width = 32
	enemy.height = 32

	
end



function enemy.spawn(x,y,dir,hp)
	enemy.b = love.physics.newBody(world,x,y,"dynamic")
	enemy.b:setMass(10)
	enemy.b:setGravityScale(0)
	enemy.s = love.physics.newRectangleShape(enemy.width,enemy.height)
	enemy.f = love.physics.newFixture(enemy.b,enemy.s)
	enemy.f:setUserData("Enemy" .. tostring(dir))
	enemy.image = love.graphics.newImage("resources/images/enemy1.png")
	enemy.prevAngle = enemy.b:getAngle()
	local dy = player.b:getY() - enemy.b:getY()  
	local dx = player.b:getX() - enemy.b:getX()
	local angle = (math.atan2(dy,dx)* 180 / math.pi) - 90
	enemy.b:setAngle(math.rad(angle))
	table.insert(enemy, {hitpoints = hp, 
							width = enemy.width, 
							height = enemy.height,
							x = enemy.b:getX(), 
							y = enemy.b:getY(), 
							dir = dir, 
							body = enemy.b, 
							shape = enemy.s, 
							fixture = enemy.f,
							image = enemy.image
							})

	
end
--[[
function enemy.draw()
	love.graphics.setColor(0,255,255)
	--love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.width, enemy.height)
	love.graphics.rectangle("fill", enemy.b:getX()-25,enemy.b:getY()-25,enemy.width,enemy.height)
end
]]
function enemy.draw()
	for i,v in ipairs(enemy) do
		--io.write("v.body:getX() is: " .. tostring(v.body:getX()) - player.b:getX()  .. "love.graphics.getWidth() is:" .. love.graphics.getWidth() .. "\n")
		--if ((v.body:getX() <= player.b:getX() - love.graphics.getWidth()/2) and (v.body:getY() <= player.b:getX() - love.graphics.getHeight()/2)) then
		--love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
		--love.graphics.setColor(0,0,255)
		--love.graphics.rectangle('fill',v.body:getX()-v.width/2,v.body:getY()-v.width/2,v.width,v.height)
		love.graphics.draw(v.image, v.body:getX(), v.body:getY(), v.body:getAngle(), 1, 1, v.width/2, v.height/2)
		--end
	end
end



function round(num, idp)
 	if num ~= nil then
		local mult = 10^(idp or 0)
		return math.floor(num * mult + 0.5) / mult
	end
end

function enemy.move(x,y)
	for i,v in ipairs(enemy) do
		
		local dy2 = player.b:getY() - v.body:getY()  
		local dx2 = player.b:getX() - v.body:getX()
		local angle2 = (math.atan2(dy2,dx2)* 180 / math.pi) - 90
		newAngle2 = angle2
		print("newAngle2 is" .. tostring(newAngle2) .. " prevAngle is " .. tostring(v.prevAngle))
		--v.body:applyForce(math.max(math.min(player.b:getX() - v.body:getX(),50), -50), math.max(math.min(player.b:getY() - v.body:getY(),50), -50))
		print(tostring(angle2) ..  " vs " .. tostring(math.deg(v.body:getAngle())))
		if round(newAngle2,-1) == 90 and round(v.prevAngle,-1) == -270 then
			--print("BAM")
			v.body:setAngle(math.rad(90))
		elseif round(newAngle2,-1) == -270 and round(v.prevAngle,-1) == 90 then
			--print("BAM")
			v.body:setAngle(math.rad(-270))
		end

		if round(angle2,-1) > round(math.deg(v.body:getAngle()),-1) then
			v.body:setAngle(math.rad(math.deg(v.body:getAngle()) + 1))
		elseif round(angle2, -1) < round(math.deg(v.body:getAngle()) or angle2 > 360 - math.deg(v.body:getAngle())) then
			v.body:setAngle(math.rad(math.deg(v.body:getAngle()) - 1))
		else
			print("BAM")
			local thrust_fx = -math.sin(v.body:getAngle()) *  enemy.speed
        	local thrust_fy = math.cos(v.body:getAngle()) *  enemy.speed
        	v.body:applyForce (thrust_fx, thrust_fy)
		end
		v.prevAngle = newAngle2
	end
end


function UPDATE_ENEMY(dt)

	enemy.move(dt)
end

function DRAW_ENEMY()
	enemy.draw()
end
