	require "player"
	require "camera"
	require "bullet"
	require "enemy"
	require "level1"
	require "conf"

	bounds = {}

	function love.load()
		require("loveframes")
		xStar = {}    -- new array
		yStar = {}
		fillStarArray()
		backgroundRendered = false;
		createUIElements()

			world = love.physics.newWorld(0, 0, 0,0,0,0,false)  --Gravity is being set to 0 in the x direction and 200 in the y direction.
	        --These callback function names can be almost any you want:
			world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	        --Loading Classes
	        --[[
	        bounds.b = love.physics.newBody(world, 0,0,"static")
	        bounds.s = love.physics.newEdgeShape(0,0, 2000, 2000)
	        bounds.f = love.physics.newFixture(bounds.b,bounds.s)
			bounds.f:setUserData("Bounds")
			]]
		player.load()
		enemy.load()
		--test
		level1.load()
	end

	function createUI()

		
		--love.graphics.setColor(255,255,220)
		--love.graphics.rectangle("line", 0, love.graphics.getHeight() - 200, love.graphics.getWidth(), 200)
		
	end

	function createUIElements()
		local image = loveframes.Create("image", frame)
		image:SetImage("resources/images/kitty.jpg")
		image:SetPos(5, love.graphics.getHeight() - 200 + 5)

		love.graphics.setColor(0, 255, 0, 255)
    	love.graphics.print("This is a pretty lame example.", 5 + 96 + 5, love.graphics.getHeight() - 200 + 5)

		local progressbar = loveframes.Create("progressbar", frame)
		progressbar:SetPos(5 + 96 + 5, love.graphics.getHeight() - 200 + 5 + 139 - (3  *25) - 10)
		progressbar:SetWidth(150)
		progressbar:SetLerpRate(10)
		local progressbar = loveframes.Create("progressbar", frame)
		progressbar:SetPos(5 + 96 + 5, love.graphics.getHeight() - 200 + 5 + 139 - (2 * 25) - 5)
		progressbar:SetWidth(150)
		progressbar:SetLerpRate(10)

		
		local progressbar = loveframes.Create("progressbar", frame)
		progressbar:SetPos(5 + 96 + 5, love.graphics.getHeight() - 200 + 5 + 139 - 25)
		progressbar:SetWidth(150)
		progressbar:SetLerpRate(10)
	end

	function beginContact(a, b, coll)
		if((a:getUserData() == "Bullet") and (b:getUserData() == "Enemy")) then
			print("collided")
			table.remove(enemy)
		end
		if((b:getUserData() == "Bullet") and (a:getUserData() == "Enemy")) then
			print("collided")
			table.remove(enemy)
		end
		--print('beginning contact')   
	end

	function endContact(a, b, coll)
		
	    ---print('beginning contact')
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
		bullet.shoot(key)

	end

	function love.draw()

		camera:set()
		renderBackground()
		DRAW_PLAYER()
		DRAW_ENEMY()
		bullet.draw()
		camera:unset()
		createUI()
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