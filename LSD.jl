type LSD
    pounds::Int
    shillings::Int
    pence::Int
    
    function LSD(l,s,d)
        if l < 0 || s < 0 || d < 0
            error("No negative numbers please!")
        end
        if d > 12 || s > 20
            error("That's too many pence or shillings!")
        end
        new(l,s,d)
    end
    
    function Base.show(io::IO, money::LSD)
        print(io, "\u00A3$(money.pounds), $(money.shillings)s, $(money.pence)d")
    end
end


