require "conf"

border = {}
borderSizeVert = love.graphics.getHeight()
borderSizeHori = love.graphics.getWidth()
function border.load()
	--Hori Lines
	border.spawn(maxBorderX/2, maxBorderY/2 - borderSizeVert/2, borderSizeHori, 10)
	border.spawn(maxBorderX/2, maxBorderY/2 + borderSizeVert/2, borderSizeHori, 10)	
	--Vert
	border.spawn(maxBorderX/2 - borderSizeHori/2, maxBorderY/2, 10, borderSizeVert)
	border.spawn(maxBorderX/2 + borderSizeHori/2, maxBorderY/2, 10, borderSizeVert)	
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
		love.graphics.setColor(234,234,234)
		love.graphics.rectangle("fill", v.body:getX() - v.borderWidth/2, v.body:getY() - v.borderHeight/2, v.borderWidth, v.borderHeight)
	end
end