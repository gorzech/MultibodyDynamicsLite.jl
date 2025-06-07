using MultibodyDynamicsLite
using Test

@testset "Testing drawing bodies" begin
    sys = MultibodySystem()
    b1 = Body([1.0, 2.0, 3.0], [2.0, 0.0, 0.0, 0.0])
    b2 = Body([4.3, -1.0, 2.0], [2.0, 0.0, 0.0, 0.0])
    b2 = Body([-2.0, 1.3, 1.0], [2.0, 0.0, 0.0, 0.0])
    push!(sys.bodies, b1)
    push!(sys.bodies, b2)
    state = init_state(sys.bodies)
    draw_frame(sys, state)
end