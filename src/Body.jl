export Body

struct Body
    r::Vector{Float64}   # position x y z
    e::Vector{Float64}   # unit quaternion e0 ex ey ez
end

function Body()
    Body([0.0, 0.0, 0.0] , [0.0, 0.0, 0.0, 0.0])
end