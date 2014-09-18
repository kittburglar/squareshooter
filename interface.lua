require "border"
require("loveframes")

interface = {}

font = love.graphics.newFont("resources/ARCADE_N.TTF", 25)

function interface.createUserInterface()
	progressbar = loveframes.Create("progressbar", frame)
	progressbar2 = loveframes.Create("progressbar", frame)
	progressbar3 = loveframes.Create("progressbar", frame)
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

function interface.level()
	--print("interface load")
	love.graphics.setColor(234,234,234)
	love.graphics.setFont(font)
	love.graphics.printf("Score:" .. player.score, 0, 20, love.graphics.getWidth(), 'center')
end

function interface.update()
	--print("updateUI");

	--loveframes.draw()
	--love.graphics.setColor(255,255,220)
	--love.graphics.rectangle("line", 0, love.graphics.getHeight() - 200, love.graphics.getWidth(), 200)
	progressbar:SetValue(player.health, progressbar:GetMax())
end