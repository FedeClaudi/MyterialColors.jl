using Myterial
using Test

@testset "Myterial.jl" begin

    @test typeof(Myterial.salmon) == String
    @test typeof(Myterial.salmon_light) == String
    @test typeof(Myterial.salmon_lighter) == String
    @test typeof(Myterial.salmon_dark) == String
    @test typeof(Myterial.salmon_darker) == String

end
