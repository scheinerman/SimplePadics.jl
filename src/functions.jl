import Base: precision

"""
    precision(a::Padic)

Return the number of digits of precision in `a`
"""
precision(a::Padic) = a.x.parent.prec_max

import Nemo: valuation, base

export base
"""
    base(a::Padic)

Return the prime number `p` for this `p`-adic number.
"""
base(a::Padic{P}) where {P} = P


export valuation
valuation(a::Padic) = valuation(a.x)

import Base: sqrt, exp, log

sqrt(a::Padic) = Padic(sqrt(a.x))
exp(a::Padic) = Padic(exp(a.x))
log(a::Padic) = Padic(log(a.x))
