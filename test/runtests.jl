using MyterialColors
using Test

@testset "MyterialColors.jl" begin

    @test typeof(MyterialColors.salmon) == String
    @test typeof(MyterialColors.salmon_light) == String
    @test typeof(MyterialColors.salmon_lighter) == String
    @test typeof(MyterialColors.salmon_dark) == String
    @test typeof(MyterialColors.salmon_darker) == String

end
