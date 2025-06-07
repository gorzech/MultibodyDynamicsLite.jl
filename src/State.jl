export State, init_state, get_index

struct State
    time::Float64
    q::Vector{Float64}

    function State(;time = 0, q = zeros(7))
        new(time, q)
    end
end

function init_state(bodies::Vector{Body})
    pos_num = 3
    ove_num = 7
    temp_q = zeros(ove_num*length(bodies))
    for (i, body) in enumerate(bodies)
        for (j, r) in enumerate(body.r)
            temp_q[(i-1)*ove_num+j] = r
        end
        for(j, e) in enumerate(body.e)
            temp_q[(i-1)*ove_num+pos_num+j] = e
        end
    end
    return State(time = 0, q = temp_q)
end

function get_index(sys::MultibodySystem, body::Body)
    idx = findfirst(b -> b === body, sys.bodies)
    idx === nothing && error("Body not found in the system.")
    offset = (idx - 1) * 7
    return offset .+ (1:7)
end
