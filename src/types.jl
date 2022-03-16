abstract type AbstractColor end
abstract type AbstractRGB <: AbstractColor end
abstract type AbstractHex <: AbstractColor end

# Plots.plot(color::AbstractColor; x=0, y=0, ms=100) = Plots.scatter(
#     [x], [y], c=Hex(color).string, ms=ms, xaxis=nothing, yaxis=nothing, xticks=[], yticks=[]
# )


# ---------------------------------------------------------------------------- #
#                                      RGB                                     #
# ---------------------------------------------------------------------------- #

"""
    RGB(r, g, b)

Represents a color in RGB space
"""
mutable struct RGB <: AbstractRGB
    r:: Int64
    g:: Int64
    b:: Int64
end

"""
Alternative constructor for `RGB` passing the color values
∈ [0, 1] range as floats.
"""
RGB(r::Float64, g::Float64, b::Float64) = RGB(toint(r * 255), toint(g * 255), toint(b * 255))

RGB(rgb::Union{Tuple, AbstractVector}) = RGB(rgb...)

# ---------------------------------- methods --------------------------------- #
Base.iterate(rgb::RGB) = (rgb.r, 1)
function Base.iterate(rgb::RGB, state)
    if state==1
        return (rgb.g, 2)
    elseif state==2
        return (rgb.b, 3)
    else
        return nothing
    end
end

Base.length(rgb::RGB) = 3

Base.Vector(rgb::RGB) = [rgb.r, rgb.g, rgb.b]

# ---------------------------------------------------------------------------- #
#                                      HEX                                     #
# ---------------------------------------------------------------------------- #
"""
    Hex("#ffffff")

Base type for hex style colors
"""
mutable struct Hex <: AbstractHex 
    code::String
    string::String
    function Hex(s::String)
        @assert s[1] == '#' "hex color should start with '#'"
        @assert length(s) == 7 "hex color string should have length == 7 (1+6)"
        return new(s[2:end], s)
    end
end



# ---------------------------------- methods --------------------------------- #
Base.iterate(hex::Hex) = (hex.code[1], 2)

function Base.iterate(hex::Hex, state)
    state < 7 ? (hex.code[state], state+1) : nothing
end

Base.length(hex::Hex) = 6

