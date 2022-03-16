# using Plots

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

# function Plots.plot(p::Palette)
#     n = length(p.colors)
#     x = (1:n) .* 10

#     scatter(
#         x,
#         zeros(n),
#         c=[Hex(c).string for c in p.colors],
#         xaxis=nothing, 
#         yaxis=nothing, 
#         ms=4,
#         xticks=[],
#         yticks=[],
#         xlim=[0, x[end]],
#         ylim=[-.05, .05],
#         label=nothing
#     )
# end


# ------------------------------- constructors ------------------------------- #
function Palette(c1:: AbstractColor, c2::AbstractColor; N::Int=100, line_type::Symbol=:linear)
    _type = typeof(c1)

    c1 = Vector(RGB(c1))
    c2 = Vector(RGB(c2))

    if line_type == :linear
        colors = map((p)->RGB(toint(lerp(c1, c2, p))), range(0, 1, length=N))
    end

    return Palette([_type(c) for c in colors])
end

Palette(c1::AbstractString, c2::AbstractString; kwargs...) = Palette(Hex(c1), Hex(c2); kwargs...)

function Palette(colors...; N::Int=100, line_type::Symbol=:linear)
    n_colors = length(colors) - 1

    if N % n_colors != 0
        error("The number of colors intervals $(n_colors) is not a divisor of the palette length $N")
    end

    N_per_color = Int(N/n_colors)
    sum([Palette(colors[i], colors[i+1]; N=N_per_color) for i in 1:n_colors])
end

# ---------------------------------- methods --------------------------------- #
Base.:+(p1::Palette, p2::Palette) = Palette(vcat(p1.colors, p2.colors))