require "conf"

animation = {}
numberofColours = 11
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

function animation.start(x, y, type, segment, colour, radius)
	table.insert(animation, {animationX = x, animationY = y, animationType = type, animationRadius = radius, animationSegment = segment, animationColour = colour})
end

function animation.draw(x, y)
	for i,v in ipairs(animation) do
		if v.animationType == "explosion" then
			if v.animationRadius > 1000 then
				table.remove(animation, i)
			end
			pickNeon(v.animationColour)
			v.animationRadius = v.animationRadius + 10
			love.graphics.setLineWidth(50)
			love.graphics.circle( "line", v.animationX, v.animationY, v.animationRadius, v.animationSegment)
			love.graphics.setLineWidth(1)
		elseif v.animationType == "hit" then
			if v.animationRadius > 20 then
				table.remove(animation, i)
			end
			pickNeon(v.animationColour)
			v.animationRadius = v.animationRadius + 3
			love.graphics.circle( "line", v.animationX, v.animationY, v.animationRadius, v.animationSegment)
		elseif v.animationType == "spawn" then
			if v.animationRadius < 20 then
				table.remove(animation, i)
			end

			pickNeon(v.animationColour)
			v.animationRadius = v.animationRadius - 3
			love.graphics.setLineWidth(3)
			love.graphics.circle( "line", v.animationX, v.animationY, v.animationRadius, v.animationSegment)
			love.graphics.setLineWidth(1)
		elseif v.animationType == "jets" then
			if v.animationRadius > 10 then
				table.remove(animation, i)
			end
			pickNeon(v.animationColour)
			v.animationRadius = v.animationRadius + 0.1
			love.graphics.circle( "line", v.animationX, v.animationY, v.animationRadius, v.animationSegment)
		elseif v.animationType == "boost" then
			if v.animationRadius > 20 then
				table.remove(animation, i)
			end
			pickNeon(v.animationColour)
			v.animationRadius = v.animationRadius + 3
			love.graphics.circle( "line", v.animationX, v.animationY, v.animationRadius, v.animationSegment)
		end

	end
end

