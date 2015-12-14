include("types.jl"); using types;
include("functions.jl"); using functions;

const WIDTH, HEIGHT     = functions.getWH()
const MAX_INIT_AGENTS   = WIDTH * HEIGHT // 100
const MAX_INIT_PLANTS   = WIDTH * HEIGHT // 10

function initagents()
    agents = Array(Agent{Int}, 0)
    for i in 1:MAX_INIT_AGENTS
        x, y = rand(1:WIDTH - 1), rand(1:HEIGHT - 1)
        push!(agents, Agent{Int}(x,y))
    end
    agents
end

function initplants()
    plants = zeros(Int, WIDTH * HEIGHT + 1)
    for i in 1:MAX_INIT_PLANTS
        x, y = rand(1:WIDTH - 1), rand(1:HEIGHT - 1)
        plants[y * HEIGHT + x] = 1
    end
    plants
end

function eventloop(plants::Array{Int, 1}, agents::Array{Agent{Int}, 1})
    while ((n = parse(Int, readline(STDIN))) != 999)

        if(n == 9)
            map(a->show(a), agents)
        end

        map(agents) do a
            move!(a, WIDTH, HEIGHT)
            turn!(a)
            idx = a.y * HEIGHT + a.x
            if(plants[idx] == 1)
                eat!(a)
                plants[idx] = 0
            end
            if(a.energy < 1)
                remove!(a)
            end
        end

        growtwo(plants, WIDTH, HEIGHT)

        functions.clear();
        map(a->functions.writeat(a.x, a.y, 'A'), agents)
    end
end

eventloop(initplants(), initagents())
