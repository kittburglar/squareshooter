require "enemy"
level1 = {}
numberofEnemies = 200

function level1.load()

	
	
	for i = 0, numberofEnemies do

			enemy.spawn(maxBorderX/2,maxBorderX/2,i,3);
	end

end