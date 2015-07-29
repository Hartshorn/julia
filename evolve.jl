using Match


type Animal
 	x::Int64
 	y::Int64
	energy::Int32
	direction::Int32
	genes
	
	function Animal(x,y,energy,direction,genes)
		new(x,y,energy,direction,genes)
	end
	
	function Base.copy(a)
		Animal(a.x, a.y, a.energy, a.direction, copy(a.genes))
	end
end

WIDTH  = 50
HEIGHT = 20
JUNGLE = (45, 10, 10, 10)
PLANT_NRG = 80
REPRO_NRG = 200

Plants = [(x,y) => false for x in 1:WIDTH, y in 1:HEIGHT]

Animals = [Animal(WIDTH / 2, HEIGHT / 2, 1000, 0, round(Int64, rand(8) * 9))]

function random_plant(l, t, w, h)
	Plants[Pos(get_random_in_range(w) + l, get_random_in_range(h) + t)] = true
end

function add_plants()
	random_plant(JUNGLE...)
	random_plant(0, 0, WIDTH, HEIGHT)
end

function move(a::Animal)
	a.x = mod(a.x +
				   (if a.direction >= 2 && a.direction < 5
						1
		  			elseif a.direction == 1 || a.direction == 5
		    			0
		  			else
						-1
					end) 
				+ WIDTH, WIDTH)
						
	a.y = mod(a.y +
				   (if a.direction >= 0 && a.direction < 3
						-1
					elseif a.direction >= 4 && a.direction < 7
						1
					else
						0
					end) 
				+ HEIGHT, HEIGHT)
	a.energy -= 1
end

function turn(a::Animal)
	x = mod(rand(Int), reduce(+, a.genes))
	# this could be better!
	a.direction += mod(r_gene, 8)
end

function eat(a::Animal)
	if Plants[a.x, a.y]
		Plants[a.x, a.y] = false
		a.energy += PLANT_NRG
	end
end

function reproduce(a::Animal)
	if a.energy >= REPRO_NRG
		a.energy = round(Int64, a.energy / 2)
		new_animal = copy(a)
		new_animal.genes[mod(get_random_in_range(8), 8) + 1] += 1
		push!(Animals, new_animal)
	end
end

	

function get_random_in_range(range)
	round(Int64, rand() * range)
end