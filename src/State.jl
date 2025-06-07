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

function Rq(q_local::Vector{Float64})
    @assert length(q_local) == 7 "Expected q to have length 7, got $(length(q))"
    e0, ex, ey, ez = q_local[4:7]  
    [
        2(e0^2 + ex^2) - 1    2(ex * ey - e0 * ez)    2(ex * ez + e0 * ey);
        2(ex * ey + e0 * ez)  2(e0^2 + ey^2) - 1      2(ey * ez - e0 * ex);
        2(ex * ez - e0 * ey)  2(ey * ez + e0 * ex)    2(e0^2 + ez^2) - 1
    ]
end

function G(e)
    e0,e1,e2,e3 = e
    [
        -e1  e0  e3 -e2;
		-e2 -e3  e0  e1;
		-e3  e2 -e1  e0
    ]
end

function Gwq_local(q_local::Vector{Float64})
    @assert length(q_local) == 7 "Expected q to have length 7, got $(length(q_local))"
    Gwq = zeros(6, 7)
    Gwq[1:3, 1:3] = I(3)
    Gwq[4:6, 4:7] =  2 * G(q_local[4:7])
    return Gwq
end

function Gwq_global(state::State)
    n = div(length(state.q), 7)
    Gwq = zeros(6n, 7n)
    for b in 1:n
        i = 1 + (b - 1) * 6
        j = 1 + (b - 1) * 7
        Gwq[i:(i+5), j:(j+6)] = Gwq_local(state.q[j:(j+6)])
    end
    return Gwq
end

function Gqw_local(q_local::Vector{Float64})
    @assert length(q_local) == 7 "Expected q to have length 7, got $(length(q_local))"
    Gqw = zeros(7, 6)
    Gqw[1:3, 1:3] = I(3)
    Gqw[4:7, 4:6] =  0.5 * G(q_local[4:7])'
    return Gqw
end

function Gqw_global(state::State)
    n = div(length(state.q), 7)
    Gqw = zeros(7n, 6n)
    for b in 1:n
        i = 1 + (b - 1) * 6
        j = 1 + (b - 1) * 7
        Gqw[j:(j+6), i:(i+5)] = Gqw_local(state.q[j:(j+6)])
    end
    return Gqw
end

