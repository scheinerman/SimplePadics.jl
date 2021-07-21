using Test, SimplePadics


x = Padic{5}(-1)

@test x * x == 1
@test x == -1

y = sqrt(x)
@test y * y == -1

@test x + x == 2x
@test x + 1 == 0
@test x - 1 == -Padic{5}(2)
@test valuation(x) == 0
@test valuation(x // 5) == -1
@test valuation(5x) == 1
@test characteristic(x) == 5

y = exp(5x)
@test log(y) == -5

@test Padic{5}(2 // 3) * 3 == 2

s = string(x)
@test s[1] == '…'
@test s[end-5] == '4'

a = Padic{17}(1000)
d = digits(a)
@test d[1] + 17 * d[2] + 17^2 * d[3] == 1000

set_precision(20)
@test get_precision() == 20
