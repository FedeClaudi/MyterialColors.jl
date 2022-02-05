using MyterialColors
using Test

@testset "MyterialColors.jl" begin
    # test we can import color codes
    @test typeof(MyterialColors.salmon) == String

end


@testset "Colors Types" begin
    # ---------------------------------------------------------------------------- #
    #                                 constructors                                 #
    # ---------------------------------------------------------------------------- #
    rgb1 = RGB(255, 255, 255)
    rgb2 = RGB(1.0, 1.0, 1.0)
    rgb3 = RGB((255, 255, 255))

    @test rgb1.r==rgb2.r
    @test rgb2.r==rgb3.r


    h = Hex("#ffffff")
    @test h.code == "ffffff"
    @test h.string == "#ffffff"

    @test_throws AssertionError Hex("ff")
    @test_throws AssertionError Hex("#ff")


    # ---------------------------------------------------------------------------- #
    #                                  conversion                                  #
    # ---------------------------------------------------------------------------- #
    rgb1_as_hex = rgb2hex(rgb1)
    rgb1_v2_as_hex = rgb2hex(255, 255, 255)

    @test rgb1_as_hex.code == h.code
    @test rgb1_as_hex.code == rgb1_v2_as_hex.code

    h_as_rgb = hex2rgb(h)

    @test h_as_rgb.r == rgb1.r

    h_as_rgb_as_h = rgb2hex(h_as_rgb)
    @test  h_as_rgb_as_h.code == h.code
end