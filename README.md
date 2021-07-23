# SimplePadics

Easy to use and nicely formatted p-adic numbers (in base-p, place-value notation). 
Everything rides on 
 [Nemo](https://github.com/Nemocas/Nemo.jl.git).



## Basics

### Construction

This module provides the type `Padic{p}` to represent `p`-adic numbers (for prime `p`).
Numbers of this sort are created either with `Integer` or `Rational` arguments:
```julia
julia> using SimplePadics

julia> Padic{5}(82)
…312_{5}

julia> Padic{5}(1//15)
…313131313.2_{5}
```


For `p` equal to `2` we have the abbreviation `Dyadic` that is exacly equivalent to `Padic{2}`.
```julia
julia> Dyadic(1//10)
…1100110.1_{2}
```



The function `characteristic` returns `p` for numbers of type `Padic{p}`:
```julia
julia> a = Padic{7}(100//49)
…2.02_{7}

julia> characteristic(a)
7
```

### Arithmetic

The standard arithmetic operations (addition, subtraction, multiplication, division) may be performed with arguments that are both of the same `p`-adic type, or a mixture of a `p`-adic and an `Integer` or `Rational`. Some examples:
```julia
julia> a = Padic{7}(10)
…13_{7}

julia> a+1
…14_{7}

julia> 2a
…26_{7}

julia> a/a
…1_{7}

julia> inv(a)
…462046205_{7}
```

### Digits

If the prime `p` is greater than 7, then we use letters to stand for digits beyond 9 (that is, a for ten, b for eleven, and so forth).
```julia
julia> a = Padic{17}(1000)
…37e_{17}

julia> 3 * 17^2 + 7 * 17 + 14
1000
```

To get the digits as a list of integers, use `digits(a)`. The first entry in the result is the most significant digit (rightmost).
```julia
julia> a = Padic{7}(124//49)
…2.35_{7}

julia> digits(a)
3-element Vector{Int64}:
 5
 3
 2
```
See `valuation` to determine the location of the radix point. 
```julia
julia> valuation(a)
-2
```

## Adjusting Precision

The precision of `Padic` numbers is globally controlled using the functions `set_precision` and `get_precision`.

Use `set_precision(n::Int)` to set the precision to `n` digits. Use `set_precision()` to 
set the precision to the default value (10).

The function `get_precision()` returns the current setting.


**Warning**: `Padic` numbers created with different precisions cannot be compared for equality or combined in operations.
```julia
julia> a = Padic{5}(-1)
…4444444444_{5}

julia> set_precision(20)
20

julia> b = Padic{5}(-1)
…44444444444444444444_{5}

julia> a == b
ERROR: Incompatible padic rings in padic operation
```

## Functions

The functions `sqrt`, `exp`, `log`, and `valuation` from Nemo are imported into this module. For example:
```julia
julia> a = Padic{5}(-1)
…4444444444_{5}

julia> sqrt(a)
…3032431212_{5}

julia> ans^2
…4444444444_{5}

julia> a = Padic{5}(500)
…4000_{5}

julia> valuation(a)
3

julia> 1/a
…3333333.334_{5}

julia> valuation(1/a)
-3
```

## Compatability with `LinearAlgebraX`

Matrices/vectors populated with `Padic` numbers can be used in the `LinearAlgebraX`
module. Some examples here:

```julia
julia> using LinearAlgebraX

julia> A = rand(Int,5,5) .% 10  # create a random matrix with entries between -9 and 9.
5×5 Matrix{Int64}:
 -9  -5  -4  -9  -8
  0  -1   9  -3   8
  2  -9   0   0  -4
  0   7  -6  -5   8
  0  -5   6  -2  -6

julia> A = Padic{5}.(A)  # convert those values to Padic numbers
5×5 Matrix{Padic{5}}:
 …4444444431_{5}  …44444444440_{5}  …4444444441_{5}   …4444444431_{5}  …4444444432_{5}
          …0_{5}   …4444444444_{5}          …14_{5}   …4444444442_{5}          …13_{5}
          …2_{5}   …4444444431_{5}           …0_{5}            …0_{5}  …4444444441_{5}
          …0_{5}           …12_{5}  …4444444434_{5}  …44444444440_{5}          …13_{5}
          …0_{5}  …44444444440_{5}          …11_{5}   …4444444443_{5}  …4444444434_{5}

julia> detx(A)
…4441202132_{5}

julia> invx(A)
5×5 Matrix{Padic{5}}:
 …4344224002_{5}  …4441024033_{5}  …1242400242_{5}  …2100330003_{5}   …211103034_{5}
 …4333241114_{5}  …2024323204_{5}  …1141013103_{5}  …3103232201_{5}  …4420230301_{5}
 …1011004214_{5}  …3224241133_{5}  …4324312303_{5}   …404043040_{5}  …2430224440_{5}
 …1031224011_{5}  …2022011034_{5}  …2244123102_{5}  …1312340431_{5}    …23100104_{5}
 …1324102422_{5}  …2324440300_{5}   …101223004_{5}    …21033133_{5}   …220320101_{5}

julia> A * ans
5×5 Matrix{Any}:
 …1_{5}  …0_{5}  …0_{5}  …0_{5}  …0_{5}
 …0_{5}  …1_{5}  …0_{5}  …0_{5}  …0_{5}
 …0_{5}  …0_{5}  …1_{5}  …0_{5}  …0_{5}
 …0_{5}  …0_{5}  …0_{5}  …1_{5}  …0_{5}
 …0_{5}  …0_{5}  …0_{5}  …0_{5}  …1_{5}

julia> nullspacex(A[1:3,:])
5×2 Matrix{Padic{5}}:
 …3414203434_{5}  …2234314433_{5}
 …3020203312_{5}   …241004443_{5}
 …3314221230_{5}  …2120313420_{5}
          …1_{5}           …0_{5}
          …0_{5}           …1_{5}
```




<hr>

## To Do List

### Promotion Rules

Arithmetic that mixes `Padic` numbers with `Integer` or `Rational` numbers is coded without the use of promotion rules. I need to learn how those work and re-implement arithmetic accordingly.

### Accessing the `Nemo` Underlying Data

I should provide a way to access the underlying data element of type `padic` (from Nemo). A `Padic` number is a `struct` with only one field, `x::padic`. So for now, one can get that value by just using `a.x` where `a` is a `Padic`.
```julia
julia> a = Padic{17}(1000)
…37e_{17}

julia> a.x
14*17^0 + 7*17^1 + 3*17^2 + O(17^10)
```

### Compatibility with `SimplePolynomials`

The numbers in this module do not work with my `SimplePolynomials` module. That should be fixable (I hope!).

