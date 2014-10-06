require "enemy"
require "interface"

level1 = {}
i = 0
numberofEnemies = 100


function level1.load()
	spawn = cron.every(0.5, function() 
		if i < numberofEnemies then
			enemy.spawn(math.random(maxBorderX/2 - 300,maxBorderX/2 + 300),math.random(maxBorderX/2 - 300, maxBorderX/2 + 300),i,1) 
			i = i + 1
		end
	end)
end