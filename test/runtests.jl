using MyterialColors
using Test

# ------------------------------- utility code ------------------------------- #

"""
Lenient comparison operator for `struct`, both mutable and immutable (type with \\eqsim).

From: https://discourse.julialang.org/t/what-general-purpose-commands-do-you-usually-end-up-adding-to-your-projects/4889/2
"""
@generated function ≂(x, y)
    if !isempty(fieldnames(x)) && x == y
        mapreduce(n -> :(x.$n == y.$n), (a,b)->:($a && $b), fieldnames(x))
    else
        :(x == y)
    end
end


"""
    Checks if two palettes have the same colors
"""
function palette_equal(p1::Palette, p2::Palette)
    same_colors = map((x) -> x[1] ≂ x[2], zip(p1.colors, p2.colors))
    return sum(same_colors) == length(same_colors)
end


# ---------------------------------------------------------------------------- #
#                                 BASE IMPORTS                                 #
# ---------------------------------------------------------------------------- #
@testset "MyterialColors.jl" begin
    # test we can import color codes
    @test typeof(MyterialColors.salmon) == String

end


# ---------------------------------------------------------------------------- #
#                                  color types                                 #
# ---------------------------------------------------------------------------- #
@testset "Colors Types" begin
    # ------------------------------- constructors ------------------------------- #
    rgb1 = RGB(255, 255, 255)
    rgb2 = RGB(1.0, 1.0, 1.0)
    rgb3 = RGB((255, 255, 255))

    @test rgb1  ≂ rgb2
    @test rgb2  ≂ rgb3


    h = Hex("#ffffff")
    @test h.code == "ffffff"
    @test h.string == "#ffffff"

    @test_throws AssertionError Hex("ff")
    @test_throws AssertionError Hex("#ff")


    # -------------------------------- coinversion ------------------------------- #
    rgb1_as_hex = rgb2hex(rgb1)
    rgb1_v2_as_hex = rgb2hex(255, 255, 255)

    @test rgb1_as_hex ≂ h
    @test rgb1_as_hex ≂ rgb1_v2_as_hex

    h_as_rgb = hex2rgb(h)

    @test h_as_rgb ≂ rgb1

    h_as_rgb_as_h = rgb2hex(h_as_rgb)
    @test  h_as_rgb_as_h.code == h.code
    @test  h_as_rgb_as_h ≂ h

end

# ---------------------------------------------------------------------------- #
#                                   palettte                                   #
# ---------------------------------------------------------------------------- #
# @testset "Palette" begin
#     # create a palette from two colors
#     rgb1 = RGB(0, 0, 0)
#     rgb2 = RGB(255, 255, 255)
#     palette = Palette(rgb1, rgb2, 100)

#     @test length(palette.colors) == 100
#     @test palette.colors[1] ≂ rgb1
#     @test palette.colors[end] ≂ rgb2

#     # check that palette equals is working
#     @test palette_equal(palette, palette)
# end