var documenterSearchIndex = {"docs":
[{"location":"#SimplePadics","page":"SimplePadics","title":"SimplePadics","text":"","category":"section"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"Easy to use and nicely formatted p-adic numbers.  Everything rides on   Nemo.","category":"page"},{"location":"#Basics","page":"SimplePadics","title":"Basics","text":"","category":"section"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"This module provides the type Padic{p} to represent p-adic numbers (for prime p). Numbers of this sort are created either with Integer or Rational arguments:","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"julia> using SimplePadics\n\njulia> Padic{5}(82)\n…312.0_{5}\n\njulia> Padic{5}(1//15)\n…313131313.2_{5}","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"For p equal to 2 we have the abbreviation Dyadic that is exacly equivalent to Padic{2}.","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"julia> Dyadic(1//10)\n…1100110.1_{2}","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"The function base returns p for numbers of type Padic{p}:","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"julia> a = Padic{7}(100//49)\n…2.02_{7}\n\njulia> base(a)\n7","category":"page"},{"location":"#Arithmetic","page":"SimplePadics","title":"Arithmetic","text":"","category":"section"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"The standard arithmetic operations (addition, subtraction, multiplication, division) may be performed with arguments that are both of the same p-adic type, or a mixture of a p-adic and an Integer or Rational. Some examples:","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"julia> a = Padic{7}(10)\n…13.0_{7}\n\njulia> a+1\n…14.0_{7}\n\njulia> 2a\n…26.0_{7}\n\njulia> a/a\n…1.0_{7}\n\njulia> inv(a)\n…462046205.0_{7}","category":"page"},{"location":"#Digits","page":"SimplePadics","title":"Digits","text":"","category":"section"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"When the prime p is greater than 7, we use letters to stand for digits beyond 9 (that is, a for ten, b for eleven, and so forth).","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"julia> a = Padic{17}(1000)\n…37e.0_{17}\n\njulia> 3 * 17^2 + 7 * 17 + 14\n1000","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"To get the digits as a list of integers, use digits(a). The first entry in the result is the most significant digit (rightmost).","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"julia> a = Padic{7}(124//49)\n…2.35_{7}\n\njulia> digits(a)\n3-element Vector{Int64}:\n 5\n 3\n 2","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"See valuation to determine the location of the radix point. ","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"julia> valuation(a)\n-2","category":"page"},{"location":"#Adjusting-Precision","page":"SimplePadics","title":"Adjusting Precision","text":"","category":"section"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"The precision of Padic numbers is globally controlled using the functions set_precision and get_precision.","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"Use set_precision(n::Int) to set the precision to n digits. Use set_precision() to  set the precision to the default value (10).","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"The function get_precision() returns the current setting.","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"Warning: Padic numbers created with different precisions cannot be compared for equality or combined in operations.","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"julia> a = Padic{5}(-1)\n…4444444444.0_{5}\n\njulia> set_precision(20)\n20\n\njulia> b = Padic{5}(-1)\n…44444444444444444444.0_{5}\n\njulia> a == b\nERROR: Incompatible padic rings in padic operation","category":"page"},{"location":"#Functions","page":"SimplePadics","title":"Functions","text":"","category":"section"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"The functions sqrt, exp, log, and valuation from Nemo are imported into this module. For example:","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"julia> a = Padic{5}(-1)\n…4444444444.0_{5}\n\njulia> sqrt(a)\n…3032431212.0_{5}\n\njulia> ans^2\n…4444444444.0_{5}\n\njulia> a = Padic{5}(500)\n…4000.0_{5}\n\njulia> valuation(a)\n3\n\njulia> 1/a\n…3333333.334_{5}\n\njulia> valuation(1/a)\n-3\n\njulia> abs(a)\n0.008\n\njulia> abs(1/a)\n125.0","category":"page"},{"location":"#Roots-of-Polynomials","page":"SimplePadics","title":"Roots of Polynomials","text":"","category":"section"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"Let F be a SimplePolynomial with integer or rational coefficients. The function p_root(F,p) returns a p-adic root of F (if one exists) or throws an error otherwise.","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"julia> using SimplePadics, SimplePolynomials\n\njulia> x = getx()\nx\n\njulia> F = x^2 + 1\n1 + x^2\n\njulia> t = p_root(F,5)\n…3032431212.0_{5}\n\njulia> t^2 + 1\n…0.0_{5}\n\njulia> sqrt(Padic{5}(-1))\n…3032431212.0_{5}","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"The function has_p_root(F,p) tests if a polynomial has a p-adic root.  Returns true if F has a root and false otherwise.","category":"page"},{"location":"#Compatability-with-LinearAlgebraX","page":"SimplePadics","title":"Compatability with LinearAlgebraX","text":"","category":"section"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"Matrices/vectors populated with Padic numbers can be used in the LinearAlgebraX module. Some examples here:","category":"page"},{"location":"","page":"SimplePadics","title":"SimplePadics","text":"julia> using LinearAlgebraX\n\njulia> A = rand(Int,5,5) .% 10  # create a random matrix with entries between -9 and 9.\n5×5 Matrix{Int64}:\n -9  -5  -4  -9  -8\n  0  -1   9  -3   8\n  2  -9   0   0  -4\n  0   7  -6  -5   8\n  0  -5   6  -2  -6\n\njulia> A = Padic{5}.(A)  # convert those values to 5-adic numbers\n5×5 Matrix{Padic{5}}:\n …4444444431.0_{5}  …44444444440.0_{5}  …4444444441.0_{5}   …4444444431.0_{5}  …4444444432.0_{5}\n          …0.0_{5}   …4444444444.0_{5}          …14.0_{5}   …4444444442.0_{5}          …13.0_{5}\n          …2.0_{5}   …4444444431.0_{5}           …0.0_{5}            …0.0_{5}  …4444444441.0_{5}\n          …0.0_{5}           …12.0_{5}  …4444444434.0_{5}  …44444444440.0_{5}          …13.0_{5}\n          …0.0_{5}  …44444444440.0_{5}          …11.0_{5}   …4444444443.0_{5}  …4444444434.0_{5}\n\njulia> detx(A)\n…4441202132.0_{5}\n\njulia> invx(A)\n5×5 Matrix{Padic{5}}:\n …4344224002.0_{5}  …4441024033.0_{5}  …1242400242.0_{5}  …2100330003.0_{5}   …211103034.0_{5}\n …4333241114.0_{5}  …2024323204.0_{5}  …1141013103.0_{5}  …3103232201.0_{5}  …4420230301.0_{5}\n …1011004214.0_{5}  …3224241133.0_{5}  …4324312303.0_{5}   …404043040.0_{5}  …2430224440.0_{5}\n …1031224011.0_{5}  …2022011034.0_{5}  …2244123102.0_{5}  …1312340431.0_{5}    …23100104.0_{5}\n …1324102422.0_{5}  …2324440300.0_{5}   …101223004.0_{5}    …21033133.0_{5}   …220320101.0_{5}\n\njulia> A * ans\n5×5 Matrix{Any}:\n …1.0_{5}  …0.0_{5}  …0.0_{5}  …0.0_{5}  …0.0_{5}\n …0.0_{5}  …1.0_{5}  …0.0_{5}  …0.0_{5}  …0.0_{5}\n …0.0_{5}  …0.0_{5}  …1.0_{5}  …0.0_{5}  …0.0_{5}\n …0.0_{5}  …0.0_{5}  …0.0_{5}  …1.0_{5}  …0.0_{5}\n …0.0_{5}  …0.0_{5}  …0.0_{5}  …0.0_{5}  …1.0_{5}\n\njulia> nullspacex(A[1:3,:])\n5×2 Matrix{Padic{5}}:\n …3414203434.0_{5}  …2234314433.0_{5}\n …3020203312.0_{5}   …241004443.0_{5}\n …3314221230.0_{5}  …2120313420.0_{5}\n          …1.0_{5}           …0.0_{5}\n          …0.0_{5}           …1.0_{5}","category":"page"}]
}
