module functions


function reset()
    workspace(); include("complex.jl")
end

function getWH()
    parse(Int, readall(`tput cols`)), parse(Int, readall(`tput lines`))
end

function clear()
    @printf("%c[2J", 27)
end

function writeat(x::Int, y::Int, c::Char)
    @printf("\033[%d;%df%s\n", y, x, c)
end

function randdir()
    (rand(-1:1), rand(-1:1))
end

function moddir(n::Int, f::Int)
    newf = f

    if (f == 1)
        if (n == 1)
            newf = -2
        end
    elseif (f == -1)
        if (n == -1)
            newf = 2
        end
    end
    newf
end

end
