import Base: (+), (-), (*), (//), (/), (==), hash

_QZ = Union{Integer,Rational}

(+)(a::Padic{P}, b::Padic{P}) where {P} = Padic(a.x + b.x)
(+)(a::Padic{P}, b::_QZ) where {P} = a + Padic{P}(b)
(+)(a::_QZ, b::Padic{P}) where {P} = b + a

(-)(a::Padic{P}) where {P} = Padic(-(a.x))

(-)(a::Padic{P}, b::Padic{P}) where {P} = a + (-b)
(-)(a::Padic{P}, b::_QZ) where {P} = a - Padic{P}(b)
(-)(a::_QZ, b::Padic{P}) where {P} = a + (-b)

(*)(a::Padic{P}, b::Padic{P}) where {P} = Padic(a.x * b.x)
(*)(a::Padic{P}, b::_QZ) where {P} = a * Padic{P}(b)
(*)(a::_QZ, b::Padic{P}) where {P} = b * a

(//)(a::Padic{P}, b::Padic{P}) where {P} = Padic(a.x // b.x)
(//)(a::Padic{P}, b::_QZ) where {P} = a // Padic{P}(b)
(//)(a::_QZ, b::Padic{P}) where {P} = Padic{P}(a) // b

(/)(a::Padic{P}, b::Padic{P}) where {P} = Padic(a.x // b.x)
(/)(a::Padic{P}, b::_QZ) where {P} = a // Padic{P}(b)
(/)(a::_QZ, b::Padic{P}) where {P} = Padic{P}(a) // b

(==)(a::Padic{P}, b::Padic{P}) where {P} = a.x == b.x
(==)(a::Padic{P}, b::_QZ) where {P} = a == Padic{P}(b)
(==)(a::_QZ, b::Padic{P}) where {P} = b == a

hash(a::Padic{P}, h::UInt64) where {P} = hash(a.x, h)
hash(a::Padic{P}) where {P} = hash(a.x)
