const WIDTH  = 10
const HEIGHT = 10
const LENGTH = WIDTH * HEIGHT
const GENES  = Int[1,2,3,4,5,6,7,8]
const PLANTENERGY = 80

type Animal
    x::Int
    y::Int
    energy
    direction
    genes
end

animals = Array{Animal}(LENGTH)
plants = zeros(Int, LENGTH)

firstanimal = Animal(WIDTH / 2, HEIGHT / 2,
                     500, 0, rand(GENES, 8))

function animal_eat(animal::Animal, plants::Array)
    if plants[get_loc(animal.x, animal.y)] != 0
        animal.energy += PE
    end
end

function add_animal_at_loc(animals::Array, animal::Animal)
    animals[get_loc(animal.x, animal.y)] = animal
end

get_loc(x::Int, y::Int) = round(Int, WIDTH * y + x)

gen_rand_int() = round(Int, rand() * 1000) % LENGTH

add_random_plants() = plants[gen_rand_int()] = 1

