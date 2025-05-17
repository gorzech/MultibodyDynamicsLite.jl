export State

struct State
    time::Float64
    q::Vector{Float64}

    function State(;time = 0, q = zeros(7))
        new(time, q)
    end
end