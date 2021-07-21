import Base: precision

"""
    precision(a::Padic)

Return the number of digits of precision in `a`
"""
precision(a::Padic) = a.x.parent.prec_max


export characteristic
"""
    characteristic(a::Padic)

Return the prime number `p` for this `p`-adic number.
"""
characteristic(a::Padic{P}) where {P} = P


import Nemo: valuation
export valuation
valuation(a::Padic) = valuation(a.x)

import Base: sqrt, exp, log

sqrt(a::Padic) = Padic(sqrt(a.x))
exp(a::Padic) = Padic(exp(a.x))
log(a::Padic) = Padic(log(a.x))
