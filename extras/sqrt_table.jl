using SimplePadics, Primes

"""
    sqrt_table(p::Int = 2, lo::Int = -20, hi::Int = 20)

Print out a table of `p`-adic square roots of integers 
in the range `lo` to `hi`, skipping those that do not have 
square roots.
"""
function sqrt_table(p::Int = 2, lo::Int = -20, hi::Int = 20)
    for a = lo:hi
        x = Padic{p}(a)
        try
            y = sqrt(x)
            println("√", a, "\t", y)
        catch
        end
    end
end


"""
    has_i(p::Int)::Bool

Determine if `√-1` exists as a `p`-adic number.
"""
function has_i(p::Int)::Bool
    a = Padic{p}(-1)
    try
        b = sqrt(a)
        return true
    catch
    end
    return false
end

"""
    has_i_list(max_p::Int = 100)::Vector{Int}

Generate a list of primes, `p`, up to `max_p`
for which `√-1` exists as a `p`-adic number.
"""
function has_i_list(max_p::Int = 100)::Vector{Int}
    [p for p in primes(max_p) if has_i(p)]
end
