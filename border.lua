require "conf"

border = {}
size = 700

function border.load()
	border.spawn(maxBorderX/2, maxBorderY/2, size, 10)
	border.spawn(maxBorderX/2, maxBorderY/2 + size, size, 10)	
	border.spawn(maxBorderX/2 - size/2, maxBorderY/2 + size/2, 10, size)
	border.spawn(maxBorderX/2 + size/2, maxBorderY/2 + size/2, 10, size)	
	border.draw()
	
end

function border.spawn(x,y,width,height)
	border.b = love.physics.newBody(world, x, y, "static")
    border.s = love.physics.newRectangleShape(width, height)
    border.f = love.physics.newFixture(border.b,border.s)
	border.f:setUserData("Bounds")
	table.insert(border, {body = border.b, shape = border.s, fixture = border.f, borderX = x, borderY = y, borderWidth = width, borderHeight = height})
end

function border.draw()
	for i,v in ipairs(border) do
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill", v.body:getX() - v.borderWidth/2, v.body:getY() - v.borderHeight/2, v.borderWidth, v.borderHeight)
	end
end