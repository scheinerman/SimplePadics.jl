import Base: (+), (-), (*), (//), (/), (==), hash


(+)(a::Padic{P}, b::Padic{P}) where {P} = Padic(a.x + b.x)

(-)(a::Padic{P}) where {P} = Padic(-(a.x))

(-)(a::Padic{P}, b::Padic{P}) where {P} = a + (-b)

(*)(a::Padic{P}, b::Padic{P}) where {P} = Padic(a.x * b.x)

(/)(a::Padic{P}, b::Padic{P}) where {P} = Padic(a.x // b.x)

(==)(a::Padic{P}, b::Padic{Q}) where {P,Q} = (P == Q) && (a.x == b.x)

import Base: promote_rule

promote_rule(::Type{Padic{P}}, ::Type{T}) where {P,T<:Integer} = Padic{P}
promote_rule(::Type{Padic{P}}, ::Type{T}) where {P,T<:Rational} = Padic{P}


(//)(a::Padic, b::Number) = a / b
(//)(a::Number, b::Padic) = a / b
(//)(a::Padic, b::Padic) = a / b

hash(a::Padic{P}, h::UInt64) where {P} = hash(a.x, h)
hash(a::Padic{P}) where {P} = hash(a.x)
