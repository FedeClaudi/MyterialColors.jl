
# ---------------------------------------------------------------------------- #
#                                    PALETTE                                   #
# ---------------------------------------------------------------------------- #
"""
    Palette

Container for a list of colors, generally used with constructors
to create colors through interpolation of other colors
"""
struct Palette{T<:AbstractColor}
    colors::Vector{T}
end

Base.show(io::IO, palette::Palette) = print(io, "Palette{$(typeof(palette.colors[1]))} - ($(length(palette.colors)) colors)")

# this is used to show values in the REPL and when using IJulia
Base.show(io::IO, m::MIME"text/plain", palette::Palette) = print(io, palette)



# ------------------------------- constructors ------------------------------- #
function Palette(c1:: AbstractColor, c2::AbstractColor, N::Int; line_type::Symbol=:linear)
    c1 = Vector(RGB(c1))
    c2 = Vector(RGB(c2))

    if line_type == :linear
        colors = map((p)->RGB(Int.(round.(lerp(c1, c2, p)))), range(0, 1, length=N))
    end

    return Palette(colors)
end