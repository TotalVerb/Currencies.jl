"""
Currencies

This package provides the `Currency` singleton type, based on the ISO 4217 standard
together with five methods:

- `symbol`: The symbol of the currency.
- `currency`: The singleton type instance for a particular currency symbol
- `name`: The full name of the currency.
- `code`: The ISO 4217 code for the currency.
- `unit`: The minor unit, i.e. number of decimal places, for the currency.

See README.md for the full documentation

Copyright 2019-2020, Eric Forgy, Scott P. Jones and other contributors

Licensed under MIT License, see LICENSE.md
"""
module Currencies

export Currency

"""
This is a singleton type, intended to be used as a label for dispatch purposes
"""
struct Currency{S}
    function Currency{S}() where {S}
        haskey(_currency_data,S) && return _currencies[S] = new{S}()
        error("Currency $S is not defined.")
    end

    Currency(S) = _currencies[S]
end
const _currencies = Dict{Symbol,Currency}()

include(joinpath(@__DIR__, "..", "deps", "currency-data.jl"))

"""
Returns the symbol associated with this value
"""
function symbol end

"""
Returns an instance of the singleton type Currency{sym}
"""
function currency end

"""
Returns the minor unit associated with this value
"""
function unit end

"""
Returns the ISO 4217 code associated with this value
"""
function code end

"""
Returns the ISO 4217 name associated with this value
"""
function name end

currency(S::Symbol) = _currencies[S]
unit(S::Symbol) = _currency_data[S][1]
code(S::Symbol) = _currency_data[S][2]
name(S::Symbol) = _currency_data[S][3]

symbol(::Type{Currency{S}}) where {S} = S
currency(::Type{Currency{S}}) where {S} = currency(S)
unit(::Type{Currency{S}}) where {S} = unit(S)
code(::Type{Currency{S}}) where {S} = code(S)
name(::Type{Currency{S}}) where {S} = name(S)

symbol(::Currency{S}) where {S} = S
currency(c::Currency) = c
unit(::Currency{S}) where {S} = unit(S)
code(::Currency{S}) where {S} = code(S)
name(::Currency{S}) where {S} = name(S)

allsymbols()  = keys(_currency_data)
allpairs() = pairs(_currency_data)

end # module Currencies
