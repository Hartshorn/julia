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
#=
for color in [:red, :green, :blue, :yellow, :magenta]
   print_with_color(color, "$(color)\n")
end
=#
function writeat(x::Int, y::Int, class::Int)
    @printf("\033[%d;%df", y, x)
    if(class == 1)
        print_with_color(:green, "A\n")
    elseif(class == 2)
        print_with_color(:red, "P\n")
    else
        println("NaN")
    end
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
