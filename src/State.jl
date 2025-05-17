export State

struct State
    time::Float64
    q::Vector{Float64}

    function State(;time = 0, q = [])
        new(time, q)
    end
end