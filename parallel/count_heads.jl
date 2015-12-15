
function count_heads(n)
    c::Int = 0
    for i in 1:n
        c += rand(Bool)
    end
    c
end

function spawn_run()
    println("using @spawn:")
    x = @spawn count_heads(1000000000)
    y = @spawn count_heads(1000000000)
    z = @spawn count_heads(1000000000)
    zz = @spawn count_heads(1000000000)
    fetch(x) + fetch(y) + fetch(z) + fetch(zz)
end

function nospawn_run()
    println("using single thread:")
    n = count_heads(1000000000)
    m = count_heads(1000000000)
    o = count_heads(1000000000)
    p = count_heads(1000000000)
    n + m + o + p
end

function parallel_for()
    println("using parallel for loops:")
    n = @parallel (+) for i in 1:1000000000
        Int(rand(Bool))
    end
    m = @parallel (+) for i in 1:1000000000
        Int(rand(Bool))
    end
    o = @parallel (+) for i in 1:1000000000
        Int(rand(Bool))
    end
    p = @parallel (+) for i in 1:1000000000
        Int(rand(Bool))
    end
    n + m + o + p
end

function do_pmap()
    println("using pmap on large arrays:")
    M = Any[rand(1000,1000) for i=1:10]
    pmap(svd, M)
    println("finished")
end
