const WIDTH  = 10
const HEIGHT = 10
const LENGTH = WIDTH * HEIGHT
# const GENES  = Int[1,2,3,4,5,6,7,8]
const PLANTENERGY = 80

type Animal
    energy
    direction
    genes
end

type Pos
	hasA::Bool
	hasP::Bool
	Animal::Animal
end

# something strange here - everything updates the same...
positions = fill(Pos(false, 
					  false, 
					  Animal(0,0,[0,0,0,0,0,0,0,0])), 
				  LENGTH)

firstanimal = Animal(500, 0, abs(rand(Int, 8)) % 8)

function setpos(positions::Array, x::Int, y::Int,
				hasp::Bool, hasa::Bool, 
				animal::Animal...)
	loc = get_loc(x,y)
	if hasp
		positions[loc].hasP = true
	end
	if hasa
		positions[loc].hasA = true
		positions[loc].Animal = animal[1]
	end
end


get_loc(x::Int, y::Int) = WIDTH * y + x

gen_rand_int() = round(Int, rand() * 1000) % LENGTH
