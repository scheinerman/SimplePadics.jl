using Test, SimplePadics, SimplePolynomials


x = Padic{5}(-1)

@test x * x == 1
@test x == -1

y = sqrt(x)
@test y * y == -1

@test x + x == 2x
@test x + 1 == 0
@test x - 1 == -Padic{5}(2)
@test valuation(x) == 0
@test valuation(x / 5) == -1
@test valuation(5x) == 1
@test base(x) == 5
@test x // 5 == x / 5
@test x / x == 1
@test x // x == Padic{5}(1)

y = exp(5x)
@test log(y) == -5

@test Padic{5}(2 // 3) * 3 == 2

s = string(x)
@test s[1] == '…'
@test s[end-5:end] == ".0_{5}"

a = Padic{17}(1000)
d = digits(a)
@test d[1] + 17 * d[2] + 17^2 * d[3] == 1000

set_precision(20)
@test get_precision() == 20

a = Padic{5}(100)
@test abs(1 / a) == 25
@test abs(a) == abs(-a)
@test abs(0 * a) == 0


x = getx()
F = x^2 + 1
@test has_p_root(F, 5)
t = p_root(F, 5)
@test F(t) == 0
