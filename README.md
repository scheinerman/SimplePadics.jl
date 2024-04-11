# SimplePadics

Easy to use and nicely formatted p-adic numbers (in base-p, place-value notation). 
Everything rides on 
 [Nemo](https://github.com/Nemocas/Nemo.jl.git).

> **Breaking change in version 0.2**: The function `has_p_root` just returns  a `Bool` value and not a 2-tuple.

## Basics

### Construction

This module provides the type `Padic{p}` to represent `p`-adic numbers (for prime `p`).
Numbers of this sort are created either with `Integer` or `Rational` arguments:
```
julia> using SimplePadics

julia> Padic{5}(82)
…312.0_{5}

julia> Padic{5}(1//15)
…313131313.2_{5}
```


For `p` equal to `2` we have the abbreviation `Dyadic` that is exacly equivalent to `Padic{2}`.
```
julia> Dyadic(1//10)
…1100110.1_{2}
```



The function `base` returns `p` for numbers of type `Padic{p}`:
```
julia> a = Padic{7}(100//49)
…2.02_{7}

julia> base(a)
7
```

### Arithmetic

The standard arithmetic operations (addition, subtraction, multiplication, division) may be performed with arguments that are both of the same `p`-adic type, or a mixture of a `p`-adic and an `Integer` or `Rational`. Some examples:
```
julia> a = Padic{7}(10)
…13.0_{7}

julia> a+1
…14.0_{7}

julia> 2a
…26.0_{7}

julia> a/a
…1.0_{7}

julia> inv(a)
…462046205.0_{7}
```




### Digits

If the prime `p` is greater than 7, then we use letters to stand for digits beyond 9 (that is, a for ten, b for eleven, and so forth).
```
julia> a = Padic{17}(1000)
…37e.0_{17}

julia> 3 * 17^2 + 7 * 17 + 14
1000
```

To get the digits as a list of integers, use `digits(a)`. The first entry in the result is the most significant digit (rightmost).
```
julia> a = Padic{7}(124//49)
…2.35_{7}

julia> digits(a)
3-element Vector{Int64}:
 5
 3
 2
```
See `valuation` to determine the location of the radix point. 
```
julia> valuation(a)
-2
```

## Adjusting Precision

The precision of `Padic` numbers is globally controlled using the functions `set_precision` and `get_precision`.

Use `set_precision(n::Int)` to set the precision to `n` digits. Use `set_precision()` to 
set the precision to the default value (10).

The function `get_precision()` returns the current setting.


**Warning**: `Padic` numbers created with different precisions cannot be compared for equality or combined in operations.
```
julia> a = Padic{5}(-1)
…4444444444.0_{5}

julia> set_precision(20)
20

julia> b = Padic{5}(-1)
…44444444444444444444.0_{5}

julia> a == b
ERROR: Incompatible padic rings in padic operation
```

## Functions

The functions `sqrt`, `exp`, `log`, and `valuation` from Nemo are imported into this module. For example:
```
julia> a = Padic{5}(-1)
…4444444444.0_{5}

julia> sqrt(a)
…3032431212.0_{5}

julia> ans^2
…4444444444.0_{5}

julia> a = Padic{5}(500)
…4000.0_{5}

julia> valuation(a)
3

julia> 1/a
…3333333.334_{5}

julia> valuation(1/a)
-3

julia> abs(a)
0.008

julia> abs(1/a)
125.0
```

## Roots of Polynomials

Let `F` be a `SimplePolynomial` with integer or rational coefficients. The function `p_root(F,p)` returns a `p`-adic root of `F` (if one exists) or throws an error otherwise.
```
julia> using SimplePadics, SimplePolynomials

julia> x = getx()
x

julia> F = x^2 + 1
1 + x^2

julia> t = p_root(F,5)
…3032431212.0_{5}

julia> t^2 + 1
…0.0_{5}

julia> sqrt(Padic{5}(-1))
…3032431212.0_{5}
```
The function `has_p_root(F,p)` tests if a polynomial has a `p`-adic root. 
Returns `true` if `F` has a root and `false` otherwise.



## Compatability with `LinearAlgebraX`

Matrices/vectors populated with `Padic` numbers can be used in the `LinearAlgebraX`
module. Some examples here:

```
julia> using LinearAlgebraX

julia> A = rand(Int,5,5) .% 10  # create a random matrix with entries between -9 and 9.
5×5 Matrix{Int64}:
 -9  -5  -4  -9  -8
  0  -1   9  -3   8
  2  -9   0   0  -4
  0   7  -6  -5   8
  0  -5   6  -2  -6

julia> A = Padic{5}.(A)  # convert those values to 5-adic numbers
5×5 Matrix{Padic{5}}:
 …4444444431.0_{5}  …44444444440.0_{5}  …4444444441.0_{5}   …4444444431.0_{5}  …4444444432.0_{5}
          …0.0_{5}   …4444444444.0_{5}          …14.0_{5}   …4444444442.0_{5}          …13.0_{5}
          …2.0_{5}   …4444444431.0_{5}           …0.0_{5}            …0.0_{5}  …4444444441.0_{5}
          …0.0_{5}           …12.0_{5}  …4444444434.0_{5}  …44444444440.0_{5}          …13.0_{5}
          …0.0_{5}  …44444444440.0_{5}          …11.0_{5}   …4444444443.0_{5}  …4444444434.0_{5}

julia> detx(A)
…4441202132.0_{5}

julia> invx(A)
5×5 Matrix{Padic{5}}:
 …4344224002.0_{5}  …4441024033.0_{5}  …1242400242.0_{5}  …2100330003.0_{5}   …211103034.0_{5}
 …4333241114.0_{5}  …2024323204.0_{5}  …1141013103.0_{5}  …3103232201.0_{5}  …4420230301.0_{5}
 …1011004214.0_{5}  …3224241133.0_{5}  …4324312303.0_{5}   …404043040.0_{5}  …2430224440.0_{5}
 …1031224011.0_{5}  …2022011034.0_{5}  …2244123102.0_{5}  …1312340431.0_{5}    …23100104.0_{5}
 …1324102422.0_{5}  …2324440300.0_{5}   …101223004.0_{5}    …21033133.0_{5}   …220320101.0_{5}

julia> A * ans
5×5 Matrix{Any}:
 …1.0_{5}  …0.0_{5}  …0.0_{5}  …0.0_{5}  …0.0_{5}
 …0.0_{5}  …1.0_{5}  …0.0_{5}  …0.0_{5}  …0.0_{5}
 …0.0_{5}  …0.0_{5}  …1.0_{5}  …0.0_{5}  …0.0_{5}
 …0.0_{5}  …0.0_{5}  …0.0_{5}  …1.0_{5}  …0.0_{5}
 …0.0_{5}  …0.0_{5}  …0.0_{5}  …0.0_{5}  …1.0_{5}

julia> nullspacex(A[1:3,:])
5×2 Matrix{Padic{5}}:
 …3414203434.0_{5}  …2234314433.0_{5}
 …3020203312.0_{5}   …241004443.0_{5}
 …3314221230.0_{5}  …2120313420.0_{5}
          …1.0_{5}           …0.0_{5}
          …0.0_{5}           …1.0_{5}
```



