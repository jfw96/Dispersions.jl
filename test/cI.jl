using Base.Iterators
include("helper_functions.jl")

@testset "dispersion" begin
    r8 = gen_kGrid("bcc-1.2",2)
    r64 = gen_kGrid("bcc-1.1",4)
    r1000 = gen_kGrid("bcc-1.3",6)
    indTest = reduceKArr(r8, reshape([(1, 1, 1) (2, 1, 1) (1, 2, 1) (2, 2, 1) (1, 1, 2) (2, 1, 2) (1, 2, 2) (2, 2, 2)], (2,2,2)))
    gridTest = reduceKArr(r8, reshape([(0, 0, 0) (π, 0, π) (π, π, 0) (2π, π, π) (0, π, π) (π, π, 2π) (π, 2π, π) (2π, 2π, 2π)], (2,2,2)))
    
    @test Nk(r8) == 2^3
    @test Nk(r64) == 4^3
    @test all(dispersion(r8) .≈ r8.ϵkGrid)
    @test all(isapprox.(flatten(gridPoints(r8)), flatten(gridTest)))
    @test_throws ArgumentError expandKArr(r64, [1,2,3,4])
    @test all(gridshape(r8) .== (2,2,2))
    @test isapprox(kintegrate(r1000, r1000.ϵkGrid), 0.0, atol=num_eps)
    @test isapprox(kintegrate(r1000, r1000.ϵkGrid .* r1000.ϵkGrid), 8 * r1000.t^2, atol=num_eps)
    #rr = abs.(conv(r64, convert.(ComplexF64,r64.ϵkGrid), convert.(ComplexF64,r64.ϵkGrid)) .- ( - r64.t .* r64.ϵkGrid))
    #@test maximum(rr) < 1e-10
end
