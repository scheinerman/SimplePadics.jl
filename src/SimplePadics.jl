module SimplePadics

using Base: String, prec_arrow, get_preferences
using Nemo


_PF = PadicField

export Padic, Dyadic

const _DEFAULT_PRECISION = 10
_PREC = _DEFAULT_PRECISION    # standard precision for p-adic numbers

export set_precision, get_precision

function set_precision(prec::Integer = _DEFAULT_PRECISION)
    @assert prec > 1 "Precision must be set to 2 or higher"
    global _PREC = prec
end

get_precision() = _PREC

"""
    Padic

Constructor for `p`-adic numbers:
* `Padic{P}(n::Integer)`
* `Padic{P}(r::Rational)`
"""
struct Padic{P} <: Number
    x::padic
    function Padic{P}(s::Integer) where {P}
        F = _PF(P, _PREC)
        new(F(s))
    end

    function Padic{P}(r::Rational) where {P}
        F = _PF(P, _PREC)
        a = F(numerator(r)) // F(denominator(r))
        new(a)
    end

    function Padic(s::padic)   # conver Nemo padic to our Padic
        F = s.parent
        digits = F.prec_max
        P = F.p
        new{P}(s)
    end

    function Padic(s::Padic)
        return s
    end
end

"""
    Dyadic

This is an abbrevation for `Padic{2}`.
"""
Dyadic = Padic{2}



function padic2str(a::padic)::String
    r = lift(QQ, a)
    t = numerator(r)
    b = BigInt(denominator(r))
    p = a.parent.p
    prefix = "…"

    digs = base(t, p)

    if b > 1   # we need to shift to
        ndigs = length(digs)
        shift = Int(round(log(p, b)))
        if shift < ndigs
            digs = digs[1:end-shift] * "." * digs[end-shift+1:end]
        elseif shift == ndigs
            digs = "0." * digs
        else
            pad = "0"^(shift - ndigs + 1)
            digs = pad * digs
            digs = digs[1:end-shift] * "." * digs[end-shift+1:end]
        end
    end

    return prefix * digs
end

function padic2str(a::Padic{P})::String where {P}
    s = padic2str(a.x)
    return s * "_{$P}"
end


import Base.Multimedia.display
display(a::Padic) = println(padic2str(a))

import Base.show
show(io::IO, a::Padic) = print(io, padic2str(a))

import Base: digits

"""
    digits(a::Padic)

Return the digits of `a`, starting from the right.
```
julia> a = Padic{7}(124//49)
…2.35_{7}

julia> digits(a)
3-element Vector{Int64}:
 5
 3
 2
```
"""
function digits(a::Padic{P})::Vector{Int} where {P}
    z = numerator(lift(QQ, a.x))
    return digits(z, base = P)
end

include("arithmetic.jl")
include("functions.jl")

end # module
