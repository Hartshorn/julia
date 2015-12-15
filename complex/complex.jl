include("types.jl"); using types;
include("functions.jl"); using functions;

const WIDTH, HEIGHT     = functions.getWH()
const MAX_INIT_AGENTS   = Int(floor(WIDTH * HEIGHT * 0.01))
const MAX_INIT_PLANTS   = Int(floor(WIDTH * HEIGHT * 0.10))
const MAX_INIT_PRED     = Int(floor(WIDTH * HEIGHT * 0.005))

function initagents()
    agents = Array(Agent{Int}, 0)
    for i in 1:MAX_INIT_AGENTS
        x, y = rand(1:WIDTH - 1), rand(1:HEIGHT - 1)
        push!(agents, Agent{Int}(x,y,1))
    end
    for i in 1:MAX_INIT_PRED
        x, y = rand(1:WIDTH - 1), rand(1:HEIGHT - 1)
        push!(agents, Agent{Int}(x,y,2))
    end
    # filter!(a -> a.direction != (0,0) && a.speed != 0, agents)
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

        if(n == 0)
            map(a->show(a), agents)
        end

        if n == 9
            functions.clear();
            map(a->functions.writeat(a.x, a.y, a.class), agents)
            continue
        end

        for i in 1:n

            preds = filter(a -> a.class == 2, agents)

            map(agents) do a
                if(a.active)
                    move!(a, WIDTH, HEIGHT)
                    turn!(a)
                    if(a.class == 1)
                        fight!(a, preds, WIDTH, HEIGHT)
                    end
                    idx = a.y * HEIGHT + a.x
                    idx == 0 ? idx += 1 : idx += 0
                    if(plants[idx] == 1)
                        eat!(a)
                        plants[idx] = 0
                    end
                    if(a.energy > 1000)
                        a.energy /= 2
                        push!(agents, Agent{Int}(a.x + 1, a.y + 1, 1))
                    end
                end
            end
            filter!(a -> (a.active == true) && (a.energy > 0), agents)
            growtwo(plants, WIDTH, HEIGHT)
        end
    end
end

eventloop(initplants(), initagents())
