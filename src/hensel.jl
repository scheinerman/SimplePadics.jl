using SimplePadics, SimplePolynomials


"""
    _clear_denominators(F::SimplePolynomial)

If `F` has rational coefficients, return a multiple of `F` that has integer 
coefficients. 
"""
function _clear_denominators(F::SimplePolynomial)
    coes = SimplePolynomials.coeffs(F)
    d = lcm(denominator.(coes))
    return integerize(d * F)
end

"""
    has_p_root(F::SimplePolynomial, p::Int)::Bool
Test if the polynomial `F` has a `p`-adic root for a prime `p`.
"""
function has_p_root(F::SimplePolynomial, p::Int)::Bool
    b, a = _has_p_root(F, p)
    return b
end


"""
    _has_p_root(F::SimplePolynomial, p::Int)

Helper function for `has_p_root` that returns extra information 
that is used by `p_root`.
"""
function _has_p_root(F::SimplePolynomial, p::Int)
    F = _clear_denominators(F)
    for a = 0:p-1
        if F(a) % p == 0 && F'(a) % p != 0
            return true, a
        end
    end
    return false, -1
end



"""
    p_root(F::SimplePolynomial, p::Int)
Find a `p`-adic root of the polynomial `F`.
"""
function p_root(F::SimplePolynomial, p::Int)
    F = _clear_denominators(F)
    (tst, a) = _has_p_root(F, p)
    if !tst
        error("This polynomial does not have a $p-adic root.")
    end
    prec = get_precision()
    value = big(a)
    P = big(p)

    for t = 2:prec+5
        PP = P^(t - 2)
        for b = 0:p-1
            x = b * PP + value
            if F(x) % (PP * P) == 0
                value = x
                pv = Padic{p}(value)
                if F(pv) == 0
                    return pv
                end
                break
            end
        end
    end
    return Padic{p}(value)
end

export has_p_root, p_root
