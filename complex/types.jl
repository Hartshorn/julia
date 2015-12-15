module types
#=
directions
(1,1) -> SE, (0,1) -> S, (-1,1) -> SW, (-1,0) -> W, (-1, -1) -> NW,
(0,-1) -> N, (1,-1) -> NE, (1,0) -> E

speed factor - 1 is twice as fast - 0 is normal speed (always adding)
=#
include("functions.jl")

export Agent, move!, eat!, turn!, fight!, growtwo

type Agent{Int}
    x::Int
    y::Int
    energy::Int
    active::Bool
    genes::Array{Int}
    direction::Tuple{Int, Int}
    speed::Int
    class::Int

    function Agent{Int}(x::Int, y::Int, c::Int)
        e = 100
        a = true
        g = rand(0:9, 8)
        d = functions.randdir()
        s = g[5] > 4 ? 1 : 0
        new(x, y, e, a, g, d, s, c)
    end
end

function move!(a::Agent, w::Int, h::Int)
    a.x = mod(a.x + first(a.direction) + a.speed, w)
    a.y = mod(a.y + last(a.direction) + a.speed, h)

    a.energy -= 1
    a.x == 0 ? 1 : a.x, a.y == 0 ? 1 : a.y
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

function fight!(a::Agent, preds::Array{Agent{Int}})
    near = filter(p -> p.x == a.x && p.y == a.y
                    || p.x == a.x && p.y == a.y + 1
                    || p.x == a.x && p.y == a.y - 1
                    || p.x == a.x + 1 && p.y == a.y
                    || p.x == a.x - 1 && p.y == a.y
                    || p.x == a.x + 1 && p.y == a.y + 1
                    || p.x == a.x - 1 && p.y == a.y - 1
                    || p.x == a.x + 1 && p.y == a.y - 1
                    || p.x == a.x - 1 && p.y == a.y + 1 , preds)
    if(length(near) > 0)
        for _ in 1:length(near)
            chance = rand(1:10)
            if(chance > 5)
                a.energy -= 50
                turn!(a)
            else
                a.active == false
            end
        end
    end
end

function growtwo(ps::Array{Int, 1}, w::Int, h::Int)
    x, y = rand(1:w - 1), rand(1:h - 1)
    ps[y * h + x] = 1
    x, y = rand(1:w - 1), rand(1:h - 1)
    ps[y * h + x] = 1
end

function Base.show(a::Agent{Int})
    @printf("(%3d,%3d) energy: %4d active: %s", a.x, a.y, a.energy, a.active)
    print(" genes:")
    map(g -> print(" ", g), a.genes)
    @printf(" dir: (%2d, %2d)", first(a.direction), last(a.direction))
    print(" speed: ", a.speed)
    println(" class: ", a.class == 1 ? "A" : "P")
end


end
