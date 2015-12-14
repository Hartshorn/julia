module types

include("functions.jl")

export Agent, move!, eat!, turn!, growtwo

type Agent{Int}
    x::Int
    y::Int
    energy::Int
    active::Bool
    genes::Array{Int}
    # (1,1) -> SE, (0,1) -> S, (-1,1) -> SW,
    # (-1,0) -> W, (-1, -1) -> NW, (0,-1) -> N,
    # (1,-1) -> NE, (1,0) -> E
    direction::Tuple{Int, Int}

    function Agent{Int}(x::Int, y::Int, e::Int = 1000, a::Bool = true)
        g = rand(0:9, 8)
        d = functions.randdir()
        new(x, y, e, a, g, d)
    end
end

function move!(a::Agent, w::Int, h::Int)
    a.x = mod(a.x + first(a.direction), w)
    a.y = mod(a.y + last(a.direction), h)
    a.energy -= 1
    a.x, a.y
end

function eat!(a::Agent)
    a.energy += 10
end

function turn!(a::Agent)
    if (a.genes[4] > 4)
        nf = first(a.direction) + functions.moddir(first(a.direction), 1)
        nl = last(a.direction) + functions.moddir(last(a.direction), -1)
    else
        nf = first(a.direction) 
        nl = last(a.direction)
    end
    a.direction = (nf, nl)
end

function growtwo(ps::Array{Int, 1}, w::Int, h::Int)
    x, y = rand(1:w - 1), rand(1:h - 1)
    ps[y * h + x] = 1
    x, y = rand(1:w - 1), rand(1:h - 1)
    ps[y * h + x] = 1
end

function Base.show(a::Agent{Int})
    @printf("x: %d, y: %d, energy: %d, active: %s, ", a.x, a.y, a.energy, a.active)
    print("genes: ")
    map(print, a.genes)
    println(" dir: ", a.direction)
end


end
