require "conf"

animation = {}

function pickNeon(number)
	if number == 0 then
		love.graphics.setColor(255,0,0)
	elseif number == 1 then
		love.graphics.setColor(255,128,0)
	elseif number == 2 then
		love.graphics.setColor(255,255,0)
	elseif number == 3 then
		love.graphics.setColor(128,255,0)
	elseif number == 4 then
		love.graphics.setColor(0,255,0)
	elseif number == 5 then
		love.graphics.setColor(0,255,128)
	elseif number == 6 then
		love.graphics.setColor(0,255,255)
	elseif number == 7 then
		love.graphics.setColor(0,128,255)
	elseif number == 8 then
		love.graphics.setColor(128,0,255)
	elseif number == 9 then
		love.graphics.setColor(255,0,255)
	elseif number == 10 then
		love.graphics.setColor(255,0,128)
	end
end

function animation.explosion(x, y, type)
	segment = math.random(3,6)
	colour = math.random(0,10)
	table.insert(animation, {animationX = x, animationY = y, animationType = type, animationRadius = 5 , animationSegment = segment, animationColour = colour})
	table.insert(animation, {animationX = x, animationY = y, animationType = type, animationRadius = 20, animationSegment = segment, animationColour = colour })
	table.insert(animation, {animationX = x, animationY = y, animationType = type, animationRadius = 60, animationSegment = segment, animationColour = colour })
end

function animation.draw(x, y)
	for i,v in ipairs(animation) do
		if v.animationType == "explosion" then
			if v.animationRadius > 800 then
				table.remove(animation, i)
			end
			pickNeon(v.animationColour)
			v.animationRadius = v.animationRadius + 10

			love.graphics.circle( "line", v.animationX, v.animationY, v.animationRadius, v.animationSegment)	
		end
	end
end